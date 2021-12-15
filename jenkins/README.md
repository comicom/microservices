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

#### Install Docker
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

#### Uninstall Docker

```shell
# uninstall old-version
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd
```


