Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56823542CF
	for <virtio-dev@lists.linux.dev>; Fri, 25 Sep 2026 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790344912; cv=none; b=Ga+EyTUgWCnCdsiGbT6NGAClvfnD2QmkszWNNNMEQbDRwCvs+5fJcLJ2pn0XsgL5O6bmDFS0IbX/g+oA23q2T15x2j2N2HWZ1G2HLA+bFK75PEkAjMVQ1G8vVxdlbxvGqFLwcIyv+GaXTJqrRhxea8hwddyybUAK/AIfLgEr0Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790344912; c=relaxed/simple;
	bh=t5dvLTY3iDucpZ1pO/7UEJg2IhSuCRcucMN4LW+X5vw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uk3UGno3JgBc0TDwL+I5WQ+d6fNxaNH3yvRSUxeYfjFMyTcoTHbGghE36wDLtUn6x6B4CgLXYuCecGTz+GdtmPq+CoNb+y3J46xgHljMJCLoR85iKGIFbFytQt5F3kxUM67diNcHxCzGuE5HwjB9+umNuTEBnm8bVKwVyO82p+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VqoH9E5T; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FH/P96MP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VqoH9E5T";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FH/P96MP"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PE1VAk601381
	for <virtio-dev@lists.linux.dev>; Fri, 25 Sep 2026 14:01:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=oI/zhoqW9RKSLEinzExm50/4S8L2C7HbpsX
	QPC7RIpk=; b=VqoH9E5TG7LnlLU8z/5rvMw8H6SUiZg36vSFw8NN/7HCcbxdfrM
	j+mSjHDMDHpkzj2RYjbbT4MhTAwJjRYD4rMHu+V1/1j41is2egWLZZ0sVGw81BB/
	FmJsSwqpcuyUklbd8UY39SNy9BTHVw3QgvH51eA9KzJEQrz4yPWInaF3cmwRd3OV
	U7g16Zk2OjIxIQEFZgcEAx1/vCoX67d6c3efiM1WsTz49pAA46JZPdk3Sm5NGE6+
	w3gebbEXe9u5+h+c1I/Q1RlHaBBdUoHLe1AjmFcqfWheY857ZTvhXrZY1A9FIO2y
	P4Zd6MyBMoY/tlZXk5ItRAkJD3PszPtK5Ow==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwjpvskbd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Fri, 25 Sep 2026 14:01:49 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-893d2c627b4so13460417b3.3
        for <virtio-dev@lists.linux.dev>; Fri, 25 Sep 2026 07:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790344909; x=1790949709; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oI/zhoqW9RKSLEinzExm50/4S8L2C7HbpsXQPC7RIpk=;
        b=FH/P96MPeXknHF2NbbWG2oUXDG8MYkv78hh3JcRHJhhZyo2zPMr8o5CvTqQsX65HL4
         3R3SgxPYMNKs4LgsRflM2oACwbTHcKAQDaRgHn1eGKkM5NVphyTjZJu2ALmx+h+ms4um
         O24cV2g5196qQOkI9PuOmJQrj4MTTK13i+mm+d/ikkg2RUHyp8qd+yGdi9cgOPZhWnPx
         QdMzv5FCLEdkS/hyqwbmu+5j41ldh2xLNpMPqpKLwK/lq2PPn7SveIY6ou89rz2qwTSQ
         uxV9nbaH6W/Bs0pl1awxDXbe1zq2OJwFqTS6JU56kZtTeEX3GnubdTOREMXP6Q/Fx9cj
         VzMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790344909; x=1790949709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oI/zhoqW9RKSLEinzExm50/4S8L2C7HbpsXQPC7RIpk=;
        b=G3hKaM0ppoNEFBjZRxJ04WbcI7R1nyLDk/UY/xljsSH3757a1fR0LYFYcTzgKEcp9M
         ikE4HxShORzW+WPwXt99Wf0b8GnDAvFZ8FJCtyZl54PgUTn1aIuv1379Hg6hSCwIzpZA
         CKysWMUKvSNqhWNvqknOvapRKgJVXeTpnIFGtx3nIXyLCMELcIC81fn49A1ybYHQd6dL
         MxUO/EKa7oaJRxqoBylKrpDm9Yx6wBaMSB2vdY36gR5kivnf5arjg1VLK593chCIYuDj
         gYZYycCAOwSwi8Akg1FH6jD91fwXLnZL+4p7l/ySDtXf4g2q7EbNb1Bz7lFfj4W7vp6J
         8PDw==
X-Gm-Message-State: AFuF++m1Fv8ggeSKtdvNh8o5m30t561fx26gRP4uiOUn26EauAXgFEPr
	ZRK5tCjwVPhTAxA+XQj7QUnDLk54BwCobXCGTlvv+C6y2BypThzN1F0gniCmd10lYp6jXAlTmEZ
	XZWrMffZq7YvOwa6uQPzY6iUE1MVFiggf2WVWEF6u5PHtVVQAvo2M+ZEhhhpjOKQOlZ56yC6/YT
	o=
X-Gm-Gg: AYBFou3Uerc+uLDvKOU4Koj766QxWG+iUozHGKIXjlKSvK47T/Z24KSaa/6qyXAOb9f
	mF/Y2P+cySBG9TR1/G/NSUYV+SrIPK2glDPrHSECdieLA9KWkSxmzjiC0eoeboEn1zfW3xSQMPa
	d+01xswyzxQz7H98R7pkY3/mMEobwe+bBSGZYz2lHBVAHsskIKYrS7ztlDbL5GQ85fXVZLkcGtC
	5lGIyvcC9UJaiP9ZyUwVcZI7ovv8AWjSLHdCE9FYUCc/A9K/l6x+OViY2c/zPLKaT3fZDnDAo3+
	fXs6f3sfWhrPBDSfUzSu6lTGj5WgR/9wHjSR242UOxWCbxG9okcvQkH21NwJKlU0My8LdX+ETZH
	euiqqEG+AwBZY8IvXvHEmu1BZ4Ud3lVmuRcgim45l1Ifoy8MHSYy4zo/ZKg==
X-Received: by 2002:a05:690c:e297:20b0:81e:fb1a:f222 with SMTP id 00721157ae682-8a647079735mr23575497b3.23.1790344907678;
        Fri, 25 Sep 2026 07:01:47 -0700 (PDT)
X-Received: by 2002:a05:690c:e297:20b0:81e:fb1a:f222 with SMTP id 00721157ae682-8a647079735mr23573667b3.23.1790344906171;
        Fri, 25 Sep 2026 07:01:46 -0700 (PDT)
Received: from u24-san1p10108.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a860f85e57sm8439937b3.19.2026.09.25.07.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 07:01:45 -0700 (PDT)
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: virtio-dev@lists.linux.dev, stefanha@redhat.com, ebiggers@kernel.org
Cc: neeraj.soni@oss.qualcomm.com
Subject: [PATCH v4 0/2] virtio-blk: Add inline encryption support
Date: Fri, 25 Sep 2026 07:01:19 -0700
Message-ID: <20260925140133.1214443-1-linlin.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: j9XpOdVGBodFWmWu0s_HnGJoTq7ezg3U
X-Proofpoint-ORIG-GUID: j9XpOdVGBodFWmWu0s_HnGJoTq7ezg3U
X-Authority-Analysis: v=2.4 cv=aLBlOr9m c=1 sm=1 tr=0 ts=6ab67ecd cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=lOd02TdZT948iX-3dRMA:9 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1NSBTYWx0ZWRfX58HLnM+OadS4
 JJDkTpJDFQcZ7nubmfG3/VLDfKnp7OzDaN1gU2aqssc05Z9aHIelZxT6yzIfbjY6LTh9nZ2noss
 +B0VN7JXb32PY/SZYz1aYOA5+4ZlxZQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1NSBTYWx0ZWRfX1K0+yPlE6tGC
 JALvZXvPaFNgjBvk0YEs3Kknl6zczzA1X0V66YhAaemSmKFUpjsE72rZbkohbOi82HBmdrhtCQs
 d3swAEqrSWD0HQi2o9Oi7Ui9bTdX3h8k6qJZGIICtg953Ox3NvyB9lpVYJDWF9MgADhFug6tlZk
 TayWKnAoNbzVnMerEsXr6/9otKvDlzq2yrugAjonGsN/mX2F7SoZA8ogu3+kmCNGB5y5ixMSj31
 3gnuoctYi+5S7tcXk1XrjjWyO+VUZfc9/1qHIk56mLvTxgqN7C8UaevYUFwAoqJYWOHwz+qS6Hw
 QMlsqMNPfgQkopELNd4t4mqi5aSTgruFx9nSALktZpX94BFgk5clR7q7GcBIveNmk9ZwwczA5xm
 FxSIdD0urhbh77s9+MLLEC6YIQpnWJb54laidgxnk4nI9DVM5WTbNJ3vZe3j+nM465f1eVZk7Ps
 2yX/Q7USPEGBZ9Ej1ew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250055

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

