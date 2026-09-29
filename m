Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A151D3D88FA
	for <virtio-dev@lists.linux.dev>; Tue, 29 Sep 2026 04:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790655733; cv=none; b=C8gdTR/nSp6M2o9m6sjl11Hkfb345WWsNmUnU918/x4fvq9uxDMEWHDkwi61dSqUAvPuS5Rww2OPIMGOAOtjmQMmPlaIHf+SD6JrzCRk54RQNLXl/VrZWRElw6x204GOofvk5oVHD/ARme2G+rpcbdGBOAfpm4UKp467oO6r0hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790655733; c=relaxed/simple;
	bh=LmtTYccWXFbT3VVM6nCwg6HCrRUmHlDTX0z02BLFnsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BmEaPKMyhM5jdVpVjLdGvZRRneDF3jIflg9JzAbBGlC9N698BJciRAEuu3BtHQGZCJf9UGatUreUgT+lhyna/tptNxewgTEy8yogiVnJKdA+E/NFiEwxge/dT0llx5p5yzM4sttASoIMVCp//T4OPHdtQwSLORikSYWRbLteM/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XIITdiw5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GAypJNtp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XIITdiw5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GAypJNtp"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T4751s3390857
	for <virtio-dev@lists.linux.dev>; Tue, 29 Sep 2026 04:22:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Wh4aIfGuy4i
	0zmfrZq1z/mtM1zbZlYOU28/rzQ1y69M=; b=XIITdiw5nRcAFvlbSzocN6ioVnC
	DFLRqrVOUhrJ62x9fV3osO4ib6eIfxwkIAbckEUJVHt9K7ksibcPnzV+8skwcjlh
	KX0y7JuJ+OtcedlWnWWhJ/hDhxbyKVBwdYwp8tAXgZIlZYNRzconn+hov0lJ9l9O
	lX36HQIPnXJAt217k0g+1c7lT80norqDMKX8qrnk1tmJ+0geVGq4APbj5Fcf1xhW
	yl3VhAxat1d6Jbn1+Tgk2BvbwE6CzqXp3FGMfYseticicfc/flgp9c/WnS9k9l1s
	sifIB3ZkhTE3KSP9l0LkF/B1jinvqL3op5Ib6+RcYBg0sVz9RkoJvil87nw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h01vkguy1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Tue, 29 Sep 2026 04:22:09 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3282d5302ffso940083eec.1
        for <virtio-dev@lists.linux.dev>; Mon, 28 Sep 2026 21:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790655728; x=1791260528; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wh4aIfGuy4i0zmfrZq1z/mtM1zbZlYOU28/rzQ1y69M=;
        b=GAypJNtp2Z/Hfow7SwRI2iFcM6jc/iamcLrkqx8D+W3S51ENy3vUCB4ecx07s3JBjJ
         OOc4bPGMZa72A9yV0qD/ywR1PelGmcZl71l7OOxsSj6Vy5Sf6wfYfiWe0cB+WRGA0sUu
         qFBDqorXM/f3jf/Ocp+7gn9WehS9GNOIcTHy7wHnIuH13rzGeZrj7QF9BkKSq239eUTY
         5f+JcW5be5w6DopogHFOFYi+W9Q2thrDpdZaBfaXMGympgDdi+pf1rpKW6H8oLCTtXWk
         1H1UoFhZOf667M6Ig0Nd99s+/IERGZnpDZypIbxfevuApQNUzvEt+5GOVT2GYkl9R7dE
         8kwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790655728; x=1791260528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wh4aIfGuy4i0zmfrZq1z/mtM1zbZlYOU28/rzQ1y69M=;
        b=SK4SUAhpaLVQRshiPwmUER1b4L4vg41fYprRUeJdbZ1TwWAW7udhbXvQM7fclke96S
         tzRkNPwbBuUdCz3LjlIBEe1kavnXabKmzSPugXTuyePXC1xuL5FWygWa2JbGfihW+uaj
         M0c/3fUYIiQjYEALFfP96NCM8Hzs1ZJ6r9dMadATy4Rn3Sh8TEpwFHo/d2Szq03j9zvz
         KNNNvNwFC5akp4eZqWXs9dayTd9z8yFXWi+/vD3O/eFnlQvhsUxCEcy1wllnVcrtjyy9
         afQfJKMEQ75AZ5JMqMhyBRzmfOqD7GBn8omh2WyszHMIdHv7pK/QPQz1ECKpPmzo1/xu
         hyOg==
X-Gm-Message-State: AFq9FYIaUFJ+c7KKBs+6tKbA8DaTnXzqTtTlKGxLh1hWbe9OgeD3hxSy
	xAXTO3VNwRliRbXAkQDKwmcAbeus4ONs/6eJEfJZGgWNE1/36Svmg6PX8OJgp1A+luJRdlaTA3R
	wv5QwMdfiS5WYSCVIKYvfwafk5aNvjBUg2luBI0DB8bAKltUTUW22VgZlJ91h3jjZrVgr6Gl9Cm
	U=
X-Gm-Gg: AYBFou3UZqZcwNrXt+22g0nEKzYk9lXW8uaAp7viGn6Y3bv5a4B5WOXsDuWmlBvJl9c
	bQ2JqpScCvy2YLxHqBvCWSk/MEy2h32+fQ4kSCtS0gWQRx8aMi/Eil21zgbRydKi20okT42btwJ
	ygT3Iqu7D6KxgNdNez1WmpKezPcvHTmhXru7Elww9Bjrd7huEigVFMpwt6hZfqhiOeyQn3nV6m3
	8lXhOyN7yOHoUfUdFbU1N2/Bj0QMvf1ElrONF8DMlc+P36gTJxzm8Q1ZIgclv9s3xmVBeth6wpH
	16UtzgLZUeHo7ffVtruivb4fa6cY4+udVCIT0OuSqu0Ww8b0jLkRW2uY+AHFYlemNlCG071UQBK
	QIl87/4vpfR9FoRdkSFWoJUFvMeWoEIaGqy8Puv2/PpLNiuOnwUA5YIUAqY0=
X-Received: by 2002:a05:7300:8354:b0:34b:3f7d:6105 with SMTP id 5a478bee46e88-34b3f7d63dcmr934679eec.14.1790655727690;
        Mon, 28 Sep 2026 21:22:07 -0700 (PDT)
X-Received: by 2002:a05:7300:8354:b0:34b:3f7d:6105 with SMTP id 5a478bee46e88-34b3f7d63dcmr934630eec.14.1790655726587;
        Mon, 28 Sep 2026 21:22:06 -0700 (PDT)
Received: from u24-san1p10108.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-341459234a1sm31172149eec.24.2026.09.28.21.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 21:22:06 -0700 (PDT)
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: virtio-dev@lists.linux.dev, stefanha@redhat.com, ebiggers@kernel.org
Cc: neeraj.soni@oss.qualcomm.com
Subject: [PATCH v5 2/2] virtio-blk: Add inline encryption support
Date: Mon, 28 Sep 2026 21:21:40 -0700
Message-ID: <20260929042152.4099414-3-linlin.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929042152.4099414-1-linlin.zhang@oss.qualcomm.com>
References: <20260929042152.4099414-1-linlin.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfXxVGXdqchiXxw
 oUZIgVEwbFpAvOtmCqeI5FfrQ4P/jO8U8MQCsCku6UVvT8g65xUBkOYS0jfaQ6t+Lx7BlmrWZ5d
 4l6WeWJ1vfjesBP/ZoXw1N00FBus8Usco1PFbOgVQIWW+gHiCC8fW/RUuIn5mpVO/J6iEmxrTjc
 OW507SvnnCc0ynzyaLCdC4PQ+rkoGXwsIzv4TOwrIp51eleBQKtbpqiiFom3lecqt6/+ANUmdPV
 NxTnH1KokZhgRmhPzmNGQqQKnOO5Qqgiv71W5FA5/xGjLQFAgtvOjdjEwpS0hpknCRkg5+D9iF5
 JnCQm4Wfpb7R3lPVLrYuwb7oZ/Lvm3lDhhgqHr/WAWqbdasJQJ0KRsZayxtdLB6dcRMkSHFWiUa
 IFj0R5ldGDC65gC9PQDe0mF5jogFOmbShgNGdA/dsYOz/OFtF/qf/d5bRGxEmd2qCLno7r6TS7Q
 nI+3jIb1B6qy0qCVcgg==
X-Proofpoint-GUID: D9_usMDC3bIoeiyKHlFjJpO4co2WB_Hz
X-Authority-Analysis: v=2.4 cv=VcVir1p9 c=1 sm=1 tr=0 ts=6abb3cf1 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=IC35IzaAQuh_1Q4tqLIA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: D9_usMDC3bIoeiyKHlFjJpO4co2WB_Hz
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfX0jluOkseq6Hf
 vuPJDp5Jhk40md6abE4oHwNn6YGTjUSjfIG6FQ8LJ19d0ufcLTcy/aFYkK/XXrzmHLteJnj9Pbe
 SYNbk8sJhCMiAXXVuRV4h/P1kRllexg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290017

From: linlzhan <linlin.zhang@oss.qualcomm.com>

Add VIRTIO_BLK_F_INLINE_ENCRYPTION to advertise inline encryption
support.

Add the virtio-blk inline encryption protocol, including device
capabilities, encrypted request metadata, crypto mode discovery,
key management commands, keyslot state semantics, and DUN handling.

This allows drivers to use device-backed inline encryption while
preserving key and request capability validation across
implementations.

Signed-off-by: linlzhan <linlin.zhang@oss.qualcomm.com>
Fixes: https://github.com/oasis-tcs/virtio-spec/issues/238
---
 device-types/blk/description.tex | 552 ++++++++++++++++++++++++++++++-
 1 file changed, 543 insertions(+), 9 deletions(-)

diff --git a/device-types/blk/description.tex b/device-types/blk/description.tex
index ed4c612..57d0c5e 100644
--- a/device-types/blk/description.tex
+++ b/device-types/blk/description.tex
@@ -76,10 +76,20 @@ \subsection{Feature bits}\label{sec:Device Types / Block Device / Feature bits}
 
 \item[VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA (19)] Device supports the
     VIRTIO_BLK_REQ_FLAG_OUT_FUA flag in the \field{flags} bitfield of the
-    \field{virtio_blk_req} structure for VIRTIO_BLK_T_OUT requests.
+    \field{virtio_blk_req} structure for VIRTIO_BLK_T_OUT and
+    VIRTIO_BLK_T_CRYPTO_OUT requests.
 
 \item[VIRTIO_BLK_F_CTRL_VQ (20)] Device supports a control virtqueue.
 
+\item[VIRTIO_BLK_F_INLINE_ENCRYPTION (21)] Only when the storage backend
+    supports inline encryption and this feature bit is negotiated, the data
+    read from or written to the device can be decrypted from or encrypted to
+    the storage via an inline crypto engine. Keys are provisioned into key
+    slots of the device, and requests identify, by key slot index, which
+    provisioned key to use. The number of key slots, the maximum size of
+    the Data Unit Number (DUN) and the supported key types are reported
+    in \field{enc_characteristics}.
+
 \end{description}
 
 \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Block Device / Feature bits / Legacy Interface: Feature bits}
@@ -142,6 +152,12 @@ \subsection{Device configuration layout}\label{sec:Device Types / Block Device /
                 u8 model;
                 u8 unused2[3];
         } zoned;
+        struct virtio_blk_enc_characteristics {
+                le16 max_slots;
+                u8 max_dun_bytes;
+                u8 key_types;
+                le32 unused3;
+        } enc_characteristics;
 };
 \end{lstlisting}
 
@@ -229,6 +245,34 @@ \subsection{Device configuration layout}\label{sec:Device Types / Block Device /
 terminated by the device with a "zone resources exceeded" error as defined for
 specific commands later.
 
+If the VIRTIO_BLK_F_INLINE_ENCRYPTION feature is negotiated, then in
+\field{virtio_blk_enc_characteristics},
+\begin{itemize}
+\item \field{max_slots} is the number of available key slots. Key slots are
+    indexed from 0 to \field{max_slots} - 1.
+
+\item \field{max_dun_bytes} is the maximum number of bytes of the Data Unit
+    Number (DUN) that the device supports for any of its supported crypto
+    modes. For example, known inline crypto engines report a
+    \field{max_dun_bytes} of 4 (JEDEC eMMC Command Queue Host Controller
+    Interface, CQHCI) or 8 (JEDEC UFS Host Controller Interface, UFSHCI).
+
+\item \field{key_types} is a bitmask of the key types the device supports,
+    using the following values:
+    \begin{lstlisting}
+#define VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW         (1 << 0)
+#define VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED  (1 << 1)
+    \end{lstlisting}
+    VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW indicates that keys are provisioned into
+    key slots in raw (plaintext) form. VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED
+    indicates that the key exists only in ephemerally-wrapped form in memory
+    outside of dedicated hardware, and can only be unwrapped and provisioned
+    into key slots by dedicated hardware (e.g. a hardware key manager). The
+    plaintext key never exists in software-accessible memory.
+
+\item \field{unused3} is reserved for future use.
+\end{itemize}
+
 \subsubsection{Legacy Interface: Device configuration layout}\label{sec:Device Types / Block Device / Device configuration layout / Legacy Interface: Device configuration layout}
 When using the legacy interface, transitional devices and drivers
 MUST format the fields in struct virtio_blk_config
@@ -295,6 +339,14 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
     \field{zoned} can be read by the driver to determine the zone
     characteristics of the device. All \field{zoned} fields are read-only.
 
+\item If the VIRTIO_BLK_F_INLINE_ENCRYPTION feature is negotiated, the fields in
+    \field{enc_characteristics} can be read by the driver to determine the
+    inline encryption capabilities of the device, and a
+    VIRTIO_BLK_T_GET_CRYPTO_MODES control virtqueue request (see
+    \ref{sec:Device Types / Block Device / Device Operation / Control Virtqueue: Device Operation})
+    can be sent to retrieve the set of supported crypto modes. All
+    \field{enc_characteristics} fields are read-only.
+
 \end{enumerate}
 
 \drivernormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
@@ -337,6 +389,24 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
 The driver MUST NOT negotiate VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA without
 VIRTIO_BLK_F_REQ_FLAGS.
 
+Zoned devices do not support inline encryption. If the VIRTIO_BLK_F_ZONED
+feature is offered by the device, then the VIRTIO_BLK_F_INLINE_ENCRYPTION
+feature MUST NOT be negotiated by the driver.
+
+Drivers MUST NOT negotiate the VIRTIO_BLK_F_INLINE_ENCRYPTION feature
+unless they are capable of:
+\begin{itemize}
+\item provisioning and evicting keys in the block device's keyslots through
+    the control virtqueue.
+\item submitting the keyslot index and Data Unit Number (DUN) per crypto
+    request to the device using the \field{virtio_blk_crypto_msg} structure.
+\item retrieving the inline encryption characteristics from the device
+    configuration space.
+\end{itemize}
+
+A driver that negotiates VIRTIO_BLK_F_INLINE_ENCRYPTION MUST also
+negotiate VIRTIO_BLK_F_CTRL_VQ.
+
 \devicenormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
 
 Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it
@@ -351,9 +421,15 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
 If the device that is being initialized is a not a zoned device, the device
 SHOULD NOT offer the VIRTIO_BLK_F_ZONED feature.
 
+A zoned device MUST NOT offer the VIRTIO_BLK_F_INLINE_ENCRYPTION feature.
+
 The VIRTIO_BLK_F_ZONED feature cannot be properly negotiated without
 FEATURES_OK bit. Legacy devices MUST NOT offer VIRTIO_BLK_F_ZONED feature bit.
 
+The VIRTIO_BLK_F_INLINE_ENCRYPTION feature cannot be properly negotiated
+without FEATURES_OK bit. Legacy devices MUST NOT offer the
+VIRTIO_BLK_F_INLINE_ENCRYPTION feature bit.
+
 If the VIRTIO_BLK_F_ZONED feature is not accepted by the driver,
 \begin{itemize}
 \item the device with the VIRTIO_BLK_Z_HA or VIRTIO_BLK_Z_NONE zone model SHOULD
@@ -425,6 +501,34 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
 The device MUST NOT acknowledge FEATURES_OK if the driver sets
 VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA without VIRTIO_BLK_F_REQ_FLAGS.
 
+The device MUST NOT acknowledge FEATURES_OK if the driver negotiates both
+VIRTIO_BLK_F_ZONED and VIRTIO_BLK_F_INLINE_ENCRYPTION.
+
+The device MUST NOT acknowledge FEATURES_OK if the driver negotiates
+VIRTIO_BLK_F_INLINE_ENCRYPTION without VIRTIO_BLK_F_CTRL_VQ.
+
+If the device is incapable of consuming the \field{virtio_blk_crypto_msg},
+the device SHOULD NOT offer the VIRTIO_BLK_F_INLINE_ENCRYPTION feature.
+
+If the VIRTIO_BLK_F_INLINE_ENCRYPTION feature is negotiated, the device
+MUST set \field{max_slots} in \field{enc_characteristics} to a value
+greater than 0. The value SHOULD reflect the number of key slots that
+are available for use by this virtio-blk device.
+
+If the VIRTIO_BLK_F_INLINE_ENCRYPTION feature is negotiated, the device
+MUST set \field{key_types} in \field{enc_characteristics} to have at
+least one of VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW or
+VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED set, and MUST NOT set any bit in
+\field{key_types} other than VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW and
+VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED. The device MUST initialize padding
+bytes \field{unused3} to 0.
+
+The device MUST NOT set \field{max_dun_bytes} in \field{enc_characteristics}
+to 0 or to a value greater than 32, since \field{dun[4]} of
+\field{virtio_blk_crypto_msg} is a fixed four-element array of 64-bit fields.
+The value reported by \field{max_dun_bytes} MAY vary depending on the
+capabilities of the underlying inline crypto engine.
+
 \subsubsection{Legacy Interface: Device Initialization}\label{sec:Device Types / Block Device / Device Initialization / Legacy Interface: Device Initialization}
 
 Because legacy devices do not have FEATURES_OK, transitional devices
@@ -488,8 +592,8 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
 value is the bit index in the \field{flags} bitfield):
 
 \begin{description}
-\item[VIRTIO_BLK_REQ_FLAG_OUT_FUA (0) for VIRTIO_BLK_T_OUT requests] Force Unit
-    Access (FUA) flag.
+\item[VIRTIO_BLK_REQ_FLAG_OUT_FUA (0) for VIRTIO_BLK_T_OUT and
+    VIRTIO_BLK_T_CRYPTO_OUT requests] Force Unit Access (FUA) flag.
 \end{description}
 
 The \field{sector} number indicates the offset (multiplied by 512) where
@@ -896,6 +1000,65 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
 operation by setting the VIRTIO_BLK_S_ZONE_INVALID_CMD value in
 \field{status} of \field{virtio_blk_req} structure.
 
+The following requirements only apply if the VIRTIO_BLK_F_INLINE_ENCRYPTION
+and VIRTIO_BLK_F_CTRL_VQ features are negotiated.
+
+In addition to the request types defined for devices without inline
+encryption support, the type of a request on a request virtqueue can be an
+inline-encrypted read (VIRTIO_BLK_T_CRYPTO_IN) or an inline-encrypted write
+(VIRTIO_BLK_T_CRYPTO_OUT):
+
+\begin{lstlisting}
+#define VIRTIO_BLK_T_CRYPTO_OUT   27
+#define VIRTIO_BLK_T_CRYPTO_IN    28
+\end{lstlisting}
+
+VIRTIO_BLK_T_CRYPTO_IN and VIRTIO_BLK_T_CRYPTO_OUT requests behave the same
+as VIRTIO_BLK_T_IN and VIRTIO_BLK_T_OUT requests respectively, except that
+the data in \field{data} is decrypted (for VIRTIO_BLK_T_CRYPTO_IN) or is to
+be encrypted (for VIRTIO_BLK_T_CRYPTO_OUT) by the inline crypto engine in
+the device backend storage using the key already provisioned in the key
+slot identified by the request, combined with the request's Data Unit
+Number (DUN). For this reason, the VIRTIO_BLK_T_CRYPTO_IN and
+VIRTIO_BLK_T_CRYPTO_OUT requests have the layout that is extended to have
+the \field{crypto_msg} field to carry this information:
+
+\begin{lstlisting}
+struct virtio_blk_req_crypto {
+        le32 type;
+        le32 flags;
+        le64 sector;
+        struct virtio_blk_crypto_msg crypto_msg;
+        u8 data[];
+        u8 status;
+};
+\end{lstlisting}
+
+\field{crypto_msg} has the following structure:
+
+\begin{lstlisting}
+struct virtio_blk_crypto_msg {
+        le32 slot;
+        u8 unused[4];
+        le64 dun[4];
+};
+\end{lstlisting}
+
+\field{slot} is the key slot index, in the range from 0 to
+\field{max_slots} - 1 of \field{enc_characteristics}. The device backend
+uses the key programmed into this slot together with \field{dun[4]}.
+\field{dun[4]} is a 256-bit unsigned Data Unit Number represented as four
+little-endian 64-bit elements, with \field{dun[0]} as the least-significant
+element. The device increments this 256-bit value by one for each successive
+data unit of the size specified by \field{data_unit_size_bits} in the
+\field{virtio_blk_crypto_key_desc}, propagating carries from each element to
+the next, while encrypting or decrypting the data of the request.
+\field{unused} is reserved.
+
+The remaining inline-encryption-related request types are control commands,
+sent on the control virtqueue; see
+\ref{sec:Device Types / Block Device / Device Operation / Control Virtqueue: Device Operation}.
+
 \drivernormative{\subsubsection}{Device Operation}{Device Types / Block Device / Device Operation}
 
 The driver SHOULD check if the content of the \field{capacity} field has
@@ -914,8 +1077,8 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
 A driver MUST set \field{sector} to 0 for a VIRTIO_BLK_T_FLUSH request.
 A driver SHOULD NOT include any data in a VIRTIO_BLK_T_FLUSH request.
 
-The length of \field{data} MUST be a multiple of 512 bytes for VIRTIO_BLK_T_IN
-and VIRTIO_BLK_T_OUT requests.
+The length of \field{data} MUST be a multiple of 512 bytes for VIRTIO_BLK_T_IN,
+VIRTIO_BLK_T_OUT, VIRTIO_BLK_T_CRYPTO_IN and VIRTIO_BLK_T_CRYPTO_OUT requests.
 
 The length of \field{data} MUST be a multiple of the size of struct
 virtio_blk_discard_write_zeroes for VIRTIO_BLK_T_DISCARD,
@@ -994,6 +1157,41 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
 
 \end{enumerate}
 
+The following requirements only apply if the VIRTIO_BLK_F_INLINE_ENCRYPTION
+and VIRTIO_BLK_F_CTRL_VQ features are negotiated.
+
+A driver MUST NOT submit a VIRTIO_BLK_T_CRYPTO_IN or VIRTIO_BLK_T_CRYPTO_OUT
+request unless all of the following conditions are satisfied:
+
+\begin{itemize}
+\item \field{slot} identifies a valid keyslot in the range
+    [0, \field{max_slots} - 1].
+
+\item a key has been provisioned into the specified keyslot.
+
+\item \field{data} is non-empty.
+
+\item (\field{sector} * 512) is aligned to the data unit size associated
+    with the programmed key.
+
+\item the length of \field{data} is a multiple of that data unit size
+    associated with the programmed key.
+
+\item the Data Unit Number (DUN) of every data unit covered by the
+    request is representable with the \field{dun_bytes} bytes in
+    \field{virtio_blk_crypto_key_desc} specified when the key was
+    programmed.
+\end{itemize}
+
+For a VIRTIO_BLK_T_CRYPTO_IN or VIRTIO_BLK_T_CRYPTO_OUT request,
+\field{dun[4]} MUST specify the 256-bit DUN of the first data unit covered
+by the request. The DUN corresponding to each subsequent data unit MUST be
+obtained by incrementing the 256-bit value by one, propagating carries from
+\field{dun[0]} through \field{dun[3]}.
+
+The driver MUST initialize \field{unused} in \field{virtio_blk_crypto_msg}
+to zero.
+
 \devicenormative{\subsubsection}{Device Operation}{Device Types / Block Device / Device Operation}
 
 The device MAY change the content of the \field{capacity} field during
@@ -1040,10 +1238,10 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
 
 \item\label{item:flush3} the VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA feature was
   negotiated and the VIRTIO_BLK_REQ_FLAG_OUT_FUA bit in \field{flags} was set in
-  the write request (regardless of whether the VIRTIO_BLK_F_FLUSH or
-  VIRTIO_BLK_F_CONFIG_WCE features were negotiated, and regardless of the
-  current cache mode as expressed by the value of the \field{writeback} field in
-  configuration space).
+  the write request (VIRTIO_BLK_T_OUT or VIRTIO_BLK_T_CRYPTO_OUT, regardless of
+  whether the VIRTIO_BLK_F_FLUSH or VIRTIO_BLK_F_CONFIG_WCE features were
+  negotiated, and regardless of the current cache mode as expressed by the value
+  of the \field{writeback} field in configuration space).
 
 \item\label{item:flush4} a VIRTIO_BLK_T_FLUSH request is sent \textbf{after the write is
   completed} and is completed itself.
@@ -1235,6 +1433,41 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
 handles VIRTIO_BLK_T_ZONE_RESET request for the zone range specified in the
 VIRTIO_BLK_T_SECURE_ERASE request.
 
+If the VIRTIO_BLK_F_INLINE_ENCRYPTION feature is not negotiated, the device
+MUST reject all inline-encryption request and control command types with
+VIRTIO_BLK_S_UNSUPP status.
+
+The following requirements only apply if the VIRTIO_BLK_F_INLINE_ENCRYPTION
+and VIRTIO_BLK_F_CTRL_VQ features are negotiated.
+
+If a VIRTIO_BLK_T_CRYPTO_IN or VIRTIO_BLK_T_CRYPTO_OUT request satisfies any
+of the following conditions, the device MUST set \field{status} to
+VIRTIO_BLK_S_IOERR and MUST NOT access the data:
+
+\begin{itemize}
+\item \field{slot} does not identify a valid keyslot.
+
+\item \field{data} is empty.
+
+\item (\field{sector} * 512) is not aligned to the data unit size
+    associated with the programmed key.
+
+\item the length of \field{data} is not a multiple of the data unit size
+    associated with the programmed key.
+
+\item the Data Unit Number (DUN) of any data unit covered by the request
+    is not representable with the \field{dun_bytes} bytes specified when
+    the key was programmed.
+\end{itemize}
+
+For encrypted reads and writes, the device MUST use the key provisioned in
+the requested slot and the request's \field{dun[4]}. If the device splits the
+request, each sub-request MUST preserve data-unit-size alignment and use the
+256-bit DUN obtained by incrementing the request DUN by the number of
+preceding data units.
+
+The device MUST ignore \field{unused} in \field{virtio_blk_crypto_msg}.
+
 \subsubsection{Control Virtqueue: Device Operation}\label{sec:Device Types / Block Device / Device Operation / Control Virtqueue: Device Operation}
 The driver uses the control virtqueue (if VIRTIO_BLK_F_CTRL_VQ is negotiated)
 to send control commands to the device.
@@ -1279,12 +1512,248 @@ \subsubsection{Control Virtqueue: Device Operation}\label{sec:Device Types / Blo
 \field{type}, and are zero if the command specified by \field{type} has no
 command-specific output or input buffer respectively.
 
+The following types of control requests are defined for use with the
+VIRTIO_BLK_F_INLINE_ENCRYPTION feature:
+
+\begin{lstlisting}
+/* Get inline crypto modes */
+#define VIRTIO_BLK_T_GET_CRYPTO_MODES          29
+
+/* Program a key into the keyslot */
+#define VIRTIO_BLK_T_CRYPTO_KEYSLOT_PROGRAM     30
+
+/* Evict a key */
+#define VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT       31
+
+/* Derive the software secret from a hardware-wrapped key */
+#define VIRTIO_BLK_T_CRYPTO_DERIVE_SW_SECRET     32
+
+/* Generate a new hardware-wrapped key */
+#define VIRTIO_BLK_T_CRYPTO_GENERATE_KEY        33
+
+/* Import a raw key as a hardware-wrapped key */
+#define VIRTIO_BLK_T_CRYPTO_IMPORT_KEY          34
+
+/* Convert a long-term wrapped key to its ephemerally-wrapped form */
+#define VIRTIO_BLK_T_CRYPTO_PREPARE_KEY         35
+\end{lstlisting}
+
+\begin{itemize}
+\item If \field{type} is VIRTIO_BLK_T_GET_CRYPTO_MODES, \field{cmd_specific_in}
+    is struct virtio_blk_crypto_modes. There is no command-specific output
+    buffer.
+\item If \field{type} is VIRTIO_BLK_T_CRYPTO_KEYSLOT_PROGRAM or
+    VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT, \field{cmd_specific_out} is struct
+    virtio_blk_crypto_key_desc. There is no command-specific input buffer.
+\item If \field{type} is VIRTIO_BLK_T_CRYPTO_GENERATE_KEY,
+    \field{cmd_specific_in} is struct virtio_blk_crypto_key_blob. There is no
+    command-specific output buffer.
+\item If \field{type} is VIRTIO_BLK_T_CRYPTO_IMPORT_KEY or
+    VIRTIO_BLK_T_CRYPTO_PREPARE_KEY, both \field{cmd_specific_out} and
+    \field{cmd_specific_in} are struct virtio_blk_crypto_key_blob.
+\item If \field{type} is VIRTIO_BLK_T_CRYPTO_DERIVE_SW_SECRET,
+    \field{cmd_specific_out} is struct virtio_blk_crypto_key_blob and
+    \field{cmd_specific_in} is struct virtio_blk_crypto_sw_secret.
+\end{itemize}
+
+\begin{lstlisting}
+struct virtio_blk_crypto_modes {
+        /*
+         * modes[N], for crypto mode number N <= VIRTIO_BLK_CRYPTO_MODE_MAX,
+         * is a bitmask of the data unit sizes with which crypto mode N can
+         * be used: bit i is set if a data unit size of (1 << i) bytes is
+         * supported. modes[0] is reserved and always 0.
+         */
+        le32 modes[VIRTIO_BLK_CRYPTO_MODE_MAX + 1];
+};
+\end{lstlisting}
+
+Crypto mode numbers are used as indices into \field{modes} in struct
+virtio_blk_crypto_modes above, and in \field{crypto_mode} in struct
+virtio_blk_crypto_key_desc. These numbers are assigned by this
+specification and are stable: a number is never reused for a different
+crypto mode, and additional crypto modes are assigned new, higher numbers.
+
+The crypto mode numbers currently defined by this specification are:
+
+\begin{lstlisting}
+#define VIRTIO_BLK_CRYPTO_MODE_INVALID          0
+#define VIRTIO_BLK_CRYPTO_MODE_AES_256_XTS      1
+
+/* Highest crypto mode number defined by this specification. */
+#define VIRTIO_BLK_CRYPTO_MODE_MAX              1
+\end{lstlisting}
+
+Crypto mode number 0 (VIRTIO_BLK_CRYPTO_MODE_INVALID) is reserved and is
+not used to reference an actual crypto mode.
+
+The VIRTIO_BLK_T_GET_CRYPTO_MODES command queries which crypto modes and
+data unit sizes the device supports for inline encryption. The command has
+no command-specific output buffer. The command succeeds with
+VIRTIO_BLK_S_OK and returns a struct virtio_blk_crypto_modes describing the
+supported (crypto mode, data unit size) combinations.
+
+\begin{lstlisting}
+#define VIRTIO_BLK_CRYPTO_MAX_KEY_SIZE          128
+
+/* Inline crypto key descriptor. */
+struct virtio_blk_crypto_key_desc {
+        le32  slot;
+        u8    bytes[VIRTIO_BLK_CRYPTO_MAX_KEY_SIZE];
+        le32  key_size;
+        le32  crypto_mode;
+        le32  key_type;
+        le32  data_unit_size_bits;
+        le32  dun_bytes;
+};
+\end{lstlisting}
+
+\field{slot} is the target keyslot in the device where the key is programmed.
+Only the first \field{key_size} bytes of \field{bytes} contain key material;
+the remaining bytes, \field{bytes[key_size:128]}, are reserved.
+\field{crypto_mode} is the crypto mode number, used as an index into the
+\field{modes} array returned by a VIRTIO_BLK_T_GET_CRYPTO_MODES request.
+\field{key_type} is either VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW or
+VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED.
+\field{data_unit_size_bits} is the base-2 logarithm of the
+data unit size in bytes used by \field{crypto_mode}. \field{dun_bytes} is
+the number of bytes that will be used to specify the Data Unit Number when
+this key is used.
+
+The VIRTIO_BLK_T_CRYPTO_KEYSLOT_PROGRAM command programs a key into a key
+slot, or overwrites the key already in that slot, for later use by
+VIRTIO_BLK_T_CRYPTO_IN and VIRTIO_BLK_T_CRYPTO_OUT requests. The key slot
+index, key material, key size, crypto mode, key type, data unit size and
+DUN size are specified by the \field{slot}, \field{bytes}, \field{key_size},
+\field{crypto_mode}, \field{key_type}, \field{data_unit_size_bits} and
+\field{dun_bytes} in \field{virtio_blk_crypto_key_desc} respectively. The
+command succeeds with VIRTIO_BLK_S_OK if the key slot index is valid and
+\field{key_size}, \field{crypto_mode}, \field{key_type},
+\field{data_unit_size_bits} and \field{dun_bytes} are all valid and
+consistent with each other and with the values reported in
+\field{enc_characteristics}. If the key slot index is invalid, or any of
+these fields is invalid or inconsistent, the command fails with
+VIRTIO_BLK_S_IOERR and the key slot is left unchanged.
+
+The VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT command empties a key slot so that
+key information is removed and the key slot cannot be used until it is
+programmed again. The key slot index is specified by the \field{slot} in
+\field{virtio_blk_crypto_key_desc} and all other fields in the
+struct are ignored. The command succeeds with VIRTIO_BLK_S_OK if the key
+slot index is valid, including if the slot is already empty. If the key
+slot index is invalid, the command fails with VIRTIO_BLK_S_IOERR.
+
+\begin{lstlisting}
+/* A raw or hardware-wrapped key. */
+struct virtio_blk_crypto_key_blob {
+        le32 key_size;
+        u8 key[VIRTIO_BLK_CRYPTO_MAX_KEY_SIZE];
+};
+\end{lstlisting}
+
+For struct virtio_blk_crypto_key_blob, only the first \field{key_size} bytes
+of \field{key} contain key material. The remaining bytes,
+\field{key[key_size:128]}, are reserved.
+
+The VIRTIO_BLK_T_CRYPTO_GENERATE_KEY command asks the device to generate a
+new hardware-wrapped key. The command has no command-specific output
+buffer. The command succeeds with VIRTIO_BLK_S_OK and returns a
+\field{virtio_blk_crypto_key_blob} containing the generated key and its
+\field{key_size} in the input buffer. If the device is unable to generate a
+key, for example because it lacks the necessary hardware resources, the
+command fails with VIRTIO_BLK_S_IOERR.
+
+The VIRTIO_BLK_T_CRYPTO_IMPORT_KEY command asks the device to import a raw
+key and return its hardware-wrapped key. The raw key and its \field{key_size}
+are given in the command-specific output buffer, a
+\field{virtio_blk_crypto_key_blob}. The command succeeds with VIRTIO_BLK_S_OK
+and returns a \field{virtio_blk_crypto_key_blob} containing the wrapped key
+and its \field{key_size} in the input buffer. If \field{key_size} is zero, or
+the device is otherwise unable to wrap the key, the command fails with
+VIRTIO_BLK_S_IOERR.
+
+The VIRTIO_BLK_T_CRYPTO_PREPARE_KEY command converts a long-term
+hardware-wrapped key into its ephemerally-wrapped form, suitable for
+programming into a key slot with VIRTIO_BLK_T_CRYPTO_KEYSLOT_PROGRAM. The
+long-term wrapped key and its \field{key_size} are given in the
+command-specific output buffer, a \field{virtio_blk_crypto_key_blob}. The
+command succeeds with VIRTIO_BLK_S_OK and returns a
+\field{virtio_blk_crypto_key_blob} containing the ephemerally-wrapped key
+and its \field{key_size} in the input buffer. If \field{key_size} is
+invalid, the key was not produced by this device, or the device is otherwise
+unable to rewrap the key, the command fails with VIRTIO_BLK_S_IOERR.
+
+\begin{lstlisting}
+#define VIRTIO_BLK_CRYPTO_SW_SECRET_SIZE        32
+
+struct virtio_blk_crypto_sw_secret {
+        u8 secret[VIRTIO_BLK_CRYPTO_SW_SECRET_SIZE];
+};
+\end{lstlisting}
+
+The VIRTIO_BLK_T_CRYPTO_DERIVE_SW_SECRET command derives the software
+secret associated with a hardware-wrapped key, for use by software that
+needs to operate on the key material outside of the device, for example
+for file system metadata encryption. The wrapped key and its
+\field{key_size} are given in the command-specific output buffer, a
+\field{virtio_blk_crypto_key_blob}. The command succeeds with
+VIRTIO_BLK_S_OK and returns a \field{virtio_blk_crypto_sw_secret}
+containing the derived \field{secret} and its \field{key_size} in the
+input buffer. If \field{key_size} is invalid, or the key was not
+produced by this device, the command fails with VIRTIO_BLK_S_IOERR.
+
 \drivernormative{\paragraph}{Control Virtqueue}{Device Types / Block Device / Device Operation / Control Virtqueue: Device Operation}
 
 The driver MUST NOT set \field{type} to a value that does not correspond to
 a control command defined by this specification, or to a control command
 whose corresponding feature has not been negotiated with the device.
 
+The driver MUST provide command-specific output and input buffers of
+exactly the size required for the command specified in \field{type}.
+
+The driver MUST NOT set \field{crypto_mode} in struct
+virtio_blk_crypto_key_desc to a value greater than
+VIRTIO_BLK_CRYPTO_MODE_MAX, or to a crypto mode number that the device did
+not report as supported in reply to a VIRTIO_BLK_T_GET_CRYPTO_MODES
+request.
+
+The driver MUST NOT set \field{type} to VIRTIO_BLK_T_CRYPTO_GENERATE_KEY,
+VIRTIO_BLK_T_CRYPTO_IMPORT_KEY, VIRTIO_BLK_T_CRYPTO_PREPARE_KEY or
+VIRTIO_BLK_T_CRYPTO_DERIVE_SW_SECRET unless the device reported
+VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED as set in \field{key_types}.
+
+For VIRTIO_BLK_T_CRYPTO_KEYSLOT_PROGRAM and VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT
+commands, the driver MUST set \field{slot} in
+\field{virtio_blk_crypto_key_desc} to a value less than \field{max_slots}
+in \field{virtio_blk_enc_characteristics}.
+
+For a VIRTIO_BLK_T_CRYPTO_KEYSLOT_PROGRAM command, the driver MUST
+\begin{itemize}
+\item set \field{key_size} to a value greater than 0 and not greater than
+    VIRTIO_BLK_CRYPTO_MAX_KEY_SIZE.
+\item initialize \field{bytes[key_size:128]} in
+    \field{virtio_blk_crypto_key_desc} to zero.
+\item set \field{key_type} to either VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW or
+    VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED, and MUST NOT set \field{key_type}
+    to VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED unless the device reported
+    VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED as set in \field{key_types}.
+\item set \field{data_unit_size_bits} to the base-2 logarithm of a data
+    unit size that the device reported as supported for \field{crypto_mode}
+    in reply to a VIRTIO_BLK_T_GET_CRYPTO_MODES request.
+\item set \field{dun_bytes} to a value not greater than
+    \field{max_dun_bytes} in \field{virtio_blk_enc_characteristics}.
+\end{itemize}
+
+For VIRTIO_BLK_T_CRYPTO_IMPORT_KEY and VIRTIO_BLK_T_CRYPTO_PREPARE_KEY
+commands, the driver MUST set \field{key_size} in the command-specific
+output buffer to a value greater than 0 and not greater than
+VIRTIO_BLK_CRYPTO_MAX_KEY_SIZE, and MUST initialize \field{key[key_size:128]}
+in \field{virtio_blk_crypto_key_blob} to zero.
+
+The driver MUST ignore \field{key[key_size:128]} in the command-specific
+input buffer returned by the device for a VIRTIO_BLK_T_CRYPTO_GENERATE_KEY,
+VIRTIO_BLK_T_CRYPTO_IMPORT_KEY or VIRTIO_BLK_T_CRYPTO_PREPARE_KEY command.
+
 \devicenormative{\paragraph}{Control Virtqueue}{Device Types / Block Device / Device Operation / Control Virtqueue: Device Operation}
 
 The device MUST complete a control virtqueue request with VIRTIO_BLK_S_UNSUPP
@@ -1292,6 +1761,71 @@ \subsubsection{Control Virtqueue: Device Operation}\label{sec:Device Types / Blo
 control command corresponds to a feature that has not been negotiated with
 the driver.
 
+The device MUST complete a control virtqueue request with VIRTIO_BLK_S_IOERR
+status if the command-specific output or input buffer provided by the
+driver does not have the size required for \field{type}.
+
+The device MUST ignore \field{bytes[key_size:128]} in
+\field{virtio_blk_crypto_key_desc}, and MUST ignore
+\field{key[key_size:128]} in a command-specific output buffer that is
+\field{virtio_blk_crypto_key_blob}.
+
+The device MUST initialize \field{key[key_size:128]} to zero in the
+command-specific input buffer it returns for a
+VIRTIO_BLK_T_CRYPTO_GENERATE_KEY, VIRTIO_BLK_T_CRYPTO_IMPORT_KEY or
+VIRTIO_BLK_T_CRYPTO_PREPARE_KEY command.
+
+For a VIRTIO_BLK_T_GET_CRYPTO_MODES command, the device MUST set
+\field{modes[N]} for each crypto mode number N that it supports to a
+bitmask of the data unit sizes it supports for that crypto mode, MUST set
+\field{modes[0]} to 0, and MUST NOT write outside the bounds of the
+provided struct virtio_blk_crypto_modes.
+
+For a VIRTIO_BLK_T_CRYPTO_KEYSLOT_PROGRAM command, the device MUST complete
+the command with VIRTIO_BLK_S_IOERR if any of the following is true:
+\begin{itemize}
+\item \field{slot} is not less than \field{max_slots}.
+\item \field{key_size} is 0 or greater than VIRTIO_BLK_CRYPTO_MAX_KEY_SIZE.
+\item \field{crypto_mode} is greater than VIRTIO_BLK_CRYPTO_MODE_MAX, or is
+    a crypto mode that the device does not support.
+\item \field{key_type} is neither VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW nor
+    VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED, or is
+    VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED but the device does not support
+    VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED keys.
+\item \field{data_unit_size_bits} does not correspond to a data unit size
+    that the device supports for \field{crypto_mode}.
+\item \field{dun_bytes} is greater than \field{max_dun_bytes}.
+\end{itemize}
+
+For a VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT command, the device MUST complete
+the command with VIRTIO_BLK_S_IOERR if \field{slot} is not less than
+\field{max_slots}, and otherwise MUST complete the command with
+VIRTIO_BLK_S_OK, regardless of whether the key slot was already empty.
+
+For VIRTIO_BLK_T_CRYPTO_KEYSLOT_PROGRAM and VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT
+commands, the device MUST leave the target key slot unchanged if the
+command fails, and MUST apply the requested change to the key slot before
+completing the command with VIRTIO_BLK_S_OK.
+
+For VIRTIO_BLK_T_CRYPTO_GENERATE_KEY, VIRTIO_BLK_T_CRYPTO_IMPORT_KEY,
+VIRTIO_BLK_T_CRYPTO_PREPARE_KEY and VIRTIO_BLK_T_CRYPTO_DERIVE_SW_SECRET
+commands, the device MUST complete the command with VIRTIO_BLK_S_UNSUPP if
+VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED is not set in \field{key_types}.
+
+For VIRTIO_BLK_T_CRYPTO_IMPORT_KEY, VIRTIO_BLK_T_CRYPTO_PREPARE_KEY and
+VIRTIO_BLK_T_CRYPTO_DERIVE_SW_SECRET commands, the device MUST complete the
+command with VIRTIO_BLK_S_IOERR if \field{key_size} in the command-specific
+output buffer is 0 or greater than VIRTIO_BLK_CRYPTO_MAX_KEY_SIZE. For
+VIRTIO_BLK_T_CRYPTO_PREPARE_KEY and VIRTIO_BLK_T_CRYPTO_DERIVE_SW_SECRET
+commands, the device MUST also complete the command with
+VIRTIO_BLK_S_IOERR if the wrapped key in the command-specific output
+buffer was not produced by this device.
+
+If a VIRTIO_BLK_T_CRYPTO_GENERATE_KEY, VIRTIO_BLK_T_CRYPTO_IMPORT_KEY,
+VIRTIO_BLK_T_CRYPTO_PREPARE_KEY or VIRTIO_BLK_T_CRYPTO_DERIVE_SW_SECRET
+command fails, the device MUST NOT write key material or the derived
+software secret to the command-specific input buffer.
+
 \subsubsection{Legacy Interface: Device Operation}\label{sec:Device Types / Block Device / Device Operation / Legacy Interface: Device Operation}
 When using the legacy interface, transitional devices and drivers
 MUST format the fields in struct virtio_blk_req
-- 
2.34.1

