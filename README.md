# Virtual Machine for Python development #


## Installation ##

1. Ensure [VirtualBox](https://www.virtualbox.org) is installed on your host system.
2. Ensure [Vagrant](https://www.vagrantup.com) is installed on your host system.
3. Open a terminal and run `vagrant plugin install vagrant-disksize`
4. Run `vagrant up` in this folder. Vagrant will download the pre-configured box and provision
    the machine by installing packages as defined in `provisioning/playbook.yml`. On first run,
    this step will take a while.
5. Run `vagrant ssh` to ssh into the virtual machine.


## Configuration ##

You'll find a file called `user_variables.yml.template` in `provisioning/ansible/`.
Copy it to `user_variables.yml` in the same folder and make the appropriate changes.
Note that `user_variables.yml` is ignored by git.