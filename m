Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793092208;
	b=SAcUhk+TT8loYRIPk95Cr81G7SLXplDf0IrkWjuoiAnDKZpt10dx96cUWCinWB/nl9Yh
	 N/9QOZmKWcEQJzWF5+Vcgyhk8OO6S+y0hFBAncyJN2uyZMaUhimeJUPB2ZnCJZKl47cFy
	 dCdk+9uxkwWCUOzcPCKpXIkTorPlv5CruWmMsStmGhbBh/bAYh6FQ667v9iT+Z52xaZJp
	 j6ze6QzWPxOlpVwJpFpXRKGlSz2sVa9hx4K+/DVTbmFDeYkodbM1Rm/AzInUWVqKD+T9z
	 B4gvmGy9crTOMLNvcUInrvYbdPMTWHj3EbZjqY0hsPONxCsoF94OxyzcM+dJhOTMVfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793092208;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=sIUCxGvZmzrx7I982kD4WWaGxm+tB1Zcq4eyYtvnSQI=;
	b=Oa/9ec3FYZxu0nv9WZYaqhxibC3BvkjelUAK2ld6kL9NWcMlZjdvhnCQ2W88jgxDwgaH
	 236YpPX51yF+wo7Yp18D+e7wHKNwKTkATjpoCvLt5JpEksyslKzw32spcN4BXk5B0p0Hq
	 yKxhsoTl4pJyacHc6E9Ldd715TMsWC+3mA2ObibF5k6aN/XnH/+i/GBu/s/Puniqwot1W
	 EMqwVL8OrSwfjNsmGOfO4S+XuN4pfMwVQPaUm+vVQN07akTKbsVJO8lHucMzLan6vXjNd
	 jngXOfCl8+O71BnuEQhWY7HlKxnVRvQy2JSlaSF1EpVWKOw99V+HzQdhpFvDMbFVk3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d+QELyb6;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OnbxKIQ0;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16072606A323
	for <virtio-dev@lists.linux.dev>; Tue, 27 Oct 2026 09:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16072606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d+QELyb6;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OnbxKIQ0
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69R8gKS91162740
	for <virtio-dev@lists.linux.dev>; Tue, 27 Oct 2026 09:10:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=sIUCxGvZmzr
	x7I982kD4WWaGxm+tB1Zcq4eyYtvnSQI=; b=d+QELyb6wubsg/5AQ+Dsl9iamns
	S854763vP+q46opVgNe53bwfxAJ86Lk0M6aP5P/i5bLswlU0eyz5c5TukbfUpRPS
	MtH9wTCiK60t/XmZKj+RXzNAaa05um63IuWlHrX1nwpGBubf5VHc0QCXEbtCBVY8
	4hXlSGmYkp3mdhdCGvRWa6I1lR81sMqb/DgZ7VejKXOaNQN2QjCr6FWqPgg7ZCBr
	RnmYZK8mEyMxSRBojzc6IktGBwo3EaFudcabmtCY2XsYr+fzLNcpoMIzntmuqsgr
	JRWxs4oObc/yNrUBy+PuGSsnfesdisL1fj021TrqFrI5zhWc7EdtkR5ffVw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjbmmatt1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Tue, 27 Oct 2026 09:10:07 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ac0ae43900so3846183a91.0
        for <virtio-dev@lists.linux.dev>; Tue, 27 Oct 2026 02:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793092207; x=1793697007; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sIUCxGvZmzrx7I982kD4WWaGxm+tB1Zcq4eyYtvnSQI=;
        b=OnbxKIQ0eNvy98HsvnIbrGFX4ROCkFiPtCd3jxOMSnf9PymXFIWf/4nrt9P0pgb/Y9
         kH0IkYAwuuf2d8QuHBL9zdIHksCJu2Q+r79byvr47YW0rMGGKWX7aFC9kU+uaLsVkJya
         pXXyw/5lIulhRkhogkjnokE2gz9PC8IWldaMVlqwXPuDM6aQtuyCpkI3W7emncvT0AAf
         KA7FaIXAkz1hLf5cCAL1oeztsmwM5ekbQvrmMxF/rj++z58U8aW8ZoofF9moFfmRPRfe
         sxPXtYlcVO+1Vx8BOSbSPnkr3+smcdF6FggGzJKdk56caETp9EmJgocEBRfSV+YdsAvn
         kROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793092207; x=1793697007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sIUCxGvZmzrx7I982kD4WWaGxm+tB1Zcq4eyYtvnSQI=;
        b=vz0iF7k/ZUpkaNOgbuSYWY5Myz4xX+UQjL1H0upPLJ9YTx4r3f91YEKGnSIOPdvCPP
         Nrjnyv1i9UcIh6nEm9WCS6ff8ynQ5536vxjws+CfNTOQRtYBfLY32U6uZ6dCmTSeIjwJ
         cKWiEgIh3GAuT57/T2VSvNJkwuxTe443+ZN8H0kpgCI+2y+/qZI2kgAjZsRv2sTRF6AI
         Mig89HEcTi76XWjXdLg30VWfsCF6TMcOfiGpZb7p3Ax1R3q7ha+FtkY812R+6YmCN31o
         0UR1V4M2RfDqcceQIFhwycQnwl/a9k4sg7Q8NP+609ZrR9rGokCowSRfs8KrKBIrkt6p
         Sygw==
X-Gm-Message-State: AFq9FYJJx1yG2aXFLHdjQa55CTspvSQUS6GrLOp5MmFfhaNwJu2OwcMl
	LT17qvDab6ZL0STlPb/jMtqjDi6nhrvwmpRW3rDug30OHc7i351w1eF7hKRT6ozCKLfJ7ax4D1D
	NoglaZkwlVgZ3enXY6fvkUQBdCkGORqSYwnqjNfenc7vhge0cT716t9VKyCM6FCcO2ruotreg
X-Gm-Gg: AYBFou00fSGgovbZAxMvP6v8HwE6iEMQgj34cd9CWN2oqM1bIY6W/ExMDcINNW0Pnjv
	3vMe7OPRZNolwX5EgyKVwtQbegrTjas+hL5cR0B5RziS6+1lsrEzoGgedKvyptYGM88EFqfEyLX
	5l/OZM9KP4QibyJ8ZRLlvD29sLPfI6YLHh4AgP8mEmgQzL8ki02a+0UECMdYPMkhGcF6ghaxkxl
	oqAozPR6QMxjKf3YUK6uksJ9yDL1zA4xD20l35Mi67RmsBHNZ7SKNDWArZhM7zpMIZhzpGvRKp2
	Cz/0lXc0MweFdaScg+ybGuwwsaqczkdjAPZBx89xlBs79hie9Lt/Obds9fpO9yaes99NqMNctvv
	A9ztGi46yhd6ONhuMuSSiMR1MY2g+XGqzFVag3s7eWUNM4WvETefNBCaAsQ==
X-Received: by 2002:a17:90b:4a49:b0:3ab:188b:c5bc with SMTP id 98e67ed59e1d1-3adea8984afmr7332712a91.14.1793092206456;
        Tue, 27 Oct 2026 02:10:06 -0700 (PDT)
X-Received: by 2002:a17:90b:4a49:b0:3ab:188b:c5bc with SMTP id 98e67ed59e1d1-3adea8984afmr7332682a91.14.1793092205900;
        Tue, 27 Oct 2026 02:10:05 -0700 (PDT)
Received: from u24-san1p10108.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae404426c2sm2940522a91.7.2026.10.27.02.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 02:10:05 -0700 (PDT)
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: virtio-dev@lists.linux.dev, virtio-comment@lists.linux.dev,
        stefanha@redhat.com, mst@redhat.com, mgurtovoy@nvidia.com,
        parav@nvidia.com, ebiggers@kernel.org
Cc: neeraj.soni@oss.qualcomm.com
Subject: [PATCH v6 4/4] virtio-blk: Add inline encryption security considerations
Date: Tue, 27 Oct 2026 02:09:27 -0700
Message-ID: <20261027090945.185178-5-linlin.zhang@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAzNiBTYWx0ZWRfXzHwgrUXGvdJh
 ESPOUBkrJZlfQ25FYE3YD5SbKRmZx0gzquTdOjWkKGJx5M9JpCTMBA6qk7gNDnnbBVwGrQFDnBp
 wVFTFV27zBeXXGMSlUzXeCJZiQrTPb4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAzNiBTYWx0ZWRfX55C7/7rNl+6/
 fqbf7zLgdazSbOcyIM1ywmuv+mqGtY20M+uGn5CVTmxY3oEJ79DJQnaBxky47hSnxHwq152Y9WQ
 xIn30WdN0kzxiHfXhWwC1YwyPxLSxG03qSCmFxtZnuWSOqusOD9sK3aNvs6IwokStn6UHtCT/pf
 NZDhJiItGw3lXvwsiQWunw4OODn761EUR1cpO4ldp/zTdbKvK+on9GE6gRPCae3tSgmE31wvNEB
 jwTMJ7mSRY4Ik4xiGu6PZ5xK/IjTJ27hwfhJrbSSv6sc0KazbFRfSpsH79poDWk7AtUL5W2gIZk
 T1cnzq9+7A3eAJob0vXQG+71RCL4+8kMHHSvJgBXvYEUvS8V7Bqpd7xawp9uVVCYK6uNUoc9VWw
 cGCthLgYwh02gpciWqMNkErHpHPWheG9L29ILNAC/tdhSPJdzgiI+ibl1/a+95uXgqnRBQyedrz
 Baghf+pvf20Isos5ILA==
X-Authority-Analysis: v=2.4 cv=PrkG/AM3 c=1 sm=1 tr=0 ts=6ae06a6f cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=NsdwARnllhIqxsrLOxIA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: K_mm2C6b4W6RiuNd_Nfjq07bD7tRz2z9
X-Proofpoint-GUID: K_mm2C6b4W6RiuNd_Nfjq07bD7tRz2z9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270036

Inline encryption protects the data stored on the backend storage, but
the device, and therefore the host, is able to read the buffers of both
the request virtqueues and the administration virtqueue.

Describe the resulting exposure. The data of the requests is transferred
in plaintext, so inline encryption is not a means of keeping data
confidential from the host, whichever key type is used, and confidential
guests cannot rely on it for that.

A raw key programmed into a keyslot is visible to the host. A
hardware-wrapped key prevents the raw key from being extracted, so that
the key can only be used through the device which wrapped it, but does
not prevent the host, which is able to send administration commands
itself, from using the key through the device.
The raw key imported by VIRTIO_BLK_ADMIN_CMD_CRYPTO_IMPORT_KEY and the
software secret returned by VIRTIO_BLK_ADMIN_CMD_CRYPTO_DERIVE_SW_SECRET
are also visible to the host.

This patch adds no normative requirements.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/238
Signed-off-by: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
---
 device-types/blk/description.tex | 40 ++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/device-types/blk/description.tex b/device-types/blk/description.tex
index bbae9af..ca54e50 100644
--- a/device-types/blk/description.tex
+++ b/device-types/blk/description.tex
@@ -1994,6 +1994,46 @@ \subsubsection{Inline Encryption Administration Commands}\label{sec:Device Types
 NOT write key material or the derived software secret to the
 \field{command_specific_result}.
 
+\subsubsection{Inline Encryption Security Considerations}\label{sec:Device Types / Block Device / Device Operation / Inline Encryption Security Considerations}
+
+Inline encryption protects the data stored on the backend storage, for
+example against an attacker who obtains the storage medium on its own. It
+is not a means of keeping data confidential from the host: the device, and
+therefore the host, is able to read the buffers of both the request
+virtqueues and the administration virtqueue. A confidential guest, for
+example a guest whose memory is protected from the host by a confidential
+computing technology, cannot rely on inline encryption to keep its data
+confidential from the host, whichever key type it uses.
+
+\begin{note}
+Inline encryption does not protect the data of VIRTIO_BLK_T_CRYPTO_OUT and
+VIRTIO_BLK_T_CRYPTO_IN requests from the host: that data is transferred in
+plaintext in buffers of the request virtqueues.
+\end{note}
+
+When \field{key_type} is VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW, the key material in
+the \field{bytes} of struct virtio_blk_crypto_key_desc of a
+VIRTIO_BLK_ADMIN_CMD_CRYPTO_KEYSLOT_PROGRAM command is the plaintext key.
+Any software able to access the buffers of the administration virtqueue,
+such as the hypervisor, the device implementation or other software on the
+host, can therefore obtain the key, and decrypt the data encrypted with it
+at any time, including after the key is no longer in use.
+
+When \field{key_type} is VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED, a
+VIRTIO_BLK_ADMIN_CMD_CRYPTO_KEYSLOT_PROGRAM command only transfers a key
+wrapped by the device, and the raw key material is not exposed in its
+buffers. This prevents the raw key from being extracted, so that the key
+can only be used through the device which wrapped it. It does not prevent
+the host, which is able to send administration commands itself, from using
+the key through the device, for example by converting a long-term wrapped
+key it has observed with VIRTIO_BLK_ADMIN_CMD_CRYPTO_PREPARE_KEY and
+programming the result into a keyslot. Moreover, a
+VIRTIO_BLK_ADMIN_CMD_CRYPTO_IMPORT_KEY command carries the raw key in its
+\field{command_specific_data}, and the struct virtio_blk_crypto_sw_secret
+returned by a VIRTIO_BLK_ADMIN_CMD_CRYPTO_DERIVE_SW_SECRET command is
+visible in its \field{command_specific_result}, so these commands expose
+secrets to the host in the same way as raw keys.
+
 \subsubsection{Legacy Interface: Device Operation}\label{sec:Device Types / Block Device / Device Operation / Legacy Interface: Device Operation}
 When using the legacy interface, transitional devices and drivers
 MUST format the fields in struct virtio_blk_req
-- 
2.34.1

