Return-Path: <virtio-dev-return-13198-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 567F0EB64D7
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 17:12:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C09572CADC
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 17:12:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B8B0C9866FA
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 17:12:42 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id ACE7C9866F0; Fri, 30 Jun 2023 17:12:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 907CB9866ED
	for <virtio-dev@lists.oasis-open.org>; Fri, 30 Jun 2023 17:12:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1688145153.430000
X-TM-MAIL-UUID: ee4b92a0-79ce-403f-ae6a-ff1396bc5399
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3EMykZidH56HeJnGTjqhqtT3uSrRs720E2RWQI91+GnGVablCd6xS1Fvp+5eMkej0wzu3JyYEUKg1Bt4ZsrXR+rNpnGpP6w0ULl7QO0rHS+1FvP27y+tDJnKQgujos6RoGJctBNe9TW66g+fGOmDgEuyuvKTpNowcilTryQnn5XpL9A1OT102Vu/PpYFGao1QyqVYb1tOLXwjm9FaH9qpUO6jjfSweVA4SgFcBsuJnXEoK5qnzGpKRvN4siQ1/r6eRs8iVo/FzitMzPi4y5Y3uZai+u9U7Oun5L1krOq7NnuVR9DCic6rbX2weuYXuAeZlFh9C5D59rcDChY4AuyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmFoyCaOlkqdJbrsaGL8tIEEXRJei17uNfH7jf8XZN8=;
 b=nRnyfidYKnrhjTuzbIcxjXkR6s9GkF1xLVuyWtqfaeUJe+DwP1QZ4CFJFBHuQXEqZeu29hnzeP5gbZgHRLuPA0pRmaG4r9zeTAG5cHsVn5bRvtW1IaqUmxA1sKmh54PGab9Wk9lBjAiQY2uCiHpnyMlHyIdlW3U2HNn0Xj8B0VWMqsdob348sNzFmnKGmKVmrEf+LD8hVAmutyaRRL2Vab6R+k6UTmAaammp0uTfvdr4bZxdHa1kcta+fC2j0YVuO509HmM1MDxu84ZXgntpwCm7wsrtC6IHXfTKFESI9P2RWuDK02wKelfyKpJOdqTN4ulwjAs+WIOWvbCQg1nHGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=linux.alibaba.com
 smtp.mailfrom=opensynergy.com; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=opensynergy.com; dkim=none (message not
 signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.66.60.4)
 smtp.mailfrom=opensynergy.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=opensynergy.com;
Received-SPF: Pass (protection.outlook.com: domain of opensynergy.com
 designates 217.66.60.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.66.60.4; helo=SR-MAIL-03.open-synergy.com; pr=C
From: Peter Hilber <peter.hilber@opensynergy.com>
To: virtualization@lists.linux-foundation.org,
	virtio-dev@lists.oasis-open.org
Cc: Peter Hilber <peter.hilber@opensynergy.com>,
	linux-kernel@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Date: Fri, 30 Jun 2023 19:10:50 +0200
Message-Id: <20230630171052.985577-8-peter.hilber@opensynergy.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230630171052.985577-1-peter.hilber@opensynergy.com>
References: <20230630171052.985577-1-peter.hilber@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8EUR05FT036:EE_|FR0P281MB1657:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c8cd4262-85b8-4365-506f-08db798d30bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OiQP6oSlTNBhJTbFjYANv7FzY6Rt9o1VCywT2YLqVd2SLVyi+ilb4+LC189uP54+fJM9d+FonlBALxPnlcmirsZiNa8hvKO0bVrWHpuTQSXIdvgTzsHTP1jEZW9nRj1yuyJaoaARKKGcjs7Vh3IiEtaAJu9qOWPZz6viTJw9g5AZwrukWEzYBdvEwYV4zv2aJyRKgqodamKV+eI33Gmq8z5ebwldOjY4n/U+E7qmuoWsEd902H/nEbV0J7mec5ZNq9Kr7LgkfJOak0+o4U7zIiPIE16anCOXFQgnmcDpjmZuxorODYhVSnXGsHuvId7G+/YR0JSZdkjhxphbrV7VrrlVhDAAeCMRuzcz2KJIZlIEc5uuZytazrI81K8HteFpuipSx7f1EPD3TOYJ1FrwUodHLbjbzFnq1Y9gkodgm2ZKn3WE4fLkXxaZuKl09bRykUHMu+KdnnjsTWF31rh6ek0Z0VVyMXdVC5BgzOFCGdippjMkuP/H9rfQLXevSsiC7ZNdzeB5pWVVHpcohN4LjuO0Ey4DwU/xURjpzyPoMOytqQSfbHBpjgGzhwWsbWBI2UvwAE5gFvdPs0fMW3GqCtGar+RQUka9KIvHUYYUwu0eXWrJkRAGDN9/R4W5BZ306FSeO2IBXDcZsk2nICyuRVQEjGyKqNrWkRQ4Iv2aaF90MVNC3g8CBLANXG6jGsOxo1FvOoGFhFMFL4p7Az0og4qJvdTQnov0mcAVHP0cmhGg1C0Q+/5Lk7m3b6ApbiLiskBInbLtth2FEpwXExzca43S1TFyMyZmx8V1fiZW6K0=
X-Forefront-Antispam-Report:
	CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(376002)(396003)(39840400004)(136003)(346002)(451199021)(46966006)(36840700001)(86362001)(54906003)(8936002)(8676002)(5660300002)(82310400005)(26005)(44832011)(1076003)(478600001)(4326008)(70206006)(70586007)(966005)(41300700001)(316002)(42186006)(186003)(2616005)(2906002)(47076005)(83380400001)(336012)(36860700001)(40480700001)(36756003)(81166007)(41533002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 17:12:31.6895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8cd4262-85b8-4365-506f-08db798d30bb
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB8EUR05FT036.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB1657
X-TM-AS-ERS: 104.47.7.177-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1011-27724.001
X-TMASE-Result: 10--11.667500-4.000000
X-TMASE-MatchedRID: huMMtcahIlDc1YtpVABxhScOunEIf0eXRyG5SSR7mMFHwPpoS7xiTQ3u
	hqemVNabwqNosrPrbHMTsTmVJvxcHKjHzroBTUY9L/5nX3iQblcH/MsNCRnylchGESF2QtYSsgk
	fnaHAFPzm9Tc/GgfFJwFtWueZlMH0Hw0ziwm/5yd81fikUYgyLefShpTpYz7797gvW7V0yoZtyV
	XNSSC+Bni2yHSIHoZstv5tlY0RB3F1dilwOXZXnZOU1MLNH5QIp9ot5GYsw7Gc2JxbD3wPF24q1
	hfzDZy5xyWmjWIJIoJwT/DvNCCX4MddJPEKsqAMES46qCSbf/WHvP6CYoqPSgN/ojyMXH62DEom
	GUxecKpxg7svMtapLpefsKoW209bgHkGDkIaUnULYpBk5/uhSeQZtxwUYGQZRpMDBdUmwGo=
X-TMASE-XGENCLOUD: fbc7fa83-7c2b-44b2-acde-9dcb2ca7bd88-0-0-200-0
X-TM-Deliver-Signature: B3A2AABD22BC6B721119BBE8E963F1C3
X-TM-Addin-Auth: FqTsgZGS/LY7uD/3u5PjxWmSaftmsshxVUNRF/ZAPGFXer8fdMKSkX3/9jh
	1KfeIN/AiRbIL2xkjrDrr4wIBEMCuOidwS5xZsXBiosoUZgOzjb4SUgfAEVOCBCatS4pB6LPyHp
	y0Q1DpGIhs52iMPg2V5CVxhmdo6AHu1v7U4jVLmy6mQnJ158CrOdfhx0JpTCyIY/3WK241rIJ29
	t2FN7qUYitRkAeX2zjtckBDhlmkHLjaN7vDVFs76aV6qm1yaJliJVkB0VHbxNyQiCkx8rNv8Rho
	yFqmNrFf+FKzdDg=.0DHIXYL8xaY4xFvpFTmQhLEmLY1fHWqAjCLWjFCQYEkATto+GZQNH+ZiZo
	l4Kw242CpfzgwoPk6WkjdjelSLs8Ot4gDSTt+cvMpCwFTFSRv6HsZnWLiWbYt6OC0Fge7Pyxl4Z
	M1Z96C3/vYnrR4j4TXNxK/894g93mJL1NNbDy/KA7U+IdT2gQiHnK4mwvyVnCtpRcELAkm37nO/
	yizyHEnfHzS75JuT88wnbX+q5iOyGfoSlrWaQJeBDcm9plA7ipJ8BGfvNTSx3k37pM/5OUVBeem
	h05TKU84j8Eq42ZP2ICSvsSVN4fiXtmAI+h7qKXLjFrY2bSRGDlHsJNG5EA==
X-TM-Addin-ProductCode: EMS
Subject: [virtio-dev] [RFC PATCH 7/7] virtio_rtc: Add Arm Generic Timer cross-timestamping

Add PTP_SYS_OFFSET_PRECISE2 support on platforms using the Arm Generic
Timer, by forwarding the clocksource information from arm_arch_timer.

Support only the CP15 counter interfaces, since the memory-mapped
interfaces are not supported by the Virtio RTC draft spec [1].

[1] https://lists.oasis-open.org/archives/virtio-comment/202306/msg00592.html

Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
---
 drivers/virtio/Kconfig          | 13 ++++++++++
 drivers/virtio/Makefile         |  1 +
 drivers/virtio/virtio_rtc_arm.c | 44 +++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+)
 create mode 100644 drivers/virtio/virtio_rtc_arm.c

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 7369ecd7dd01..ed3f541032a0 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -203,4 +203,17 @@ config VIRTIO_RTC_PTP
 
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
index 000000000000..2367f054081c
--- /dev/null
+++ b/drivers/virtio/virtio_rtc_arm.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Provides cross-timestamp params for Arm.
+ *
+ * Copyright (C) 2022-2023 OpenSynergy GmbH
+ */
+
+#include <clocksource/arm_arch_timer.h>
+#include <linux/err.h>
+
+#include <uapi/linux/virtio_rtc.h>
+
+#include "virtio_rtc_internal.h"
+
+static const u16 viortc_hw_counters[] = { VIRTIO_RTC_COUNTER_ARM_VIRT,
+					  VIRTIO_RTC_COUNTER_ARM_PHYS };
+
+/* see header for doc */
+int viortc_hw_get_counters(const u16 **hw_counters, int *num_hw_counters)
+{
+	*hw_counters = viortc_hw_counters;
+	*num_hw_counters = ARRAY_SIZE(viortc_hw_counters);
+
+	return 0;
+}
+
+/* see header for doc */
+int viortc_hw_xtstamp_params(u16 *hw_counter, struct clocksource **cs)
+{
+	*cs = arch_timer_get_cs();
+
+	switch (arch_timer_counter_get_type()) {
+	case ARCH_COUNTER_CP15_VIRT:
+		*hw_counter = VIRTIO_RTC_COUNTER_ARM_VIRT;
+		break;
+	case ARCH_COUNTER_CP15_PHYS:
+		*hw_counter = VIRTIO_RTC_COUNTER_ARM_PHYS;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
-- 
2.39.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

