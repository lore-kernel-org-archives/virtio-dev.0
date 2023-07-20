Return-Path: <virtio-dev-return-13389-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F2A3EB64DD
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Jul 2023 12:20:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 752227388D
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Jul 2023 12:20:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6E773986818
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Jul 2023 12:20:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5DBEB98680C; Thu, 20 Jul 2023 12:20:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2B0E598680D;
	Thu, 20 Jul 2023 12:19:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRhhB/XgobrqkZDioVwn2mer5KBjlOb5G3SskOTCtKsSoE3YuLSnJktOQrnzc3rcy9yKrLZ2YFmLhBXdHwp/4aqwhzZkLHoImXCz8A7PI3cHCihogflIPzHSNi7r7+TvoaKtCqg3gIy7e2Lt3wCloZ0Do2cAd/9nSuC4PYjzAYzIEx4HCiGOiNXzcHv4itLhbA9K5Y9GUChactXcUAMGqHqeSP0lm8FNS765t/+mswPqC5yQnSxDLWx9B2yP6UwvV8SUotXC6KIxJt8v4YA7j2Snp3ZMM1LKMtcBijTr1g8mEJtKKejKe2EfXcp6x7BGupXY4oTVDUa3V9LCXq1Lew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jf9qStTQTFRWnnmoCOaXVyGMqrSWFQgJWFWoWTIhHuA=;
 b=B+IXYL/oR7GB3ZHXDhqmLlXtWDH6AMEogL8H4vAHYueaZ11Os47si7NWr1r8mx3H81E8Nw/YID4frIfDZ2Rqz3KzUB/aNbG6NUN8ruOstE3uaB7kBgG0Gm1YnaPqdwBmwLsNJHhbp3vl1elHADaDYZ0mpWfwBjf5whHLzLk7Lak1+ROcKEJ+J4Ii4dI0yHOOuvkEyDyzP6LcCi0BneGVpVMcUuZsCeW62zm8/9lyF0tGT4KYSlqnJSwv2NQRX4yXmce7VwdS6SMpBADim8xRk8QqKfSQ6nYLXiddpD+F8eMpyxcz1Mo1G/I0MW9SbLFx0rEMRusyJvqMa4zfFevphQ==
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
To: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?=
	<marcandre.lureau@gmail.com>, Robert Beckett <bob.beckett@collabora.com>,
	<virtio-comment@lists.oasis-open.org>, <virtio-dev@lists.oasis-open.org>
CC: Stefano Stabellini <sstabellini@kernel.org>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>, Alex Deucher
	<Alexander.Deucher@amd.com>, Christian Koenig <Christian.Koenig@amd.com>,
	Stewart Hildebrand <Stewart.Hildebrand@amd.com>, Xenia Ragiadakou
	<burzalodowa@gmail.com>, Honglei Huang <Honglei1.Huang@amd.com>, Julia Zhang
	<Julia.Zhang@amd.com>, Huang Rui <Ray.Huang@amd.com>, Jiqian Chen
	<Jiqian.Chen@amd.com>
Date: Thu, 20 Jul 2023 20:18:43 +0800
Message-ID: <20230720121844.8956-1-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT085:EE_|SJ2PR12MB8876:EE_
X-MS-Office365-Filtering-Correlation-Id: 988a7b31-82ca-4dec-4f81-08db891b8292
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SWyjYX4olqMqyP7TnFAvdLwjgNZyKh8iGuBDQU9YMo7av/pogwLK7Acrp4F2dc/25TSsaapfF0M05cbMMBQ0RYrr2QaMDwmuPvJmXTP5YPjp/sXkGGobpJdFZsARQopp7BV3a161mIZpAYdjOaWi8oaSF/L9iVd9lsOUoiN5CwHk1PaRWo8u6mF7IvR1x1u0MKhpd6FuyhAgOYD5sOPHFIGB5x+Ouw27oILRoWWRcg0/HUqi4mH2Up65IWMmDh8Spla9v/Tb4UvgRZgFPpkdsHRFzowTA0y8yogdGgcqf6iJPU2qR6NFGSE9w1+3OdV1mL7BJGllDqsz/oUFOnvY8Tk7TlA4xyN1bZXF0v5fHh56ApSsWiFCZBf+qd28XUz6mgdU7rEftMcwmKuWHyBwIGU8wwF7QNIXMicrnVOSuGNXGKXZIznUxXNua3SMU0j4i0DFMOZlM0kH4dFhooU3jl5j/RJdVjCgx1h5GxBg3oVslqxzhI+oXzVLdr73+KOWN9KzKFK8Y0FhniC7HQpcpIxfCmBL9kH6i4ClcisoTiyEit1/iGVxavoes+2TeffGnlrBFN945CSJuzZTlrc/h7TtZeNNBAdDCAIBDyruAyvsI/1Z54EZknMox8K0KIxXSb+aqk7XJyil1Tg6VRJPLBiCJVHanP9BpB7EAC7fukEv69dsywbqXPILJzX1hfE5BmhJ7s29FlsgRtjhtKCtpuIJ1kWsruukt6UdcFbUBtVkioIroOmYmDIu22kf0tEz7Y1yyWhSgymBGIzM4qn/UrC4gUuP9WrLigxSIzqo0KY=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(7696005)(6666004)(478600001)(54906003)(110136005)(426003)(47076005)(36860700001)(36756003)(2616005)(83380400001)(40460700003)(186003)(40480700001)(26005)(16526019)(2906002)(81166007)(1076003)(336012)(86362001)(966005)(4326008)(70586007)(8676002)(41300700001)(316002)(356005)(70206006)(82740400003)(8936002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 12:19:05.0024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 988a7b31-82ca-4dec-4f81-08db891b8292
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8876
Subject: [virtio-dev] [VIRTIO GPU PATCH v3 0/1] Add new feature flag VIRTIO_GPU_F_FREEZE_S3

v3:

Hi all,
Thanks for Gerd Hoffmann's advice. V3 makes below changes:
* Use enum for freeze mode, so this can be extended with more
  modes in the future.
* Rename functions and paratemers with "_S3" postfix.
* Explain in more detail

And latest version on QEMU and Linux kernel side:
	QEMU: https://lore.kernel.org/qemu-devel/20230720120816.8751-1-Jiqian.Chen@amd.com
	Kernel: https://lore.kernel.org/lkml/20230720115805.8206-1-Jiqian.Chen@amd.com/T/#t

Best regards,
Jiqian Chen.


v2:
link,
https://lists.oasis-open.org/archives/virtio-comment/202307/msg00160.html

Hi all,
Thanks to Gerd Hoffmann for his suggestions. V2 makes below changes:
* Elaborate on the types of resources.
* Add some descriptions for S3 and S4.


v1:
link,
https://lists.oasis-open.org/archives/virtio-comment/202306/msg00595.html

Hi all,
I am working to implement virtgpu S3 function on Xen.

Currently on Xen, if we start a guest through Qemu with enabling virtgpu,
and then suspend and s3resume guest. We can find that the guest kernel
comes back, but the display doesn't. It just shown a black screen.

That is because when guest was during suspending, it called into Qemu and
Qemu destroyed all resources and reset renderer. This made the display
gone after guest resumed.

So, I add a mechanism that when guest is suspending, it will notify Qemu,
and then Qemu will not destroy resources. That can help guest's display
come back.

As discussed and suggested by Robert Beckett and Gerd Hoffmann on v1
qemu's mailing list. Due to that mechanism needs cooperation between
guest and host. What's more, as virtio drivers by design paravirt
drivers, it is reasonable for guest to accept some cooperation with host
to manage suspend/resume. So I request to add a new feature flag, so that
guest and host can negotiate whenever freezing is supported or not.

Jiqian Chen (1):
  virtio-gpu: Add new feature flag VIRTIO_GPU_F_FREEZE_S3

 device-types/gpu/description.tex | 42 ++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

-- 
2.34.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

