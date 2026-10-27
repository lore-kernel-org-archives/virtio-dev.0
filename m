Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793092203;
	b=G8sSFp4IFYI/2MFCy8HeD4n1x+KQHmmlD84AmvYUuuG8riWUdeuAmG3BILDkiKLDOsWR
	 iOhXuCNBCARLwaI+gR5nRpRfBXg+C732sboXcIdXCmTSazAwjaoIh4OE1fH7190LuZWD6
	 lz1puYykw+sLD7jP0i5Nan3tR02PW0jQ9XN7XPnxEKm3aRE2M/CZeVKGYyoyhfol+gFJc
	 D438XVl+WXT4MUWs0WoPMRBuqQRC8zQgWGttVk7RxmPJJOhvWqMCivspuUp0rxrAp+ftU
	 vodcgdE3I7J+US2zQGnmYISfT/tgQLqli694Ab1pZGjZsFqHfDysXXAjKJppnXK87MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793092203;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=jJqwyAcnBDNuL1IKXOrEe4oTsa9FnRgdACu/xuJZ69A=;
	b=plT9RTYhsYMEElBHRre4gYd1t7tUhLxzF0zMfifhOrVD7enO1LdMbwl1AA3Se58cPpdt
	 s8gGQpmsTu/j5k9eD9FicqMox+TNQFFH8hIavdCWVECfgg4zNem3qBqM3TMtB436S2aQ7
	 l8Plx9OqPl6avPKKWA1dPk1G8UvLZeOiq7lCKkeJsuHnqtFeugYOr1sPXhwzNYUFb3QsY
	 R3nbdtRkSLqDHYvJzWv8OcjiLr+5Jv0vLVklUs3i8SZcbJAWDlk+6koxO0Z9O7mNy3opw
	 QkCJTPB1BCPWzBTLZgdvG5/Evo+9bPpMT5NiC62Xlt86ed9UahhHlPS4JDVvct1yumA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=D74+1Vu0;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aaKX9jHC;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E70A606A321
	for <virtio-dev@lists.linux.dev>; Tue, 27 Oct 2026 09:10:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E70A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=D74+1Vu0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aaKX9jHC
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69R8gKWU1162775
	for <virtio-dev@lists.linux.dev>; Tue, 27 Oct 2026 09:10:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=jJqwyAcnBDN
	uL1IKXOrEe4oTsa9FnRgdACu/xuJZ69A=; b=D74+1Vu0ueQb+XPK2m5OnWcjXs5
	QSg1wIjBXn6KgxjEtXezWRAE+fQ5YkIZPwSj0G19mdJNI+aqW+XIbEXlV3e+Ddfs
	2AkaUtBaLygJZfTYxAKoQp52W0908tg7vDII6Zy4JZaP9enBf4Ejv7NqFe6j7rEy
	m6QgG+Laf35eHHrpJ8H/EgpvSuiaNr9zLv45tEU8RltI7/nNKCZWFPddsLBA8P79
	Le1Y95j526ERxgm3A0Zn2nFjn+5M39cvmOHZKUM8Dk+nBC4+5B3f7yb2W/hQbFR+
	AfJUZMtO6pqiPBAXGDSCLYPVDmggQgixmzAyvLLWlf+Uq4EN2jJrfZyGjfQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjbmmats7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Tue, 27 Oct 2026 09:10:01 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ea0fe07201so26755955ad.1
        for <virtio-dev@lists.linux.dev>; Tue, 27 Oct 2026 02:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793092201; x=1793697001; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jJqwyAcnBDNuL1IKXOrEe4oTsa9FnRgdACu/xuJZ69A=;
        b=aaKX9jHCXB3ysbVArTpha0vH6OVfs9HGPJeGY1G228hc6wBFowD9VVly9+ch0+nXsz
         haQ4YO6+UomcQECjM+eDbtwCbjASWPK2g/n76KA4OwkQtnYWYtDaxBXQvYWTKPJeUmuA
         svbCdKERoph10IcyJSPFAzDJwuYEN6Kj7CoUbTwVkeBlw8meD12+SfwYYO5pdNgWNfQc
         pqQ7rrjwucp3fjJjWm7e3zsZ0Kw7Xu37H4jW8qS+OgsqVJHo1om0O80vG1jFcugkSXRx
         ARyqzK23bAlg8g60B1brRAGVxnveBbZ4HU24I7pepPmZEdz7Ck0DHRIYk0Pd38/w3kg5
         d1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793092201; x=1793697001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jJqwyAcnBDNuL1IKXOrEe4oTsa9FnRgdACu/xuJZ69A=;
        b=j6gbntiAsytix2Zgt6MkB7InlZNQOZe3j3zGw4mO3D8do8Mx2KN1kH17Jg2386WSp8
         QvFy+CWAjVc4sokvRHPIK6vkt7hnPOQWjOOcvMQPDfISWYiFlUMpYz16hGUtVZFlLn/Q
         +6VWuUVNCzOpfToics2wJSZ+YnxwubVdbOPOgnYbrRf2gR/iQ4Fn8/TqPNSMoY3aNvR/
         3PcrCacXd9Zp3AW4085l44EA/P49n8uuep/obba3Hmz9rQWAlT4pZTJ6iP8rGJeXQI0+
         tKflitbTd4uX9LiJE5YCMuEvFJC/ua6ZHCY+t6qlniqh3oZty8iBAN8dSiKGWcQid/cC
         r9YA==
X-Gm-Message-State: AFq9FYLmkfFUAP0+hVHKJb3zS8zz+/5U5wZQINSOWkJzF/LuogKdgV0C
	HXmFzoZUQVwW4mhw/ZB4leoEbQqHfmTkDtBGkVX/kfPMtFs3kVZ3wXftypJwlzIrpnW+NM6MREn
	XsvA830p1Fq17/M0R4NDBd+I7yJF3pjAxqeExKqzmmDFm/pSjPbhWC7McfxZgie4/JQqmnUvS
X-Gm-Gg: AYBFou39/LJJ4qdDz6n5w9OPvlHbWyUfA+PbTc/2NsJ1gSRUdH0JQ9qshbCxrNb7pwh
	zZM7DId38/LWcWhKKNf7N+x7JP3RN0X/EJl0AupvSboZRf/eey68Q6pPHsP6Xe+1rKrMQSMzAuh
	kRDmgj8So7PoGQ0t2P/XftUXyzV04Jfmwluz2iHXD2LP1rOs4Iz6LTLvSsr4IJKReOmJTHW3T2t
	RM3pC3fZ+MkxgWiGHcnlBt/K7ZtvPikHYlWdFec7tTkW9ggAldWFN2ra6bVusJEMZtE0Dd6XTi9
	bdxQJL+3Rb4BFyBhIfOwFxD4Oai0S7pwu7D69X3POoeirKvOSrRJa4Cc4TWhxxpYAQqPOhJubLF
	si/ga2X+qcltJeU4jET9CNR26eLWlmp+lWJLpiWLvVlGxlKN1mKxtUKz65w==
X-Received: by 2002:a17:90b:3e4d:b0:3ac:adce:60b2 with SMTP id 98e67ed59e1d1-3ade9b2ce76mr7802206a91.2.1793092200498;
        Tue, 27 Oct 2026 02:10:00 -0700 (PDT)
X-Received: by 2002:a17:90b:3e4d:b0:3ac:adce:60b2 with SMTP id 98e67ed59e1d1-3ade9b2ce76mr7802191a91.2.1793092199915;
        Tue, 27 Oct 2026 02:09:59 -0700 (PDT)
Received: from u24-san1p10108.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae404426c2sm2940522a91.7.2026.10.27.02.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 02:09:59 -0700 (PDT)
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: virtio-dev@lists.linux.dev, virtio-comment@lists.linux.dev,
        stefanha@redhat.com, mst@redhat.com, mgurtovoy@nvidia.com,
        parav@nvidia.com, ebiggers@kernel.org
Cc: neeraj.soni@oss.qualcomm.com
Subject: [PATCH v6 1/4] virtio-blk: Add inline encryption feature bit and configuration
Date: Tue, 27 Oct 2026 02:09:24 -0700
Message-ID: <20261027090945.185178-2-linlin.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027090945.185178-1-linlin.zhang@oss.qualcomm.com>
References: <20261027090945.185178-1-linlin.zhang@oss.qualcomm.com>
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Post: <mailto:virtio-dev@lists.linux.dev>
List-Help: <mailto:virtio-dev+help@lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtio-dev+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAzNiBTYWx0ZWRfX2hDRcrxJQ+TN
 9YK/oMY57g+Z/RffAB2Vo5npw+zpEyzJ4qiXDitJ6R3uRHdIINHPVrArW1KkZLcSAKgoeyVYK62
 /x3XBEy61diBeOMN2vVwt38M0K7W2Y8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAzNiBTYWx0ZWRfXza5+YGKVNN0y
 adWkf7fkNHtY7e3OoUGKXme36HifXu+iHAjDn7ReSUML2tWQxmd2TYlP4lYW3hR/DKg4EsXyU41
 G/3n/kSDsNaI/ggNABeJB6VhwroqCTbspfQHk510vABLaRnPhrvNq2sav8S/XehVd+fbCSY28Bf
 hgEe53ZJ/BQaTjt1xZKbRrRvqcZAHAxz4l6+n4zA5SguiTpOJv+SaMUOSWWncI0lg/NeIB7uFbE
 3FSz52x8aik3e1q0IU/MRyrQLluufNEox9Zk8vzTEOJSvXD0A4fJyiIK7v5VARoiLuS6uoSeTC8
 AEJkRbNEz9tWhs9Y/V4Jl4iwIGJ3+uZKRkSytzdCiAca3+pylP9j4AFFTrogWx/gXRXDFOmHyEu
 Cgc1gRQHsdsHFXRNxqXhBbduWBNqlxFlKbxP8fAOOqAtoC09uqW5ZJkouWg+GYl2w+DUmBnWWIC
 moAb5Bvbk8Gtp9K1nkA==
X-Authority-Analysis: v=2.4 cv=PrkG/AM3 c=1 sm=1 tr=0 ts=6ae06a69 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=V5FpdODwkRovwfavNdUA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: jD21gWaayQqyzJlwrTdFrHRD5GQqZv7b
X-Proofpoint-GUID: jD21gWaayQqyzJlwrTdFrHRD5GQqZv7b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270036

Inline crypto engines, such as those defined by JEDEC UFSHCI and eMMC
CQHCI, encrypt and decrypt data on its way to and from the storage,
using keys that are programmed into keyslots of the engine and selected
per request. Block devices backed by such storage have no way to expose
this capability to the driver so far.

As the first step towards supporting inline encryption in virtio-blk,
add the VIRTIO_BLK_F_INLINE_ENCRYPTION feature bit and the
enc_characteristics device configuration fields, which let the driver
discover the inline encryption capabilities of the device:

max_slots: number of keyslots.
max_dun_bytes: maximum size of the Data Unit Number (DUN) in bytes.
key_types: supported key types, raw and/or hardware-wrapped.

Keys are managed with group administration commands, therefore the
feature depends on VIRTIO_F_ADMIN_VQ.

max_slots is 32 bits wide, matching the 32-bit slot fields used in the
administration commands and in the requests.

Inline encryption cannot necessarily be supported on a zoned block
device, as the zoned write constraints do not guarantee that I/O
addresses are aligned to the encryption data unit size. Therefore the
feature is never offered together with VIRTIO_BLK_F_ZONED.

Driver requirements:
- VIRTIO_BLK_F_INLINE_ENCRYPTION is not negotiated without
  VIRTIO_F_ADMIN_VQ.
- The reserved field unused3 is ignored.

Device requirements:
- VIRTIO_BLK_F_INLINE_ENCRYPTION is only offered together with
  VIRTIO_F_ADMIN_VQ, and never together with VIRTIO_BLK_F_ZONED.
- FEATURES_OK is not acknowledged if VIRTIO_BLK_F_INLINE_ENCRYPTION is
  negotiated without VIRTIO_F_ADMIN_VQ.
- max_slots, max_dun_bytes and key_types report valid values.

Subsequent patches add the administration commands to manage the keys
and the request types which use them.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/238
Signed-off-by: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
---
 device-types/blk/description.tex | 102 +++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/device-types/blk/description.tex b/device-types/blk/description.tex
index 3b3a4e7..b347140 100644
--- a/device-types/blk/description.tex
+++ b/device-types/blk/description.tex
@@ -73,6 +73,17 @@ \subsection{Feature bits}\label{sec:Device Types / Block Device / Feature bits}
     VIRTIO_BLK_REQ_FLAG_OUT_FUA flag in the \field{flags} bitfield of the
     \field{virtio_blk_req} structure for VIRTIO_BLK_T_OUT requests.
 
+\item[VIRTIO_BLK_F_INLINE_ENCRYPTION (20)] Device supports inline
+    encryption: data written to or read from the device can be encrypted
+    or decrypted by an inline crypto engine in the device backend storage.
+    Keys are programmed into keyslots of the device, and each encrypted
+    request selects, by keyslot index, the key programmed into that
+    keyslot. The number of keyslots, the maximum size of the Data Unit
+    Number (DUN) and the supported key types are reported in
+    \field{enc_characteristics}. The keys are managed using group
+    administration commands sent on the administration virtqueue, so this
+    feature requires VIRTIO_F_ADMIN_VQ.
+
 \end{description}
 
 \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Block Device / Feature bits / Legacy Interface: Feature bits}
@@ -135,6 +146,12 @@ \subsection{Device configuration layout}\label{sec:Device Types / Block Device /
                 u8 model;
                 u8 unused2[3];
         } zoned;
+        struct virtio_blk_enc_characteristics {
+                le32 max_slots;
+                u8 max_dun_bytes;
+                u8 key_types;
+                u8 unused3[2];
+        } enc_characteristics;
 };
 \end{lstlisting}
 
@@ -222,6 +239,39 @@ \subsection{Device configuration layout}\label{sec:Device Types / Block Device /
 terminated by the device with a "zone resources exceeded" error as defined for
 specific commands later.
 
+If the VIRTIO_BLK_F_INLINE_ENCRYPTION feature is negotiated, then in
+\field{enc_characteristics},
+\begin{itemize}
+\item \field{max_slots} is the number of available keyslots. Keyslots are
+    indexed from 0 to \field{max_slots} - 1.
+
+\item \field{max_dun_bytes} is the maximum number of bytes of the Data Unit
+    Number (DUN) that the device supports for any of its supported crypto
+    modes.
+
+\item \field{key_types} is a bitmask of the key types the device supports,
+    using the following values:
+    \begin{lstlisting}
+#define VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW         (1 << 0)
+#define VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED  (1 << 1)
+    \end{lstlisting}
+    VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW indicates that keys are programmed into
+    keyslots in raw (plaintext) form. VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED
+    indicates that keys are programmed into keyslots in ephemerally-wrapped
+    form, and can only be unwrapped by dedicated hardware (e.g. a hardware
+    key manager), so that the plaintext key is never passed to the device
+    for keyslot programming. Outside of the device, such a key is stored in
+    a long-term wrapped form.
+
+\item \field{unused3} is reserved for future use.
+\end{itemize}
+
+\begin{note}
+For example, known inline crypto engines report a \field{max_dun_bytes} of
+4 (JEDEC eMMC Command Queue Host Controller Interface, CQHCI) or 8 (JEDEC
+UFS Host Controller Interface, UFSHCI).
+\end{note}
+
 \subsubsection{Legacy Interface: Device configuration layout}\label{sec:Device Types / Block Device / Device configuration layout / Legacy Interface: Device configuration layout}
 When using the legacy interface, transitional devices and drivers
 MUST format the fields in struct virtio_blk_config
@@ -285,6 +335,11 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
     \field{zoned} can be read by the driver to determine the zone
     characteristics of the device. All \field{zoned} fields are read-only.
 
+\item If the VIRTIO_BLK_F_INLINE_ENCRYPTION feature is negotiated, the fields in
+    \field{enc_characteristics} can be read by the driver to determine the
+    inline encryption capabilities of the device. All
+    \field{enc_characteristics} fields are read-only.
+
 \end{enumerate}
 
 \drivernormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
@@ -327,6 +382,23 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
 The driver MUST NOT negotiate VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA without
 VIRTIO_BLK_F_REQ_FLAGS.
 
+Drivers MUST NOT negotiate the VIRTIO_BLK_F_INLINE_ENCRYPTION feature
+unless they are capable of:
+\begin{itemize}
+\item retrieving the inline encryption characteristics from the device
+    configuration space.
+\item programming and evicting keys in the block device's keyslots
+    through the administration virtqueue.
+\item submitting the keyslot index and Data Unit Number (DUN) per crypto
+    request to the device.
+\end{itemize}
+
+The driver MUST NOT negotiate VIRTIO_BLK_F_INLINE_ENCRYPTION without
+VIRTIO_F_ADMIN_VQ.
+
+If the VIRTIO_BLK_F_INLINE_ENCRYPTION feature is negotiated, the driver
+MUST ignore \field{unused3} in \field{enc_characteristics}.
+
 \devicenormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
 
 Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it
@@ -341,6 +413,9 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
 If the device that is being initialized is a not a zoned device, the device
 SHOULD NOT offer the VIRTIO_BLK_F_ZONED feature.
 
+The device MUST NOT offer both the VIRTIO_BLK_F_ZONED and the
+VIRTIO_BLK_F_INLINE_ENCRYPTION features.
+
 The VIRTIO_BLK_F_ZONED feature cannot be properly negotiated without
 FEATURES_OK bit. Legacy devices MUST NOT offer VIRTIO_BLK_F_ZONED feature bit.
 
@@ -415,6 +490,33 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
 The device MUST NOT acknowledge FEATURES_OK if the driver sets
 VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA without VIRTIO_BLK_F_REQ_FLAGS.
 
+The VIRTIO_BLK_F_INLINE_ENCRYPTION feature cannot be properly negotiated
+without FEATURES_OK bit. Legacy devices MUST NOT offer the
+VIRTIO_BLK_F_INLINE_ENCRYPTION feature bit.
+
+The device MUST NOT offer VIRTIO_BLK_F_INLINE_ENCRYPTION unless it also
+offers VIRTIO_F_ADMIN_VQ.
+
+The device MUST NOT acknowledge FEATURES_OK if the driver negotiates
+VIRTIO_BLK_F_INLINE_ENCRYPTION without VIRTIO_F_ADMIN_VQ.
+
+If the VIRTIO_BLK_F_INLINE_ENCRYPTION feature is negotiated, the device
+MUST set \field{max_slots} in \field{enc_characteristics} to a value
+greater than 0. The value SHOULD reflect the number of keyslots that
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
+If the VIRTIO_BLK_F_INLINE_ENCRYPTION feature is negotiated, the device
+MUST NOT set \field{max_dun_bytes} in \field{enc_characteristics} to 0 or
+to a value greater than 32.
+
 \subsubsection{Legacy Interface: Device Initialization}\label{sec:Device Types / Block Device / Device Initialization / Legacy Interface: Device Initialization}
 
 Because legacy devices do not have FEATURES_OK, transitional devices
-- 
2.34.1

