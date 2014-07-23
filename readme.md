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

## .dockitrc

You can set default arguments for dockit runs and starts which apply when starting containers.

Example:

    default_args: -v /Development/bundler_volume/:/var/bundler/ --link mysql:mysql -p 80:3000
    dev_mount: /var/www/

Above the default args are supplied to docker run commands, and the dev mount will mount the
root directory of your application to the given mount point when dockit run is used (not dockit start)

### default_args

There may be certain specific defaults which you wish to give the docker runs when starting the
containers, simply add them to the default_args list and they will be automatically added:

    default_args: -p 80:3000 -v /Some/Mount:/data

### dev_mount

Whilst running application and commands in development environments the source tree can be changed,
for example build task outputs or in rails a running server will reload on source changes.

For this reason the dev host source files can be mounted into the running container, rather than
using the source which was built into the image.  This means changes will persist beyond the life
of the container, and can be modified whilst running.

    dev_mount: /var/www

### host_nat

Often development code bases expect items to be running on localhost.  To support this you can NAT
the expected service port to the docker host, that way a container which bound to the host can be
accessed as if they were localhost on the container.

Example.

(mysql) - container which is exposing 3306 onto the docker container
(webapp) - application which expects mysql on localhost

in webapp's .dockitrc

    host_nat: 3306

this will use socat to route traffic send to localhost:3306 on the container to the host machine.
Notice you will need to ensure that socat is installed in the image for the container.

### env

Specify environment variables for when running.., for example

    env: MYSQL_PASSWORD=mydevpassword

