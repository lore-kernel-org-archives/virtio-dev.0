Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDD42F0661
	for <virtio-dev@lists.linux.dev>; Tue, 10 Feb 2026 08:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770712338; cv=none; b=UfAAz+/U1qDRF6baWK4Q5lggF5L47Xk5yksuO76Nss9DFBytGeTHd06HdnIeJP0eGL5KxKn2wFCUZWpLlV/nbfo7E0PY8fHx116jk0i64/eS8q6AGJqVCxckPHlRZnLCeU0ce65el7IzvRP30ISXwSAQ07TjTsLZB8zpyzjgWb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770712338; c=relaxed/simple;
	bh=hwQTGnMQqtuYVkppFQ+qFgYk1SrP8tinRTRSbFLX6wI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rLtcMqbNbkZgRRinE5prxgxH/IhCpNuQUyt0jH/HtdRfaYOzm9Bdqdi/4hW5PpCgUo+gqINNTc2gWwWyKY55azko3cQv5xCf8j9NwnqkC+URp0TtX8s0kaAKU14S2JTEojfWv6yvL9OvZ+e38yA6Co+6q/+jKOWxG01l2Q/Vn7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YS5E4aAh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ned2H3Ok; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YS5E4aAh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ned2H3Ok"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61A53lVb801157
	for <virtio-dev@lists.linux.dev>; Tue, 10 Feb 2026 08:32:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	acCjTQGhqYDE+cpBX4zXhj0tHL1QIt8nIzgU2ufkEPc=; b=YS5E4aAhwFV5N2Qg
	8LRUr3veLfdY9un4Pfn31T62JNQYclu6Y/EctYt6EWy6fYYATTzG+rWLX8tJC2A5
	PCtya9Fq8xXsgyp40wlqDgX0ihDTPrR4r1HQrB0ajSf8ZgX+bNBSx08ACoiJJ0wD
	c5cA/GrwiE5cwrsIHsdIm0V4GIk+cMJSZnCruPBxBcYMJJr3L0jNJmGb2/fWcTQF
	XnMPBGnclj7wKw/gx70xFyKGrKI1/sReTIcJF16nK9NRsa3oreVQyBGPh2S6J4p7
	DXf3lk1N5eO03t/1qH9PVXTmxbLy/61MmF0/IFFwnhcANn41dGQk+GqyQE8fDguo
	gLTXOg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7x6u0n6r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Tue, 10 Feb 2026 08:32:15 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1270dcd11c1so525890c88.0
        for <virtio-dev@lists.linux.dev>; Tue, 10 Feb 2026 00:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770712335; x=1771317135; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acCjTQGhqYDE+cpBX4zXhj0tHL1QIt8nIzgU2ufkEPc=;
        b=Ned2H3OkW9GSzjuRSD+sQq0jD8I2hGCfZIMFhXGMQIW+tGw7NcMICpI211tTDQ3YWM
         fo7oPco4uawyuq2+bIxStLt++5zsLRDSsq2wy0nEAwFA7x1j9lg4XlJTrxW+n+73GUll
         W6WyasrnNmUMp0x0xRqgk6RLUjSuZz9j7dG461tPANJ44Q0WB8JsT0/b13O8SHTukf6E
         9Tg9qFZf9J6knqH8Mzh1AdSNayxvrgJqSmyjjggTLnL3lVf2mFLsxmbuNEdL8xmzRIOI
         O23p++Dj4r30QM1XM4lgRIS442ukZipm6+NF/KjV6BfNrqu/h1ZICKns+CMXyLZgycPZ
         N9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770712335; x=1771317135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=acCjTQGhqYDE+cpBX4zXhj0tHL1QIt8nIzgU2ufkEPc=;
        b=wPbbX5Tw/ALFvRWwDiG+7iBRXxlUDtK7WycNMRyDG7ls87KR2i2fr2lh3Eo3NXwqyx
         XHKlWyEjKADPqKdg4pkB1f/x7eLy60SVQuP/6ushGfj+L+7MDG3X/0sRX4yS9l7xliKP
         upVYG7/E0KSvBXmgKsjSTTco/1E5zXRiFS1W+KtkHQi14AycGS9r1TpFbLeRHZOi9ZsH
         KxkKhCBXpvevHKfX1YFUvCxXC0m0OGBbS+2o6oo3xKvNaa/wX1L/AZKRKK4OJAjkETdu
         b8tpkOIv2eGNvtaNaktp3uf3kUu3+2nlrxHzxy9Dk/Uukki3izGppqgzfubZrNXoqP6x
         BKaA==
X-Gm-Message-State: AOJu0YxHwlyohlQqnpXk54x7eOGz4+x7a773U/9nsAX3YoXFEIKNTJ/d
	7SHTf+rVFezJhamIIfPw7syh65and6If87jzqi2xNd75ro6a2FwLhvpX8nRZM8t7OhONobR/27w
	jjNWC/TcYfnkKk0XIyM3faWVbstJ39G5Sn26PcqDuKILHVd9OmPFUJmOX4VkGVzVWAWKHZ0Cjg8
	8=
X-Gm-Gg: AZuq6aJG65LIB3TmmavGLfZM4fFtJCc/j1q+oHQemOZsvGbWrqBJJfM4bYN7J44FjPf
	LylDe61Rv4uXll2+ADm9Bkzhz/3phoZBx+PZXQl3ahkiIfJcKbKmM7bEnbieIJBgYOYOLzLDIyS
	bagBqq6EN2JA2RRM1/eemKN3EoxHAW6BX5b0n/3NOa/8Dwrlzi2QmLYvaBkyLjBQqTF2SfZmKmq
	yEKlhICVIC/X9bGARh4VkXlWWzxe11GwDQdKjLycerkFVEMABXSucdm4jleIOzKYTr+Xo8oYmKO
	49sHuLFpk1VVTNHRU6AdDZmmX5+m07P3flLyE4gaQHaYYrtmyGQT7qVvjDGj1sNrVFWZW31FFTT
	6THXucKjkDqRVdN86HVnZRRg52Cr205Af6ztV7Q32BICVHlPxFD9IhFzCrsru6mNevStPNdoZKY
	bMC6dO
X-Received: by 2002:a05:7022:672a:b0:119:e56b:98b1 with SMTP id a92af1059eb24-12704048e45mr6862954c88.24.1770712334577;
        Tue, 10 Feb 2026 00:32:14 -0800 (PST)
X-Received: by 2002:a05:7022:672a:b0:119:e56b:98b1 with SMTP id a92af1059eb24-12704048e45mr6862944c88.24.1770712333892;
        Tue, 10 Feb 2026 00:32:13 -0800 (PST)
Received: from u20-san1p10573.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1270414f28bsm11580570c88.0.2026.02.10.00.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 00:32:13 -0800 (PST)
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: virtio-dev@lists.linux.dev, stefanha@redhat.com
Cc: quic_dshaikhu@quicinc.com
Subject: [PATCH v2 1/1] virtio-blk: Add inline encryption support
Date: Tue, 10 Feb 2026 00:32:08 -0800
Message-Id: <20260210083208.472824-2-linlin.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260210083208.472824-1-linlin.zhang@oss.qualcomm.com>
References: <20260210083208.472824-1-linlin.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: v5Pb0lAFxjLpc8lgkFsLBgDPnGMW4QIH
X-Proofpoint-ORIG-GUID: v5Pb0lAFxjLpc8lgkFsLBgDPnGMW4QIH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDA3MSBTYWx0ZWRfX8MjpsOi3e08R
 Lb7JwyQvtws6/TEapb6wmeoSU6i3/9zF3JiSon2rt5LpO3gqJ9TBCFrKqzhOHqrDZPmVYsN2gFo
 JM6qSydgVUpTB+dvTuJp01/rrTKq13XUI2SrJw9UjD/hYtSE1ryL+BLIv8sj2xVtnSgFr9O0U3f
 K4sBXwkxd4wdnS0zcXPiUuCs8SL5E+yCtVtPOq66s8UHpP7+eG/NPjO+jf+4aBvb1hkZZrJP28+
 BIFaodgggg37SGbUcfauz/lFkMzr6b+oCqx8SlhdY4V83hkcFWHKIL43HHdBzmktodIY6z+dn91
 LuP3X95jL4ukbjEZ39eJdYLKWfyqBL1/cFnLBArCQsG6s0Zxc/4qwc33psWoGcDN/2bMvUZhtL4
 /x1FpovWzzqnLZA0pI//JPCTM9f4HLvzPqlrIzSbwKb9a83GJ6odKeBLa5K+/rUZlNp6aAdFR0n
 kEHbPqDSmBEr42XeOuQ==
X-Authority-Analysis: v=2.4 cv=YfmwJgRf c=1 sm=1 tr=0 ts=698aed0f cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=20KFwNOVAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=Rwu5TU5C4Xmeo1I2ddMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100071

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

