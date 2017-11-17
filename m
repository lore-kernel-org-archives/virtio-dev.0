Return-Path: virtio-dev-return-2700-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 266C01CB807A
	for <virtio-dev@lists.oasis-open.org>; Fri, 17 Nov 2017 10:53:15 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Date: Fri, 17 Nov 2017 18:52:11 +0000
Message-Id: <20171117185211.32593-6-jean-philippe.brucker@arm.com>
In-Reply-To: <20171117185211.32593-1-jean-philippe.brucker@arm.com>
References: <20171117185211.32593-1-jean-philippe.brucker@arm.com>
Subject: [virtio-dev] [RFC PATCH v2 5/5] ACPI/IORT: Move IORT to the ACPI folder
To: iommu@lists.linux-foundation.org, devel@acpica.org, linux-acpi@vger.kernel.org, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: jasowang@redhat.com, mst@redhat.com, lv.zheng@intel.com, robert.moore@intel.com, joro@8bytes.org, alex.williamson@redhat.com, sudeep.holla@arm.com, hanjun.guo@linaro.org, lorenzo.pieralisi@arm.com, lenb@kernel.org, rjw@rjwysocki.net, marc.zyngier@arm.com, robin.murphy@arm.com, will.deacon@arm.com, eric.auger@redhat.com, bharat.bhushan@nxp.com, Jayachandran.Nair@cavium.com, ashok.raj@intel.com, peterx@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

IORT can be used (by QEMU) to describe a virtual topology containing an
architecture-agnostic paravirtualized device. The rationale behind this
blasphemy is explained in patch 4/5.

In order to build IORT for x86 systems, the driver has to be moved outside
of arm64/. Since there is nothing specific to arm64 in the driver, it
simply requires moving Makefile and Kconfig entries.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/acpi/Kconfig            | 3 +++
 drivers/acpi/Makefile           | 1 +
 drivers/acpi/arm64/Kconfig      | 3 ---
 drivers/acpi/arm64/Makefile     | 1 -
 drivers/acpi/{arm64 => }/iort.c | 0
 5 files changed, 4 insertions(+), 4 deletions(-)
 rename drivers/acpi/{arm64 => }/iort.c (100%)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 5b1938f4b626..ce40275646c8 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -536,4 +536,7 @@ if ARM64
 source "drivers/acpi/arm64/Kconfig"
 endif
 
+config ACPI_IORT
+	bool
+
 endif	# ACPI
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index cd1abc9bc325..689c470c013b 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -112,3 +112,4 @@ video-objs			+= acpi_video.o video_detect.o
 obj-y				+= dptf/
 
 obj-$(CONFIG_ARM64)		+= arm64/
+obj-$(CONFIG_ACPI_IORT) 	+= iort.o
diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
index 5a6f80fce0d6..403f917ab274 100644
--- a/drivers/acpi/arm64/Kconfig
+++ b/drivers/acpi/arm64/Kconfig
@@ -2,8 +2,5 @@
 # ACPI Configuration for ARM64
 #
 
-config ACPI_IORT
-	bool
-
 config ACPI_GTDT
 	bool
diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
index 1017def2ea12..47925dc6cfc8 100644
--- a/drivers/acpi/arm64/Makefile
+++ b/drivers/acpi/arm64/Makefile
@@ -1,2 +1 @@
-obj-$(CONFIG_ACPI_IORT) 	+= iort.o
 obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/iort.c
similarity index 100%
rename from drivers/acpi/arm64/iort.c
rename to drivers/acpi/iort.c
-- 
2.14.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

