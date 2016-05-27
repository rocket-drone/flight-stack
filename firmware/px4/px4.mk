#
# Copyright 2016 Stephen Street <stephen@redrocketcomputing.com>
# 
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/. 
#
ifeq ($(findstring ${BUILD_ROOT},${CURDIR}),)
include ${PROJECT_ROOT}/tools/makefiles/target.mk
else

include ${PROJECT_ROOT}/tools/makefiles/common.mk

PX4_PATH := $(subst ${PROJECT_ROOT}/,${PROJECT_ROOT}/src/,${SOURCE_DIR})
#OPENTX_CMAKELIST := $(shell find ${OPENTX_PATH} -name "CMakeLists.txt")
PX4_DEPS := $(shell find ${PX4_PATH} -type f) 

all: ${INSTALL_ROOT}/firmware/nuttx-px4fmu-v4-default.px4

clean: 
	@echo "CLEANING: ${CURDIR}"
	$(Q)${MAKE} -j ${MAKE_JOBS} clean

${INSTALL_ROOT}/firmware/nuttx-px4fmu-v4-default.px4: src/firmware/nuttx/nuttx-px4fmu-v4-default.px4
	@echo "INSTALLING: $@"
	$(Q)${MAKE} -j ${MAKE_JOBS} install
	$(Q)touch ${INSTALL_ROOT}/firmware/nuttx-px4fmu-v4-default.px4

src/firmware/nuttx/nuttx-px4fmu-v4-default.px4: Makefile
	@echo "BUILDING: $@"
	$(Q)${MAKE} -j ${MAKE_JOBS}

Makefile: 
	@echo "CONFIGURING: $@"
	$(Q)cmake ${PX4_PATH} -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX=${INSTALL_ROOT}/firmware -DCONFIG=nuttx_px4fmu-v4_default

endif