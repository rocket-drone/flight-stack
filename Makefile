#
# Copyright 2016 Stephen Street <stephen@redrocketcomputing.com>
# 
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/. 
#

export PROJECT_ROOT ?= ${CURDIR}

targets: firmware ground

include ${PROJECT_ROOT}/tools/makefiles/tree.mk 

distclean:
	@echo "DISTCLEAN: ${BUILD_ROOT} ${IMAGE_ROOT} ${INSTALL_ROOT}"
	$(Q)rm -rf ${BUILD_ROOT} ${IMAGE_ROOT} ${INSTALL_ROOT}

realclean: distclean
	@echo "REALCLEAN: doing nothing"

