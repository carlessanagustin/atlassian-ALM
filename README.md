# Application Lifecycle Management Stack

https://confluence.atlassian.com/jira/installing-jira-on-linux-191501165.html#InstallingJIRAonLinux-PerforminganUnattendedInstallation

(TODO) LEFT HERE:
* https://confluence.atlassian.com/bitbucketserver/securing-bitbucket-server-with-tomcat-using-ssl-776640127.html
* https://confluence.atlassian.com/bitbucketserver/getting-started-776640896.html


Basado en Atlassian. Incluye:

* Jira
* BitBucket

## Uso

### Pre-requisitos

Debemos asegurar que tenemos instalado el siguiente listado de software en nuestro ordenador

* Instalar VirtualBox - https://www.virtualbox.org/
* Instalar Vagrant - https://www.vagrantup.com/
* Instalar Git - https://git-scm.com/

### Instrucciones

* Abrir Git Bash (Windows) o Terminal (Linux/MacOSX)
* Realizar los siguientes pasos

```bash
$ cd /carpeta/de/trabajo
$ git clone https://github.com/carlessanagustin/atlassian-ALM.git
$ cd atlassian-ALM
$ vagrant up --provision
```

* Ir a BitBucket - [http://localhost:7990](http://localhost:7990)
* Ir a Jira - [http://localhost:8080](http://localhost:8080)

------

Creado por [carlessanagustin.com](http://www.carlessanagustin.com)