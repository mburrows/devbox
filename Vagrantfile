Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.provision "file", source: "dotfiles/.tmux.conf", destination: ".tmux.conf"
  config.vm.provision "file", source: "dotfiles/.vimrc", destination: ".vimrc"
  config.vm.provision :shell, :privileged => false, :path => File.join( "provision", "provision.sh" )
end
