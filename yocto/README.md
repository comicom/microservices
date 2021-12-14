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

## Linux for Embedded System


## Bitbake

http://git.openembedded.org/bitbake

* Bitbake는 Make 및 Ant(아파치 엔트)와 호환되는 빌드 도구
* Portage의 파생, Portage는 젠투 리눅스 배포판에서 사용하는 빌드 및 패키지 관리 시스템
* yocto의 poky를 사용할 때는 poky의 메타 데이터와 알맞은 bitbake 버전이 포함되어 있음

## Bitbake Hello World

기본 구성은 다음과 같다.

```
bbhello/
├── class
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


```
bitbake -h

bitbake-layers -h
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



