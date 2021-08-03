Return-Path: <virtio-dev-return-8477-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BE297986553
	for <virtio-dev@lists.oasis-open.org>; Tue,  3 Aug 2021 13:11:35 +0000 (UTC)
From: Cristian Marussi <cristian.marussi@arm.com>
Date: Tue,  3 Aug 2021 14:10:18 +0100
Message-Id: <20210803131024.40280-10-cristian.marussi@arm.com>
In-Reply-To: <20210803131024.40280-1-cristian.marussi@arm.com>
References: <20210803131024.40280-1-cristian.marussi@arm.com>
Subject: [virtio-dev] [PATCH v7 09/15] firmware: arm_scmi: Make shmem support optional for transports
Content-Type: text/plain; charset="US-ASCII"
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: sudeep.holla@arm.com, james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com, etienne.carriere@linaro.org, vincent.guittot@linaro.org, souvik.chakravarty@arm.com, cristian.marussi@arm.com, igor.skalkin@opensynergy.com, peter.hilber@opensynergy.com, alex.bennee@linaro.org, jean-philippe@linaro.org, mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com, Andriy.Tryshnivskyy@opensynergy.com
List-ID: <virtio-dev.lists.oasis-open.org>

From: Igor Skalkin <igor.skalkin@opensynergy.com>

Upcoming new SCMI transports won't need any kind of shared memory support.
Compile shmem.c only if a shmem based transport is selected.

Signed-off-by: Igor Skalkin <igor.skalkin@opensynergy.com>
[ Peter: Adapted patch for submission to upstream. ]
Co-developed-by: Peter Hilber <peter.hilber@opensynergy.com>
Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
[ Cristian: Adapted patch/commit_msg to new SCMI Kconfig layout ]
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v4 --> v5
- Adapted to new SCMI Kconfig layout
---
 drivers/firmware/arm_scmi/Kconfig  | 8 ++++++++
 drivers/firmware/arm_scmi/Makefile | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index a6fcd06b2232..cd84e5f2ee02 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -30,10 +30,17 @@ config ARM_SCMI_HAVE_TRANSPORT
 	  Used to trigger a build bug when trying to build SCMI without any
 	  configured transport.
 
+config ARM_SCMI_HAVE_SHMEM
+	bool
+	help
+	  This declares whether a shared memory based transport for SCMI is
+	  available.
+
 config ARM_SCMI_TRANSPORT_MAILBOX
 	bool "SCMI transport based on Mailbox"
 	depends on MAILBOX
 	select ARM_SCMI_HAVE_TRANSPORT
+	select ARM_SCMI_HAVE_SHMEM
 	default y
 	help
 	  Enable mailbox based transport for SCMI.
@@ -45,6 +52,7 @@ config ARM_SCMI_TRANSPORT_SMC
 	bool "SCMI transport based on SMC"
 	depends on HAVE_ARM_SMCCC_DISCOVERY
 	select ARM_SCMI_HAVE_TRANSPORT
+	select ARM_SCMI_HAVE_SHMEM
 	default y
 	help
 	  Enable SMC based transport for SCMI.
diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index 38163d6991b3..e0e6bd3dba9e 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 scmi-bus-y = bus.o
 scmi-driver-y = driver.o notify.o
-scmi-transport-y = shmem.o
+scmi-transport-$(CONFIG_ARM_SCMI_HAVE_SHMEM) = shmem.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_MAILBOX) += mailbox.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_SMC) += smc.o
 scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

