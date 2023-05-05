Return-Path: <virtio-dev-return-12565-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8188C77B7C
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 01:47:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id ABEDA142D74
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 01:47:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5670A9866F6
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 01:47:23 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4911E9866C0; Fri,  5 May 2023 01:47:23 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BA5599866D8;
	Fri,  5 May 2023 01:47:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lj46h/QEz3O12pFWnHazH9JDnerzazWAW61CIMQ5UG7fAT9bEH9AaBH+SuMMP+rYXc2CHLCaTr+j/b9MWrDc9O8t6Hm6p0sjYVy23zgkluZPvGKI8J629kcXt87lAT8+Lr/8mr/9dZu6I+rN8rpTUhcPgtslM8hB9aIOEUei3coH7LcGVDx47CihDzGsOFS5BNh5vBtwdRqaF/XZjaj8wYMKywNUdFWMRB0gyY3qdUmRLLjTjFU9peD0Q/NP5CyVdDnUaoWdoCtAD4/XZpyX15fNIe65mjDLqk6x4ahXrWRwo61JFOcsGRjSqloe9o+DBFrkbDgCnv7GCXujh2dm6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=te4Hc5Rl0s9hzd5GnJLQkqRPFY7D4crERYFvW7XRDFc=;
 b=QNgbusxmhor6wczToGErB+l9GfONJg5bJQVS94FDSxu6RKsCQHZs0RTPIMVDoffFPhjDxki5YDNVm3C1KhJemRbiSd2oqJaUkLmKKFQdVhhklAhrvnnrNRE5BP7JHwxe3bA46uqM2nZYuhBb6JEenYBRFwa9AEg1i/0M/PZ9ys2REBSPggQwgTe73stFnnS1UZijF1iKFJbuiCNNW+JwMi9xYbhyssIeSgm+riaHVKxdrs4DX443BzZj+p1QIu79NZ6pTBmSw+uWSLr24P3k1H5vTJKoQYMmlB35vYpLcm6Skb2KidrkSzFiljUHxhykLsA9FdhnjAE5JHKUZXLk/Q==
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
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>
CC: <sgarzare@redhat.com>, <pasic@linux.ibm.com>,
	<david.edmondson@oracle.com>, <virtio-comment@lists.oasis-open.org>,
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>
Date: Fri, 5 May 2023 04:46:12 +0300
Message-ID: <20230505014614.571520-10-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230505014614.571520-1-parav@nvidia.com>
References: <20230505014614.571520-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT088:EE_|DM4PR12MB5817:EE_
X-MS-Office365-Filtering-Correlation-Id: 35987b94-081a-4895-c3fd-08db4d0a9ddb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0z9kko9+AMDX3RQaPEwAhy48nbqSKuYmjo6hw9lCS3rItaue4S96n0KaZ6vKgCBx4egw6SowD2vUKND3Vo2OMeAO0KaXuNEe/3cun2Ns2E/CKrgsIuLAX7Zc6nDitlxzj6YE6s2tlG2GPIwRpXtjP1GwkQoU3gdx+E2ScqT162g/F9ZcRkmot6GLU0RMjpi/K/+tf8FIvizimvDuF2p4CJOVMsmnECsoMntVxa4UaJSbXd2tzof/cec5/lwsZfqP8X3kSZraYgNy0cRlUzsvKZcT1iwtGifdm7Id0h0xlLFzPvZVP7Tve1hcc62lxzMWqNb8hbnihWiGZZSqpIAJicDTqdQssDCR6oZ2LDMAN0UJXS6ZWHcI27TzVIhiW8lK8lN2PjszeXR0dyXy7fd02adzGUPGFnqGVNPnxOU8fMKFYefVITPeWdc7TUIohmXi9fBGOFayBNX3TqRAoIN0KPCpnPxVJqIk0fRpxANFOB4ziftJ6GtdqgHJszEnfZvRIElaxjM8Xvrza+3QK35BQ/t+Fv5sN6qLzYilJbatG+PAoYl4d9xvKY3Q/cUbWoIq0yPMzC/e4zqeor7ggOgs41Ee2BvmJEBMSVjBE1qVC68+0LBwea2uwZKh4WUa4/nFsePtPB52rcFq3hbxP/6i0dgvI9OVPLYMwohBmNuFOpzYLlzVkmtYLRUeXB6RadG2ePV0mc5+M7ROVwajJKbNG0vKmAB/TrRTEMr5JNWGOQPxDw7HiCSHOuxwY5Q1z2pZ
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199021)(36840700001)(46966006)(40470700004)(7636003)(40460700003)(316002)(966005)(16526019)(186003)(54906003)(356005)(107886003)(110136005)(8676002)(8936002)(1076003)(40480700001)(5660300002)(86362001)(36860700001)(82310400005)(26005)(426003)(336012)(6666004)(2616005)(83380400001)(2906002)(47076005)(478600001)(70586007)(41300700001)(4326008)(70206006)(82740400003)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 01:46:59.5088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35987b94-081a-4895-c3fd-08db4d0a9ddb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5817
Subject: [virtio-dev] [PATCH v17 09/11] virtio-net: Avoid duplicate receive queue example

Receive queue number/index example is duplicate which is already defined
in the Setting RSS parameters section.

Hence, avoid such duplicate example and prepare it for the subsequent
patch to describe using receive queue handle.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 device-types/net/description.tex | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/device-types/net/description.tex b/device-types/net/description.tex
index 875c4e6..f3f9f1d 100644
--- a/device-types/net/description.tex
+++ b/device-types/net/description.tex
@@ -1478,8 +1478,8 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 The device MUST determine the destination queue for a network packet as follows:
 \begin{itemize}
 \item Calculate the hash of the packet as defined in \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets}.
-\item If the device did not calculate the hash for the specific packet, the device directs the packet to the receiveq specified by \field{unclassified_queue} of virtio_net_rss_config structure (value of 0 corresponds to receiveq1).
-\item Apply \field{indirection_table_mask} to the calculated hash and use the result as the index in the indirection table to get 0-based number of destination receiveq (value of 0 corresponds to receiveq1).
+\item If the device did not calculate the hash for the specific packet, the device directs the packet to the receiveq specified by \field{unclassified_queue} of virtio_net_rss_config structure.
+\item Apply \field{indirection_table_mask} to the calculated hash and use the result as the index in the indirection table to get 0-based number of destination receiveq.
 \item If the destination receive queue is being reset (See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}), the device MUST drop the packet.
 \end{itemize}
 
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

