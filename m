Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA463D3481
	for <virtio-dev@lists.linux.dev>; Tue, 29 Sep 2026 04:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790655727; cv=none; b=KWx8LRPKVeWdclZ40nNxYEspLO2b62KpnppyiYe6uz4hAp7ElLEmWPGhUqsrnpjTv9X5JGqD4yOSfCxUNPM5aBh1zG9PDFmzR5WujPxcpTET1dRQt+Xp3ldWj/NnAvYQKozAvxr2DkiiMEppiwTuqUo4wRTeagSfnnLP+uHpJ2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790655727; c=relaxed/simple;
	bh=nvg2WciAqYEVW5uNmJpOZY9oEVfvERMZLzbGfekuhJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GuPEz/EIE2xV1R0moTRlTlo+WymkWVSFYf/jzEq2Mn0ZdU43CKovFtMsZpDnbZaPuYk4dWNUGUHo1igUTUzQeDA3JUU08+eeHbdJ1hZGCtWgVqF+eK/0V74uur7a/WWf+UFTRryZtLaRChjzHfg36Bp5PqDCtDNYbN6PRwESsqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eIYP/7My; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SNEJ/bXa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eIYP/7My";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SNEJ/bXa"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T47GUO3643289
	for <virtio-dev@lists.linux.dev>; Tue, 29 Sep 2026 04:22:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=vpvW6mVGQzKu/FaCFsLekr2i/X4qljUaS93
	0dRjj9pY=; b=eIYP/7Myn2hVoe7Yf2oLOVUX0/GUHS6obku/HxHuGtDJAQZ4mX5
	izN4BSQDCi0hJ8+P5Xn2aMlfUXm5zXp57VwFjIMYbn8VLhVZBlK1nLIgwdTzbpcB
	eHWQdpDI39ofwh6tEi5onaSPkym05yosiGBIV9ZcShFdfRPVOlZSHy2RigjJmp0s
	Adn0AqHqFCSUQ+Ri6rXZ7m+ZLN+C5hyNvvhBjnDRfZIONCNlNNGq25h9zCz01oPP
	ihnssB7k98zEhxYk++QASotqMlAmDUC2NQXkkEjRU9Zap9XBpvvUCD2M9JPnCsVx
	7qbaeVhPbZDRjrBPFgM2A37+hqAKw3vMpdA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h00s4s3rb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Tue, 29 Sep 2026 04:22:05 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-34afa104860so649210eec.1
        for <virtio-dev@lists.linux.dev>; Mon, 28 Sep 2026 21:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790655725; x=1791260525; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vpvW6mVGQzKu/FaCFsLekr2i/X4qljUaS930dRjj9pY=;
        b=SNEJ/bXaQhQBaIoDqFpYnCb0VL3h9W9J8Y9D51GUBtwhI2A550HeaJUyxQNNwJsJ14
         bCTPyNN/Ih83fntEgoc/zbiNF1QE0am2ni+Xhc/8bORyq96R1pFE/wak5lmLNyqDO30u
         bVH7ftdwOJhOThsCPBx+zUwoN5Gsny3F/uVZUupxX4MFSlB97BIGmYoalUEfLqmexuRj
         Yit/zQSyM3qcIeaZb6R70PlHT2HqJB4qemmIkeqx+oMLjeYCpVaaYYXE6GIk8T3xU97k
         BHyKBi62pJJbOljluNbfxKdGePfPLBlRyiCHr4PxOPHKEvz1Kx5oFpM5wP6pn7xxjdtC
         bIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790655725; x=1791260525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vpvW6mVGQzKu/FaCFsLekr2i/X4qljUaS930dRjj9pY=;
        b=aAoVfQ08gYVcp9PXStuyQu6BQ9F3HQosXzJgan2d1FdL3HJYy5l8P57FAc1s5SAkDa
         ra0x1VvYFx901LqAajbj15eiJxUJmM04pveI0iy0WxmlUocFFcSS+0fReAmTXXgTjToa
         5Zhxc1eGKyTPRY8VZekDDrW451fo4/TUb1H9F/nM4PJdd8MdM5fwgr4eXBoiredlrgaM
         ybGoxTBV5btTMnKBg04Pw+KuziPPewwNBqL9WvAGU8Z6KqCSoYxvr/Cyq8YSDMkU4V9S
         ajaeBfYDznKc8zB8lrJyLu5qnOpt2W1nwTb7n9i0IbEgYLBqJC4uxAtMDYaf9TSEPjje
         eXlQ==
X-Gm-Message-State: AFq9FYJBHoyOgx/fqrTKJ7ncJ42HIj8D1wAymVR3yKwj3nARISAVrJ6+
	dIrHBbyIurGuvDCuuOZK4BR1d/ISKgUQgd9294UdkX/u1ioW9g1RYNFDy1vN5LaAcQBcRDoQ4SL
	W6LkCjMoDdNfP0S1liPRKw99TcngQhb+10JzL/wxJnafKbe1tWI+LFTQXr3sGd7Di/zeMHR+miO
	s=
X-Gm-Gg: AYBFou3QDcves0wDuNgFhpPH+aPz2rpqKQepB2GYUgprGMihcMB1z44SkjbDMHdvEY0
	1HWtQKCwaqpkI+peBaCusCN87tJbFmHI6dXtnPSWvPnsJZPKbWwEip3gUWSxk1SfKg9Cx/wUXpa
	qQpi4CHMCv9JzFL7wljhNRPxvZnxlGgRHdrduFU+DBkXwZhoe/S+fICoEw16WeeZO7CTKMPuxBK
	lqC8IxXeTuCbJesLToZ6C0dyDYEtdRQoXJh3BlcU1NT67QsCOE1tAEx0YP4K5e2uoTynzRpwD3q
	BM3w/8s5tmNlxPUAY9bzd27r+wSNIdB+d7DYRD60dvQ3wlsD07vi/2YGqA3zR0t+8Bx7y8Ejtsb
	FDuXE80tl3BQFQ0ISGzZdpSW13ZDB+dJ0YaGfsU6548eKVqlBLy4Lccj6UtM=
X-Received: by 2002:a05:693c:8802:20b0:34a:48ce:b687 with SMTP id 5a478bee46e88-34a48cec2bbmr3524443eec.32.1790655724667;
        Mon, 28 Sep 2026 21:22:04 -0700 (PDT)
X-Received: by 2002:a05:693c:8802:20b0:34a:48ce:b687 with SMTP id 5a478bee46e88-34a48cec2bbmr3524417eec.32.1790655724076;
        Mon, 28 Sep 2026 21:22:04 -0700 (PDT)
Received: from u24-san1p10108.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-341459234a1sm31172149eec.24.2026.09.28.21.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 21:22:03 -0700 (PDT)
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: virtio-dev@lists.linux.dev, stefanha@redhat.com, ebiggers@kernel.org
Cc: neeraj.soni@oss.qualcomm.com
Subject: [PATCH v5 0/2] Add inline encryption support
Date: Mon, 28 Sep 2026 21:21:38 -0700
Message-ID: <20260929042152.4099414-1-linlin.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfX3D/5+xA7hN8E
 A+R2tEJfgc1V861xGpAeuefKMpwY8tedc/lTCCVshWBT1Hp2iPu+Vj9jy4/TN5HFsUp3i1u570P
 NMdPjbF5L+uMAzS1D8blCrwg/kRBOmI=
X-Authority-Analysis: v=2.4 cv=ALbfqNVA c=1 sm=1 tr=0 ts=6abb3ced cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=lOd02TdZT948iX-3dRMA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfX7KwUVE9ZUnQZ
 6q3HXLwPVB/YRK2kEhHqui4rwH4CvO7Q1I/UEBOal0f++pKX39G3z1iUqYs1Tl6SAnY2494QliH
 Ip0BplrPSfhhasO1hrcUrJREjthFY/MfJwWIHmGhNtcsNaPE1MrXqvbJBZ9W2Tf2jyMSF5gv9N5
 K5akCgZ1kA/qfDDu79aBZiyvNZuU+6CpXH+9yWdMGjVHZ300kYYswFKJMI8mTiN6Vehl+8CJ7yc
 /WC/Ffgglt89uBUdrJflz5Piy13SCE1HGxkCd9qAF5/1sbfOyXjXtoiM/p/5nxMnCY724KNi6SK
 KyI8AA9glKlWnp6CXjpCG93bu2HFhgsJzbesQDrJBwahsh346W0Grl2vd0EQUU3yQ9TPdT0/Z56
 DrbDnAIqVg0mCbMPphC0kxM0IXX5hZn6SReaen5t0w2/CPzOQQJW3Amk9JrAhknbv1XOT8hcS4m
 mt6OVSckMdUwTfN1J0A==
X-Proofpoint-GUID: zkmpGX6zDxHk-6a_pqEi9wImVR_idW6F
X-Proofpoint-ORIG-GUID: zkmpGX6zDxHk-6a_pqEi9wImVR_idW6F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290017

From: linlzhan <linlin.zhang@oss.qualcomm.com>

This series adds virtio-blk inline encryption support for devices backed
by storage hardware with an inline crypto engine.

The protocol exposes device capabilities such as keyslot count, maximum
DUN size, and supported key types. Encrypted requests identify a
provisioned keyslot and carry a 256-bit DUN. Key management and crypto
capability discovery use the block device control virtqueue.

The control virtqueue is defined as a generic framework so that its
buffer layout and queue placement are independent of any particular
control command. Inline encryption then builds on this framework with
explicit crypto command formats, capability validation, and keyslot
state semantics.

All key related operatios are handled in the control virtqueue, and
the crypto I/O request is handled in the request queue.

For background on inline encryption in UFS and eMMC storage, see:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/block/inline-encryption.rst

changes in v5
 - Change feature bit value of VIRTIO_BLK_F_CTRL_VQ and
   VIRTIO_BLK_F_INLINE_ENCRYPTION to 20 and 21 respectively

changes in v4
 - Add a control virtqueue specific subsection for virtio block
 - Move all control virtqueue request related to this new subsection
 - Add the precise semantics, error codes, etc for the new control
   virtqueue commands
 - Move 'MUST' to the normative section
 - Use c struct to describe control virtqueue request

changes in v3:
 - Add a control virtqueue
 - Move key program/evict/derive_sw_secret/generate/prepare/import to
   the control virtqueue
 - Add the driver and device requirements for the request in the control
   virtqueue
 - Extend DUN in crypto message to a fixed four-element array of 64-bit
   fields 

changes in v2:
 - Revmove virtualization-specific terminology
 - Move MUST sentence to the device/driver normative section
 - Add explicit rejection for CRYPTO request if IE feature bit
   isn't negociated
 - Modify the support list of crypto modes and the definition of
   the size of the crypto modes buffer
---

linlzhan (2):
  virtio-blk: Add the control virtqueue
  virtio-blk: Add inline encryption support

 device-types/blk/description.tex        | 619 +++++++++++++++++++++++-
 device-types/blk/device-conformance.tex |   1 +
 device-types/blk/driver-conformance.tex |   1 +
 3 files changed, 612 insertions(+), 9 deletions(-)

-- 
2.34.1

