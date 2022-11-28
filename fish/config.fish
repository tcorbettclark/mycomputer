if status --is-login
    # Always set the path explicitly for full control, and in a way which does not interfere with Python virtualenvs.

    # pyenv
    set -gx PYENV_ROOT "$HOME/.pyenv"
    fish_add_path -P $PYENV_ROOT/shims $PYENV_ROOT/bin

    # pipx
    fish_add_path -P "$HOME/.local/bin"
     
    # brew installed curl
    fish_add_path -P /usr/local/opt/curl/bin
    
    # standard unix paths
    fish_add_path -P /usr/local/sbin /usr/sbin /sbin /usr/local/bin /usr/bin /bin
end

# Setup pyenv, and have pyenv-virtualenv automatically activate
# virtualenvs on entering directory with .python-version
if status --is-interactive
    if type -q pyenv
        pyenv init - | source
    end

    if type -q pyenv
        pyenv virtualenv-init - | source
    end
end

# Certain SSH variables are (correctly) exported to subprocesses e.g. to forward
# the ssh agent. But when that subprocess is a fish shell, we want them to remain Universal
# so that when they change, they change everywhere (including tmux and Python virtualenvs).
# A new ssh login may validly change them, and when this happens the fish shell will set the new values
# in global scope.
# Both of these use-cases are handled by always running the following on every new fish shell.
# It "uplifts" the nearest scope values into Universal scope only.
if status --is-interactive
    uplift-variable-to-universal SSH_AUTH_SOCK SSH_CLIENT SSH_CONNECTION
end

# Make starfish manage the prompt always.
starship init fish | source
