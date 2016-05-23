#
# Copyright 2016 Stephen Street <stephen@redrocketcomputing.com>
# 
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/. 
#

ifeq (${.DEFAULT_GOAL},)
	.DEFAULT_GOAL := all
endif

ifeq ("$(origin V)", "command line")
	VERBOSE = ${V}
endif

ifndef VERBOSE
	VERBOSE = 0
endif

ifeq (${VERBOSE},1)
 	quiet =
 	Q =
else
 	quiet = (${1})
 	Q = @
endif

export QT_PATH ?= /opt/Qt/5.5/gcc_64/bin/
export TOOLCHAIN_PATH ?=${PROJECT_ROOT}/local/bin/
export BUILD_ROOT ?= ${PROJECT_ROOT}/build
export IMAGE_ROOT ?= ${PROJECT_ROOT}/images
export INSTALL_ROOT ?= ${PROJECT_ROOT}/root 

export MAKE_JOBS ?= $(shell grep --count ^processor /proc/cpuinfo)

ifeq ($(shell which arm-none-eabi-gcc),)
	export PATH := ${TOOLCHAIN_PATH}:${QT_PATH}:${PATH}
endif

FIND ?= find
