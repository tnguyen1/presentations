#### &nbsp;

# Docker

### 16-Dec-2014

<img src="docker_wave_whale.svg" height="250" />

----

## What is Dokker?

<p class="fragment">

<img src="dokkervan.png" height="400" /> &nbsp; <img src="dacia.png" height="200" />

</p>

----

<h2>What is <span style="color:#005976;">Docker</span>?</h2>

**`Docker`** builds on top of OS-level virtualization methods

for running multiple isolated **`Linux`** systems - **`containers`** -

on a single host system

<p class="fragment">

<img src="linux-kernel-chgroups-arch.png" height="350" /> &nbsp; <img src="littletux.png" height="200" />

</p>

----

## What are Containers?

<img src="containers.png" height="180"/>

A **`container`** is a self contained execution environment

that shares the kernel of the host system and

which is isolated from other containers in the system

- - -

<p class="fragment">

**Isolated resources**
<br>
{ CPU, memory, disk I/O, network, process IDs etc. }

</p>

----

## What are Containers?

<img src="containers.png" height="180"/>

Examples of containerization methods

[Linux Containers (LXC)](https://linuxcontainers.org/) | [OpenVZ](http://openvz.org/) | [Linux-VServer](http://linux-vserver.org/)

- - -

Docker's own default **execution driver** | [libcontainer](https://github.com/docker/libcontainer)&nbsp;&nbsp;<i class="fa fa-github-square"></i>

----

## Containers vs. Virtual Machines

**Virtual machines** | Hypervisor-based virtualization

**Containers** | OS-level virtualization

<img src="container_vs_vm.jpg" />

----

## Containers vs. Virtual Machines

&nbsp;

#### Virtual machines

Full OS for each VM

Any operating system

Fully dedicated resources (CPU, RAM, Disk)

- - -

#### Containers

Shared kernel providing isolated virtual environment

Any Linux distribution

Lightweight | Low overhead per container

----

## Docker Containers & Images

Enter Docker's layer system

<img src="Multiple_Layers-512.png" height="350"/>

--

## Filesystems

Linux requires 2 filesystems

<img src="docker-filesystems-generic.png" height="450"/>

--

## Multiple rootfs

Docker supports multiple rootfs

<img src="docker-filesystems-multiroot.png" height="450"/>

--

## Docker image

Read-only layers are called **`images`**

<img src="docker-filesystems-debian.png" height="450"/>

--

## Stacking images

Images can depend on other images called **`parents`**

<img src="docker-filesystems-multilayer.png" height="450"/>

--

## Docker container

On top of images Docker creates writable layers called **`containers`**

<img src="docker-filesystems-busyboxrw.png" height="450"/>

----

## Docker composition

&nbsp;

1. A **daemon** with a RESTful API
<pre><code class="bash">$ sudo service docker start</code></pre>

1. A **command-line client** to build images and manage containers
<pre><code class="bash">$ docker info|build|images|run|ps|exec|start|stop|rm
$ docker search|pull|push</code></pre>

1. Public and private Docker **image registries**
<br>
[Docker Hub Registry](https://registry.hub.docker.com) &nbsp;<i class="fa fa-external-link"></i>

----

## Demo

&nbsp;

1. Foreground container
1. Detached container
1. Versioned filesystem
1. Saving a container state to an image
1. Automated image build &laquo; Dockerfile

--

## 1. Foreground container

<pre><code class="bash"># start /bin/bash in a container | -i means interactive
$ docker run --name demo -t -i ubuntu:14.04 /bin/bash
root@cbe84007dedc:/>

# look around all your processes / filesystem / network
root@cbe84007dedc:/> ps aux
root@cbe84007dedc:/> ls -l
root@cbe84007dedc:/> ifconfig

# exit - container is stopped as /bin/bash exits
root@cbe84007dedc:/> exit

# start container
$ docker start demo
root@cbe84007dedc:/>

# detach/attach container
root@cbe84007dedc:/> Ctrl-p + Ctrl-q
$ docker attach demo
root@cbe84007dedc:/>
</code></pre>

--

## 2. Detached container

<pre><code class="bash"># -d means detached
$ CID=$(docker run -d ubuntu:14.04 \
  bash -c 'while true; do sleep 1; echo hello at $(date); done')

# show id of container
$ echo $CID

# show container's logs (stdout)
$ docker logs -f $CID

# show running containers
$ docker ps

# stop container
$ docker stop $CID

# show all stopped and running containers
$ docker ps -a

# remove container
$ docker rm $CID</code></pre>

--

## 3. Versioned filesystem

<pre><code class="bash"># look at /tmp
$ docker run ubuntu:14.04 /bin/ls -l /tmp

# modify the filesystem
$ CID=$(docker run -d ubuntu:14.04 \
  bash -c 'while true; do sleep 1; echo "hello at $(date)" > /tmp/$(date +%Y%m%d_%H%M%S); done')

# see the changes on the filesystem
$ docker diff $CID

# stop and remove the container
$ docker stop $CID; docker rm $CID

# create new container and look at /tmp
# changes are gone!
$ docker run ubuntu:14.04 /bin/ls -l /tmp</code></pre>

--

## 4. Saving a container state to an image

<pre><code class="bash"># new container with filesystem modifications
$ CID=$(docker run -d ubuntu:14.04 \
  bash -c 'while true; do sleep 1; echo "hello at $(date)" > /tmp/$(date +%Y%m%d_%H%M%S); done')

# see the changes on the filesystem
$ docker diff $CID

# commit container changes to a new image named $USER/demo
$ docker commit $CID $USER/demo

# stop and remove the container
$ docker rm -f $CID

# create new container and look at /tmp
# changes are gone!
$ docker run $USER/demo /bin/ls -l /tmp</code></pre>

--

<h2>5. Automated image build &laquo; <span style="color:#005976;">Dockerfile</span></h2>

Docker can **`build`** images automatically

by reading instructions from a **`Dockerfile`**

<pre class="fragment"><code class="bash"># Example Dockerfile
# Pull base image
FROM dockerfile/ubuntu

# Install Java
RUN apt-get update && apt-get install -y openjdk-7-jdk && rm -rf /var/lib/apt/lists/*

# Define working directory
WORKDIR /data

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

# Define default command.
CMD ["bash"]</code></pre>

<pre class="fragment"><code class="bash"># Build image from Dockerfile
path/to/Dockerfile $ docker build -t $USER/demomo .</code></pre>

----

## Docker @ Bonitasoft

<img src="jenkins.png" height="150" />
<br>
<img src="sonarqube.png" height="80" /> &nbsp; <img src="postgresql.png" height="80" />
<br>
<img src="nodejs.png" height="80" /> &nbsp; <img src="npm.png" height="80" /> &nbsp; <img src="docker-registry.png" height="80" />
<br>
<img src="nginx.png" height="80" /> &nbsp; <img src="php.png" height="80" /> &nbsp; <img src="mysql.png" height="80" />

----

## Docker @ Bonitasoft

&nbsp;

<i class="fa fa-bolt"></i>&nbsp;&nbsp;5 Docker hosts with 2 **Jenkins** containers each

<i class="fa fa-bolt"></i>&nbsp;&nbsp;1 Docker host with 5 application containers

- - -

<i class="fa fa-bolt"></i>&nbsp;&nbsp;Jenkins Docker containers appear on local network
<br>
thanks to **`iptables`** NAT rules

&nbsp;

<img src="Bonitasoft-logo.png" height="100" />

----

## Documentation

&nbsp;

https://www.docker.com &nbsp;<i class="fa fa-external-link"></i>

[Docker for Bonitasoft CI on GitHub](https://github.com/bonitasoft/bonita-internal-tools/tree/master/ci/docker) &nbsp;<i class="fa fa-github-square"></i>

[Docker on R&D Google site](https://sites.google.com/a/bonitasoft.com/rd/continuous-integration/docker) &nbsp;<i class="fa fa-google-plus-square"></i>

&nbsp;

<img src="documentation.png" />

----

#### &nbsp;

# Thank you

#### &nbsp;

<img src="docker-logo.png" />
