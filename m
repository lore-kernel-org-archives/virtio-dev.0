Return-Path: <virtio-dev-return-13292-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD1BEB64D9
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 21:28:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 06AD53E337
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 21:27:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F031B986836
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 21:27:56 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DC5CB98680F; Thu,  6 Jul 2023 21:27:56 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B2B2798683F;
	Thu,  6 Jul 2023 21:27:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxUNYlrh2DRToYtKAi04PNTZ6J3WUXMwx/CFAPT4MUb/pC3LjaTkamsHn/6mFcaesFxD5S7Gt+1pDZ6BQT1I9G4Erca28qAlmyM8FmPaNLZXimyuLlZJmlvmS8z/b8vg1+Z68R3xFtTb/7f5NU6WfJdpV9LUpq8yZCwgPaf+83coEGAGnK66R3vilDgNgX0/ZrJQE1/dTvfhKaZzFa3DEgKxSlYp3ddiqTIWlbBGNkMPFwCXheuyfuYQ1RwwASWJA0DUi7N2oTrFTs6Xj3szRevgYVgsBwyELdhcg08cDGdVpDo+gaOIHpDCudfDOG8KhugE42t2XjoS8yK4H6epkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cusiwnF3ysTXD7TrDhhGpsPI+2feieHxXyBPkJF3Nos=;
 b=UmwpbWMnb2lheDfDnYn3u08LidaryyAHByOoTkza5BF/Whgw6w3R7blUnAzNYQK0wCPmnSs5bCZ/gzQwsEoRA8jGBO+tsafPRNi7c7Uol4SfcNLHAj6EX93D7nVPua4mtGSYzNsRWStsnET6Hw4yt68U5byQUw4dG9/ksAAHZJlL4IY/MMZjr74U3Oij8yw1Rgz8ieqb57xpigTSapxJzBw4x2IwDs3nE/BwnmdbOjPwlXEDTXcfy+1MpQs84yi0uXOd1oH1bAj7LpIfFbpeT8qFHpB3uVDvAjaYpNsOdOYm69idixeva9J7xpcdNY0XY4P8oi64gfheblP3BOraKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.oasis-open.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
From: Parav Pandit <parav@nvidia.com>
To: <virtio-comment@lists.oasis-open.org>, <mst@redhat.com>,
	<cohuck@redhat.com>, <david.edmondson@oracle.com>
CC: <virtio-dev@lists.oasis-open.org>, <sburla@marvell.com>,
	<jasowang@redhat.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>
Date: Fri, 7 Jul 2023 00:27:21 +0300
Message-ID: <20230706212722.97973-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230706212722.97973-1-parav@nvidia.com>
References: <20230706212722.97973-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT089:EE_|DM6PR12MB4909:EE_
X-MS-Office365-Filtering-Correlation-Id: 84c3df71-deef-49b1-07da-08db7e67d769
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Xkm4q+aDly8Mmm4A3cQHEM5IQS/fdeymBrmGYi4TjNXHDBB5dVJSIZorokzIQR1CKKEC8iZ6akDqwHx97HZvk1vbuCTPaxi2U9kGcgTvMkoApQHSjvbczmE4zOvIuV8Kqb0jheCw6C8RJD1UJlWm1dqAU1FOIeT3BcbqMHuhL0BPIyjsnjRGhbdCU6HFhqJTiCZZRWiuhbpd90OfhaXb1uxgEmuMAhwmYotIONTxOKXkCCzBhVihsxbCV39hAt5BKkAt7MNOvfezRmd0np3i1cO35zG3tr2+ZMV5Ogewtpa7aspS/TsHR5DOZVyqncm6BrbcHHmFFe3eJAb9cWvx+79i1a5dOAV481SNIFnTQneASMWv0SOK2O/qfR4gvMrE6rM5jgVS/pyBILjkXPmj9j40j6gZMTZho0stidA2DxtiWwlCQaaSXYIjgF/97IBV3hW7WwbJaU7sRr94cVYYqWsyG3WH3a1oesSn6lEJj7JjDNnp7PsXifh2yDIg03WpapoyfoEdXzUmSQAgMD/4STtJ2HzkA+aQzhyc5mcmme/iAlbXQSgsioWuK1R+hCqWnVnLWu2wfYXMBDCbqk2wbEnWV1P4jhBMxoWOnhdKU3biomf6kVNgg93I5o4FygEvSzsHDGjx2lYFFjGlE7mpDr7UfS/gqBJ3+x78wieblQIUqBFHwerE6DJ/4L4J5I3Yf5OR5nzMRHsFB1ciczyo9fkbhgKsd0YYfHC0OaqDmgpCKkBk6L1WIJ4+vYXphCHW
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199021)(40470700004)(36840700001)(46966006)(82310400005)(7636003)(356005)(82740400003)(40480700001)(36756003)(86362001)(40460700003)(6666004)(478600001)(107886003)(186003)(16526019)(26005)(1076003)(8676002)(8936002)(5660300002)(70586007)(70206006)(110136005)(54906003)(41300700001)(4326008)(316002)(2906002)(36860700001)(426003)(336012)(2616005)(47076005)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 21:27:46.2210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c3df71-deef-49b1-07da-08db7e67d769
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4909
Subject: [virtio-dev] [PATCH v11 2/3] admin: Fix section numbering

Requirements are put one additional level down. Fix it.

Signed-off-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
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

