Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-22.04"
  config.vm.provision "shell", path: "init.sh"
  config.vm.synced_folder ".", "/home/vagrant/watermark_function"
  config.vm.network "forwarded_port", guest: 3000, host: 3000
end
