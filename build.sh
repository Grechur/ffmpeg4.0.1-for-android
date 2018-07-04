#!/bin/bash
NDK=/home/zz/android-ndk-r14b
SYSROOT=$NDK/platforms/android-14/arch-arm/
CPU=armv7-a
TOOLCHAIN=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64
PREFIX=$(pwd)/android/$CPU
ADDI_CFLAGS="-marm"
OPTIMIZE_CFLAGS="-mfloat-abi=softfp -mfpu=vfp -marm -march=$CPU "

function build_android
{
./configure \
--prefix=$PREFIX \
--enable-neon \
--enable-hwaccels \
--enable-shared \
--enable-jni \
--enable-mediacodec \
--enable-decoder=h264_mediacodec \
--disable-static \
--disable-doc \
--enable-ffmpeg \
--disable-ffplay \
--disable-ffprobe \
--enable-avdevice \
--disable-doc \
--disable-symver \
--cross-prefix=$TOOLCHAIN/bin/arm-linux-androideabi- \
--target-os=android \
--arch=arm \
--cpu=armv7-a \
--enable-cross-compile \
--sysroot=$SYSROOT \
--extra-cflags="-Os -fpic $ADDI_CFLAGS" \
--extra-ldflags="$ADDI_LDFLAGS" \
$ADDITIONAL_CONFIGURE_FLAG
}
build_android
