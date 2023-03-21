Return-Path: <virtio-dev-return-11691-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 810B2C6FD1D
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 21:59:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 22FEC1318C4
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 21:59:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1B7149864AD
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 21:59:19 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0FF57986475; Tue, 21 Mar 2023 21:59:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E7FB09864B8;
	Tue, 21 Mar 2023 21:59:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtkeW8ITfBNtnEv7Ty84/Zv5z9hDpkW0vs5N+Z7gQxyADsKMmWO/uwiMxPxgHj6EtGjjT50aJQIXxw5C8t/2wv2dhWOpTBDvekhOoqvYjqZ+lfoudk8bc4uEQevvE7mEG82YHKwIURIIbTBZMOQ2040cKyOJJIJZ5v2iDcL0bTBTg36e2ju7YRYTyP/qVnHZADjzXSTaChGdrcCqU3i2gHhlqMmH/jrTRzpOxqUFAVlUhXS8DmR6M2p//BoIWUL/CmJuoCF/0r0Q18dVLZ+nq1My0cVlomzSQ43NoEXCbznMtXU1xPdO5WzCKs2hDR67bZ6rkrKMnAsddwI445sdvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=endzE8e8srqAsOtj09NhPJXNKyARwdFDkFMFOJLw3oc=;
 b=eWuhbhm0WuPV+ZwgTilEpStrtfDXVGNafN80iJCEaJGbMDyhX5b+kx4A9s0uc/fcX0Gc6kPcYLfCrjxcS/9QrsxACyf0qhIZ2ePm7XJyFKQFJk5kR5MvTlv2BmsghcAmccy0FdtKTpOhxh6cQFJ2jULre+WxoL++pudzydZ96mIHfdONbKAHqsmL1O/lk9whyylLo7koGGZsOI6iFMWmt/4pddNb1UbSFxc7nlHuHkxf36ulGzhAAm283pmmO9hqO4y5zEmeOMODuQTVhmnKqXXCMl8zKYqX002EbueiWPwNRrVpw4YKvhTsaHeaBvJi7r4Yj8NEnum5TkUT/Wp5yA==
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
	<parav@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Date: Tue, 21 Mar 2023 23:58:30 +0200
Message-ID: <20230321215834.225856-5-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230321215834.225856-1-parav@nvidia.com>
References: <20230321215834.225856-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT019:EE_|PH8PR12MB7349:EE_
X-MS-Office365-Filtering-Correlation-Id: 8529090d-f119-492e-5b06-08db2a577dc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WW8LBdBhq5lWg90gGWzkk0Irffudp2riouhD315rNBEYrjRD0liGHVFkSltG+B/rYD6sIGF1H3tlrbLm3Z7N4uqc7zzpsGpNtWlwoDPD4HJUpOVSF1DLXO89r0WvEXa11bX9uMIJ1NMt3ueVyOGf+tw/v7pjZ9MMp7rgL1sL/Hfq45eoZN6VzCNxG6b7IRo6sBiDss8UKH6axiTO8ZMD19OZSronl5VjiBzi9vgF4mHFmVoBod8xRcENoc2EDgnzTvJQoTaXHPBlCQSB6HoZEXApKy7uXI6iuHnIYfrpkWlt43/Twq1l5R0+PPA66OiZ9jrYPBWxuq4UIdU67s/BS5rcU5yn5unZ/uIEQGESaAOb1hGZT5JFs6L+UPxXvruGlJq9OIcfDchLHqevpPpny+aZQLFahJKPFGGGZpIA3cTQMm2i/TdH2BlTGbh/+6cTf9JcGqYDrzUGRNbanhpY/yq4mw6amH2GdMC3yUXubfrMptmI/hULop8YIRaFdjrhs0+un5OLKaQ9Nzf0MaCe7HNDJS3FD4OsFS/rIt4LPBgsOZVMCSPtEKWB/iO/ZWyE0oij2BITWV0zRzvoTKPp3iXhlZDynEjKVzjffNIuXAcHqIpc0lGXmFRaqdRIGlvE3Edrb78hVS34DvRGfP+LRUEaVp/uQxNyN9uVsN2KyZJMRLhvjWR8yP46KvPZPM0qtBnNvJjuyL8SlTv3rONbPjeqFJOxQdjfT9kmaXdxNbqUi2W735jW5+r54wgEVBZ7egdJZnHV1VvjiAYswB1KCFvwxtJlhjPjTmKeq00L0wE=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199018)(36840700001)(40470700004)(46966006)(478600001)(40480700001)(41300700001)(36860700001)(83380400001)(40460700003)(316002)(8676002)(4326008)(70206006)(70586007)(54906003)(186003)(110136005)(16526019)(26005)(2616005)(1076003)(336012)(6666004)(86362001)(82310400005)(107886003)(36756003)(82740400003)(2906002)(8936002)(5660300002)(7636003)(966005)(47076005)(426003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 21:59:06.1996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8529090d-f119-492e-5b06-08db2a577dc1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7349
Subject: [virtio-dev] [PATCH v3 4/8] transport-mmio: Refer to the vq by its number

Currently specification uses virtqueue index and
number interchangeably to refer to the virtqueue.

Instead refer to it by its number.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 transport-mmio.tex | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/transport-mmio.tex b/transport-mmio.tex
index 3047633..f9b3a34 100644
--- a/transport-mmio.tex
+++ b/transport-mmio.tex
@@ -108,7 +108,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
     bits accessible by writing to \field{DriverFeatures}.
   }
   \hline
-  \mmioreg{QueueSel}{Virtual queue index}{0x030}{W}{%
+  \mmioreg{QueueSel}{Virtual queue number}{0x030}{W}{%
     Writing to this register selects the virtual queue that the
     following operations on \field{QueueSizeMax},
     \field{QueueSize}, \field{QueueReady},
@@ -149,7 +149,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
     there are new buffers to process in a queue.
 
     When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
-    the value written is the queue index.
+    the value written is the queue number.
 
     When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
     the \field{Notification data} value has the following format:
@@ -363,8 +363,7 @@ \subsubsection{Virtqueue Configuration}\label{sec:Virtio Transport Options / Vir
 The driver will typically initialize the virtual queue in the following way:
 
 \begin{enumerate}
-\item Select the queue writing its index (first queue is 0) to
-   \field{QueueSel}.
+\item Select the queue writing its number to \field{QueueSel}.
 
 \item Check if the queue is not already in use: read \field{QueueReady},
    and expect a returned value of zero (0x0).
@@ -392,7 +391,7 @@ \subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport Option
 
 When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
 the driver sends an available buffer notification to the device by writing
-the 16-bit virtqueue index
+the 16-bit virtqueue number
 of the queue to be notified to \field{QueueNotify}.
 
 When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
@@ -470,7 +469,7 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
     (see QueuePFN).
   }
   \hline
-  \mmioreg{QueueSel}{Virtual queue index}{0x030}{W}{%
+  \mmioreg{QueueSel}{Virtual queue number}{0x030}{W}{%
     Writing to this register selects the virtual queue that the
     following operations on the \field{QueueSizeMax},
     \field{QueueSize}, \field{QueueAlign}
@@ -550,8 +549,7 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
 
 The virtual queue is configured as follows:
 \begin{enumerate}
-\item Select the queue writing its index (first queue is 0) to
-   \field{QueueSel}.
+\item Select the queue writing its number to \field{QueueSel}.
 
 \item Check if the queue is not already in use: read \field{QueuePFN},
    expecting a returned value of zero (0x0).
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

