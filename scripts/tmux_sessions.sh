#!/bin/bash
SESSION=$1

# Atom
tmux new-session -d -s $SESSION
tmux rename-window 'Atom'
tmux send-keys "cd ~/projects/$SESSION" C-m

# # Setup a window for tailing log files
# tmux new-window -t $SESSION:1 -n 'Logs'
# tmux split-window -h
# tmux select-pane -t 0
# tmux send-keys "tail -f /vagrant/maximus.log" C-m
# tmux select-pane -t 1
# tmux send-keys "tail -f /vagrant/maximus-worker.log" C-m
# tmux split-window -v
# tmux resize-pane -D 20
# tmux send-keys "tail -f /vagrant/maximus-mojo.log" C-m
# # Setup a CoffeeScript compiler/watchdog pane
# tmux select-pane -t 0
# tmux split-window -v
# tmux resize-pane -D 20
# tmux send-keys "coffee -o /vagrant/root/static/js/ -cw /vagrant/root/coffee/" C-m

# # Setup a MySQL window
# tmux new-window -t $SESSION:2 -n 'MySQL' 'mysql -uroot'
#
# # Set default window
# tmux select-window -t $SESSION:1
#
# Attach to session
tmux a -t $SESSION
