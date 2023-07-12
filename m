Return-Path: <virtio-dev-return-13342-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14130EB64D9
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 09:37:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 437E476048
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 09:37:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3BF199867B4
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 09:37:00 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2E19A986682; Wed, 12 Jul 2023 09:37:00 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 17DE6986663;
	Wed, 12 Jul 2023 09:36:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrTR2iyk1m/DyxtF8nOyffq/Bg6sjy42rNttZidjiJ0kvkWyRyS47G3hi5QgUVZL2Up4N7olGUgqMyCYw5O0pF5XcHxSeNuqGJFc0DwliScK9jgt0rwpOb+uS/xC4WHnsoy9FnlT/BoUe6hQw6T70MeSwpgFxdB2po3XjBPVnlo8CHkEYxGsAjLZpn33isTZfnH0N6w/wjWlKJvPUlm9SRFttHnis5RBV+9F3/j6N+m+cOsCEoRG4ZbZmgp9drDTG/wN6FLWSFUxJbzUzLdiKsq+OdGWiGDo8i4+GoKAtvk4kqwXp8RNsTrFC9qKSdk9Ow1b2GTqoF3xD6uEcF5EMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qqck5if5dtkaLgJZdXUd3+d+eCI21Xo3SuWYVjd5/fA=;
 b=ADHUrSEpDxWBV814/ZGcHowSjxJNbDSsdzazxUikvjQw50ERAOZl4pj+SBBilAdzUGSqnVup/Kus8sV4zpKlynkE+3MMjRLi9VHcx8wqrp+Ei+kJo8+zKz4vv62KxrbjbSkXcmpwqj44SGqRO+aEPUiBukljkme8//jSCvoac6+RJgY2ZGvJJxQFVWpE3b2qKeZlUjA7XOr+qnCpHZ055HSMuEPPgM0JIpxb5C82zYc3RZ/ooDm+LO1qemLFGXgVM0JolsnEKoLOjU0cho+iRZZXzDG+OnJajqo+4M4ihYBvYTRlS0W11UVELJmWPsKjTBuGtK94xbl8NBlMX/WYpg==
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
Date: Wed, 12 Jul 2023 17:36:28 +0800
Message-ID: <20230712093629.1410765-1-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT088:EE_|CY8PR12MB8297:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d1f7dab-8462-458c-d06c-08db82bb8434
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+ekQnExsad6gZ6d/LFvt4CYeNhaHZnTNbdybGfTXV9M/5/eCKofyNkt4Xb+jnaPVzvLWqnvMx5+T2ygW1nWS5PGXmsjr9yiSaKD/juYazUBoWSWMTJG/1y42E9BxraGEF9rkf9/TN2ZIeCYLTHnUf3t+Oc2xbNrFLsJAp7FvV+4nOti5l2ubloGXeoiMvP1nxpRsBLcMR1qaFm4P5kATRo2/e2uT1TpBE+ZPREQEo40u8QcItytli8JRLO5EKpU12C6gct+OHZdkJnRlSFf80MGZNm7k4UDerf6ozkj/LDX4+xfeM2eiZXCx38gLoIwN3PBHzln8E8fH+asKK/JnzT469lVxNb0uXbRsx43RMqxnZeXjKA17F8DeGmrPnEVrYHAMpIr6aLZfvdhOKMUQYPWuO2IPAJ8WwS1XMqbarsTLPhsBms8wgZa45zmUOVUKJGHQSOkJDzmIqDlqbNhngPOiw/fI185FsCJHErZiSTNxpf4+qiDbUgY1I68IurBAr4r+VHUhZdlruZVpBYep28QeGXJ3NDo1KrBSfsPkWEE+nm1GDc9Yw8Wb1BHUtktgYskyDowjfBcs5i63RQXgJdwa3BlhuEhwfeqfJSu68Ig5T5PSYkwzeDmkuLv5qIudDlHnCpjfwt/GviSkxUAklUaNwLOFxmFwjdAyGph4nt3rjevgDGBNDc8KQD2kabPP0QoXNVHkyV1ggU4eBqvDfHzieSPT0X5g5pcfU5b2s1gF3Q2Nc1MI7wxCqEOxEVYSjvW5ZmgmiqbbiA9XQWRNxzGTWRAcYy7VRn8RHm9WYiI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199021)(46966006)(36840700001)(40470700004)(8676002)(8936002)(5660300002)(36860700001)(186003)(16526019)(47076005)(2616005)(83380400001)(26005)(86362001)(41300700001)(1076003)(6666004)(7696005)(82310400005)(966005)(336012)(426003)(316002)(356005)(36756003)(2906002)(40460700003)(70206006)(82740400003)(70586007)(40480700001)(81166007)(54906003)(478600001)(110136005)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 09:36:49.0824
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1f7dab-8462-458c-d06c-08db82bb8434
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8297
Subject: [virtio-dev] [VIRTIO GPU PATCH v2 0/1] Add new feature flag VIRTIO_GPU_F_FREEZING

v2:

Hi all,
Thanks to Gerd Hoffmann for his suggestions. V2 makes below changes:
* Elaborate on the types of resources.
* Add some descriptions for S3 and S4.


v1:

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

Attach the patches of Qemu and kernel:
        Qemu
                v1: https://lore.kernel.org/qemu-devel/20230608025655.1674357-2-Jiqian.Chen@amd.com/
                v2: https://lore.kernel.org/qemu-devel/20230630070016.841459-1-Jiqian.Chen@amd.com/T/#t
        Kernel
                v1: https://lore.kernel.org/lkml/20230608063857.1677973-1-Jiqian.Chen@amd.com/
                v2: https://lore.kernel.org/lkml/20230630073448.842767-1-Jiqian.Chen@amd.com/T/#t

Best regards,
Jiqian Chen.

Jiqian Chen (1):
  virtio-gpu: Add new feature flag VIRTIO_GPU_F_FREEZING

 device-types/gpu/description.tex | 35 ++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

-- 
2.34.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

