# Always set the path explicitly for full control, and in a way which does not interfere with Python virtualenvs.
if status --is-login
    set -gx PATH /home/tcorbettclark/.pyenv/shims /home/tcorbettclark/.pyenv/bin /home/tcorbettclark/.poetry/bin /home/tcorbettclark/node_modules/.bin /home/tcorbettclark/.local/bin /usr/local/sbin /usr/sbin /sbin /usr/local/bin /usr/bin /bin
end

# Setup autocompletions for pyenv.
if status --is-interactive
    set -gx PYENV_SHELL fish
    source '/home/tcorbettclark/.pyenv/libexec/../completions/pyenv.fish'
    command pyenv rehash 2>/dev/null
end

# Certain SSH variables are (correctly) exported to subprocesses e.g. to forward
# the ssh agent. But when that subprocess is a fish shell, we want them to remain Universal
# so that when they change, they change everywhere (including tmux and Python virtualenvs).
# A new ssh login may validly change them, and when this happens the fish shell will set the new values
# in Global scope.
# Both of these use-cases are handled by always running following on every new fish shell.
# It "uplifts" the nearest scope values into Universal scope only.
uplift-variable-to-universal SSH_AUTH_SOCK SSH_CLIENT SSH_CONNECTION