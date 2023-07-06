Return-Path: <virtio-dev-return-13246-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6391DEB64D9
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 04:21:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9AB9CC527
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 04:20:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 07CED986812
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 04:20:41 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id AC73A986894; Thu,  6 Jul 2023 04:20:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 555E9986726;
	Thu,  6 Jul 2023 04:19:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QN7OK304ZFqsGO1pKcJbD5JaWbHJLUswhpOyxi4/w856fgZFd4j5xkyZ/OlMPwyVHkzqvM5VaAP3rVtHxxgyOxukVX3kGDWWUtlQ7sHsqH52/5zC+XnmT1QI7F4jfbqYJpt3BWN+frIQK/L9mzvzs/dYZ4akcLIkqYrr9UiJnl0DjnPs8T/ePsVgCh0WC7DW9VzSjJVA4BWmogupE8qpD2mD3M9hP2rmKrQxbtlF/Rq7/z/dI8GA4v8hGGbhgcBavMKVwqLYa2AqCzv9iTmuZxawQn94bhhZfJOPGE422PdX7rROKhyK8LaNEwmQ4kaablovXLBW/8JPtQZ1wvJrSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8S1A7FFyTvWFH5/AQ+yPFVr74UsNy4ZPxVY0AQpM/hw=;
 b=R/dywD74fHINJQlkkLRcuQoSqV9Ioj7CAFeV4WZ2MPGg6lMXQmaVqsZmbA4k0/3N1XAsAbsiOoJLVOgtrUGE/S9FgW4UHs2kvxiiZc9LOZwv719vJtiWf9kUjIgcDWfGn9hmzfNWKKNJ+YbyZuO5gJKATqrAEy0ueVsEsKb2dt8dDgLEnbPT2g/YZtZWORPfiOSncfW1v+kxCf86BshTsWnUnIJamaCtWvhmon5VgM+dA52jEH6li9qdTT8sOnsNhvNDUthHQ01xYgCALJaoELoz1a5Td1WacPksna82dDLTCNh98wO6vWvHwc2btA3aaJPpa5ENEE2XziiHOgfpfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.oasis-open.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
From: Parav Pandit <parav@nvidia.com>
To: <virtio-comment@lists.oasis-open.org>, <mst@redhat.com>,
	<cohuck@redhat.com>, <david.edmondson@oracle.com>
CC: <virtio-dev@lists.oasis-open.org>, <sburla@marvell.com>,
	<jasowang@redhat.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>
Date: Thu, 6 Jul 2023 07:17:12 +0300
Message-ID: <20230706041714.65600-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230706041714.65600-1-parav@nvidia.com>
References: <20230706041714.65600-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT093:EE_|DS0PR12MB8218:EE_
X-MS-Office365-Filtering-Correlation-Id: 06e97ec6-43f8-4900-cb22-08db7dd82594
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MRJq/DO/yOJ8lXSnz6a4Um9zc0r71KKdohAp3TwjQJcdqt93nBj7ElilDvAMl86EgHw+D1nbX/00/Khw9htJyMxTL7TXtU8h+podwpIGvK/H6SsbSPFw2HxTj9oKm8xUB0KrRHRWSOuXwpKapko9R9kqb8e4HDpCzHuXmMfobzE79ystI7QQ0y/1VTWF+rXjqQObfC/xFLRii29jxef35RY6Oi/Ev3T40ZZ6m2SJbSqXVFsyqc+eoV7i2wcIjVjZwHdSCAIAvKiVSn54cXzxdhjk+V+DpTkwDQwls+wOSo4E+4MREekXBIn+n3j44ssRX5tHox5Ry9ztzbkUv51b6CB4rcgEKL2BZ+Flvk5yHtU2BNUrg04m/1g6eW7/M6Zb6BmgFvaVOQS8GrcoeC3u8nuXGTfGD2BolFxMJijNlLaoDcmT5gAu5iHv1NLqTpHyFoj/+XLuFSVsAk9e7TbT/nsHoKoAQ/O0yjnrITF6zJGxvQuIt2bEKVkk+wKv21XIBVcQrJDDLc2wKmFAm96QBZ/6Xg1C5tbQpBNKl9lyq0K8YzQXX9BTtpJP3xyaj21MlppGJPOiHHexOZRE99DC2g2UDvZVjNWfqejaZwo+F+imO/OwMDau3qC6/nSefH2y6G+iYY8zc5qajwbo7lB+90jczrJczZ1XqrgA4NUuf56gnBaV/pSJ/DNJ3QGIzd5yJmojPJwyqq+hBrgxvyARZWpeCwSXinwXIpPwAX8LVPV0cnCTdQX+w6ABBKHffrxa
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199021)(46966006)(36840700001)(40470700004)(478600001)(70206006)(6666004)(70586007)(110136005)(54906003)(16526019)(26005)(186003)(1076003)(107886003)(2906002)(82310400005)(336012)(41300700001)(5660300002)(4326008)(316002)(8936002)(8676002)(356005)(7636003)(82740400003)(83380400001)(40460700003)(36756003)(426003)(47076005)(2616005)(36860700001)(86362001)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 04:19:09.9035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e97ec6-43f8-4900-cb22-08db7dd82594
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8218
Subject: [virtio-dev] [PATCH v10 2/4] admin: Fix section numbering

Requirements are put one additional level down. Fix it.

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v9->v10:
- addressed comments from Cornelia
- fixed requirements for administration virtqueue section
v4->v5:
- new patch
---
 admin.tex | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/admin.tex b/admin.tex
index e51f9e6..b0a1a91 100644
--- a/admin.tex
+++ b/admin.tex
@@ -286,7 +286,7 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
 supporting multiple group types, the list of supported commands
 might differ between different group types.
 
-\devicenormative{\paragraph}{Group administration commands}{Basic Facilities of a Virtio Device / Device groups / Group administration commands}
+\devicenormative{\subsubsection}{Group administration commands}{Basic Facilities of a Virtio Device / Device groups / Group administration commands}
 
 The device MUST validate \field{opcode}, \field{group_type} and
 \field{group_member_id}, and if any of these has an invalid or
@@ -378,7 +378,7 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
 \field{VF Enable} refer to registers within the SR-IOV Extended
 Capability as specified by \hyperref[intro:PCIe]{[PCIe]}.
 
-\drivernormative{\paragraph}{Group administration commands}{Basic Facilities of a Virtio Device / Device groups / Group administration commands}
+\drivernormative{\subsubsection}{Group administration commands}{Basic Facilities of a Virtio Device / Device groups / Group administration commands}
 
 The driver MAY discover whether device supports a specific group type
 by issuing VIRTIO_ADMIN_CMD_LIST_QUERY with the matching
@@ -506,7 +506,7 @@ \section{Administration Virtqueues}\label{sec:Basic Facilities of a Virtio Devic
 tail of a structure, with the driver/device using the full
 structure without concern for versioning.
 
-\devicenormative{\paragraph}{Group administration commands}{Basic Facilities of a Virtio Device / Administration virtqueues}
+\devicenormative{\subsection}{Group administration commands}{Basic Facilities of a Virtio Device / Administration virtqueues}
 
 The device MUST support device-readable and device-writeable buffers
 shorter than described in this specification, by
@@ -555,7 +555,7 @@ \section{Administration Virtqueues}\label{sec:Basic Facilities of a Virtio Devic
 or VIRTIO_ADMIN_STATUS_ENOMEM, then the command MUST NOT
 have any side effects, making it safe to retry.
 
-\drivernormative{\paragraph}{Group administration commands}{Basic Facilities of a Virtio Device / Administration virtqueues}
+\drivernormative{\subsection}{Group administration commands}{Basic Facilities of a Virtio Device / Administration virtqueues}
 
 The driver MAY supply device-readable or device-writeable parts
 of \field{struct virtio_admin_cmd} that are longer than described in
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

