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

OPENTX_PATH := $(subst ${PROJECT_ROOT}/,${PROJECT_ROOT}/src/,${SOURCE_DIR})
OPENTX_CMAKELIST := $(shell find ${OPENTX_PATH} -name "CMakeLists.txt")
OPENTX_DEPS := $(shell find ${OPENTX_PATH} -path ${OPENTX_PATH}/companion/src/images/originals -prune -a -type f) 
#$(addprefix ${OPENTX_PATH}/,$(shell git -C ${OPENTX_PATH} ls-tree -r HEAD --name-only))

$(info OPENTX_PATH=${OPENTX_PATH})
#$(info OPENTX_DEPS=${OPENTX_DEPS})

all: ${INSTALL_ROOT}/bin/companion22

clean: 
	@echo "CLEANING: "
	$(Q)${MAKE} clean

${INSTALL_ROOT}/bin/companion22: opentx
	@echo "INSTALLING: $@"
	$(Q)${MAKE} -j ${MAKE_JOBS} install

opentx: Makefile ${OPENTX_DEPS} 
	@echo "BUILDING: $@"
	$(Q)${MAKE} -j ${MAKE_JOBS}

Makefile: ${OPENTX_CMAKELIST}
	@echo "CONFIGURING: $@"
	$(Q)cmake -DCMAKE_INSTALL_PREFIX=${INSTALL_ROOT} -DCMAKE_PREFIX_PATH=/opt/Qt/5.5/gcc_64 -DCMAKE_BUILD_TYPE=Release -DPCB=TARANIS -DPCBREV=REVPLUS -DHELI=YES -DLUA=YES -DWARNINGS_AS_ERRORS=YES ${OPENTX_PATH} 

${OPENTX_DEPS}:

endif