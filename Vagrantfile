Vagrant.configure("2") do |config|
    config.vm.box = "bento/ubuntu-16.04"
    config.vm.box_download_insecure = true
    config.ssh.forward_x11 = true

    config.vm.provider "virtualbox" do |v|
        v.customize ["modifyvm", :id, "--memory", "1024"]
    end

    config.vm.provision "file", source: "dotfiles/.", destination: "~"
    config.vm.provision :shell, :privileged => false, :path => File.join( "provision", "provision.sh" )
end
