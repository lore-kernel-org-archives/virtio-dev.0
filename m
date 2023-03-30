Return-Path: <virtio-dev-return-11865-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA922C7619A
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 22:59:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 488977800
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 22:59:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9774198683E
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 22:59:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 47806986752; Thu, 30 Mar 2023 22:59:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6DE3A98657D;
	Thu, 30 Mar 2023 22:59:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yxq5BwlZoAY5pg8OMMdIK/6i/4xSRaLUN+2Ag6dtUk8rJhVopw1by4ZoYXC7mzpYsFZDXh4omH4JdL356TYYiRPyWE2eEab80x33Sk9/CV9t8WfMAVyT++2KxpmQgjUW7HDL7PxlGD+jatBSrNr2U1qyJQ10asbPuyIb13mvWJKJ+I4svzGsy9ayIM4JkmQ9hDYHuiyrgb2V287MO6ABxTXjRfI4MeBWXXBBPwNaICk30lfQyN5KpHkh7sJG7q06IzhiQhoLjUMsVKLxqH7D4C9AzS+m8fK9SiGqZmiHqOkc7TG8wTDjehV2NGflQkDLADGWhITurnF7cMOCuB2HDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xr0oay6ztlXvUcaLfhm1baBTJWbocn/KPL0Kgm6GMXc=;
 b=IP+wWpYojq8mylAaoo5N4o7Hr8RjduvH2U2iyubYTHkq54t74DkLNExAQw7ohhlLUI8RYUajcaPakUsJgcZLQsn5IEpCUDFvxLgPJYZ7ngmwsjX2ClV1RFuXwTvivBKDm9m7qJDeVW0T6AWXfr7k+ij2Bn4ssNRGiNugJARri+umuuDFIE4dpA5ruIq9xCySyb19DdWTP8TMUbQ9GPVZYJOBNeVzr3td+FnR5/cJMRFqU6JolWJKJ6htUzLFzqUWwt37DnezBmH2v17Gz+1dcGNc17tf99r9j3xIVWH2qjBytWNgZkHcpw7BW9JxTkWvnfE6mhYM2mssdUsap1BPVA==
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
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Satananda Burla <sburla@marvell.com>
Date: Fri, 31 Mar 2023 01:58:30 +0300
Message-ID: <20230330225834.506969-8-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT052:EE_|SJ2PR12MB8651:EE_
X-MS-Office365-Filtering-Correlation-Id: 49298bab-abeb-4c0d-4b8e-08db31726953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sDYb18kCEz9D6XrxZDWWMv92o9au0mK9wnPlvRH4IhxRfzJ158s9cUick5JDIMBhI09IsCGDZNAdKNviW4XskA9fqaWxdFPxzJSD/F0/LhN+XLkY4GzEZV9XUM54K7JW0C9CPYm6o8jGtWeRhHQ6Nqy86zTW9W2nAs+jTd3107w0ZrLuK4OorSBLFDvLUENdcx4VSYpLfRF25RPzlYnNDcQHyDAB245vHCzh3z3091o0KXP6fCsOVpzBeX13aO3nhw1qWH3xNmD3D285aRoiPOff5NRtsIMcPw9QTwVaNM9vOkK/P/6YoGENYOaXgJLoB1goglZ5SICSOHu4WWlGJZIfrMhp5OvpLGRyKXJbzlG8d0IFOAxzCxo0aJNlIqFeXAK9C5XRm5wzw3ugkR5b9ZWPcQgahwrXm4DCl6/LpKcQ7UbBAUpyk1Bd8pMRg+cR7M/5x68VdjFQSjAO8f0duuia1K15/MjfZ4i8L5w4L3JK1QRPIi7zlm/5hU3ZSifvQKvn8Q+INOqUTD0Rsf/e107wH7gaawYTXMryWMWDZJqqN3Rc406G70V6dTaxNzF/zULq+pU/XPQsJh9eLC1HlxcOr6MKkupUKIVCZIzgN6963BZMQ7S6/5OTDpIraHsjvoGLucsz8F6zX+QYCYH4hlINOZGguydyu4kHOhSKRIGEnb37x3Eco64A6FU2hohI+HnF/GW1uejKgw7E7bogGnR7axsivBB2GCbYdnh8ClF99+TYm8M4H8AsGgkwNfRXFFYr5aAtLw4dNOfvGtQ5SPy2FN+j395TwpWH7JWhARc=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199021)(40470700004)(46966006)(36840700001)(16526019)(316002)(54906003)(186003)(6666004)(110136005)(1076003)(26005)(336012)(426003)(2616005)(83380400001)(47076005)(82740400003)(40460700003)(7636003)(478600001)(82310400005)(40480700001)(8936002)(86362001)(5660300002)(70206006)(356005)(70586007)(41300700001)(8676002)(36860700001)(2906002)(34020700004)(4326008)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 22:59:26.4594
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49298bab-abeb-4c0d-4b8e-08db31726953
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8651
Subject: [virtio-dev] [PATCH 07/11] transport-pci: Introduce transitional MMR device id

Transitional MMR device PCI Device IDs are unique. Hence,
any of the existing drivers do not bind to it.
This further maintains the backward compatibility with
existing drivers.

Co-developed-by: Satananda Burla <sburla@marvell.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 transport-pci.tex | 45 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/transport-pci.tex b/transport-pci.tex
index ee11ba5..665448e 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -19,12 +19,14 @@ \section{Virtio Over PCI Bus}\label{sec:Virtio Transport Options / Virtio Over P
 \subsection{PCI Device Discovery}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery}
 
 Any PCI device with PCI Vendor ID 0x1af4, and PCI Device ID 0x1000 through
-0x107f inclusive is a virtio device. The actual value within this range
-indicates which virtio device is supported by the device.
+0x107f inclusive and DeviceID 0x10f9 through 0x10ff is a virtio device.
+The actual value within this range indicates which virtio device
+type it is.
 The PCI Device ID is calculated by adding 0x1040 to the Virtio Device ID,
 as indicated in section \ref{sec:Device Types}.
-Additionally, devices MAY utilize a Transitional PCI Device ID range,
-0x1000 to 0x103f depending on the device type.
+Additionally, devices MAY utilize a Transitional PCI Device ID range
+0x1000 to 0x103f inclusive or a Transitional MMR PCI Device ID range
+0x10f9 to 0x10ff inclusive, depending on the device type.
 
 \devicenormative{\subsubsection}{PCI Device Discovery}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery}
 
@@ -95,6 +97,41 @@ \subsubsection{Legacy Interfaces: A Note on PCI Device Discovery}\label{sec:Virt
 
 This is to match legacy drivers.
 
+\subsubsection{Transitional MMR Interface: A Note on PCI Device
+Discovery}\label{sec:Virtio Transport Options / Virtio Over PCI
+Bus / PCI Device Discovery / Transitional MMR Interface: A Note on PCI Device Discovery}
+
+The transitional MMR device has one of the following PCI Device ID
+depending on the device type:
+
+\begin{tabular}{|l|c|}
+\hline
+Transitional PCI Device ID  &  Virtio Device    \\
+\hline \hline
+0x10f9      &   network device     \\
+\hline
+0x10fa     &   block device     \\
+\hline
+0x10fb     & memory ballooning (traditional)  \\
+\hline
+0x10fc     &      console       \\
+\hline
+0x10fd     &     SCSI host      \\
+\hline
+0x10fe     &  entropy source    \\
+\hline
+0x10ff     &   9P transport     \\
+\hline
+\end{tabular}
+
+The PCI Subsystem Vendor ID and the PCI Subsystem Device ID MAY
+reflect the PCI Vendor and Device ID of the environment.
+
+The transitional MMR driver MUST match any PCI Revision ID value.
+
+The transitional MMR driver MAY match any PCI Subsystem Vendor ID and
+any PCI Subsystem Device ID value.
+
 \subsection{PCI Device Layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout}
 
 The device is configured via I/O and/or memory regions (though see
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

