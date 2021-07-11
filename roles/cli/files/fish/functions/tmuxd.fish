function tmuxd
    tmux -f ~/.config/tmux/tmux.conf attach -t dev || tmux -f ~/.config/tmux/tmux.conf new -s dev 
end
