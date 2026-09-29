Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9DB3D3481
	for <virtio-dev@lists.linux.dev>; Tue, 29 Sep 2026 04:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790655730; cv=none; b=EWh2xLqHeNvS53r0dYU6CHsy4xbOkRfxhDTaoCpaqXlDbJRg0oELoPp9uLTtpiilqxh/ZVas7ksX5y9cxGb2rg/cR8SNWotu0yPyyMskmiJHG9BM9RABaW2uI1fCumYh8azPm3FtqQ+11YmZd6k4JrXbGbLbZSpwQj0Nv+YOJ2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790655730; c=relaxed/simple;
	bh=yeuetNOxjUAJH3qGoKzMRD0t7wsH7ddWwMk0xLjcnLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AR9BQx2Fs3TBK8K0JrqAx19Y0v72v89JZuXj9sz2kv7fbaM6cZxx/d6k9Nczx/XI5l2P1rV7ruM7MugvhHNTQX7sWCKXIDZ247TmUC8judyw2uL+OuWxU1Aqf2nnUbTCjuxPbRx8AYAiXcudIMckrX2KFHnxE4UmLhBbDMcgQLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YoXxwMxo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UP//W26K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YoXxwMxo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UP//W26K"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T47LNV3241691
	for <virtio-dev@lists.linux.dev>; Tue, 29 Sep 2026 04:22:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=M0/OZtuhBzl
	jznLNet27lOAojzeIQCNRJVkqOfTcxlU=; b=YoXxwMxoYP+sp81/gARqX//N+VT
	yiIQbHcKsMna+tjqmbJJRj9dYly2Cz0Hwl67BRtdT8y6HuwHMHGJ3S+SNIe+LDdH
	PpYD1O5LV+n6T4afB1AAs1kVAO1REZqrCrbA30sMY9TVk1kgjB1oBSrAau6Yt1O2
	dHjVvY0DNfIo0rhXbGQ5CYNS5ax/CTwKf6ktRhgh2RqCg2wa6HY4NQ4SRPuEIxYX
	5IbAwoR8TKQEaG2SFLPkENbtXP6llbZM+JFNHKNQ1avBD09un9+GOmZfTW17QWSN
	bBfw2KhazrTUkEBKS1vRin2KXwZb+FM8LwLRTZhGGYlPZ0vXZmdNyox0CHg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0144s0yd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Tue, 29 Sep 2026 04:22:07 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30f1b904861so5407884eec.0
        for <virtio-dev@lists.linux.dev>; Mon, 28 Sep 2026 21:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790655727; x=1791260527; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M0/OZtuhBzljznLNet27lOAojzeIQCNRJVkqOfTcxlU=;
        b=UP//W26K5TvW2HJX0E5Sc0N7Mg6+38LnLC1Q3yb6pENeoP7ke2scjJBb4fhg23ETNy
         qXjsn8LR3vdw+qt1uGdQOvany1Vbz8gziLpTNvviacnSjEIYxxzTYPNaKETGA1mQ1RiV
         95NrNY7p/mrJ9Srac3rUbWlbAkRENQh/QPAMQJVhYSWPjfxSWUewiUjYicL4B+g7QPhH
         ScAtrJDJVZ6bbWs84oQh/9nQCFKgQZAvZxJU5DxoqsNShkcLWIX1C3+ua8QVcINf1LwH
         TJrTJNIYIXbhlMgiWf1zv5pTpBUZ/csKn0rsSDoSv6zTkT07AOt7iRT0lbCVTTieuW7q
         fmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790655727; x=1791260527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M0/OZtuhBzljznLNet27lOAojzeIQCNRJVkqOfTcxlU=;
        b=QYFq/KD6moeJt75Re8Ap5rYezXR/nWPrBQp9osd5UGDhUujGDOQC54eiW8n5TZ24oW
         uQKVbJEBCnaqZHFzCrTlnf4MYejkPsJ04CnABPZfVCD9cahh9ilND0ubtgkychQB+2ww
         fmowNJbZTRkQaX1DTL1DqJBKA1uttqTpnaM8QO4ebXjbB2JlTpNPmmvgeZ7RAtNqaVJk
         leRkZomLEjl+AENZmZM+dBScoita3IiUhGbOJUjj7moMjAQaE23b+zz9B0l7eVyqjo3j
         Q+CyZf7gSP3z5Zam672djOymQGRfWUOv3LFQnzNTB9pYdE+q3fwfUT78yi+yHOqyl0gF
         hTkg==
X-Gm-Message-State: AFq9FYLu3TJHgUtHq4oUno3IvSYO55qdUPJF2xD+0WrTrUMI96/nF3GQ
	EqdI9IaHFwKT4DU3fxZUkjJ/ltbGjES4fxBaQnYqq/2flXJ9q8XDX2uuN7ivL/w76QAujBwltu4
	fND1zrVhIoL22gPIxCDlEUl09Bv9tH49lRac2Hv+sdz3MedMQ2LqMB88KxTwbQm4fdNLIWtVWk7
	w=
X-Gm-Gg: AYBFou04dvbNA5QsEBIaUNEmXP+5qle3Sh3wCUjWJRT7obkpGy3S4NH7lIZ3hP3BzWb
	I1+AugTTbdEVS1y4PzgkcVtNjfa/jU1G4HGGEtlJcV8zyGxvbVBLeWvWXnjFNWZG/bGm0JaaPMo
	YmDRDry6esjHb6R2icWqBZxdKTJu7n9tFI+AoJJf680NKbosr+WyhMf/hTUr42NMz2IfTLaOKem
	f5WkYYM4wpuNF4RBXod10+t5g+XJV3IAxtxUFUxnnegRV3slJC50huziRmdJZAl04jmAHGaVD2o
	0bCl7Z0d0EnjsxgAhCndp8ajOuAJqEdD2be/2qTs6R+82nnoO5WxHmWYJNirwuctlHLZ2vCN8Fc
	FaUVhibObRaR0IZs7S8HeAcmMLzjWiPk8VxzUKBvJ5goImd9NAItVklfnj6U=
X-Received: by 2002:a05:7301:438a:b0:34a:dfa6:a9f0 with SMTP id 5a478bee46e88-34adfa6adc9mr2049556eec.5.1790655725882;
        Mon, 28 Sep 2026 21:22:05 -0700 (PDT)
X-Received: by 2002:a05:7301:438a:b0:34a:dfa6:a9f0 with SMTP id 5a478bee46e88-34adfa6adc9mr2049524eec.5.1790655725215;
        Mon, 28 Sep 2026 21:22:05 -0700 (PDT)
Received: from u24-san1p10108.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-341459234a1sm31172149eec.24.2026.09.28.21.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 21:22:04 -0700 (PDT)
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: virtio-dev@lists.linux.dev, stefanha@redhat.com, ebiggers@kernel.org
Cc: neeraj.soni@oss.qualcomm.com
Subject: [PATCH v5 1/2] virtio-blk: Add the control virtqueue
Date: Mon, 28 Sep 2026 21:21:39 -0700
Message-ID: <20260929042152.4099414-2-linlin.zhang@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfX1B1i92ioHifL
 QY/5R84YljvNFxGuxElFuxSuxBkpK7kF3DmVc7WHhyB5urKYGdJ6/DEkwi/9264h+5VFMhy0q/i
 YDytUf6KuTl0A//3VMYXiUc1mwAg1B3XUifXFJNXUflTVdFlHTasF+78a+ZbzzW4Jo0O11hlJ+G
 LUn2DbEuLZL4Rxt3muYHF5gnxsWXnkt+LtRLLyYkoFW8gn8umwq2tu/TerkSe6yUUhn4Ve/kVSj
 x0/dkSAh6ZaYFXgq2YGzKLZ1j8jtxK0Y9lW5FI8NinkSbYfXy/LMgCnnfc5MT0YSI8FtR4NMeSf
 SmBcUfoUphz0gjWmV7G4jUEEtRiudHNFCIQtnNJW1yTvLaaXzs0qKVVv8YdCLvu0PpJ3wNiIFhf
 XeO1k2y1aM/8MuYhGEvLqMofaxyyNu0Dq8iPnZN27IwBGMz63TzXL+78X4JS3HTgnbYKJ6kfr3U
 LTIY2IMGBragm/IWTyA==
X-Authority-Analysis: v=2.4 cv=FJSOVOos c=1 sm=1 tr=0 ts=6abb3cef cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=IQmPwkyYz_jVs6FnuecA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: NRaOdXeMqYmnKFlyOK0JcmdwiWyXqIxN
X-Proofpoint-GUID: NRaOdXeMqYmnKFlyOK0JcmdwiWyXqIxN
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfXy+nv4wEZM7OQ
 zFYRfKmQ2+AmEEKMNzSf3PNoLkoZ7t6EMbBZWwRvNq+/i5wkP7+8u591E8Ha8l1zQZSM74Yxtv5
 hR3ktUta+1HLEKTRgemsBbKa+uiNdo8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290017

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
index 3b3a4e7..ed4c612 100644
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
 
+\item[VIRTIO_BLK_F_CTRL_VQ (20)] Device supports a control virtqueue.
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

