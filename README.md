# Application Lifecycle Management Stack

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
```

#### Iniciar y aprovisionar las instancias

* Jira + BitBucket

```bash
$ vagrant up --provision
```

* Solo Jira

```bash
$ vagrant up jira --provision
```

* Solo BitBucket

```bash
$ vagrant up bitbucket --provision
```

* Ir a BitBucket - [http://localhost:7990](http://localhost:7990)
* Ir a Jira - [http://localhost:8080](http://localhost:8080)

#### Parar las instancias

```bash
$ vagrant halt
```

#### Eliminar las instancias

```bash
$ ./delete-vagrant.sh
```

------

Creado por [carlessanagustin.com](http://www.carlessanagustin.com)