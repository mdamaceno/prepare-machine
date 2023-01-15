# Instalação do Debian

## 1. Instalação mínima do sistema

Fazer partição do disco com btrfs. Mínimo de 30% para / (raíz) e 70% para /home. Verificar a necessidade de swap.

Selecionar apenas o **SSH Server** na instalação.

Após a instalação do sistema pelo instalador e reiniciada a máquina, adicionar os pacotes necessários:

```
sudo apt update
sudo apt install vim htop bash-completion
```

Para ter auto completar rode o comando `source /etc/bash_completion`.

Editar o arquivo `/etc/apt/sources.list`

Comentar as entradas com `deb-src` e adicionar na frente das linhas `contrib non-free`.

Instalar driver AMD Graphics `sudo apt install firmware-amd-graphics`
Instalar driver bluetooth Atheros `sudo apt install firmware-atheros`

Rodar `sudo apt update` para atualizar.

## Instalação do servidor gráfico e window manager

### Xorg
Instalar o servidor gráfico com `sudo apt install xorg` e/ou `sudo apt install xwayland`

### XFCE
Instalar Xfce com `sudo apt install xfce4`
Instalar XFCE Goodies com `sudo apt install xfce4-goodies`
Instalar XFCE Terminal com `sudo apt install xfce4-terminal`
Instalar editor de menu do XFCE Menulibre `sudo apt install menulibre`

Remover Xterm com `sudo apt remove xterm`

## Instalação de serviços e utilitários

Instalar Snap `sudo apt install snapd`
Reiniciar a máquina
Instalar o Snap Core `sudo snap install core`
Tornar executáveis do Snap acessíveis `echo `

Instalar docker `sudo snap install docker`

Para rodar o docker como usuário normal, executar os comandos:

```
sudo addgroup --system docker
sudo adduser $USER docker
newgrp docker
sudo snap disable docker
sudo snap enable docker
```

Instalar ferramentas web simples `sudo apt install curl wget`

Instalar ferramentas de extração de arquivo:

```
sudo apt install zip unzip rar unrar zstd
```

Instalar de pacotes essenciais para desenvolvimento:
```
sudo apt install git build-essential autoconf cmake libyaml-dev libpq-dev libmariadb-dev sqlite3
```
