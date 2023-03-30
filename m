Return-Path: <virtio-dev-return-11874-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B51BC77B6D
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 23:01:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2469F1922E8
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 23:00:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D3A96986ACB
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 23:00:52 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B54C79867CB; Thu, 30 Mar 2023 23:00:52 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 585139868D8;
	Thu, 30 Mar 2023 23:00:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROkA3gy6Hd1wkTkgqzHLKo7//6p/2MSMz3/0yjgKVghvzaOmwKlL4fIl8gfpcCP4ObL13fdF2DBCBD7f3jEtHsKMgAxm3TvXOozhIH+XLXq7pV8zVecvesczGzWSY0XwPK1ADQZ9MoRZgS/rBG5BLsQpntNfTk848lSqiK59ugRVKwWmO0t07RxwflsyzfTYbxiQ6HUIhsu2vhpV4KQRFlx47Zf8Ynjgmsr/evSFcF7PGJLsLbem6XJensW1jCE5augOqSQxcbPnAwBIyIbR1mqbJt+FvLEK+GZVoCEtkvqW4QRbnSWi5kN8HeNbfNZK4+ZORUYR6q0Sh0RiaVcVZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVPWHzWUyF0qn5ao/RlBOoIlw0HUJRuzmX0+elAojWE=;
 b=c8AXEG2CHKbc7hJdHGcRRToKsokeJMwXIYaoqBA9MXxWKIAmsN5J9OIJfvy1KvWgzZXXahjK1ORuZOXd+J0Qf1UAngy7TUlDTuxmJtE+pKu42SuG6YEnC0sHd7EKYPTx5cyr5KQ6aNHt0xIDIifM8puxBknh4feBtJqmghYsMxoQfqA4xObassiX3rD/Qf0kNvEeI2ND6BdnLAcgmAbbqcqCeG6SqN8HdkoN6EsFo/gr5D30mnLDlIz9hWfn9npVwUl6KF3sMCmjjGQaWc/5ajz1PedixvJWVq6CTfw4jgAMH5c3p31wlEYMimyWc5/QG9SCDl/g92/OaRdFWa1SKA==
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
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Satananda Burla <sburla@marvell.com>
Date: Fri, 31 Mar 2023 01:58:34 +0300
Message-ID: <20230330225834.506969-12-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230330225834.506969-1-parav@nvidia.com>
References: <20230330225834.506969-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT026:EE_|CH0PR12MB5042:EE_
X-MS-Office365-Filtering-Correlation-Id: 32a260f4-7011-4f52-4fe9-08db31726f17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Kqd0oImZGUw7RAKjROm1aQicfBvFfdzNIJmdIx/fuQO+9zo4UAff5Xfr+a06vIODkxBh+QMaOyKCgNLyRB+WSSylnYEMOY3fWJB5t+TLD7ZQxcN1Z6u15D1KhtCaUONr9n3Go7cU6tWx7OLu3rLmlHQJ1TSlvYnbKrd0Rtb66W+Oxn1/b4UAz83l3XlhF57PLJrPcCuzdjWKMGhbpdfABDgl5IBRV/kci/foTuFlwzZBZZ3RdNtXtlTSgVumIzcZJfVKg0batduEMSwyPKA1wWef3qRgPeI51Pv0X0IUlx203IulVi8rXzrxJNKSj4B+/eglnrhNM3ambln7JznBvz3l/l3R6RyT5xZgimqJB516b5pSYhaFYJX5TPd+nixobhFowZPakN71l0efQIR6Zk2kdzhJPLbjfT40I2zX8YLpayXvXRZojZPzKqV9C/tqwN/R+/IaqbGqJO6aqceeH8TMfCWjrBRwDK04x58mHm8AN7BY2X1C++iwYbQK6rqe8O+dIzgE5+o7maKkM1nKRHz+T3KNeXQSdpKD1DEN7k0bXOFKw4JZGTRcQ+eSVEhK+TKgd4GWArUeRB7feXrVQ1N9YQYhUfQu0dSZsmSu5k9J8reZbVYS3l7i5ws1CY5T9cX4UAwufefCpaDVvEJuBtZnEsVIZcrQqLWXNY5oYiBWtwZqpZyG3S1zzv6RfGx5/J1oDfgDyz45OYH2InCnxM1rPc58ZIcRsK9zyLyFCJTkOrAiKi5p2MK+Or9iAdxuexrhGbmN29eeIYfgCFBdGe6JqmIXNysk7BdUJF5g32A=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(2906002)(8936002)(356005)(82740400003)(41300700001)(5660300002)(82310400005)(36756003)(86362001)(40480700001)(7636003)(336012)(47076005)(478600001)(34020700004)(54906003)(36860700001)(186003)(16526019)(426003)(1076003)(26005)(6666004)(2616005)(83380400001)(70586007)(70206006)(8676002)(4326008)(110136005)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 22:59:36.1326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a260f4-7011-4f52-4fe9-08db31726f17
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5042
Subject: [virtio-dev] [PATCH 11/11] conformance: Add transitional MMR interface conformance

Add conformance section for the transitional MMR interface.

Basically transitional MMR interface follows same requirements as that
of the transitional device with few exceptions to it. List such delta
requirements in the conformance section.

Co-developed-by: Satananda Burla <sburla@marvell.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 conformance.tex      |  8 ++++++--
 tmmr-conformance.tex | 27 +++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 2 deletions(-)
 create mode 100644 tmmr-conformance.tex

diff --git a/conformance.tex b/conformance.tex
index ccbc9bf..4cccba7 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -11,7 +11,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 
 Conformance targets:
 \begin{description}
-\item[Driver] A driver MUST conform to four conformance clauses:
+\item[Driver] A driver MUST conform to five conformance clauses:
   \begin{itemize}
     \item Clause \ref{sec:Conformance / Driver Conformance}.
     \item One of clauses \ref{sec:Conformance / Driver Conformance / PCI Driver Conformance}, \ref{sec:Conformance / Driver Conformance / MMIO Driver Conformance} or \ref{sec:Conformance / Driver Conformance / Channel I/O Driver Conformance}.
@@ -36,8 +36,9 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \ref{sec:Conformance / Driver Conformance / PMEM Driver Conformance}.
 
     \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
+    \item Clause \ref{sec:Conformance / Transitional MMR Interface: Transitional MMR Device and Transitional MMR Driver Conformance}.
   \end{itemize}
-\item[Device] A device MUST conform to four conformance clauses:
+\item[Device] A device MUST conform to five conformance clauses:
   \begin{itemize}
     \item Clause \ref{sec:Conformance / Device Conformance}.
     \item One of clauses \ref{sec:Conformance / Device Conformance / PCI Device Conformance}, \ref{sec:Conformance / Device Conformance / MMIO Device Conformance} or \ref{sec:Conformance / Device Conformance / Channel I/O Device Conformance}.
@@ -63,6 +64,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \ref{sec:Conformance / Device Conformance / PMEM Device Conformance}.
 
     \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
+    \item Clause \ref{sec:Conformance / Transitional MMR Interface: Transitional MMR Device and Transitional MMR Driver Conformance}.
   \end{itemize}
 \end{description}
 
@@ -294,3 +296,5 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item Section \ref{sec:Device Types / SCSI Host Device / Device Operation / Device Operation: eventq / Legacy Interface: Device Operation: eventq}
 \item Section \ref{sec:Reserved Feature Bits / Legacy Interface: Reserved Feature Bits}
 \end{itemize}
+
+\input{tmmr-conformance.tex}
diff --git a/tmmr-conformance.tex b/tmmr-conformance.tex
new file mode 100644
index 0000000..ad3489b
--- /dev/null
+++ b/tmmr-conformance.tex
@@ -0,0 +1,27 @@
+\conformance{\section}{Transitional MMR Interface: Transitional MMR Device and Transitional MMR Driver Conformance}\label{sec:Conformance / Transitional MMR Interface: Transitional MMR Device and Transitional MMR Driver Conformance}
+
+An implementation MAY choose to implement OPTIONAL support for the
+transitional MMR interface, by conforming to all of the MUST
+level requirements for the transitional MMR interface for the
+transitional devices and drivers.
+
+The requirements for the transitional MMR interface follows all
+the legacy interface requirements listed in section
+\ref{sec:Conformance / Legacy Interface: Transitional Device and
+Transitional Driver Conformance} with the following exceptions.
+
+Following requirements MUST NOT be implemented:
+
+\begin{itemize}
+\item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery / Legacy Interfaces: A Note on PCI Device Discovery}
+\item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities / Common configuration structure layout / Legacy Interfaces: A Note on Configuration Registers}
+\end{itemize}
+
+Instead following requirements MUST be implemented:
+
+\begin{itemize}
+\item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery / Transitional MMR Interface: A Note on PCI Device Discovery}
+\item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities / Common configuration structure layout / Transitional MMR Interface: A Note on Configuration Registers}
+\item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities / Notification capability / Transitional MMR Interface}
+\item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities / Transitional MMR Interface: Legacy Memory Mapped Configuration Registers Capability}
+\end{itemize}
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

