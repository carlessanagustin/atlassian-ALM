Vagrant.configure(2) do |config|
    config.vm.box = "ubuntu/trusty64"

    config.vm.provision :shell, :path => "bootstrap-bitbucket.sh"

    config.vm.provider "virtualbox" do |vb|
        vb.memory = 1024
        vb.cpus = 1
    end
    
    config.vm.network "forwarded_port", host: 8080, guest: 80, auto_correct: true # web
    config.vm.network "forwarded_port",  host: 5432, guest: 5432, auto_correct: true # postgres

    config.vm.network "private_network", ip: "192.168.32.10", virtualbox__intnet: true, auto_config: true
end
