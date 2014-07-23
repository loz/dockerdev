# Remote/Vagrant Docker Development Environment

A development environment for working using docker containers to keep dependencies clean.

## Setup

The base environment is assume to be an ubuntu based docker running server.

First, ensure that you are all set with ssh key forwarding so your remote server has the right
to commincate with any repositories and servers you have access to.  See the SSH Agent Forwarding
section below.

Next, clone the project on your remote server:

    git clone git@github.com:loz/dockerdev.git

Now bootstrap the environment:

    cd dockerdev
    ./bootstrap.sh

## SSH Agent Forwarding
It is recommended to ssh agent forward to the docker dev environment.

Github has a good guide on this: https://developer.github.com/guides/using-ssh-agent-forwarding/

simply put, on your dev box:

    ssh-agent
    ssh-add /path/to/your/key

add to `~/.ssh/config`

    Host your.docker.host.com
       ForwardAgent yes

this should have your docker host working with your local ssh key

## .dexrc

You can set default arguments for dex runs and starts which apply when starting containers.

Example:

    default_args: -v /Development/bundler_volume/:/var/bundler/ --link mysql:mysql -p 80:3000
    dev_mount: /var/www/

Above the default args are supplied to docker run commands, and the dev mount will mount the
root directory of your application to the given mount point when dex run is used (not dex start)
