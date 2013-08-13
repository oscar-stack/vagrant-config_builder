Vagrant Config Builder
======================

Configure and manage your Vagrant environments with data.

Synopsis
--------

This plugin provides an interface to the Vagrant configuration constructs in a
logic free manner. You can format your input data to fit your needs and use
`vagrant-config_builder` to transform that into the needed Vagrant config.

Example
-------

This example loads all yaml files in the config directory and generates a
Vagrant config based on that information. File names are arbitrary and chosen
for clarity.

#### Directory structure

    .
    ├── config
    │   ├── roles.yaml
    │   └── vms.yaml
    └── Vagrantfile

#### Vagrantfile

    require 'config_builder'
    Vagrant.configure('2', &ConfigBuilder.load(
      :yaml,
      :yamldir,
      File.expand_path('config', __DIR__)
    ))

#### config/roles.yaml

    ---
    roles:
      bigvm:
        provider:
          type: virtualbox
          customize: [[modifyvm, !ruby/sym id, '--memory', 1024]]

#### config/vms.yaml

    ---
    vms:
      -
        name: db
        private_networks: [ {ip: '10.20.1.2'} ]
        box: centos-5-i386
        roles: bigvm
      -
        name: web
        private_networks: [ {ip: '10.20.1.3'} ]
        box: centos-5-i386

Installation
------------

Build the gem:

  * `gem build vagrant-config_builder.gemspec`

Install the gem:

  * `gem install vagrant-config_builder-0.1.0dev.gem`

Installation into the Vagrant internal gems:

  * `vagrant plugin install vagrant-config_builder`
