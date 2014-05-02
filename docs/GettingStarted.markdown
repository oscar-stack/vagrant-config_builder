# @title Getting Started

# Getting Started

The vagrant-config_builder plugin is designed to ease the management of complex Vagrant setups.
This goal is accomplished by moving configuration data out of the Vagrant DSL and into formats that excel at expressing hierarchical information.
Moving the configuration to a dedicated data structure allows multiple VMs to be defined by composing and remixing a set of common components.
This guide describes:

  - How to transition a Vagrant configuration to a ConfigBuilder data structure.

  - How vagrant-config_builder maps that structure back to a Vagrant configuration.

  - The methodology that vagrant-config_builder uses to manage components of configuration shared by multiple VMs.


## Expressing Configuration as Data

This guide will walk through re-implementing the following Vagrantfile using vagrant-config_builder:

```ruby
# Vagrantfile

# Requires the following plugins:
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
      /usr/bin/puppet resource service iptables ensure=stopped enable=false
      /usr/bin/puppet resource service puppetmaster ensure=running enable=true
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

The above listing showcases several examples of duplicated configuration: both VMs are using the same Vagrant box, both are configuring their networks in the same way and both are provisioned using nearly identical shell scripts.
In fact, the only real difference between the VMs are the hostnames and the few lines of shell that install and configure the Puppet master instead or the Puppet agent.
These little bits of shared configuration pop up constantly in multi-machine Vagrant environments and are commonly handled by a combination of copy-and-paste and factoring out bits of data and configuration into variables or methods (such as `box_name` and `box_url` used above).
There are some significant drawbacks to this situation:

  - Copy and paste quickly becomes expensive to maintain as the number of machines in the environment increases.

  - Factoring configuration out to variables and methods can help, but requires care to produce something that is portable and reusable across environments.

  - Determining which bits of configuration are shared among which machines is a challenging task to complete quickly and usually requires a careful reading of the Vagrantfile.

vagrant-config_builder approaches this problem by storing every bit of configuration in a unified data structure.
The structure can be loaded from any data source that is convertable to a hash such as YAML, JSON, XML (possibly [interpretive dance][oscar data sources]).
Generation of configuration hashes from data sources is implemented through the `ConfigBuilder::Loader` module and is completely pluggable.
This guide will use YAML as the configuration storage format as vagrant-config_builder includes a YAML Loader.

If the Vagrantfile above were to be translated to YAML, it would look like this:

```yaml
# config/vms.yaml
---
vms:
  - name: puppetmaster
    box_url: http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210-nocm.box
    box: centos-64-x64-vbox4210-nocm
    hostname: puppetmaster.boxnet
    private_networks:
      - {ip: 0.0.0.0, auto_network: true}
    provisioners:
      - type: hosts
      - type: shell
        inline: |
          if which puppet > /dev/null 2>&1; then
            echo 'Puppet Installed.'
          else
            echo 'Installing Puppet Master.'
            rpm -ivh http://yum.puppetlabs.com/el/6/products/i386/puppetlabs-release-6-6.noarch.rpm
            yum --nogpgcheck -y install puppet-server
            echo '*.boxnet' > /etc/puppet/autosign.conf
            /usr/bin/puppet resource service iptables ensure=stopped enable=false
            /usr/bin/puppet resource service puppetmaster ensure=running enable=true
          fi

  - name: puppetagent
    box_url: http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210-nocm.box
    box: centos-64-x64-vbox4210-nocm
    hostname: puppetagent.boxnet
    private_networks:
      - {ip: 0.0.0.0, auto_network: true}
    provisioners:
      - type: hosts
      - type: shell
        inline: |
          if which puppet > /dev/null 2>&1; then
            echo 'Puppet Installed.'
          else
            echo 'Installing Puppet Master.'
            rpm -ivh http://yum.puppetlabs.com/el/6/products/i386/puppetlabs-release-6-6.noarch.rpm
            yum --nogpgcheck -y install puppet
          fi
```
The YAML configuration above maps very closely to the original Vagrant DSL.
The major differences are:

  - Repetitive bits of syntax such as `config.vm.*` and `node.vm.*` are now expressed implicitly through the structure of the data.

  - Operations that are executed multiple times are expressed as arrays. These are:

    - Defining VMs.

    - Defining network interfaces on VMs.

    - Running provisioners on VMs.

The mapping between the ConfigBuilder data and the original Vagrantfile will be covered in detail in the next section.
With the YAML configuration saved in `config/vms.yaml`, the Vagrantfile can updated to invoke `ConfigBuilder.load`:

```ruby
# Vagrantfile

# Requires the following plugins:
#
#  - vagrant-hosts
#  - vagrant-auto_network
#  - vagrant-config_builder
#
Vagrant.configure('2', &ConfigBuilder.load(
  :yaml,
  :yamldir,
  File.expand_path('../config', __FILE__)
))
```

This calls the `yamldir` method of the YAML Loader and passes a path to a `config` directory located adjacent to the Vagrantfile.

  [oscar data sources]: http://www.youtube.com/watch?v=1TgGQjjLDXg&t=19m27s
