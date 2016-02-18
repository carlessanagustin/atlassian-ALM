# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    
    config.vm.boot_timeout = 60
    
    config.vm.define "bitbucket" do |bitbucket|
        bitbucket.vm.provision :shell, :path => "bootstrap-bitbucket.sh"
        bitbucket.vm.host_name = "bitbucket"
        bitbucket.vm.box = "ubuntu/trusty64"
        bitbucket.vm.provider "virtualbox" do |vb|
            vb.memory = 2048
            vb.cpus = 1
        end
        bitbucket.vm.network "forwarded_port", host: 7990, guest: 7990, auto_correct: true # bitbucket
        bitbucket.vm.network "forwarded_port",  host: 5432, guest: 5432, auto_correct: true # postgres
        bitbucket.vm.network "private_network", ip: "192.168.32.10", virtualbox__intnet: true, auto_config: true
    end
    
    config.vm.define "jira" do |jira|
        jira.vm.provision :shell, :path => "bootstrap-jira.sh"
        jira.vm.host_name = "jira"
        jira.vm.box = "ubuntu/trusty64"
        jira.vm.provider "virtualbox" do |vb|
          vb.memory = 2048
          vb.cpus = 1
            end
        jira.vm.network "forwarded_port", host: 8080, guest: 8080, auto_correct: true # jira
        jira.vm.network "private_network", ip: "192.168.32.11", virtualbox__intnet: true, auto_config: true
    end
    
    config.vm.define "jenkins" do |jenkins|
        jenkins.vm.provision :shell, :path => "bootstrap-jenkins.sh"
        jenkins.vm.host_name = "jenkins"
        jenkins.vm.box = "ubuntu/trusty64"
        jenkins.vm.provider "virtualbox" do |vb|
          vb.memory = 1024
          vb.cpus = 1
            end
        jenkins.vm.network "forwarded_port", host: 8081, guest: 80, auto_correct: true # jenkins
        jenkins.vm.network "forwarded_port", host: 8082, guest: 8080, auto_correct: true # jenkins
        jenkins.vm.network "forwarded_port", host: 8085, guest: 8085, auto_correct: true # jenkins
        jenkins.vm.network "private_network", ip: "192.168.32.12", virtualbox__intnet: true, auto_config: true
    end
    
end