Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A7D35F8DF
	for <virtio-dev@lists.linux.dev>; Fri,  6 Feb 2026 17:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770397976; cv=none; b=Vgzjz326R7rjHD/mcX6hNqJU7LbiYLhNYdJmX+QuIyZHW5BPtjB+rFhrA82iVWQo0XKkQ2b9NzfKH8ZhP5MsPrwKGdwh3qdUjQRm3vlAYBCJWKGbgJA8y3XvQg8WzLyPt8RcW8gHXbiVqP/cwwHcMPf33ZXR95sdtYBhSb0iWgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770397976; c=relaxed/simple;
	bh=ncS77gKRwTWIL7x4yXAHGk6IXJiK+0yjYWb6See+zEQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mG80IhkHW0OP9givf0nR6Wn60QHU9CEouM7A+WVWwBxJ+h0aH8Sc/gbLqAE19UvOZnfYfQFCWuLdewB12BLR5PF7HjYsRiewGHUN7bdtfmk1gt3gWm7bGWScphTE86o3KM5COAzTSRQ80eEf1FcvbYeIr9M4Pnq67eFM1y2V6pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aJ1IIe7A; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aJ1IIe7A"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 616B4V9E3764710;
	Fri, 6 Feb 2026 17:12:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fYNZZLt5J7yJ4IVFzSN5NtK/gSanDmM3DPjNE9zvoDY=; b=aJ1IIe7Agtk3KwX9
	+aOmPH0rkJTOVCJUCnCWGHM8gkf1naCrZef8EAeuJbmHtg7//hVkCs3Udgs9279D
	GgcNIdj7QQ2MMKAFm0Zubx4SPpwc6ykwIxnomqL8Pt+XNAbgEXRz0uBAE7J1oleN
	+GRUMZPSjEbaUXmlBxvxP8mOjTyikC4KrxMpinfcKhOnbGX++wphr9b5mORQ9Lc+
	nRPi9nwCNm4HVbqT9yDxe2Van6WLaNDkBJf5yJYcNYEFu/ElJX9Fgoh4hFngtB74
	x2LAN64t59vgH6AD6sc0cGPkRNoWWqPlLlnGONM06RyXUHwFJbDhwPhZt1h4/3at
	b7WLkA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c5f3wh1yq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 17:12:54 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 616HCrg8014772
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Feb 2026 17:12:53 GMT
Received: from linlzhan-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 6 Feb 2026 09:12:52 -0800
From: Linlin Zhang <quic_linlzhan@quicinc.com>
To: <virtio-dev@lists.linux.dev>, <stefanha@redhat.com>
CC: <quic_dshaikhu@quicinc.com>
Subject: [PATCH v2] virtio-blk: Add inline encryption support
Date: Sat, 7 Feb 2026 01:12:18 +0800
Message-ID: <20260206171218.1748260-1-quic_linlzhan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260204172749.GA610283@fedora>
References: <20260204172749.GA610283@fedora>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDEyNSBTYWx0ZWRfXwiuc1UUpfb8y
 kefMtbom1wC1X02PrdSPHkGKPYqCUgU18OP7oD7pwUUZlE7JOoFAb2C7mN/t6ONdVdlAbAbZhTr
 Urzp8uB2K8gTmy96MLNaEqm8rtN8KDfwgan9AD/lnuWW7f82Widw1pYSy+K3wXPuDxuxKnNX7EK
 Llr9dYCpxniMLuYe0VH/xY6Luc3vM3shdMwIzs/RCUW8VCVPQ5S6qCL/bpc49SKQT8+sL8lbzqH
 5IXR7pKvZaQtr3KFyaFXVLsyHV9W/ceaCmOtuSEI+uSRkebCs/avRHqsZqC+rdZwnh9/5dL5vC+
 ScNxOwbu4jShaFNovLacTluNpw1/ONBPY5/YVcJ4vme/462Qt6ESpDUeSl41FTDW/FcHFVh6POI
 H+CU+FL6h3Um7W14OykGuwmhq4Li/5JIy7F4f30LD7DDv1q36rYU1ZKg4ICV3nJHZYTSVo7gll3
 fx2c9vZBq2R/eiMC+Dg==
X-Proofpoint-ORIG-GUID: 77Robe6zZM_Lj6yMixXavxirPf5t7LZr
X-Authority-Analysis: v=2.4 cv=NajrFmD4 c=1 sm=1 tr=0 ts=69862116 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=COk6AnOGAAAA:8 a=20KFwNOVAAAA:8
 a=EUspDBNiAAAA:8 a=Rwu5TU5C4Xmeo1I2ddMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 77Robe6zZM_Lj6yMixXavxirPf5t7LZr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602060125

From: linlzhan <quic_linlzhan@quicinc.com>

Inline encryption on virtio block can only be supported when
the new feature bit VIRTIO_BLK_F_ICE is negotiated.

Extend struct virtio_blk_config and struct virtio_blk_req,
so that crypto capabilities can be got in the frontend and
encryption metadata can be sent to the backend, together with
each I/O transaction.

About the inline encryption on UFS or eMMC storage, please
refer to the Linux inline encryption documentation:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/block/inline-encryption.rst

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/238
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: linlzhan <quic_linlzhan@quicinc.com>
Signed-off-by: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
---

changes from v2:
 - Add inline encryption link in commit message for a better
   backgrond descryption
 - Add sufficient descryption for the fields of crypto
   capability
 - Delete crypto capability in configuration layout, instead
   add a new request command to get it
 - Correct the terminology in non-normative and normative
   sections
 - Correct the mail for open source upstream
---

 device-types/blk/description.tex | 110 ++++++++++++++++++++++++++++++-
 1 file changed, 108 insertions(+), 2 deletions(-)

diff --git a/device-types/blk/description.tex b/device-types/blk/description.tex
index 2712ada..60f46af 100644
--- a/device-types/blk/description.tex
+++ b/device-types/blk/description.tex
@@ -66,6 +66,11 @@ \subsection{Feature bits}\label{sec:Device Types / Block Device / Feature bits}
 	(ZNS). For brevity, these standard documents are referred as "ZBD standards"
 	from this point on in the text.
 
+\item[VIRTIO_BLK_F_ICE(22)] Inline Crypto Extensions are supported. Only when this
+     feature bit is negotiated, the device need expose crypto characteristics in
+     configuration space and the driver need provide an extended request header
+     containing a crypto payload for block I/O.
+
 \end{description}
 
 \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Block Device / Feature bits / Legacy Interface: Feature bits}
@@ -128,6 +133,10 @@ \subsection{Device configuration layout}\label{sec:Device Types / Block Device /
                 u8 model;
                 u8 unused2[3];
         } zoned;
+        struct virtio_blk_crypto_characteristics {
+                __virtio16 slot_info;
+                __virtio16 reserved;
+        } crypto;
 };
 \end{lstlisting}
 
@@ -215,6 +224,18 @@ \subsection{Device configuration layout}\label{sec:Device Types / Block Device /
 terminated by the device with a "zone resources exceeded" error as defined for
 specific commands later.
 
+If the VIRTIO_BLK_F_ICE feature is negotiated, then in
+\field{virtio_blk_crypto_characteristics},
+\begin{itemize}
+\item \field{slot_info} value packs two 8-bits values to reduce the number of
+    Configuration Space reads.
+    \begin{itemize}
+        \item Bits~\[15:8] (\emph{max\_slots}): the maximum number of supported
+            crypto key slots.
+        \item Bits~\[7:0] (\emph{slot\_offset}): an offset applied to slot numbering.
+    \end{itemize}
+\end{itemize}
+
 \subsubsection{Legacy Interface: Device configuration layout}\label{sec:Device Types / Block Device / Device configuration layout / Legacy Interface: Device configuration layout}
 When using the legacy interface, transitional devices and drivers
 MUST format the fields in struct virtio_blk_config
@@ -278,6 +299,10 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
     \field{zoned} can be read by the driver to determine the zone
     characteristics of the device. All \field{zoned} fields are read-only.
 
+\item If the VIRTIO_BLK_F_ICE feature is negotiated, the fields in
+    \field{crypto} can be read by the driver to determine the inline crypto
+    characteristics of the device. All \field{crypto} fields are read-only.
+
 \end{enumerate}
 
 \drivernormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
@@ -317,6 +342,9 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
     driver SHOULD ignore all other fields in \field{zoned}.
 \end{itemize}
 
+If the VIRTIO_BLK_F_ICE feature is negotiated, then the driver MUST validate
+    the max_slots in \field{slot_info} before the slot usage.
+
 \devicenormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
 
 Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it
@@ -402,6 +430,13 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
 \item the device MUST initialize padding bytes \field{unused2} to 0.
 \end{itemize}
 
+If the VIRTIO_BLK_F_ICE feature is negotiated, then the fields in \field{crypto}
+struct in the configuration space MUST be set by the device.
+\begin{itemize}
+\item the \field{slot_info} field of \field{crypto} MUST be set by the device to a
+    max_slots in the higher 8 bits and slot_offset in the lower 8 bits.
+\end{itemize}
+
 \subsubsection{Legacy Interface: Device Initialization}\label{sec:Device Types / Block Device / Device Initialization / Legacy Interface: Device Initialization}
 
 Because legacy devices do not have FEATURES_OK, transitional devices
@@ -436,6 +471,13 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
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
@@ -445,8 +487,9 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
 (VIRTIO_BLK_T_OUT), a discard (VIRTIO_BLK_T_DISCARD), a write zeroes
 (VIRTIO_BLK_T_WRITE_ZEROES), a flush (VIRTIO_BLK_T_FLUSH), a get device ID
 string command (VIRTIO_BLK_T_GET_ID), a secure erase
-(VIRTIO_BLK_T_SECURE_ERASE), or a get device lifetime command
-(VIRTIO_BLK_T_GET_LIFETIME).
+(VIRTIO_BLK_T_SECURE_ERASE), a get device lifetime command
+(VIRTIO_BLK_T_GET_LIFETIME), or a get device crypto capabilities command
+(VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES).
 
 \begin{lstlisting}
 #define VIRTIO_BLK_T_IN           0
@@ -457,12 +500,27 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
 #define VIRTIO_BLK_T_DISCARD      11
 #define VIRTIO_BLK_T_WRITE_ZEROES 13
 #define VIRTIO_BLK_T_SECURE_ERASE   14
+#define VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES   27
 \end{lstlisting}
 
 The \field{sector} number indicates the offset (multiplied by 512) where
 the read or write is to occur. This field is unused and set to 0 for
 commands other than read, write and some zone operations.
 
+The \field{payload} consists of the encryption information for current
+request. It is only present when the VIRTIO_BLK_F_ICE feature is negotiated and
+\field{type} is VIRTIO_BLK_T_IN, VIRTIO_BLK_T_OUT or VIRTIO_BLK_T_FLUSH.
+\begin{itemize}
+\item The \field{slot} field in \field{payload} indicates the ICE
+  (Inline Crypto Encryption) slot index where the key resides.
+
+\item The \field{activate} field in \field{payload} implies this is a
+  inline encryption request.
+
+\item The \field{data_unit_num} field in \field{payload} indicates the
+  starting block of the request.
+\end{itemize}
+
 VIRTIO_BLK_T_IN requests populate \field{data} with the contents of sectors
 read from the block device (in multiples of 512 bytes).  VIRTIO_BLK_T_OUT
 requests write the contents of \field{data} to the block device (in multiples
@@ -530,6 +588,47 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
 The \field{device_lifetime_est_typ_b} refers to wear of MLC cells and is provided
 with the same semantics as \field{device_lifetime_est_typ_a}.
 
+VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES requests fetch the storage hardware crypto
+capabilities into \field{data}. And the \field{data} is of the form
+
+\begin{lstlisting}
+struct virtio_blk_crypto_caps {
+  u8 size;
+  le32 crypto_capabilities[];
+};
+\end{lstlisting}
+
+The \field{size} specifies the size of array \field{crypto_capabilities}.
+The \field{crypto_capabilities} indicates the crypto capabilities supported by the
+hardware storage for inline encryption.
+
+A crypto capability packs four 8-bits values:
+\begin{itemize}
+    \item Bits~\[31:24]: crypto algorithm identifiers.
+    The device supports reporting and negotiating cryptographic algorithms
+    using the following algorithm identifiers:
+    \begin{lstlisting}
+        CRYPTO_ALG_AES_XTS              = 0x0
+        CRYPTO_ALG_BITLOCKER_AES_CBC    = 0x1
+        CRYPTO_ALG_AES_ECB              = 0x2
+        CRYPTO_ALG_ESSIV_AES_CBC        = 0x3
+    \end{lstlisting}
+    These identifiers abstract the underlying hardware crypto implementation
+    and does not assume any operating‑system‑specific data structures or
+    constants.
+    \item Bits~\[23:16]: mask of data unit size. When bit j in this field
+    (j=7......0) is set, a data unit size of 512*2^j bytes is selected.
+    \item Bits~\[15:8]: crypto key size identifiers.
+    \begin{lstlisting}
+        CRYPTO_KEY_SIZE_INVALID     = 0x0
+        CRYPTO_KEY_SIZE_128_BITS    = 0x1
+        CRYPTO_KEY_SIZE_192_BITS    = 0x2
+        CRYPTO_KEY_SIZE_256_BITS    = 0x3
+        CRYPTO_KEY_SIZE_512_BITS    = 0x4
+    \end{lstlisting}
+    \item Bits~\[7:0]: unused.
+\end{itemize}
+
 The final \field{status} byte is written by the device: either
 VIRTIO_BLK_S_OK for success, VIRTIO_BLK_S_IOERR for device or driver
 error or VIRTIO_BLK_S_UNSUPP for a request unsupported by device:
@@ -912,6 +1011,13 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
 successfully, failed, or were processed by the device at all if the request
 failed with VIRTIO_BLK_S_IOERR.
 
+The length of \field{data} MUST be a multiple of 4 bytes plus 1 for
+VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES requests.
+
+A driver MUST set \field{activate} to 1 for VIRTIO_BLK_T_IN,VIRTIO_BLK_T_OUT,
+    and VIRTIO_BLK_T_FLUSH requests that require inline encryption. For other
+    request types or when inline encryption is not required, it is set to 0.
+
 The following requirements only apply if the VIRTIO_BLK_F_ZONED feature is
 negotiated.
 
-- 
2.34.1

