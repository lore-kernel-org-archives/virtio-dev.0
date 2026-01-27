Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72BD3101BB
	for <virtio-dev@lists.linux.dev>; Tue, 27 Jan 2026 14:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769523296; cv=none; b=bA5yLNDSH09csoh80SlKzuQwOfZFwCgdk341c2UzbtTjuYxw8Az5A/wa4ZmvgC/vPap8zkVzILdD8IehxSAb4f8RfZ2WTD8b5RT9+Fo9c4rg7F3fIMv3RG4sSa7f0YPd1G//yxNpkQsgzZG32nG1y1zqsTIVgFkX1x7htB74krQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769523296; c=relaxed/simple;
	bh=rqzGlcXzUOvVHc/oHnrDMI9+gUU1sv8s0lZ81Z3yqtg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aoDcDrZbJsuP50Ofmcvz1C1/VwbA08Bt6RtroQYZL/yRegSGNe+dUsHj0ysF/L16AY6YgR24pfNZ6KVljettOhGRwUxTqhDfAh4k4TQP3ei9Bst4xZjRRNDkH+ezFx77es5aYbO+nD1BryjCMQsx3XgMLf1x8sDyQ4WV1yi7at0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lFFwjVYw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lFFwjVYw"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RDg3hq658896
	for <virtio-dev@lists.linux.dev>; Tue, 27 Jan 2026 14:14:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=h2vaRjh6rWzZ8H/aZyjySG
	hLzn3jNbeWMb7xFbgGQ+A=; b=lFFwjVYwFj45uGFOoJl3S1CQVhGBStVvp4X44G
	jfI7uKtj0E+o9BbdTlMACmSG9ZLiwgAhL6FeI4/C9VrMA64i9aU/gDrcsyN6Qijn
	lu9VKiETqJg6/IRKLEHvWBnXIZS2NGAPO0MJKwEyqD5kxDMXI/MaAahU7kvzhw9d
	XEw+GAVJYNOzPAKcCixK10kpy41pg3qbgu2hEtRYdtuTZx2akMhPsgw7r9Lxi8aK
	CUWsiQhd0AHFwq2QlWpnzwxOnO+OCmJnN/8e85GG92YKp7omm2y9J+7eKUzqof90
	NhcjXmSXj4LtwzbewWM9wNCJZ20uy6HeexDBCed+w5RFcOfA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxryn9ap8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Tue, 27 Jan 2026 14:14:53 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 60REEr0G003497
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Tue, 27 Jan 2026 14:14:53 GMT
Received: from linlzhan-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 27 Jan 2026 06:14:51 -0800
From: Linlin Zhang <quic_linlzhan@quicinc.com>
To: <virtio-dev@lists.linux.dev>
CC: <quic_dshaikhu@quicinc.com>, <quic_spunacha@quicinc.com>
Subject: [PATCH v1] virtio-blk: Add inline encryption support
Date: Tue, 27 Jan 2026 22:14:32 +0800
Message-ID: <20260127141432.2617357-1-quic_linlzhan@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: r5O6-g3lrilxpTomIQTT5W30AkPy3fs6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDExNiBTYWx0ZWRfX9aaxSyULNYuy
 iYEEVQ8UrQd61s3c9Dm7vTSmbMNH9aIwSE23p7SEYCsUMImzAT88QAe6tQ9C+L1pa3QeKcKenaL
 a7KisHhpp6c/Ip/6973D3UohCHoG/H5YY5F8W7hpDeplrVTIvTe4JrkBwjoBOPJ6UBLS0jCiSyK
 ubPdhZDNSXpRp0chzF6mdpZkPAkeLeyjBXQ/XAlJ43mTU9DM9ITBjBGriRN7nuVoy6lqPBqaJn9
 vuZ9PpjvlsEc4OULaJh2xFc3vfIeTIaXNadPoptXXxr2OwNJGYeIklx7bzJV++CUd1u/vOI+xtB
 WUW1LrInsJDZ/LiWKLmp6p0At4/VGYyzpZ3NWF45CL4AGTzOrWYtWX4Dsdin9ee4Q1C7J80HDiL
 Vm1JlJA5yne5R6Rv/Pk+m5JWj8Az12Xs7BJN0w3lHDYuaH//FvONN3im1kPzl5m3NoLC6eG2l2a
 8UInM7l9/GA8yuesFGA==
X-Proofpoint-GUID: r5O6-g3lrilxpTomIQTT5W30AkPy3fs6
X-Authority-Analysis: v=2.4 cv=FsEIPmrq c=1 sm=1 tr=0 ts=6978c85d cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=nGuF1CrgE_JbnNSJFKAA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270116

From: linlzhan <quic_linlzhan@quicinc.com>

Inline encryption on virtio block can only be supported when
the new feature bit VIRTIO_BLK_F_ICE is negotiated.

Extend struct virtio_blk_config and struct virtio_blk_req,
so that crypto capabilities can be got in the frontend and
encryption metadata can be sent to the backend, together with
each I/O transaction.

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

