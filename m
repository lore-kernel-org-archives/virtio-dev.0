Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732D026FD97
	for <virtio-dev@lists.linux.dev>; Sun, 13 Sep 2026 16:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789316206; cv=none; b=bCwWCvBqxFoG1zVltN2sdx3QVO+VIC85KWpKM8xt5160EY+N9hPueGoEB1dNjj+btyy83UWmamU9rFf3UhKs8dg/s+P3tzmx7MJvIFwz9qPHiUvg+UzGt0Nrv+imeNzp4QIuRbtClA9/bB+RftwjzlK+K1mfwwTa6SsWpOfKrcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789316206; c=relaxed/simple;
	bh=2cwYlfLxJpYuDxHONsjf2Uqvfg4icoQ/S755zerV7IM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rGliaPYQ0J71dWnBe0Mli/5W8l6FPZx1ASN7ZMUUxIapRkDrqLv9jzwBjY2xh3Z2JhoxSaMdDlXHrhBuoeoDJfZA3jl3Z079gthjb9uR+zDmtKJScGjWNcODXrj2tdZ9HphMzyrcuROk25immJj8dnhWSuyvT4k0CD3PCEPPkGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EIilfIuh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bqk9+q4B; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EIilfIuh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bqk9+q4B"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68DE0QDi2481632
	for <virtio-dev@lists.linux.dev>; Sun, 13 Sep 2026 16:16:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=R1skCjBgfxz
	4KDOgf7OLORE52FdeRm9nooyeESqZeDU=; b=EIilfIuhHRg78iDboaQu5s0pua5
	DiEC8FAtIwyUluYZP4FTwPd/Sy+bJBMF46D1qkKVytNa15LBYa1sXIsmK+ktB5Vj
	HXTE8XuLCyeigEvbGR6CBJlYB15ZsxGDqUaDZIyv5Pp34g1IWMYGmqgS8hVQxkoP
	5MR8kdHYQdcHsRtu8rtWucuBlMcBplvM8UqtleVQUCSIUsMRZANiVZlHniQ4h6EJ
	CrAVnHI2HJ6qqnimNu7oESvCM1W9LYtb9OCyl9rZuaP0DHGRPXiztagi65lQ1qA/
	9yt+sDbztv4bWAreophsy9jeyPXVWrpIi5SsZow5REC4k2JyDT4dI29b90g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dkncq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Sun, 13 Sep 2026 16:16:42 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cfc52ddc55so36923585ad.3
        for <virtio-dev@lists.linux.dev>; Sun, 13 Sep 2026 09:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789316202; x=1789921002; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R1skCjBgfxz4KDOgf7OLORE52FdeRm9nooyeESqZeDU=;
        b=bqk9+q4BOE+Lb7GVxQNASX8+KXs0XoJ4wk4Ay868gdJ31vAaB09Kd/JUsfvE6sobmF
         VEutZoe4b37zx5aATvFspVgV39CzNBYB0Nwpwp+wB6p8P4wpuvYXqPJfOc191Gli2LMl
         r1uA5oOZq7HMmy+wp/I+KINjh0hli/6MHgpTmD4sKYqq5XNxRIUhJtU95qmWdHbZsRs9
         SwOExT4vXebzKKeAkkqN5ZEz2YiomURDQlGXOdAml7ALHJ4FbEhMOkfLJHGs3iLIjBnd
         4R84mMdLAUYe5q7FBU29MGiIOeIHpcXV9uh/luH82VwzfxTq2ZlVJarAspYplO5kPmXM
         Vgyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789316202; x=1789921002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R1skCjBgfxz4KDOgf7OLORE52FdeRm9nooyeESqZeDU=;
        b=YFX0UWnOc7x/TlI1sACN075tQeFSaIyb/JfTfFOSgwLQMiG2SxFcVLMZ7NNr7oIQpr
         AFhtyzqBBJuh8OBHpVyLbPz0/y5kBIa4Rcx+dJmnT0tWXKAbkrh6SHDF6TPumQ8HpErz
         46W1ZzTghn21shm3e3tAf6+qVGOsYZvz5fygIdRtyhaJJvm89PbSf7DjFioaJZx0Y4Qm
         3rbj1yIqeVknkktItZvckHA517GcTDRZHHUMfpKNq2ZkoKZ6v+JsqfI6n+qwHgN9zOFQ
         DvNHxvJ1zbc7Jq5K3X4Waoei7ME6ObZh+LUt9W+XxLFfSKMah1j0zizBX6Dijg75ktO+
         Vppw==
X-Gm-Message-State: AFuF++mXjgLvr24106QsNwi5cHSdJb+XmvQvaBQLnBCthSB2tL5G5moP
	UQCfqn9uuyaBgmKQQWU4KuQa4u/l/oyNdRY7sV7Gvv/hZWFUA/YhefmI9uOHvkmTHExdidmuPTz
	BLDKvWdQyP5n1F39z7nibxqNHsG3EXPgRlywgEc/w0EbwgR8ljn/5WyO+kKrzl6Bg/SCqzHAdZy
	k=
X-Gm-Gg: AYBFou3u/xp41ov4fnWJYP7H2TFZb9+OL3yCwKakJ2RgPF8uz6FBz9IdeT+PnuYiRdj
	ktQdzG/10D1HOq1Af+D5kOXwoEPrPoi4Jyt82RVAu0fE4hOA8cGT4A0HFcYcIjirYzphdK2koM4
	3RUsSvPPJ/O+dZeyH+1n5HK9yoxY7vUoPmLSXX76PJUX0m1UcHZKwNivYLoRQIMtSLtKWrA5L1S
	2g/OKXCHZQWu041Hivw2RjMv5uc5WWzVjgA3E65hWeg0/DuH6zJxSy95bWzoRR66mGXulY4eQPJ
	zictdcmuUhlXF+KD4Z2tauCZh4/r7rs+qI0zopr7EOgpC58FArAiOEsN8I5SCNytmWsNvAL2hXZ
	VHWmPKlBbA9LtP3oSgmCcO7uBHfpFq2vTy7Eo45uZue1CUCqx1oI/paRK03o=
X-Received: by 2002:a17:90b:384d:b0:38e:250b:122f with SMTP id 98e67ed59e1d1-39d9c1b4a9dmr22539956a91.16.1789316201854;
        Sun, 13 Sep 2026 09:16:41 -0700 (PDT)
X-Received: by 2002:a17:90b:384d:b0:38e:250b:122f with SMTP id 98e67ed59e1d1-39d9c1b4a9dmr22539898a91.16.1789316201400;
        Sun, 13 Sep 2026 09:16:41 -0700 (PDT)
Received: from u24-san1p10108.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba7a9bb56sm21932939eec.31.2026.09.13.09.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 09:16:40 -0700 (PDT)
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: virtio-dev@lists.linux.dev, stefanha@redhat.com, ebiggers@kernel.org
Cc: neeraj.soni@oss.qualcomm.com
Subject: [PATCH v3 1/2] virtio-blk: Add the control virtqueue
Date: Sun, 13 Sep 2026 09:16:14 -0700
Message-ID: <20260913161628.368484-2-linlin.zhang@oss.qualcomm.com>
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
X-Proofpoint-GUID: 4nN_zRi2A33ITdsJcpD44jnIfS4_88om
X-Proofpoint-ORIG-GUID: 4nN_zRi2A33ITdsJcpD44jnIfS4_88om
X-Authority-Analysis: v=2.4 cv=NelzRGD4 c=1 sm=1 tr=0 ts=6aa6cc6a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=gNhikE27diOJ3FV8mUYA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDIzMCBTYWx0ZWRfX7+M7rulVgHSo
 xy0aABHvCnm5OMhrys2LOC4s1Uxn1GNX5AowxJtQyqg2iEpOcpDSCRo4s1Kzy5Xy8zMXnX/tX2P
 3wgwmQc4QOYikaK7lOq0Oph5BUHpPjk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDIzMCBTYWx0ZWRfX1fJxGcsVTV9z
 4KZyUcN5lgVZY2gaxu8CyUK21okygiUclvI3df51PjG8nsifmI4hWOpBVof1NOhk94DRhi8AezR
 mIBO0YD9spMU8NoGmc+ZI6h9W28FCmDqy6QqsqA26P9cFT8J0tmoEVC4uyQWNkvMuFA8CHN7vPW
 J9ZWBS25CM6+FWHkayNG2DO+8F/+3IkN/xy019sUfG3QrXxRUvA+FI6xhy6SN9fTjarR5IgSR7y
 daJHyuApSOo7sm3rEIz9Sm54iXKqc7g1wLxxHAcJoUcuNBm2qnPRoOpH4oKKTGfToK/SUDGiJzX
 26yoGHvklg9k0CL9OH1wWyiR0GzskegFKdlptC9NKT3O8nUw5mjJa5F67n/2No1eCIjLF1ChF/M
 lz6BtnN9roHCcEBoqZe8Qac+9W2yxIjtgNnPDuUCHdHWaE9YqZHSblCvNrI2uIcGmP5/ilQYvIj
 ehXRVS6rJxO0GXRdDWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609130230

From: linlzhan <linlin.zhang@oss.qualcomm.com>

Add VIRTIO_BLK_F_CTRL_VQ to advertise control virtqueue support.

Define the control virtqueue location, driver queue discovery,
and common control request buffer layout. This provides a
standard framework for block-device control commands.

Signed-off-by: linlzhan <linlin.zhang@oss.qualcomm.com>
---
 device-types/blk/description.tex | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/device-types/blk/description.tex b/device-types/blk/description.tex
index 3b3a4e7..9bfdc4a 100644
--- a/device-types/blk/description.tex
+++ b/device-types/blk/description.tex
@@ -13,11 +13,16 @@ \subsection{Virtqueues}\label{sec:Device Types / Block Device / Virtqueues}
 \item[0] requestq1
 \item[\ldots]
 \item[N-1] requestqN
+\item[N] controlq, if VIRTIO_BLK_F_CTRL_VQ is negotiated
 \end{description}
 
  N=1 if VIRTIO_BLK_F_MQ is not negotiated, otherwise N is set by
  \field{num_queues}.
 
+If VIRTIO_BLK_F_CTRL_VQ is negotiated, the control virtqueue is appended
+after the request virtqueues. The control virtqueue is reserved for control
+requests defined by this specification.
+
 \subsection{Feature bits}\label{sec:Device Types / Block Device / Feature bits}
 
 \begin{description}
@@ -73,6 +78,8 @@ \subsection{Feature bits}\label{sec:Device Types / Block Device / Feature bits}
     VIRTIO_BLK_REQ_FLAG_OUT_FUA flag in the \field{flags} bitfield of the
     \field{virtio_blk_req} structure for VIRTIO_BLK_T_OUT requests.
 
+\item[VIRTIO_BLK_F_CTRL_VQ (22)] Device supports a control virtqueue.
+
 \end{description}
 
 \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Block Device / Feature bits / Legacy Interface: Feature bits}
@@ -274,6 +281,9 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
 \item If the VIRTIO_BLK_F_MQ feature is negotiated, \field{num_queues} field
     can be read to determine the number of queues.
 
+\item If the VIRTIO_BLK_F_CTRL_VQ feature is negotiated, the driver MUST
+    identify the control virtqueue as queue N, after all request virtqueues.
+
 \item If the VIRTIO_BLK_F_SECURE_ERASE feature is negotiated,
     \field{max_secure_erase_sectors} and \field{max_secure_erase_seg} can be read
     to determine the maximum secure erase sectors and maximum number of
@@ -327,6 +337,10 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
 The driver MUST NOT negotiate VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA without
 VIRTIO_BLK_F_REQ_FLAGS.
 
+If the VIRTIO_BLK_F_CTRL_VQ feature is negotiated, the driver MUST NOT submit
+any request to the control virtqueue unless the request is defined by this
+specification.
+
 \devicenormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
 
 Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it
@@ -454,6 +468,11 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
 };
 \end{lstlisting}
 
+Control virtqueue requests consist of a type field in an output buffer,
+followed by an optional command-specific output buffer, an optional
+command-specific input buffer, and a status byte in an input buffer. The
+type field and status byte MUST each be in their own buffer.
+
 The type of the request is either a read (VIRTIO_BLK_T_IN), a write
 (VIRTIO_BLK_T_OUT), a discard (VIRTIO_BLK_T_DISCARD), a write zeroes
 (VIRTIO_BLK_T_WRITE_ZEROES), a flush (VIRTIO_BLK_T_FLUSH), a get device ID
-- 
2.34.1

