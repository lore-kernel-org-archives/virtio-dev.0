Return-Path: <virtio-dev-return-12149-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA5FC7619A
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:43:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4EF2B41A28
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:42:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3B3D5986617
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:42:59 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 31C329865F9; Tue, 11 Apr 2023 19:42:59 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1FA779865EE;
	Tue, 11 Apr 2023 19:42:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azxJmVE+WgvYtvkaWtQBIlq4Jf+TVBGW69MjmkuewC7tfpgFJShfCpQP5Zxe6XYk13y2kAiA3DcYmXW/BQNsvU2ktwu9gF0wzNgdIjnvc879QvZq9s3VAWtutUKtL6U52Bpz+duOY4UZ/DieJsD5EzdG/GsHK9UQakbOZq/bnim/jHQf1b5vb3gUxdgiB0435vhpXOBUfxCDGEdRV5iWZaUmueYpzvi/6zMNLf55japTtGVIxUHOym5Ct5Lj1KYEYuqd3SBrQawaxWYyO+UXM1cYIR5qXUoC4Qst45UjBhEEBZEd9ShzslApyHPVHK85s05S++HuwW3DoD5MZfUhvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmKC6QQoEfxm4D1FnDUCdkpJNUg3bCggrWxd1nW7HmI=;
 b=P3BZI0rPm1kbBERmjUFRQ5+53BKkc2/XTL6SziT4jsYUTfphMALFbc6nrRKOq1RdR4SYYfdoTdCSyuFxu3O7Llc1CAsMp5UmfrL7t8ORc2Y4SD36lFRFSdnC/7mx6rypxPN5/f3Xwcnu6wVr5M4xjBF5HJ2ElJPe+Pdbxxft7rp16Q868/DqO37s8dwzs2DedIFCa0WXqJG4RvEH//kMNiAZLqKxl+e7bO4EsxqTBR2G54xn1uNaRzKPH2qieG6/VPwgOu84qrXGX7aVYxrkJupWoaQzZlAMYACSMYGejK5MDkHANM3+Fo0ZRdpmYbZROZC0AGk+dAG0Gq70M/kk1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
From: Parav Pandit <parav@nvidia.com>
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>,
	<pasic@linux.ibm.com>, <cohuck@redhat.com>
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Date: Tue, 11 Apr 2023 22:42:20 +0300
Message-ID: <20230411194220.752355-3-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT033:EE_|PH0PR12MB5498:EE_
X-MS-Office365-Filtering-Correlation-Id: d3362c2d-95e0-496b-6f17-08db3ac4f1c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zMhY4OPTQjUagzUorrz8sDEbV4YwtesT8QiantqO7o3NrA8VjTlbI2AHxCdWGGTz5hY2Kr6r5NHMrCUUw1Y/Yhz0knM9cUEAHM2VdHGkfJMCvbBk7ONFqDhXtvfNeSNNAmGcv4PuE2PaN/IQu58n8+LUghA7tBbFVR2SpyFsR7IQ27avnII8cvVRW8dO3FZDpNAvHC0yOhXOkurPDWDeiqdMXQSua2LSWn0Rn2APAcRs6ZAtUapzpXDlZkkBfAzbqdV/Q61ctqICRnyhMDzRInOx1p02lxnHVXELHB3BsWUMYtO+Mh7YZTyprCfQlDibjuh4/p6ALoGR1EIEA5QgwqT+FRAq2Drl1xUSA9DQ8z+6ugEmuIsY0+dsluZh97rpnPyrbh6r9D5TNc+N27u+knNRX7LjkXr8RwIAxP3+t+vU1APVP6WfRy/9eF/hr8CzVR0Y9cByFzMMc3rMr4UEEgn+R0ye2j3Oh0rvQnDnPSmesBBfNrvoAex00OIJmhziu16FXb6xxTfSbBc/ULPBFFraw4CzGctBQxhhguG+XmBqddr3Rcn3MIHxwPtOoXN34jbDIMTzuG+vJ2tq4Ji/fPf3Smkv1vFXxyPpWxOi+VxQBU4k8o58AB8NGlraiUe/pwqJm1xPKVAeork72qMUA3sz6F2NebaTiIymFIDVsBtn+kW0wSLxDHvSIH7M1GV1+yAtwLTN2pPvSe0TH5YnqnJ21HFsTLWA6O0/4lBEVGEQzguQbMRG2vJval2djUnrfyej38aXp796DjoDUMRD60li555aXSoc2ytdHXBUKrY=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199021)(36840700001)(46966006)(40470700004)(36860700001)(36756003)(5660300002)(2906002)(40460700003)(316002)(8676002)(86362001)(40480700001)(8936002)(70206006)(70586007)(4326008)(7636003)(356005)(41300700001)(82310400005)(82740400003)(2616005)(83380400001)(47076005)(426003)(336012)(34070700002)(54906003)(107886003)(186003)(26005)(110136005)(1076003)(478600001)(16526019)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 19:42:54.6006
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3362c2d-95e0-496b-6f17-08db3ac4f1c9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5498
Subject: [virtio-dev] [PATCH 2/2] transport-pci: Improve queue msix vector register desc

queue_msix_vector register is for receiving interrupts from the device
for the virtqueue.

"for MSI-X" is confusing term.

Also it is the register that driver "writes" to, similar to
many other registers such as queue_desc, queue_driver etc.

Hence, replace the verb from use to write.

Signed-off-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
changelog:
v0->v1:
- added 'here'
- dropped 'receiving'
---
 transport-pci.tex | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/transport-pci.tex b/transport-pci.tex
index cb9fadd..00669b5 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -367,7 +367,7 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
         A 0 means the queue is unavailable.
 
 \item[\field{queue_msix_vector}]
-        The driver uses this to specify the queue vector for MSI-X.
+        The driver writes an MSI-X vector number here for virtqueue interrupts.
 
 \item[\field{queue_enable}]
         The driver uses this to selectively prevent the device from executing requests from this virtqueue.
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

