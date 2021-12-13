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

