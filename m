Return-Path: <virtio-dev-return-12137-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4164EC7619A
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:24:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 767DFC624E
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:24:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 65EDA98661B
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:24:16 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5B17398636E; Tue, 11 Apr 2023 19:24:16 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 626F99863D1;
	Tue, 11 Apr 2023 19:24:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DlCOWhJeR08fag65S3yf9O9lPNhFL5xtHC3PynrzvxYOXgYbQFasmOgfB4RAjz8bCZdQM1qwd5OnpH7b4agltGos3iq0SZ1xx2ZYnydgqpr55RdZZucjWI+8cL8rR8pBSmv7GTgjMTop+IGUcsipY83HpdJob/7+H8BGLanoFGvVwEnLt4tnvShfUC2aj1bu/8X14IPedQk129euZ9L8z42QgXceFRhA5gwzFiyWbbCHcdKDfw6Orw2RbnXsSlu0Tt9CN9Ua/qmjd+nKGw9OVul9Fxu/In3FFVGp6jYaq+ymlvzHmvLovuujwA+67hsI5styhdAIwzdxP4UuXmaLtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2p7myX3Zfyz00kZ0hkXsK8GiBToNbm1RXozSLlUwO0=;
 b=asFCMf5OCK6MyVlK9l2B6LSPu6wE9bVvp9MkIXZpMJk5rjP90gv+TNwqianeYJ3L3uoEwu41O/xw/wOhLAqhZ9d5CYgjZqq7A6OuMy9ZZDE+EKm9dDoee3BIqxerJEtEDE6Re+kz2cK+dVNZzePl1biXHSKgl+7+14Ac7EmP5xcP6Uk7e2sMPzHcdCLMNhTdy9iW8n1ciedZ35/sGDV1Uqk0xpfXFXYeN3u5E2LLfxIgyDSR79hRnkrRaE8v4cxlOjYlMS3jH8pbdm/1syVoJq97dTFv0NB6z0DR7LyYIdUhVsLb+4057r1GxwJNxTL9a9sBjEIvjxfqAy3D+vYohA==
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
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>
CC: <sgarzare@redhat.com>, <pasic@linux.ibm.com>,
	<virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Date: Tue, 11 Apr 2023 22:23:35 +0300
Message-ID: <20230411192341.751841-6-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230411192341.751841-1-parav@nvidia.com>
References: <20230411192341.751841-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT016:EE_|PH7PR12MB7891:EE_
X-MS-Office365-Filtering-Correlation-Id: adc313fb-aef7-4507-022c-08db3ac2527d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gRiZH3JXCxTje0dhXKA/FKiZFZQotziPPmJ+BB37j0j6eD2eBZUc2Shr16zplTYF7CgRj0ghibjkrcPd+bzafPYdIJQgSaLLcS6pD0ZsXCNZhoEnEuEXxxyC9kz453qEz4XPV4yXiv6kKgOPvSfxIuO291pePjwEfstFlhWIeQEddDLDgJI7+Ler6z+v7gJ/ZC3OLfiIBgRciEoNUlGS9TEUTnE2vrsuii5l97g115N+naNWyiOmyYfzKSLN4KlvIRCL2xCY2kdzeMRyWrN4csDH1BWAo15wmXqoZjHKpsW9lS4/Y45L/QbYDzxiWP3hZ4+qHN9pWKXegtB71iwicUDDfkEiemCphyichEWsX9E2gJqRxJPyH1BMSP9LQTqCpFT6Q+o4uON0hYEoWM4E/o2EdGEaCJdWqa9u0aX8Bl51mykEPUGQi/1fucD4ziVNVgWo21KkJ60U7QH+o1bZmtHJqIqi3miXrsS+FeNXKVp1/DP/ccDcEWBiiYFKHP/WTBTK99PHoPowqYX075+BuSGDr2OO7AwUSC4xSNkm+sdQmIqg8nBKSOAgg6qWeGviza35rui/VE3fwY56JoKa/MKk3y0054+zciTL6EjH9DWh6PIVdnoN74kuete+ZBPaNLiZpI8hgsxrKZQqudLTHKm4pauXRxeaQTZEuQZgKh1GhVrEtbTtwv4eNGJqxJgjgoSgkz6Aj2BoWqRb0x1tKtvRzvK85Sx0/n1QclINbpPumrqQMu5NErK/8k2xxaVLdl8/AP17qQ9Z3w12nU5YNRfVHNkNmdCqWegsnOjJRwkb4ZUk7lqdqSRlUUfiOlXx7wWOuGQfUmNB1hRmYYRd1A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199021)(46966006)(40470700004)(36840700001)(36756003)(86362001)(966005)(41300700001)(110136005)(316002)(54906003)(8676002)(70586007)(478600001)(4326008)(70206006)(82310400005)(5660300002)(40480700001)(36860700001)(8936002)(2906002)(356005)(7636003)(34070700002)(186003)(16526019)(82740400003)(6666004)(107886003)(26005)(1076003)(336012)(2616005)(83380400001)(426003)(47076005)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 19:24:08.3797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adc313fb-aef7-4507-022c-08db3ac2527d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7891
Subject: [virtio-dev] [PATCH v13 05/11] transport-mmio: Rename QueueNum register

These are further named differently between pci and mmio transport.
PCI transport indicates queue size as queue_size.

To bring consistency between pci and mmio transport,
rename the QueueNumMax and QueueNum
registers to QueueSizeMax and QueueSize respectively.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>

---
changelog:
v8->v9:
- added field tag to indicate field name instead of English word
v0->v1:
- replaced references of QueueNumMax to QueueSizeMax
- replaced references of QueueNum to QueueSize
- added note for renamed fields old name suggested by @Michael Tsirkin
---
 transport-mmio.tex | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/transport-mmio.tex b/transport-mmio.tex
index f884a2c..164e640 100644
--- a/transport-mmio.tex
+++ b/transport-mmio.tex
@@ -110,24 +110,31 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
   \hline
   \mmioreg{QueueSel}{Virtual queue index}{0x030}{W}{%
     Writing to this register selects the virtual queue that the
-    following operations on \field{QueueNumMax}, \field{QueueNum}, \field{QueueReady},
+    following operations on \field{QueueSizeMax},
+    \field{QueueSize}, \field{QueueReady},
     \field{QueueDescLow}, \field{QueueDescHigh}, \field{QueueDriverlLow}, \field{QueueDriverHigh},
     \field{QueueDeviceLow}, \field{QueueDeviceHigh} and \field{QueueReset} apply to. The index
     number of the first queue is zero (0x0).
   }
   \hline
-  \mmioreg{QueueNumMax}{Maximum virtual queue size}{0x034}{R}{%
+  \mmioreg{QueueSizeMax}{Maximum virtual queue size}{0x034}{R}{%
     Reading from the register returns the maximum size (number of
     elements) of the queue the device is ready to process or
     zero (0x0) if the queue is not available. This applies to the
     queue selected by writing to \field{QueueSel}.
+    \begin{note}
+    \field{QueueSizeMax} was previously known as \field{QueueNumMax}.
+    \end{note}
   }
   \hline
-  \mmioreg{QueueNum}{Virtual queue size}{0x038}{W}{%
+  \mmioreg{QueueSize}{Virtual queue size}{0x038}{W}{%
     Queue size is the number of elements in the queue.
     Writing to this register notifies the device what size of the
     queue the driver will use. This applies to the queue selected by
     writing to \field{QueueSel}.
+    \begin{note}
+    \field{QueueSize} was previously known as \field{QueueNum}.
+    \end{note}
   }
   \hline
   \mmioreg{QueueReady}{Virtual queue ready bit}{0x044}{RW}{%
@@ -308,11 +315,11 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
 
 Before writing to the \field{DriverFeatures} register, the driver MUST write a value to the \field{DriverFeaturesSel} register.
 
-The driver MUST write a value to \field{QueueNum} which is less than
-or equal to the value presented by the device in \field{QueueNumMax}.
+The driver MUST write a value to \field{QueueSize} which is less than
+or equal to the value presented by the device in \field{QueueSizeMax}.
 
 When \field{QueueReady} is not zero, the driver MUST NOT access
-\field{QueueNum}, \field{QueueDescLow}, \field{QueueDescHigh},
+\field{QueueSize}, \field{QueueDescLow}, \field{QueueDescHigh},
 \field{QueueDriverLow}, \field{QueueDriverHigh}, \field{QueueDeviceLow}, \field{QueueDeviceHigh}.
 
 To stop using the queue the driver MUST write zero (0x0) to this
@@ -363,14 +370,14 @@ \subsubsection{Virtqueue Configuration}\label{sec:Virtio Transport Options / Vir
    and expect a returned value of zero (0x0).
 
 \item Read maximum queue size (number of elements) from
-   \field{QueueNumMax}. If the returned value is zero (0x0) the
+   \field{QueueSizeMax}. If the returned value is zero (0x0) the
    queue is not available.
 
 \item Allocate and zero the queue memory, making sure the memory
    is physically contiguous.
 
 \item Notify the device about the queue size by writing the size to
-   \field{QueueNum}.
+   \field{QueueSize}.
 
 \item Write physical addresses of the queue's Descriptor Area,
    Driver Area and Device Area to (respectively) the
@@ -465,25 +472,32 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
   \hline
   \mmioreg{QueueSel}{Virtual queue index}{0x030}{W}{%
     Writing to this register selects the virtual queue that the
-    following operations on the \field{QueueNumMax}, \field{QueueNum}, \field{QueueAlign}
+    following operations on the \field{QueueSizeMax},
+    \field{QueueSize}, \field{QueueAlign}
     and \field{QueuePFN} registers apply to. The index
     number of the first queue is zero (0x0).
 .
   }
   \hline
-  \mmioreg{QueueNumMax}{Maximum virtual queue size}{0x034}{R}{%
+  \mmioreg{QueueSizeMax}{Maximum virtual queue size}{0x034}{R}{%
     Reading from the register returns the maximum size of the queue
     the device is ready to process or zero (0x0) if the queue is not
     available. This applies to the queue selected by writing to
     \field{QueueSel} and is allowed only when \field{QueuePFN} is set to zero
     (0x0), so when the queue is not actively used.
+    \begin{note}
+    \field{QueueSizeMax} was previously known as \field{QueueNumMax}.
+    \end{note}
   }
   \hline
-  \mmioreg{QueueNum}{Virtual queue size}{0x038}{W}{%
+  \mmioreg{QueueSize}{Virtual queue size}{0x038}{W}{%
     Queue size is the number of elements in the queue.
     Writing to this register notifies the device what size of the
     queue the driver will use. This applies to the queue selected by
     writing to \field{QueueSel}.
+    \begin{note}
+    \field{QueueSize} was previously known as \field{QueueNum}.
+    \end{note}
   }
   \hline
   \mmioreg{QueueAlign}{Used Ring alignment in the virtual queue}{0x03c}{W}{%
@@ -543,16 +557,16 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
    expecting a returned value of zero (0x0).
 
 \item Read maximum queue size (number of elements) from
-   \field{QueueNumMax}. If the returned value is zero (0x0) the
+   \field{QueueSizeMax}. If the returned value is zero (0x0) the
    queue is not available.
 
 \item Allocate and zero the queue pages in contiguous virtual
    memory, aligning the Used Ring to an optimal boundary (usually
    page size). The driver should choose a queue size smaller than or
-   equal to \field{QueueNumMax}.
+   equal to \field{QueueSizeMax}.
 
 \item Notify the device about the queue size by writing the size to
-   \field{QueueNum}.
+   \field{QueueSize}.
 
 \item Notify the device about the used alignment by writing its value
    in bytes to \field{QueueAlign}.
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

