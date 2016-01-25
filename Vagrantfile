# -*- mode: ruby -*-
# vi: set ft=ruby :


## Load box options

require_relative "VagrantConfig/VagrantConfig.rb"

# Calculate hostname and IP values
VagrantConfig[:box][:hostname] = VagrantConfig[:box][:box_name].downcase
VagrantConfig[:box][:ip] = "10.10.10.#{VagrantConfig[:box][:box_number]}"


## Configure the box

Vagrant.configure(2) do |config|
  
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.
  
  
  ## Box specification
  
  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ubuntu/trusty64"
  
  # Set the name of the box (as shown in Vagrant messages)
  config.vm.define VagrantConfig[:box][:box_name]
  
  # Set the guest's hostname
  config.vm.hostname = VagrantConfig[:box][:hostname]
  
  
  ## Network
  
  # Create a private network, using the box number to determine the IP
  config.vm.network "private_network", ip: VagrantConfig[:box][:ip]
  
  # Forward ports for Apache, SSL, and MySQL, using the box number for the port component
  config.vm.network "forwarded_port", 
    guest: 80,
    host: "80#{VagrantConfig[:box][:box_number]}"
  
  config.vm.network "forwarded_port", 
    guest: 443,
    host: "44#{VagrantConfig[:box][:box_number]}"
  
  config.vm.network "forwarded_port", 
    guest: 3306,
    host: "33#{VagrantConfig[:box][:box_number]}"
  
  # Specify ports that Vagrant may use for "handling port collisions and such"
  config.vm.usable_port_range = 2900..3000
  
  # Set a message for when `vagrant up` has finished
  config.vm.post_up_message = <<-pumsg
    The "#{VagrantConfig[:box][:box_name]}" VM (box number: #{VagrantConfig[:box][:box_number]}) has finished building.
    IP address: #{VagrantConfig[:box][:ip]}
    
    Available ports:
    
    SSH:    localhost:22#{VagrantConfig[:box][:box_number]}
    HTTP:   localhost:80#{VagrantConfig[:box][:box_number]}
    HTTPS:  localhost:44#{VagrantConfig[:box][:box_number]}
    MySQL:  localhost:33#{VagrantConfig[:box][:box_number]}
    
    Have a nice day.
    
  pumsg
  
  
  ## Filesystem
  
  # Choose NFS or rsync
  if (:nfs === VagrantConfig[:sync][:method])
    
    # NFS
    
    # Share the Apache document root with the guest VM using vagrant-bindfs
    # First we share our host directory to /vagrant-nfs, then we use
    # bindfs to re-mount /vagrant-nfs to the real guest directory
    config.vm.synced_folder VagrantConfig[:sync][:from], "/vagrant-nfs", type: :nfs
    config.bindfs.bind_folder "/vagrant-nfs", VagrantConfig[:sync][:to]
  
  elsif (:rsync === VagrantConfig[:sync][:method])
    
    # rsync
    
    # Set the base rsync options
    config.vm.synced_folder(
      VagrantConfig[:sync][:from],
      VagrantConfig[:sync][:to],
      type: "rsync",
      rsync__exclude: [".git/", "sites/default/files/", "sites/default/nfsfiles/"],
      rsync__args: ["--verbose", "--archive", "--delete", "-z", "--links"]
    )
    
    # Set gatling-rsync plugin options
    if Vagrant.has_plugin?("vagrant-gatling-rsync")
      config.gatling.latency = 2.5
      config.gatling.time_format = "%H:%M:%S"
    end
    
  else
    abort "Invalid sync method '#{VagrantConfig[:sync][:method].inspect}'."
  end
  
  
  ## SSH
  
  # Enable agent forwarding so that host SSH keys will be available on the guest
  config.ssh.forward_agent = true
  
  # Override default forwarded port for SSH
  config.vm.network :forwarded_port,
    guest: 22,
    host: "22#{VagrantConfig[:box][:box_number]}",
    id: "ssh",
    auto_correct: true
  
  
  ## Provider
  
  # Configure VirtualBox
  config.vm.provider "virtualbox" do |vb|
    
    # The name of the box, as it appears in VirtualBox
    vb.name = VagrantConfig[:box][:box_name]
    
    # CPU and memory allocation
    vb.cpus = 2
    vb.memory = 2048
    
    # Cap CPU usage to 50% of host CPU
    vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
    
    # Use paravirtualised networking
    vb.customize ["modifyvm", :id, "--nictype1", "virtio"]
    
    # Use NAT for DNS
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    
    # Set time synchronisation frequency to 60 seconds
    vb.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 60000]
    
  end
  
  
  ## Provisioning
  
  # Ansible
  config.vm.provision "ansible" do |ansible|
    
    # Call the playbook
    ansible.playbook = "VagrantConfig/ansible/playbook.yaml"
    
    # Pass in box options
    ansible.extra_vars = VagrantConfig
    
  end
  
end
