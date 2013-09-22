# @title Getting Started

# Getting Started

The vagrant-config_builder plugin is designed to ease the management of complex Vagrant setups.
This goal is accomplished by moving configuration data out of the Vagrant DSL and into formats that excel at expressing hierarchical information.
Moving the configuration to a dedicated data structure allows many VMs to be defined by composing and remixing a set of common components.
This guide describes:

  - How to transition a Vagrant configuration to a YAML data structure.

  - How vagrant-config_builder maps that structure back to a Vagrant configuration.

  - The methods that vagrant-config_builder uses to manage components of configuration shared by multiple VMs.


## Expressing Configuration as Data

This guide will walk through re-implementing the following Vagrantfile using vagrant-config_builder:

```ruby
# This Vagrantfile requires the following plugins:
#
#   - vagrant-hosts
#   - vagrant-auto_network
#
Vagrant.configure('2') do |config|

  box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210-nocm.box'
  box_name = 'centos-64-x64-vbox4210-nocm'

  config.vm.define :puppetmaster do |node|
    node.vm.box_url = box_url
    node.vm.box = box_name

    node.vm.hostname = 'puppetmaster.boxnet'

    node.vm.network :private_network, :ip => '0.0.0.0', :auto_network => true
    node.vm.provision :hosts

    node.vm.provision :shell, :inline => <<-EOF
    if which puppet > /dev/null 2>&1; then
      echo 'Puppet Installed.'
    else
      echo 'Installing Puppet Master.'
      rpm -ivh http://yum.puppetlabs.com/el/6/products/i386/puppetlabs-release-6-6.noarch.rpm
      yum --nogpgcheck -y install puppet-server
      echo '*.boxnet' > /etc/puppet/autosign.conf
      service iptables stop
      service puppetmaster start
    fi
    EOF
  end

  config.vm.define :puppetagent do |node|
    node.vm.box_url = box_url
    node.vm.box = box_name

    node.vm.hostname = 'puppetagent.boxnet'

    node.vm.network :private_network, :ip => '0.0.0.0', :auto_network => true
    node.vm.provision :hosts

    node.vm.provision :shell, :inline => <<-EOF
    if which puppet > /dev/null 2>&1; then
      echo 'Puppet Installed.'
    else
      echo 'Installing Puppet Agent.'
      rpm -ivh http://yum.puppetlabs.com/el/6/products/i386/puppetlabs-release-6-6.noarch.rpm
      yum --nogpgcheck -y install puppet
    fi
    EOF
  end

end
```
