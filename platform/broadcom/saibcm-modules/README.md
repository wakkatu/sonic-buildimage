# How to build SONiC opennsl-modules

## Get source of `opennsl-modules` from `sonic-buildimage`

The branch/commit of `sonic-buildimage` is dependent on the version of libsaibcm.

    git clone -b 202006-sdk-6.5.17-onl https://github.com/wakkatu/sonic-buildimage.git

## Build `opennsl-modules` package in ONL docker

Before building `opennsl-modules`, you should have completed `make amd64`.

    sonic-buildimage/platform/broadcom/saibcm-modules/build.sh
