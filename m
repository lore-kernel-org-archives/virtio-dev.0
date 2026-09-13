Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9654F370ACA
	for <virtio-dev@lists.linux.dev>; Sun, 13 Sep 2026 16:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789316212; cv=none; b=oMKimfvcLDf2QA25QVCHi5i7dwOIi5vQlFBAML4le0MwXkCy18YtXuszV9YqiR7sQ7OkZGqu/yEVXutdMpZu1RN75acwOIWL7caKPmEr+uifXNwEaJiQ7Bl1wQCIgaf4DuvpVuqh4Ddl2RgE8vmq8eoPNfYurKRSBLgiE0dOMZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789316212; c=relaxed/simple;
	bh=oUG7XcXbqj/TPiGLeCR7SVRTlaEbGQnOvo8GJKy1y5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FnxspMFHn6/vKpTevakgTgsc0HCkUfdd2xwzMjjSOWDiuxwoX9FBwvbvkvU1fq/Tdmo6A5d0w6PpIOqp1ZUeXMciGcgEfyzT9A2nVNTT5DnOxJyvEDm1jZvIdmSHE9RRxEpEkDY+q4kamtAbXEdKcOQuhZN4/juBsh1wnwFRHcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OxuGzsIc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eF4ItzH4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OxuGzsIc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eF4ItzH4"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68DE1OuM2485750
	for <virtio-dev@lists.linux.dev>; Sun, 13 Sep 2026 16:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=3mBhoxKyeuV
	qsdc9T4w/+W5Zg1+xNXBMAq8X9vLfr5U=; b=OxuGzsIc5bz/CCjuULXdDWXw0VX
	xaMU2IPSgiJ8lJZyhdD8g09psN3oGLR6osjz7Mm1lXNA7IzLqo9aVOwJm8+34+UY
	CvBUVp0+CQ4dfjTBXVp9Oc+w0EC40c1Kmxq4YtYpdmvhvPmrfozTQrHZp+9ftewp
	QZBBp77UIm1lwrYA8yzmJn9aJqs/5c6OEGlC2wd1sH6gPmGP2imXAEi24sIRp7gm
	oSdovnUy3RHLqjTcqGN0Iv87H3vzsEHeX+Dz5vzd3WNk6o3fV5UGSQBlr14OrsWM
	xHVBt/iaNyJFdyw3dFmcoUt1/rdY2DqVvpW8U0R1PzhDHqdyw+Rq1hz3T8Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dknct-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Sun, 13 Sep 2026 16:16:45 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-396b9ef3070so4548270a91.3
        for <virtio-dev@lists.linux.dev>; Sun, 13 Sep 2026 09:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789316204; x=1789921004; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3mBhoxKyeuVqsdc9T4w/+W5Zg1+xNXBMAq8X9vLfr5U=;
        b=eF4ItzH4IEpd7lj/vmoC6s6GlwzEahml3rrgs+7sCUdTJVwLv35mAqJ/XQYDpSFrFD
         OCMm+Czede22mK5gBAGcjOdQ7iPc1F4hMJkrO/LfQ5Ey0HpejX5t32PEnQKEZatQv82d
         fL2RHF0ET+6nK5tJNRZ9KiMC0kNgPUlYgIMMblAXoMGhxtbsKafUMbVdLCWXbnOV+uMZ
         wMUg0eBzOts157U00Ks8W8CtCvGWJj5Av5GX9erV8CBCBQYOsw1s6NRaaws7DOIexrdR
         eR4KNjXvBcqplpJW579XM/TIv7oZ11wOWM3H4SZLalFihBCh6GozHBIKG0CwlX2n1EOZ
         xunA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789316204; x=1789921004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3mBhoxKyeuVqsdc9T4w/+W5Zg1+xNXBMAq8X9vLfr5U=;
        b=ZCRhBnl3ncHXgbljgnZKvMi6bq+trPu7WiwqpHhWQMedieC7fMVbG2kxdbDtfgUHXe
         pKiXWmgCA0bj0nb3omAvOLPisNOOHd7uMiAn6iAI+PsRVpQ6bH1+7TPFbuScWDrVejzY
         /hGR8S3Aa+p40qTOVLT2EL0OJ5YZNHpmwqOxCxObTms1RmNbomU8u8F9QjnfkWTWFvPW
         mGK1AoeWXVL1zVsjANE0wJ85L7BQ1UzangoIUzWEF+D0uIsjwoK3zTT5L4xJm+NHrnxj
         Xyzx0sKkD9wqeXhH1Z2n2mYjJvKHRjRXX6vY2RT2AtdLQiFbRmS2PijtCOiVnjbkUR+g
         qf/w==
X-Gm-Message-State: AFuF++mbkp1dCnh8l2PTx1zdEAnGOZ6MLGkRCJ0FMQrsqTs7FWWSFHNE
	HReax+omEWltEV3OZwg9rTF9s4Bv79NiaPsDppKtAMiH81G0f8ZLeQu3dOchCJ3u2+9ar5TMVC6
	92/Ioni7CpZBWgHGnKeu80zuZq7ZtiFcTblhvmN/MtxszOk0Wq2seYJe/YGrUcWeraDpAlPbhNU
	s=
X-Gm-Gg: AYBFou1ZvzcIHgDdvnXRLNHDVLeiklEUbuFd5AJmGZ5n4f4zP8Tielnzlm9+6kHphmr
	lUhJ5A1VirpLWrx/qxIRGapQM3IKVPenrnDCqjEwJS6+zlOFqfvWqw1pBdfV/ZJlyq/+y58XpS6
	Z9s1hw/a5pnL07sbOx+c2SM6/HD96lv097qgNI88F+xHeWlAxQzxhnTh3N/9qZTZ2sF+bdXzDsh
	Bw/ROB2Y9s5fgyzwwm/idq8va8xjhXGxCM2bdFDhXkNbHl0zyGeHlwdLrk57OaC5ttsA+/AMR5+
	J/RG2FImnxZ1ztAxPbpdbn+RQpPu+LMmRXwe0Q/Xav1MxRjhsuc7JFHQ5Bpl0EogUc7xrNk79o2
	sp5CnFqG9z8XAraH6Cy8YrtMLpHkBJFQOSfn3GdMrRJVQQcnUWUn4QrZkqvg=
X-Received: by 2002:a17:90b:28d0:b0:398:9bd4:d18 with SMTP id 98e67ed59e1d1-39d9c3f2ba7mr26794641a91.23.1789316204081;
        Sun, 13 Sep 2026 09:16:44 -0700 (PDT)
X-Received: by 2002:a17:90b:28d0:b0:398:9bd4:d18 with SMTP id 98e67ed59e1d1-39d9c3f2ba7mr26794535a91.23.1789316203283;
        Sun, 13 Sep 2026 09:16:43 -0700 (PDT)
Received: from u24-san1p10108.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba7a9bb56sm21932939eec.31.2026.09.13.09.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 09:16:42 -0700 (PDT)
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: virtio-dev@lists.linux.dev, stefanha@redhat.com, ebiggers@kernel.org
Cc: neeraj.soni@oss.qualcomm.com
Subject: [PATCH v3 2/2] virtio-blk: Add inline encryption support
Date: Sun, 13 Sep 2026 09:16:15 -0700
Message-ID: <20260913161628.368484-3-linlin.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260913161628.368484-1-linlin.zhang@oss.qualcomm.com>
References: <20260913161628.368484-1-linlin.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: qhaj028loEZDIBRqOtaRzMyolgUG_d13
X-Proofpoint-ORIG-GUID: qhaj028loEZDIBRqOtaRzMyolgUG_d13
X-Authority-Analysis: v=2.4 cv=NelzRGD4 c=1 sm=1 tr=0 ts=6aa6cc6d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=4DU8uC8dT6efhwBYgIgA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDIzMCBTYWx0ZWRfX1hBtYYouLx6t
 elL9VCywDsDmlBbVUgIgYZXUTEI6M9Ex8dMqM4ii4ZUplq8e5LpyeX1kgRHI5qJ3yhitp+VSrld
 ZhGYt7gNhHmFCEjSfZ/50NvZ1foJpGk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDIzMCBTYWx0ZWRfXy2lrh9DSTmEh
 6j036jPOTrzazhMdl6xvwydBmoDRwUxi6FgNvH7Gkc64zwG3hyWzst0VVMcg1u+ImgxbUFX7+Lu
 MKok1gvpBMjt8ZwDr9rlY5w8KY4/Vi8ujcBGRKrPK7JFkymUmb5U9H4N8VLLZMLM1gggWl5pP9Z
 sjIg/YI9SQRkbOwwEn9dhnAHeijlZwA4S7wNye+rtbWZFfJfJFAT4U5KTLzUmLaBXxwRUCS9sO0
 /qG0cV26m28YGx3fZhHYpfte9F9KWqZN34myOqbNlEzrVo121abcZ1QxoIAa6J6Lw8NdHUiVLAz
 tebWYYRoNMByII/7D10Pe81Qiqbmbv7HDSaI2snqUDauwZGEuRACg0D/IVl86aThMmB6/++N0ot
 +dDLqxLvDnQJEJd+W83Y/3cAo1xaWU/KnUYyATQng+y4jMW7XeyJ/DYPjR52WvfXHcd351krpwY
 BnfUcIaET65ucrWO8DQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609130230

From: linlzhan <linlin.zhang@oss.qualcomm.com>

Add VIRTIO_BLK_F_IE to advertise inline encryption support.

Add the virtio-blk inline encryption protocol, including device
capabilities, encrypted request metadata, crypto mode discovery,
key management commands, keyslot state semantics, and DUN handling.

This allows drivers to use device-backed inline encryption while
preserving key and request capability validation across implementations.

Signed-off-by: linlzhan <linlin.zhang@oss.qualcomm.com>
Fixes: https://github.com/oasis-tcs/virtio-spec/issues/238
---
 device-types/blk/description.tex | 450 +++++++++++++++++++++++++++++--
 1 file changed, 428 insertions(+), 22 deletions(-)

diff --git a/device-types/blk/description.tex b/device-types/blk/description.tex
index 9bfdc4a..5869af0 100644
--- a/device-types/blk/description.tex
+++ b/device-types/blk/description.tex
@@ -21,7 +21,8 @@ \subsection{Virtqueues}\label{sec:Device Types / Block Device / Virtqueues}
 
 If VIRTIO_BLK_F_CTRL_VQ is negotiated, the control virtqueue is appended
 after the request virtqueues. The control virtqueue is reserved for control
-requests defined by this specification.
+requests defined by this specification, including the cryptographic control
+requests described below.
 
 \subsection{Feature bits}\label{sec:Device Types / Block Device / Feature bits}
 
@@ -75,11 +76,21 @@ \subsection{Feature bits}\label{sec:Device Types / Block Device / Feature bits}
     bitfield in the \field{virtio_blk_req} structure.
 
 \item[VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA (19)] Device supports the
-    VIRTIO_BLK_REQ_FLAG_OUT_FUA flag in the \field{flags} bitfield of the
-    \field{virtio_blk_req} structure for VIRTIO_BLK_T_OUT requests.
+    VIRTIO_BLK_REQ_FLAG_OUT_FUA flag in the \field{flags} bitfield in the
+    \field{virtio_blk_req} structure for VIRTIO_BLK_T_OUT and
+    VIRTIO_BLK_T_CRYPTO_OUT requests.
 
 \item[VIRTIO_BLK_F_CTRL_VQ (22)] Device supports a control virtqueue.
 
+\item[VIRTIO_BLK_F_INLINE_ENCRYPTION (23)] Only when the storage backend
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
@@ -142,6 +153,12 @@ \subsection{Device configuration layout}\label{sec:Device Types / Block Device /
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
 
@@ -229,6 +246,34 @@ \subsection{Device configuration layout}\label{sec:Device Types / Block Device /
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
+#define VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW    (1 << 0)
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
@@ -279,7 +324,7 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
     number of write zeroes segments for the block driver to use.
 
 \item If the VIRTIO_BLK_F_MQ feature is negotiated, \field{num_queues} field
-    can be read to determine the number of queues.
+     can be read to determine the number of queues.
 
 \item If the VIRTIO_BLK_F_CTRL_VQ feature is negotiated, the driver MUST
     identify the control virtqueue as queue N, after all request virtqueues.
@@ -295,6 +340,14 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
     \field{zoned} can be read by the driver to determine the zone
     characteristics of the device. All \field{zoned} fields are read-only.
 
+\item If the VIRTIO_BLK_F_INLINE_ENCRYPTION feature is negotiated, the fields in
+    \field{enc_characteristics} can be read by the driver to determine the
+    inline encryption capabilities of the device, and a
+    VIRTIO_BLK_T_GET_CRYPTO_MODES control virtqueue request (see
+    \ref{sec:Device Types / Block Device / Device Operation}) can be sent
+    to retrieve the set of supported crypto modes. All
+    \field{enc_characteristics} fields are read-only.
+
 \end{enumerate}
 
 \drivernormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
@@ -322,6 +375,10 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
 offered by the device with the VIRTIO_BLK_Z_HA or VIRTIO_BLK_Z_NONE zone model,
 then the driver MAY negotiate these two bits independently.
 
+Zoned devices do not support inline encryption. If the VIRTIO_BLK_F_ZONED
+feature is offered by the device, then the VIRTIO_BLK_F_INLINE_ENCRYPTION
+feature MUST NOT be negotiated by the driver.
+
 If the VIRTIO_BLK_F_ZONED feature is negotiated, then
 \begin{itemize}
 \item if the driver that can not support host-managed zoned devices
@@ -341,6 +398,20 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
 any request to the control virtqueue unless the request is defined by this
 specification.
 
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
@@ -355,9 +426,15 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
 If the device that is being initialized is a not a zoned device, the device
 SHOULD NOT offer the VIRTIO_BLK_F_ZONED feature.
 
+A zoned device MUST NOT offer the VIRTIO_BLK_F_INLINE_ENCRYPTION feature.
+
 The VIRTIO_BLK_F_ZONED feature cannot be properly negotiated without
 FEATURES_OK bit. Legacy devices MUST NOT offer VIRTIO_BLK_F_ZONED feature bit.
 
+The VIRTIO_BLK_F_INLINE_ENCRYPTION feature cannot be properly negotiated without
+FEATURES_OK bit. Legacy devices MUST NOT offer the VIRTIO_BLK_F_INLINE_ENCRYPTION feature
+bit.
+
 If the VIRTIO_BLK_F_ZONED feature is not accepted by the driver,
 \begin{itemize}
 \item the device with the VIRTIO_BLK_Z_HA or VIRTIO_BLK_Z_NONE zone model SHOULD
@@ -429,6 +506,35 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
 The device MUST NOT acknowledge FEATURES_OK if the driver sets
 VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA without VIRTIO_BLK_F_REQ_FLAGS.
 
+The device MUST NOT acknowledge FEATURES_OK if the driver negotiates both
+VIRTIO_BLK_F_ZONED and VIRTIO_BLK_F_INLINE_ENCRYPTION.
+
+If the device is incapable of consuming the \field{virtio_blk_crypto_msg},
+the device SHOULD NOT offer the VIRTIO_BLK_F_INLINE_ENCRYPTION feature.
+
+The device MUST NOT offer the VIRTIO_BLK_F_INLINE_ENCRYPTION feature without
+also offering VIRTIO_BLK_F_CTRL_VQ.
+
+If the VIRTIO_BLK_F_INLINE_ENCRYPTION feature is negotiated, the device
+MUST set \field{max_slots} in \field{enc_characteristics} to a value
+greater than 0. The value SHOULD reflect the number of key slots that
+the backend storage device makes available for use by this virtio-blk
+device.
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
@@ -468,11 +574,6 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
 };
 \end{lstlisting}
 
-Control virtqueue requests consist of a type field in an output buffer,
-followed by an optional command-specific output buffer, an optional
-command-specific input buffer, and a status byte in an input buffer. The
-type field and status byte MUST each be in their own buffer.
-
 The type of the request is either a read (VIRTIO_BLK_T_IN), a write
 (VIRTIO_BLK_T_OUT), a discard (VIRTIO_BLK_T_DISCARD), a write zeroes
 (VIRTIO_BLK_T_WRITE_ZEROES), a flush (VIRTIO_BLK_T_FLUSH), a get device ID
@@ -497,8 +598,8 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
 value is the bit index in the \field{flags} bitfield):
 
 \begin{description}
-\item[VIRTIO_BLK_REQ_FLAG_OUT_FUA (0) for VIRTIO_BLK_T_OUT requests] Force Unit
-    Access (FUA) flag.
+\item[VIRTIO_BLK_REQ_FLAG_OUT_FUA (0) for VIRTIO_BLK_T_OUT and
+    VIRTIO_BLK_T_CRYPTO_OUT requests] Force Unit Access (FUA) flag.
 \end{description}
 
 The \field{sector} number indicates the offset (multiplied by 512) where
@@ -905,6 +1006,189 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
 operation by setting the VIRTIO_BLK_S_ZONE_INVALID_CMD value in
 \field{status} of \field{virtio_blk_req} structure.
 
+The following requirements only apply if the VIRTIO_BLK_F_INLINE_ENCRYPTION
+and VIRTIO_BLK_F_CTRL_VQ features are negotiated.
+
+In addition to the request types defined for devices without inline
+encryption support, the type of a request on a request virtqueue can be an
+inline-encrypted read (VIRTIO_BLK_T_CRYPTO_IN) or an inline-encrypted write
+(VIRTIO_BLK_T_CRYPTO_OUT).
+
+The following request types are defined:
+
+\begin{lstlisting}
+#define VIRTIO_BLK_T_CRYPTO_OUT             27
+#define VIRTIO_BLK_T_CRYPTO_IN              28
+#define VIRTIO_BLK_T_GET_CRYPTO_MODES       29
+#define VIRTIO_BLK_T_CRYPTO_KEYSLOT_PROGRAM 30
+#define VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT   31
+#define VIRTIO_BLK_T_CRYPTO_DERIVE_SW_SECRET 32
+#define VIRTIO_BLK_T_CRYPTO_GENERATE_KEY    33
+#define VIRTIO_BLK_T_CRYPTO_IMPORT_KEY      34
+#define VIRTIO_BLK_T_CRYPTO_PREPARE_KEY     35
+\end{lstlisting}
+
+VIRTIO_BLK_T_CRYPTO_IN and VIRTIO_BLK_T_CRYPTO_OUT requests are submitted
+on a request virtqueue. All other request types listed above are submitted
+on the control virtqueue.
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
+\field{unused} is reserved and MUST be initialized to zero by the driver and
+ignored by the device.
+
+Control virtqueue requests consist of a type field in an output buffer,
+followed by an optional command-specific output buffer, an optional
+command-specific input buffer, and a status byte in an input buffer. The
+type field and status byte MUST each be in their own buffer.
+
+The command-specific buffers for each control command MUST be arranged as
+follows, in addition to the type and status buffers:
+
+\begin{description}
+\item[VIRTIO_BLK_T_GET_CRYPTO_MODES] One device-writable
+    \field{virtio_blk_crypto_modes} response buffer.
+
+\item[VIRTIO_BLK_T_CRYPTO_KEYSLOT_PROGRAM and
+    VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT] One device-readable
+    \field{virtio_blk_crypto_key_desc} command buffer.
+
+\item[VIRTIO_BLK_T_CRYPTO_DERIVE_SW_SECRET] One device-readable
+    \field{virtio_blk_crypto_key_blob} command buffer followed by one
+    device-writable \field{virtio_blk_crypto_sw_secret} response buffer.
+
+\item[VIRTIO_BLK_T_CRYPTO_GENERATE_KEY] One device-writable
+    \field{virtio_blk_crypto_key_blob} response buffer.
+
+\item[VIRTIO_BLK_T_CRYPTO_IMPORT_KEY and
+    VIRTIO_BLK_T_CRYPTO_PREPARE_KEY] One device-readable
+    \field{virtio_blk_crypto_key_blob} command buffer followed by one
+    device-writable \field{virtio_blk_crypto_key_blob} response buffer.
+\end{description}
+
+VIRTIO_BLK_T_GET_CRYPTO_MODES returns the data unit sizes with which each
+of the crypto modes specified by this specification can be used by the
+device. Its response is:
+
+\begin{lstlisting}
+struct virtio_blk_crypto_modes {
+        le32 modes[2];
+};
+\end{lstlisting}
+
+\field{modes[N]}, for crypto mode number N, is a bitmask indicating the
+data unit sizes with which crypto mode N can be used by the device: bit i of
+\field{modes[N]} is set if crypto mode N can be used with a data unit size of
+$(1 << i)$ bytes. \field{modes[0]} is reserved and is always set to 0 by the
+device. A zero value for \field{modes[N]} indicates that the device does not
+support that crypto mode.
+
+Crypto mode numbers are assigned by this specification, independently of
+any operating system's internal representation of crypto algorithms, so
+that support for additional crypto modes can be added in future revisions
+of this specification without changing the meaning of previously assigned
+numbers:
+
+\begin{lstlisting}
+#define VIRTIO_BLK_CRYPTO_MODE_AES_256_XTS        1
+\end{lstlisting}
+
+Crypto mode numbers already assigned by this or an earlier
+version of this specification are never reused for a different crypto
+mode; additional crypto modes are assigned new numbers, greater than the
+highest number defined by the version of this specification the
+implementation supports.
+
+Because crypto mode numbers, and the version of this specification each
+crypto mode was assigned in, are fixed by this specification rather than
+negotiated between the driver and the device, both sides need only refer
+to this specification to agree on their meaning: the driver sizes its
+response buffer to cover every crypto mode number defined by the
+version of this specification it implements, and the device fills in
+\field{modes[N]}, for each such N, directly according to whether and how
+it supports the crypto mode assigned to N by this specification. Neither
+side needs any additional mapping, renumbering, or out-of-band agreement
+for this.
+
+The remaining control commands use the following structures:
+
+\begin{lstlisting}
+struct virtio_blk_crypto_key_desc {
+        le32 slot;
+        u8 bytes[128];
+        le32 key_size;
+        le32 crypto_mode;
+        le32 key_type;
+        le32 data_unit_size_bits;
+        le32 dun_bytes;
+};
+
+struct virtio_blk_crypto_key_blob {
+        le32 key_size;
+        u8 key[128];
+};
+
+struct virtio_blk_crypto_sw_secret {
+        u8 secret[32];
+};
+\end{lstlisting}
+
+VIRTIO_BLK_T_CRYPTO_KEYSLOT_PROGRAM and VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT
+use \field{virtio_blk_crypto_key_desc} as their command-specific input to
+the device.
+VIRTIO_BLK_T_CRYPTO_GENERATE_KEY returns a
+\field{virtio_blk_crypto_key_blob}. VIRTIO_BLK_T_CRYPTO_IMPORT_KEY and
+VIRTIO_BLK_T_CRYPTO_PREPARE_KEY use a key blob as output and return a key
+blob. VIRTIO_BLK_T_CRYPTO_DERIVE_SW_SECRET uses a key blob as output and
+returns \field{virtio_blk_crypto_sw_secret}.
+
+VIRTIO_BLK_T_CRYPTO_IN requests are reads and VIRTIO_BLK_T_CRYPTO_OUT requests
+are writes. The control virtqueue commands use the direction of each buffer
+described above.
+
+For \field{virtio_blk_crypto_key_desc}, only the first \field{key_size} bytes
+of \field{bytes} contain key material. The remaining bytes,
+\field{bytes[key_size:128]}, are reserved, MUST be initialized to zero by the
+driver, and MUST be ignored by the device.
+
 \drivernormative{\subsubsection}{Device Operation}{Device Types / Block Device / Device Operation}
 
 The driver SHOULD check if the content of the \field{capacity} field has
@@ -923,8 +1207,8 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
 A driver MUST set \field{sector} to 0 for a VIRTIO_BLK_T_FLUSH request.
 A driver SHOULD NOT include any data in a VIRTIO_BLK_T_FLUSH request.
 
-The length of \field{data} MUST be a multiple of 512 bytes for VIRTIO_BLK_T_IN
-and VIRTIO_BLK_T_OUT requests.
+The length of \field{data} MUST be a multiple of 512 bytes for VIRTIO_BLK_T_IN,
+VIRTIO_BLK_T_OUT, VIRTIO_BLK_T_CRYPTO_IN and VIRTIO_BLK_T_CRYPTO_OUT requests.
 
 The length of \field{data} MUST be a multiple of the size of struct
 virtio_blk_discard_write_zeroes for VIRTIO_BLK_T_DISCARD,
@@ -1003,6 +1287,67 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
 
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
+    request is representable in the \field{dun_bytes} bytes specified when
+    the key was programmed. \field{dun_bytes} MUST NOT be greater than
+    \field{max_dun_bytes}.
+\end{itemize}
+
+For a VIRTIO_BLK_T_CRYPTO_IN or VIRTIO_BLK_T_CRYPTO_OUT request,
+\field{dun[4]} SHALL specify the 256-bit DUN of the first data unit covered
+by the request. The DUN corresponding to each subsequent data unit SHALL be
+obtained by incrementing the 256-bit value by one, propagating carries from
+\field{dun[0]} through \field{dun[3]}.
+
+For a keyslot-program command, the driver MUST:
+
+\begin{itemize}
+\item Set \field{key_size} to a value between 64 and 128, inclusive.
+
+\item Set \field{data_unit_size_bits} to the base-2 logarithm of the
+data unit size in bytes.
+
+\item Set \field{dun_bytes} to the number of bytes used to represent
+the DUN for the programmed key. \field{dun_bytes} MUST be between 1 and 32,
+inclusive, and MUST NOT be greater than \field{max_dun_bytes}.
+
+\item Set every byte in \field{bytes[key_size:128]} to zero.
+\end{itemize}
+
+A driver MUST treat any crypto mode number for which its response
+buffer does not contain a corresponding \field{modes} element as
+unsupported by the device.
+
+A driver MUST provide a device-writable buffer with size
+$(M + 1) \times 4$ bytes for the complete \field{modes} array as
+the response buffer for a VIRTIO_BLK_T_GET_CRYPTO_MODES control request,
+where $M$ is the highest crypto mode number defined by that version
+of this specification (the $+1$ accounts for the reserved crypto mode
+number 0).
+
+The driver MUST set all reserved fields in crypto-related structures
+to zero.
+
 \devicenormative{\subsubsection}{Device Operation}{Device Types / Block Device / Device Operation}
 
 The device MAY change the content of the \field{capacity} field during
@@ -1049,10 +1394,10 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
 
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
@@ -1068,11 +1413,6 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
 and its completion, the write could be either volatile or stable when
 its completion is reported; in other words, the exact behavior is undefined.
 
-% According to the device requirements for device initialization:
-%   Offer(CONFIG_WCE) => Offer(FLUSH).
-%
-% After reversing the implication:
-%   not Offer(FLUSH) => not Offer(CONFIG_WCE).
 
 If VIRTIO_BLK_F_FLUSH was not offered by the
   device\footnote{Note that in this case, according to
@@ -1244,6 +1584,72 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
 handles VIRTIO_BLK_T_ZONE_RESET request for the zone range specified in the
 VIRTIO_BLK_T_SECURE_ERASE request.
 
+If the VIRTIO_BLK_F_INLINE_ENCRYPTION feature is not negotiated, the device
+MUST reject all inline-encryption request and control command types with
+VIRTIO_BLK_S_UNSUPP status.
+
+The following requirements only apply if the VIRTIO_BLK_F_INLINE_ENCRYPTION
+and VIRTIO_BLK_F_CTRL_VQ features are negotiated.
+
+If an encrypted request specifies an invalid slot, zero-length data, a
+misaligned sector or data length, or a DUN range that is not representable in
+the \field{dun_bytes} bytes specified when the key was programmed, the device
+MUST set \field{status} to
+VIRTIO_BLK_S_UNSUPP and MUST NOT access the data.
+
+For VIRTIO_BLK_T_GET_CRYPTO_MODES, the device MUST fill each
+\field{modes[N]} element that fits entirely within the response buffer.
+
+For a mode index N, \field{modes[N]} SHALL indicate whether the
+corresponding crypto mode defined by this specification is supported by
+both the virtio-blk device and the backend storage device.
+
+The device MUST set \field{modes[N]} to zero if:
+
+\begin{itemize}
+\item no crypto mode is assigned to N by this specification.
+
+\item the corresponding crypto mode is not supported.
+\end{itemize}
+
+The device MUST NOT write beyond the response buffer and MUST NOT write
+a partial \field{modes} element.
+
+For encrypted reads and writes, the device MUST use the key provisioned in
+the requested slot and the request's \field{dun[4]}. If the device splits the
+request, each sub-request MUST preserve data-unit alignment and use the
+256-bit DUN obtained by incrementing the request DUN by the number of
+preceding data units.
+
+For a keyslot program command, the device MUST validate
+\field{slot}, \field{key_size}, \field{crypto_mode}, \field{key_type},
+\field{data_unit_size_bits}, and \field{dun_bytes} against the device
+capabilities. In particular, \field{key_size} MUST be between 64 and 128,
+inclusive; \field{crypto_mode} MUST identify a supported crypto mode,
+\field{key_type} MUST identify a supported key type,
+\field{data_unit_size_bits} MUST identify a data unit size supported for the
+specified crypto mode, and \field{dun_bytes} MUST be between 1 and
+\field{max_dun_bytes}, inclusive. The device MUST reject invalid values with
+VIRTIO_BLK_S_UNSUPP.
+
+For a successful keyslot program command, the device MUST store the supplied
+key and associated parameters in the specified slot, replacing any value
+previously stored in that slot. If the command fails, the device MUST leave
+the contents and state of the specified slot unchanged.
+
+For a keyslot evict command, the device MUST validate \field{slot}. If the
+slot is valid, the device MUST remove any key and associated parameters from
+the slot and complete the command successfully. Evicting an already empty
+slot MUST also complete successfully. If the slot is invalid, the device
+MUST reject the command with VIRTIO_BLK_S_UNSUPP and MUST leave all slots
+unchanged.
+
+For a keyslot evict command, fields other than \field{slot} in the
+\field{virtio_blk_crypto_key_desc} are ignored by the device.
+
+The device MUST reject a control command with an invalid command-specific
+buffer or an unknown command type with VIRTIO_BLK_S_UNSUPP.
+
 \subsubsection{Legacy Interface: Device Operation}\label{sec:Device Types / Block Device / Device Operation / Legacy Interface: Device Operation}
 When using the legacy interface, transitional devices and drivers
 MUST format the fields in struct virtio_blk_req
-- 
2.34.1

