#cd jni ; ndk-build APP_OPTIM=debug NDK_DEBUG=1 ; cd .. ; ant uninstall debug && ant installd && ./run.sh
ant clean && cd jni && ndk-build && cd .. && ant debug install && ./run.sh

