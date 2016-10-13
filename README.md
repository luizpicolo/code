[Read this document in English](https://github.com/sistemacode/code/blob/master/README_EN.md)

---

[![Build Status](https://travis-ci.org/sistemacode/code.svg?branch=FixedSpecs)](https://travis-ci.org/sistemacode/code)

# C.O.D.E - Controle de ocorrências e desempenho escolar

## Sobre o sistema

Veja o hotsite para divulgação do sistema: http://sistemacode.github.io

O Controle de Ocorrências de Desempenho Escolar, C.O.D.E, é um software desenvolvido com o objetivo de controlar parte do processo de ocorrências e relatórios de desempenho escolar de forma prática e segura. Possui menus auto-explicativos e, futuramente, um manual eletrônico para o auxilo no manuseio do software, ou, para usuários mais avançados, a adaptação de novos sistemas baseados em seu código fonte.
Sendo assim, pode-se dizer que o Sistema de Gestão de Ocorrências de Desempenho Escolar é de fácil operação e automatiza as principais rotinas envolvidas no objetivo proposto.
Operando em ambiente web, tem visual limpo que torna a navegação simples e rápida, trabalhando em mono ou multi-usuário.

## Preview

![Lista de estudantes](https://cdn.rawgit.com/sistemacode/code/master/public/screenshots/list_students.png)

## Instalação

O C.O.D.E foi desenvolvido utilizando a linguagem de programação Ruby com o Framework Rails e o banco de dados PostgreSQL. Logo, para que ele seja executado, você necessita de um ambiente que contenha todos estes recursos. Se não possui, siga os passos descritos em **Criando o ambiente para a execução do C.O.D.E**. Caso já possua o ambiente necessário, siga para [**Instalando o C.O.D.E**](#id-instalando-o-code).

## Criando o ambiente para execução do C.O.D.E
***(Distribuiçoes baseadas do distro Debian)***
OBS: Existem várias formas de se criar um ambiente de execução, fique a vontade para escolher o que mais lhe é familiar.

### Primeiramente instale o PostgreSQL

    sudo apt-get install postgresql postgresql-contrib


Ou se quiser, poder usar Docker para ter o banco de dados instalado para o seu ambiente de desenvolvimento, para isso:

- Primeiro instale Docker (para saber com instalar Docker consulte [aqui](https://docs.docker.com/engine/installation/))
- Após, rode:

    ```Bash
    $ docker-compose up
    ```

### Logo após, troque a senha do usuário executando os passos abaixo

    sudo su - postgres
    psql -c "ALTER USER postgres WITH PASSWORD 'nova_senha'"
    sudo service postgresql restart

### Configurando o server Ruby

    sudo apt-get install libcurl4-openssl-dev -y &&
    curl -L get.rvm.io | bash -s stable &&
    source ~/.rvm/scripts/rvm &&
    rvm requirements &&
    rvmsudo /usr/bin/apt-get install build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion &&
    rvm install ruby &&
    rvm use ruby --default &&
    rvm rubygems current

**Apenas para ambiente de produção**

    gem install passenger &&
    sudo apt-get install libpq-dev &&
    rvmsudo passenger-install-nginx-module &&
    sudo update-rc.d nginx defaults

<div id="id-instalando-o-code"></div>

## Instalando o C.O.D.E

**Primeiro passo:** Execute o comando abaixo para clonar o repositório para a máquina que disponibilizará o sistema

    git clone git@github.com:luizpicolo/code.git

**Segundo passo:** Em seguida, execute os próximos comandos para renomear os arquivos de configuração. Logo após, altere os dados para as configurações corretas

    cp config/database.yml.example config/database.yml &&
    cp config/application.yml.example config/application.yml &&
    cp config/secrets.yml.example config/secrets.yml

**Terceiro passo** Dentro do local onde o projeto foi clonado, execute os comando abaixo para migrar o banco de dados e criar o primeiro usuário do sistema

    bundle install && rake db:create && rake db:migrate

Caso deseje adicionar alguns dados de testes

    rake code:seed_example_data

## Usando o C.O.D.E pelo docker

Para rodar pelo Docker

    docker run sistemacode/code -p 8080:80 -v /caminho_na_maquina_host/var/lib/postgresql:/var/lib/postgresql

Onde "8080" é a porta em qual escutar, e "/caminho_na_maquina_host" é pasta no servidor onde devera ficar os dados do banco de dados.

## Teste

Para executar os testes :D

    rake db:test:prepare && rspec

## Coisas a fazer

 - Internacionalização
 - Manual acoplado ao sistema (Aberto a propostas)

## Acesso ao sistema

Caso todos os passos acima tenham sido executados corretamente, você está apto(a) a utilizar o sistema.
Acesse o endereço ( caso esteja executando localmente `http://localhost:3000` ) e utilize o usuário semeado anteriormente.
`admin@admin.com.br` e senha `12345678`
______
Criado com <3 por Luiz Picolos
