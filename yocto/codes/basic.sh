git clone -b dunfell-23.0.12 https://github.com/YoeDistro/poky.git

cd poky

source oe-init-build-env

bitbake core-image-minimal

runqemu qemux86-64 nographic
