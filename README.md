# Projeto 02 - Docker com Vagrant e Ansible

## Descrição
Este projeto tem como objetivo provisionar uma máquina virtual utilizando **Vagrant** e configurar automaticamente, via **Ansible**, um ambiente de containers **Docker** para hospedar a aplicação **WordPress** integrada com **MySQL** e **Nginx**.

O provisionamento automatiza:
- Instalação do Docker e dependências
- Criação da rede e volumes do Docker
- Criação e execução dos containers (WordPress, MySQL e Nginx)
- Configuração de proxy reverso e suporte a balanceamento de carga

---

##  Estrutura de Diretórios


Projeto-02-Docker-com-Vagrant-e-Ansible/
│── Vagrantfile              
│── ansible/ 
│   ├── docker-compose.yml
│   ├── playbook_ansible.yml
│── docker/  
│   ├── Dockerfile
│   ├── nginx.conf               
│── README.md
             

`

---

## Passo a Passo de Execução

1. Clone este repositório:
   bash
   git clone https://github.com/Gui-IFPB/Projeto-02-Docker-com-Vagrant-e-Ansible.git
   cd Projeto-02-Docker-com-Vagrant-e-Ansible
`

2. Suba a máquina virtual com o Vagrant:

   bash
   vagrant up
   

3. Aguarde a conclusão do **provisionamento automático** realizado pelo Ansible.

4. Ao finalizar, a aplicação WordPress estará disponível no navegador em:

   
   http://192.168.56.162:8080
   

---

## Teste do Projeto

Para realizar os testes, basta executar o comando abaixo para garantir que a VM está ativa:

bash
vagrant ssh hostname -f


Em seguida, abra o navegador e acesse:


http://192.168.56.162:8080


Se tudo estiver correto, a página de instalação/configuração do **WordPress** será exibida.

---


