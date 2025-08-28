Vagrant.configure("2") do |config|
  # Box base
  config.vm.box = "debian/bookworm64"

  # Hostname
  config.vm.hostname = "guilherme.mihael"

  # Desabilitar geração de chaves SSH
  config.ssh.insert_key = false

  # Rede privada (host-only) com IP fixo
  config.vm.network "private_network", ip: "192.168.56.162"

  # Port forwarding NAT para acesso via localhost
  config.vm.network "forwarded_port", guest: 8080, host: 8080

  # Configurações da VM
  config.vm.provider "virtualbox" do |vb|
    vb.memory = 1024
    vb.check_guest_additions = false
  end

  # Provisionamento com Ansible
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "ansible/playbook_ansible.yml"
  end
end

