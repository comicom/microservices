# YOCTO

https://www.yoctoproject.org/

## what is Yocto?

### backgroud

![Linux-and-RTOS](https://github.com/comicom/microservices/blob/main/yocto/images/01_LinuxandRTOS.png)

* Porting
  * Microsoft, Apple, UNIX과 같은, 다른 플랫폼에 application을 이식하는 것
  * Andorid 버전을 > iOS 버전으로 바꾸는 것
  * In Embedded platform
    * consumer
    * mobile (Android)
    * network (CGL Linux | RTOS)
    * automotive (AGL Linux | RTOS)
    * aerospace & defense (RTOS)
    * ...
  * (bootloader(coding) + kernel(coding) + rootfile system + library + application(coding) ) → package
  * source code download(fetch) → unpack → patch → configure → compile → install → package
* Converting
  * Linux 환경에서 C++로 만든 것 > JAVA로 개발언어 변경

### contents

Porting을 진행하면서 규칙을 발견했다. 이를 Automation 한 것이 Yocto이다.

Yocto는 Embedded 환경에 맞춰서 Porting을 진행한 Custom Linux를 쉽게 배포할 수 있도록 하는 도구이다.

![YoctoDevelopmentEnvironment2.png](https://github.com/comicom/microservices/blob/main/yocto/images/02_YoctoDevelopmentEnvironment2.png)

![YoctoDevelopmentEnvironment3.png](https://github.com/comicom/microservices/blob/main/yocto/images/02_YoctoDevelopmentEnvironment3.png)

#### OpenEmbedded-Core
OpenEmbedded project와 공유되는 core meta data, base layer 묶음. OpenEmbedded project는http://openembedded.org를 home page 로하는 별도의 build system으로, 이것만 가지고도 linux 배포 판을 만들 수 있을 정도로 매우 강력함. 
 
#### Poky
Yocto project의 reference system으로, 다양한 tool과 meta data 로 이루어짐. 여기에 자신만의 target board 에 대한 내용 을 추가해 줌으로써 최종적으로 원하는 linux system을 만들어 낼 수 있음. 포키 프로젝트가 안정된 비트베이크를 포함하고 있음.

    * L Meta data, 아래 세 가지를 일컬어 meta data라고함.    
        - ★ **Recipes** ( .bb - bitbake ) :
          - the logical units of software/images to build
          - buildroot의 package에해당하는내용.
          - source download -> build -> install 관련내용을기술하고있음.
          - BitBake가이내용을보 고, 실제 action을취하게됨.
        - ★ **Classes** ( .bbclass ) : abstraction to common code(task)    
        - ★ **Configuration files** ( .conf ) : global definitions of variables
    * L Poky Meta Data 구성
        - meta : 아키텍쳐 관련  메타 데이터 -arm,x86,mips,powerpc, qemu
        - meta-yocto : 포키 배포한 특화 메타 데이터
        - meta-yocto-bsp : 레퍼런스 하드웨어 개발보드에 대한 bsp 메타데이터
        - ★ **meta-skeleton** : 레이어 탬플릿 디렉토리
        - ★ **meta 데이터에 포함된 recipes 조회** : ls meta*/recipes*/images/*.bb
 
#### BitBake
python과 shell script 로 만들어진 task scheduler로써, Recipes 를 읽어 build하고자하는 source를 download하고, build한후, 최종 install 하기 까지의 전 과정을 담당함. Make 와 유사하다고 볼 수도 있겠으나, 실제로는 규모면에서 차이가 있음

## Linux for Embedded System

![YoctoDevelopmentEnvironment.png](https://github.com/comicom/microservices/blob/main/yocto/images/02_YoctoDevelopmentEnvironment.png)

### 개발자의 역할

1. 개발자가 빌드 스크립트를 작성한다. 
    - Metadata(.bb + patches) 파일들을 작성한다.
    - Yocto로 개발시 개발자가 주로 하는 일이다.

2. 환경설정, Machine 등을 설정한다
    - Machine(BSP) configuration, Policy Configuration, User Configuration. 주로 build 환경 설정 후 conf폴더 내의 .conf 파일들을 수정하는 작업을 말한다.
    - 개발자가 작성/다운 받은 레시피들 중에서 어떤 machine 환경에서 빌드할 것인지 설정하는 작업이다.

3. bitbake 명령어로 빌드한다
    - 작성한 Metadata 파일과 설정 환경에 따라서 Yocto를 구동시킨다. 여기까지가 개발자가 하는 일이다.
    - 중간에 문제가 없으면 나머지는 yocto가 알아서 해준다.

### Yocto의 역할

1. 소스 코드를 받아온다.
    - Metadata에 .bb 파일을 보면 SRC_URI가 있고 여기에 주소가 입력되어 있다.
    - 이건 위 주소에서 파일들을 받아오라는 뜻이다. 

2. 패치를 적용한다. 
    - Patch Application, SRC_URI에 가끔 file://somepatch.patch 로 패치파일이 들어가 있는 경우가 있다.
    - 이건 소스를 받고 패치 파일을 적용하라는 뜻이다. 

3. Config 파일 만들고 빌드 시작
    - Configuration/Compile 리눅스를 컴파일 할 때를 생각해보면 먼저 config 파일을 만들고 다음 그 config 파일을 토대로 compile을 한다. 이것도 똑같다.
    - 1, 2에서 받아온 소스코드들을 가지고 configuration 작업을 하고 compile을 하는 것이다. 
    - 리눅스 같은 OS 코드 뿐만 아니라 gcc 컴파일러도 받아온다.

4. 생성된 package 파일들 분석
    - 만들어진 파일들을 분석해 package 형태로 만든다. 그리고 각각의 연관 관계를 분석한다.

5. Generation
    - 만들어지 파일들을 ipk, rpm, deb 파일의 형태로 만든다.
    - 어디든 쉽게 적용 할 수 있게 압축된 형태로 제공하는 것이다.

6. 이미지 생성
    - 만들어진 파일들을 모두 통합해서 통합 이미지를 만든다.
    - 이 이미지는 아까 개발자가 입력한 Machine에 빌드 할 수 있는 이미지이다.

### Yocto 작업 순서

1. Poky reference system 을 준비(download & 환경설정) 한다. 
2. 자신의 target board에맞는 BSP layer를 하나 만든다. 혹은 기존에 존재하는 내용이 있다면 이를 이용(혹은개선)한다. 
3. (필요하다고 판단이 될 경우) 기존에 다른 사람들이 만들어둔 여러 layer(meta-XXXX) 를 찾아 download 한다. 
4. 자신의 target board에맞는 general layer를 만든다. (역시 필요할 경우)    
     * conf file & meta data 를 적절히 준비(수정)해 둔다.    
     * 추가로 필요한 recipe를 만들어 둔다. 
5. bitbake - fetch
     * Recipe 파일을 토대로 build에 필요한 모든 source code를 download 한다. 
     * Source code 에 대한 patch가 존재할 경우 관련 fetch 를 진행한다. 
6. bitbake - configure & compile
     * configure & compile을진행한다. 
7. bitbake - install
     * install 을한다. 
8. bitbake - package
     * build가 정상적으로 진행될 경우, package 파일(RPM, ipk 등)을생성한다. 
9. booting에 필요한 이미지(kernel, rootfs 등)를 생성한다.

## Bitbake

http://git.openembedded.org/bitbake

https://docs.yoctoproject.org/bitbake/bitbake-user-manual/bitbake-user-manual-intro.html#concepts

* Bitbake는 Make 및 Ant(아파치 엔트)와 호환되는 빌드 도구
* Portage의 파생, Portage는 젠투 리눅스 배포판에서 사용하는 빌드 및 패키지 관리 시스템
* yocto의 poky를 사용할 때는 poky의 메타 데이터와 알맞은 bitbake 버전이 포함되어 있음

### bitbake -h
```shell
Usage: bitbake [options] [recipename/target recipe:do_task ...]
```

### bitbake-layers -h
```shell
NOTE: Starting bitbake server...
usage: bitbake-layers [-d] [-q] [-F] [--color COLOR] [-h] <subcommand> ...

BitBake layers utility

optional arguments:
  -d, --debug           Enable debug output
  -q, --quiet           Print only errors
  -F, --force           Force add without recipe parse verification
  --color COLOR         Colorize output (where COLOR is auto, always, never)
  -h, --help            show this help message and exit

subcommands:
  <subcommand>
    add-layer           Add one or more layers to bblayers.conf.
    remove-layer        Remove one or more layers from bblayers.conf.
    flatten             flatten layer configuration into a separate output
                        directory.
    layerindex-fetch    Fetches a layer from a layer index along with its
                        dependent layers, and adds them to conf/bblayers.conf.
    layerindex-show-depends
                        Find layer dependencies from layer index.
    show-layers         show current configured layers.
    show-overlayed      list overlayed recipes (where the same recipe exists
                        in another layer)
    show-recipes        list available recipes, showing the layer they are
                        provided by
    show-appends        list bbappend files and recipe files they apply to
    show-cross-depends  Show dependencies between recipes that cross layer
                        boundaries.
    create-layer        Create a basic layer

Use bitbake-layers <subcommand> --help to get help on a specific command
```

## Bitbake Hello World

https://docs.yoctoproject.org/bitbake/bitbake-user-manual/bitbake-user-manual-hello.html

기본 구성은 다음과 같다.

```shell
hello/
├── classes
│   └── base.bbclass
├── conf
│   ├── bblayers.conf
│   └── bitbake.conf
└── meta-hello
    ├── conf
    │   └── layer.conf
    └── recipes-editor
        └── nano
```

1. Create a Project Directory

```shell
mkdir ~/hello
cd ~/hello
```

2. Setting BBPATH

conf/bblayers.conf와 관련이 깊다.

```shell
export BBPATH="projectdirectory"
```

> poky에서 'source oe-init-build-env'를 이용하면 BBPATH가 자동으로 잡힘
> 'echo $BBPATH'를 이용하여 확인할 수 있음

3. Creating conf/bitbake.conf

**conf/bitbake.conf**

includes a number of configuration variables BitBake uses for metadata and recipe files. For this example, you need to create the file in your project directory and define some key BitBake variables.

```shell
mkdir conf
cd conf
vim bitbake.conf
```

```python
PN  = "${@bb.parse.vars_from_file(d.getVar('FILE', False),d)[0] or 'defaultpkgname'}"

TMPDIR  = "${TOPDIR}/tmp"
CACHE   = "${TMPDIR}/cache"
STAMP   = "${TMPDIR}/${PN}/stamps"
T       = "${TMPDIR}/${PN}/work"
B       = "${TMPDIR}/${PN}"
```

```shell
cd ../
```

example: https://git.openembedded.org/bitbake/tree/conf/bitbake.conf

4. Creating classes/base.bbclass

BitBake uses class files to provide common code and functionality. The minimally required class for BitBake is the classes/base.bbclass file.

```shell
mkdir classes
```

5. Creating a Layer

```shell
mkdir mylayer
cd my layer
mkdir conf
vim layer.conf
```

``` python
BBPATH .= ":${LAYERDIR}"
BBFILES += "${LAYERDIR}/*.bb"
BBFILE_COLLECTIONS += "mylayer"
BBFILE_PATTERN_mylayer := "^${LAYERDIR_RE}/"
```

## Board Surport Package (BSP)

Yocto의 하드웨어 지원

리눅스 커널 및 루트 파일시스템 이미지 생성을 위해 사용된다.

### BSP 레이어 예시

* meta-fsl-arm
* meta-fsl-ppc
* meta-fsl-intel
* meta-fsl-intel-galileo
* meta-minnow
* meta-raspberrypi
* meta-renesas
* meta-ti
* meta-xilinx
* meta-zynq

### 

https://www.yoctoproject.org/software-overview/downloads/

https://github.com/topics/yocto-project

