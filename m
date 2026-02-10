Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA0917ADE0
	for <virtio-dev@lists.linux.dev>; Tue, 10 Feb 2026 08:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770712337; cv=none; b=UZDhfZ7DVz3QSUdx3Hnr2fniCjSmmY/N32M22XO5e570S3E3jAOcWjpwbAjw6iZjih5lqva2ZoXZfSjm4lC76UZnonWfSmpMbG0ygFnvrAxLRB70sqJQ3Ay/t1CGb5l66z8X21hYFK5KqJ+qSkEKVR/pBCHgUNn0es4j5s4zxUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770712337; c=relaxed/simple;
	bh=XVfV7feDHbwQTs1lbQrqO+KdSyY+YG/C+2bNFOVspms=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lYonHtrJFLykUtEDsN5Uk9cMgjXwT5mDSrYdHJiVqAc5sUdTaJV99ZmvTQ3hjEp/KkPx3rwvG4iJyQRkwmzG0l3n0QQgD6PKjHKDGglzv6s/Ty8i6bjW6MTe+kq0jwoj9lq4x5mzDxOZ9F3HbIEK05I1H0uNR/A3nz51ZSKAJCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yzmc7ZK3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Rt0lfecA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yzmc7ZK3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rt0lfecA"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61A53lVZ801157
	for <virtio-dev@lists.linux.dev>; Tue, 10 Feb 2026 08:32:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=n28Atd13GP2c5waRhIof69dwnktUnVUOy0n
	lqB/VYsU=; b=Yzmc7ZK34QWL2+eTPFjxBZSCXoz5TxpXc+AAsT76duffaTbtCKm
	5tmkkMM4ZIillsacU6wTnzhABPAsv532zbIvxIyt/KWmlnX7x+9YR6mGauBgw9FW
	7TyGPjUVIvypYpFvYZ7tdWLJtoBUkcMdzdh8X+2Xq6yR9KTfVa3jIZAN1tgXs8GL
	2YIy7PRinRw+u3EM7o/Qfp7BW8AeWXU2W2zmdSFj60GWXrSy0Go3NzOKN0DDfqVS
	Yzq2T/0bp8UtPrzjPdoV2vM1UqmUTKNrbDc3Xbw6lZNfWp25IvqcoVUO1Gdo10en
	EVrE6JK9jBjvE5tn6BmfNLyUrh8Rni8Ilbw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7x6u0n6n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Tue, 10 Feb 2026 08:32:15 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-126e8ee6227so565367c88.0
        for <virtio-dev@lists.linux.dev>; Tue, 10 Feb 2026 00:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770712334; x=1771317134; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n28Atd13GP2c5waRhIof69dwnktUnVUOy0nlqB/VYsU=;
        b=Rt0lfecAvEQ39lk4UUn20qGSCStP8k+HBDVOVf2QIOr9U+EWL4O0glQp2RRgu5ksij
         RX57SEI1kBq2U7OvIpEIH9h/5D57OJkciDjWY0TSWfu3cY4NmVwfM3Sxt7udybRQz6OT
         JDOjHc6x68TMpjyGqWM2p7xstXKOqypIqNsTUojyrjQEgAz9W/0o8VhFSRCLpwhWkwNK
         xFXvL9Zhx997Dmo7xi+z64SZxslndEI5QrgZeBEXxB/4y0Zb9gEgt6hArBUKYritlYtB
         aw9DjJQBVPiY/AZb2WtWbVJPUie9Ah+erZ5ddYuSE58J5Mve0XUt9ksZuNJc2ZVaBfAQ
         QqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770712334; x=1771317134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n28Atd13GP2c5waRhIof69dwnktUnVUOy0nlqB/VYsU=;
        b=tJejLSwCxoKTyb1+4YffXykm//D5IkODZMqhpcyMQ3gfpcRCDq5CnT6N3rLRFgodKF
         sFnwgE/dckI8J0fkCjY/SVckpgGbOxKuBMExMB5Uh0dGE1HU/hvSF4zVBYR4dK706AxM
         /PBad4jC9LDGpgv0P7feiWo0d6YbLAUKbRLWzcJE/1MMOTkFXM6Z1yyl2T/nXod59ugZ
         Mm9O3/koxTPxFTo019KN/OnggYNN5CXTIcfVTOMP1m9i0Mct3WNS1Geeq8kAuzAeF7Ml
         seIeuLT8f8jXM007s6A3iNpk6uwWwhJeeCvyJcc98cQfA1USlaETlxt/xwoRk7aHc/XT
         YzFQ==
X-Gm-Message-State: AOJu0YwNFzLks/ab6xEfT9wp6jecwyB2ETVAo5l8k0zlySBBGyQdK8TF
	9PJzzWtaY8VuTPNAExwWzP15WOgHDEO5oXPaQO05RfMfRZXYnYgQgJk5+16XjNnlG00NwMkrPn0
	a+ilgbjYMOPkm3vBG9V7yPiB/uB54lZ37XVkk5rvIMgXRqrZFD2ApGtW4rb4dtUjLuk5iLzaIDL
	g=
X-Gm-Gg: AZuq6aJVH6P5Vf+ynEdnnw7/G+K4s1BOsxN2ogLFNvzRzJI7RC94Rjd3ooAxMAinlFK
	wlKo09J3Aop69APGBIZjTipPL/EUiiw3gM7N8I7pqq8hpzeHwLDLgExgmzeW53Kiv1zoYeEKewV
	3w9Vr7dz0M0J8NOIVVc3BWoElTyv83GALPHiBIy/Z2N/sapQQynGKMTkHDtoQElb9bzUYIBuA8W
	jfD5MQItix+ismuE4SnVMtvnZqqrMmP6DzPhwzSAKIi8zKYri2CnVTKqQpElx8FLf6RFGUN3j6A
	kI/ckx4hT8xGr+fEoQ2ntFdmbHYouJVig9eoxX+kfiWTN1Bs3ricfKl9H3WcqRWDAKiLrHkWSW0
	if2kx+ZLPpR4WV9j3ctTzzEfCQA7F1eW4nK+zfrNP7qPlf4pSNUARNtRdwENYI7z7eKCYmdNyZh
	Hjeong
X-Received: by 2002:a05:7022:4591:b0:11b:9386:a386 with SMTP id a92af1059eb24-12704096c8emr7038877c88.41.1770712333661;
        Tue, 10 Feb 2026 00:32:13 -0800 (PST)
X-Received: by 2002:a05:7022:4591:b0:11b:9386:a386 with SMTP id a92af1059eb24-12704096c8emr7038868c88.41.1770712333123;
        Tue, 10 Feb 2026 00:32:13 -0800 (PST)
Received: from u20-san1p10573.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1270414f28bsm11580570c88.0.2026.02.10.00.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 00:32:12 -0800 (PST)
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: virtio-dev@lists.linux.dev, stefanha@redhat.com
Cc: quic_dshaikhu@quicinc.com
Subject: [PATCH v2 0/1] Virtio block adds inline encryption support
Date: Tue, 10 Feb 2026 00:32:07 -0800
Message-Id: <20260210083208.472824-1-linlin.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: VT3Ar2Qf7JLpyDVJ4ec246EjZZuTKmji
X-Proofpoint-ORIG-GUID: VT3Ar2Qf7JLpyDVJ4ec246EjZZuTKmji
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDA3MSBTYWx0ZWRfXzE+StBxhZ1cj
 uXLv5sJwVH/+mpPodvyvxh87MwOR0HKbQboxGnFfG7tX8rIubEGa/PSTtihoePdL/1lSO9Gcjci
 GCsm89kTiTNAT4p9i3TuXKY4SmJhUL/zfGbKD7BIWRDOnhsboR/L/eDLswSNzeCyZWe6IciQFiF
 A7dT9AXIwqu9UmtBQgcl4+bkz1wuailCridTYg7aJhgFPtD01Sba48+vX7kcswrImx2UPWodHRO
 7A0L/mI97jSaHNArmalJYXTNYhLRNgDHqUnSGc+rVUxeObVNKR1YlvUrFNtyt/Rc4SE7gTCopzW
 bAbD9wxgPVida5PiX4ikfshHUVTpU1Fi6Geu26MLAsY7gL0lkzVFtHKpjwZ11odY4t48Sm3ITQX
 Rrh3IlXmO6GJK8wumnwKvwjPMTr/yleUgyTLGbpdrJcwZ+qXC+ZYtVdu+AQwSoiTnaW6Vrap8mL
 zzVqw1DrU9mlMnDCTZw==
X-Authority-Analysis: v=2.4 cv=YfmwJgRf c=1 sm=1 tr=0 ts=698aed0f cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=OyG1xUQrl2GFGyBWuDsA:9 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100071

From: "linlin.zhang@oss.qualcomm.com" <linlin.zhang@oss.qualcomm.com>

Current virtio block protocol discards inline encryption metadata
during I/O transaction, such that hardware inline encryption cannot
be used by the guest virtual machine. 

This patch is used to add inline encryption support on virtio block
through a new feature bit VIRTIO_BLK_F_ICE negotiation and some
struct extension.

About the inline encryption on UFS or eMMC storage, please
refer to the Linux inline encryption documentation:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/block/inline-encryption.rst

---
changes from v2:
 - Add inline encryption link in commit message for a better
   backgrond descryption
 - Add sufficient descryption for the fields of crypto
   capability
 - Delete crypto capability in configuration layout, instead
   add a new request command to get it
 - Correct the terminology in non-normative and normative
   sections
 - Correct the mail for open source upstream

 v1 patch: https://lore.kernel.org/virtio-dev/20260204172749.GA610283@fedora/T/#t

-- 
2.34.1

