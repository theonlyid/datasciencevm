require 'yaml'
require 'SecureRandom'

user_variables = YAML::load(File.read("#{File.dirname(__FILE__)}/provisioning/ansible/user_variables.yml"))

# if user_variables['ssh_keys']['attempt_to_copy_host_keys']
#   ssh_private_src = user_variables['ssh_keys']['ssh_host_key_location']
#   ssh_public_src = "#{user_variables['ssh_keys']['ssh_host_key_location']}.pub"
#   ssh_private_dest = "#{user_variables['ssh_keys']['ssh_key_for_bitbucket']}"
#   ssh_public_dest = "#{user_variables['ssh_keys']['ssh_key_for_bitbucket']}.pub"
  
#   unless File.file?(ssh_private_src)
#     print "SSH key not found at #{ssh_private_src}. Check source of ssh keys in user_variables.yml\n"
#     exit(-2709)
#   end
#   unless File.file?(ssh_public_src)
#     print "SSH key not found at #{ssh_public_src}. Check source of ssh keys in user_variables.yml\n"
#     exit(-2709)
#   end
# end

VAGRANT_HOSTNAME = '.vagrant/vagrant_hostname'
if File.exist? VAGRANT_HOSTNAME
  hostname = IO.read( VAGRANT_HOSTNAME ).strip
else
  hostname = "PyDev-#{SecureRandom.hex(2)}"
  IO.write( VAGRANT_HOSTNAME, hostname )
end


Vagrant.configure("2") do |config|  
  # Define the box that will be used as a base for the development VM
  config.vm.box = "ubuntu/bionic64"
  config.vm.box_version = "20180809.0.0"
  config.disksize.size = "10GB"

  config.vm.provider "virtualbox" do |vb|
    vb.name = "#{hostname}"
    vb.customize ["modifyvm", :id, "--audioout", "on"]
    vb.memory = 6000
    vb.cpus = 7
    vb.customize ["modifyvm", :id, "--vram", "64"]
    vb.gui = false
  end
  
  config.vm.hostname = hostname
  
  # Define shared folders
  
  config.vm.synced_folder "src/", "/shared/src"

  config.ssh.forward_x11 = true
  # config.ssh.private_key_path = "~/.ssh/github"
  config.ssh.forward_agent = true
  
  config.vm.provision 'preemptively give others write access to /etc/ansible/roles', type: :shell, inline: <<~'EOM'
    mkdir /etc/ansible/roles -p
    chmod o+w /etc/ansible/roles
  EOM

  # provision the VM using ansible
  config.vm.provision "ansible_local" do |ansible|
    ansible.galaxy_role_file = 'provisioning/ansible/galaxy_requirements.yml'
    ansible.galaxy_roles_path = '/etc/ansible/roles'
    ansible.galaxy_command = 'ansible-galaxy install --role-file=%{role_file} --roles-path=%{roles_path}'
    
    ansible.compatibility_mode = "2.0"


    ansible.playbook = "provisioning/ansible/setup_base.yml"
  end
  

  config.vm.provision "shell", inline: "echo 'Python Development Machine succesfully started. Log in with \"vagrant ssh\"'"

end
