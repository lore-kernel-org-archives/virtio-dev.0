Return-Path: <virtio-dev-return-11271-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD72BC6FA8E
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Feb 2023 23:13:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 08CBD370F4
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Feb 2023 23:13:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 02BEC98679E
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Feb 2023 23:13:01 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EC4B098668B; Fri, 24 Feb 2023 23:13:00 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D2B6E986797;
	Fri, 24 Feb 2023 23:12:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHLJMe9KOVR6lN5bBNY1d9GvimlY4V2FRLuJY9AHEx7B5g0NXBxt3+HxYMz5E3ipxItFt6IsKXG7HQRwnZ7vycyAaPm5kW2VsqRNaa0ABSac9lD814rzPTvgaEpXMc5+QwH9PXg5RgD1MiB7++lONKmApRw97AN2lz0r3HgROeRLX85Wa2gwpukPpYAqN6KIne1KYQo6ynA6W0g6X7FEgI640KO2FNbmLsslhLp538KLj1ge0DIWKNVPes2+TYq2hOy4jMSZP1mkKRaRrdbwJYacDpPfAffrZsGsuGVWJCPrvBoBVXmN57rwLEmz+FIU647+AGh2kxVMZZVxySZwTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DILlKaLBDfU7PmniFGM9Nf0dqMEo6JAvquXF3ULZARo=;
 b=FhOOjzHYzB25QAvJX2hNdTQ7Dof39mJE+BEx/k7iG6etn8/kiAQpIB1TihmEGY3lJ2lWNusXOn+eoPlNlQRtKv8lgW+6bV2aoJFq5fIxM+jTfQ0qqZptx+L+UbtItVOe0SFlgx9f0kiYwPQPG9IbvXR2yOGSxThpIlHEpDaiCeRhlDDTnTD44kifMJtsd3Ug5LHQG3wKVaMgwr1WSaYkut1tyj9xjSePOaT1GHHsi8nCyFsUZDoZAYd1mBVkrkJLNZoYtWbdB/xtcIVbQA8em+ZfOZ6F9yerC99HbJ4QOcV8+gFmwUlL97roYck8KYiI76y3g0GXxUw89/INrLEw9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
From: Parav Pandit <parav@nvidia.com>
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Sat, 25 Feb 2023 01:12:30 +0200
Message-ID: <20230224231232.340814-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 drhqmail201.nvidia.com (10.126.190.180)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C96B:EE_|MW4PR12MB5643:EE_
X-MS-Office365-Filtering-Correlation-Id: eb1fdfab-2003-481d-7ef4-08db16bca83d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CTPLdMJsk+Wmgzuzm34SQG8hmlgmFvUWLFqp46Xi0DE5X6WGJXvG/riVuGQUxVa9Oj9p4bGOVGPVxHUWEZu4yT2dqMQMDIlP/dQ5fyCCPJsh8v4Jpwz3S7nRQM3IKgqN37Zn7s2qnHoYWkWQw6YQEXkgll+Ja0jC6nh8RyR2/U9gyWUPGJ1Xl75FSR33Mbj8GzbEcZpy7QY1xQttwWNKmnWxm0Lop3Bj7CIJtMr8jvcobrcrrJMTm7ObQ34R+2p9RUK3TJnucBhz5pXPlT3IdNk7FmcwcHN6tRpLawAp66c84pY/K8+rJbFaiZKAuKxrW8smeMn2S83pmoYz7PCKQ7O8AU74rFoWK5DccaWy+iYAKGLpQRsYttTjEVrjFGK+31dg1t+1KQs5/z3JU83u3C/ZR/nVTr0MdwT0ZxffXpCSN67YLUWJ2Gk1wKNTuBzljtv7rqeH8S858eHVAdMscKeJ3aOjjQ38G71jI4eA269dwICSMrtNHF9Obyky1TzV/4VD0HzJCX8EMnuQiyaGS21jrvLQtv+A/P49gR2VDtEqVskcx9QNkAFHaQ/xMe4Kj4a8AQEsGRr/QcsOEOpq/5SdEehaRmH1mf+dKHZhfMzyq19ZPNGl2uiir/nsMjP3FPdDxw1zkIU6ZggEtRZjtiRUw/8NR7dmK5abP+I6Z7NcCWG+tBMcF+vq8O0FFMxYme9aLoG75BVpPLp/xisTQomvrbvPrxvZvFW27JiDrZKyXuRHgPx10j8BStrggbUL
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199018)(36840700001)(46966006)(40470700004)(5660300002)(16526019)(7636003)(186003)(36860700001)(26005)(82740400003)(8936002)(40460700003)(2906002)(1076003)(356005)(70206006)(41300700001)(107886003)(6666004)(8676002)(2616005)(4326008)(966005)(70586007)(47076005)(110136005)(36756003)(478600001)(86362001)(82310400005)(316002)(54906003)(83380400001)(40480700001)(336012)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 23:12:53.4228
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb1fdfab-2003-481d-7ef4-08db16bca83d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000C96B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5643
Subject: [virtio-dev] [PATCH 0/2] Move transitional dev req to legacy interface
Message-ID: <20230224231230.K6Zu8Fc02sm5OWe4XLoVKh3v4dGjMLGMLcSg5taqVPM@z>

Currently, the PCI transitional device discovery requirements
are located in two sections. One it located in the regular device
section mixed with non-transitional device normative statements.
Some of them are already located in the second legacy interface
section.

‘Legacy interfaces’ is the section to describe transitional device
requirements as mentioned in the first legacy interface section
2.2.3.

Hence move these normative statements and requirements to the
Legacy interface section.

This is only an editorial change.

It is on top of series [1].

[1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00578.html

patch summary:
patch-1 use capital alphabets to define device id
patch-2 move pci device id normative statements adjacent to other
requirements


Parav Pandit (2):
  transport-pci: Use capital alphabets
  transport-pci: Move transitional device id to legacy section

 transport-pci.tex | 74 ++++++++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 36 deletions(-)

-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

