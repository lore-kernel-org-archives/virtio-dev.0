Return-Path: <virtio-dev-return-13359-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFF1C001B0
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 22:24:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2ED0441EE8
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 22:24:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E2BF1986855
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 22:24:54 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BD3DE98687D; Wed, 12 Jul 2023 22:24:54 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BF7AF98683B;
	Wed, 12 Jul 2023 22:24:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dh834Ry0TY2OkMt8othcWJLQs+RSx302mC8FFzgQ74c6SSjjdm08ZTL3VhFMpk3oQ9OkLsb30GRgrtwL45nacUEf2Rrew41FUOETBW2pnc+OtbmQVRj2mBmVXcNpNTguyVjNQXJqnDnq/WyY7smWlY3JMEqrGji3MATcsnZZ5EwN1dpQX/QjFhOuEgJ2Ey08BDzxOmNDN3VN7Jh26pROG55tsy+/wLyfA7Qncsavhbm7EoPeKF2wxzgagZXftWATP5YMn2Vq9cb8PY3NobRk+L1YYiG75u59TSqpjkyGU6KrBTuceXDnmffLQ+aq0y+tZoJ02Ege1BP/m6QxrfFwpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MaxNe1ghHBkivYOBNgSYnth7uVXBAatkjt6kGye96uw=;
 b=dRd+YkvkLMXQY6ibT7c298B15fBM093d8+GL0ha9P5M99fXmrgDJz1T74HpB+bvfl7/0kjBDWskVqHyPGvlCp0wlN6Xnyz8vIKf70Y9TInAPedcXQh2PMyTuBFIgR4WaoseyXkBawzlZyDCGLW0pU2TOB82Rzcy1egJ5IB9dQEnssyNIhYMaXyoDna4I74vWunDUFFCaRv2uTQmtoPnfmjM1eFel3/OEQlpW+aFlDQn5wJFwEiovun/7gPy1jAgI1GIx1GHDJ1+boZsrKKdGKqc+MQz1hBgAb7Ub0lgvI6SCaIqjBk+0TiIdqL4B5v6M2cb/eV/PLH0mYzQL83yuaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.oasis-open.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
From: Parav Pandit <parav@nvidia.com>
To: <virtio-comment@lists.oasis-open.org>, <mst@redhat.com>,
	<cohuck@redhat.com>
CC: <virtio-dev@lists.oasis-open.org>, <hengqi@linux.alibaba.com>,
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>
Date: Thu, 13 Jul 2023 01:24:03 +0300
Message-ID: <20230712222405.455201-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230712222405.455201-1-parav@nvidia.com>
References: <20230712222405.455201-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT112:EE_|BL1PR12MB5780:EE_
X-MS-Office365-Filtering-Correlation-Id: d37b9110-67fa-4f3f-c54d-08db8326c86b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Lflj984bxgLdFisLrvYsuGPA9JCRHTBiAg0acYsZxOE7vRl3hj22VM5gM3Q8t2Q3bz/pNKFN2TnUVTKEvOMAiX74rifiY/sc2fA1xqzA99YpKikjOkKq+oRFmWZP+yHr5TgWl2zdn3+CUUoCjvzc5n+oa0fGcgfgcReXislDr3K9fIjBE1t9CnkulQB/omTE2FQqSVnF2Xh8ujq4S1Xl/N6Wno+uwuY8/JegQ56Rep5yCMcfVxwkxDewa6OWGjHPYhQhKgGK497W+pn/C1MgozDc1pR0b7XyBhbCUbFa0o6jW2OtlYE4FZ/Sl0UpYMF97ykC8bh1aA+JErHJ71VXMR0BmkIfS/KEO4p5FIw6KR3ORa0C4N8NPpf2Uszf1cTylfLRV3um+NifBEQ/8lrY5EiYrcaAqQLAHvl4wFXi2WgXa5nCE1WFvL4Y3wPpXyDwE57SIDbS78nd3rnUt01wvwdFLTHUPuCNhMygV1CBQ7kkDlyT6oPTQSbn0jwgLWIRIAoQ5l0TdInUf81bzBxkmdXTh2HZPB0j8GXNBEmm928EdymF2j5XeWKBX9DOm52mVQhMzYwIOhSXmuIvr5dX8XP5qkge2Z10mmL8ftI/R5ayOqY8zpMM5sC8yw0o48JX51wgRjrMvmY8jipHiJooX+ZZIcxf3nO3a1xUi9TCZISjASEsKWaaLJruYUQRJ9O9PKe5p4c+okMk8zJJ+teAd27ukL077nbBP0AxcsFFVWL4dcLYlouh0m6REgiWo4pIZGvl8ADZ12bVmd8L6BCBHg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199021)(36840700001)(46966006)(40470700004)(86362001)(82310400005)(2906002)(110136005)(478600001)(8936002)(54906003)(6666004)(36756003)(41300700001)(4326008)(70206006)(316002)(70586007)(426003)(83380400001)(47076005)(356005)(7636003)(82740400003)(5660300002)(1076003)(36860700001)(40460700003)(8676002)(2616005)(186003)(16526019)(336012)(107886003)(40480700001)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 22:24:39.5528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d37b9110-67fa-4f3f-c54d-08db8326c86b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5780
Subject: [virtio-dev] [PATCH 2/4] virtio-net: Avoid hyphen and extra braces

Avoid hyphen and replace it with white space like rest of the entries.
Also avoid unnecessary braces.
Name RFC as just RFC without special prefix about it.

This likely resolves the html generation errors.

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 device-types/net/description.tex |  2 +-
 introduction.tex                 | 15 +++++++--------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/device-types/net/description.tex b/device-types/net/description.tex
index 6fd4a20..53c811f 100644
--- a/device-types/net/description.tex
+++ b/device-types/net/description.tex
@@ -904,7 +904,7 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
 \end{itemize}
 
 The per-packet hash calculation can depend on the IP packet type. See
-\hyperref[intro:IP]{[IP]}, \hyperref[intro:UDP]{[UDP]} and \hyperref[intro:TCP]{[TCP]}.
+\hyperref[intro:IP]{IP}, \hyperref[intro:UDP]{UDP} and \hyperref[intro:TCP]{TCP}.
 
 \subparagraph{Supported/enabled hash types}
 \label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled hash types}
diff --git a/introduction.tex b/introduction.tex
index 81f07a4..028ec17 100644
--- a/introduction.tex
+++ b/introduction.tex
@@ -101,26 +101,25 @@ \section{Normative References}\label{sec:Normative References}
 	\phantomsection\label{intro:SEC1}\textbf{[SEC1]} &
     Standards for Efficient Cryptography Group(SECG), ``SEC1: Elliptic Cureve Cryptography'', Version 1.0, September 2000.
 	\newline\url{https://www.secg.org/sec1-v2.pdf}\\
-
-	\phantomsection\label{intro:gre_rfc2784}\textbf{[GRE_rfc2784]} &
+	\phantomsection\label{intro:rfc2784}\textbf{[RFC2784]} &
     Generic Routing Encapsulation. This protocol is only specified for IPv4 and used as either the payload or delivery protocol.
 	\newline\url{https://datatracker.ietf.org/doc/rfc2784/}\\
-	\phantomsection\label{intro:gre_rfc2890}\textbf{[GRE_rfc2890]} &
-    Key and Sequence Number Extensions to GRE \ref{intro:gre_rfc2784}. This protocol describes extensions by which two fields, Key and
-    Sequence Number, can be optionally carried in the GRE Header \ref{intro:gre_rfc2784}.
+	\phantomsection\label{intro:rfc2890}\textbf{[RFC2890]} &
+    Key and Sequence Number Extensions to GRE \ref{intro:rfc2784}. This protocol describes extensions by which two fields, Key and
+    Sequence Number, can be optionally carried in the GRE Header \ref{intro:rfc2784}.
 	\newline\url{https://www.rfc-editor.org/rfc/rfc2890}\\
-	\phantomsection\label{intro:gre_rfc7676}\textbf{[GRE_rfc7676]} &
+	\phantomsection\label{intro:rfc7676}\textbf{[RFC7676]} &
     IPv6 Support for Generic Routing Encapsulation (GRE). This protocol is specified for IPv6 and used as either the payload or
     delivery protocol. Note that this does not change the GRE header format or any behaviors specified by RFC 2784 or RFC 2890.
 	\newline\url{https://datatracker.ietf.org/doc/rfc7676/}\\
-	\phantomsection\label{intro:gre_in_udp_rfc8086}\textbf{[GRE-in-UDP]} &
+	\phantomsection\label{intro:rfc8086}\textbf{[GRE in UDP]} &
     GRE-in-UDP Encapsulation. This specifies a method of encapsulating network protocol packets within GRE and UDP headers.
     This protocol is specified for IPv4 and IPv6, and used as either the payload or delivery protocol.
 	\newline\url{https://www.rfc-editor.org/rfc/rfc8086}\\
 	\phantomsection\label{intro:vxlan}\textbf{[VXLAN]} &
     Virtual eXtensible Local Area Network.
 	\newline\url{https://datatracker.ietf.org/doc/rfc7348/}\\
-	\phantomsection\label{intro:vxlan-gpe}\textbf{[VXLAN-GPE]} &
+	\phantomsection\label{intro:vxlan gpe}\textbf{[VXLAN GPE]} &
     Generic Protocol Extension for VXLAN. This protocol describes extending Virtual eXtensible Local Area Network (VXLAN) via changes to the VXLAN header.
 	\newline\url{https://www.ietf.org/archive/id/draft-ietf-nvo3-vxlan-gpe-12.txt}\\
 	\phantomsection\label{intro:geneve}\textbf{[GENEVE]} &
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

