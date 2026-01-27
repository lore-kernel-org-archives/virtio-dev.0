Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A4629E114
	for <virtio-dev@lists.linux.dev>; Tue, 27 Jan 2026 14:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769523652; cv=none; b=VrtWMFkn/dYs+v5azU3F6IUzdVlDzUCGdCj8FaYym1gmxJoCaNf2FxM7lOxjsEpRMO7na40Rr3bsDpvh0AJjS5ahY8VTlcQczdPNUn3g+G/i8TQMICzgeb8o13k0krsN+WKgwIlXDEZSVdqRpNx0VtuzFLqtlptXDcre1emdfcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769523652; c=relaxed/simple;
	bh=NFOce0zH4OLpRhMagKZSNUhHuopAror3Cn2B6q+b/X0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WgsE/P42hN7KF/cJRejDrYNggs33QP3ttZZVKYZ0dv3EQKvFM1pykptli4ZrcU7bxqDoCeY7k7U/nZ2FKONqY/OJ2wfApdGM3TTGDLPYBniZE0bVogmuRbDlshC+anM7T7I60JjP8z5j91RIOQzh+R4V80KaxIvpaBuoZX7e5vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PJ3wUnRn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PJ3wUnRn"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RDobJH113483
	for <virtio-dev@lists.linux.dev>; Tue, 27 Jan 2026 14:20:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dPjTTNVtsnr2iZH/Z2PpvszMH2CL2t1RhkkA8sgYCJ0=; b=PJ3wUnRnt2jUZDiQ
	+98a1CFSvKSehCRF25c3DkCgj+096HV8AnLV9BzEs0h+ZV/i4uirFWKCcpgDuPAv
	VdacZFEP2la6jP2HpELc/Xp1GF6Ioqkesbm8v/dz4ddrJMbrfORXQmEVd+lemxhZ
	JQFoeeQ+wJX41wLfSXmIeA/5wiDf5+ZV/VddPg+djAkrdfZSorHf30RouZneMWm5
	L05WMuUmWptLmM/DQub6KscWqbMv5DOoe/4mm44PxLHKDmzNumrO0yM1so8E0K2m
	/y6oo2/vFc4vW7eW/6vklQvP6RzystR/I0vUB08OoGV1HqFHwlhcSCnXqa5G82te
	pDKsOQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxs0e1c4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Tue, 27 Jan 2026 14:20:50 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 60REKn69007784
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Tue, 27 Jan 2026 14:20:49 GMT
Received: from linlzhan-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 27 Jan 2026 06:20:48 -0800
From: Linlin Zhang <quic_linlzhan@quicinc.com>
To: <virtio-dev@lists.linux.dev>
CC: <quic_dshaikhu@quicinc.com>
Subject: [PATCH v1] virtio-blk: Add inline encryption support
Date: Tue, 27 Jan 2026 22:20:32 +0800
Message-ID: <20260127142032.2619551-1-quic_linlzhan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260127141432.2617357-1-quic_linlzhan@quicinc.com>
References: <20260127141432.2617357-1-quic_linlzhan@quicinc.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDExNyBTYWx0ZWRfX569m+onmBQiZ
 6RGZVtNV6cDVZniHxDZQJsf1QuKR1ztVKkORvVMEIJ1xjbXl5RQHfQATtYpKn975Os4sO5r7U6Q
 eyLmAZ5T7xbiLwTC3618AuBclYsUGsHfzPX2NglWw4xZsRTnoHDdWLyLxftW1/9H0POBRTJDV2Q
 5ndQqgfRNKv8WOUItu8CIpfcYnP/vE8QTPw9zAwPj3d5CasVATukYbyVoLBim3RDDnDt5oqEqjj
 pUIIQqGs7zG1scVP6w7ydWkzrtxDR9wfbh3Qs8ntaPV+L2OE9lV18stSwJ6S+qzrAVxdpx46cf9
 DW170zM1biDfvhxz80vIhQVUkltdaqrLfhY+eTtEu5ftpv/52nLdFq/WHJZbiHrNU4UKuo2l3BV
 gPJBnmWORGDl0D2sLvFHzo2QgPy5L9Bj14EhsIQvs+FDY3y0TLiIS+dxaU8sAIT4Ri0aX915EZZ
 SXLhEexALkASNEfkNiw==
X-Proofpoint-ORIG-GUID: w89ywo9Evya-sB-hiwflDDxVAqmVComR
X-Authority-Analysis: v=2.4 cv=Hvh72kTS c=1 sm=1 tr=0 ts=6978c9c2 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=COk6AnOGAAAA:8 a=nGuF1CrgE_JbnNSJFKAA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: w89ywo9Evya-sB-hiwflDDxVAqmVComR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270117

From: linlzhan <quic_linlzhan@quicinc.com>

Inline encryption on virtio block can only be supported when
the new feature bit VIRTIO_BLK_F_ICE is negotiated.

Extend struct virtio_blk_config and struct virtio_blk_req,
so that crypto capabilities can be got in the frontend and
encryption metadata can be sent to the backend, together with
each I/O transaction.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/238

Change-Id: Ic23b2137e5d9a599d826e06c279f1b614d79abdf
Signed-off-by: linlzhan <quic_linlzhan@quicinc.com>
---
 device-types/blk/description.tex | 69 ++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/device-types/blk/description.tex b/device-types/blk/description.tex
index 2712ada..23d8dc0 100644
--- a/device-types/blk/description.tex
+++ b/device-types/blk/description.tex
@@ -66,6 +66,11 @@ \subsection{Feature bits}\label{sec:Device Types / Block Device / Feature bits}
 	(ZNS). For brevity, these standard documents are referred as "ZBD standards"
 	from this point on in the text.
 
+\item[VIRTIO_BLK_F_ICE(22)] Inline Crypto Extensions are supported. When this
+     is negotiated, the device exposes crypto characteristics in configuration
+     space and the driver SHALL provide an extended request header containing a
+     crypto payload for block I/O.
+
 \end{description}
 
 \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Block Device / Feature bits / Legacy Interface: Feature bits}
@@ -128,6 +133,11 @@ \subsection{Device configuration layout}\label{sec:Device Types / Block Device /
                 u8 model;
                 u8 unused2[3];
         } zoned;
+        struct virtio_blk_crypto_characteristics {
+                __virtio16 slot_info;
+                __virtio16 reserved;
+                __virtio32 capability;
+        } crypto;
 };
 \end{lstlisting}
 
@@ -215,6 +225,25 @@ \subsection{Device configuration layout}\label{sec:Device Types / Block Device /
 terminated by the device with a "zone resources exceeded" error as defined for
 specific commands later.
 
+If the VIRTIO_BLK_F_ICE feature is negotiated, then in
+\field{virtio_blk_crypto_characteristics},
+\begin{itemize}
+\item \field{slot_info} value packs two 8-bits values:
+    \begin{itemize}
+        \item Bits~\[15:8] (\emph{max\_slots}): the maximum number of supported
+            crypto key slots.
+        \item Bits~\[7:0] (\emph{slot\_offset}): an offset applied to slot numbering.
+    \end{itemize}
+\item \field{capability} value packs four 8-bits values:
+    \begin{itemize}
+        \item Bits~\[31:24]: crypto algorithm id.
+        \item Bits~\[23:16]: mask of data unit size.
+        \item Bits~\[15:8]: crypto key size.
+        \item Bits~\[7:0]: unused.
+    \end{itemize}
+\end{itemize}
+
+
 \subsubsection{Legacy Interface: Device configuration layout}\label{sec:Device Types / Block Device / Device configuration layout / Legacy Interface: Device configuration layout}
 When using the legacy interface, transitional devices and drivers
 MUST format the fields in struct virtio_blk_config
@@ -278,6 +307,10 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
     \field{zoned} can be read by the driver to determine the zone
     characteristics of the device. All \field{zoned} fields are read-only.
 
+\item If the VIRTIO_BLK_F_ICE feature is negotiated, the fields in
+    \field{crypto} can be read by the driver to determine the inline crypto
+    characteristics of the device. All \field{crypto} fields are read-only.
+
 \end{enumerate}
 
 \drivernormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
@@ -317,6 +350,9 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
     driver SHOULD ignore all other fields in \field{zoned}.
 \end{itemize}
 
+If the VIRTIO_BLK_F_ICE feature is negotiated, then the driver must validate
+    the max_slots in \field{slot_info} before the slot usage.
+
 \devicenormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
 
 Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it
@@ -402,6 +438,16 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
 \item the device MUST initialize padding bytes \field{unused2} to 0.
 \end{itemize}
 
+If the VIRTIO_BLK_F_ICE feature is negotiated, then the fields in \field{cryto}
+struct in the configuration space MUST be set by the device.
+\begin{itemize}
+\item the \field{slot_info} field of \field{crypto} MUST be set by the device to a
+    max_slots in the higher 8 bits and slot_offset in the lower 8 bits.
+
+\item the \field{capability} field of \field{crypto} MUST be set by the device
+    to a crypto capability read from the storage register.
+\end{itemize}
+
 \subsubsection{Legacy Interface: Device Initialization}\label{sec:Device Types / Block Device / Device Initialization / Legacy Interface: Device Initialization}
 
 Because legacy devices do not have FEATURES_OK, transitional devices
@@ -436,6 +482,13 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
         le32 type;
         le32 reserved;
         le64 sector;
+        struct virtio_blk_crypto_payload {
+            u8 slot;
+            u8 activate;
+            le16 reserved1;
+            le32 reserved2;
+            le64 data_unit_num;
+        } payload;
         u8 data[];
         u8 status;
 };
@@ -463,6 +516,20 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
 the read or write is to occur. This field is unused and set to 0 for
 commands other than read, write and some zone operations.
 
+The \field{payload} consists of the encryption information for current
+request. It need to be set by the driver only when the feature VIRTIO_BLK_F_ICE
+is negotiated.
+\begin{itemize}
+\item The \field{slot} filed in \field{payload} indicates the ICE
+  (Inline Crypto Encryption) slot index where the key resides in.
+
+\item The \field{activate} filed in \field{payload} implies this is a
+  encryption request.
+
+\item The \field{data_unit_num} filed in \field{payload} indicates the
+  starting block of the request.
+\end{itemize}
+
 VIRTIO_BLK_T_IN requests populate \field{data} with the contents of sectors
 read from the block device (in multiples of 512 bytes).  VIRTIO_BLK_T_OUT
 requests write the contents of \field{data} to the block device (in multiples
@@ -912,6 +979,8 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
 successfully, failed, or were processed by the device at all if the request
 failed with VIRTIO_BLK_S_IOERR.
 
+A driver MUST set \field{activate} to 0 for a non VIRTIO_BLK_F_ICE request.
+
 The following requirements only apply if the VIRTIO_BLK_F_ZONED feature is
 negotiated.
 
-- 
2.34.1

