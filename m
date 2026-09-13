Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF66370D57
	for <virtio-dev@lists.linux.dev>; Sun, 13 Sep 2026 16:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789316206; cv=none; b=gzWxMoU0ihR30pLNukNkVNHaigYLE5AKx0nHLMrRhAo3ASlmVIK2/wzGJMPG4ey2DjvlDngsTaKSQy1922z06Xkf9+k9EJWYfDvMzWgLfjsHiVYgWmPP02tcmkzqQdTVhOEpgLJbLo5awD4tMXSA16YzYi+MTioMJF41TDlLjA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789316206; c=relaxed/simple;
	bh=GxVKU9jqsRgF23i6BLKPgXoTSJPg1ctAq2nhQWh2BO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U/yMskRIK8i9s8NRGKxX9mEBJM4EKM6d9xVXfidEEfArinc9lOFU6GIZq4+WO0u2lE33JYoIeegyHTeFm27ujw2adUp75vKVXCIFjuEkTrAB+c4fGZ9/3BduDmeuWAk+UVjcUhyhS2pA/dKPWSapQPo6BcRL4fFpJ8chFz4xNRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WF0OiroV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=acdCdYJi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WF0OiroV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="acdCdYJi"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68DE042T1251573
	for <virtio-dev@lists.linux.dev>; Sun, 13 Sep 2026 16:16:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=jsnF78NUUv+8VlEEcl32uDIptLYHRKapZg3
	85T9AvHQ=; b=WF0OiroVHzYkF8oyUHUUWHJSVgOycl3gzOmE+uOvkIWI+VlRdns
	7O+4URSRNmA8Rngj0n6mMUJa2Y86//38A440jWcDhso9XUZNkdAZHfOARBjsZQIF
	G0mI2V3nAb+YhohpxATzIyE6auGjzrbT2XqPlvY4BOlnYZNt0cVsC9iQ/CVofkJg
	WG3+waZqoA7LLVkheYb2Hy29w8tq0qRAL/dNftanhZSi9JCjt3S9s7g/bSVATepm
	OTyYKSIrFRNtE9p37UhSm34UpFZI2gFKagg2okSl+QEn5JuiZ5OYC9fRrA9yFMDz
	P+9fwR7/JXlpXegRYXNvjNlgspyf/eDPZ+A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9cbkrj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Sun, 13 Sep 2026 16:16:42 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39533bb224cso2958634a91.3
        for <virtio-dev@lists.linux.dev>; Sun, 13 Sep 2026 09:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789316201; x=1789921001; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jsnF78NUUv+8VlEEcl32uDIptLYHRKapZg385T9AvHQ=;
        b=acdCdYJiMgerOK3dHAbEYHVCg6p5O+qhKj1eDGKIqTdD8KxzlkhhUCK4yWITfnsTbe
         URQotxzFj9nh+ZU/BMo2O0Gr0owIb2KaBrD6pHUp8WhRO1IJlBhfs52tTSndJ5IMjltE
         VAAd0zO5VzL4eEKCfLEMtfKAsBTvtU7VugzeS9XDylWMYyYvJl0No1a3oB8BcU8oB1/8
         /GnrNNygC56t7lf15nSIsKh1KKBFM7CEEArqPNHI2M1/BOGa/I6THmCwFJCmP8zdXhIf
         z7BbWzR5gq0imSNv+s7QbRiwHEotles0MlibqwTvjKRyIhQoy5TIq61oF2QgtXobXjZq
         Vy6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789316201; x=1789921001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jsnF78NUUv+8VlEEcl32uDIptLYHRKapZg385T9AvHQ=;
        b=jBGi4HFRnNhERf3oaJUmmah55uYsqewF9JV37V2mKTdRI/4GqPcXfBKakbGmj40d1m
         jkWVPgC5jtgUHIiwpoWxSxLSmzeqfDpdbm3P7zqWB8mFKKUsp/bnUA8/DCihTcehQ1hu
         ZEDrKaJz1fOCXIGtH1uixFb28dIEFuHbigPJDJbGxaPLqWzengQ4IYilWwndJ93a/Og3
         5SanQzODXEJwF/2X6KX6M343G3qswNjNPl8hrpodG6k3HqcPyg/bBL/JfO+UPSlJUd0E
         w3sdQO8UYzlDoroqOuuO/wb3a9A0N8eu4tCQih8Y7Oq43Nd/saPdyl2p+rBVlOy/DWMd
         zehw==
X-Gm-Message-State: AFuF++kXRPXwMyntHDNgY4S613nQP5k4vNBbIfIU3AugQQnuOkRDi4UE
	24GWECPgiTUe5HdpEPu2SzAZGSVabPTRRkRVQFlx0vvgDPaeZXrnU+Ls2GN2QRKvevl0w6IpEH5
	+xK2wmFA0Vp+59SHmu448ICRzw2WScHLnVt49LDYkDkIIMseoH1BdCvMg0pkdGG85ME+62t7q
X-Gm-Gg: AYBFou31ihvU6jyzJMuwZfV4gZf1gIvm43p5qAJjMaF5yy0D0mYGpqT6EBjIMW3KOIj
	TXVBCSbrWaJBiM3QZ+KAuOEc5JyC3pnYvC6RnH4qz211VDl0Nm4NogJya89ASsA2ZSklBprPkg/
	mTpoDe+EzEWBoQtxppDC3hfl9Z3SI4tUyuHw4wA3MR5FVgk1Ckh2rnDMIEeVhz+gP9tlKo/5ZcA
	wnIXS9N5JpRuGncUL1F9b/P8yCm/J3Y5of2r9ECwFOZf+ZbMI8yg88Edr3/Iq8zuewb7IcQIZT1
	qNsfqhwREiSbpcHvOPeXe5y9Sf+GYV1vkBwbJ4T7G0+8O4VUEYK77K5onLJBiB3Dnil+rggMU7A
	62x0RrqxmHVxdBy1NPWgd3kDJ0MogE5tvJvKkW7qNt++z/aBTEmf+2hAcIW8=
X-Received: by 2002:a17:90b:53cf:b0:380:540:d499 with SMTP id 98e67ed59e1d1-39dbbeb3c67mr13414623a91.6.1789316201288;
        Sun, 13 Sep 2026 09:16:41 -0700 (PDT)
X-Received: by 2002:a17:90b:53cf:b0:380:540:d499 with SMTP id 98e67ed59e1d1-39dbbeb3c67mr13414405a91.6.1789316199873;
        Sun, 13 Sep 2026 09:16:39 -0700 (PDT)
Received: from u24-san1p10108.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba7a9bb56sm21932939eec.31.2026.09.13.09.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 09:16:39 -0700 (PDT)
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: virtio-dev@lists.linux.dev, stefanha@redhat.com, ebiggers@kernel.org
Cc: neeraj.soni@oss.qualcomm.com
Subject: [PATCH v3 0/2] virtio-blk: Add inline encryption support
Date: Sun, 13 Sep 2026 09:16:13 -0700
Message-ID: <20260913161628.368484-1-linlin.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: uUriow8a6MpO-2qy521dkpm0nwICfQNT
X-Authority-Analysis: v=2.4 cv=Pv4G/AM3 c=1 sm=1 tr=0 ts=6aa6cc6a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=x7hn7aeetCaAfwo4AHYA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDIzMCBTYWx0ZWRfX67fTkZOUDr2G
 qhKNgzXQhScn7WHkWKkP47aeBvvY0LAIiRDYs2IiVe+kNu54iXc9NNHI6lFcXPbIKWHAKDZy4RV
 9acPw//6kNmkUO65kS173/M+v0He82U=
X-Proofpoint-ORIG-GUID: uUriow8a6MpO-2qy521dkpm0nwICfQNT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDIzMCBTYWx0ZWRfX77BgY9vg/d5t
 xf1TLUeFmf0vErQnQ/umlwpWc1IxTFgzSNBfKqzQuruTv0ztymsGZBKgo9kOM2inYEKcBHzWF8B
 B5Ai1tjVzf+82+yFah7vYq5/WXYKGJA+uuPjw5NqjAscvihlnzkWiaaVc4dfQeT7D8jDi1g8AmX
 JYUokg6lzbXlYcPOr2/c9+lQX2XiLrDOq4hc8BRt6SDNnNxAOvraTWDT3V4hTbgZ7GaXV7IztCV
 MqYuMFy3KGuT15BbZM5irA35ydyxX9Bf5cGdD3tOilg2IVDGCcpLsZcQ9BT/LVeIh1sJCMEbcAC
 iphpytVnRo5iF4RxWkesW6Ld8LXCJVImqlUaM0PWXPsJpRFiVSEv9Qxgmu+S6Onwy/hSA+u85si
 nJ/BzpRIayF+K5bJbAZJgCVDGc9xrmFR8MmTvm/3t/tXhu+bshEx1mkZj10VugAI1Twcx1JwwNC
 5wVR+cre/hy6H9zyNQA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609130230

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

 device-types/blk/description.tex | 457 +++++++++++++++++++++++++++++--
 1 file changed, 441 insertions(+), 16 deletions(-)

-- 
2.34.1

