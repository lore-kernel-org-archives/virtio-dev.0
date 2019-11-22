Return-Path: virtio-dev-return-6367-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7D7E7985EAE
	for <virtio-dev@lists.oasis-open.org>; Fri, 22 Nov 2019 10:50:54 +0000 (UTC)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Date: Fri, 22 Nov 2019 11:49:48 +0100
Message-Id: <20191122105000.800410-2-jean-philippe@linaro.org>
In-Reply-To: <20191122105000.800410-1-jean-philippe@linaro.org>
References: <20191122105000.800410-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] [RFC 01/13] ACPI/IORT: Move IORT to the ACPI folder
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, lorenzo.pieralisi@arm.com, guohanjun@huawei.com, sudeep.holla@arm.com, gregkh@linuxfoundation.org, joro@8bytes.org, bhelgaas@google.com, mst@redhat.com, jasowang@redhat.com, jacob.jun.pan@intel.com, eric.auger@redhat.com, sebastien.boeuf@intel.com, kevin.tian@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

IORT can be used (by QEMU) to describe a virtual topology containing an
architecture-agnostic paravirtualized device.

In order to build IORT for x86 systems, the driver has to be moved outside
of arm64/. Since there is nothing specific to arm64 in the driver, it
simply requires moving Makefile and Kconfig entries.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 MAINTAINERS                     | 9 +++++++++
 drivers/acpi/Kconfig            | 3 +++
 drivers/acpi/Makefile           | 1 +
 drivers/acpi/arm64/Kconfig      | 3 ---
 drivers/acpi/arm64/Makefile     | 1 -
 drivers/acpi/{arm64 =3D> }/iort.c | 0
 6 files changed, 13 insertions(+), 4 deletions(-)
 rename drivers/acpi/{arm64 =3D> }/iort.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index eb19fad370d7..9153d278f67e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -377,6 +377,15 @@ L:=09platform-driver-x86@vger.kernel.org
 S:=09Maintained
 F:=09drivers/platform/x86/i2c-multi-instantiate.c
=20
+ACPI IORT DRIVER
+M:=09Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+M:=09Hanjun Guo <guohanjun@huawei.com>
+M:=09Sudeep Holla <sudeep.holla@arm.com>
+L:=09linux-acpi@vger.kernel.org
+L:=09linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:=09Maintained
+F:=09drivers/acpi/iort.c
+
 ACPI PMIC DRIVERS
 M:=09"Rafael J. Wysocki" <rjw@rjwysocki.net>
 M:=09Len Brown <lenb@kernel.org>
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index ebe1e9e5fd81..548976c8b2b0 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -576,6 +576,9 @@ config TPS68470_PMIC_OPREGION
 =09  region, which must be available before any of the devices
 =09  using this, are probed.
=20
+config ACPI_IORT
+=09bool
+
 endif=09# ACPI
=20
 config X86_PM_TIMER
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 5d361e4e3405..9d1792165713 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -123,3 +123,4 @@ video-objs=09=09=09+=3D acpi_video.o video_detect.o
 obj-y=09=09=09=09+=3D dptf/
=20
 obj-$(CONFIG_ARM64)=09=09+=3D arm64/
+obj-$(CONFIG_ACPI_IORT) =09+=3D iort.o
diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
index 6dba187f4f2e..d0902c85d46e 100644
--- a/drivers/acpi/arm64/Kconfig
+++ b/drivers/acpi/arm64/Kconfig
@@ -3,8 +3,5 @@
 # ACPI Configuration for ARM64
 #
=20
-config ACPI_IORT
-=09bool
-
 config ACPI_GTDT
 =09bool
diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
index 6ff50f4ed947..38771a816caf 100644
--- a/drivers/acpi/arm64/Makefile
+++ b/drivers/acpi/arm64/Makefile
@@ -1,3 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_ACPI_IORT) =09+=3D iort.o
 obj-$(CONFIG_ACPI_GTDT) =09+=3D gtdt.o
diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/iort.c
similarity index 100%
rename from drivers/acpi/arm64/iort.c
rename to drivers/acpi/iort.c
--=20
2.24.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

