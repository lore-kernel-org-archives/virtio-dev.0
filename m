Return-Path: <virtio-dev-return-14366-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB55EC47DD9
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Feb 2024 14:28:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 137A926A29
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Feb 2024 14:28:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E5A62986591
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Feb 2024 14:28:05 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C537E986445; Wed, 28 Feb 2024 14:28:05 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B4F80986478
	for <virtio-dev@lists.oasis-open.org>; Wed, 28 Feb 2024 14:28:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1709130482.555000
X-TM-MAIL-UUID: b87ca807-3a99-4a9f-ba48-222bb185718e
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UidLQtGN4jiBr3upsnE4iIVFBXOpaJvECL08uFD9xXr/fbuJ+Q6HpbVSWDb6ISj5qQytxHgHIoHYDcS+h1OLIw7ep2MyES4HLdYN4/N+Q3hpnQuFk4oUZmo0hgusS7xXL6c6pxzfSKE4btsdoBTG7CbfOGzJ36BIip4qQ1FqYHyjeP/srevAfJ9Z746a3/c9hBXYHKYFkoBIlQ+vlM5wtdz9WHKLgIodwJBt4WsZXIlUJNraxnf9YlOkfM8ezD18PqMTls0PlEStkSdvON8gPgQYY7WTkyh5ySXCUsV/Wd1qfvfJaaS/KaZaQ10oGEYB1tHy35s2m/ZSqMwXdSeabg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgqwcFQA4akIkJAuAlqUX0IBOrtaip8D9sVqIdUbFqw=;
 b=M1XWElRWQXUl+3s7NhA63feSSNc4vrNOEX737h8rQ8Z6tCgxFhH6ESVNFuRWZ9tnKx7NLII7qcuvhDZjnPmR32DaXGgfQGBmjmGedytXfMXqg6lZv1Ref/azKarIDh1x2q5ii4TXtDVlaAvvI80kZGz2eSQ7hblHxlE9GJhyhUZbHF/D/MzLQA2RypQwreNJ/uRADRBVfigJpIR+jD6Xyg0I6uuNEUv3p9VC2zkCPPXzR1oYyjaytOAbLyq9NYIdzuo2RFitcV9AbXC/p2R7munzYqSuAZgyxiol6SgxOJkBhT9iUPcbXxYmnwgZJ1llhjroyGJClKwqAGIu1CgXjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=kernel.org smtp.mailfrom=opensynergy.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=opensynergy.com; dkim=none (message not signed); arc=none (0)
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.66.60.4)
 smtp.mailfrom=opensynergy.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=opensynergy.com;
Received-SPF: Pass (protection.outlook.com: domain of opensynergy.com
 designates 217.66.60.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.66.60.4; helo=SR-MAIL-03.open-synergy.com; pr=C
From: Harald Mommer <Harald.Mommer@opensynergy.com>
To: virtio-dev@lists.oasis-open.org,
	Haixu Cui <quic_haixcui@quicinc.com>,
	Mark Brown <broonie@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: quic_ztu@quicinc.com,
	Matti Moell <Matti.Moell@opensynergy.com>,
	Mikhail Golubev <Mikhail.Golubev@opensynergy.com>,
	Harald Mommer <harald.mommer@opensynergy.com>
Date: Wed, 28 Feb 2024 15:27:53 +0100
Message-Id: <20240228142755.4061-2-Harald.Mommer@opensynergy.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240228142755.4061-1-Harald.Mommer@opensynergy.com>
References: <20240228142755.4061-1-Harald.Mommer@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004A:EE_|FR0P281MB2089:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 19302f3d-9bb7-4d0d-e351-08dc386977ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DLxstYOV5VE0Rx2v5EGhWTy/UprEI4S6l9o/4xsvKU5vI2+abH34D2F1hqFu4ygSGZlp96zqJe0g4l0Bb8rmhmoOUd8KrA7W5EztK72J+z+FxjmT6NqKVUy0jC6jDHu+n28M5dqoB1+mVXTc8wnnQqfqNP5HfAiywoVl4NspA9RXXO1psQ6tBqfjzk1TdJa6mAu8Jj+G+sgcYl+gesraiUBRG++h8T9/f8WbiUpo+9dKJBWdfoeCiQni7Bwj1GwN26bdEZ14JPfbxQjyYhVNpNSC73ebSJ+NlGnk5nVYfikux7T09JayjRT1CdlmDxWPunmfkhY2+zFdQA+1qopTTHmzQUsPc2nN8fmojn02BAWyU2OTT7aGZwxRhJTBuOavMZFoyusG8X69j3AqfF5puEipSPvxXT1JxZWfDG0YfK4x7jmFFOfiH1m8IiOx4NUJtXt9WFFYTLskVm/Jkfx1JlT7GWfY5ztomGPPfBcPcGOaZuQ3M0Lpt/KyQPFiwIDHe0Slt6YoTxL3gCIfWpuOW8eKC9mBtm/N9SiRlFYyan6eFhdpZiUIqGcku3EDZT8S+7k4xGwLKJP4gZSoki/N6df0gICglkqGxIcSpY30B11EkI5fG2Sx2nmw3ty+YW6eyMIGBEvPJOMTzp2MrZyQY4W47P3j309HgC1zZJn5paY6/9Qr2+uykp3W3Q3NRyhJsVyFf4VjSCUbu+MvXR/Jh+M5o9Z+bKz74Z8EiA+kQVVg1Vc3Qmq4RnVxmz3U/Kmo
X-Forefront-Antispam-Report:
	CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 14:28:01.1493
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19302f3d-9bb7-4d0d-e351-08dc386977ca
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB2089
X-TM-AS-ERS: 104.47.7.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28218.007
X-TMASE-Result: 10-0.491300-4.000000
X-TMASE-MatchedRID: Dkfyeyxtv0bJ+P2VFrJmrBkPtuOr7qUwbNjTSFpLxCgW+iZuJylrLk9A
	UWTSPmMGupoogdfVK+Jd4x1IUlKnFM8TyCfmBrmqW8gh3wzbqBNwRUdni9UCWPdzaXqYo8IqVxH
	vEGsKrsW/2tJ3foSBQiPzRlrdFGDwfH2QXwfwYBCUHCQ9y5SdWZ7ayFyYRC038/sI6NCSAcVCG+
	H1Pc3TBA==
X-TMASE-XGENCLOUD: b735a1cf-1976-4b90-88e2-ddd3f7a8b3b8-0-0-200-0
X-TM-Deliver-Signature: 2D089C40A783FCB8D0BEF08BB5813936
X-TM-Addin-Auth: RF7bVIu8C1u3az0nbR3z5Z6BQGKYS8nVx01kJQjkD80RVb2jz8Y9WzU+RfQ
	NyapUVYJ3zdyS0AxYF7E/za/BeqQq8tTy7x1zDnHg/7Rvn6gKO5FYd6mSjwGxuoABuW5Iur+o0H
	xpbAyf3R8U7+z0+D1U7ye3baBJgvw/5gKjT7ky1w0vN7me9F2Zv8WcWU6jGxmJzkeBrJ3fZoxBz
	GkdqJAyl80m0f1ht+KsC4JnqqZoO64+41MZt8styPtYFtyD4Nplo/godsysrjeOK8SQUnnIVOUk
	PJsXQP5Ywzod9Vc=.kWi2Git16ehkPFoCCU2yoyVxBZwQdc7DcNZ8p1OReEPiaR31xzmWOv2g5L
	TJ4zZqF3xypSW8DgagUs3HKILIIhlVnfPaqmvqMfJBcuxyn7OVAyoS8wYeLC4DizqjzzPV/s6mI
	dwpUHj6sNlT3hYf3/GCtiOu8/MFqwR8g4p4ee78ZomLatF54kqMBgJaJ0Rfw3NPK/6mFDepP2lo
	RxwEb6ja74vZz3n+QWjsjf/3UtwT/5D6pSctDvfFl+kgpMjQ+XHUu76lk7PBFuYJGFk0iVogPgI
	SZaoDAPC3rXKzPWDUy5uBbZasNI0Lqywyb4vxYOJ0SbPMz5KI9DWJRkAc6Q==
X-TM-Addin-ProductCode: EMS
Subject: [virtio-dev] [PATCH v1 1/3] virtio: Add ID for virtio SPI.

From: Harald Mommer <harald.mommer@opensynergy.com>

Add #define ID VIRTIO_ID_SPI 45 for virtio SPI.

Signed-off-by: Harald Mommer <harald.mommer@opensynergy.com>
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/uapi/linux/virtio_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
index 7aa2eb766205..6c12db16faa3 100644
--- a/include/uapi/linux/virtio_ids.h
+++ b/include/uapi/linux/virtio_ids.h
@@ -68,6 +68,7 @@
 #define VIRTIO_ID_AUDIO_POLICY		39 /* virtio audio policy */
 #define VIRTIO_ID_BT			40 /* virtio bluetooth */
 #define VIRTIO_ID_GPIO			41 /* virtio gpio */
+#define VIRTIO_ID_SPI			45 /* virtio spi */
 
 /*
  * Virtio Transitional IDs
-- 
2.25.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

