Return-Path: <virtio-dev-return-13297-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A9ACC0015E
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 03:54:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CBF103356A
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 03:54:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 76EF6986864
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 03:54:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4BACE98684A; Fri,  7 Jul 2023 03:54:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BE00398681C;
	Fri,  7 Jul 2023 03:54:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPJjIJKkdsZOH0ly59pMbsHjWEYmDf8ntHrU+zIZsGK8MODBXDqCAk/rqrAEcdY/NSZm0ZulSenJJKDxcdRzlL4N2B6yt4+vShbzT3zqLomH6V94jHxMaUmaMzH6Gwt++njOeLU6u9fHt48cckaPpLnVt/4VvcDLjHc7R8atViYcGgNGzTM2AAtgU5cy/YM4+YnoGDP8FDwkTN6mcDGhnrCftwKKKHGCYEyFMU8jQxUSdJwym9rWV5T39I2lGPB4Ku8uk6azoJMNiIQEzqxvil1DPrceoVjSg6lU+EMj5ttEzsBjeykJe4Ey9DKeMBqj0I76hG7TUMxf1zt+vBL7dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cusiwnF3ysTXD7TrDhhGpsPI+2feieHxXyBPkJF3Nos=;
 b=PEN/xliWAnOF0yuahRYQOCatctFj04oCa8NXWi59FD0EkHish9bxsg180nNDW/Ve5dQhRlUsy4DaAywqhQuJby7WWiuRJ0W1wjOvzzpjvXdCtwHnGPcx4l/9h7FzmJWjpUyHqlkOPpUK/ed0RNAmwzkDZlD4wWu3+uL2G6V5oRuQiNcoZk8sl/rlrsUN2gev1l2WRFQqdZgBSzd3fi+OIroSxMRspakMAtrOo866zrL6AySMhhmb7aOFDctBXbAlo4wK36X4KXqvi7b1AgANRPcS6SRNzo1TlEl2lidrYmnFGriKWro5DgFcNa2dvohei40HrU4Q4UoVqy7d531yoQ==
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
Date: Fri, 7 Jul 2023 06:54:00 +0300
Message-ID: <20230707035401.107855-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230707035401.107855-1-parav@nvidia.com>
References: <20230707035401.107855-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT066:EE_|CH3PR12MB9313:EE_
X-MS-Office365-Filtering-Correlation-Id: 51ca7d2e-46e3-4f9a-dc05-08db7e9ddaf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bXb86YcY8LaUywpbsG+VF3pKWr3bMHr5wL67qyQRWhB0BOdR2m7zZadVvqrFSBLC3ZxtpK055thfOKn++Km/oxjK9SUqzIZSk8dQwHMUqLE4b4E9hlMaS1vfyfuNrtby+OzwR9ImZHYe2bt8yzhpJVeTGwuj2IE3pBZ/0/ggeXywxfmCmpS0uDml0zoQ28zV43QE4Nu36wmi8fix0FSyHX5aFTsjJPaLE5xv6HD+i8hW4VA/zr+BqTksFbT653y0+760Y9J7k7WYSPXSmgz9OBxnG9q99fqL/rGiYdaQKSc06XucJW54g4kAE4yHFzqB8h4xnh1xRofk96T8/d2jetV5Kqww/kJoJDz4szBFCxsU1NJ79GpQnq8meu9XObUCA1rNQgFhxnfTYR2VTnV24crwCLuYFujKJPuhDNXCDCNSZLKWnrM7FhBZS2L4J5kxZ9vERr+q/Lmc84e+AD/EgjL9IxTXErQdv5VHvHMvfevfjeTFDQz1pJiJ3WDuftAKxhN8P4IMDMckKBTCMIMdrlW75O553eHGl6kcfLoi2tIeyy2rZdwUGhpR6TsqIO/mwtP8JBWg8qcnUG34C57Wd9lwc3+UKuLSXIHqb6g0p4ub3Ss4cKvo/O/8jtcMXX2Qd/bE5acT6Tyeevz0Lk+EHM8yLIfxFpoI5VxOvx/vubxdvRjzxq2FK1D7bII+IXwHh/8gt2jbO4QdxtRk1l2web/5w4JkjYaWLnddIRw9E7zRzDR6Xdb4AqyvcxEW6h1f
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199021)(46966006)(40470700004)(36840700001)(478600001)(6666004)(54906003)(110136005)(1076003)(26005)(40460700003)(16526019)(186003)(107886003)(70206006)(70586007)(2906002)(82310400005)(316002)(41300700001)(4326008)(5660300002)(8936002)(8676002)(356005)(7636003)(82740400003)(86362001)(36756003)(47076005)(36860700001)(83380400001)(2616005)(336012)(426003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 03:54:24.9743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ca7d2e-46e3-4f9a-dc05-08db7e9ddaf1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9313
Subject: [virtio-dev] [PATCH v12 2/3] admin: Fix section numbering

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

