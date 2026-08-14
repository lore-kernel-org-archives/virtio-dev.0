Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CE73C73CC
	for <virtio-dev@lists.linux.dev>; Fri, 14 Aug 2026 14:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786717420; cv=none; b=ufbAwVZ5cR6+JwLnF0o1+z/Exi9LXB16XWdORFAyeKbebTaYehjXujzlGWt7suxxqJkxi914bzrG/g917IDg5P+vQU9B4ABhaaccNdBz/bcrlLwbnjrS42JBi0imDbe29o25ibRbhNCP2ue/WAPxqW1KaAWUJTlyOpnXVKaC6C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786717420; c=relaxed/simple;
	bh=vZ9qCPVVQZOk57tNu5QX5+Ghy+27m3lo0Tt0uMCue6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KcDBZflQyF+9uj7OOoidbFWGYf0nd3dfOqQVpeHqA+Ma6IvlNr4PJI/mXBp+XkfSUva1fGmegUbXlNM9zugcP1RopzdaRY9L/VwK5nilvPeL8nKO6AkfOew+PEMNy97TE6cfqlbkvX58XCNcb9xB5MzpDxDpGmdhDtV0apQttF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Lxvf+hOA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YNT27POc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lxvf+hOA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YNT27POc"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EDxSI01564782
	for <virtio-dev@lists.linux.dev>; Fri, 14 Aug 2026 14:23:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=VJJpky8k3bKX28j9mDL9C9K0neUkT30byyz
	IwvIQ1XU=; b=Lxvf+hOAFe/h0Z/vLu/8Z3n5qGscr1wpQZmY4Ld2UyS+4Id+VEF
	klhjyOkoNhqbkMX7Jqo39CqDT9WJglUvc9yjjiyPmhNoGqoYT0ao2onYZ02BdsnF
	CK9M+gdv27lmtioLumiVBTJIx8RGwmBixvRWBJiaNgMD+l6zT29jiFlRgtM0q33v
	wfbIpH2srL9gQ/wv5nv3Ya611a6SHqnB3J9rL60CpJ2YAhM5nwkzpdTWe8O5GXRg
	R24N0joeZ38NHZrFrE8JMTyJlRPLe/noC9zgSTii6v3R+JFabvJrdxGlM6zJU/de
	LU+US8dekwly9lt7888LDppEujv/wqZBFKw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1j2f4kdv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Fri, 14 Aug 2026 14:23:20 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cbef7b172easo2160258a12.0
        for <virtio-dev@lists.linux.dev>; Fri, 14 Aug 2026 07:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786717400; x=1787322200; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VJJpky8k3bKX28j9mDL9C9K0neUkT30byyzIwvIQ1XU=;
        b=YNT27POc8CQZ1Ak+Ei9YB3HYEeMzqp/DUZZaAYmDB8Ps4JLUfnL8pvFVDPTqbaRP5P
         v0JnPpKr9aBrbi/WLUX67bZuo2O+2LrYcHE4Vx0BxpNU9Uc5pobTq7FZCo0SuSK/uCKS
         9XC1Il6+KLqsA7lm7FzH0OU3pkR+74RcRc5ukQ/bacAksrn10Jwraa8aCtkRTkYWsJqh
         SFOS0wws22Ppo5l655z3XgPN6/DNf2Gm4tukUzWsTwC7MMk/s0FKg+pP2SXE/hHdDuLw
         2dbK6WC9u/9DR+wtn/l5rxkD+V203zdDJRiSvKPIAbqUJCCuw8xtCdLa2hgZ6wZMWNj2
         sq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786717400; x=1787322200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VJJpky8k3bKX28j9mDL9C9K0neUkT30byyzIwvIQ1XU=;
        b=gv9d+aznjfpfdtirDPZrzi+0Gzw0FQzsOvUdYmxie+Ahivc0Jm/RAMMoarrX/rwJp3
         hrkhsECTzW18ZgTcAdKnfgJNW2qmpSZ2DVlK0gI3OQC4iMtFk+fPBguRq4H2xpYecory
         vZq9UJriRBy+rPOxP/lcknCZQEMyy62h457VKAJFVPVI8Tz56UIhIpzxQ7afCS3SvKKx
         LsXGTkyoLaANQ7cPVjOxPzCjHxynfn9rbsswEMb0QJ3Lp22lBOVUAQkggrkIgoRTDVmc
         ImNYM2doSasIXNoKGbHX00srBuecvKS0c1dZmiP46hNwmOysAGpxgNftKs5IKf3kJEHr
         RuTA==
X-Gm-Message-State: AOJu0Yyq8QF8Z9FuQeDGeZUYVRX91vqL45taJUFadHzSgVq/hTZ/KugK
	wj8XdzLPaibxgB0teims1H+XzZhzDVgi9LfeVMpdv4wj4AX29T3eJHCaFj70d+sb2V0TvjPFPeC
	6pB5lw8PQvhRaioSySvMXCTOe7SyQGhR5JQf/BupNkUfCCj4TZFO+F1/piSSE0WwcpLaDJTq1
X-Gm-Gg: AR+sD11wX1DfslOnRyKWv7PgIXCnaY3e+Rf5PD1p3FokqvJBYVcVl5FflOkeHSyKQnu
	B1Z4lfL1hp1dLr24mtxy7/5GdP/C3T5htdcj/Nw/uT20U6uKmLJQWDXT5r5WsSTqGdW+5XDNhPp
	re/vOoQrjlAtmgTg0+WTwvozXtwnV+unQEGertYmBwMxY+9zNbtmdCZZWOe6Y9Vs/oDqwaZfn7K
	9gkdyHDCh+aN1ehn1DJX5Ha4yFFcVIwTwGv6jIkaGAK6PQVqvzDpP2kOnRVVH3u7FvFTBzRpcjm
	nfZQqi+UI8gnyNEyGMDvRoPf/7v8RkftpcWe1KeiJEPYBjgBHkaj+jB1C1gl4BbRxFpQnb4WoyI
	3eoKRVHDVc/FF3DNUTsYWr/py5XFPZJ+zJOdOiPjXKU7VdhHDYbrtmGrB3jk=
X-Received: by 2002:a05:6300:141:b0:3c8:e10b:7a9b with SMTP id adf61e73a8af0-3cc71b19c7emr8138087637.16.1786717400030;
        Fri, 14 Aug 2026 07:23:20 -0700 (PDT)
X-Received: by 2002:a05:6300:141:b0:3c8:e10b:7a9b with SMTP id adf61e73a8af0-3cc71b19c7emr8137944637.16.1786717398975;
        Fri, 14 Aug 2026 07:23:18 -0700 (PDT)
Received: from u24-san1p10108.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320d60eb8eesm5344663eec.10.2026.08.14.07.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 07:23:18 -0700 (PDT)
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: virtio-dev@lists.linux.dev, stefanha@redhat.com, ebiggers@kernel.org
Cc: neeraj.soni@oss.qualcomm.com
Subject: [PATCH v1] virtio-blk: Add inline encryption support
Date: Fri, 14 Aug 2026 07:23:01 -0700
Message-ID: <20260814142306.3934029-1-linlin.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FeMHAp+6 c=1 sm=1 tr=0 ts=6a7f24d9 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=ktaf5dMkO6o13SluR0MA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: FkrC1aay3LtikUQ-rgfrX8PMkyePeT1F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDEwOSBTYWx0ZWRfX2O484O2aTwon
 KAUBCfOmZO9ON9Q8wGEqiC2KxlDGNf81spJlksINnBQSMf5zZyg/9If/YjgoLOFqYkKcbiKXwLZ
 iPD2NFnjK5MVNBJKPAtbufLCpSLzCDOx/TFuf5piYsvka5cWIci1RCkrVdSp2iMOTa56+pRFKdt
 3izumHhbuCreOkMLjBmmW+X5lSZrBJ5APYBMvPHI9eE9kaOiMUIS53RoQecOWdRyI4yiZFE9TwR
 Y41ZUmOtMEyxrkL4h7ghWy9/f8UyYT9KJo15I5G5ckVg68zNA7oK3lqVzICibuRkQ+2gNVh4kp2
 J9cAJB8bdZ0RPXjpF+u2wQOiK8LlTSDz/wrIv6r7bPPNslS9pe77boF0zNPTmUXzsTAHvBE++AO
 unDHGNFRGs1gwZeZbt+lTJ2QGP6LDc775BAKchs+FzmNH7/2E6q/7jMGFuj58V8o0FVcFMJOieE
 1XeQ9zC/aBI58oP6DRg==
X-Proofpoint-ORIG-GUID: FkrC1aay3LtikUQ-rgfrX8PMkyePeT1F
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDEwOSBTYWx0ZWRfX8cBIhi29BntB
 V751sYich2wTe8qtjuZTN+XIEmNN31rALMXOan7JJzkigss5lqv6YwBnP/PDU/MQVdh9h3coTs8
 Phqn7a+2lo3NTMPIuWTbb4toT6quiyI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140109

From: linlzhan <linlin.zhang@oss.qualcomm.com>

Add VIRTIO_BLK_F_IE to advertise inline encryption support.

When the feature is negotiated, the device reports inline encryption
characteristics through virtio_blk_enc_characteristics. Add
VIRTIO_BLK_T_GET_CRYPTO_MODES, VIRTIO_BLK_T_CRYPTO_IN, and
VIRTIO_BLK_T_CRYPTO_OUT so that the driver can discover supported
crypto modes and submit inline-encrypted I/O requests.

Crypto I/O requests carry a virtual key slot index, data unit size,
and initial Data Unit Number (DUN). The device maps the virtual key
slot to a physical key slot in the storage backend and uses these
parameters for inline encryption or decryption.

Key provisioning is performed through an out-of-band mechanism and is
outside the scope of this device type.

For background on inline encryption in UFS and eMMC storage, see:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/block/inline-encryption.rst

Change-Id: I83c52456bc0c9dd37f39ff46e6bfe73a715138ca
Signed-off-by: linlzhan <linlin.zhang@oss.qualcomm.com>
Fixes: https://github.com/oasis-tcs/virtio-spec/issues/238
---
 device-types/blk/description.tex | 297 ++++++++++++++++++++++++++++++-
 1 file changed, 291 insertions(+), 6 deletions(-)

diff --git a/device-types/blk/description.tex b/device-types/blk/description.tex
index 3b3a4e7..f8a544b 100644
--- a/device-types/blk/description.tex
+++ b/device-types/blk/description.tex
@@ -71,7 +71,16 @@ \subsection{Feature bits}\label{sec:Device Types / Block Device / Feature bits}
 
 \item[VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA (19)] Device supports the
     VIRTIO_BLK_REQ_FLAG_OUT_FUA flag in the \field{flags} bitfield of the
-    \field{virtio_blk_req} structure for VIRTIO_BLK_T_OUT requests.
+    request for VIRTIO_BLK_T_OUT and VIRTIO_BLK_T_CRYPTO_OUT requests.
+
+\item[VIRTIO_BLK_F_IE (22)] Only when the storage backend supports inline
+    encryption and this feature bit is negotiated, the data read from or
+    written to the device can be decrypted from or encrypted to the storage
+    via inline crypto engine. Keys are provisioned into key slots of the
+    inline crypto engine through a mechanism outside the scope of this device
+    type, and requests identify, by key slot index, which provisioned key to
+    use. The number of key slots, the maximum DUN size and the supported key
+    types are reported in \field{enc_characteristics}.
 
 \end{description}
 
@@ -135,6 +144,12 @@ \subsection{Device configuration layout}\label{sec:Device Types / Block Device /
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
 
@@ -222,6 +237,39 @@ \subsection{Device configuration layout}\label{sec:Device Types / Block Device /
 terminated by the device with a "zone resources exceeded" error as defined for
 specific commands later.
 
+If the VIRTIO_BLK_F_IE feature is negotiated, then in
+\field{virtio_blk_enc_characteristics},
+\begin{itemize}
+\item \field{max_slots} is the number of key slots allocated to the Guest VM.
+    It MUST not exceed the number of key slots supported by the inline crypto
+    engine of the device backend storage. Key slots are indexed from 0 to
+    \field{max_slots} - 1.
+
+\item \field{max_dun_bytes} is the maximum number of bytes of the Data Unit
+    Number (DUN) that the device supports for any of its supported crypto
+    modes. For example, known inline crypto engines report a
+    \field{max_dun_bytes} of 4 (JEDEC eMMC Command Queue Host Controller
+    Interface, CQHCI) or 8 (JEDEC UFS Host Controller Interface, UFSHCI);
+    a device backed by different inline crypto engine hardware MAY report
+    a different value, subject to the constraints in
+    \ref{devicenormative:Device Types / Block Device / Device Initialization}.
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
@@ -285,6 +333,14 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
     \field{zoned} can be read by the driver to determine the zone
     characteristics of the device. All \field{zoned} fields are read-only.
 
+\item If the VIRTIO_BLK_F_IE feature is negotiated, the fields in
+    \field{enc_characteristics} can be read by the driver to determine the
+    inline encryption capabilities of the device, and a
+    VIRTIO_BLK_T_GET_CRYPTO_MODES request (see
+    \ref{sec:Device Types / Block Device / Device Operation}) can be sent
+    to retrieve the set of supported crypto modes. All
+    \field{enc_characteristics} fields are read-only.
+
 \end{enumerate}
 
 \drivernormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
@@ -312,6 +368,10 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
 offered by the device with the VIRTIO_BLK_Z_HA or VIRTIO_BLK_Z_NONE zone model,
 then the driver MAY negotiate these two bits independently.
 
+Zoned devices do not support inline encryption. If the VIRTIO_BLK_F_ZONED
+feature is offered by the device, then the VIRTIO_BLK_F_IE feature MUST NOT
+be negotiated by the driver.
+
 If the VIRTIO_BLK_F_ZONED feature is negotiated, then
 \begin{itemize}
 \item if the driver that can not support host-managed zoned devices
@@ -327,6 +387,12 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
 The driver MUST NOT negotiate VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA without
 VIRTIO_BLK_F_REQ_FLAGS.
 
+Drivers MUST NOT negotiate the VIRTIO_BLK_F_IE feature if they are
+incapable of provisioning keys into the key slots of the device backend
+storage's inline crypto engine, or of conveying the key slot index,
+data unit size in bits, and Data Unit Number (DUN) per request to
+the device using the \field{virtio_blk_crypto_msg} structure.
+
 \devicenormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
 
 Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it
@@ -341,9 +407,15 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
 If the device that is being initialized is a not a zoned device, the device
 SHOULD NOT offer the VIRTIO_BLK_F_ZONED feature.
 
+A zoned device MUST NOT offer the VIRTIO_BLK_F_IE feature.
+
 The VIRTIO_BLK_F_ZONED feature cannot be properly negotiated without
 FEATURES_OK bit. Legacy devices MUST NOT offer VIRTIO_BLK_F_ZONED feature bit.
 
+The VIRTIO_BLK_F_IE feature cannot be properly negotiated without
+FEATURES_OK bit. Legacy devices MUST NOT offer the VIRTIO_BLK_F_IE feature
+bit.
+
 If the VIRTIO_BLK_F_ZONED feature is not accepted by the driver,
 \begin{itemize}
 \item the device with the VIRTIO_BLK_Z_HA or VIRTIO_BLK_Z_NONE zone model SHOULD
@@ -415,6 +487,26 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
 The device MUST NOT acknowledge FEATURES_OK if the driver sets
 VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA without VIRTIO_BLK_F_REQ_FLAGS.
 
+The device MUST NOT acknowledge FEATURES_OK if the driver negotiates both
+VIRTIO_BLK_F_ZONED and VIRTIO_BLK_F_IE.
+
+If the device is incapable of consuming the \field{virtio_blk_crypto_msg},
+the device SHOULD NOT offer the VIRTIO_BLK_F_IE feature.
+
+If the VIRTIO_BLK_F_IE feature is negotiated, the device MUST set
+\field{max_slots} in \field{enc_characteristics} to a value greater than 0.
+
+If the VIRTIO_BLK_F_IE feature is negotiated, the device MUST set
+\field{key_types} in \field{enc_characteristics} to have at least one of
+VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW or VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED
+set, and MUST NOT set any bit in \field{key_types} other than
+VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW and VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED.
+The device MUST initialize padding bytes \field{unused3} to 0.
+
+The device MUST NOT set \field{max_dun_bytes} in \field{enc_characteristics}
+to 0 or to a value greater than 8, since \field{dun} of
+\field{virtio_blk_crypto_msg} is a fixed 8-byte field.
+
 \subsubsection{Legacy Interface: Device Initialization}\label{sec:Device Types / Block Device / Device Initialization / Legacy Interface: Device Initialization}
 
 Because legacy devices do not have FEATURES_OK, transitional devices
@@ -478,8 +570,8 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
 value is the bit index in the \field{flags} bitfield):
 
 \begin{description}
-\item[VIRTIO_BLK_REQ_FLAG_OUT_FUA (0) for VIRTIO_BLK_T_OUT requests] Force Unit
-    Access (FUA) flag.
+\item[VIRTIO_BLK_REQ_FLAG_OUT_FUA (0) for VIRTIO_BLK_T_OUT and
+    VIRTIO_BLK_T_CRYPTO_OUT requests] Force Unit Access (FUA) flag.
 \end{description}
 
 The \field{sector} number indicates the offset (multiplied by 512) where
@@ -886,6 +978,108 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
 operation by setting the VIRTIO_BLK_S_ZONE_INVALID_CMD value in
 \field{status} of \field{virtio_blk_req} structure.
 
+The following requirements only apply if the VIRTIO_BLK_F_IE feature is
+negotiated.
+
+In addition to the request types defined for devices without inline
+encryption support, the type of the request can be an inline-encrypted read
+(VIRTIO_BLK_T_CRYPTO_IN), an inline-encrypted write (VIRTIO_BLK_T_CRYPTO_OUT)
+or a get crypto modes command (VIRTIO_BLK_T_GET_CRYPTO_MODES).
+
+\begin{lstlisting}
+#define VIRTIO_BLK_T_CRYPTO_OUT        27
+#define VIRTIO_BLK_T_CRYPTO_IN         28
+#define VIRTIO_BLK_T_GET_CRYPTO_MODES  30
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
+        le32 data_unit_size_bits;
+        le64 dun;
+};
+\end{lstlisting}
+
+\field{slot} is the virtual key slot index, in the range from 0 to
+\field{max_slots} - 1 of \field{enc_characteristics}. The device maps this
+virtual key slot index to a physical key slot in the inline crypto engine of
+the device backend storage.
+\field{data_unit_size_bits} is $log_2$ of the data unit size in bytes,
+used for calculating DUNs for sub-requests if the request is split.
+\field{dun} is the Data Unit Number, that is, the initial value that the
+inline crypto engine increments by one for each successive data unit of
+the size specified by \field{data_unit_size_bits}, while encrypting or
+decrypting the data of the request.
+
+VIRTIO_BLK_T_GET_CRYPTO_MODES is a read request that returns the data unit
+sizes with which each of the device's crypto modes can be used. The
+response consists of a header followed by zero or more \field{le32}
+bitmask elements, indexed by crypto mode number:
+
+\begin{lstlisting}
+struct virtio_blk_crypto_modes {
+        le32   nr_modes;
+        u8     reserved[4];
+        le32   modes[];
+};
+\end{lstlisting}
+
+The device sets \field{nr_modes} in the response header to the number of
+fully transferred \field{modes} elements in the data buffer. \field{modes[N]},
+for crypto mode number N, is a bitmask indicating the data unit sizes with
+which crypto mode N can be used by the device: the i'th bit of
+\field{modes[N]} is set if crypto mode N can be used with a data unit size
+of $(1 << i)$ bytes. A value of 0 for a \field{modes} element indicates
+that the device does not support the corresponding crypto mode at all.
+Crypto mode number 0 is reserved; \field{modes[0]} is always set to 0 by
+the device.
+
+Crypto mode numbers are assigned by this specification, independently of
+any operating system's internal representation of crypto algorithms, so
+that support for additional crypto modes can be added in future revisions
+of this specification without changing the meaning of previously assigned
+numbers:
+
+\begin{lstlisting}
+#define VIRTIO_BLK_CRYPTO_MODE_AES_256_XTS        1
+#define VIRTIO_BLK_CRYPTO_MODE_AES_128_CBC_ESSIV  2
+#define VIRTIO_BLK_CRYPTO_MODE_ADIANTUM           3
+#define VIRTIO_BLK_CRYPTO_MODE_SM4_XTS            4
+\end{lstlisting}
+
+A driver or device implementation MAY support only a subset of these
+crypto modes. Crypto mode numbers already assigned by this or an earlier
+version of this specification are never reused for a different crypto
+mode; additional crypto modes are assigned new numbers, greater than the
+highest number defined by the version of this specification the
+implementation supports.
+
+VIRTIO_BLK_T_CRYPTO_IN and VIRTIO_BLK_T_GET_CRYPTO_MODES requests are reads,
+and VIRTIO_BLK_T_CRYPTO_OUT requests are writes.
+
 \drivernormative{\subsubsection}{Device Operation}{Device Types / Block Device / Device Operation}
 
 The driver SHOULD check if the content of the \field{capacity} field has
@@ -904,8 +1098,8 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
 A driver MUST set \field{sector} to 0 for a VIRTIO_BLK_T_FLUSH request.
 A driver SHOULD NOT include any data in a VIRTIO_BLK_T_FLUSH request.
 
-The length of \field{data} MUST be a multiple of 512 bytes for VIRTIO_BLK_T_IN
-and VIRTIO_BLK_T_OUT requests.
+The length of \field{data} MUST be a multiple of 512 bytes for VIRTIO_BLK_T_IN,
+VIRTIO_BLK_T_OUT, VIRTIO_BLK_T_CRYPTO_IN and VIRTIO_BLK_T_CRYPTO_OUT requests.
 
 The length of \field{data} MUST be a multiple of the size of struct
 virtio_blk_discard_write_zeroes for VIRTIO_BLK_T_DISCARD,
@@ -984,6 +1178,42 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
 
 \end{enumerate}
 
+The following requirements only apply if the VIRTIO_BLK_F_IE feature is
+negotiated.
+
+A driver MUST NOT submit a VIRTIO_BLK_T_CRYPTO_IN or VIRTIO_BLK_T_CRYPTO_OUT
+request with a \field{slot} value that is not less than \field{max_slots} of
+\field{enc_characteristics}, or that identifies a key slot into which no key
+has been provisioned.
+
+A driver MUST set \field{data_unit_size_bits} of a VIRTIO_BLK_T_CRYPTO_IN or
+VIRTIO_BLK_T_CRYPTO_OUT request's \field{crypto_msg} to $log_2$ of the data
+unit size in bytes associated with the key provisioned in the virtual key
+slot identified by \field{slot}. Since data unit sizes are reported by
+VIRTIO_BLK_T_GET_CRYPTO_MODES as a bitmask of \field{le32} elements, a
+driver MUST NOT set \field{data_unit_size_bits} to a value greater than 31.
+
+A driver MUST NOT submit a VIRTIO_BLK_T_CRYPTO_IN or VIRTIO_BLK_T_CRYPTO_OUT
+request with a zero length \field{data}.
+
+A driver MUST NOT submit a VIRTIO_BLK_T_CRYPTO_IN or VIRTIO_BLK_T_CRYPTO_OUT
+request unless \field{sector}, multiplied by 512, and the length of
+\field{data}, are both a multiple of $(1 << \field{data_unit_size_bits})$
+bytes.
+
+A driver MUST NOT submit a VIRTIO_BLK_T_CRYPTO_IN or VIRTIO_BLK_T_CRYPTO_OUT
+request if \field{dun} + $N$ - 1 is not representable in
+\field{max_dun_bytes} bytes, where $N$ is the number of data units of
+$2^{\field{data_unit_size_bits}}$ bytes in \field{data}.
+
+A driver MUST treat any crypto mode number that is not less than
+\field{nr_modes} of a VIRTIO_BLK_T_GET_CRYPTO_MODES response as unsupported
+by the device.
+
+A driver MUST provide a \field{data} buffer of at least
+sizeof(struct virtio_blk_crypto_modes) (8) bytes for a
+VIRTIO_BLK_T_GET_CRYPTO_MODES request.
+
 \devicenormative{\subsubsection}{Device Operation}{Device Types / Block Device / Device Operation}
 
 The device MAY change the content of the \field{capacity} field during
@@ -1030,7 +1260,8 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
 
 \item\label{item:flush3} the VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA feature was
   negotiated and the VIRTIO_BLK_REQ_FLAG_OUT_FUA bit in \field{flags} was set in
-  the write request (regardless of whether the VIRTIO_BLK_F_FLUSH or
+  the write request (VIRTIO_BLK_T_OUT or VIRTIO_BLK_T_CRYPTO_OUT, regardless of
+  whether the VIRTIO_BLK_F_FLUSH or
   VIRTIO_BLK_F_CONFIG_WCE features were negotiated, and regardless of the
   current cache mode as expressed by the value of the \field{writeback} field in
   configuration space).
@@ -1225,6 +1456,60 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
 handles VIRTIO_BLK_T_ZONE_RESET request for the zone range specified in the
 VIRTIO_BLK_T_SECURE_ERASE request.
 
+The following requirements only apply if the VIRTIO_BLK_F_IE feature is
+negotiated.
+
+If a VIRTIO_BLK_T_CRYPTO_IN or VIRTIO_BLK_T_CRYPTO_OUT request:
+\begin{itemize}
+\item specifies a \field{slot} value that is not less than \field{max_slots},
+    or that identifies a key slot into which no key has been provisioned,
+
+\item specifies a \field{data_unit_size_bits} value greater than 31, or
+    that does not match $log_2$ of the data unit size in bytes associated
+    with the key provisioned in the virtual key slot identified by the
+    \field{slot},
+
+\item specifies a zero length \field{data},
+
+\item specifies a \field{sector}, multiplied by 512, or a length of
+    \field{data}, that is not a multiple of $(1 << \field{data_unit_size_bits})$
+    bytes, or
+
+\item specifies a \field{dun} such that \field{dun} + $N$ - 1 is not
+    representable in \field{max_dun_bytes} bytes, where $N$ is the number
+    of data units of $2^{\field{data_unit_size_bits}}$ bytes in
+    \field{data},
+\end{itemize}
+then the device MUST set the \field{status} byte to VIRTIO_BLK_S_UNSUPP and
+MUST NOT read or write any data.
+
+If a VIRTIO_BLK_T_GET_CRYPTO_MODES request's \field{data} buffer is smaller
+than sizeof(struct virtio_blk_crypto_modes) (8) bytes, the device MUST set
+the \field{status} byte to VIRTIO_BLK_S_UNSUPP and MUST NOT write any data.
+
+If the driver's \field{data} buffer in a VIRTIO_BLK_T_GET_CRYPTO_MODES
+request is not large enough to hold \field{modes} elements up to the
+highest crypto mode number the device supports, the device MUST set
+\field{nr_modes} to the number of complete \field{modes} elements that fit
+in the buffer, and MUST NOT write a partial element.
+
+The device MUST initialize padding bytes \field{reserved} of a
+VIRTIO_BLK_T_GET_CRYPTO_MODES response to 0.
+
+For a VIRTIO_BLK_T_CRYPTO_IN or VIRTIO_BLK_T_CRYPTO_OUT request, the device
+MUST use the key provisioned in the virtual key slot identified by
+\field{slot} of the request's \field{crypto_msg}, combined with \field{dun},
+to decrypt the data read from, or encrypt the data written to, the device
+backend storage. If the device backend storage splits the request into
+sub-requests, each sub-request MUST begin at a byte offset, from the start
+of \field{data}, that is a multiple of $(1 << \field{data_unit_size_bits})$
+bytes, MUST have a length that is a multiple of
+$(1 << \field{data_unit_size_bits})$ bytes, and MUST use, in place of
+\field{dun}, the Data Unit Number
+$\field{dun} + (\mathit{byte\_offset} / (1 << \field{data_unit_size_bits}))$,
+where $\mathit{byte\_offset}$ is that sub-request's starting byte offset
+from the start of \field{data}.
+
 \subsubsection{Legacy Interface: Device Operation}\label{sec:Device Types / Block Device / Device Operation / Legacy Interface: Device Operation}
 When using the legacy interface, transitional devices and drivers
 MUST format the fields in struct virtio_blk_req
-- 
2.34.1

