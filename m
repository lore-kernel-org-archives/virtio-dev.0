Return-Path: <virtio-dev-return-14135-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC98C10DC3
	for <virtio-dev@archiver.kernel.org>; Thu,  7 Dec 2023 16:37:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E033444549
	for <virtio-dev@archiver.kernel.org>; Thu,  7 Dec 2023 16:37:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DB878986927
	for <virtio-dev@archiver.kernel.org>; Thu,  7 Dec 2023 16:37:57 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CE548986907; Thu,  7 Dec 2023 16:37:57 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2F6EE986941
	for <virtio-dev@lists.oasis-open.org>; Thu,  7 Dec 2023 16:37:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1701967054.840000
X-TM-MAIL-UUID: b414e869-c604-4345-863e-37408b8adc6a
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MM5Kb1t+wAtmkegpdrSr5Ln0zDPMft48SU6L+4YOXF3dqpTydt1fvv24wIoxzamYIWXMEuLqQJfyUmykGBGgBEAcnEOvV+Z59in5GsYPfXdo8F0bY4LLXrL4OgRLYAdcjZcVo2jvSIv6seMlfvY9R35Mb0EDORyFjFwo9z3w9Ot4PhuaU/UT1jLvxNCmOasctUNaKtAKRKRDxEvggD4ZCytGqHe2loiHCzGvjK+u5WiIohfGJEdg6S0g+g+BZgYxdcEiEe/zodJ+nvy8zmN1hLeAcMF0/2Uc7S1OKuLIwCy3T07an0AcLcZd6PGsaD6Tw5YB7BsaeqMxXZjTboXKCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1ahOgTqMHP0J/Y3L09zPZaEvHUaMdWjDT7KXlf/274=;
 b=CceXsXIa2GTo/h2uT7t0piZuhDSuYMDK7NsmU1TnWLTXAJpxInzoZQZufbFHiARg6kbpj7N+Vl8zGK0Oo1X/XgbWRKPDZRMBhAe5UcasZ/C83VlVjO+zD7Lwtva6McLwRjTH6grRkaXimSKpHkZTAZIFVjz0PTwW2dTDEqtVxenCpdUMaKKUDxybQ3DZ+c6bvP7lKLxbhAdGuWyPdCGur6edkVktmHB4IGQ334ieGjD9rmic0D4fnMj/kKISjZVsxlgR/r5p+s5Z8AXaij90xCP/03QA1NHrWv2caZyzCnxHQUB+40hjQ/0ugUc8nWEVtd8igOgaB5W6iA7uxZbBMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=gmail.com smtp.mailfrom=opensynergy.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=opensynergy.com; dkim=none (message not signed); arc=none (0)
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.66.60.4)
 smtp.mailfrom=opensynergy.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=opensynergy.com;
Received-SPF: Pass (protection.outlook.com: domain of opensynergy.com
 designates 217.66.60.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.66.60.4; helo=SR-MAIL-03.open-synergy.com; pr=C
From: Igor Skalkin <Igor.Skalkin@opensynergy.com>
To: virtio-dev@lists.oasis-open.org,
	virtio-comment@lists.oasis-open.org,
	luiz.dentz@gmail.com,
	mst@redhat.com
Cc: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	jasowang@redhat.com,
	boris.le.labousse@opensynergy.com,
	Igor Skalkin <Igor.Skalkin@opensynergy.com>
Date: Thu,  7 Dec 2023 17:37:21 +0100
Message-Id: <20231207163721.26737-2-Igor.Skalkin@opensynergy.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231207163721.26737-1-Igor.Skalkin@opensynergy.com>
References: <20231207163721.26737-1-Igor.Skalkin@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8EUR05FT055:EE_|BE1P281MB2289:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 81be74a7-bb46-4251-40fb-08dbf742cfaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zyfI37pKxJgOL647ATwZNhDHq36N2NrmPHTTmeW9ajC2vko0HAu0W8byF6Ea1TSv/P0Zfm770cjgbA+1IMqp7oNWDMReB9Cbrpa67T/RpcoBBULfhlvb/Bbgqkka/x25Mf9ImUgEDtD5vlZlnx/5OJ2xDOH3MfdbwTNWSfFja1vtXK3kJJHOZLEqwOw2ZVXPh6VttLPGGiZfIYDsbt+8+TW5Q1n70PLePytBl4ND2dGCVOAUmLqWovWQDJX9Uxcqb/E/r/AFyl54kQQslIuEjPGOhoEht4DKZ3GqHLG/W9U5aA5qsVrdHil424C50OUEsu6zHFB/+P/v1FUrtv7zgHxWyadQysoOQo85T7GE5S0foPnbIkOjdIqbkCXjNCUy3i6iahv2VHbRzP02beb4FjJtCqopHxwwBe9cknK0HNLczHl94rvVlV/GgMUGSKmxDohDO0ODXpfwpTfGf8poZtYIC5BjrCltmiLyOplp5wTIRTmKmZBIVmaNvv6pFixyYeMWM/1kvWjxT6rBeN7l7xvpSiuxrTFTje4P/cgD5S4OoBDRpQ8xe6r0+jxKIpY18dwfogU4BADNKt3yrEZPSAmpj1Bmv8GvtRpAEeSU0KWLRX48C7q/4hjlVD0xmJvKicpqFFai7BBka5mCSNq1NtehCdvVLIvwfFP5bn+2bZX204DjkT7bXAE2BpCkoeuK2beHRgDGA11IYu/tWbYSzddRUPnNIK2yGzJXUgRMQ7jFCNbjMvdQlHzpiHBS4+w5GH9xNcqaKQT9H7SM8FI6TtwOHEZVgkCMP1W/QhrZrrQt9+AMq5TdjZUMbZWQZiQV
X-Forefront-Antispam-Report:
	CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(346002)(39840400004)(396003)(376002)(136003)(230922051799003)(82310400011)(451199024)(186009)(1800799012)(64100799003)(36840700001)(46966006)(47076005)(336012)(66899024)(83380400001)(36756003)(86362001)(36860700001)(81166007)(41300700001)(5660300002)(30864003)(478600001)(8936002)(45080400002)(4326008)(40480700001)(8676002)(107886003)(2616005)(1076003)(26005)(70586007)(70206006)(2906002)(316002)(42186006)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 16:37:32.6234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81be74a7-bb46-4251-40fb-08dbf742cfaf
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB8EUR05FT055.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB2289
X-TM-AS-ERS: 104.47.11.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28044.000
X-TMASE-Result: 10--35.175300-4.000000
X-TMASE-MatchedRID: 5y2TnboncNGUP+0hdpOx0ibNef8sKf12OPrWgMtHd2vB3i17wva+EvOU
	koqD+FEZnQvVnz410DyLO9h/kZ7mQnkHMxUIdlxL+DE5zr5ahdzc7b6k5+X69zAsn09lQFCFm7W
	YZnTau36ijVoxG5GMcAfoZhqt/FSE2J61hi7qqbLWcxHsnT13T+A4l73CwysLkZ43711Uirfnq/
	Q0Vm6yzduGPRtWbaTwK7Ow+6iMiTXr6eh0XDxDfzZ4NKr/TszHn+UEJ0zQ2RHMfVBYtCwQcbeTi
	R13vOFkfhf3eCDiLHeugVrhSoK7PfJLPT/yapWgCqJ0RbJ3bb2q0ui/bxZsSfvYtdj1aUP1pBu7
	zSJhKcy07bmrp95R8gxuj9Z29OajHnfjloPvGDl43vgC6ReA/6AHl/iBl3ALtk6R7Pw8b4BrAiD
	6bCwinRkj2Su9G0v/9QDF9zcGxfYXnx2NW2tNXebTZJ7LF2rAY4oSzx+h+U5OdtX08uUzypUDUq
	Gco/jNtuTvK9FM0qMet2W2IEA45pfk3hpXiJaVAuJ1/rls05fYB7h0QmbuTaJ/4hU3LNogAxI+U
	WxLhU0vRvH+BtCe2q8GpbnL65afpCkfTcAJL1Y+MySqIuP2jBUk9SpeetB1MHiMmW0ZUNss3nAY
	9fdM9dh5c4TN8zbZ7PVkFWMnCn8N5Rk4kJccyNPDdrro6llroli4ZoiOHT/pP8tMOyYmaA==
X-TMASE-XGENCLOUD: ddfef9e9-a492-4446-bc24-5c0541839391-0-0-200-0
X-TM-Deliver-Signature: 149DCB93B5D935003C79A14EE27D9649
X-TM-Addin-Auth: e7EgHWpakAJTFMWOaJNxE5TL4X8tXvNWYlFRk6CS2VroUZTG5Bgouhv9oCA
	f+E3eYaNQU4iBOwRUwzKPGom0vNyq7ylwE2rD2MDn9ESGJgpYq1ofUwddMakRyFqqJb8YMfhXTb
	dHlsFChFxyy9bg8iUzU5ETWwIY0d2Lisa29Da+9hVmX54tulpeRv70QlbwVXqyPWJfSp+YJgJwN
	WFi+wqwNXlCDcredLBuwMlsnaAPScb1J8hVeXfKnDdNKNQoUXQ8kUWBJ8enwrK9YjOB1iLMcqna
	McZJdBQy3jZxDa4=.Cf4J3ByHnZ8bsTkGCWZ791HbVraQ4JZXzvm+YjI3Wtpcy6RhNFTao48MuJ
	E+pjA7qWlP4uS6IydYOSIleWOOlV1Ep+ohvFj4kHguKkTtkgjL22Za3aIGEbXHrTWwrUf5AWlXi
	QlVBM4x8quaJpLAccD/S19cByiC0fClpHFYQBY7mlgRPKJvVWnorDveHRQjxd+r2G3Rsr3egff7
	JM/uKkMFXCgNXhHPZSAeHrX3+bTMSFsJhH4ttlsQw25EA4iKHtKee7uXk6dVA2IZ1GZr8X90AEr
	LwilkyFGrUACsEahd6zM9Hp557APm8aUTAHLhp+CsY87n2OUMWphX9SvCgQ==
X-TM-Addin-ProductCode: EMS
Subject: [virtio-dev] [PATCH v2 1/1] RFC: virtio-bt: add virtio BT device specification

This PR is aimed as review for comments(RFC) purpose.

* Initial draft version.
---
 conformance.tex                        |  12 +-
 content.tex                            |   1 +
 device-types/bt/description.tex        | 158 +++++++++++++++++++++++++
 device-types/bt/device-conformance.tex |   7 ++
 device-types/bt/driver-conformance.tex |   7 ++
 introduction.tex                       |  15 +++
 6 files changed, 196 insertions(+), 4 deletions(-)
 create mode 100644 device-types/bt/description.tex
 create mode 100644 device-types/bt/device-conformance.tex
 create mode 100644 device-types/bt/driver-conformance.tex

diff --git a/conformance.tex b/conformance.tex
index dc00e84..86c7db1 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -32,8 +32,9 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \ref{sec:Conformance / Driver Conformance / Memory Driver Conformance},
 \ref{sec:Conformance / Driver Conformance / I2C Adapter Driver Conformance},
 \ref{sec:Conformance / Driver Conformance / SCMI Driver Conformance},
-\ref{sec:Conformance / Driver Conformance / GPIO Driver Conformance} or
-\ref{sec:Conformance / Driver Conformance / PMEM Driver Conformance}.
+\ref{sec:Conformance / Driver Conformance / GPIO Driver Conformance},
+\ref{sec:Conformance / Driver Conformance / PMEM Driver Conformance} or
+\ref{sec:Conformance / Driver Conformance / BT Driver Conformance}
 
     \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
   \end{itemize}
@@ -59,8 +60,9 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \ref{sec:Conformance / Device Conformance / Memory Device Conformance},
 \ref{sec:Conformance / Device Conformance / I2C Adapter Device Conformance},
 \ref{sec:Conformance / Device Conformance / SCMI Device Conformance},
-\ref{sec:Conformance / Device Conformance / GPIO Device Conformance} or
-\ref{sec:Conformance / Device Conformance / PMEM Device Conformance}.
+\ref{sec:Conformance / Device Conformance / GPIO Device Conformance},
+\ref{sec:Conformance / Device Conformance / PMEM Device Conformance} or
+\ref{sec:Conformance / Device Conformance / BT Device Conformance}
 
     \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
   \end{itemize}
@@ -152,6 +154,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \input{device-types/scmi/driver-conformance.tex}
 \input{device-types/gpio/driver-conformance.tex}
 \input{device-types/pmem/driver-conformance.tex}
+\input{device-types/bt/driver-conformance.tex}
 
 \conformance{\section}{Device Conformance}\label{sec:Conformance / Device Conformance}
 
@@ -238,6 +241,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \input{device-types/scmi/device-conformance.tex}
 \input{device-types/gpio/device-conformance.tex}
 \input{device-types/pmem/device-conformance.tex}
+\input{device-types/bt/device-conformance.tex}
 
 \conformance{\section}{Legacy Interface: Transitional Device and Transitional Driver Conformance}\label{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}
 A conformant implementation MUST be either transitional or
diff --git a/content.tex b/content.tex
index 0a62dce..b67b3e5 100644
--- a/content.tex
+++ b/content.tex
@@ -767,6 +767,7 @@ \chapter{Device Types}\label{sec:Device Types}
 \input{device-types/scmi/description.tex}
 \input{device-types/gpio/description.tex}
 \input{device-types/pmem/description.tex}
+\input{device-types/bt/description.tex}
 
 \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
 
diff --git a/device-types/bt/description.tex b/device-types/bt/description.tex
new file mode 100644
index 0000000..98311f4
--- /dev/null
+++ b/device-types/bt/description.tex
@@ -0,0 +1,158 @@
+\section{BT Device}\label{sec:Device Types / BT Device}
+
+The virtio-bt device provides an HCI (Host Control Interface) over VirtIO
+link between the guest HCI device and the host HCI backend.
+Also, the device can inform the guest driver which operational system / vendor
+ specific HCI extensions it supports.
+Host Control Interface is described in Bluetooth Core Specification (see
+\hyperref[intro:bluetooth-core]{Bluetooth Core Specification}).
+
+\subsection{Device ID}\label{sec:Device Types / BT Device / Device ID}
+
+40
+
+\subsection{Virtqueues}\label{sec:Device Types / BT Device / Virtqueues}
+
+\begin{description}
+\item[0] transmitq
+\item[1] receiveq
+\end{description}
+
+\subsection{Feature bits}\label{sec:Device Types / BT Device / Feature bits}
+
+\begin{description}
+\item[VIRTIO_BT_F_VND_HCI (0)]  The device supports vendor-specific HCI
+extensions.
+\item[VIRTIO_BT_F_MSFT_EXT (1)] The device supports Microsoft HCI Extensions.
+\item[VIRTIO_BT_F_AOSP_EXT (2)] The device supports Android HCI Extensions.
+\item[VIRTIO_BT_F_CONFIG_V2 (3)] The device uses the second version of the
+configuration space structure.
+\end{description}
+
+\devicenormative{\subsubsection}{Feature bits}{Device Types / BT Device / Feature bits}
+
+The device MAY require the driver to accept the \field{VIRTIO_BT_F_CONFIG_V2}
+feature bit and use the second version of the configuration layout, because the
+first one is unaligned, which violates the specification.
+
+The device should offer \field{VIRTIO_BT_F_MSFT_EXT} or
+\field{VIRTIO_BT_F_AOSP_EXT} feature bit if it supports correspondingly MSFT or
+AOSP extension command sets (see \hyperref[intro:bluetooth-aosp]{Bluetooth AOSP
+HCI Extensions}, \hyperref[intro:bluetooth-msft]{Bluetooth MSFT HCI Extensions}
+). In case of \field{VIRTIO_BT_F_MSFT_EXT}, device should also set configuration
+field \field{msft_opcode}.
+
+The device should offer \field{VIRTIO_BT_F_VND_HCI} feature bit and set
+configuration field \field{vendor}, if it supports corresponding vendor
+extensions. Also, in case of second configuration version, fields
+\field{set_bdaddr_opcode} and \field{quirks} can be set according to this
+\field{vendor}.
+
+\drivernormative{\subsubsection}{Feature bits}{Device Types / BT Device / Feature bits}
+
+The driver MUST accept \field{VIRTIO_BT_F_CONFIG_V2} feature bit if offered by
+the device.
+
+The driver SHOULD accept any of the  \field{VIRTIO_BT_F_VND_HCI},
+\field{VIRTIO_BT_F_MSFT_EXT} or \field{VIRTIO_BT_F_AOSP_EXT} feature bits if
+offered by the device.
+
+\subsection{Device configuration layout}\label{sec:Device Types / BT Device / Device configuration layout}
+BT device supports two versions of the configuration structure layout.
+\subsubsection{Device configuration layout: Version 1}\label{sec:Device Types / BT Device / Device configuration layout / Verion 1}
+
+All fields of this configuration are always available and read-only for the
+driver.
+\begin{lstlisting}
+struct virtio_bt_config {
+    u8 type;
+    le16 vendor;
+    le16 msft_opcode;
+} __attribute__((packed));
+\end{lstlisting}
+
+\begin{description}
+
+\item[\field{type}] indicates the type of the device, is it "Primary BR/EDR
+controller" or "Alternate MAC/PHYs (AMP) secondary controller" and can have the
+following values:
+\begin{lstlisting}
+#define VIRTIO_BT_CONFIG_TYPE_PRIMARY 0
+#define VIRTIO_BT_CONFIG_TYPE_AMP     1
+\end{lstlisting}
+
+\item[\field{vendor}]
+Indicates the vendor of the BT device and can have the following mutually
+exclusive values:
+\begin{lstlisting}
+#define VIRTIO_BT_CONFIG_VENDOR_NONE     0
+#define VIRTIO_BT_CONFIG_VENDOR_ZEPHYR   1
+#define VIRTIO_BT_CONFIG_VENDOR_INTEL    2
+#define VIRTIO_BT_CONFIG_VENDOR_REALTEK  3
+\end{lstlisting}
+The device MUST offer the \field{VIRTIO_BT_F_VND_HCI} feature bit if it sets
+\field{vendor} to any value other than \field{VIRTIO_BT_CONFIG_VENDOR_NONE}.
+In the current Linux implementation of virtio-bt, these values are simply
+hard-coded and point to the hard-coded (\field{manufacturer},
+\field{set_bdaddr_opcode}, \field{quirks}) parameters, there
+\field{manufacturer} is a "Company Identifier" from the
+\hyperref[intro:bluetooth-numbers]{Bluetooth Assigned Numbers}, Chapter 7
+(Company Identifiers).
+This approach is not extensible and has been replaced in the second version of
+the configuration.
+\item[\field{msft_opcode}]
+This field is used by the driver if device offers \field{VIRTIO_BT_F_MSFT_EXT}
+feature bit.
+\end{description}
+
+\subsubsection{Device configuration layout: Version 2}\label{sec:Device Types / BT Device / Device configuration layout / Version 2}
+All fields of this configuration are always available and read-only for the
+driver.
+\begin{lstlisting}
+struct virtio_bt_config_v2 {
+    le16 vendor;
+    le16 set_bdaddr_opcode;
+    le32 quirks;
+    le16 msft_opcode;
+};
+\end{lstlisting}
+
+\begin{description}
+
+\item[\field{vendor}] - Manufacturer identifier, for the possible values see
+\hyperref[intro:bluetooth-numbers]{Bluetooth Assigned Numbers}, Chapter 7
+(Company Identifiers).
+The device MUST offer the VIRTIO_BT_F_VND_HCI feature bit if it sets
+\field{vendor} to any value other than VIRTIO_BT_CONFIG_VENDOR_NONE.
+According to the Linux guest driver implementation, devices from different
+vendors can have different opcodes for the \field{set_bdaddr} (Bluetooth Device
+Address) command, and the different \field{quirks} bits (list and short
+description of these \field{quirks} you can find in
+\hyperref[intro:bluetooth-quirks]{Bluetooth HCI device quirks}.
+So, next two fields allow us to set these parameters.
+
+\item[\field{set_bdaddr_opcode}] - opcode for the set_bdaddr (Bluetooth Device
+Address) command.
+\item[\field{quirks}] - Quirks bits supported by the device.
+\hyperref[intro:bluetooth-quirks]{Bluetooth HCI device quirks}
+
+\item[\field{msft_opcode}]
+This fields is used by the driver if device offers \field{VIRTIO_BT_F_MSFT_EXT}
+feature bit.
+\end{description}
+
+\subsection{Device initialization}\label{sec:Device Types / BT Device / Device initialization}
+
+The virtqueues are initialized.
+
+\subsection{Device operations}\label{sec:Device Types / BT Device / Device operations}
+
+The driver populates the receive queue with at least one buffer of at
+least 258 bytes to contain 1 byte "packet type" and HCI event packet (2 bytes
+of HCI event packet header and up to 255 bytes payload).
+Synchronous and asynchronous data packets that are longer than the provided
+buffer will be fragmented.
+
+The driver sends to the transmit queue all (command and data) packets, received
+from the guest HCI device, and transfers to the guest HCI device all (event and
+data) HCI packets, received from the receive queue.
diff --git a/device-types/bt/device-conformance.tex b/device-types/bt/device-conformance.tex
new file mode 100644
index 0000000..283b0e1
--- /dev/null
+++ b/device-types/bt/device-conformance.tex
@@ -0,0 +1,7 @@
+\conformance{\subsection}{Bluetooth Device Conformance}\label{sec:Conformance / Device Conformance / Bluetooth Device Conformance}
+
+A BT device MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / BT Device / Feature bits}
+\end{itemize}
diff --git a/device-types/bt/driver-conformance.tex b/device-types/bt/driver-conformance.tex
new file mode 100644
index 0000000..80bb235
--- /dev/null
+++ b/device-types/bt/driver-conformance.tex
@@ -0,0 +1,7 @@
+\conformance{\subsection}{BT Driver Conformance}\label{sec:Conformance / Driver Conformance / BT Driver Conformance}
+
+A BT driver MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{drivernormative:Device Types / BT Device / Feature bits}
+\end{itemize}
diff --git a/introduction.tex b/introduction.tex
index cfa6633..d524fce 100644
--- a/introduction.tex
+++ b/introduction.tex
@@ -145,6 +145,21 @@ \section{Normative References}\label{sec:Normative References}
     Leiba, B., "Ambiguity of Uppercase vs Lowercase in RFC 2119 Key Words", BCP
     14, RFC 8174, DOI 10.17487/RFC8174, May 2017
         \newline\url{http://www.ietf.org/rfc/rfc8174.txt}\\
+	\phantomsection\label{intro:bluetooth-core}\textbf{[BT Core]} &
+    Bluetooth Core Specification
+	\newline\url{http://www.bluetooth.com/specifications/specs/core-specification-5-4}\\
+	\phantomsection\label{intro:bluetooth-aosp}\textbf{[BT AOSP]} &
+    Bluetooth AOSP HCI Extensions
+	\newline\url{http://source.android.com/docs/core/connect/bluetooth/hci_requirements}\\
+	\phantomsection\label{intro:bluetooth-msft}\textbf{[BT MSFT]} &
+    Bluetooth Microsoft HCI Extensions
+	\newline\url{http://learn.microsoft.com/en-us/windows-hardware/drivers/bluetooth/microsoft-defined-bluetooth-hci-commands-and-events}\\
+	\phantomsection\label{intro:bluetooth-quirks}\textbf{[BT HCI quirks]} &
+    Bluetooth HCI device quirks
+	\newline\url{https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/net/bluetooth/hci.h}\\
+	\phantomsection\label{intro:bluetooth-numbers}\textbf{[BT vendors]} &
+    Bluetooth Assigned Numbers Document
+	\newline\url{https://www.bluetooth.com/specifications/assigned-numbers}\\
 \end{longtable}
 
 \section{Non-Normative References}
-- 
2.40.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

