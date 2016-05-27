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

QGROUNDCONTROL_PATH := $(subst ${PROJECT_ROOT}/,${PROJECT_ROOT}/src/,${SOURCE_DIR})
QGROUNDCONTROL_DEPS := $(shell find ${QGROUNDCONTROL_PATH} -type f) 
QMAKE := ${QT_PATH}/bin/qmake

all: ${INSTALL_ROOT}/bin/qgroundcontrol

clean: 
	@echo "CLEANING: ${CURDIR}"
	$(Q)${MAKE} clean

${INSTALL_ROOT}/bin/qgroundcontrol: release/qgroundcontrol
	@echo "INSTALLING: $@"
	$(Q)${MAKE} INSTALL_ROOT= BUILD_ROOT= IMAGE_ROOT= PROJECT_ROOT= install

release/qgroundcontrol: Makefile ${QGROUNDCONTROL_DEPS}
	@echo "BUILDING: $@"
	$(Q)${MAKE} -j ${MAKE_JOBS} INSTALL_ROOT= BUILD_ROOT= IMAGE_ROOT= PROJECT_ROOT= 

Makefile: ${QGROUNDCONTROL_PATH}/qgroundcontrol.pro
	@echo "CONFIGURING: $@"
	$(Q)${QMAKE} -r PREFIX=${INSTALL_ROOT} "CONFIG+=silent" ${QGROUNDCONTROL_PATH}/qgroundcontrol.pro

${QGROUNDCONTROL_DEPS}:

endif