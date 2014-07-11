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
