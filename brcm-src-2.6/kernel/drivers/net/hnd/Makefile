#
# Makefile for Broadcom Home Networking Division (HND) shared driver code
#
# Copyright (C) 2008, Broadcom Corporation
# All Rights Reserved.
# 
# THIS SOFTWARE IS OFFERED "AS IS", AND BROADCOM GRANTS NO WARRANTIES OF ANY
# KIND, EXPRESS OR IMPLIED, BY STATUTE, COMMUNICATION OR OTHERWISE. BROADCOM
# SPECIFICALLY DISCLAIMS ANY IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A SPECIFIC PURPOSE OR NONINFRINGEMENT CONCERNING THIS SOFTWARE.
#
# $Id: Makefile,v 1.5 2008/05/02 22:49:54 Exp $
#

SHARED   := ../../../../../shared
ROUTER   := ../../../../../router
SRC      := ../../../../../../src
WLSHARED := wlconfig_lx_shared
WLCFGDIR := $(src)/../../../../../wl/config
WLSYSDIR := $(src)/../../../../../wl/sys

ifneq ($(wildcard $(WLCFGDIR)),)
include $(WLCFGDIR)/$(WLSHARED)
include $(WLCFGDIR)/wl.mk
endif

hnd-objs := $(addprefix $(SHARED)/, $(sort $(WLFILES:.c=.o)))
HND_OBJS := $(addprefix $(src)/$(SHARED)/, $(sort $(WLFILES:.c=.o)))

EXTRA_CFLAGS += $(WLFLAGS) -DBCM5354 -DLINUX_HYBRID_POSTPROCESSING_REMOVAL

ifneq ($(CONFIG_BCM947XX),y)
HND_OBJS += $(src)/$(SHARED)/nvramstubs.o
hnd-objs += $(SHARED)/nvramstubs.o
endif

ifeq ($(CONFIG_ET_47XX),y)
HND_OBJS += $(src)/$(SHARED)/bcmrobo.o
hnd-objs += $(SHARED)/bcmrobo.o
else
ifeq ($(CONFIG_BCM57XX),y)
HND_OBJS += $(src)/$(SHARED)/bcmrobo.o
hnd-objs += $(SHARED)/bcmrobo.o
endif
endif

ifdef CONFIG_USB_RNDIS
EXTRA_CFLAGS += -DCONFIG_USBRNDIS_RETAIL
endif

ifeq ($(BCMDBG_MEM),1)
EXTRA_CFLAGS += -DBCMDBG_MEM
endif

obj-$(CONFIG_HND) := hnd.o shared_ksyms.o

clean-files := shared_ksyms.c

#ifdef BCMDBG
EXP_OBJS := $(HND_OBJS)
#else
EXP_OBJS := $(filter-out $(src)/$(SHARED)/aiutils.o $(src)/$(SHARED)/sbutils.o \
 $(src)/$(SHARED)/nicpci.o \
 ,$(HND_OBJS))
#endif

ifeq ($(wildcard $(src)/$(SHARED)/bcmutils.c),)
$(src)/$(SHARED)/bcmutils.o: $(src)/$(SHARED)/linux/bcmutils.o
	cp $< $@
endif

ifeq ($(wildcard $(src)/$(SHARED)/bcmrobo.c),)
$(src)/$(SHARED)/bcmrobo.o: $(src)/$(SHARED)/linux/bcmrobo.o
	cp $< $@
endif

ifeq ($(wildcard $(src)/$(SHARED)/hnddma.c),)
$(src)/$(SHARED)/hnddma.o: $(src)/$(SHARED)/linux/hnddma.o
	cp $< $@
endif

ifeq ($(wildcard $(src)/$(SHARED)/linux_osl.c),)
$(src)/$(SHARED)/linux_osl.o: $(src)/$(SHARED)/linux/linux_osl.o
	cp $< $@
endif

ifeq ($(wildcard $(src)/$(SHARED)/sbutils.c),)
$(src)/$(SHARED)/sbutils.o: $(src)/$(SHARED)/linux/sbutils.o
	cp $< $@
endif

ifeq ($(wildcard $(src)/$(SHARED)/hndpmu.c),)
$(src)/$(SHARED)/hndpmu.o: $(src)/$(SHARED)/linux/hndpmu.o
	cp $< $@
endif

ifeq ($(wildcard $(src)/$(SHARED)/bcmsrom.c),)
$(src)/$(SHARED)/bcmsrom.o: $(src)/$(SHARED)/linux/bcmsrom.o
	cp $< $@
endif

ifeq ($(wildcard $(src)/$(SHARED)/nvramstubs.c),)
$(src)/$(SHARED)/nvramstubs.o: $(src)/$(SHARED)/linux/nvramstubs.o
	cp $< $@
endif

ifeq ($(wildcard $(src)/$(SHARED)/bcmwpa.c),)
$(src)/$(SHARED)/bcmwpa.o: $(src)/$(SHARED)/linux/bcmwpa.o
	cp $< $@
endif

ifeq ($(wildcard $(src)/$(SHARED)/bcmotp.c),)
$(src)/$(SHARED)/bcmotp.o: $(src)/$(SHARED)/linux/bcmotp.o
	cp $< $@
endif

ifeq ($(wildcard $(src)/$(SHARED)/nicpci.c),)
$(src)/$(SHARED)/nicpci.o: $(src)/$(SHARED)/linux/nicpci.o
	cp $< $@
endif

$(src)/shared_ksyms.c: $(src)/shared_ksyms.sh $(EXP_OBJS)
	sh -e $< $(EXP_OBJS) > $@