# Copyright (C) 2010 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
LOCAL_PATH := $(call my-dir)

PA_ROOT := ../..

include $(CLEAR_VARS)
LOCAL_MODULE := portaudio
LOCAL_C_INCLUDES := $(PA_ROOT)/include $(PA_ROOT)/src/common $(PA_ROOT)/src/os/unix
LOCAL_CFLAGS += -DPA_LOG_API_CALLS -DPA_LITTLE_ENDIAN -DPA_USE_OPENSLES
LOCAL_SRC_FILES :=  \
	$(PA_ROOT)/src/common/pa_converters.c \
	$(PA_ROOT)/src/common/pa_front.c \
	$(PA_ROOT)/src/common/pa_cpuload.c \
	$(PA_ROOT)/src/common/pa_debugprint.c \
	$(PA_ROOT)/src/common/pa_process.c \
	$(PA_ROOT)/src/common/pa_trace.c \
	$(PA_ROOT)/src/common/pa_ringbuffer.c \
	$(PA_ROOT)/src/common/pa_stream.c \
	$(PA_ROOT)/src/common/pa_allocation.c \
	$(PA_ROOT)/src/common/pa_dither.c \
	$(PA_ROOT)/src/os/unix/pa_unix_hostapis.c \
	$(PA_ROOT)/src/os/unix/pa_unix_util.c \
	$(PA_ROOT)/src/hostapi/opensles/pa_opensles.c

include $(BUILD_STATIC_LIBRARY)

include $(CLEAR_VARS)

LOCAL_CFLAGS += -DPA_LOG_API_CALLS
LOCAL_C_INCLUDES := $(PA_ROOT)/include 
LOCAL_MODULE    := portaudio-activity
LOCAL_SRC_FILES := main.c
LOCAL_LDLIBS    := -llog -landroid -lEGL -lGLESv1_CM -lOpenSLES
LOCAL_STATIC_LIBRARIES := android_native_app_glue portaudio

include $(BUILD_SHARED_LIBRARY)

$(call import-module,android/native_app_glue)
