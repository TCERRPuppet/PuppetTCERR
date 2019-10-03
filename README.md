#  PuppetTCERR
Repositório com Catálogos Puppet para diferentes tipos de servidores.

# Como Instalar o Agente Puppet:

Debian 8.X:

cd /tmp

wget http://apt.puppet.com/puppetlabs-release-pc1-jessie.deb

dpkg -i puppetlabs-release-pc1-jessie.deb


Debian 9.X:

cd /tmp

wget http://apt.puppet.com/puppetlabs-release-pc1-stretch.deb

dpkg -i puppetlabs-release-pc1-stretch.deb


Ubuntu:

cd /tmp
wget http://apt.puppet.com/puppetlabs-release-pc1-xenial.deb
dpkg -i puppetlabs-release-pc1-xenial.deb

Após isso:

Debian/Ubuntu:

apt-get update

apt-get -y install puppet-agent

export PATH=/opt/puppetlabs/bin:$PATH

echo "PATH=/opt/puppetlabs/bin:$PATH" >> /etc/bash.bashrc


CentOS/Red Hat:

yum install -y http://yum.puppet.com/puppetlabs-release-pc1-el-7.noarch.rpm

yum -y install puppet-agent

export PATH=/opt/puppetlabs/bin:$PATH

echo "PATH=/opt/puppetlabs/bin:$PATH" >> /etc/bashrc


# Para Estabelecer a Comunicação Entre Agente e Servidor:

Editar o arquivo /etc/puppetlabs/puppet/puppet.conf e adicionar as linhas:

[main]

certname = {hostname --fqdn}

server = {servername --fqdn}

environment = production

[agent]

report = true

pluginsync = true

Após isso, solicitar o certificado para o Servidor com o comando: 'puppet agent -t'.

Assim que o certificado for autenticado no servidor, para aplicar os catálogos, digitar o mesmo comando: 'puppet agent -t'.
