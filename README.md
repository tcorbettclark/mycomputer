How to install a Linux computer the way I like it
=================================================

Introduction
------------

The following explains how to install a machine just the way I like it. The
same instructions work for a remote machine e.g. on Digital Ocean, as a local
Linux laptop. Some configuration files (e.g. ssh keys) are obviously private so
I don't share them here.

After installing the base OS the whole process takes about an hour.


Disk partitions
---------------

I install from scratch on every OS release, alternating between two 16G+
partitions, and using a third partition `/localbackup` to transfer data between
the two (and for backups). I don't bother to keep a separate `/home` partition
because of ever-changing user configuration files.


Base OS
-------

Generally Ubuntu or Ubuntu derivative like Mint.

Update with:

    sudo apt-get update
    sudo apt-get upgrade

And reboot.


Create my user
--------------

    sudo adduser --disabled-password tcorbettclark


sudo
----

Add tcorbettclark to the sudo Linux group by editing `/etc/group`

Remove need for passwords for sudo group using `visudo` to set:

    %sudo ALL=(ALL) NOPASSWD: ALL

Once confirmed I can login remotely as `tcorbettclark`, edit
`/etc/ssh/sshd_config` to disable password login and disable root login.

Restart ssh daemon:

    sudo systemctl restart ssh


NTP
---

    sudo apt-get install ntp

And check after a while that `ntpq` reports successful time syncs.


Fish shell
----------

    sudo add-apt-repository ppa:fish-shell/release-2
    sudo apt-get update
    sudo apt-get install fish
    chsh -s /usr/bin/fish
    mkdir -p ~/.config/fish/functions
    cp fish/functions/* ~/.config/fish/functions/
    cp fish/config.fish ~/.config/fish/


SSH
---

Create the `.ssh` folder with

    su - tcorbettclark
    mkdir -p .ssh/sockets

Add DSA and RSA public and private keys to `~/.ssh`, and create `~/.ssh/authorized_keys` file.

Configure preferences (e.g. SSH fowarding) with

    cp ssh/config ~/.ssh/

Reduce permissions for `~/.ssh` files with

    chmod 600 .ssh/*

Note that all private keys should be encrypted using e.g.:

    openssl pkcs8 -topk8 -v2 des3 -in ~/.ssh/id_rsa.old -out ~/.ssh/id_rsa


Setup ssh-agent
---------------

See fish function

    start-ssh-agent

Add keys to the agent with

    ssh-add


Install Mosh
------------

Install the mosh-server

    sudo apt-get install mosh

If needed, install better fonts e.g. in Secure Shell Chrome plugin, set the
user-css to http://rawgit.com/wernight/powerline-web-fonts/master/SourceCodePro.css

Then set the font-family to "Source Code Pro for Powerline".

Setup Tmux
----------

Install the latest from source with:

    bash tmux/install.sh

Create `~/.tmux.conf`:

    cp tmux/tmux.conf ~/.tmux.conf


Python, pip, pew, etc
---------------------

Install pyenv (https://github.com/pyenv/pyenv) then use pew to manage virtualenvs.


Nodejs
------

Get up to date version of node:

    curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
    sudo apt-get install -y nodejs


Git
---

    sudo apt-get install git
    git config --global user.name "Timothy Corbett-Clark"
    git config --global user.email "timothy@corbettclark.com"
    git config --global credential.helper cache
    git config --global core.editor "subl -n -w"
    git config --global color.ui true


VS Code
-------

Follow their instructions to install.

Example remote settings

    {
        "python.pythonPath": "/home/tcorbettclark/.pyenv/versions/3.6.7/bin/python",
        "python.formatting.provider": "black",
        "python.formatting.blackPath": "/home/tcorbettclark/.pyenv/shims/black",
        "python.linting.pylintEnabled": false,
        "python.linting.flake8Enabled": true,
        "python.linting.enabled": true,
        "python.linting.flake8Args": [
            "--ignore",
            "W503",
            "--max-line-length",
            "88"
        ]
    }

Example local settings

    {
        "window.zoomLevel": -1,
        "remote.SSH.showLoginTerminal": false,
        "git.confirmSync": false,
        "extensions.ignoreRecommendations": false,
        "explorer.confirmDragAndDrop": false,
        "[python]": {
            "editor.defaultFormatter": "ms-python.python"
        },
        "editor.formatOnSave": true,
        "editor.trimAutoWhitespace": true,
        "files.trimTrailingWhitespace": true
    }

Dropbox for file syncing, sharing, and backups
----------------------------------------------

Install [Dropbox](http://www.dropbox.com) by following their instructions.

To speed up synchronising, seed the Dropbox directory from a local copy.


Encfs for encrypting files e.g. on Dropbox
------------------------------------------

I use [Encfs](https://vgough.github.io/encfs/) to encrypt certain files stored
on Dropbox.

Mount my encrypted folder:

    mkdir -p /home/tcorbettclark/Private
    encfs /home/tcorbettclark/Dropbox/Private /home/tcorbettclark/Private

Note that absolute paths must be used.

When needed, nmount with:

    fusermount -u /home/tcorbettclark/Dropbox/Private


Xterm
-----

Allow meta-forward-word to work, and set fonts and colours:

 * Edit.Keyboard Shortcuts - disable all menu access
 * Set font to Ubuntu Mono size 11


Other
-----

    sudo apt-get install htop jq
