Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656694C3BE;
	Fri, 28 Jun 2024 12:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719579178; cv=none; b=WfMAqc8YcCHwM8tMyqB6KF4avmgfP335Op59/ozppTdTCAQTA108Vc4pHRFcmHXvlanKCQz+bbdmyCkwLuflmzaRed6tHUEYN5RgziMCdj4NCsT8A2j2rHKILYyO2ipmgZN8X6MeIlKCLVwKmy2wn+yp0c0gn3LUwknWZHIu1SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719579178; c=relaxed/simple;
	bh=/F+5S/27/CBc4fxVuUmge8dVuPfUk9TrYp0qdhZy+1w=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=WNwYM8MI8Ow+TdORwQHMtp9k63jSQ5JdRCPf+YYngYI2nUod+tUvBfRt512eFVYUDvadtaKbd96d1BC347i49CQYfvVYdhhvIqjLtyaH0Y5DlZmCWoIhLex72fBDNyApUIaEgw7oL0pUPp7aqncgG738LLciJsWN+si/TLsIzrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h5AsHWo/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h5AsHWo/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:Date:Cc:To:
	From:Subject:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=szcl/ni0HLjSGIufAsvdUhq3s+0mHSRAFbiNpZegZNU=; b=h5AsHWo/vA85ZMJKui0o4SrK3s
	l4MndzrFcRVvx9wBecF3jnsouC7YDPT5jyW887u1/CVQzmFuNJjeFUunCeMpS5iVSembi12ncfiUY
	/Dag/23cw803dGmn51LlHUvmTyl+PmOxwV8ioIuPHxrW0qwOMHyGIs7ndAAWxN2Kajk4if5IjB8uG
	4M42yXaSuT8bI3VhoTms5+U1PUKvLrHYU+QK1CRUr06TlP+k4KJuy/9V3DEvaQeLkd/dgXzDwbNZP
	r2w3Uc9u8AOGWnmNIrxDNxIQLXrtT/ZXHTapbjyA/Gg+Om2arXhyCED/hat7oXgjA8Mmz5fXFF1pK
	QFUyEz4A==;
Received: from [2001:8b0:10b:5:2b2d:df20:7441:40a4] (helo=u3832b3a9db3152.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sNB5x-0000000EguT-0awn;
	Fri, 28 Jun 2024 12:52:53 +0000
Message-ID: <864c2cbe6aa85d5d0c16de4cedc6f67491ecd9df.camel@infradead.org>
Subject: [RFC PATCH] hw/acpi: Add vmclock device
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel <qemu-devel@nongnu.org>, Peter Hilber
 <peter.hilber@opensynergy.com>, "Luu, Ryan" <rluu@amazon.com>, "Ridoux,
 Julien" <ridouxj@amazon.com>, virtio-dev <virtio-dev@lists.linux.dev>,
 virtualization <virtualization@lists.linux.dev>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>,  Ani Sinha <anisinha@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>
Date: Fri, 28 Jun 2024 13:52:52 +0100
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-ZCZo3EPZ+Xoe3+iQ/i4r"
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-ZCZo3EPZ+Xoe3+iQ/i4r
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: David Woodhouse <dwmw@amazon.co.uk>

The vmclock device addresses the problem of live migration with precision
clocks. The tolerances of a hardware counter (e.g. TSC) are typically
around =C2=B150PPM. We use NTP/PTP/PPS to discipline that counter against a=
n
external source of 'real' time, and track the precise frequency of the
counter as it changes with environmental conditions.

When a guest is live migrated, anything it knows about the frequency of
the underlying counter becomes invalid. It may move from a host where
the counter running at -50PPM of its nominal frequency, to a host where
it runs at +50PPM. There will also be a step change in the value of the
counter, as the correctness of its absolute value at migration is
limited by the accuracy of the source and destination host's time
synchronization.

The device exposes a shared memory region to guests, which can be mapped
all the way to userspace. In the first phase, this merely advertises a
'disruption_marker', which indicates that the guest should throw away any
NTP synchronization it thinks it has, and start again.

Because can be exposed all the way to userspace, applications can still
use time from a vDSO 'system call', and check the disruption marker to
be sure that their timestamp is indeed truthful.

The structure also allows for the precise time, as known by the host, to
be exposed directly to guests so that they don't have to wait for NTP to
resync from scratch.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---

Guest kernel support at=20
https://git.infradead.org/users/dwmw2/linux.git/shortlog/refs/heads/vmclock
and discussion at
https://lore.kernel.org/lkml/51dcda5b675fb68c54b74fd19c408a3a086fc412.camel=
@infradead.org/

 hw/acpi/Kconfig           |   5 ++
 hw/acpi/meson.build       |   1 +
 hw/acpi/vmclock-abi.h     | 175 +++++++++++++++++++++++++++++++++++++
 hw/acpi/vmclock.c         | 177 ++++++++++++++++++++++++++++++++++++++
 hw/i386/Kconfig           |   1 +
 hw/i386/acpi-build.c      |  10 ++-
 include/hw/acpi/vmclock.h |  34 ++++++++
 7 files changed, 402 insertions(+), 1 deletion(-)
 create mode 100644 hw/acpi/vmclock-abi.h
 create mode 100644 hw/acpi/vmclock.c
 create mode 100644 include/hw/acpi/vmclock.h

diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
index e07d3204eb..1d4e9f0845 100644
--- a/hw/acpi/Kconfig
+++ b/hw/acpi/Kconfig
@@ -60,6 +60,11 @@ config ACPI_VMGENID
     default y
     depends on PC
=20
+config ACPI_VMCLOCK
+    bool
+    default y
+    depends on PC
+
 config ACPI_VIOT
     bool
     depends on ACPI
diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
index fa5c07db90..77566ae8a8 100644
--- a/hw/acpi/meson.build
+++ b/hw/acpi/meson.build
@@ -16,6 +16,7 @@ acpi_ss.add(when: 'CONFIG_ACPI_NVDIMM', if_false: files('=
acpi-nvdimm-stub.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_PCI', if_true: files('pci.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_CXL', if_true: files('cxl.c'), if_false: fi=
les('cxl-stub.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_VMGENID', if_true: files('vmgenid.c'))
+acpi_ss.add(when: 'CONFIG_ACPI_VMCLOCK', if_true: files('vmclock.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_HW_REDUCED', if_true: files('generic_event_=
device.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_HMAT', if_true: files('hmat.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_APEI', if_true: files('ghes.c'), if_false: =
files('ghes-stub.c'))
diff --git a/hw/acpi/vmclock-abi.h b/hw/acpi/vmclock-abi.h
new file mode 100644
index 0000000000..3f6473c3d9
--- /dev/null
+++ b/hw/acpi/vmclock-abi.h
@@ -0,0 +1,175 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Cl=
ause) */
+
+/*
+ * This structure provides a vDSO-style clock to VM guests, exposing the
+ * relationship (or lack thereof) between the CPU clock (TSC, timebase, ar=
ch
+ * counter, etc.) and real time. It is designed to address the problem of
+ * live migration, which other clock enlightenments do not.
+ *
+ * When a guest is live migrated, this affects the clock in two ways.
+ *
+ * First, even between identical hosts the actual frequency of the underly=
ing
+ * counter will change within the tolerances of its specification (typical=
ly
+ * =C2=B150PPM, or 4 seconds a day). The frequency also varies over time o=
n the
+ * same host, but can be tracked by NTP as it generally varies slowly. Wit=
h
+ * live migration there is a step change in the frequency, with no warning=
.
+ *
+ * Second, there may be a step change in the value of the counter itself, =
as
+ * its accuracy is limited by the precision of the NTP synchronization on =
the
+ * source and destination hosts.
+ *
+ * So any calibration (NTP, PTP, etc.) which the guest has done on the sou=
rce
+ * host before migration is invalid, and needs to be redone on the new hos=
t.
+ *
+ * In its most basic mode, this structure provides only an indication to t=
he
+ * guest that live migration has occurred. This allows the guest to know t=
hat
+ * its clock is invalid and take remedial action. For applications that ne=
ed
+ * reliable accurate timestamps (e.g. distributed databases), the structur=
e
+ * can be mapped all the way to userspace. This allows the application to =
see
+ * directly for itself that the clock is disrupted and take appropriate
+ * action, even when using a vDSO-style method to get the time instead of =
a
+ * system call.
+ *
+ * In its more advanced mode. this structure can also be used to expose th=
e
+ * precise relationship of the CPU counter to real time, as calibrated by =
the
+ * host. This means that userspace applications can have accurate time
+ * immediately after live migration, rather than having to pause operation=
s
+ * and wait for NTP to recover. This mode does, of course, rely on the
+ * counter being reliable and consistent across CPUs.
+ *
+ * Note that this must be true UTC, never with smeared leap seconds. If a
+ * guest wishes to construct a smeared clock, it can do so. Presenting a
+ * smeared clock through this interface would be problematic because it
+ * actually messes with the apparent counter *period*. A linear smearing
+ * of 1 ms per second would effectively tweak the counter period by 1000PP=
M
+ * at the start/end of the smearing period, while a sinusoidal smear would
+ * basically be impossible to represent.
+ */
+
+#ifndef __VMCLOCK_ABI_H__
+#define __VMCLOCK_ABI_H__
+
+#ifdef __KERNEL__
+#include <linux/types.h>
+#else
+#include <stdint.h>
+#endif
+
+struct vmclock_abi {
+	uint32_t magic;
+#define VMCLOCK_MAGIC	0x4b4c4356 /* "VCLK" */
+	uint16_t size;		/* Size of page containing this structure */
+	uint16_t version;	/* 1 */
+
+	/* Sequence lock. Low bit means an update is in progress. */
+	uint32_t seq_count;
+
+	uint32_t flags;
+	/* Indicates that the tai_offset_sec field is valid */
+#define VMCLOCK_FLAG_TAI_OFFSET_VALID		(1 << 0)
+	/*
+	 * Optionally used to notify guests of pending maintenance events.
+	 * A guest may wish to remove itself from service if an event is
+	 * coming up. Two flags indicate the rough imminence of the event.
+	 */
+#define VMCLOCK_FLAG_DISRUPTION_SOON		(1 << 1) /* About a day */
+#define VMCLOCK_FLAG_DISRUPTION_IMMINENT	(1 << 2) /* About an hour */
+	/* Indicates that the utc_time_maxerror_picosec field is valid */
+#define VMCLOCK_FLAG_UTC_MAXERROR_VALID		(1 << 3)
+	/* Indicates counter_period_error_rate_frac_sec is valid */
+#define VMCLOCK_FLAG_PERIOD_ERROR_VALID		(1 << 4)
+
+	/*
+	 * This field changes to another non-repeating value when the CPU
+	 * counter is disrupted, for example on live migration. This lets
+	 * the guest know that it should discard any calibration it has
+	 * performed of the counter against external sources (NTP/PTP/etc.).
+	 */
+	uint64_t disruption_marker;
+
+	uint8_t clock_status;
+#define VMCLOCK_STATUS_UNKNOWN		0
+#define VMCLOCK_STATUS_INITIALIZING	1
+#define VMCLOCK_STATUS_SYNCHRONIZED	2
+#define VMCLOCK_STATUS_FREERUNNING	3
+#define VMCLOCK_STATUS_UNRELIABLE	4
+
+	uint8_t counter_id;
+#define VMCLOCK_COUNTER_INVALID		0
+#define VMCLOCK_COUNTER_X86_TSC		1
+#define VMCLOCK_COUNTER_ARM_VCNT	2
+#define VMCLOCK_COUNTER_X86_ART		3
+
+	/*
+	 * By providing the offset from UTC to TAI, the guest can know both
+	 * UTC and TAI reliably, whichever is indicated in the time_type
+	 * field. Valid if VMCLOCK_FLAG_TAI_OFFSET_VALID is set in flags.
+	 */
+	int16_t tai_offset_sec;
+
+	/*
+	 * The time exposed through this device is never smeaared; if it
+	 * claims to be VMCLOCK_TIME_UTC then it MUST be UTC. This field
+	 * provides a hint to the guest operating system, such that *if*
+	 * the guest OS wants to provide its users with an alternative
+	 * clock which does not follow the POSIX CLOCK_REALTIME standard,
+	 * it may do so in a fashion consistent with the other systems
+	 * in the nearby environment.
+	 */
+	uint8_t leap_second_smearing_hint;
+	/* Provide true UTC to users, unsmeared. */;
+#define VMCLOCK_SMEARING_NONE			0
+	/*
+	 * https://aws.amazon.com/blogs/aws/look-before-you-leap-the-coming-leap-=
second-and-aws/
+	 * From noon on the day before to noon on the day after, smear the
+	 * clock by a linear 1/86400s per second.
+	*/
+#define VMCLOCK_SMEARING_LINEAR_86400		1
+	/*
+	 * draft-kuhn-leapsecond-00
+	 * For the 1000s leading up to the leap second, smear the clock by
+	 * clock by a linear 1ms per second.
+	 */
+#define VMCLOCK_SMEARING_UTC_SLS		2
+
+	/*
+	 * What time is exposed in the time_sec/time_frac_sec fields?
+	 */
+	uint8_t time_type;
+#define VMCLOCK_TIME_UNKNOWN		0	/* Invalid / no time exposed */
+#define VMCLOCK_TIME_UTC		1	/* Since 1970-01-01 00:00:00z */
+#define VMCLOCK_TIME_TAI		2	/* Since 1970-01-01 00:00:00z */
+#define VMCLOCK_TIME_MONOTONIC		3	/* Since undefined epoch */
+
+	/* Bit shift for counter_period_frac_sec and its error rate */
+	uint8_t counter_period_shift;
+
+	/*
+	 * Unlike in NTP, this can indicate a leap second in the past. This
+	 * is needed to allow guests to derive an imprecise clock with
+	 * smeared leap seconds for themselves, as some modes of smearing
+	 * need the adjustments to continue even after the moment at which
+	 * the leap second should have occurred.
+	 */
+	int8_t leapsecond_direction;
+	uint64_t leapsecond_tai_sec; /* Since 1970-01-01 00:00:00z */
+
+	/*
+	 * Paired values of counter and UTC at a given point in time.
+	 */
+	uint64_t counter_value;
+	uint64_t time_sec;
+	uint64_t time_frac_sec;
+
+	/*
+	 * Counter frequency, and error margin. The unit of these fields is
+	 * seconds >> (64 + counter_period_shift)
+	 */
+	uint64_t counter_period_frac_sec;
+	uint64_t counter_period_error_rate_frac_sec;
+
+	/* Error margin of UTC reading above (=C2=B1 picoseconds) */
+	uint64_t utc_time_maxerror_picosec;
+};
+
+#endif /*  __VMCLOCK_ABI_H__ */
diff --git a/hw/acpi/vmclock.c b/hw/acpi/vmclock.c
new file mode 100644
index 0000000000..57be75b713
--- /dev/null
+++ b/hw/acpi/vmclock.c
@@ -0,0 +1,177 @@
+/*
+ * Virtual Machine Clock Device
+ *
+ * Copyright =C2=A9 2024 Amazon.com, Inc. or its affiliates. All Rights Re=
served.
+ *
+ * Authors: David Woodhouse <dwmw2@infradead.org>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "hw/i386/e820_memory_layout.h"
+#include "hw/acpi/acpi.h"
+#include "hw/acpi/aml-build.h"
+#include "hw/acpi/vmclock.h"
+#include "hw/nvram/fw_cfg.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
+#include "migration/vmstate.h"
+#include "sysemu/reset.h"
+
+#include "vmclock-abi.h"
+
+void vmclock_build_acpi(VmclockState *vms, GArray *table_data,
+                        BIOSLinker *linker, const char *oem_id)
+{
+    Aml *ssdt, *dev, *scope, *method, *addr, *crs;
+    AcpiTable table =3D { .sig =3D "SSDT", .rev =3D 1,
+                        .oem_id =3D oem_id, .oem_table_id =3D "VMCLOCK" };
+
+    /* Put VMCLOCK into a separate SSDT table */
+    acpi_table_begin(&table, table_data);
+    ssdt =3D init_aml_allocator();
+
+    scope =3D aml_scope("\\_SB");
+    dev =3D aml_device("VCLK");
+    aml_append(dev, aml_name_decl("_HID", aml_string("QEMUVCLK")));
+    aml_append(dev, aml_name_decl("_CID", aml_string("VMCLOCK")));
+    aml_append(dev, aml_name_decl("_DDN", aml_string("VMCLOCK")));
+
+    /* Simple status method */
+    method =3D aml_method("_STA", 0, AML_NOTSERIALIZED);
+    addr =3D aml_local(0);
+    aml_append(method, aml_store(aml_int(0xf), addr));
+    aml_append(method, aml_return(addr));
+    aml_append(dev, method);
+
+    crs =3D aml_resource_template();
+    aml_append(crs, aml_qword_memory(AML_POS_DECODE,
+                                     AML_MIN_FIXED, AML_MAX_FIXED,
+                                     AML_CACHEABLE, AML_READ_ONLY,
+                                     0xffffffffffffffffULL,
+                                     vms->physaddr,
+                                     vms->physaddr + VMCLOCK_SIZE - 1,
+                                     0, VMCLOCK_SIZE));
+    aml_append(dev, aml_name_decl("_CRS", crs));
+    aml_append(scope, dev);
+    aml_append(ssdt, scope);
+
+    g_array_append_vals(table_data, ssdt->buf->data, ssdt->buf->len);
+    acpi_table_end(linker, &table);
+    free_aml_allocator();
+}
+
+static void vmclock_update_guest(VmclockState *vms)
+{
+    if (!vms->clk) {
+        return;
+    }
+    vms->clk->seq_count |=3D 1;
+    smp_wmb();
+
+    vms->clk->disruption_marker++;
+
+    smp_wmb();
+    vms->clk->seq_count +=3D 1;
+}
+
+/* After restoring an image, we need to update the guest memory and notify
+ * it of a potential change to VM Generation ID
+ */
+static int vmclock_post_load(void *opaque, int version_id)
+{
+    VmclockState *vms =3D opaque;
+    vmclock_update_guest(vms);
+    return 0;
+}
+
+static const VMStateDescription vmstate_vmclock =3D {
+    .name =3D "vmclock",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .post_load =3D vmclock_post_load,
+    .fields =3D (const VMStateField[]) {
+        VMSTATE_UINT64(physaddr, VmclockState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void vmclock_handle_reset(void *opaque)
+{
+    VmclockState *vms =3D VMCLOCK(opaque);
+
+    if (!memory_region_is_mapped(&vms->clk_page)) {
+        memory_region_add_subregion_overlap(get_system_memory(),
+                                            vms->physaddr,
+                                            &vms->clk_page, 0);
+    }
+}
+
+static void vmclock_realize(DeviceState *dev, Error **errp)
+{
+    VmclockState *vms =3D VMCLOCK(dev);
+
+    /* Given that this function is executing, there is at least one VMCLOC=
K
+     * device. Check if there are several.
+     */
+    if (!find_vmclock_dev()) {
+        error_setg(errp, "at most one %s device is permitted", TYPE_VMCLOC=
K);
+        return;
+    }
+
+    vms->physaddr =3D VMCLOCK_ADDR;
+
+    e820_add_entry(vms->physaddr, VMCLOCK_SIZE, E820_RESERVED);
+
+    memory_region_init_ram(&vms->clk_page, OBJECT(dev), "vmclock_page",
+                           VMCLOCK_SIZE, &error_abort);
+    memory_region_set_enabled(&vms->clk_page, true);
+    vms->clk =3D memory_region_get_ram_ptr(&vms->clk_page);
+    memset(vms->clk, 0, VMCLOCK_SIZE);
+
+    vms->clk->magic =3D cpu_to_le32(VMCLOCK_MAGIC);
+    vms->clk->size =3D cpu_to_le16(VMCLOCK_SIZE);
+    vms->clk->version =3D cpu_to_le16(1);
+
+    /* These are all zero and thus default, but be explicit */
+    vms->clk->time_type =3D VMCLOCK_TIME_UNKNOWN;
+    vms->clk->clock_status =3D VMCLOCK_STATUS_UNKNOWN;
+    vms->clk->counter_id =3D VMCLOCK_COUNTER_INVALID;
+
+    qemu_register_reset(vmclock_handle_reset, vms);
+
+    vmclock_update_guest(vms);
+}
+
+static Property vmclock_device_properties[] =3D {
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vmclock_device_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->vmsd =3D &vmstate_vmclock;
+    dc->realize =3D vmclock_realize;
+    device_class_set_props(dc, vmclock_device_properties);
+    dc->hotpluggable =3D false;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+}
+
+static const TypeInfo vmclock_device_info =3D {
+    .name          =3D TYPE_VMCLOCK,
+    .parent        =3D TYPE_DEVICE,
+    .instance_size =3D sizeof(VmclockState),
+    .class_init    =3D vmclock_device_class_init,
+};
+
+static void vmclock_register_types(void)
+{
+    type_register_static(&vmclock_device_info);
+}
+
+type_init(vmclock_register_types)
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index f4a33b6c08..86b00bb94f 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -43,6 +43,7 @@ config PC
     select SERIAL_ISA
     select ACPI_PCI
     select ACPI_VMGENID
+    select ACPI_VMCLOCK
     select VIRTIO_PMEM_SUPPORTED
     select VIRTIO_MEM_SUPPORTED
     select HV_BALLOON_SUPPORTED
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 53f804ac16..d83922c7e2 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -43,6 +43,7 @@
 #include "sysemu/tpm.h"
 #include "hw/acpi/tpm.h"
 #include "hw/acpi/vmgenid.h"
+#include "hw/acpi/vmclock.h"
 #include "hw/acpi/erst.h"
 #include "hw/acpi/piix4.h"
 #include "sysemu/tpm_backend.h"
@@ -2508,7 +2509,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState=
 *machine)
     size_t aml_len =3D 0;
     GArray *tables_blob =3D tables->table_data;
     AcpiSlicOem slic_oem =3D { .id =3D NULL, .table_id =3D NULL };
-    Object *vmgenid_dev;
+    Object *vmgenid_dev, *vmclock_dev;
     char *oem_id;
     char *oem_table_id;
=20
@@ -2588,6 +2589,13 @@ void acpi_build(AcpiBuildTables *tables, MachineStat=
e *machine)
                            tables->vmgenid, tables->linker, x86ms->oem_id)=
;
     }
=20
+    vmclock_dev =3D find_vmclock_dev();
+    if (vmclock_dev) {
+        acpi_add_table(table_offsets, tables_blob);
+        vmclock_build_acpi(VMCLOCK(vmclock_dev), tables_blob, tables->link=
er,
+                           x86ms->oem_id);
+    }
+
     if (misc.has_hpet) {
         acpi_add_table(table_offsets, tables_blob);
         build_hpet(tables_blob, tables->linker, x86ms->oem_id,
diff --git a/include/hw/acpi/vmclock.h b/include/hw/acpi/vmclock.h
new file mode 100644
index 0000000000..5605605812
--- /dev/null
+++ b/include/hw/acpi/vmclock.h
@@ -0,0 +1,34 @@
+#ifndef ACPI_VMCLOCK_H
+#define ACPI_VMCLOCK_H
+
+#include "hw/acpi/bios-linker-loader.h"
+#include "hw/qdev-core.h"
+#include "qemu/uuid.h"
+#include "qom/object.h"
+
+#define TYPE_VMCLOCK    "vmclock"
+
+#define VMCLOCK_ADDR    0xfeffb000
+#define VMCLOCK_SIZE    0x1000
+
+OBJECT_DECLARE_SIMPLE_TYPE(VmclockState, VMCLOCK)
+
+struct vmclock_abi;
+
+struct VmclockState {
+    DeviceState parent_obj;
+    MemoryRegion clk_page;
+    uint64_t physaddr;
+    struct vmclock_abi *clk;
+};
+
+/* returns NULL unless there is exactly one device */
+static inline Object *find_vmclock_dev(void)
+{
+    return object_resolve_path_type("", TYPE_VMCLOCK, NULL);
+}
+
+void vmclock_build_acpi(VmclockState *vms, GArray *table_data,
+                        BIOSLinker *linker, const char *oem_id);
+
+#endif
--=20
2.44.0



--=-ZCZo3EPZ+Xoe3+iQ/i4r
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEkQw
ggYQMIID+KADAgECAhBNlCwQ1DvglAnFgS06KwZPMA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQG
EwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoT
FVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0
aW9uIEF1dGhvcml0eTAeFw0xODExMDIwMDAwMDBaFw0zMDEyMzEyMzU5NTlaMIGWMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYD
VQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50
aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAyjztlApB/975Rrno1jvm2pK/KxBOqhq8gr2+JhwpKirSzZxQgT9tlC7zl6hn1fXjSo5MqXUf
ItMltrMaXqcESJuK8dtK56NCSrq4iDKaKq9NxOXFmqXX2zN8HHGjQ2b2Xv0v1L5Nk1MQPKA19xeW
QcpGEGFUUd0kN+oHox+L9aV1rjfNiCj3bJk6kJaOPabPi2503nn/ITX5e8WfPnGw4VuZ79Khj1YB
rf24k5Ee1sLTHsLtpiK9OjG4iQRBdq6Z/TlVx/hGAez5h36bBJMxqdHLpdwIUkTqT8se3ed0PewD
ch/8kHPo5fZl5u1B0ecpq/sDN/5sCG52Ds+QU5O5EwIDAQABo4IBZDCCAWAwHwYDVR0jBBgwFoAU
U3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0OBBYEFAnA8vwL2pTbX/4r36iZQs/J4K0AMA4GA1Ud
DwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEF
BQcDBDARBgNVHSAECjAIMAYGBFUdIAAwUAYDVR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC51c2Vy
dHJ1c3QuY29tL1VTRVJUcnVzdFJTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3JsMHYGCCsGAQUF
BwEBBGowaDA/BggrBgEFBQcwAoYzaHR0cDovL2NydC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJT
QUFkZFRydXN0Q0EuY3J0MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0G
CSqGSIb3DQEBDAUAA4ICAQBBRHUAqznCFfXejpVtMnFojADdF9d6HBA4kMjjsb0XMZHztuOCtKF+
xswhh2GqkW5JQrM8zVlU+A2VP72Ky2nlRA1GwmIPgou74TZ/XTarHG8zdMSgaDrkVYzz1g3nIVO9
IHk96VwsacIvBF8JfqIs+8aWH2PfSUrNxP6Ys7U0sZYx4rXD6+cqFq/ZW5BUfClN/rhk2ddQXyn7
kkmka2RQb9d90nmNHdgKrwfQ49mQ2hWQNDkJJIXwKjYA6VUR/fZUFeCUisdDe/0ABLTI+jheXUV1
eoYV7lNwNBKpeHdNuO6Aacb533JlfeUHxvBz9OfYWUiXu09sMAviM11Q0DuMZ5760CdO2VnpsXP4
KxaYIhvqPqUMWqRdWyn7crItNkZeroXaecG03i3mM7dkiPaCkgocBg0EBYsbZDZ8bsG3a08LwEsL
1Ygz3SBsyECa0waq4hOf/Z85F2w2ZpXfP+w8q4ifwO90SGZZV+HR/Jh6rEaVPDRF/CEGVqR1hiuQ
OZ1YL5ezMTX0ZSLwrymUE0pwi/KDaiYB15uswgeIAcA6JzPFf9pLkAFFWs1QNyN++niFhsM47qod
x/PL+5jR87myx5uYdBEQkkDc+lKB1Wct6ucXqm2EmsaQ0M95QjTmy+rDWjkDYdw3Ms6mSWE3Bn7i
5ZgtwCLXgAIe5W8mybM2JzCCBhQwggT8oAMCAQICEQDGvhmWZ0DEAx0oURL6O6l+MA0GCSqGSIb3
DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYD
VQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28g
UlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTIyMDEwNzAw
MDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJARYTZHdtdzJAaW5mcmFkZWFkLm9y
ZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3GpC2bomUqk+91wLYBzDMcCj5C9m6
oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZHh7htyAkWYVoFsFPrwHounto8xTsy
SSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT9YgcBqKCo65pTFmOnR/VVbjJk4K2
xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNjP+qDrh0db7PAjO1D4d5ftfrsf+kd
RR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy2U+eITZ5LLE5s45mX2oPFknWqxBo
bQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3BgBEmfsYWlBXO8rVXfvPgLs32VdV
NZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/7auNVRmPB3v5SWEsH8xi4Bez2V9U
KxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmdlFYhAflWKQ03Ufiu8t3iBE3VJbc2
5oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9aelIl6vtbhMA+l0nfrsORMa4kobqQ5
C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMBAAGjggHMMIIByDAfBgNVHSMEGDAW
gBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeDMcimo0oz8o1R1Nver3ZVpSkwDgYD
VR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGln
by5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuc2VjdGlnby5jb20vU2VjdGln
b1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYoGCCsGAQUFBwEB
BH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBQ2xpZW50
QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAjBggrBgEFBQcwAYYXaHR0cDovL29j
c3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5mcmFkZWFkLm9yZzANBgkqhkiG9w0B
AQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQvQ/fzPXmtR9t54rpmI2TfyvcKgOXp
qa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvIlSPrzIB4Z2wyIGQpaPLlYflrrVFK
v9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9ChWFfgSXvrWDZspnU3Gjw/rMHrGnql
Htlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0whpBtXdyDjzBtQTaZJ7zTT/vlehc/
tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9IzCCBhQwggT8oAMCAQICEQDGvhmW
Z0DEAx0oURL6O6l+MA0GCSqGSIb3DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3Jl
YXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0
ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJl
IEVtYWlsIENBMB4XDTIyMDEwNzAwMDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJ
ARYTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3
GpC2bomUqk+91wLYBzDMcCj5C9m6oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZH
h7htyAkWYVoFsFPrwHounto8xTsySSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT
9YgcBqKCo65pTFmOnR/VVbjJk4K2xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNj
P+qDrh0db7PAjO1D4d5ftfrsf+kdRR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy
2U+eITZ5LLE5s45mX2oPFknWqxBobQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3
BgBEmfsYWlBXO8rVXfvPgLs32VdVNZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/
7auNVRmPB3v5SWEsH8xi4Bez2V9UKxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmd
lFYhAflWKQ03Ufiu8t3iBE3VJbc25oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9ae
lIl6vtbhMA+l0nfrsORMa4kobqQ5C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMB
AAGjggHMMIIByDAfBgNVHSMEGDAWgBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeD
Mcimo0oz8o1R1Nver3ZVpSkwDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYw
FAYIKwYBBQUHAwQGCCsGAQUFBwMCMEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYB
BQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9j
cmwuc2VjdGlnby5jb20vU2VjdGlnb1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1h
aWxDQS5jcmwwgYoGCCsGAQUFBwEBBH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdv
LmNvbS9TZWN0aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAj
BggrBgEFBQcwAYYXaHR0cDovL29jc3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5m
cmFkZWFkLm9yZzANBgkqhkiG9w0BAQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQv
Q/fzPXmtR9t54rpmI2TfyvcKgOXpqa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvI
lSPrzIB4Z2wyIGQpaPLlYflrrVFKv9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9Ch
WFfgSXvrWDZspnU3Gjw/rMHrGnqlHtlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0w
hpBtXdyDjzBtQTaZJ7zTT/vlehc/tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9
IzGCBMcwggTDAgEBMIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVz
dGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMT
NVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEA
xr4ZlmdAxAMdKFES+jupfjANBglghkgBZQMEAgEFAKCCAeswGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQwNjI4MTI1MjUyWjAvBgkqhkiG9w0BCQQxIgQg23bKf0EL
PcLt1lfeW2v1ew9zJxBvPtqijTMEpMU59pUwgb0GCSsGAQQBgjcQBDGBrzCBrDCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
A1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAMa+GZZnQMQDHShREvo7qX4wgb8GCyqGSIb3
DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNl
Y3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAxr4Z
lmdAxAMdKFES+jupfjANBgkqhkiG9w0BAQEFAASCAgBUlMRdoXFRkNgpGqLnc+EwLC9/jcbAgoxv
8t4Uv/4b0DiNee1GhVuzxNgOPj/uLcwgOrujuKFKgp0FOMlvJLNx8syQRm8PF2kkus2431fpeEab
t88t7MXhLs2UQ/RmhTgJzgZU6KbjEUcEUMzr/2AgYU0S1rRLn1f5D6umgIB9GMci/TyVgBiGIbUF
z3SRSnAGppP4MFcaXTmnOqfFeg0lsQyYxJ9FR63Uu9tZWj9Lek5sO27kHbEybOj2noIPohozw+np
x6I6mhcGKVrOKP+tMjYfjWfB53ut5+gri+7DyheTEiPLklzUqZOvtV0Tul2AGHnwSvkZ5nTcIN3m
sduP4k23wyPPyyUK+amhUGnl1PfhIbtSNKFD5wSqdeS8Wr9Q5SnncMQHDZRCp2BEVtqXTuzbQ4HR
dh5J8SK9VJ18ef5y9q97IYuRT61292xmlqCqnt2b0HMhUSmJUVXS70Qu70jirQK+iisYvy0KACMk
my/vaPJ66ZAGkYi0kJx7WHCCdE/cNexZMBX8RQG1FBOeB6nvlcOPjoTCzi84WtWmIY+YRHbmP38C
H8T41qjzx4NekOc0GOHi61xrWkwBS7AWrthspwi2Ggq3tUVT0l1u31f7gq4uC4ITAdDStUoaeKY6
pabtCpkZfdedyg44iLsPu/hCKsMYFkqWr7h9YYmLPQAAAAAAAA==


--=-ZCZo3EPZ+Xoe3+iQ/i4r--
