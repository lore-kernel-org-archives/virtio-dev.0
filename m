Return-Path: <virtio-dev-return-11785-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74FCC761A6
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 20:54:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 44ACE157EF4
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 20:54:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 37E7298649D
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 20:54:39 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2E1D29863CE; Mon, 27 Mar 2023 20:54:39 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2D90A986599;
	Mon, 27 Mar 2023 20:54:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEnBmLm79xjQ1+h30MCsCJPS+iQtQ73WKC0oKmycBCIM/T4dm03yGDVnC3mxC8vjhjjw5weQQ3pfjbps+pEHNfqA2rW9xDSpkjaW027c56xG/7D/S6qFlGDf7JqOokPYvNdRGMgicq2LXz/RmoOYixaxz3iC8uAyR/emL78/oAe4BN6VuvFVscE9qn7S90XhUPqzteI3j/skrGnwjFDT/3QW5yVqPKetGFZTxoW7hPwXNKc4IohsJiXKjcXYfVNFNFfifJE/MABPGSoujyOdO+zWRG/zCzXiBOKpOgJhND+UP4c0mZ6I5GoEqHUoL8MSwEtkQ9Ph1Ck2wkXBOGjmoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uw/qSgmFdLMPw7nWkuQ7f3PJS2T3aLKWxhau2jjYlkk=;
 b=j85jIscS8Qy7DEeoFA41TpJwl0KbZ+8W0YVBntn9c6pWBcHHG2fv26erk+1RwXCZ6cNr8CsDebf9zlEfGfC98Ru/vlB6gm5tiHFJVQik05GQB5mh1l40R4zmt9ycch+KPGWQnavp1M4X5VFMCU9soCf8Zb2/8zSnYalnzO/5pPF+lxw4uzDXoghvA40lHvK8FM7b2P3hK7TtwHl5hO+TzJakhuyq81TZGSHfldEad8eQFp8YRB22hCneDZ32LS0qJ2J2lFfg2aU134AAQOkMP2xHdXw9D/hx3Qiz/KJTk6jpHb86nP++kyzWNE18J1xNMXKTteKFKO4UeXf4YDFoOw==
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
	<parav@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Date: Mon, 27 Mar 2023 23:53:53 +0300
Message-ID: <20230327205359.406605-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230327205359.406605-1-parav@nvidia.com>
References: <20230327205359.406605-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E632:EE_|MW3PR12MB4522:EE_
X-MS-Office365-Filtering-Correlation-Id: 856587dc-acea-4650-61c3-08db2f0570c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Zso+Nt3cZm2zj+FFk6qfJ7NK5GWQVwuT8QGXfSb+5E+f0OhmwwsYpvp5DUBasPy++4VOT1DVuyUPW5Zlk+uyIoIcgN98Yl58Xdz4ncKRR//TgCLUvOZsgYmE0j/7bmVAlEW8oVGonNfIzRptT8+tUF4j2xLaFQuH1oQ4RVxx8451UzG/6oZQLKdnXZSdNNrfQhjwfWemablCu9K7nZ/Rnueiq1z5DVLDsqXlxegaIJa3zZl/bh/WWMLNFTblBQKQ8r6p1PSTZELawEZ+V7UZjDlKScvpsuTJ6mR7nuC1sL7pQxD2sWjkc4Aul0tcPajwN2Hl8sd5hfKmmOQRoYiSYBQfyd/CA4Llehq1njmOPxX4a1Nx4Tap1t9xW6Zn9TVTyDjLSo/PNTYkParvaUEjOhatwk+sGST5xzDNWr7OCe942bxlu2Zeje22X9t6Mgmr6nK+FafKJj7wwvngMMN6VjK3rAW4HaSjHP9ST4lPnq4Bzt3zTCz6kXvmUQPtvpnd9YjSmYscPkggKJMe9o1W/eqAO0Dgb7aIz22+jcl5uzJDVy3mzaoqajvo4RvzGa4UCoW1Mp3NjQTqDu7ICCuYwAL8PTl82k84MijFmKv8JI2ddVRBcA57cD1E40XdLWkCks7PSeZZ8+kdrAq7xpkqgyAK2xr1IJ0CDzxsZLQJrfiO7qWIW0VhzYwFTMkAfHre96l/QUrtnXsvqTi1gdU1qU6sIEFi2p/u3XgzOGvTDImfocOLNXnNn6hBL58fJZUI6rVAh9s6QqE/88r+MBh/b13tD796vzNvfhx1DOxXsCM5EH7GXuJydn3AFlbIvXVhgGk/C2zbt32kWU1X6c8aZQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199021)(46966006)(40470700004)(36840700001)(54906003)(110136005)(966005)(316002)(478600001)(36756003)(2906002)(40460700003)(70206006)(40480700001)(4326008)(41300700001)(5660300002)(70586007)(8676002)(8936002)(356005)(82740400003)(7636003)(86362001)(16526019)(186003)(2616005)(82310400005)(1076003)(26005)(107886003)(6666004)(36860700001)(83380400001)(426003)(336012)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 20:54:21.4689
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 856587dc-acea-4650-61c3-08db2f0570c3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0000E632.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4522
Subject: [virtio-dev] [PATCH v7 2/8] transport-pci: Refer to the vq by its number

Currently specification uses virtqueue index and
number interchangeably to refer to the virtqueue.

Instead refer to it by its number.

This patch is on top of [1].

[1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00527.html

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v2->v3:
- addressed comments from Michael
- changed vqn to virtqueue number in the Note
- refer to vqn field instead of virtqueue number
---
 transport-pci.tex | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/transport-pci.tex b/transport-pci.tex
index b07a822..044c085 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -390,13 +390,15 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
 
 \item[\field{queue_notify_data}]
         This field exists only if VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated.
-        The driver will use this value to put it in the 'virtqueue number' field
-        in the available buffer notification structure.
+        The driver will use this value to put it in the field
+        \field{vqn} in the available buffer notification
+        structure.
         See section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Available Buffer Notifications}.
         \begin{note}
         This field provides the device with flexibility to determine how virtqueues
         will be referred to in available buffer notifications.
-        In a trivial case the device can set \field{queue_notify_data}=vqn. Some devices
+        In a trivial case the device can set
+        \field{queue_notify_data}=vq number. Some devices
         may benefit from providing another value, for example an internal virtqueue
         identifier, or an internal offset related to the virtqueue number.
         \end{note}
@@ -1005,7 +1007,7 @@ \subsubsection{Device Initialization}\label{sec:Virtio Transport Options / Virti
 The driver typically does this as follows, for each virtqueue a device has:
 
 \begin{enumerate}
-\item Write the virtqueue index (first queue is 0) to \field{queue_select}.
+\item Write the virtqueue number (first queue is 0) to \field{queue_select}.
 
 \item Read the virtqueue size from \field{queue_size}. This controls how big the virtqueue is
   (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}~\nameref{sec:Basic Facilities of a Virtio Device / Virtqueues}). If this field is 0, the virtqueue does not exist.
@@ -1035,7 +1037,7 @@ \subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport Option
 
 When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
 the driver sends an available buffer notification to the device by writing
-the 16-bit virtqueue index
+the 16-bit virtqueue number
 of this virtqueue to the Queue Notify address.
 
 When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
@@ -1053,7 +1055,7 @@ \subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport Option
 If VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated:
 \begin{itemize}
 \item If VIRTIO_F_NOTIFICATION_DATA has not been negotiated, the driver MUST use the
-\field{queue_notify_data} value instead of the virtqueue index.
+\field{queue_notify_data} value instead of the virtqueue number.
 \item If VIRTIO_F_NOTIFICATION_DATA has been negotiated, the driver MUST set the
 \field{vqn} field to the \field{queue_notify_data} value.
 \end{itemize}
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

