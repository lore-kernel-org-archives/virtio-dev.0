Return-Path: <virtio-dev-return-14158-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42FBC35274
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Dec 2023 07:40:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7CBF821690
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Dec 2023 07:40:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6F6B29864D3
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Dec 2023 07:40:54 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5F960983F75; Mon, 18 Dec 2023 07:40:54 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 504D3986481
	for <virtio-dev@lists.oasis-open.org>; Mon, 18 Dec 2023 07:40:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1702885248.450000
X-TM-MAIL-UUID: 31e06f38-11a2-421c-b5ae-d5339e368442
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NK/hQE8iKWcwRYsj7tUbw68UHPjokjjCkJCEK29D3NwbtRaJLWedWDU9kT+G7bEEg5F5vAwwGKVbgqgoA9BcuzxrkBI6Sh8XW80ouuXH+D53I21BK29aHsQfWjNp8qLCW/6dBsnoXqmCYXjda6xb3T5qHYnlyUHol5ZCkXw2iekhJdMxFHbI3Tt3fpI/cblKtGkLBlK9u86ENXX5YQ3ccGrCtvFMMmY7euu/jIuhJjeKmVr385z1nrZdhALdEkdku3eOUdEYqFIiAov8WDpfxuxtKs89coUN5PiEiRHy2L9yImcMxae+8pqh5j0fY9x+jgNWq6z6e9MUyXoR2yxENg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBJEa+VSM5FoMWndM2MPL8alyUCPzdErHELlZP8FuFk=;
 b=eP3PgGHawxvTvXYkns37PAUk4i2jb6Mbshz8Nykl2MnztAqGGt53VWCNarCjMUtGQufXP9dNP8rJlfzdnmvq0ghubpjxjVekhjhRborgLBkv9KRss8czzpnaf+thoRNSeIoaLeavWz5hEk8CItrbiCimVc+u4H+MDPvq21Dwf7IYMxdQDLwwrLVbKtszcjPBcDOu+7vpyv3IJAhkDCXtAnAPsDHbZlI2Fp+/1+B04IPALop4zD7caVBS9Z2ZJ0TB5D9XknoXV7vHHPDtHEcdU6GLUQeRHltQDwb8iQGwQhRqi/EhGAQwx4AR7+Q6gfvQh/B4yaNp6SWmMsCmLq4Lqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=arm.com smtp.mailfrom=opensynergy.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=opensynergy.com; dkim=none (message not signed); arc=none (0)
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.66.60.4)
 smtp.mailfrom=opensynergy.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=opensynergy.com;
Received-SPF: Pass (protection.outlook.com: domain of opensynergy.com
 designates 217.66.60.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.66.60.4; helo=SR-MAIL-03.open-synergy.com; pr=C
From: Peter Hilber <peter.hilber@opensynergy.com>
To: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	virtio-dev@lists.oasis-open.org,
	linux-arm-kernel@lists.infradead.org
Cc: Peter Hilber <peter.hilber@opensynergy.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 18 Dec 2023 08:38:44 +0100
Message-Id: <20231218073849.35294-7-peter.hilber@opensynergy.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231218073849.35294-1-peter.hilber@opensynergy.com>
References: <20231218073849.35294-1-peter.hilber@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1EUR05FT004:EE_|BEZP281MB2456:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b749595c-4cbf-4540-6660-08dbff9ca634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RusVH3la176wxDg+L7Xq0fuHHTOvkxf+VNdAefakPvc+G60YmWlz7ShLVc1VaGEDPk9mGnpBQg/prQcrLDZd1nscDLOyNzo1qAdgUIEPGfqK/yEu9Ajp8X8hl/IJS80niwXxtIx9BbcIt5YeinMD4PrZ9lNbP0a/9blcxA7P1S2k0460V0TsV/rKQScQCwKpCKz0s9a45zGcFXIYc+GVsnaTY7ayefkwhnfzpWxL3xQQRNAXOuZ/+ZuBktSEh8nJRp0agFBRTeRrQEXApk1AvnyAiHs/minIwyiYJr2zWSexvj2eHTjyss7MqE/kPmOlqOFkD6JGAEJHxvXi0zlAgR2RnN7MlVbcHI8eumgdOIYGQXTgv7tYSl/zjflyG0uremUrcJWieDX8t6lsNcdr66QcCiVy7vKCNuo4M/yGwuyFVfuq+MHryBZ9rbSrsqcBr+mmFi31OEy9B9nnqFVwRL57GY+iV6Bp2cz/nCqeHzuMq7JGkKdz7I60ysFs+Uir3LUSTVQWMA3d1pvZ2SQ4hIYSmecnOSRpckf/Xo61KKvPzGbxhY/7c/LnA2B2molIsFn4Qn8YKbfLwfM0Hh1/R+87wwZ3kK/zyR1X9FfPF6Bq234NLoRSkWVLxPO6u3ueqZgiPo5UsSNj7D0mGdILRRd8a3RLmEPCrsp12bKShkV4FakUUpBKxE+CdqdBGv1XIuwvnsEdQTFrrw8BlwtunPv3/VU9ljCxcaAclbV3dXe15Ea2Fc/PY2Zp8Yy1iMvPRoPkWt/bF886Ex74iY93BwBX32yT0yvoa6gZVOf3u2A+uheG5Md/QtpwrUdzM2zV
X-Forefront-Antispam-Report:
	CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(39840400004)(136003)(376002)(346002)(396003)(230922051799003)(186009)(64100799003)(82310400011)(451199024)(1800799012)(36840700001)(46966006)(40480700001)(70586007)(86362001)(81166007)(36756003)(8936002)(36860700001)(47076005)(83380400001)(336012)(26005)(2616005)(1076003)(478600001)(2906002)(42186006)(54906003)(70206006)(4326008)(316002)(8676002)(5660300002)(44832011)(7416002)(41300700001)(41533002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 07:40:47.0708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b749595c-4cbf-4540-6660-08dbff9ca634
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VI1EUR05FT004.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB2456
X-TM-AS-ERS: 104.47.11.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28064.005
X-TMASE-Result: 10--18.516800-4.000000
X-TMASE-MatchedRID: ZAkTtSyZ7B7c1YtpVABxhScOunEIf0eXRyG5SSR7mMFHwPpoS7xiTQ3u
	hqemVNab4tr/y+kNIhx+41laLbgwdzURLmZdK2fK9K6xgLnDQNjrlkvw0pZ13MhGESF2QtYSsgk
	fnaHAFPzm9Tc/GgfFJwFtWueZlMH0Hw0ziwm/5yd81fikUYgyLUMxQVRV15qN9zxz+98nLbrqqp
	KNT13hEpMgmvUQU/w2ftTV5S2xLn0yxlgWcGNdNffKbx7F+zg4FkXEytHxBjkweIyZbRlQ2yzec
	Bj190z12HlzhM3zNtns9WQVYycKfw3lGTiQlxzIv9rSd36EgUI+Mqg+CyrtwA==
X-TMASE-XGENCLOUD: 5d705e4f-6d2a-4add-99e1-f085abd63cdc-0-0-200-0
X-TM-Deliver-Signature: 814341606C3CE357FAA4FD95D4083D3D
X-TM-Addin-Auth: oQqVyGfEqq1tPlA0MO11HPq0hwnejF6i8E6IARDqyDafuHtMRehVBO4//ml
	go3/nrkqd4jsFcyczmBclIjpUY1+OsQpPGXNlH9WPVWIwU03DEFJBPKXQL2a7g1n8R7wolHQ9M7
	dxcrNAbUSyM3pcsqP64QEbZQ/Rsf05X19gqNFaCBBe6xXIpQzIkBtt30VUDjPoGja47r7PB8Ji3
	AhMhGyxWokLkMQ/oQEpzJQYFfCHP3dDuAWmNC1AW6krRYU0Cjn8SiCH31mR1F0LRGos9Rw3H6AF
	ToiBDYSODFPs9nk=.ijNlbM3fQ75twsMA63aue4qsotouRPH3Vq5/TRxJPcMTK/2O748XJiS+g5
	+8tI58pi8B9lOrxLqKzmqB8yQpzlpjCCceLHNib11OfBfTKEjExpMpBYqsxadk887rSWZkyoltD
	BwVGSDExQPZec6Ixx9CY1kgKDklyEA7YTvG4i/KhxcVQb6B9Aj1GbMVMRKVqqMKa0sgHwtYyQMw
	q9VdmyNiplJHPy4tgl5rmJ+oUCQVqb76/A7/gjTXx99Gx91+QAJreVq6MSQmKJ4jepH3GEkHAa8
	Qq1ClqkAerIIPA5c/D74f/s3aLhEIVfZ8jEaIMGc45YcJGywvPogZPHs+eg==
X-TM-Addin-ProductCode: EMS
Subject: [virtio-dev] [RFC PATCH v3 6/7] virtio_rtc: Add Arm Generic Timer cross-timestamping

Add PTP_SYS_OFFSET_PRECISE2 support on platforms using the Arm Generic
Timer.

Always report the CP15 virtual counter as the HW counter in use by
arm_arch_timer, since the Linux kernel's usage of the Arm Generic Timer
should always be compatible with this.

Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
---

Notes:
    v2:
    
    - Depend on prerequisite patch series "treewide: Use clocksource id for
      get_device_system_crosststamp()".
    
    - Return clocksource id instead of calling dropped arm_arch_timer helpers.
    
    - Always report the CP15 virtual counter to be in use by arm_arch_timer,
      since distinction of Arm physical and virtual counter appears unneeded
      after discussion with Marc Zyngier.

 drivers/virtio/Kconfig          | 13 +++++++++++++
 drivers/virtio/Makefile         |  1 +
 drivers/virtio/virtio_rtc_arm.c | 22 ++++++++++++++++++++++
 3 files changed, 36 insertions(+)
 create mode 100644 drivers/virtio/virtio_rtc_arm.c

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 8542b2f20201..d35c728778d2 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -205,6 +205,19 @@ config VIRTIO_RTC_PTP
 
 	 If unsure, say Y.
 
+config VIRTIO_RTC_ARM
+	bool "Virtio RTC cross-timestamping using Arm Generic Timer"
+	default y
+	depends on VIRTIO_RTC_PTP && ARM_ARCH_TIMER
+	help
+	 This enables Virtio RTC cross-timestamping using the Arm Generic Timer.
+	 It only has an effect if the Virtio RTC device also supports this. The
+	 cross-timestamp is available through the PTP clock driver precise
+	 cross-timestamp ioctl (PTP_SYS_OFFSET_PRECISE2 or
+	 PTP_SYS_OFFSET_PRECISE).
+
+	 If unsure, say Y.
+
 endif # VIRTIO_RTC
 
 endif # VIRTIO_MENU
diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
index 4d48cbcae6bb..781dff9f8822 100644
--- a/drivers/virtio/Makefile
+++ b/drivers/virtio/Makefile
@@ -15,3 +15,4 @@ obj-$(CONFIG_VIRTIO_DMA_SHARED_BUFFER) += virtio_dma_buf.o
 obj-$(CONFIG_VIRTIO_RTC) += virtio_rtc.o
 virtio_rtc-y := virtio_rtc_driver.o
 virtio_rtc-$(CONFIG_VIRTIO_RTC_PTP) += virtio_rtc_ptp.o
+virtio_rtc-$(CONFIG_VIRTIO_RTC_ARM) += virtio_rtc_arm.o
diff --git a/drivers/virtio/virtio_rtc_arm.c b/drivers/virtio/virtio_rtc_arm.c
new file mode 100644
index 000000000000..5185b130b3f1
--- /dev/null
+++ b/drivers/virtio/virtio_rtc_arm.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Provides cross-timestamp params for Arm.
+ *
+ * Copyright (C) 2022-2023 OpenSynergy GmbH
+ */
+
+#include <linux/clocksource_ids.h>
+
+#include <uapi/linux/virtio_rtc.h>
+
+#include "virtio_rtc_internal.h"
+
+/* see header for doc */
+
+int viortc_hw_xtstamp_params(u16 *hw_counter, enum clocksource_ids *cs_id)
+{
+	*hw_counter = VIRTIO_RTC_COUNTER_ARM_VIRT;
+	*cs_id = CSID_ARM_ARCH_COUNTER;
+
+	return 0;
+}
-- 
2.40.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

