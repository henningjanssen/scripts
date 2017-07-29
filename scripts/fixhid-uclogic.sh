#!/usr/bin/env bash

rmmod hid_uclogic && insmod /lib/modules/$(uname -r)/kernel/drivers/hid/hid-uclogic.ko
