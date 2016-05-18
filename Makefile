#
# Copyright 2016 Stephen Street <stephen@redrocketcomputing.com>
# 
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/. 
#

export PROJECT_ROOT ?= ${CURDIR}

targets: ground

include ${PROJECT_ROOT}/tools/makefiles/tree.mk 

#ground:
#	+$(Q)${MAKE} -C ${PROJECT_ROOT}/ground --no-print-directory -f ground.mk ${MAKECMDGOALS}
#.PHONY: ground

#firmware:
#	+$(Q)${MAKE} -C ${PROJECT_ROOT}/firmware --no-print-directory -f firmware.mk ${MAKECMDGOALS}
#.PHONY: firmware


distclean:

realclean:
