#!/usr/bin/env bash
# backup-session.sh
# Source this at the start of each sitting: source ~/backup-session.sh
#
# Required env var (set before sourcing):
#   export BACKUP_PREFIX="backups/scaleway/vol1"
#
# Then use:
#   bk <path>    back up a folder
#   del <path>   delete a folder
#   bk_status    show progress log

# ── Config ───────────────────────────────────────────────────────────────────
BACKUP_BUCKET="s3://aim-scaleway-volumes-backup"
BACKUP_LOG="$HOME/backup-progress.tsv"
BACKUP_DRY_RUN=false
# ─────────────────────────────────────────────────────────────────────────────

if [[ -z "${BACKUP_PREFIX}" ]]; then
    echo "[ERROR] BACKUP_PREFIX is not set. Export it before sourcing:"
    echo "  export BACKUP_PREFIX=backups/scaleway/vol1"
    return 1 2>/dev/null || exit 1
fi

if [[ ! -f "$BACKUP_LOG" ]]; then
    printf "timestamp\tpath\taction\tstatus\n" > "$BACKUP_LOG"
fi

_bk_is_done() {
    local path="$1" action="${2:-}" st="${3:-}"
    /usr/bin/awk -F'\t' -v p="$path" -v a="$action" -v s="$st" \
        'NR > 1 && $2 == p && (a == "" || $3 == a) && (s == "" || $4 == s) { found = 1; exit } END { exit !found }' "$BACKUP_LOG"
}

_bk_log() {
    printf "%s\t%s\t%s\t%s\n" "$(/usr/bin/date -Iseconds)" "$1" "$2" "$3" >> "$BACKUP_LOG"
}

_bk_confirm() {
    local reply
    printf "%s [y/N] " "$1"
    read -r reply
    [[ "$reply" =~ ^[Yy]$ ]]
}

# bk <local-path>
# Syncs the folder to ${BACKUP_BUCKET}/${BACKUP_PREFIX}/<folder-name>/
# Shows destination and asks for confirmation before transferring.
# Skips silently if already logged.
bk() {
    local src="${1%/}"
    local dest="${BACKUP_BUCKET}/${BACKUP_PREFIX}/${src##*/}"

    if _bk_is_done "$dest" "backup" "ok"; then
        echo "[skip]   $src  (already in log)"
        return 0
    fi

    echo ""
    echo "  Source : $src"
    echo "  Dest   : $dest"
    echo ""

    if ! _bk_confirm "Back up to this location?"; then
        echo "Aborted."
        return 1
    fi

    if [[ "$BACKUP_DRY_RUN" == true ]]; then
        echo "[backup] (dry run — not executing)"
        return 0
    fi

    echo ""

    if [[ -d "$src" ]]; then
        aws s3 sync "$src" "$dest" --endpoint-url https://s3.fr-par.scw.cloud
    else
        # Scaleway caps multipart uploads at 1000 parts. The AWS CLI default
        # chunk size is 8MB, which overflows that limit on large files. Size
        # the chunk so the part count stays under it (target ~900 parts),
        # min 8MB. multipart_chunksize has no CLI flag, so pass it via config.
        local bytes chunk_mb
        bytes=$(/usr/bin/stat -c %s "$src")
        chunk_mb=$(( (bytes + 900 * 1048576 - 1) / (900 * 1048576) ))
        (( chunk_mb < 8 )) && chunk_mb=8
        aws configure set default.s3.multipart_chunksize "${chunk_mb}MB"
        aws s3 cp "$src" "$dest" --endpoint-url https://s3.fr-par.scw.cloud
    fi

    local exit_code=$?
    if (( exit_code == 0 )); then
        _bk_log "$dest" "backup" "ok"
        echo ""
        echo "[done]   Files available at: $dest"
    else
        _bk_log "$dest" "backup" "FAILED(exit=$exit_code)"
        echo "[ERROR]  Transfer failed (exit $exit_code) — not logged, will be retried next time."
        return 1
    fi
}

# del <local-path>
# Asks for confirmation, then deletes the folder.
# Logs BEFORE deleting so a partial deletion is not retried as a backup.
# Skips silently if already logged.
del() {
    local path="${1%/}"

    if _bk_is_done "$path" "delete"; then
        echo "[skip]   $path  (already deleted)"
        return 0
    fi

    echo ""
    if ! _bk_confirm "Delete $path?"; then
        echo "Aborted."
        return 1
    fi

    if [[ "$BACKUP_DRY_RUN" == true ]]; then
        echo "[delete] (dry run — not executing)"
        return 0
    fi

    _bk_log "$path" "delete" "ok"
    /usr/bin/rm -rf "$path"
    echo "[done]   Deleted: $path"
}

# bk_status
# Prints the current progress log, formatted as a table.
bk_status() {
    echo "Prefix : ${BACKUP_PREFIX}"
    echo "Bucket : ${BACKUP_BUCKET}/${BACKUP_PREFIX}"
    echo "Log    : $BACKUP_LOG"
    echo "Dry run: $BACKUP_DRY_RUN"
    echo ""
    column -t -s $'\t' "$BACKUP_LOG"
}

echo ""
echo "Backup session ready."
echo "  Prefix : ${BACKUP_PREFIX}"
echo "  Bucket : ${BACKUP_BUCKET}/${BACKUP_PREFIX}"
echo "  Log    : $BACKUP_LOG"
echo "  Dry run: $BACKUP_DRY_RUN"
echo ""
echo "  bk <path>    back up a folder"
echo "  del <path>   delete a folder"
echo "  bk_status    show progress log"
echo ""
