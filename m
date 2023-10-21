Return-Path: <virtio-dev-return-14010-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 716F3C00A8F
	for <virtio-dev@archiver.kernel.org>; Sat, 21 Oct 2023 03:51:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AE38D2AD71
	for <virtio-dev@archiver.kernel.org>; Sat, 21 Oct 2023 03:51:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 984E498695E
	for <virtio-dev@archiver.kernel.org>; Sat, 21 Oct 2023 03:51:55 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8BAF498694F; Sat, 21 Oct 2023 03:51:55 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 77760986950;
	Sat, 21 Oct 2023 03:51:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWaDWSyzqVFql+SBSqDQ5vLGw0pgD8PBWuq2DCfh/chVXGcxjTWhBoF+k1jKgdO3GbAqvZjrXaTyX1JdXHEknhRMjM773cRyTjlQ3R0bLj5zha06H2DzXMnzE7BAdGxgicmCexOK0M+SvehGB8+02BKylGgw29xX0h9zM94OgztUD3B/MQnPZF1pfPKJ0o42V8oGp3c5cjWtCWjXFIYgR8CP1w4IMlZ+YYf3g5tAn8xhohElmQ8q67TFeowUjhFQ9Gh8hXEwbIE44nm9Tzff5hSwV3X4VCYHC83Wl0zJhEioqPP8j7p4RSVgyDaOQMYRRXaJTleWhX9f8JzNAcxw+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6sGvljYb1UnJBsRXKLks3d8OT9JhzHpq79sb0jz568=;
 b=ISb3NTtJcz1IxW91TwFL1MLYjJRcPE9uklsRHYd/uGeSlenyBqkyRtH9ATvz9/yWu0MSJUTTk4L+Z5N3WJk1Jb525R2x1YNR/QIJ/RRP9S/tOWUHBagAgwZpCcJbEwEpQlbOyI6JbSebgwoLVijQtw31WMjScMIMMFlSLLgip4KCZwFuLh4imTRRKkVwZr0ejOgIZivlT5uMz5/qL2/UQc+264lXW/twgpc94VSxJFcJbMzz8lX6TYb40/4RYqSJb1Fez+xutf+S18WADiyck89ik7dScR9KlYO1dK6rie2S6m6frFmuqpH/Cn7y40fq5zQsroPe0l0UwfqSn9pwhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, David Airlie <airlied@redhat.com>, "Gurchetan
 Singh" <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, "Robert
 Beckett" <bob.beckett@collabora.com>, Mikhail Golubev-Ciuchea
	<Mikhail.Golubev-Ciuchea@opensynergy.com>,
	<virtio-comment@lists.oasis-open.org>, <virtio-dev@lists.oasis-open.org>
CC: Honglei Huang <Honglei1.Huang@amd.com>, Julia Zhang <Julia.Zhang@amd.com>,
	Huang Rui <Ray.Huang@amd.com>, Jiqian Chen <Jiqian.Chen@amd.com>
Date: Sat, 21 Oct 2023 11:51:10 +0800
Message-ID: <20231021035111.650248-1-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|SA1PR12MB7224:EE_
X-MS-Office365-Filtering-Correlation-Id: 8865c1fa-412a-4c21-5f44-08dbd1e90cff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1e/GffegkxUVTFoM4E018HRTXKspRgGUC25HsheDnWoRaIRKuB64EDk/WDZ0rXwQTC1Ln1hoVRj0EiwVl9eouKQxBC4Zpqb+478LjpTzqerh19OxjXOErEdSt46+v2msMcxYAv0KyNn+JdwzNZpTLgI22azW9/YXKBGapSqj81viCTdULi9qIt+pZfj1NV+9SgniylGzXaowHtgaKXHM6ef0mbhLgvywhRJTz/69jOD3N4/KOJfLCQhdnni/EIf3bnOjZmYSe9Dpx3heD4iRjXId5wehmwXPyphINVxhQUbyDVb3CNHcQgSaNWLUwKVjcldJtzwQzQrzSGrgP/HDk4xg6aVPiXm/tnE8x6X73ivhL40gM+Id4KAvZLhrzK0bKfTiUfepisfhTbmFinCSBId3Zwhdu58Rxd9zh1zk9BaKV+189XclXKFTHZ3Vr2TCl0ZZLjIPDb/PI+MQ/3j3lEeBy3MAMPxP4Yyf/fo6wLrt/v6RG1DphQJtr6kE+8El0KxnvBLaFVeMrVeUVv6FyNeC7A2+YAfOK0jHkhCRsnfGvKy+bdy3mKdl1BYiQgnZ7XPQT6fU2R2vc4vqCkc89ASg6nVeJ5YX5By0/LyokEfk/eJ/NIqEKIkOiHHGto8FwOAtP4fH7+RBiVt6oUc+K6THo2Tr6u0T4KeN+vuZWdJAz1aJromF+YalDrR7l/8Y/l5FUTIYlVDZEJv8we8r0OB/BgaNnkdBUCQBZo6q06SFyb5UPMs1kQgI62CzLpHxtd12cAz6Guxzkchp6CQpB0Fdm4qslRXU4MMSbzodTD0JKuQCIgwNqr4A0JM9Gmus
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(82310400011)(451199024)(1800799009)(186009)(64100799003)(36840700001)(46966006)(40470700004)(40480700001)(36756003)(40460700003)(54906003)(316002)(110136005)(70206006)(70586007)(921008)(86362001)(1076003)(82740400003)(356005)(81166007)(36860700001)(83380400001)(426003)(336012)(26005)(2616005)(16526019)(7696005)(6666004)(8936002)(2906002)(966005)(478600001)(41300700001)(5660300002)(8676002)(7416002)(47076005)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2023 03:51:47.8236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8865c1fa-412a-4c21-5f44-08dbd1e90cff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7224
Subject: [virtio-dev] [PATCH v6 0/1] Add new feature VIRTIO_F_PRESERVE_RESOURCES

Hi all,
This is the version 6, thank Michael S. Tsirkin, Parav Pandit and Jason Wang
for their suggestions, it made below changes:
* Declared a new feature bit
* Add the description of conformance
* Improve it to virtio device level
* Change the unsuitable description, use "preserve resources" to replace
  "freeze mode" to avoid mixing with freeze. This patch is to protect all
  the resources that can't be re-create but we still need them, not to
  trigger any suspend or freeze behavior.

Best regards,
Jiqian Chen

v5:
makes below changes:
* Since this series patches add a new mechanism that let virtgpu and Qemu can negotiate
  their reset behavior, and other guys hope me can improve this mechanism to virtio pci
  level, so that other virtio devices can also benefit from it. So instead of adding
  new feature flag VIRTIO_GPU_F_FREEZE_S3 only serves for virtgpu, v5 add a new parameter
  named freeze_mode to struct virtio_pci_common_cfg, when guest begin suspending, set
  freeze_mode to VIRTIO_PCI_FREEZE_MODE_FREEZE_S3, and then all virtio devices can get
  this status, and notice that guest is suspending, then they can change their reset
  behavior.
V5 of Qemu patch:
https://lore.kernel.org/qemu-devel/20230919110225.2282914-1-Jiqian.Chen@amd.com/T/#t
V5 of kernel patch:
https://lore.kernel.org/lkml/20230919104607.2282248-1-Jiqian.Chen@amd.com/T/#t


v4:
no v4 patches.
V4 of Qemu patch:
https://lore.kernel.org/qemu-devel/20230719074726.1613088-1-Jiqian.Chen@amd.com/T/#t
No v4 of kernel patch


v3:
makes below changes:
* Use enum for freeze mode, so this can be extended with more
  modes in the future.
* Rename functions and paratemers with "_S3" postfix.
* Explain in more detail
Link:
https://lists.oasis-open.org/archives/virtio-comment/202307/msg00209.html
V3 of Qemu patch:
https://lore.kernel.org/qemu-devel/20230720120816.8751-1-Jiqian.Chen@amd.com
V3 of Kernel patch: https://lore.kernel.org/lkml/20230720115805.8206-1-Jiqian.Chen@amd.com/T/#t


v2:
makes below changes:
* Elaborate on the types of resources.
* Add some descriptions for S3 and S4.
Link:
https://lists.oasis-open.org/archives/virtio-comment/202307/msg00160.html
V2 of Qemu patch:
https://lore.kernel.org/qemu-devel/20230630070016.841459-1-Jiqian.Chen@amd.com/T/#t
V2 of Kernel patch:
https://lore.kernel.org/lkml/20230630073448.842767-1-Jiqian.Chen@amd.com/T/#t


v1:
Hi all,
I am working to implement virtgpu S3 function on Xen.

Currently on Xen, if we start a guest through Qemu with enabling virtgpu, and then suspend and s3resume guest. We can find that the guest kernel comes back, but the display doesn't. It just shown a black screen.

That is because when guest was during suspending, it called into Qemu and Qemu destroyed all resources and reset renderer. This made the display gone after guest resumed.

So, I add a mechanism that when guest is suspending, it will notify Qemu, and then Qemu will not destroy resources. That can help guest's display come back.

As discussed and suggested by Robert Beckett and Gerd Hoffmann on v1 qemu's mailing list.
Due to that mechanism needs cooperation between guest and host. What's more, as virtio drivers by design paravirt drivers, it is reasonable for guest to accept some cooperation with host to manage suspend/resume. So I request to add a new feature flag, so that guest and host can negotiate whenever freezing is supported or not.
Link:
https://lists.oasis-open.org/archives/virtio-comment/202306/msg00595.html
V1 of Qemu patch:
https://lore.kernel.org/qemu-devel/20230608025655.1674357-2-Jiqian.Chen@amd.com/
V1 of Kernel patch:
https://lore.kernel.org/lkml/20230608063857.1677973-1-Jiqian.Chen@amd.com/


Jiqian Chen (1):
  content: Add new feature VIRTIO_F_PRESERVE_RESOURCES

 conformance.tex   |  2 ++
 content.tex       | 25 +++++++++++++++++++++++++
 transport-pci.tex |  6 ++++++
 3 files changed, 33 insertions(+)

-- 
2.34.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

