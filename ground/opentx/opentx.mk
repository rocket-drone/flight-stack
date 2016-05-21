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

all: radio companion

clean: 
	@echo "CLEANING: "

radio:
	@echo "BUILDING: $@"
	
companion:
	@echo "BUILDING: $@"


endif