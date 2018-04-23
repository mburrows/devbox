function tmux
    # If we are invoked with arguments then just pass them through
    if count $argv > /dev/null
        command tmux -2 $argv
        return
    end

    # Check for .tmux file (poor mans Tmuxinator)
    if test -x .tmux
        set -l digest (openssl sha -sha512 .tmux)
        if not grep -q "$digest" ~/.tmux.digests ^ /dev/null
            # we have never seen this SHA before, it's not trusted, so check with user
            cat .tmux
            echo 'Trust and run this .tmux file? (t = trust, otherwise = skip) '
            read -n1 -l reply 
            if test $reply = "t"
                echo "$digest" >> ~/.tmux.digests
                ./.tmux
                return
            end
        else
            # trusted, just invoke the commands
            ./.tmux
            return
        end
    end

    # Attach to existing session, or connect to an existing one, based on the current directory
    set -l session_name (basename (pwd))
    command tmux -2 new -A -s $session_name
end
