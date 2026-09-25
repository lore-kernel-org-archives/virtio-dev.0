Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6697353A6F
	for <virtio-dev@lists.linux.dev>; Fri, 25 Sep 2026 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790344914; cv=none; b=e9KAOCA6V92ujxgKkSpDW2TRPXtOpqeAwRAXLyBYivIbGIKmT5fD2O9yjdrOACQFP3Gu0cJ4Bthhh2FKgkIgNPSRKafAiqgvi6muOPi74RFU0qsQtrBoVuG/3uNIe+rIkSFKTCaDytlWL1ePMx1MxvujcvivnU1kNiK9Ep5L1o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790344914; c=relaxed/simple;
	bh=QdsY8gxuwrKYWyTm033BXFvlA2QowgtDv08N97umfME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mx5NR0+HqIinti7emp/1Hn1MI9XUHGelnaXzINgMOHr4R+SWhg/ShwBLA31W5WeavRb1S3mCwVgDJpGxttqM5q1q77uufaoRefMtNVInop6Bb7kkkeUbtijrOvIvfLZFdPpvHKJpeS/Lg8fyrJ0Y7C7PllBrHZzsUWiHt5Gigho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ncxX/oKw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MjrXRmC+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ncxX/oKw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MjrXRmC+"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PBV8XI425742
	for <virtio-dev@lists.linux.dev>; Fri, 25 Sep 2026 14:01:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=tzoEs9Dl4TB
	IiBOk5kPscAomWsPycc8Me1dwMa8FyRo=; b=ncxX/oKwZIhQIVbbE5VaPxF4dtt
	VxOw1Ru4+NzLWK2KlVil7GB6XQsM2EDvd4HA/g8l5H5Nuehd8pXmu1BZlHzRVl75
	v5JtRLfItQYwXKdmB0Syik/7ZEPe3rB6iGBBsf74pAusDLbI6MsAJQohKvy9N8Ma
	7SOG5Q5or43XBJOVFrbt/3fjh2wtLXYixbKQG1K8YHBQTbIgId5iUKIqd5/3EJTq
	79VtZoYlbw4u6S3qbzcggEiOIXpm5o7pZQs5dY/TT+n5mJegrcHOWQUUwka8xO6c
	ioPEjPakG0xnRyjKLAXXOYXGi5IQzPsIVNvqfeF+dloCKHLM6qGAsEfca6g==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwr5e8fvj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Fri, 25 Sep 2026 14:01:49 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-81eddfe28b4so14788817b3.3
        for <virtio-dev@lists.linux.dev>; Fri, 25 Sep 2026 07:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790344909; x=1790949709; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tzoEs9Dl4TBIiBOk5kPscAomWsPycc8Me1dwMa8FyRo=;
        b=MjrXRmC+wBfxOiAd7mrPE9zWXeG6eVZ+x49eiihqF0xJlOxzE0sbGA0i5t5n06W35V
         FjM3wN/Ir1LLoIo6zp3oP4xQxhhWWwLK+vTVrWcq6Zo75Wsal8mW5ebJg44YNxwXTtSE
         6HHokFyQ5Y3ya1VLM/3HW+a/PQmqA9Cpsg0AQSmlElNT0tIBvpytO5Yb/FXWGjNr+44F
         9XgkAwWlvT5KMqME/NYm2aMieehXYP+1HVY/81K092djPpQdXn1n2zpMTZzIVR0G7f4R
         Tczm+ccTXq9TIG6/JPPK0/GsKWFmdhYJN5nJVVG94Akwb5uoe8IpIszVOl/SOVWHjJfh
         2QUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790344909; x=1790949709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tzoEs9Dl4TBIiBOk5kPscAomWsPycc8Me1dwMa8FyRo=;
        b=yaUT2FTYCAx2q0vdntGlel6e1RXTx386Aownih3tRZ3YO8WN6E9MPBKp5VB1bqoDkj
         CBLHg3jC/pk3+jeUbGAo4QI7ESi4A/VQsvUNkeLfBLlGZeEcA34IqbntAJyJz3iMeOl1
         GSqfBX5aE5n28AKmEZ/W9qyrEXpd7So5mM2ImthiWn4bOMz/INaIwncSNcJFy/0PIXyl
         pVYQgYpzt1fYNEJRgukp2QOrK/CDkGxQBCHNzaBzvnuH2WCP5Vr1yoDxSObpTrQVEFlZ
         3n08B8fZlAZIr45JWw47wMywYOhtLdpQtWe+8n6fAA/gsMNT+gWMB1X/+TMAd9z56pga
         EFiw==
X-Gm-Message-State: AFuF++lSG93ob62stZVlvB3ieIZuA9yuhbnyEr5biGdzNNAUVxUnuNkH
	DBM/E9s+oxpsnDlA0buWjzlRauy1O1w+pOl9PFa1puIAupVcPTuXEO/y1Z7wgQEN7yr5OmdCNyq
	7dd7WpRwEadP6QuCeDmv/AtjJwrMWKnmHViAWYeBs5QRGRZGAHNoDSXaVHGSEIZ9HvHi8Z9xtHA
	E=
X-Gm-Gg: AYBFou0C5zI+Fwl/BRqFew6aD+t1Ao5BeOPY2wojwixy1HNgwAIGxMPJp04/sH1oPIj
	1Rh9aPIUxJGcWJedPJrU9C6RLhWkluQYQssQl+Olx4iutwI9stz2XYCKmccL/M+RLd6o4V8Nafx
	6Gh4EVK0q3WjEAS3QgjscRAM7QbbDL85VCIlCps88GHMeJ3ny0BqX/C5yN2BGWudbN9d3rata75
	t+D5CFwBYzPjr7mmINjWsX4/4uZ1qDrlzv7YE+wI3aFY+YMSRAxRLvf7gRDBZjQoVPJJyEbwRQp
	8LFk4Fbc9Yp7woADpiWdkUtCmoS4AEDWzJ9u6dpaiMMf1UK06WQy5FRaYSeLekd9046sEXjn/p2
	4y3UAkT6on5OlgvUUzDAhk+Xd6EFMIoDtZtw0XAp0l2RK+gXRzeUWvk/t5g==
X-Received: by 2002:a05:690c:c4e8:b0:8a8:633e:97c4 with SMTP id 00721157ae682-8a8633eb690mr11852157b3.19.1790344908801;
        Fri, 25 Sep 2026 07:01:48 -0700 (PDT)
X-Received: by 2002:a05:690c:c4e8:b0:8a8:633e:97c4 with SMTP id 00721157ae682-8a8633eb690mr11851567b3.19.1790344908148;
        Fri, 25 Sep 2026 07:01:48 -0700 (PDT)
Received: from u24-san1p10108.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a860f85e57sm8439937b3.19.2026.09.25.07.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 07:01:47 -0700 (PDT)
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: virtio-dev@lists.linux.dev, stefanha@redhat.com, ebiggers@kernel.org
Cc: neeraj.soni@oss.qualcomm.com
Subject: [PATCH v4 1/2] virtio-blk: Add the control virtqueue
Date: Fri, 25 Sep 2026 07:01:20 -0700
Message-ID: <20260925140133.1214443-2-linlin.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925140133.1214443-1-linlin.zhang@oss.qualcomm.com>
References: <20260925140133.1214443-1-linlin.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: TzRLcM7T7TlVWsSUfB5redSmuZVhYrHh
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1NSBTYWx0ZWRfX5nm+xibWoon2
 0jMEU75hsDgGCO1F/Gzfy2CHp1x5DFJ2x6bSlltV0ZBvKQkwyX61wEV2/iNVHLoBIW4FSd51JV0
 fEcelzDHBiXkLMopWnQ1mDGS3OMeUfA=
X-Authority-Analysis: v=2.4 cv=Hf2B3SE8 c=1 sm=1 tr=0 ts=6ab67ecd cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=IQmPwkyYz_jVs6FnuecA:9 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1NSBTYWx0ZWRfX1Ti2b9IKP9ER
 DvuZI3U0asiWb+2aVumE9oIMiIpZEBYMhM2IghxcBXRi6tlEc4mgJ6jMNIuXvXzJzn3hVYUy+y7
 z2oeJPlBR0P0gIXbjYqQbsf5NT4uLid5NWc7XG5hJtu0FlCEIUfV/hC/QYWVL55fRfwF+HuS8bM
 kdEDabGAQQed0MgSqzQrCb415X+kNU1KV5tRXqx3AUWdgqSauXxBZ6QhQHBGt12EArSb6w8UWJ+
 nvV/spZGAbVQ2shtko6+7/yOHKdlsO7Jx9pqeNc8aqi7v95srUinkiYcHwYl6dwub7sCBQyT2dt
 KlQFATJEdRAGojzlTI1jTyfxiCUIOZk0eoc5r+tCT7pa+t7Qfgsr54Nfmu6xiy/vUc/jfOEjjXK
 yW2TZ3OxmssXtdBP27DaOhuqdsmiMg==
X-Proofpoint-GUID: TzRLcM7T7TlVWsSUfB5redSmuZVhYrHh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250055

From: linlzhan <linlin.zhang@oss.qualcomm.com>

Add VIRTIO_BLK_F_CTRL_VQ to advertise control virtqueue support.

Define the control virtqueue location, driver queue discovery,
and common control request buffer layout. This provides a
standard framework for block-device control commands.

Signed-off-by: linlzhan <linlin.zhang@oss.qualcomm.com>
---
 device-types/blk/description.tex        | 67 +++++++++++++++++++++++++
 device-types/blk/device-conformance.tex |  1 +
 device-types/blk/driver-conformance.tex |  1 +
 3 files changed, 69 insertions(+)

diff --git a/device-types/blk/description.tex b/device-types/blk/description.tex
index 3b3a4e7..2d75b35 100644
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
@@ -1225,6 +1235,63 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
 handles VIRTIO_BLK_T_ZONE_RESET request for the zone range specified in the
 VIRTIO_BLK_T_SECURE_ERASE request.
 
+\subsubsection{Control Virtqueue: Device Operation}\label{sec:Device Types / Block Device / Device Operation / Control Virtqueue: Device Operation}
+The driver uses the control virtqueue (if VIRTIO_BLK_F_CTRL_VQ is negotiated)
+to send control commands to the device.
+
+The device MUST return a status code as part of the control command result:
+either VIRTIO_BLK_S_OK for success, VIRTIO_BLK_S_IOERR for a device or driver
+error, or VIRTIO_BLK_S_UNSUPP for a request that is unsupported by the
+device.
+
+A control virtqueue request is composed of up to four separate buffers: a
+\field{type} field in an output buffer, an optional command-specific
+output buffer, an optional command-specific input buffer, and a
+\field{status} field in an input buffer. The \field{type} field and
+\field{status} field MUST each be in their own buffer, distinct from any
+command-specific buffer.
+
+All control commands are of the following form:
+\begin{lstlisting}
+struct virtio_blk_ctrl {
+        /* Device-readable part */
+
+        le32 type;
+
+        /* Command-specific, see below. */
+        u8 cmd_specific_out[cmd_specific_out_len];
+
+        /* Device-writable part */
+
+        /* Command-specific, see below. */
+        u8 cmd_specific_in[cmd_specific_in_len];
+
+        u8 status;
+};
+\end{lstlisting}
+
+\field{type} identifies the control command being requested.
+
+\field{status} uses the same status values as I/O requests (for
+example VIRTIO_BLK_S_OK, VIRTIO_BLK_S_IOERR, VIRTIO_BLK_S_UNSUPP).
+
+\field{cmd_specific_out_len} and \field{cmd_specific_in_len} depend on
+\field{type}, and are zero if the command specified by \field{type} has no
+command-specific output or input buffer respectively.
+
+\drivernormative{\paragraph}{Control Virtqueue}{Device Types / Block Device / Device Operation / Control Virtqueue: Device Operation}
+
+The driver MUST NOT set \field{type} to a value that does not correspond to
+a control command defined by this specification, or to a control command
+whose corresponding feature has not been negotiated with the device.
+
+\devicenormative{\paragraph}{Control Virtqueue}{Device Types / Block Device / Device Operation / Control Virtqueue: Device Operation}
+
+The device MUST complete a control virtqueue request with VIRTIO_BLK_S_UNSUPP
+status if it does not recognize the value of \field{type}, or if that
+control command corresponds to a feature that has not been negotiated with
+the driver.
+
 \subsubsection{Legacy Interface: Device Operation}\label{sec:Device Types / Block Device / Device Operation / Legacy Interface: Device Operation}
 When using the legacy interface, transitional devices and drivers
 MUST format the fields in struct virtio_blk_req
diff --git a/device-types/blk/device-conformance.tex b/device-types/blk/device-conformance.tex
index b4fbc8b..55016e9 100644
--- a/device-types/blk/device-conformance.tex
+++ b/device-types/blk/device-conformance.tex
@@ -5,4 +5,5 @@
 \begin{itemize}
 \item \ref{devicenormative:Device Types / Block Device / Device Initialization}
 \item \ref{devicenormative:Device Types / Block Device / Device Operation}
+\item \ref{devicenormative:Device Types / Block Device / Device Operation / Control Virtqueue: Device Operation}
 \end{itemize}
diff --git a/device-types/blk/driver-conformance.tex b/device-types/blk/driver-conformance.tex
index 0f69866..e2d0753 100644
--- a/device-types/blk/driver-conformance.tex
+++ b/device-types/blk/driver-conformance.tex
@@ -5,4 +5,5 @@
 \begin{itemize}
 \item \ref{drivernormative:Device Types / Block Device / Device Initialization}
 \item \ref{drivernormative:Device Types / Block Device / Device Operation}
+\item \ref{drivernormative:Device Types / Block Device / Device Operation / Control Virtqueue: Device Operation}
 \end{itemize}
-- 
2.34.1

