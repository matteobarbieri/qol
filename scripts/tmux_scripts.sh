#!/bin/zsh

setup_tmux_session()
{
	PROJECT_NAME=$1

	STARTING_FOLDER=~/projects/$PROJECT_NAME

	# If the conda virtual environment exists
	CONDA_ENV_EXISTS=$(conda env list | cut -f1 -d \ | grep "$PROJECT_NAME" | wc -l)

	# Start a new session, main window named django
	tmux new-session -d -s $PROJECT_NAME -n repo -c $STARTING_FOLDER
	if [ "$CONDA_ENV_EXISTS" -gt 0 ]; then
		tmux send-keys '. activate '"$PROJECT_NAME" 'C-m'
	fi

	# Add a window with vim (don't open it)
	tmux new-window -n 'vim' -t $PROJECT_NAME -c $STARTING_FOLDER
	if [ "$CONDA_ENV_EXISTS" -gt 0 ]; then
		tmux send-keys '. activate '"$PROJECT_NAME" 'C-m'
	fi

	tmux new-window -n 'monitor' -t $PROJECT_NAME htop
	tmux split-window 'nvidia-smi -l 1'

	# Select the repo window
	tmux select-window -t repo
}
