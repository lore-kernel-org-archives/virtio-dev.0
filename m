Return-Path: <virtio-dev-return-12148-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40211C7619A
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:42:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7A7E13309A
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:42:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6EB209865D6
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:42:56 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 641A19863C9; Tue, 11 Apr 2023 19:42:56 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 50B8998636E;
	Tue, 11 Apr 2023 19:42:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fs15HI4M2Ogn3xol/nZqt+sq625ypgGtgBWOgJNj11FzRxM5gXjt2PPTIkqy+KY8gU5cpRxxZMvN8VYTmuLSLH1amjsMGyo4sHsdyixSQmTZBbOVsCFHB+1RnW12ntgZV0qFxJjsv29FIcgg32PK7OJ/ioYzp5iSABg3IoFMiSovlbf8Dsd1YiFBiigKyxU9EaoWKEyeWNB1DFB17oP0Naou9tjtd1mCJipA1KT8wtSkMg1WLlTMLiAfXXvKADHIchO45Zy/3/EBe011qmzmISHKjnxHquQApnioIK9/QxB6Q1nVp0j+kc42GfmIA5p6Mlm7z0+ZUZjLwdOMhT5d1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTV0oFodIs1m1vrhsh7Gzh+MQSvJNEyr3e2kZBLX6u4=;
 b=FV9klrzcFHfHTtsqc+ok83HiH1t2aIgmD5gtl217LX+SAXDULhVG6i/Q1fnXqDqAaBUti1Xb1ISUqY/O0USvGNtdk5Lm/jEW650+YttEvj1r29iHNZLDRa3FVJHlHPxEplb9FP9miMqQOBnw1xnGfmUx7CBqEfV7Rve8K4fYQCMnGv+WvhOVqLT4zsI5e3APOGCbMiOvW5O/Oi8eUqLil2w9gEOMQwaYfK5ZGybmVqU42wT6g8s1YwJG9rbzQf5+ulyGlGtoee5fDqCfdXdBWoY6J6tZPIVvNGNtNx/khcpvfhguIvolUBELgDIR0oEn4azYgjKJcaxJuXKB4XRzKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
From: Parav Pandit <parav@nvidia.com>
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>,
	<pasic@linux.ibm.com>, <cohuck@redhat.com>
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Date: Tue, 11 Apr 2023 22:42:19 +0300
Message-ID: <20230411194220.752355-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230411194220.752355-1-parav@nvidia.com>
References: <20230411194220.752355-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT091:EE_|SN7PR12MB7180:EE_
X-MS-Office365-Filtering-Correlation-Id: d76741cc-01e5-4511-5800-08db3ac4eddf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fbRcwylhASoF1NdIShZChbuzGnx3TpPcXo23Y5Butre03gjd5vIUiAZtyzMK8nrqdwMLfUTERCgm/7fqHnn0jI04VhNTQgGTrL75hU4gMulh6cV228p7S6KxMUJ9Fwslesaq9B5C+InDuEA98svalVyLatRHAj6u1WOvUbMbcn2V0wOg/fAlTRAIZy5K0Es4wlHQJGK8hQpr4/H9BS4SlSp2fSFpVVNC/3GLmeyhl1Sumoi1OEbDSOpKWdKkxEVTgPm71iaJnbE1ss/kpIuFxAkkn2+UZ65MqssbEQsxVLaxqSnGb/gnP9mvVHI6qX2iJSAijMhqXpbSg3zrMnVGjqI4fYfNYjEi4t8qFcxyUguaBqbttxUJJJxzMxuHw+szM7uX4owZm005aQrPl3gpu76DLxMjtxjSReuvLvwmxEzFAnwoD67mbX4qswUjvEPv4jr27bNaYtM978Ym1pIU5e0G42Au5NjI9tBF0r8Xt43yVmFLRkuAZaLdhv/BEbf64diTuKm5FsiapM1hScgaBNePXsELcD5Z57hcrY7vs2I9Bb+S0nnzSDks8/h72W89dk43zANHk+omkA88nWS47BjnVdSdps9hbqJZMbe0ehH6t816xZDL4rB4ZJqMIeKAE6SfybsIgxfDRFyDuU1qhBO6yxgygK4uCKSpzmcV5GyacFeGAZlGHFw3TEmteJm877VaTwyCpos0P9QGHsWgaBXNVkogUtQ/02/p3Wu8SkwB1S0idnIXWwgTfpIaZ1Up+2HzBsqcdo68C0BTq+ITPvrBsrvmOdB6qj/Vxsqg7SE=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199021)(36840700001)(46966006)(40470700004)(36756003)(86362001)(41300700001)(110136005)(70586007)(316002)(478600001)(4326008)(70206006)(8676002)(54906003)(40480700001)(36860700001)(5660300002)(82310400005)(2906002)(8936002)(34070700002)(47076005)(82740400003)(356005)(16526019)(7636003)(186003)(6666004)(26005)(1076003)(107886003)(2616005)(426003)(336012)(83380400001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 19:42:48.0645
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d76741cc-01e5-4511-5800-08db3ac4eddf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7180
Subject: [virtio-dev] [PATCH 1/2] transport-pci: Improve config msix vector description

config_msix_vector is the register that holds the MSI-X vector number
for receiving configuration change related interrupts.

It is not "for MSI-X".

Hence, replace the confusing text with appropriate one.

Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>

---
changelog:
v0->v1:
- added 'here'
- dropped 'receiving'
---
 transport-pci.tex | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/transport-pci.tex b/transport-pci.tex
index 42be072..cb9fadd 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -343,7 +343,8 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
         Driver Feature Bits selected by \field{driver_feature_select}.
 
 \item[\field{config_msix_vector}]
-        The driver sets the Configuration Vector for MSI-X.
+        The driver writes an MSI-X vector number here for Configuration change
+        interrupts.
 
 \item[\field{num_queues}]
         The device specifies the maximum number of virtqueues supported here.
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

