Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/trusty64"
    config.vm.box_download_insecure = true

    config.vm.provider "virtualbox" do |v|
        v.customize ["modifyvm", :id, "--memory", "1024"]
    end

    config.vm.provision "file", source: "dotfiles/.", destination: "~"
    config.vm.provision :shell, :privileged => false, :path => File.join( "provision", "provision.sh" )
end
