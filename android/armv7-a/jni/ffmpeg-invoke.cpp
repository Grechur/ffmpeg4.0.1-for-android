#include <jni.h>
#include <string>
#include "android/log.h"

extern "C"{
#include "ffmpeg.h"
}

#define LOGD(...) __android_log_print(ANDROID_LOG_DEBUG  , "ffmpeg-invoke", __VA_ARGS__)


extern "C"
JNIEXPORT jstring JNICALL
Java_com_grechur_testjni_FFmpegInvoke_test(JNIEnv *env, jclass type) {

    std::string retValue = "FFmpeg invoke test";
    return env->NewStringUTF(retValue.c_str());
}

extern "C"
JNIEXPORT jint JNICALL
Java_com_grechur_testjni_FFmpegInvoke_run(JNIEnv *env, jclass type, jint cmdLen,
                                                       jobjectArray cmd) {

    char *argCmd[cmdLen] ;
    jstring buf[cmdLen];
    LOGD("length=%d",cmdLen);

    for (int i = 0; i < cmdLen; ++i) {
        buf[i] = static_cast<jstring>(env->GetObjectArrayElement(cmd, i));
        char *string = const_cast<char *>(env->GetStringUTFChars(buf[i], JNI_FALSE));
        argCmd[i] = string;
        LOGD("argCmd=%s",argCmd[i]);
    }

    ffmpeg_exec(cmdLen, argCmd);

    return 0;

}