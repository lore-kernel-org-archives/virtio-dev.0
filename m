Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793092206;
	b=qYC5+WFJnThcToNv6z6+19mdVI25cIsAkn3fZZmkydXa9IScfaSodtWyANlNn3XtYJJ5
	 6sElqdZbefbVqtb74xVsQgtShYrnXTgjkwV+BDK021pKN/KnsdatroX3OsRHhd2aTmslm
	 LhGMMmRgDLTGHcgwz5IOo5C2krO75VNN/+fMi5HPSSe2yNheRsoBZMIIhsUfVJSyjDAyj
	 eJpUnIzJa935RO2gcU6Yqq4cSU6yhyHzABRkvYhk8LG3i/EYsfMW87s4/TM+6oxLzbBj5
	 e0nUv5eDip7SD0EU7DULgQAELCUzMGmbk4DmdB6TKJNdbIxC29RhYMwGg8pGrh3e4wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793092206;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=vYgWt0u0k5xi4fjvnnNsodfJpJdiSNhXnGShsXUi1ho=;
	b=3AljEdtio+blfn71d+VXhhH49Xw6SyxHVocDWFpE0Q1HdeKP9vwk5Z9A28N83TEpVrfx
	 9mPjSKwG4GJtO4TxCOYPdclS2byfY14fcz0mn2bhLDqc78ESBqe2d+TCrDsYmzxeyKcGZ
	 BQTVzuM9C2CNPxAKsEh4HGilK+iOPcgfI8R0xIDhEkepkEtNkaH96cho48GnKATaMH5tr
	 yiYATGjSQm0OaHtxqSf6HFuIDP7TxpcSVb5HXHIDXWxyVa2HOMaON4tH1j68yTYzsQ3y5
	 PV/DcK4nkzNtnavz6v7t1dyQm/F2Y/JkfYn8yuuRUBlsvjfKzQqx/UwNMIkxuzOxUhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mSuG8fKT;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KThjyDo6;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A078A606A31F
	for <virtio-dev@lists.linux.dev>; Tue, 27 Oct 2026 09:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A078A606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mSuG8fKT;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KThjyDo6
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69R8gc7H1709141
	for <virtio-dev@lists.linux.dev>; Tue, 27 Oct 2026 09:10:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=vYgWt0u0k5x
	i4fjvnnNsodfJpJdiSNhXnGShsXUi1ho=; b=mSuG8fKTAHQOr2BY6w0OzzfAyAL
	rQVHRcuEH1MS0uMwdTQdwUOB0g2/O4PP2M47jQoa87s2wm6HAxyBI3XkZ6Te+7hC
	cEypMwwlShNMRW5ZFAzufJdjS0C517A2ZXKU2HZb0VygAsonSa0wMsg4P/aREk0G
	LlOen2XbV1zvdCxEUkZVnEeqGJ8Y3PENdhcZyiMhU9HNQ6durQ9XtIL8dnq8QBvq
	2elr0DePF+Yw3BTQ2Yk7uTU3ysVhH5/kcgW9a6Tz2Ql8388SBKHrajzp7GpxKnAM
	sD23LzcHv7w/gyt5i1is5gRyiRTCGjUqlaM2vbhXQy7OXB+gM3pPAwAYo+Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj79xv254-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Tue, 27 Oct 2026 09:10:04 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3adbc9a47fbso3860814a91.1
        for <virtio-dev@lists.linux.dev>; Tue, 27 Oct 2026 02:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793092204; x=1793697004; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vYgWt0u0k5xi4fjvnnNsodfJpJdiSNhXnGShsXUi1ho=;
        b=KThjyDo6tr6frJX4rRU7g1USl4hkF3i0PdFuhR0IeImsCwprylajW32GGkdFSYI93I
         LqSsvMn4MbdnDkmA2Jl73LUJNo0BGqmq4WiM/Lb3oERq13paJpHbDlNBPW0vWwAK7pPV
         8o2jOCIfD+50qtMSfRER5tLknW19IdowYqkvgzJbxetixYelmG1PLDzR6EJU/VoELIHU
         QVsXLoHtJcWd6MvblDgwVdqFUx1GtTJRUgtth4uJKwWePDRPxaZVGo4o4Cfn5LgdzXYw
         8PbCPTmhk59wJEojR0soMH5m/KmVbRY+22wOptMvgUdi9sYlhe+4OkiIa2tWdr3nDfyM
         kYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793092204; x=1793697004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vYgWt0u0k5xi4fjvnnNsodfJpJdiSNhXnGShsXUi1ho=;
        b=uiVj8oxIVIoAutxTHtn4CZuJiVDqEqR+djQ07zRx4TszUM5f74nzrjO79AqrhsdBbG
         JBg+ELGOjb1N8UhDSraQQcg8/IM62tt4Kkk6SVfCZdur2TU6yc86OSq0Nv6Zf1P3KuBs
         b4d017eXmvKVYkd0Rlt/Vc1Kj86+RAnxHOJYLNp3MK9GrU7nB0SrUNZqNStWBUWX3ttO
         q2t8vtXHFUhbpEevaQg+uWfWGkiOGX6w2A/2DyDbeeNknGIUzNE14Q8Mg30iDBEInwYi
         42iMeaFFWF0tNRtDOHaWefJNnoFM00k7P5Bv7TS9D9X7SbXAvlDkN9C0vRA6igLz94LM
         2heg==
X-Gm-Message-State: AFq9FYKsDiRuJmgoRd51WsqQEi1WRvED8Rrx25+oEbb65X062hlsEK9o
	2jy3Lb9zTt9PgCOE21Ft5fZPWIjd7objjo7Az0CvXrDOlLvBVSAZH2x2NB1lfGqbld4Ye45roRG
	bAKDt0eLI8Z6p7ZD8P2xdk5+9iBy7A9ue0hI5loQuKzgc2y9byiTyiyBjhCahdhPAYM3j+tuB
X-Gm-Gg: AYBFou0izfjCyDHgnB8YlG6NkWdMOjLTEFQAiOLIiEA9f97xqgcKZRdrnSFOtzZ+DsW
	BTd6S5vbiH9YpDyDA6s8LHCys1NZZO0zAgc0U7dTje4rQFvd+W1BPMrE+bnEhrenlxYV10SBBia
	NTixWb3u//VX6AHAF/exlAgVN/dodSd9idXBOhssQvs2TunJPpc8RADqK5lMUCHSanL+HAaYeOM
	QLLQJNWi6drXq3tRJeHa9ZHZrj2S3OVlJ4lNn08mv9RMG28oe05d5/HHY8EkfAKyChKI5XyEMLI
	PNDO81JfPpZYfFFi9SZ74NwTRMU27znjrbrtc1KJAW4tiJqdCgeMncHk0nvpwpLfWKVF2vC8Vx1
	6/zi70Nt8+kKS6ovIJKoh1V8kBhsw/Tc/gpzWpGrswU2dXDYfGrCZ8R9M8Q==
X-Received: by 2002:a17:90b:52c4:b0:3a4:8c41:fab6 with SMTP id 98e67ed59e1d1-3adead50adamr7417028a91.46.1793092203761;
        Tue, 27 Oct 2026 02:10:03 -0700 (PDT)
X-Received: by 2002:a17:90b:52c4:b0:3a4:8c41:fab6 with SMTP id 98e67ed59e1d1-3adead50adamr7416971a91.46.1793092202504;
        Tue, 27 Oct 2026 02:10:02 -0700 (PDT)
Received: from u24-san1p10108.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae404426c2sm2940522a91.7.2026.10.27.02.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 02:10:02 -0700 (PDT)
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: virtio-dev@lists.linux.dev, virtio-comment@lists.linux.dev,
        stefanha@redhat.com, mst@redhat.com, mgurtovoy@nvidia.com,
        parav@nvidia.com, ebiggers@kernel.org
Cc: neeraj.soni@oss.qualcomm.com
Subject: [PATCH v6 2/4] virtio-blk: Add inline encryption administration commands
Date: Tue, 27 Oct 2026 02:09:25 -0700
Message-ID: <20261027090945.185178-3-linlin.zhang@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: e2uVoylL7a_yWN2x9eYC7gMapmsi6noP
X-Proofpoint-GUID: e2uVoylL7a_yWN2x9eYC7gMapmsi6noP
X-Authority-Analysis: v=2.4 cv=FPyOVOos c=1 sm=1 tr=0 ts=6ae06a6d cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=Ct7Ke8_oGBt8dWtJekEA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAzNiBTYWx0ZWRfX/JFpOZoZxL7O
 ZfA3xE1KYc+qBD11WII+ZUrOAYpfqfgYUuDIR2zoEHNcti/kzfZ/Iw9erIMgo2k2+BdAO3cHmnV
 tVBatQnGruX8bj8cDpqF+8jMIX/+SQKpmIXlI2PfOUDy2UfGvlvyDpRIUQtiFAnOEgUElJFVXH/
 WbP39HOEJb8vBTeQhJaxGN5Vr4Xj2rm0mJbXXXxs8JyHzztp0cTSgbDbwTzOauCoHsl9MNpFIaG
 viMmU2dGFGLzrvUhcgbuma4Kx8rz1Jv5oMVaeUk8AiBrLrM1DrfMdX0brWuzTXnz4/H2zMEZZJ/
 FRmq4dfQPae9yJsd01p4c7dhcI5LJUWnjECCt+fBMHLIFCket7s+Jlj2da4ks7vXRY2dNC2n6T5
 GCN3nXMVd+MoP7zel3NEdkeGn2cbgneWCZb3ExF/mBoTgEvW09qN/VZ096qoYn3no7DIO3vRUUe
 Y0LQDy78C+FZtS+9LiQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAzNiBTYWx0ZWRfX6rjqxgD0ajAA
 Ecwi2LDOq6om/dXp9w244IL+At2OQM1uFBN41DoF9JtUxeLKfBPf5Z2MFZ6IZ+23RcAbDxKAbJ7
 PpufWIXnq0O2fWJTRH1D/dtxvZCeuu4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270036

With VIRTIO_BLK_F_INLINE_ENCRYPTION the driver can discover the inline
encryption capabilities of the device, but it has no way yet to query
the supported crypto modes or to manage the keys in the keyslots.

Add group administration commands for this. They operate on the device
itself, so they use the Self group type, and therefore work with any
transport which provides an administration virtqueue:

VIRTIO_BLK_ADMIN_CMD_GET_CRYPTO_MODES (0x0013): query the supported
crypto modes and data unit sizes.
VIRTIO_BLK_ADMIN_CMD_CRYPTO_KEYSLOT_PROGRAM (0x0014): program a key
into a keyslot.
VIRTIO_BLK_ADMIN_CMD_CRYPTO_KEYSLOT_EVICT (0x0015): empty a keyslot.
VIRTIO_BLK_ADMIN_CMD_CRYPTO_DERIVE_SW_SECRET (0x0016): derive the
software secret of a hardware-wrapped key.
VIRTIO_BLK_ADMIN_CMD_CRYPTO_GENERATE_KEY (0x0017): generate a new
hardware-wrapped key.
VIRTIO_BLK_ADMIN_CMD_CRYPTO_IMPORT_KEY (0x0018): import a raw key as a
hardware-wrapped key.
VIRTIO_BLK_ADMIN_CMD_CRYPTO_PREPARE_KEY (0x0019): convert a long-term
wrapped key to its ephemerally-wrapped form.

The opcodes are allocated from the range of commands using struct
virtio_admin_cmd, and are listed in the group administration commands
table.

A hardware-wrapped key exists in a long-term wrapped form, returned by
GENERATE_KEY and IMPORT_KEY, and in an ephemerally-wrapped form,
returned by PREPARE_KEY, which is the form used by KEYSLOT_PROGRAM and
DERIVE_SW_SECRET. A device reset does not invalidate either form.

The length of a key is given by its key_size field. The buffer lengths
otherwise follow the generic rules for administration commands, except
that a command fails if a key does not fit in the buffer provided, as a
truncated key is unusable.

Driver requirements:
- The commands are only enabled and used if
  VIRTIO_BLK_F_INLINE_ENCRYPTION has been negotiated, and the
  hardware-wrapped key commands only if the device supports
  hardware-wrapped keys.
- The command specific data hold the whole key, in the wrapped form
  expected by the command, and the command specific result is large
  enough for the result. A returned key which was not written
  completely is treated as a failure.

Device requirements:
- The commands are reported by VIRTIO_ADMIN_CMD_LIST_QUERY if the
  device offers VIRTIO_BLK_F_INLINE_ENCRYPTION, so that the list of
  supported commands does not depend on feature negotiation; the
  hardware-wrapped key commands only if the device supports
  hardware-wrapped keys. VIRTIO_ADMIN_CMD_LIST_USE fails if it enables
  them and VIRTIO_BLK_F_INLINE_ENCRYPTION has not been negotiated.
- GET_CRYPTO_MODES reports 0 for unsupported crypto modes and no data
  unit size smaller than 512 bytes, and only writes whole entries into
  a result buffer which is too short.
- Invalid or inconsistent parameters fail the command with
  VIRTIO_ADMIN_STATUS_EINVAL and VIRTIO_ADMIN_STATUS_Q_INVALID_FIELD,
  and a result buffer too short for the returned key with
  VIRTIO_ADMIN_STATUS_EINVAL and VIRTIO_ADMIN_STATUS_Q_INVALID_COMMAND.
  A failed command neither changes the keyslot nor returns key
  material. A GENERATE_KEY which cannot generate a key fails with a
  status other than VIRTIO_ADMIN_STATUS_OK, without having to report
  the cause.
- On success, the command specific result holds the whole returned key
  or software secret. KEYSLOT_EVICT ignores all fields other than slot.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/238
Signed-off-by: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
---
 admin.tex                               |  16 +-
 device-types/blk/description.tex        | 505 +++++++++++++++++++++++-
 device-types/blk/device-conformance.tex |   1 +
 device-types/blk/driver-conformance.tex |   1 +
 4 files changed, 521 insertions(+), 2 deletions(-)

diff --git a/admin.tex b/admin.tex
index cfca5e3..9d63aa5 100644
--- a/admin.tex
+++ b/admin.tex
@@ -158,8 +158,22 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
 \hline
 0x0011 & \hyperref[par:Basic Facilities of a Virtio Device / Device groups / Group administration commands / Device parts / Device parts handling commands / VIRTIO-ADMIN-CMD-DEV-MODE-SET]{VIRTIO_ADMIN_CMD_DEV_MODE_SET} & Stop or resume the device \\
 \hline
+0x0013 & \hyperref[sec:Device Types / Block Device / Device Operation / Inline Encryption Administration Commands]{VIRTIO_BLK_ADMIN_CMD_GET_CRYPTO_MODES} & Get the inline encryption crypto modes supported by a block device \\
 \hline
-0x0013 - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}    \\
+0x0014 & \hyperref[sec:Device Types / Block Device / Device Operation / Inline Encryption Administration Commands]{VIRTIO_BLK_ADMIN_CMD_CRYPTO_KEYSLOT_PROGRAM} & Program a key into a block device keyslot \\
+\hline
+0x0015 & \hyperref[sec:Device Types / Block Device / Device Operation / Inline Encryption Administration Commands]{VIRTIO_BLK_ADMIN_CMD_CRYPTO_KEYSLOT_EVICT} & Evict a key from a block device keyslot \\
+\hline
+0x0016 & \hyperref[sec:Device Types / Block Device / Device Operation / Inline Encryption Administration Commands]{VIRTIO_BLK_ADMIN_CMD_CRYPTO_DERIVE_SW_SECRET} & Derive the software secret from a hardware-wrapped key of a block device \\
+\hline
+0x0017 & \hyperref[sec:Device Types / Block Device / Device Operation / Inline Encryption Administration Commands]{VIRTIO_BLK_ADMIN_CMD_CRYPTO_GENERATE_KEY} & Generate a hardware-wrapped key in a block device \\
+\hline
+0x0018 & \hyperref[sec:Device Types / Block Device / Device Operation / Inline Encryption Administration Commands]{VIRTIO_BLK_ADMIN_CMD_CRYPTO_IMPORT_KEY} & Import a raw key as a hardware-wrapped key in a block device \\
+\hline
+0x0019 & \hyperref[sec:Device Types / Block Device / Device Operation / Inline Encryption Administration Commands]{VIRTIO_BLK_ADMIN_CMD_CRYPTO_PREPARE_KEY} & Convert a long-term wrapped key of a block device to its ephemerally-wrapped form \\
+\hline
+\hline
+0x001A - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}    \\
 \hline
 0x8000 - 0xFFFF & - & Reserved for future commands (possibly using a different structure)    \\
 \hline
diff --git a/device-types/blk/description.tex b/device-types/blk/description.tex
index b347140..b85db2e 100644
--- a/device-types/blk/description.tex
+++ b/device-types/blk/description.tex
@@ -337,7 +337,10 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
 
 \item If the VIRTIO_BLK_F_INLINE_ENCRYPTION feature is negotiated, the fields in
     \field{enc_characteristics} can be read by the driver to determine the
-    inline encryption capabilities of the device. All
+    inline encryption capabilities of the device, and a
+    VIRTIO_BLK_ADMIN_CMD_GET_CRYPTO_MODES administration command (see
+    \ref{sec:Device Types / Block Device / Device Operation / Inline Encryption Administration Commands})
+    can be sent to retrieve the set of supported crypto modes. All
     \field{enc_characteristics} fields are read-only.
 
 \end{enumerate}
@@ -1327,6 +1330,506 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
 handles VIRTIO_BLK_T_ZONE_RESET request for the zone range specified in the
 VIRTIO_BLK_T_SECURE_ERASE request.
 
+\subsubsection{Inline Encryption Administration Commands}\label{sec:Device Types / Block Device / Device Operation / Inline Encryption Administration Commands}
+If the VIRTIO_BLK_F_INLINE_ENCRYPTION and VIRTIO_F_ADMIN_VQ features are
+negotiated, the driver uses the administration virtqueue (see
+\ref{sec:Basic Facilities of a Virtio Device / Device groups / Group administration commands})
+to send inline encryption key management commands to the device. These commands
+operate on the device itself, so they use the Self group type (0x0) with
+\field{group_member_id} set to 0. As a result they do not depend on the
+transport used by the device; any transport that provides an administration
+virtqueue for the Self group type can carry them.
+
+The following group administration commands are defined for use with the
+VIRTIO_BLK_F_INLINE_ENCRYPTION feature, with these \field{opcode} values:
+
+\begin{lstlisting}
+/* Get inline crypto modes */
+#define VIRTIO_BLK_ADMIN_CMD_GET_CRYPTO_MODES          0x0013
+
+/* Program a key into the keyslot */
+#define VIRTIO_BLK_ADMIN_CMD_CRYPTO_KEYSLOT_PROGRAM    0x0014
+
+/* Evict a key */
+#define VIRTIO_BLK_ADMIN_CMD_CRYPTO_KEYSLOT_EVICT      0x0015
+
+/* Derive the software secret from a hardware-wrapped key */
+#define VIRTIO_BLK_ADMIN_CMD_CRYPTO_DERIVE_SW_SECRET   0x0016
+
+/* Generate a new hardware-wrapped key */
+#define VIRTIO_BLK_ADMIN_CMD_CRYPTO_GENERATE_KEY       0x0017
+
+/* Import a raw key as a hardware-wrapped key */
+#define VIRTIO_BLK_ADMIN_CMD_CRYPTO_IMPORT_KEY         0x0018
+
+/* Convert a long-term wrapped key to its ephemerally-wrapped form */
+#define VIRTIO_BLK_ADMIN_CMD_CRYPTO_PREPARE_KEY        0x0019
+\end{lstlisting}
+
+Each command uses the common structure of a group administration command.
+The result of a command is reported in \field{status} of that structure
+(VIRTIO_ADMIN_STATUS_OK on success), and the command-specific data are carried
+in \field{command_specific_data} and \field{command_specific_result} as
+follows:
+
+\begin{itemize}
+\item For VIRTIO_BLK_ADMIN_CMD_GET_CRYPTO_MODES,
+    \field{command_specific_result} is struct virtio_blk_crypto_modes.
+    There is no \field{command_specific_data}.
+\item For VIRTIO_BLK_ADMIN_CMD_CRYPTO_KEYSLOT_PROGRAM and
+    VIRTIO_BLK_ADMIN_CMD_CRYPTO_KEYSLOT_EVICT, \field{command_specific_data}
+    is struct virtio_blk_crypto_key_desc. There is no
+    \field{command_specific_result}.
+\item For VIRTIO_BLK_ADMIN_CMD_CRYPTO_GENERATE_KEY,
+    \field{command_specific_result} is struct virtio_blk_crypto_key_blob.
+    There is no \field{command_specific_data}.
+\item For VIRTIO_BLK_ADMIN_CMD_CRYPTO_IMPORT_KEY and
+    VIRTIO_BLK_ADMIN_CMD_CRYPTO_PREPARE_KEY, both
+    \field{command_specific_data} and \field{command_specific_result} are
+    struct virtio_blk_crypto_key_blob.
+\item For VIRTIO_BLK_ADMIN_CMD_CRYPTO_DERIVE_SW_SECRET,
+    \field{command_specific_data} is struct virtio_blk_crypto_key_blob and
+    \field{command_specific_result} is struct virtio_blk_crypto_sw_secret.
+\end{itemize}
+
+\begin{lstlisting}
+struct virtio_blk_crypto_modes {
+        /*
+         * modes[N], for crypto mode number N <= VIRTIO_BLK_CRYPTO_MODE_MAX,
+         * is a bitmask of the data unit sizes with which crypto mode N can
+         * be used: bit i is set if a data unit size of (1 << i) bytes is
+         * supported. modes[0] is reserved and always 0.
+         */
+        le32 modes[VIRTIO_BLK_CRYPTO_MODE_MAX + 1];
+};
+\end{lstlisting}
+
+Crypto mode numbers are used as indices into \field{modes} in struct
+virtio_blk_crypto_modes above, and in \field{crypto_mode} in struct
+virtio_blk_crypto_key_desc. These numbers are assigned by this
+specification and are stable: a number is never reused for a different
+crypto mode, and additional crypto modes are assigned new, higher numbers.
+
+The crypto mode numbers currently defined by this specification are:
+
+\begin{lstlisting}
+#define VIRTIO_BLK_CRYPTO_MODE_INVALID          0
+#define VIRTIO_BLK_CRYPTO_MODE_AES_256_XTS      1
+
+/* Highest crypto mode number defined by this specification. */
+#define VIRTIO_BLK_CRYPTO_MODE_MAX              1
+\end{lstlisting}
+
+Crypto mode number 0 (VIRTIO_BLK_CRYPTO_MODE_INVALID) is reserved and is
+not used to reference an actual crypto mode.
+
+\begin{note}
+When a future version of this specification defines additional crypto
+modes, VIRTIO_BLK_CRYPTO_MODE_MAX and thus the size of struct
+virtio_blk_crypto_modes increase. A driver and a device implementing
+different versions of this specification remain compatible through the
+generic buffer length rules for administration commands: a device does
+not write the entries for crypto modes beyond the buffer provided by an
+older driver, and a newer driver interprets the entries which an older
+device does not write as 0, that is as not supported.
+\end{note}
+
+For VIRTIO_BLK_CRYPTO_MODE_AES_256_XTS, a raw key is 64 bytes long, that is
+two 256-bit AES keys. The size of a hardware-wrapped key is determined by
+the device, and is reported in \field{key_size} of the struct
+virtio_blk_crypto_key_blob returned by the command which produced the key.
+
+The VIRTIO_BLK_ADMIN_CMD_GET_CRYPTO_MODES command queries which crypto modes
+and data unit sizes the device supports for inline encryption. The command
+has no \field{command_specific_data}. On success,
+\field{command_specific_result} is a struct virtio_blk_crypto_modes
+describing the supported (crypto mode, data unit size) combinations.
+
+\begin{lstlisting}
+/* Inline crypto key descriptor. */
+struct virtio_blk_crypto_key_desc {
+        le32  slot;
+        le32  key_size;
+        le32  crypto_mode;
+        le32  key_type;
+        le32  data_unit_size_bits;
+        le32  dun_bytes;
+        u8    bytes[];
+};
+\end{lstlisting}
+
+\field{slot} is the target keyslot in the device where the key is programmed.
+\field{crypto_mode} is the crypto mode number, used as an index into the
+\field{modes} array returned by a VIRTIO_BLK_ADMIN_CMD_GET_CRYPTO_MODES request.
+\field{key_type} is either VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW or
+VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED.
+\field{data_unit_size_bits} is the base-2 logarithm of the
+data unit size in bytes used by \field{crypto_mode}.
+\field{dun_bytes} is the number of bytes that will be used to specify the Data
+Unit Number when this key is used.
+\field{key_size} is the length of the key material in bytes, and the key
+material is the first \field{key_size} bytes of \field{bytes}.
+
+The VIRTIO_BLK_ADMIN_CMD_CRYPTO_KEYSLOT_PROGRAM command programs a key into
+a keyslot, or overwrites the key already in that keyslot, for later use by
+VIRTIO_BLK_T_CRYPTO_IN and VIRTIO_BLK_T_CRYPTO_OUT requests. The keyslot
+index, key material, key size, crypto mode, key type, data unit size and
+DUN size are specified by the \field{slot}, \field{bytes}, \field{key_size},
+\field{crypto_mode}, \field{key_type}, \field{data_unit_size_bits} and
+\field{dun_bytes} in struct virtio_blk_crypto_key_desc respectively. These
+fields have to be valid and consistent with each other and with the values
+reported in \field{enc_characteristics}, otherwise the command fails and
+the keyslot is left unchanged.
+
+The VIRTIO_BLK_ADMIN_CMD_CRYPTO_KEYSLOT_EVICT command empties a keyslot so
+that key information is removed and the keyslot cannot be used until it is
+programmed again. The keyslot index is specified by the \field{slot} in
+struct virtio_blk_crypto_key_desc and all other fields in the struct are
+ignored. Evicting a keyslot which is already empty succeeds.
+
+\begin{lstlisting}
+/* A raw or hardware-wrapped key. */
+struct virtio_blk_crypto_key_blob {
+        le32 key_size;
+        u8 key[];
+};
+\end{lstlisting}
+
+For struct virtio_blk_crypto_key_blob, \field{key_size} is the length of
+the key material in bytes, and the key material is the first
+\field{key_size} bytes of \field{key}.
+
+For struct virtio_blk_crypto_key_desc and struct
+virtio_blk_crypto_key_blob, the length of the key material is given by
+\field{key_size} and not by the length of the buffer. Any data following
+the first \field{key_size} bytes of \field{bytes} or \field{key} is not
+part of the key. The length of the buffers otherwise follows the general
+rules in \ref{sec:Basic Facilities of a Virtio Device / Administration Virtqueues},
+except that a key is never silently truncated: a buffer which is too
+short to hold the whole key causes the command to fail, as described
+below.
+
+When struct virtio_blk_crypto_key_blob is used as
+\field{command_specific_result}, the driver does not know the size of the
+returned key in advance, so it provides a buffer large enough for the
+largest key it is able to handle. The device knows from \field{opcode} that
+the result is struct virtio_blk_crypto_key_blob, and compares the length
+of the device-writeable buffer with the size of that struct including the
+key it returns. If the buffer is longer, the device writes only the struct
+and the key, and the driver ignores the rest of the buffer. If the buffer
+is too short to hold the whole key, the command fails.
+
+A hardware-wrapped key exists in two forms:
+\begin{itemize}
+\item The long-term wrapped form, returned by
+    VIRTIO_BLK_ADMIN_CMD_CRYPTO_GENERATE_KEY and
+    VIRTIO_BLK_ADMIN_CMD_CRYPTO_IMPORT_KEY, which the driver can store
+    persistently, for example on the storage.
+\item The ephemerally-wrapped form, returned by
+    VIRTIO_BLK_ADMIN_CMD_CRYPTO_PREPARE_KEY, which is the form used in
+    \field{bytes} of a VIRTIO_BLK_ADMIN_CMD_CRYPTO_KEYSLOT_PROGRAM command
+    with \field{key_type} VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED and in
+    \field{command_specific_data} of a
+    VIRTIO_BLK_ADMIN_CMD_CRYPTO_DERIVE_SW_SECRET command.
+\end{itemize}
+A device reset (see
+\ref{sec:Basic Facilities of a Virtio Device / Device Reset}) only empties
+the keyslots, and does not affect the validity of the long-term wrapped and
+ephemerally-wrapped keys produced by the device before the reset.
+
+The VIRTIO_BLK_ADMIN_CMD_CRYPTO_GENERATE_KEY command asks the device to
+generate a new hardware-wrapped key. The command has no
+\field{command_specific_data}. On success, \field{command_specific_result}
+is a struct virtio_blk_crypto_key_blob containing the generated key, in
+long-term wrapped form, and its \field{key_size}.
+
+The VIRTIO_BLK_ADMIN_CMD_CRYPTO_IMPORT_KEY command asks the device to import
+a raw key and return its hardware-wrapped key. The raw key and its
+\field{key_size} are given in the \field{command_specific_data}, a
+struct virtio_blk_crypto_key_blob. On success,
+\field{command_specific_result} is a struct virtio_blk_crypto_key_blob
+containing the wrapped key, in long-term wrapped form, and its
+\field{key_size}.
+
+The VIRTIO_BLK_ADMIN_CMD_CRYPTO_PREPARE_KEY command converts a long-term
+hardware-wrapped key into its ephemerally-wrapped form, suitable for
+programming into a keyslot with VIRTIO_BLK_ADMIN_CMD_CRYPTO_KEYSLOT_PROGRAM.
+The long-term wrapped key and its \field{key_size} are given in the
+\field{command_specific_data}, a struct virtio_blk_crypto_key_blob. On
+success, \field{command_specific_result} is a
+struct virtio_blk_crypto_key_blob containing the ephemerally-wrapped key
+and its \field{key_size}.
+
+\begin{lstlisting}
+#define VIRTIO_BLK_CRYPTO_SW_SECRET_SIZE        32
+
+struct virtio_blk_crypto_sw_secret {
+        u8 secret[VIRTIO_BLK_CRYPTO_SW_SECRET_SIZE];
+};
+\end{lstlisting}
+
+The VIRTIO_BLK_ADMIN_CMD_CRYPTO_DERIVE_SW_SECRET command derives the software
+secret associated with a hardware-wrapped key, for use by software that
+needs to operate on the key material outside of the device, for example
+for file system metadata encryption. The ephemerally-wrapped key and its
+\field{key_size} are given in the \field{command_specific_data}, a
+struct virtio_blk_crypto_key_blob. On success,
+\field{command_specific_result} is a struct virtio_blk_crypto_sw_secret
+containing the derived \field{secret}.
+
+\drivernormative{\paragraph}{Inline Encryption Administration Commands}{Device Types / Block Device / Device Operation / Inline Encryption Administration Commands}
+
+The driver MUST NOT send any of the commands above unless it has enabled
+the corresponding opcode for the Self group type with
+VIRTIO_ADMIN_CMD_LIST_USE, after querying the supported opcodes with
+VIRTIO_ADMIN_CMD_LIST_QUERY, and the VIRTIO_BLK_F_INLINE_ENCRYPTION and
+VIRTIO_F_ADMIN_VQ features have been negotiated.
+
+If the VIRTIO_BLK_F_INLINE_ENCRYPTION feature has not been negotiated, the
+driver MUST NOT enable the opcodes of the commands above with
+VIRTIO_ADMIN_CMD_LIST_USE.
+
+The driver MUST set \field{group_type} to 0x0 (Self group type) and
+\field{group_member_id} to 0 for these commands.
+
+When \field{command_specific_data} is struct virtio_blk_crypto_key_blob,
+or is struct virtio_blk_crypto_key_desc of a
+VIRTIO_BLK_ADMIN_CMD_CRYPTO_KEYSLOT_PROGRAM command, the driver MUST provide
+a \field{command_specific_data} that contains the whole struct up to and
+including the first \field{key_size} bytes of \field{bytes} or \field{key}.
+The driver MAY append padding after the key material.
+\begin{note}
+Padding allows the driver to make the device-readable part of
+\field{struct virtio_admin_cmd}, including the key material, a multiple
+of 64 bit in length, as required by
+\ref{drivernormative:Basic Facilities of a Virtio Device / Administration virtqueues}.
+\end{note}
+
+The driver MUST provide a \field{command_specific_result} of at least the
+size of struct virtio_blk_crypto_modes, as defined by the version of this
+specification the driver implements, for
+VIRTIO_BLK_ADMIN_CMD_GET_CRYPTO_MODES, and large enough to hold struct
+virtio_blk_crypto_sw_secret for
+VIRTIO_BLK_ADMIN_CMD_CRYPTO_DERIVE_SW_SECRET. For
+VIRTIO_BLK_ADMIN_CMD_CRYPTO_GENERATE_KEY,
+VIRTIO_BLK_ADMIN_CMD_CRYPTO_IMPORT_KEY and
+VIRTIO_BLK_ADMIN_CMD_CRYPTO_PREPARE_KEY, the driver SHOULD provide a
+\field{command_specific_result} large enough to hold struct
+virtio_blk_crypto_key_blob with the largest key the driver is able to
+handle.
+
+The driver MUST NOT set \field{crypto_mode} in struct
+virtio_blk_crypto_key_desc of a VIRTIO_BLK_ADMIN_CMD_CRYPTO_KEYSLOT_PROGRAM
+command to a value greater than VIRTIO_BLK_CRYPTO_MODE_MAX, or to a crypto
+mode number that the device did not report as supported in reply to a
+VIRTIO_BLK_ADMIN_CMD_GET_CRYPTO_MODES request.
+
+The driver MUST NOT set \field{opcode} to
+VIRTIO_BLK_ADMIN_CMD_CRYPTO_GENERATE_KEY,
+VIRTIO_BLK_ADMIN_CMD_CRYPTO_IMPORT_KEY,
+VIRTIO_BLK_ADMIN_CMD_CRYPTO_PREPARE_KEY or
+VIRTIO_BLK_ADMIN_CMD_CRYPTO_DERIVE_SW_SECRET unless the device reported
+VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED as set in \field{key_types}.
+
+For VIRTIO_BLK_ADMIN_CMD_CRYPTO_KEYSLOT_PROGRAM and
+VIRTIO_BLK_ADMIN_CMD_CRYPTO_KEYSLOT_EVICT commands, the driver MUST set
+\field{slot} in struct virtio_blk_crypto_key_desc to a value less than
+\field{max_slots} in \field{enc_characteristics}.
+\begin{note}
+As the device ignores all fields of struct virtio_blk_crypto_key_desc
+other than \field{slot} for a VIRTIO_BLK_ADMIN_CMD_CRYPTO_KEYSLOT_EVICT
+command, the driver can, for example, set \field{key_size} to 0 and
+provide no key material for this command.
+\end{note}
+
+For a VIRTIO_BLK_ADMIN_CMD_CRYPTO_KEYSLOT_PROGRAM command, the driver MUST
+\begin{itemize}
+\item set \field{key_size} to a value greater than 0.
+\item set \field{key_type} to either VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW or
+    VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED, and MUST NOT set \field{key_type}
+    to VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED unless the device reported
+    VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED as set in \field{key_types}.
+\item set \field{data_unit_size_bits} to the base-2 logarithm of a data
+    unit size that the device reported as supported for \field{crypto_mode}
+    in reply to a VIRTIO_BLK_ADMIN_CMD_GET_CRYPTO_MODES request.
+\item set \field{dun_bytes} to a value greater than 0 and not greater than
+    \field{max_dun_bytes} in \field{enc_characteristics}.
+\end{itemize}
+
+For VIRTIO_BLK_ADMIN_CMD_CRYPTO_IMPORT_KEY,
+VIRTIO_BLK_ADMIN_CMD_CRYPTO_PREPARE_KEY and
+VIRTIO_BLK_ADMIN_CMD_CRYPTO_DERIVE_SW_SECRET commands, the driver MUST set
+\field{key_size} in \field{command_specific_data} to a value greater than 0.
+
+If \field{key_type} is VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED, the driver
+MUST provide the key in \field{bytes} of a
+VIRTIO_BLK_ADMIN_CMD_CRYPTO_KEYSLOT_PROGRAM command in ephemerally-wrapped
+form, as returned by VIRTIO_BLK_ADMIN_CMD_CRYPTO_PREPARE_KEY. The driver
+MUST provide the key in \field{command_specific_data} in
+ephemerally-wrapped form for a VIRTIO_BLK_ADMIN_CMD_CRYPTO_DERIVE_SW_SECRET
+command, and in long-term wrapped form for a
+VIRTIO_BLK_ADMIN_CMD_CRYPTO_PREPARE_KEY command.
+
+For VIRTIO_BLK_ADMIN_CMD_CRYPTO_GENERATE_KEY,
+VIRTIO_BLK_ADMIN_CMD_CRYPTO_IMPORT_KEY and
+VIRTIO_BLK_ADMIN_CMD_CRYPTO_PREPARE_KEY commands, the driver MUST treat the
+command as failed if \field{key_size} in \field{command_specific_result}
+is 0, or if the used buffer length shows that the device did not write
+the whole struct up to and including the first \field{key_size} bytes of
+\field{key}, and MUST ignore any data in \field{command_specific_result}
+following the first \field{key_size} bytes of \field{key}.
+
+\devicenormative{\paragraph}{Inline Encryption Administration Commands}{Device Types / Block Device / Device Operation / Inline Encryption Administration Commands}
+
+If the device offers the VIRTIO_BLK_F_INLINE_ENCRYPTION feature, the device
+MUST support the Self group type and MUST include the opcodes of the commands
+above in the list returned by VIRTIO_ADMIN_CMD_LIST_QUERY for the Self group
+type, except that the device MUST NOT include the opcodes of
+VIRTIO_BLK_ADMIN_CMD_CRYPTO_DERIVE_SW_SECRET,
+VIRTIO_BLK_ADMIN_CMD_CRYPTO_GENERATE_KEY,
+VIRTIO_BLK_ADMIN_CMD_CRYPTO_IMPORT_KEY and
+VIRTIO_BLK_ADMIN_CMD_CRYPTO_PREPARE_KEY in that list if it does not set
+VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED in \field{key_types}.
+
+If the VIRTIO_BLK_F_INLINE_ENCRYPTION feature has not been negotiated, the
+device MUST fail a VIRTIO_ADMIN_CMD_LIST_USE command which includes the
+opcode of any of the commands above with \field{status} set to
+VIRTIO_ADMIN_STATUS_EINVAL and \field{status_qualifier} set to
+VIRTIO_ADMIN_STATUS_Q_INVALID_FIELD.
+\begin{note}
+Which commands are reported by VIRTIO_ADMIN_CMD_LIST_QUERY depends on the
+features offered by the device, and not on the features negotiated, since
+\ref{devicenormative:Basic Facilities of a Virtio Device / Device groups / Group administration commands}
+does not allow the list of supported commands to shrink.
+\end{note}
+
+When \field{command_specific_data} is struct virtio_blk_crypto_key_desc or
+struct virtio_blk_crypto_key_blob, the device MUST use only the first
+\field{key_size} bytes of \field{bytes} or \field{key} as the key material,
+and MUST ignore any data following them.
+
+For VIRTIO_BLK_ADMIN_CMD_CRYPTO_KEYSLOT_PROGRAM,
+VIRTIO_BLK_ADMIN_CMD_CRYPTO_IMPORT_KEY,
+VIRTIO_BLK_ADMIN_CMD_CRYPTO_PREPARE_KEY and
+VIRTIO_BLK_ADMIN_CMD_CRYPTO_DERIVE_SW_SECRET commands, the device MUST
+complete the command with \field{status} set to VIRTIO_ADMIN_STATUS_EINVAL
+and \field{status_qualifier} set to VIRTIO_ADMIN_STATUS_Q_INVALID_FIELD if
+\field{command_specific_data} does not contain the whole struct up to and
+including the first \field{key_size} bytes of \field{bytes} or \field{key}.
+\begin{note}
+Treating the missing key bytes as zero would silently produce a different
+key. This is therefore an intentional exception to the rule in
+\ref{devicenormative:Basic Facilities of a Virtio Device / Administration virtqueues}
+that the device does not fail a command solely because the buffers
+provided are shorter than described in this specification.
+\end{note}
+
+For VIRTIO_BLK_ADMIN_CMD_CRYPTO_GENERATE_KEY,
+VIRTIO_BLK_ADMIN_CMD_CRYPTO_IMPORT_KEY and
+VIRTIO_BLK_ADMIN_CMD_CRYPTO_PREPARE_KEY commands, the device MUST complete
+the command with \field{status} set to VIRTIO_ADMIN_STATUS_EINVAL and
+\field{status_qualifier} set to VIRTIO_ADMIN_STATUS_Q_INVALID_COMMAND if
+\field{command_specific_result} is too short to hold struct
+virtio_blk_crypto_key_blob with the whole returned key, since a truncated
+key cannot be used.
+\begin{note}
+This is an intentional exception to the rule in
+\ref{devicenormative:Basic Facilities of a Virtio Device / Administration virtqueues}
+that the device does not fail a command solely because the buffers
+provided are shorter than described in this specification: a returned key
+which is truncated to the length of the buffer is unusable, so the device
+reports the failure instead of silently returning part of the key.
+\end{note}
+
+For VIRTIO_BLK_ADMIN_CMD_CRYPTO_GENERATE_KEY,
+VIRTIO_BLK_ADMIN_CMD_CRYPTO_IMPORT_KEY and
+VIRTIO_BLK_ADMIN_CMD_CRYPTO_PREPARE_KEY commands, on success the device
+MUST set \field{key_size} in \field{command_specific_result} to the size of
+the returned key, which MUST be greater than 0, MUST write the returned key
+to the first \field{key_size} bytes of \field{key}, and MUST report the
+length of data written as the used buffer length.
+
+For a VIRTIO_BLK_ADMIN_CMD_CRYPTO_DERIVE_SW_SECRET command, on success the
+device MUST write the whole struct virtio_blk_crypto_sw_secret, that is
+VIRTIO_BLK_CRYPTO_SW_SECRET_SIZE bytes, to \field{command_specific_result},
+and MUST report the length of data written as the used buffer length.
+
+For a VIRTIO_BLK_ADMIN_CMD_GET_CRYPTO_MODES command, the device MUST set
+\field{modes[N]} for each crypto mode number N that it supports to a
+bitmask of the data unit sizes it supports for that crypto mode, MUST set
+\field{modes[N]} to 0 for each crypto mode number N from 1 to
+VIRTIO_BLK_CRYPTO_MODE_MAX that it does not support, MUST set
+\field{modes[0]} to 0, and MUST NOT set bits 0 to 8 in any
+\field{modes[N]}, that is data unit sizes smaller than 512 bytes. If
+\field{command_specific_result} is shorter than struct
+virtio_blk_crypto_modes, the device MUST write only the entries of
+\field{modes} which fit entirely in \field{command_specific_result}, and
+MUST NOT write part of an entry.
+
+For a VIRTIO_BLK_ADMIN_CMD_CRYPTO_KEYSLOT_PROGRAM command, the device MUST
+complete the command with \field{status} set to VIRTIO_ADMIN_STATUS_EINVAL
+and \field{status_qualifier} set to VIRTIO_ADMIN_STATUS_Q_INVALID_FIELD if
+any of the following is true:
+\begin{itemize}
+\item \field{slot} is not less than \field{max_slots}.
+\item \field{key_size} is 0, or is not a key size that the device supports
+    for \field{crypto_mode} and \field{key_type}.
+\item \field{crypto_mode} is greater than VIRTIO_BLK_CRYPTO_MODE_MAX, or is
+    a crypto mode that the device does not support.
+\item \field{key_type} is neither VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW nor
+    VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED, or is
+    VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED but the device does not support
+    VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED keys.
+\item \field{data_unit_size_bits} does not correspond to a data unit size
+    that the device supports for \field{crypto_mode}.
+\item \field{dun_bytes} is 0, or is greater than \field{max_dun_bytes}.
+\end{itemize}
+
+For a VIRTIO_BLK_ADMIN_CMD_CRYPTO_KEYSLOT_EVICT command, the device MUST
+complete the command with \field{status} set to VIRTIO_ADMIN_STATUS_EINVAL
+and \field{status_qualifier} set to VIRTIO_ADMIN_STATUS_Q_INVALID_FIELD if
+\field{slot} is not less than \field{max_slots}, and otherwise MUST
+complete the command with VIRTIO_ADMIN_STATUS_OK, regardless of whether the
+keyslot was already empty. The device MUST ignore all other fields of
+struct virtio_blk_crypto_key_desc for this command.
+
+For VIRTIO_BLK_ADMIN_CMD_CRYPTO_KEYSLOT_PROGRAM and
+VIRTIO_BLK_ADMIN_CMD_CRYPTO_KEYSLOT_EVICT commands, the device MUST leave
+the target keyslot unchanged if the command fails, and MUST apply the
+requested change to the keyslot before completing the command with
+VIRTIO_ADMIN_STATUS_OK.
+
+For a VIRTIO_BLK_ADMIN_CMD_CRYPTO_GENERATE_KEY command, the device MUST
+complete the command with a \field{status} other than
+VIRTIO_ADMIN_STATUS_OK if it is unable to generate a key.
+\begin{note}
+The device is not required to report the cause of the failure, which might
+not be known to it. For example, it can use VIRTIO_ADMIN_STATUS_ENOSPC if it
+knows that it lacks the necessary hardware resources.
+\end{note}
+
+For VIRTIO_BLK_ADMIN_CMD_CRYPTO_IMPORT_KEY,
+VIRTIO_BLK_ADMIN_CMD_CRYPTO_PREPARE_KEY and
+VIRTIO_BLK_ADMIN_CMD_CRYPTO_DERIVE_SW_SECRET commands, the device MUST
+complete the command with \field{status} set to VIRTIO_ADMIN_STATUS_EINVAL
+and \field{status_qualifier} set to VIRTIO_ADMIN_STATUS_Q_INVALID_FIELD if
+\field{key_size} in \field{command_specific_data} is 0, or is not a key
+size that the device supports for the command.
+\begin{note}
+The device is not required to check in which form a wrapped key in
+\field{command_specific_data} is. It processes the command with the key
+supplied, and reports failures, for example if it is unable to wrap,
+rewrap or unwrap the key, with a \field{status} other than
+VIRTIO_ADMIN_STATUS_OK.
+\end{note}
+
+If a VIRTIO_BLK_ADMIN_CMD_CRYPTO_GENERATE_KEY,
+VIRTIO_BLK_ADMIN_CMD_CRYPTO_IMPORT_KEY,
+VIRTIO_BLK_ADMIN_CMD_CRYPTO_PREPARE_KEY or
+VIRTIO_BLK_ADMIN_CMD_CRYPTO_DERIVE_SW_SECRET command fails, the device MUST
+NOT write key material or the derived software secret to the
+\field{command_specific_result}.
+
 \subsubsection{Legacy Interface: Device Operation}\label{sec:Device Types / Block Device / Device Operation / Legacy Interface: Device Operation}
 When using the legacy interface, transitional devices and drivers
 MUST format the fields in struct virtio_blk_req
diff --git a/device-types/blk/device-conformance.tex b/device-types/blk/device-conformance.tex
index b4fbc8b..6b07de4 100644
--- a/device-types/blk/device-conformance.tex
+++ b/device-types/blk/device-conformance.tex
@@ -5,4 +5,5 @@
 \begin{itemize}
 \item \ref{devicenormative:Device Types / Block Device / Device Initialization}
 \item \ref{devicenormative:Device Types / Block Device / Device Operation}
+\item \ref{devicenormative:Device Types / Block Device / Device Operation / Inline Encryption Administration Commands}
 \end{itemize}
diff --git a/device-types/blk/driver-conformance.tex b/device-types/blk/driver-conformance.tex
index 0f69866..0e583cb 100644
--- a/device-types/blk/driver-conformance.tex
+++ b/device-types/blk/driver-conformance.tex
@@ -5,4 +5,5 @@
 \begin{itemize}
 \item \ref{drivernormative:Device Types / Block Device / Device Initialization}
 \item \ref{drivernormative:Device Types / Block Device / Device Operation}
+\item \ref{drivernormative:Device Types / Block Device / Device Operation / Inline Encryption Administration Commands}
 \end{itemize}
-- 
2.34.1

