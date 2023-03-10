Return-Path: <virtio-dev-return-11591-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A576DC6FD19
	for <virtio-dev@archiver.kernel.org>; Fri, 10 Mar 2023 06:27:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0FFF477F3
	for <virtio-dev@archiver.kernel.org>; Fri, 10 Mar 2023 06:27:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0A36198671F
	for <virtio-dev@archiver.kernel.org>; Fri, 10 Mar 2023 06:27:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id F35DE98670C; Fri, 10 Mar 2023 06:27:27 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DF1F498670B;
	Fri, 10 Mar 2023 06:27:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1678429630.731000
X-TM-MAIL-UUID: 47708282-175e-426a-a1d8-a43de1a3dc06
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=foX5SSGwY+IVmABiAVZJs+qgXueab4FHKM+xzpqIRwMm9nGR6iXmTyrLKaab7DQrZ9zD8bkoNJfdfihgXJ54mqoQ9pPQjDM2uWToDxuai335v/ZBo+7xwtmTKW56WSBYpTLgC9Mw0sgzr2lBBHj/kYlre0njWQaLA3t8xOf/4hbuq915Zl+XHNLs7L6zpcbY4hGdNl3/BxbfL8aPKtUiJmBuKD957IOFq8EJUoacq+wUJilhtrKdeB0srx3zZaJBH5UNiwWx1fqLwjvRWGhd4DuK7XTFkSosCyeMIFVYfX4hMR4xWnLCWNP+PzD3V2UWWkM3hUO11scIrUaRV6MPfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wW9mM23P6olfLLcEslwMPQ38+sYdcX18HfJsbDxv3ks=;
 b=MtW5dvoQ/BHoKDcLrb3w3ANtFaipYQqDeCG302bamGoIyXRoDVEKBpAr7XpFJv2HK+F01Oci+gzWDtatjfMdoqL4b/AhTF7duY8y0Vt5psrrbJ2fm5p3aPWYxrz9CekNA4oHFZ+rCKS6wFAy3B88UFmeSE/Rpu5002sybMmCjHv/3MAOd03pgztO5JhFRZk0WxoTphnf8/K4Bbg/VOqKTvBuDkgJ6hFB3EEMvKkI9wFHTQuYaAZWKab5bDJ2GSMjnziuT+x97dpB4njqgnvssc8ZiFOk34UF9xa2OAjRzBq+QZKCogLFiAg8opoGW8OHeij7yxLlW5+jZ1nDhS0R/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=gmail.com smtp.mailfrom=opensynergy.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=opensynergy.com;
 dkim=none (message not signed); arc=none
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
	Igor Skalkin <Igor.Skalkin@opensynergy.com>
Date: Fri, 10 Mar 2023 07:26:13 +0100
Message-Id: <20230310062613.109867-2-Igor.Skalkin@opensynergy.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230310062613.109867-1-Igor.Skalkin@opensynergy.com>
References: <20230310062613.109867-1-Igor.Skalkin@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1EUR05FT057:EE_|FR3P281MB3037:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e295fb20-1184-4c5e-0045-08db21307a1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Vkj/UL7/A0xOftSXEGwoegQOLLtXfw3Zsn/IT5I7n/+AfwtfH6JC5ghEkn7X9ps8O+V3YVQj2NXZKRx1wfTvHm9E1d3RSc2eewriCBuHLlFpxF5JzdB6g/UYfuebmk77vRd5jl1gCF5NZk2ZnqOlv1xP2rjKX5PBOiIN7F4TbCjcmvqvYv9kWiTKEcJ5Fru/jrIH+GzVHBbBAuNdx/NKw0uTqsLBdGIx0fwaTqzV3JqDdS7RfSJEt1GnFXisXogsRJqEHtZ4iBUv+r1gTb5jlr51sn5uILpqW5GLmBqqYMNpWeck4x+jbV4f/rDQPiGTEO2ruW3gqOxa70+jhN3Rfq+YPex+2+SX6pW8C9hQSYB3fjvk/0TxtJFUtWlvZwuLR8XoctPLG5vjc6+T0NPeUAVvr7sTI7/sAacehY1jgFNvl0ULYiljSbAbA+mWSdAa8FpivWw5KbFmRRBZWUorWX6OwZKI7GDptlWE7A0UQqwbR/Bfbvg6E3YJoHPH16FwXKU6EeD7Syayzb9scsJQMa1mCJwueBe8Q9qYoer7rL/fS2SIbaImSLW/I6b7ItrKy/Gsm9Oh+oS2Cg37Na6Y4GXqISEs7wD0fvt0mfQ2NYtY7b2lE6dnGEcUtfDqx3qWziQGx3/IQxJyYDUQqlitq3LAzp36pHQgCeIyhvih9pVZdxdvb4yC2knInynwAT7M
X-Forefront-Antispam-Report:
	CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(396003)(39840400004)(346002)(376002)(136003)(451199018)(46966006)(36840700001)(66899018)(82310400005)(36860700001)(83380400001)(47076005)(36756003)(40480700001)(81166007)(42186006)(316002)(478600001)(107886003)(336012)(186003)(26005)(1076003)(2616005)(5660300002)(70206006)(8676002)(41300700001)(70586007)(2906002)(8936002)(4326008)(86362001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 06:27:09.2987
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e295fb20-1184-4c5e-0045-08db21307a1d
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VI1EUR05FT057.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB3037
X-TM-AS-ERS: 104.47.11.170-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1006-27494.006
X-TMASE-Result: 10--30.894400-4.000000
X-TMASE-MatchedRID: fVxtjXdaHW00b21ExFN2+nYiw8L1nrYY3AJrtcannraghGjfPV9/aYO3
	HyUMPRbHjD2u30TwDiivwm0pw/7rQdz4cH5hW96YzYK5U+QI3O7BOVz0Jwcxl6vCrG0TnfVUaUX
	s6FguVy2877BVIJP3X30GFT5KU5MDUb9lEuZnMySyMWcHlEdDX9G3Y6ijqBt3WAuSz3ewb23T0P
	pHDbMiszbHLXsjW/n4T98vouvikxtjAEhhEuKD9rlu+/8vPerI+KgiyLtJrSBLpCLN4NR43qwpC
	vKgKbVfZiWKmYVwM5QbPfMmu2qCIexH/XlL8qoOYPyK201ebhuOiQxt3vkkCmeyTJ7naNGimBnb
	6j1x5fRAUdCMBZ4OHz18102FWUCN2LGVgOBkVOaXfrypKnpvnhB0ENZnw1vtXKP1Yab5oz6iOWo
	VIe7Hu4LT55GSQ5sWUoG/ENIRZF6R9GF2J2xqM1EZp44lOcxbaZGo0EeYG97p46aWZIqarfoLR4
	+zsDTtAqYBE3k9Mpw=
X-TMASE-XGENCLOUD: 91a680fa-b27a-4317-874f-c1d3c3cff982-0-0-200-0
X-TM-Deliver-Signature: 279CACD6D436E2096BFDC8061A076D9B
X-TM-Addin-Auth: TqeZwSUnUqrEAYpDhsNAvowsydbk8Mvq75RAS6ECVOXlrschixxkYljBMo4
	xPzHJzUA1t3v1upICW6WD/nSHWq0idiih2mg3mBh62fw3xG+Pnk8t/fomchHTasuzls2mRuhRqy
	uzN6WY4nqdX8z8JFU1fEtKWYzY0viyd1GVyUgjBjW5Cu0A+QLIkWCGGC30BcTYVwevzJx8zcQU7
	RrjKKtM1Fu3biFhYrhbpb0Af6AdIIuw/BcO5LBqlh4RMxDUw7iJnuJ+qfMAJjHE1eoPCN8ye/kH
	Qe4jGdnjh7QJRAk=.I/oCcLBfyIyz5hdYF/eVNXbcN4+7Yje6g6eAzDKcXKbo4yLP1Giu3otm3m
	Yo/i4E8PqwCntOt2YlP0fHkCnB0UPNlWLJk7jppEx/HwaSv53QzEd42+ahe+gkEZU3499rjoXVJ
	csOENiF3W2q7VzKWoQNeXnMFTgvCBGZ/n6ShO1P975UIsSvfZekKjBnbdDNtTw++ISQdLpeE0En
	CSiPOqBaLCL2La34oKNH3fWPtqfC/LAqDclu7+NqtUW8QboVG7BUKm7USft6MyX0W14iB0t2VHY
	ypY/IoKmyOeVK+Re5BrnjRLujrI3Me1/ZtW7o/46w5Ft/Kik1Lomf4IqKmA==
X-TM-Addin-ProductCode: EMS
Subject: [virtio-dev] [PATCH 1/1] RFC: virtio-bt: add virtio BT device specification

This PR is aimed as review for comments(RFC) purpose.

* Initial draft version.

Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
---
 conformance.tex                        |  12 ++-
 content.tex                            |   1 +
 device-types/bt/description.tex        | 112 +++++++++++++++++++++++++
 device-types/bt/device-conformance.tex |   8 ++
 device-types/bt/driver-conformance.tex |   8 ++
 5 files changed, 137 insertions(+), 4 deletions(-)
 create mode 100644 device-types/bt/description.tex
 create mode 100644 device-types/bt/device-conformance.tex
 create mode 100644 device-types/bt/driver-conformance.tex

diff --git a/conformance.tex b/conformance.tex
index 01ccd69..a69eb47 100644
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
index 0c7cdf8..3723ec8 100644
--- a/content.tex
+++ b/content.tex
@@ -3022,6 +3022,7 @@ \chapter{Device Types}\label{sec:Device Types}
 \input{device-types/scmi/description.tex}
 \input{device-types/gpio/description.tex}
 \input{device-types/pmem/description.tex}
+\input{device-types/bt/description.tex}
 
 \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
 
diff --git a/device-types/bt/description.tex b/device-types/bt/description.tex
new file mode 100644
index 0000000..3ce265d
--- /dev/null
+++ b/device-types/bt/description.tex
@@ -0,0 +1,112 @@
+\section{BT Device}\label{sec:Device Types / BT Device}
+
+The virtio-bt device provides an HCI (Host Control Interface) over VirtIO
+link between the guest HCI device and the host HCI backend.
+Also, the device can inform the guest driver which vendor-specific command
+set it supports.
+Host Control Interface is described in Bluetooth Core Specification:
+\newline\url{https://www.bluetooth.com/specifications/specs/core-specification-5-4/}\\
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
+\item[VIRTIO_BT_F_VND_HCI (0)]  Indicates vendor command support.
+\item[VIRTIO_BT_F_MSFT_EXT (1)] Indicates MSFT vendor support.
+\item[VIRTIO_BT_F_AOSP_EXT (2)] Indicates AOSP vendor support.
+\item[VIRTIO_BT_F_CONFIG_V2 (3)] The device uses the second version of the
+configuration space structure.
+\end{description}
+
+\devicenormative{\subsubsection}{Feature bits}{Device Types / BT Device / Feature bits}
+
+The device MUST require the driver to accept the VIRTIO_BT_F_CONFIG_V2 feature
+bit, i.e. not set FEATURES_OK without it, and use the second version
+(struct virtio_bt_config_v2) of the configuration layout, because the
+first one (struct virtio_bt_config) is unaligned, which violates the
+specification.
+
+The device should offer VIRTIO_BT_F_MSFT_EXT or VIRTIO_BT_F_AOSP_EXT feature bit
+if it supports correspondingly MSFT or AOSP extension command sets. In case of
+VIRTIO_BT_F_MSFT_EXT, device should also set configuration \field{msft_opcode}.
+
+The device should offer VIRTIO_BT_F_VND_HCI feature bit and set \field{vendor}
+to the VIRTIO_BT_CONFIG_VENDOR_ZEPHYR, VIRTIO_BT_CONFIG_VENDOR_INTEL or
+VIRTIO_BT_CONFIG_VENDOR_REALTEK, if it supports corresponding vendor extensions.
+
+\drivernormative{\subsubsection}{Feature bits}{Device Types / BT Device / Feature bits}
+
+The driver MUST accept VIRTIO_BT_F_CONFIG_V2 feature bit if offered by the device.
+
+The driver SHOULD accept any of the  VIRTIO_BT_F_VND_HCI, VIRTIO_BT_F_MSFT_EXT
+or VIRTIO_BT_F_AOSP_EXT feature bits if offered by the device.
+
+\subsection{Device configuration layout}\label{sec:Device Types / BT Device / Device configuration layout}
+
+
+The first version:
+\begin{lstlisting}
+struct virtio_bt_config {
+	u8 type;
+	le16 vendor;
+	le16 msft_opcode;
+} __attribute__((packed));
+\end{lstlisting}
+
+is deprecated, new devices must use the second one:
+\begin{lstlisting}
+struct virtio_bt_config_v2 {
+	u8 type;
+	u8 alignment;
+	le16 vendor;
+	le16 msft_opcode;
+};
+\end{lstlisting}
+
+\devicenormative{\subsubsection}{Device configuration layout}{Device Types / BT Device / Device configuration layout}
+The device MUST NOT present a value different than
+\begin{lstlisting}
+	VIRTIO_BT_CONFIG_TYPE_PRIMARY = 0,
+	VIRTIO_BT_CONFIG_TYPE_AMP = 1,
+\end{lstlisting}
+in \field{type}.
+
+The values 1..3 of the \field{vendor} are already reserved for vendor extensions listed below:
+\begin{lstlisting}
+	VIRTIO_BT_CONFIG_VENDOR_NONE = 0
+	VIRTIO_BT_CONFIG_VENDOR_ZEPHYR = 1
+	VIRTIO_BT_CONFIG_VENDOR_INTEL = 2
+	VIRTIO_BT_CONFIG_VENDOR_REALTEK = 3
+\end{lstlisting}
+
+If value of the \field{vendor} is not VIRTIO_BT_CONFIG_VENDOR_NONE, device MUST
+offer VIRTIO_BT_F_VND_HCI feature bit.
+
+\drivernormative{\subsubsection}{Driver configuration layout}{Device Types / BT Device / Driver configuration layout}
+All configuration fields are read-only for the driver.
+
+\subsection{Device initialization}\label{sec:Device Types / BT Device / Device initialization}
+
+The virtqueues are initialized.
+
+\subsection{Device operations}\label{sec:Device Types / BT Device / Device operations}
+
+The driver SHOULD populate the receive queue with at least one buffer of at
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
index 0000000..7b73f4a
--- /dev/null
+++ b/device-types/bt/device-conformance.tex
@@ -0,0 +1,8 @@
+\conformance{\subsection}{Bluetooth Device Conformance}\label{sec:Conformance / Device Conformance / Bluetooth Device Conformance}
+
+A BT device MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / BT Device / Feature bits}
+\item \ref{devicenormative:Device Types / BT Device / Device configuration layout}
+\end{itemize}
diff --git a/device-types/bt/driver-conformance.tex b/device-types/bt/driver-conformance.tex
new file mode 100644
index 0000000..2264a79
--- /dev/null
+++ b/device-types/bt/driver-conformance.tex
@@ -0,0 +1,8 @@
+\conformance{\subsection}{BT Driver Conformance}\label{sec:Conformance / Driver Conformance / BT Driver Conformance}
+
+A BT driver MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{drivernormative:Device Types / BT Device / Feature bits}
+\item \ref{drivernormative:Device Types / BT Device / Driver configuration layout}
+\end{itemize}
-- 
2.37.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

