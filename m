Return-Path: <virtio-dev-return-8480-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A903F986527
	for <virtio-dev@lists.oasis-open.org>; Tue,  3 Aug 2021 13:11:35 +0000 (UTC)
From: Cristian Marussi <cristian.marussi@arm.com>
Date: Tue,  3 Aug 2021 14:10:17 +0100
Message-Id: <20210803131024.40280-9-cristian.marussi@arm.com>
In-Reply-To: <20210803131024.40280-1-cristian.marussi@arm.com>
References: <20210803131024.40280-1-cristian.marussi@arm.com>
Subject: [virtio-dev] [PATCH v7 08/15] firmware: arm_scmi: Make SCMI transports configurable
Content-Type: text/plain; charset="US-ASCII"
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: sudeep.holla@arm.com, james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com, etienne.carriere@linaro.org, vincent.guittot@linaro.org, souvik.chakravarty@arm.com, cristian.marussi@arm.com, igor.skalkin@opensynergy.com, peter.hilber@opensynergy.com, alex.bennee@linaro.org, jean-philippe@linaro.org, mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com, Andriy.Tryshnivskyy@opensynergy.com
List-ID: <virtio-dev.lists.oasis-open.org>

Add configuration options to be able to select which SCMI transports have
to be compiled into the SCMI stack.

Mailbox and SMC are by default enabled if their related dependencies are
satisfied.

While doing that move all SCMI related config options in their own
dedicated submenu.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
Used a BUILD_BUG_ON() to avoid the scenario where SCMI is configured
without any transport. Coul dnot do in any other way in Kconfig due to
circular dependencies.

This will be neeed later on to add new Virtio based transport and
optionally exclude other transports.

v6 --> v7
- using if ARM_SCMI_PROTOCOL to simplify depends
---
 drivers/firmware/Kconfig           | 34 +--------------
 drivers/firmware/arm_scmi/Kconfig  | 70 ++++++++++++++++++++++++++++++
 drivers/firmware/arm_scmi/Makefile |  4 +-
 drivers/firmware/arm_scmi/common.h |  4 +-
 drivers/firmware/arm_scmi/driver.c |  6 ++-
 5 files changed, 80 insertions(+), 38 deletions(-)
 create mode 100644 drivers/firmware/arm_scmi/Kconfig

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 1db738d5b301..8d41f73f5395 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -6,39 +6,7 @@
 
 menu "Firmware Drivers"
 
-config ARM_SCMI_PROTOCOL
-	tristate "ARM System Control and Management Interface (SCMI) Message Protocol"
-	depends on ARM || ARM64 || COMPILE_TEST
-	depends on MAILBOX || HAVE_ARM_SMCCC_DISCOVERY
-	help
-	  ARM System Control and Management Interface (SCMI) protocol is a
-	  set of operating system-independent software interfaces that are
-	  used in system management. SCMI is extensible and currently provides
-	  interfaces for: Discovery and self-description of the interfaces
-	  it supports, Power domain management which is the ability to place
-	  a given device or domain into the various power-saving states that
-	  it supports, Performance management which is the ability to control
-	  the performance of a domain that is composed of compute engines
-	  such as application processors and other accelerators, Clock
-	  management which is the ability to set and inquire rates on platform
-	  managed clocks and Sensor management which is the ability to read
-	  sensor data, and be notified of sensor value.
-
-	  This protocol library provides interface for all the client drivers
-	  making use of the features offered by the SCMI.
-
-config ARM_SCMI_POWER_DOMAIN
-	tristate "SCMI power domain driver"
-	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
-	default y
-	select PM_GENERIC_DOMAINS if PM
-	help
-	  This enables support for the SCMI power domains which can be
-	  enabled or disabled via the SCP firmware
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called scmi_pm_domain. Note this may needed early in boot
-	  before rootfs may be available.
+source "drivers/firmware/arm_scmi/Kconfig"
 
 config ARM_SCPI_PROTOCOL
 	tristate "ARM System Control and Power Interface (SCPI) Message Protocol"
diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
new file mode 100644
index 000000000000..a6fcd06b2232
--- /dev/null
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menu "ARM System Control and Management Interface Protocol"
+
+config ARM_SCMI_PROTOCOL
+	tristate "ARM System Control and Management Interface (SCMI) Message Protocol"
+	depends on ARM || ARM64 || COMPILE_TEST
+	help
+	  ARM System Control and Management Interface (SCMI) protocol is a
+	  set of operating system-independent software interfaces that are
+	  used in system management. SCMI is extensible and currently provides
+	  interfaces for: Discovery and self-description of the interfaces
+	  it supports, Power domain management which is the ability to place
+	  a given device or domain into the various power-saving states that
+	  it supports, Performance management which is the ability to control
+	  the performance of a domain that is composed of compute engines
+	  such as application processors and other accelerators, Clock
+	  management which is the ability to set and inquire rates on platform
+	  managed clocks and Sensor management which is the ability to read
+	  sensor data, and be notified of sensor value.
+
+	  This protocol library provides interface for all the client drivers
+	  making use of the features offered by the SCMI.
+
+if ARM_SCMI_PROTOCOL
+
+config ARM_SCMI_HAVE_TRANSPORT
+	bool
+	help
+	  This declares whether at least one SCMI transport has been configured.
+	  Used to trigger a build bug when trying to build SCMI without any
+	  configured transport.
+
+config ARM_SCMI_TRANSPORT_MAILBOX
+	bool "SCMI transport based on Mailbox"
+	depends on MAILBOX
+	select ARM_SCMI_HAVE_TRANSPORT
+	default y
+	help
+	  Enable mailbox based transport for SCMI.
+
+	  If you want the ARM SCMI PROTOCOL stack to include support for a
+	  transport based on mailboxes, answer Y.
+
+config ARM_SCMI_TRANSPORT_SMC
+	bool "SCMI transport based on SMC"
+	depends on HAVE_ARM_SMCCC_DISCOVERY
+	select ARM_SCMI_HAVE_TRANSPORT
+	default y
+	help
+	  Enable SMC based transport for SCMI.
+
+	  If you want the ARM SCMI PROTOCOL stack to include support for a
+	  transport based on SMC, answer Y.
+
+endif #ARM_SCMI_PROTOCOL
+
+config ARM_SCMI_POWER_DOMAIN
+	tristate "SCMI power domain driver"
+	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
+	default y
+	select PM_GENERIC_DOMAINS if PM
+	help
+	  This enables support for the SCMI power domains which can be
+	  enabled or disabled via the SCP firmware
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called scmi_pm_domain. Note this may needed early in boot
+	  before rootfs may be available.
+
+endmenu
diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index 6a2ef63306d6..38163d6991b3 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -2,8 +2,8 @@
 scmi-bus-y = bus.o
 scmi-driver-y = driver.o notify.o
 scmi-transport-y = shmem.o
-scmi-transport-$(CONFIG_MAILBOX) += mailbox.o
-scmi-transport-$(CONFIG_HAVE_ARM_SMCCC_DISCOVERY) += smc.o
+scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_MAILBOX) += mailbox.o
+scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_SMC) += smc.o
 scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o
 scmi-module-objs := $(scmi-bus-y) $(scmi-driver-y) $(scmi-protocols-y) \
 		    $(scmi-transport-y)
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index dd19ec2e0105..204cde53a9a7 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -403,8 +403,10 @@ struct scmi_desc {
 	int max_msg_size;
 };
 
+#ifdef CONFIG_ARM_SCMI_TRANSPORT_MAILBOX
 extern const struct scmi_desc scmi_mailbox_desc;
-#ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
+#endif
+#ifdef CONFIG_ARM_SCMI_TRANSPORT_SMC
 extern const struct scmi_desc scmi_smc_desc;
 #endif
 
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 5ff0bcbb4db4..d20e6760b488 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1933,10 +1933,10 @@ ATTRIBUTE_GROUPS(versions);
 
 /* Each compatible listed below must have descriptor associated with it */
 static const struct of_device_id scmi_of_match[] = {
-#ifdef CONFIG_MAILBOX
+#ifdef CONFIG_ARM_SCMI_TRANSPORT_MAILBOX
 	{ .compatible = "arm,scmi", .data = &scmi_mailbox_desc },
 #endif
-#ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
+#ifdef CONFIG_ARM_SCMI_TRANSPORT_SMC
 	{ .compatible = "arm,scmi-smc", .data = &scmi_smc_desc},
 #endif
 	{ /* Sentinel */ },
@@ -2008,6 +2008,8 @@ static int __init scmi_driver_init(void)
 
 	scmi_bus_init();
 
+	BUILD_BUG_ON(!IS_ENABLED(CONFIG_ARM_SCMI_HAVE_TRANSPORT));
+
 	/* Initialize any compiled-in transport which provided an init/exit */
 	ret = scmi_transports_init();
 	if (ret)
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

