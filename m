Return-Path: <virtio-dev-return-11761-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE53DC74A5B
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 01:06:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 63E8142A84
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 01:05:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5BA88986486
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 01:05:43 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4E34B98642D; Fri, 24 Mar 2023 01:05:43 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E9F10986462;
	Fri, 24 Mar 2023 01:05:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEJY/Hvlv6HeqIogJTLbF05lL7BIb08CowpRAoG6XkXmpRF4WdVbAQZJ0XVCf36qapgBGxI1IebDrtwhvrTDHFni6ngLV9uxWPphRqXyCyVxVKHNaVaKByj4qVzagp2E1Tmaqa9ZquS7ujfXEDMtkKPYJVzq3A7HhllkD5Ss1iyBcsWi5fNMPdGDoO+tOqaKgalfN6ganfSYWi0DPF18hofjf3IuiJTZpuaCPBgYyNSPp/U4jPKEyBRwLhEjUq5Tz58uE3WkvwcjvLHT4lW3TzRtFZaKI0k/292E2lqLZRatL1SK9H9Z4xhyHx0UU/oY90P9vZxgAmEYZoR1PiSTgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=endzE8e8srqAsOtj09NhPJXNKyARwdFDkFMFOJLw3oc=;
 b=TjME3wUBOUu2RLElQNgiFEGJ5nyAcNl0heHJfmCSvONcUzDeBmx5ThRzcvnlpIA2YdzKEcA7eJbLQMpIbx/PkeLReoj9wAy6PCsibtbgNCso0R2R7E7yHWymBXDvrZA1R7q50jjNijVLCEwaIJ13fYXHZ0g5MEmf552LL48ji1ylxg4KIuZ1rVpAzGRq9xg9b5rPJftkeF5bB1zE2BbBUNn70mjUzyN/35AIURfFuba3yt/o5284+MZlm6D7G+mubAV7JvUiq3aOtH87um581eqv5V2ISdaBT7jaNNo9Xj8YjkgDYZppSt8JnE/aMyssRvpu0SDl1OiJNU8Lq3OApw==
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
Date: Fri, 24 Mar 2023 04:04:28 +0300
Message-ID: <20230324010432.280330-5-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230324010432.280330-1-parav@nvidia.com>
References: <20230324010432.280330-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT062:EE_|PH8PR12MB7229:EE_
X-MS-Office365-Filtering-Correlation-Id: 04135c38-93ca-4db5-d108-08db2c03cbde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GUtKP1IETyqj62pytyOg2Dop8lcFrwaRmq9halz1etUU28IDAWXItmns5/vbxAmfV/qKHAx125H+jRlt4vre5f3lcnah4hwnEYGowNr83YY8wRyNj0J8J6gW0QbpH2uthR9fwnoTysr7MfZCGeALvIP5i9Q9Xi+gWaLI5zCBPo33j7MRgbEQ4zxBKVPWvGg7AQGnIf1hSFmeceHrKHxGsipDLG7cQINXTg6nGY4fGV9b4gTVFTXtAz11UDC9Wx9peaaeDTmFP97TH6rJLV8Wh8Yr3KQy+hGKgkwX7B2PPro6Pl2RG/pBtUSqW9Z20vWJZ/ZL0rrQ8KBLHMykP+aF3vx3mPSyRJFDiPwEZJXvFxZWj/LgF36A1XNx6oRxKhVAAi7gs9e6EzbqwedUOZh80hM06URWDAjhWOcLv1VRlCTJNnfnaHB7raHi+qyxefK7+jNhpmcmq0VJlS5mFMulS/y9zaLt8z1sqwKkpqeGdmtLOXIBAxE5WN+heY8BzXDpCymH2JOYRSXP1XNYxs52m0R3c5YKUv5Ynuq06e1EqybbqOH1f+lXXU5Dml1wao7ji06ROPLp14O04W0vCokA9cfU4GgtTsCKdFRHITA2zuetYThw+e3s4+UPzrt7l6J4FYJMEddl2YSdGRyHiaytcnGpRh6m1KWoXodsYuhp6Czetuf7IGDn2sGqNwIH6rW/15PB27I1T6clfdOHZ1r0NvhNFS0+KZPgrqK7glyrqukrYJJ6K6TtUz855As2fzxgBVKGCc3DB9Npm7lHHAVT8yjgqZK6jd4DKsCSqRKFn3A=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199018)(40470700004)(36840700001)(46966006)(36756003)(40460700003)(4326008)(86362001)(8676002)(41300700001)(8936002)(70586007)(70206006)(966005)(316002)(110136005)(54906003)(478600001)(2906002)(5660300002)(82740400003)(36860700001)(40480700001)(6666004)(356005)(2616005)(7636003)(1076003)(26005)(82310400005)(107886003)(16526019)(83380400001)(336012)(47076005)(426003)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 01:05:01.7771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04135c38-93ca-4db5-d108-08db2c03cbde
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7229
Subject: [virtio-dev] [PATCH v6 4/8] transport-mmio: Refer to the vq by its number

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

