# Jenkins

https://www.jenkins.io/doc/book/getting-started/

## what is Jenkins?

for CI/ID

Jenkins is an extensible automation server with more than 1500 plugins providing integrations for hundreds of tools and services.

1. 자동화 테스트
2. 코드 표준 준수여부 검사
3. 빌드 파이프라인 구성

## Installing Jenkins

### Docker

Docker is a platform for running applications in an isolated environment called a "container" (or Docker container). Applications like Jenkins can be downloaded as read-only "images" (or Docker images), each of which is run in Docker as a container.

#### Prerequisites

Minimum hardware requirements:
* 256 MB of RAM
* 1 GB of drive space (although 10 GB is a recommended minimum if running Jenkins as a Docker container)

Recommended hardware configuration for a small team:
* 4 GB+ of RAM
* 50 GB+ of drive space

Comprehensive hardware recommendations:
* Hardware: see the Hardware Recommendations page, https://www.jenkins.io/doc/book/scaling/hardware-recommendations/

Software requirements:
* Java: see the Java Requirements page, https://www.jenkins.io/doc/administration/requirements/java/
* Web browser: see the Web Browser Compatibility page, https://www.jenkins.io/doc/administration/requirements/web-browsers
* For Windows operating system: Windows Support Policy, https://www.jenkins.io/doc/administration/requirements/windows

##### Install Docker
```shell
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
```

1. List the versions available in your repo:
```shell
apt-cache madison docker-ce
```

2. Install a specific version using the version string from the second column, for example,
```shell
sudo apt-get install docker-ce=<VERSION_STRING> docker-ce-cli=<VERSION_STRING> containerd.io
```

Verify that Docker Engine is installed correctly by running the hello-world image.
```shell
sudo docker run hello-world
```

##### Uninstall Docker

```shell
# uninstall old-version
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd
```

#### On Linux

1. Open up a terminal window.

2. Create a bridge network in Docker using the following docker network create command:
```shell
docker network create jenkins
```

3. In order to execute Docker commands inside Jenkins nodes, download and run the docker:dind Docker image using the following docker run command:
```shell
docker run \
  --name jenkins-docker \ # 	( Optional )
  --rm \                  #  	( Optional )
  --detach \              # 	( Optional )
  --privileged \
  --network jenkins \
  --network-alias docker \
  --env DOCKER_TLS_CERTDIR=/certs \
  --volume jenkins-docker-certs:/certs/client \
  --volume jenkins-data:/var/jenkins_home \
  --publish 2376:2376 \   # 	( Optional )
  docker:dind \
  --storage-driver overlay2
```

> Note: If copying and pasting the command snippet above does not work, try copying and pasting this annotation-free version here:
```shell
docker run --name jenkins-docker --rm --detach \
  --privileged --network jenkins --network-alias docker \
  --env DOCKER_TLS_CERTDIR=/certs \
  --volume jenkins-docker-certs:/certs/client \
  --volume jenkins-data:/var/jenkins_home \
  --publish 2376:2376 docker:dind --storage-driver overlay2
```

4. Customise official Jenkins Docker image, by executing below two steps:

      * Create Dockerfile with the following content:

```shell
FROM jenkins/jenkins:2.319.1-jdk11
USER root
RUN apt-get update && apt-get install -y lsb-release
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-ce-cli
USER jenkins
RUN jenkins-plugin-cli --plugins "blueocean:1.25.2 docker-workflow:1.26"
```

      * Build a new docker image from this Dockerfile and assign the image a meaningful name, e.g. "myjenkins-blueocean:1.1":

```shell
docker build -t myjenkins-blueocean:1.1 .
```

  Keep in mind that the process described above will automatically download the official Jenkins Docker image if this hasn’t been done before.

5. Run your own myjenkins-blueocean:1.1 image as a container in Docker using the following docker run command:

```shell
docker run \
  --name jenkins-blueocean \        # 	( Optional )
  --rm \                            # 	( Optional )
  --detach \                        # 	( Optional )
  --network jenkins \
  --env DOCKER_HOST=tcp://docker:2376 \
  --env DOCKER_CERT_PATH=/certs/client \
  --env DOCKER_TLS_VERIFY=1 \
  --publish 8080:8080 \
  --publish 50000:50000 \           # 	( Optional )
  --volume jenkins-data:/var/jenkins_home \
  --volume jenkins-docker-certs:/certs/client:ro \
  myjenkins-blueocean:1.1 
```

> Note: If copying and pasting the command snippet above does not work, try copying and pasting this annotation-free version here:

```shell
docker run --name jenkins-blueocean --rm --detach \
  --network jenkins --env DOCKER_HOST=tcp://docker:2376 \
  --env DOCKER_CERT_PATH=/certs/client --env DOCKER_TLS_VERIFY=1 \
  --publish 8080:8080 --publish 50000:50000 \
  --volume jenkins-data:/var/jenkins_home \
  --volume jenkins-docker-certs:/certs/client:ro \
  myjenkins-blueocean:1.1
```
  Proceed to the Post-installation setup wizard.

