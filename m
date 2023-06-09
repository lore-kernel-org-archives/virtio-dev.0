Return-Path: <virtio-dev-return-12905-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2896BC7EE23
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 02:03:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 790512AC66
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 02:03:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 66C1A98669C
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 02:03:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 570969842E9; Fri,  9 Jun 2023 02:03:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3EBD098668D;
	Fri,  9 Jun 2023 02:03:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArmnH3cwJMF6ypHm1L6m4seqCdvb0PBA/riLs72k6odAJEzYoh6cRs9ohPNBcE1TrBqdNtpy4e9TASHkhfmDuSUnrBA4XLdY6pVMSNY50XT+H8uTFDT9vzTZMjdYvvh2wTMsBYk4XlkWuHVtyMJQ2uqoQ4Abyq3ZU8k2RBXQPinJAoJ10/6SQbya+wSsvHp0TcM9kfVYKG7napvP7sWR2Wn02t8Usj3UJCYDMp3Em5+WoSDsfbj+DKc5n+UFQGALhXwfre/npqgTVrzxD6m4iQhXuQxledBkIpUKADOUXtgDI3DcgH2vDSn+TbTMn3Z920Fva9n6opkCEk7cZ0MNFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpnhhKY+AZMWGOlUxfddk+CfiwFN+mL4rsv45y7CulA=;
 b=E/3RO9n8jL2eHPMDKexXFEqKajnJKMD/W2HdIckbOhX8I25dyrdFkDG3kIwGdaao2Hor9n/wY+dDj6I+227R1sYQ3zbJ/os247yaHvDqdoRpu09yNaORbzkEdkoSh0ReoQCYDdcOjr5Kz0m+Qs5RP+axomE8txk963bPiuhnTBAQJms4V0GcXNA9NUf4HFQnF2bqeP/mHO01rtX5NdxQO4zQdu8TQbTiKgix0vBHHtCbcsIIY9BQI1vaqK+dIP4kI/Fx27jU0J0W3sr6hMFW6qar62uWwEQsgivGMaUOXDzhKhg7oyPPUUFqtc9YRTu/H2uzUygDqBDRvSUE97M3Hw==
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
Date: Fri, 9 Jun 2023 05:02:45 +0300
Message-ID: <20230609020248.869700-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230609020248.869700-1-parav@nvidia.com>
References: <20230609020248.869700-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT071:EE_|SA3PR12MB7923:EE_
X-MS-Office365-Filtering-Correlation-Id: 73ac5aa5-dbf0-414f-3176-08db688db191
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Py9NjjlNtRiVHx3zRjkRYyDMFPiXHIund6X6LI5XbzPOJ1Ei33CkyK/P0Zbf8kJBXgSEtOwxeks3XmXghILfj4pl+X6517aQdlYEUsulFgfuuO06b1HvTOR9oI2yOLNwtyFiN4uq8tfcgYwc+//G4dfImaHkpmEmTpjjlH0XrwTg+QzMCS11LhfgLlEzl4+uLaqX9L2y2Y6xH9g5GfkT7rKinYgqPOQQRa7mTkUaW3pBihvifUKyMUQl9yfRv0f6J0HuDRazL0sp8F+BDNaCDIGgs7mFRsljw9IzgzjFu51W5ANtIVfyZQNTRs8cOhpvIwG1EL2H9mAko5uJn+YcTmQOGfjVXhcrr2+Yqw4NUZiu95W3LZvJoGa9HWb07HYKZxFw/0bZaLbKuSLSz3EYgxPd3ZHXrKyMkI1LLyH8sLoV56TUF/V294YW9OFvvFatUXlluVUuAJ7+Dqlmy6O/W/c2hRpM2F1E7bvwMlzd338oXGlmucfOFn2NCQYT4Zk8SCk1Nybo1CtwRbgvLKu+QUpkMKRWgJtzWEkDM8eEEFrze3Vceq3XYXYaesblT/7wkKxadWFRjnZz3hrFu5q7cfMKHG68w59GY+1BgpkCThXvyS2hoRQWNHNhUFTl9fjdwx0aWYg3H6VqS3B+Iquw734v1j8Oq+UsrU6yr19vSTcxqT8x2sH/YhbjFUfvSIzcSEzii4T6wF7ORhVoEtxJf88Id59nAkfbyPBtqR4Osl4E5Fq3mbkq+HHQ3x5/CK4+
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(26005)(40460700003)(6666004)(82740400003)(107886003)(40480700001)(36860700001)(1076003)(426003)(336012)(47076005)(16526019)(2616005)(186003)(83380400001)(110136005)(316002)(86362001)(82310400005)(36756003)(70206006)(70586007)(54906003)(4326008)(5660300002)(8676002)(8936002)(7636003)(2906002)(4744005)(356005)(41300700001)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 02:03:18.0411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ac5aa5-dbf0-414f-3176-08db688db191
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7923
Subject: [virtio-dev] [PATCH v5 1/4] admin: Split opcode table rows with a line

Currently all opcode appears to be in a single row.
Separate them with a line similar to other tables.

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v2->v3:
- new patch
---
 admin.tex | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/admin.tex b/admin.tex
index 2efd4d7..e51f9e6 100644
--- a/admin.tex
+++ b/admin.tex
@@ -114,7 +114,9 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
 opcode & Name & Command Description \\
 \hline \hline
 0x0000 & VIRTIO_ADMIN_CMD_LIST_QUERY & Provides to driver list of commands supported for this group type    \\
+\hline
 0x0001 & VIRTIO_ADMIN_CMD_LIST_USE & Provides to device list of commands used for this group type \\
+\hline
 0x0002 - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}    \\
 \hline
 0x8000 - 0xFFFF & - & Reserved for future commands (possibly using a different structure)    \\
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

