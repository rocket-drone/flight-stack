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

ARDUPILOT_PATH := $(subst ${PROJECT_ROOT}/,${PROJECT_ROOT}/src/,${SOURCE_DIR})
#OPENTX_CMAKELIST := $(shell find ${OPENTX_PATH} -name "CMakeLists.txt")
ARDUPILOT_DEPS := $(shell find ${ARDUPILOT_PATH} -type f) 

all: px4-v4/bin/arducopter-quad.px4

clean: 
	@echo "CLEANING: ${CURDIR}"
	$(Q)${MAKE} -j ${MAKE_JOBS} clean

#${INSTALL_ROOT}/firmware/nuttx-ARDUPILOTfmu-v4-default.ARDUPILOT: src/firmware/nuttx/nuttx-ARDUPILOTfmu-v4-default.ARDUPILOT
#	@echo "INSTALLING: $@"
#	$(Q)${MAKE} -j ${MAKE_JOBS} install
#	$(Q)touch ${INSTALL_ROOT}/firmware/nuttx-ARDUPILOTfmu-v4-default.ARDUPILOT

#src/firmware/nuttx/nuttx-ARDUPILOTfmu-v4-default.ARDUPILOT: Makefile
#	@echo "BUILDING: $@"
#	$(Q)${MAKE} -j ${MAKE_JOBS}

px4-v4/bin/arducopter-quad.px4: config.log
	${ARDUPILOT_PATH}/modules/waf/waf-light

config.log: 
	@echo "CONFIGURING: $@"
	$(Q)cd ${ARDUPILOT_PATH} && ./modules/waf/waf-light configure --out=${CURDIR} --board=px4-v4

endif