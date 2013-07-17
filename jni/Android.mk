LOCAL_PATH := $(call my-dir)

OGG_SRC_PATH 	:= libogg-1.3.1/
VORBIS_SRC_PATH	:= libvorbis-1.3.3/
OPENAL_SRC_PATH := openal-soft-android/
LUA_SRC_PATH 	:= lua-5.2.2/
GLEW_SRC_PATH	:= glew-1.9.0/

#libogg
include $(CLEAR_VARS)
LOCAL_MODULE 	:= libogg
LOCAL_CFLAGS 	:= -fexceptions -g -Dlinux -DFT2_BUILD_LIBRARY=1 -DPHYSFS_NO_CDROM_SUPPORT=1 -DAL_ALEXT_PROTOTYPES=1 -DHAVE_GCC_DESTRUCTOR=1 -DOPT_GENERIC -DREAL_IS_FLOAT
LOCAL_CPPFLAGS	:= $(LOCAL_CFLAGS)
LOCAL_C_INCLUDES := $(LOCAL_PATH)/$(OGG_SRC_PATH)/include
LOCAL_SRC_FILES := \
	$(OGG_SRC_PATH)src/framing.c \
	$(OGG_SRC_PATH)src/bitwise.c
LOCAL_LDLIBS	:= -llog -lGLESv1_CM
include $(BUILD_SHARED_LIBRARY)

#libvoribs
include $(CLEAR_VARS)
LOCAL_MODULE	:= libvorbis
LOCAL_CFLAGS	:= -g -Dlinux -DFT2_BUILD_LIBRARY=1 -DPHYSFS_NO_CDROM_SUPPORT=1 -DAL_ALEXT_PROTOTYPES=1 -DHAVE_GCC_DESTRUCTOR=1 -DOPT_GENERIC -DREAL_IS_FLOAT
LOCAL_CPPFLAGS	:= $(LOCAL_CFLAGS)
LOCAL_C_INCLUDES := $(LOCAL_PATH)/$(VORBIS_SRC_PATH)/include \
	$(LOCAL_PATH)/$(OGG_SRC_PATH)/include
	
LOCAL_SRC_FILES := \
	${VORBIS_SRC_PATH}lib/mdct.c \
	${VORBIS_SRC_PATH}lib/smallft.c \
	${VORBIS_SRC_PATH}lib/block.c \
	${VORBIS_SRC_PATH}lib/envelope.c \
	${VORBIS_SRC_PATH}lib/window.c \
	${VORBIS_SRC_PATH}lib/lsp.c \
	${VORBIS_SRC_PATH}lib/lpc.c \
	${VORBIS_SRC_PATH}lib/analysis.c \
	${VORBIS_SRC_PATH}lib/synthesis.c \
	${VORBIS_SRC_PATH}lib/psy.c \
	${VORBIS_SRC_PATH}lib/info.c \
	${VORBIS_SRC_PATH}lib/floor1.c \
	${VORBIS_SRC_PATH}lib/floor0.c \
	${VORBIS_SRC_PATH}lib/res0.c \
	${VORBIS_SRC_PATH}lib/mapping0.c \
	${VORBIS_SRC_PATH}lib/registry.c \
	${VORBIS_SRC_PATH}lib/codebook.c \
	${VORBIS_SRC_PATH}lib/sharedbook.c \
	${VORBIS_SRC_PATH}lib/lookup.c \
	${VORBIS_SRC_PATH}lib/bitrate.c \
	${VORBIS_SRC_PATH}lib/vorbisfile.c 
LOCAL_LDLIBS    := -llog -L../lib -lGLESv1_CM
LOCAL_SHARED_LIBRARIES := libogg
include $(BUILD_SHARED_LIBRARY)

#libopenal
include $(CLEAR_VARS)
LOCAL_MODULE	:= libopenal
LOCAL_CFLAGS	:= -g -Dlinux -DFT2_BUILD_LIBRARY=1 -DPHYSFS_NO_CDROM_SUPPORT=1 -DAL_ALEXT_PROTOTYPES=1 -DHAVE_GCC_DESTRUCTOR=1 -DOPT_GENERIC -DREAL_IS_FLOAT
LOCAL_CPPFLAGS  := ${LOCAL_CFLAGS}
LOCAL_C_INCLUDES := \
	$(LOCAL_PATH)/${OPENAL_SRC_PATH}include/ \
	$(LOCAL_PATH)/${OPENAL_SRC_PATH}OpenAL32/Include \
	$(LOCAL_PATH)/${OPENAL_SRC_PATH}
LOCAL_SRC_FILES := \
	${OPENAL_SRC_PATH}OpenAL32/alAuxEffectSlot.c \
	${OPENAL_SRC_PATH}OpenAL32/alBuffer.c \
	${OPENAL_SRC_PATH}OpenAL32/alEffect.c \
	${OPENAL_SRC_PATH}OpenAL32/alError.c \
	${OPENAL_SRC_PATH}OpenAL32/alExtension.c \
	${OPENAL_SRC_PATH}OpenAL32/alFilter.c \
	${OPENAL_SRC_PATH}OpenAL32/alListener.c \
	${OPENAL_SRC_PATH}OpenAL32/alSource.c \
	${OPENAL_SRC_PATH}OpenAL32/alState.c \
	${OPENAL_SRC_PATH}OpenAL32/alThunk.c \
	${OPENAL_SRC_PATH}Alc/ALc.c \
	${OPENAL_SRC_PATH}Alc/ALu.c \
	${OPENAL_SRC_PATH}Alc/alcConfig.c \
	${OPENAL_SRC_PATH}Alc/alcDedicated.c \
	${OPENAL_SRC_PATH}Alc/alcEcho.c \
	${OPENAL_SRC_PATH}Alc/alcModulator.c \
	${OPENAL_SRC_PATH}Alc/alcReverb.c \
	${OPENAL_SRC_PATH}Alc/alcRing.c \
	${OPENAL_SRC_PATH}Alc/alcThread.c \
	${OPENAL_SRC_PATH}Alc/bs2b.c \
	${OPENAL_SRC_PATH}Alc/helpers.c \
	${OPENAL_SRC_PATH}Alc/hrtf.c \
	${OPENAL_SRC_PATH}Alc/mixer.c \
	${OPENAL_SRC_PATH}Alc/panning.c \
	${OPENAL_SRC_PATH}Alc/backends/loopback.c \
	${OPENAL_SRC_PATH}Alc/backends/null.c \
	${OPENAL_SRC_PATH}Alc/backends/android.c \
	${OPENAL_SRC_PATH}Alc/backends/wave.c
LOCAL_LDLIBS    := -llog -L../lib -lGLESv1_CM
LOCAL_SHARED_LIBRARIES :=  \

include $(BUILD_SHARED_LIBRARY)


#liblua5.2
include $(CLEAR_VARS)
LOCAL_MODULE	:= liblua5.2
LOCAL_CFLAGS 	:= $(JNI_CFLAGS)
LOCAL_CPPFLAGS  := ${LOCAL_CFLAGS}
LOCAL_C_INCLUDES  :=  \
	${LUA_SRC_PATH}src 
LOCAL_SRC_FILES := \
	$(LUA_SRC_PATH)src/lapi.c \
				$(LUA_SRC_PATH)src/lauxlib.c \
				$(LUA_SRC_PATH)src/lbaselib.c \
				$(LUA_SRC_PATH)src/lbitlib.c \
				$(LUA_SRC_PATH)src/lcode.c \
				$(LUA_SRC_PATH)src/lcorolib.c \
				$(LUA_SRC_PATH)src/lctype.c \
				$(LUA_SRC_PATH)src/ldblib.c \
				$(LUA_SRC_PATH)src/ldebug.c \
				$(LUA_SRC_PATH)src/ldo.c \
				$(LUA_SRC_PATH)src/ldump.c \
				$(LUA_SRC_PATH)src/lfunc.c \
				$(LUA_SRC_PATH)src/lgc.c \
				$(LUA_SRC_PATH)src/linit.c \
				$(LUA_SRC_PATH)src/liolib.c \
				$(LUA_SRC_PATH)src/llex.c \
				$(LUA_SRC_PATH)src/lmathlib.c \
				$(LUA_SRC_PATH)src/lmem.c \
				$(LUA_SRC_PATH)src/loadlib.c \
				$(LUA_SRC_PATH)src/lobject.c \
				$(LUA_SRC_PATH)src/lopcodes.c \
				$(LUA_SRC_PATH)src/loslib.c \
				$(LUA_SRC_PATH)src/lparser.c \
				$(LUA_SRC_PATH)src/lstate.c \
				$(LUA_SRC_PATH)src/lstring.c \
				$(LUA_SRC_PATH)src/lstrlib.c \
				$(LUA_SRC_PATH)src/ltable.c \
				$(LUA_SRC_PATH)src/ltablib.c \
				$(LUA_SRC_PATH)src/ltm.c \
				$(LUA_SRC_PATH)src/lundump.c \
				$(LUA_SRC_PATH)src/lvm.c \
				$(LUA_SRC_PATH)src/lzio.c \
				#$(LUA_SRC_PATH)src/luaApiHook.c
					
LOCAL_LDLIBS    := -llog -L../lib -lGLESv1_CM
LOCAL_SHARED_LIBRARIES := 

include $(BUILD_SHARED_LIBRARY)

#MANE
include $(CLEAR_VARS)
LOCAL_MODULE	:= libmane
LOCAL_CPPFLAGS += -std=c++0x
WILDCARD_LOCAL_SRC_FILES := $(wildcard $(LOCAL_PATH)/MANE/src/*.cpp) \
	$(wildcard $(LOCAL_PATH)/MANE/src/Math/*.cpp) \
	$(wildcard $(LOCAL_PATH)/MANE/MBM/src/*.cpp)
	
LOCAL_SRC_FILES	:= $(subst jni/, ,$(WILDCARD_LOCAL_SRC_FILES))
LOCAL_C_INCLUDES :=$(LOCAL_PATH)/MANE/include \
	$(LOCAL_PATH)/$(OGG_SRC_PATH)include \
	$(LOCAL_PATH)/$(VORBIS_SRC_PATH)include \
	$(LOCAL_PATH)/$(OPENAL_SRC_PATH)include \
	$(LOCAL_PATH)/$(LUA_SRC_PATH)src \
	$(LOCAL_PATH)/$(GLEW_SRC_PATH)include

LOCAL_SHARED_LIBRARIES := libogg libvorbis libopenal liblua5.2 
LOCAL_LDLIBS    := -llog -lGLESv2 -landroid
include $(BUILD_SHARED_LIBRARY)

#metalancer
include $(CLEAR_VARS)
LOCAL_MODULE    := libmetalancer
LOCAL_CPPFLAGS += -std=c++11
MY_LOCAL_SRC_FILES := \
		$(wildcard $(LOCAL_PATH)/metalancer/*.cpp)
LOCAL_SRC_FILES := $(subst jni/, ,$(MY_LOCAL_SRC_FILES))
LOCAL_C_INCLUDES := $(LOCAL_PATH)/MANE/include \
	$(LOCAL_PATH)/$(OGG_SRC_PATH)include \
	$(LOCAL_PATH)/$(VORBIS_SRC_PATH)include \
	$(LOCAL_PATH)/$(OPENAL_SRC_PATH)include \
	$(LOCAL_PATH)/$(LUA_SRC_PATH)src \
	$(LOCAL_PATH)/$(GLEW_SRC_PATH)include \
		
LOCAL_SHARED_LIBRARIES := \
	libmane
LOCAL_LDLIBS    := -llog -lGLESv2 -landroid

include $(BUILD_SHARED_LIBRARY)
