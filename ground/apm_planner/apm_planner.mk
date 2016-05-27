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

APM_PLANNER_PATH := $(subst ${PROJECT_ROOT}/,${PROJECT_ROOT}/src/,${SOURCE_DIR})
APM_PLANNER_DEPS := $(shell find ${APM_PLANNER_PATH} -type f) 
QMAKE := ${QT_PATH}/bin/qmake

all: ${INSTALL_ROOT}/bin/apmplanner2

clean: 
	@echo "CLEANING: ${CURDIR}"
	$(Q)${MAKE} clean

${INSTALL_ROOT}/bin/apmplanner2: release/apmplanner2
	@echo "INSTALLING: $@"
	$(Q)${MAKE} INSTALL_ROOT= BUILD_ROOT= IMAGE_ROOT= PROJECT_ROOT= install

release/apmplanner2: Makefile
	@echo "BUILDING: $@"
	$(Q)${MAKE} -j ${MAKE_JOBS} INSTALL_ROOT= BUILD_ROOT= IMAGE_ROOT= PROJECT_ROOT= 

Makefile: ${APM_PLANNER_PATH}/qgroundcontrol.pro
	@echo "CONFIGURING: $@"
	$(Q)${QMAKE} -r PREFIX=${INSTALL_ROOT} "CONFIG+=silent" ${APM_PLANNER_PATH}/qgroundcontrol.pro

${APM_PLANNER_DEPS}:

endif