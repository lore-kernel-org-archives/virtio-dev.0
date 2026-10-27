Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793092201;
	b=I12OrBIp6GNxBNLgBhrvKZQs/63J5bsmtSKSxaFGS1lNCYIRBH4AJw012hFla7WCoa21
	 pgXAahEX5yGlhoZcCJM27VdOMEM1gzkFcqb1SC3nvVDCfkeU49NzCu/gAhUMWQsk9dnll
	 vN17tI2Teci1tw416bg3gVnn2XrargNmbAKQSyjpp4IQoS9e7ZgMXn7dIZ3v3sPP8Q0dM
	 qfuefKzD+/xXpCRHnyiYawvXnbCMIvVUqj3GiDhkd5vE8yyR8ldWhOCLXVLeSqApbLs4w
	 TyIUssu0ZtQ77B8X/6HEwdiIPCY9FWdRNM8ztcJT7dEuGJ/rCPyLrQnoqD9l0G4wDsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793092201;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=kecHQ9Cxgo+QuEHQWjjKTjxkwSfnlCL1FZxMG4Ytnco=;
	b=NvaGCsj7G6jmbxQ5BfXKIyXAASY0h/V/NVuDZKW1OyHivbWdG2RtQIwkte+0Jgi1UaH5
	 1889GXn4tRLWkAxcTSOped/ADwVcpxAhcTLvnM3BfhgxAij5oOT6K5Tpla+sJVfNhn1kW
	 W/aMJi+O2L3IYkqg0zyPZvsU32VvEtA9HJaQ+anwzK/RH7z/YK1YWwT86NlzDiGsRcswA
	 RQQbqYWDajZhXbgaow7rB+dV2MZtmkLhu7/AP6VKTP/tBCBXzrKVtEkUuI9yG8c24ZoXY
	 7ih9cWWuFoZB0mri4iIRp9Q1OyJxTK7l+S/6Qr3shHbdmZ3CSNJlKXl5+7p/ir8LYaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=f5SDlwkN;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q9e2igHC;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D404606A31B
	for <virtio-dev@lists.linux.dev>; Tue, 27 Oct 2026 09:10:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D404606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=f5SDlwkN;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q9e2igHC
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69R8gdWW1709190
	for <virtio-dev@lists.linux.dev>; Tue, 27 Oct 2026 09:09:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=kecHQ9Cxgo+QuEHQWjjKTjxkwSfnlCL1FZx
	MG4Ytnco=; b=f5SDlwkN+HVoPhgSRX+zO3Iue7eh+eJFIDme2ePmnkJLKmtKfun
	alwN/LKGm+i0uswx/QOCXnrca1lzJbRJTPwMdvAkmlLUFSPEV+rafI80lu4WO88F
	rfcp+ZeZCij31cBhcP5tiePWX6q1/G+NcvDgoqzintw6KWqNeaYnsNw6HP7Yddd+
	tD/ZsE3w5XymdxaFmwKdJ5OHYTlNzKF9VkbM3UytnlG8vTLHGFjLK380oRqGELrP
	ij7Pg3YbypEDfi6jA7LlpZcQZbzC1ZrzIyv7nhvZdpG1sqba7mgeqKa+hQrQXMaS
	NbYWK2yyYER7wjD6idwADXL6oph4LLZMWQA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj79xv24r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Tue, 27 Oct 2026 09:09:59 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3adad90c894so4237533a91.1
        for <virtio-dev@lists.linux.dev>; Tue, 27 Oct 2026 02:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793092199; x=1793696999; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kecHQ9Cxgo+QuEHQWjjKTjxkwSfnlCL1FZxMG4Ytnco=;
        b=Q9e2igHC8UjKdv8yi7MWxVdyn2ksH9H+NUbG769mKRt7BzPPUWItAODNUx2AQHdXV9
         yd7hSkiy46y0W6/yxF60br3P+wXsLD3VZS2FnLERh6QkAadV2q3BJgxhfmxs/1MUbqhm
         Bg9WyoH/YlccaG6xNlcpmpjLNtfU0yVABgfDwPa1NRuXhiCMiURLO5S+HmbDfkereadr
         MXkAyP662slLZDcn+9SXOmpsKp81ZtMaooauthgz97mvCUshOlKRQzmNb3SkZf9KwU/T
         yOdXdfaxVyPREWiq9m6Oqru9Kk8HfBHytHAEa1mdPTXJNKx6HDyVwJ58ImjGum6HUjey
         /bxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793092199; x=1793696999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kecHQ9Cxgo+QuEHQWjjKTjxkwSfnlCL1FZxMG4Ytnco=;
        b=HyVvRwgC5t7iWvmwhoknUtHDsPRORL/HP//cKSqFY6269SEMvgB/CxsMK36I8DITm7
         eturfd38CCWMtTwyK0sYaaFrujBqJruyiv75EBm8QczJO/vMvFszD6YnVC+3hV8A/GHP
         v5XPlo+9Q8BTKMFQxWl0D1vEuJ/37M0nvu+asEmApNhIPUzv4EDmgPrlV8lENv3bEYk9
         nH4xe02VK9Dh5p7dWSliI723vMe4sITREAVSfxt7kEvJARkyeHywLdg5VviiTTlO3vNk
         Hmq5okcwWE/Frt4NRYcuBQufCyG81YC3rPawVpaF2GkBtjamdVh3pWKnFwH9lw4hgfd+
         mMFg==
X-Gm-Message-State: AFq9FYLgnTiSny7dqjRZ9C2cSEJ2wkKcUjkjDFfV1Jiy63bGLBZ7rfXQ
	tYlqoCWf10Z7oBWfTe3gcE7GVcJLR8I2yf/u1eHg4GVp4sReewnmc78T8ImF0Qf+BA6OVyCxu4+
	NOOyEU+K871uAHiwSrGABu+Ibm8WFAdsseXqcoEQHn101wFZiyt/NkvbQu+QfuYe+BF1J3V+7
X-Gm-Gg: AYBFou0/aapqby5a13PuHVKIitXJ82N/Ti2f8HNu/PuhvV9v31I3CDlfF9neZInQfRM
	rZiwkwFCNktU0a6ALk8lho81a0Cb96g7kBa6RTjWLRy9BYUD2AoUUskqC9/lv/apq6Q26OIPD5v
	V4YShWsf4bq1VVzhXE0P+hfRbUk+ui3W7JvOmD2TmUE1XPgABtF3nJymwIg3o7pLzV6MXQs6nXJ
	pArLaH2dnnYt9D7jkJp7GcuU5KcdfVtpbxsHZ4JzQrNBHiQuZRNsbQiMHGq9MxLo+nBaOWzrNrN
	5sTHc5JwXeBQ0OOJD77uuf+Ho9lwnYpmIUekUgDeaOhmyeiSJrjgmqD2v7xh+2zpOmNHqk2uceN
	++Tlkuh+IPPJo6lDectf4rroPEhwYlist1W6yUDMCeJUEj09bAMoUfNkTbA==
X-Received: by 2002:a17:90b:3d4e:b0:3ab:884b:65b7 with SMTP id 98e67ed59e1d1-3adead55564mr7437113a91.25.1793092198324;
        Tue, 27 Oct 2026 02:09:58 -0700 (PDT)
X-Received: by 2002:a17:90b:3d4e:b0:3ab:884b:65b7 with SMTP id 98e67ed59e1d1-3adead55564mr7437094a91.25.1793092197810;
        Tue, 27 Oct 2026 02:09:57 -0700 (PDT)
Received: from u24-san1p10108.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae404426c2sm2940522a91.7.2026.10.27.02.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 02:09:57 -0700 (PDT)
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: virtio-dev@lists.linux.dev, virtio-comment@lists.linux.dev,
        stefanha@redhat.com, mst@redhat.com, mgurtovoy@nvidia.com,
        parav@nvidia.com, ebiggers@kernel.org
Cc: neeraj.soni@oss.qualcomm.com
Subject: [PATCH v6 0/4] Add inline encryption support
Date: Tue, 27 Oct 2026 02:09:23 -0700
Message-ID: <20261027090945.185178-1-linlin.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
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
X-Proofpoint-ORIG-GUID: 3FdTulGccSnbFlzF3xjGjeBthVQgaFeT
X-Proofpoint-GUID: 3FdTulGccSnbFlzF3xjGjeBthVQgaFeT
X-Authority-Analysis: v=2.4 cv=FPyOVOos c=1 sm=1 tr=0 ts=6ae06a67 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=Ikd4Dj_1AAAA:8 a=P-wNOC4C4cACZxsgl2cA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAzNiBTYWx0ZWRfXwo7SrnKaVIEO
 sEBmsPNEcYfZrmNhNpMIRPxoGeSTaMB/C8asrZGDfjABg2DxdvmaumOKfgtAkS05JXBqAp66TbT
 6dazZRJ+Jzx4eqPaJBpfz9el/Xpj8VCfqREKZ31Vi4uVViCZa6hf0dPS4q8KLSNZV4GiKU6FjGx
 9tSQ6GvHikpmpaP0WqYW84biwjwSqrfbSf0IDEggZZymRX3koMn1Vz3z3mDZ3o4LxBAWwtga1MX
 sqttexc8N9WdtQo1IegYBis077TjmVf7ZRai2av6a14FD1qF0UJ8G9QR4lwf/1UldYpEc79oQFT
 Us1STJdtmx4rtAQcyuO3G0IeESNQwnXbHqunqqKOVMvB+XhHKWH/ZViKEwCQrq8LkNXopOQWAv+
 9/hqtFVeo1S7RYUv7ScxVFbXZ32ywyxicuZULg8eXLDS2wQxQOFqiYajqjT28u7KyYsihUl67Rb
 lvfRwe56DjFoiwvHnyg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAzNiBTYWx0ZWRfX/kkzH8Pp5Tyl
 iEks2JybWJ6gfcJi5FMhSr7iVNhzrTp4zg1UBX9dyzpy6mTrzNuEDUhv9TyMzpuINFLcWREv749
 zRneCo2q1UjJYc3VnhiIrrlz5T/tm10=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270036

This series adds inline encryption support to virtio-blk, for devices
backed by storage with an inline crypto engine, such as UFS or eMMC.

The device reports its capabilities in the configuration space: the
number of keyslots, the maximum Data Unit Number (DUN) size and the
supported key types (raw and hardware-wrapped). Keys are managed, and
the supported crypto modes are discovered, with group administration
commands of the Self group type, so the feature depends on
VIRTIO_F_ADMIN_VQ. Encrypted reads and writes are still submitted on
the request virtqueues; each of them identifies a programmed keyslot
and carries a 256-bit DUN.

Patch summary:
1. Add the feature bit and the configuration fields
2. Add the administration commands to manage the keys and to query the
   supported crypto modes
3. Add the encrypted request types
4. Describe what inline encryption does and does not protect against,
   in particular for confidential guests

This series is independent of, but is intended to be used together
with, the series adding administration virtqueue support to the MMIO
transport:
https://lore.kernel.org/all/20261017114556.1701355-1-parav@nvidia.com/

For background on inline encryption, see:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/block/inline-encryption.rst

The new administration command opcodes are allocated from 0x0013, not
from 0x0012: the group administration commands table in the current
specification lists 0x0013 - 0x7FFF as the range of commands using
struct virtio_admin_cmd, so the new commands start at the first opcode
of that range.

changes in v6:
 - Remove the dedicated control virtqueue and VIRTIO_BLK_F_CTRL_VQ; use
   group administration commands of the Self group type on the
   administration virtqueue instead, with opcodes 0x0013 - 0x0019
 - Change feature bit VIRTIO_BLK_F_INLINE_ENCRYPTION to 20
 - Require VIRTIO_F_ADMIN_VQ to be offered with
   VIRTIO_BLK_F_INLINE_ENCRYPTION
 - Never offer VIRTIO_BLK_F_INLINE_ENCRYPTION together with
   VIRTIO_BLK_F_ZONED, as the zoned write constraints do not guarantee
   that I/O addresses are aligned to the encryption data unit size
 - Widen max_slots to 32 bits, matching the 32-bit slot fields
 - Only report the commands in VIRTIO_ADMIN_CMD_LIST_QUERY if the
   device offers VIRTIO_BLK_F_INLINE_ENCRYPTION, and the
   hardware-wrapped key commands only if the device supports
   hardware-wrapped keys; fail VIRTIO_ADMIN_CMD_LIST_USE enabling them
   if the feature has not been negotiated
 - Define the long-term and ephemerally-wrapped forms of
   hardware-wrapped keys, and which form each command takes and returns
 - Do not program or evict a keyslot while requests using it are
   outstanding
 - Change struct virtio_blk_crypto_key_desc and struct
   virtio_blk_crypto_key_blob to use variable-length arrays; the key
   length is given by key_size, and buffer lengths follow the generic
   administration command rules, except that a command fails if a key
   would be truncated. Remove VIRTIO_BLK_CRYPTO_MAX_KEY_SIZE
 - Empty all keyslots on device reset, and fail requests using an empty
   keyslot with VIRTIO_BLK_S_IOERR
 - Report a failed GENERATE_KEY with any status other than
   VIRTIO_ADMIN_STATUS_OK; require a successful DERIVE_SW_SECRET to
   return the whole software secret; KEYSLOT_EVICT ignores all fields
   other than slot
 - Add a 'Security Considerations' subsection
 - Split the series into four patches

changes in v5:
 - Change feature bit value of VIRTIO_BLK_F_CTRL_VQ and
   VIRTIO_BLK_F_INLINE_ENCRYPTION to 20 and 21 respectively

changes in v4:
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
 - Remove virtualization-specific terminology
 - Move MUST sentence to the device/driver normative section
 - Add explicit rejection for CRYPTO request if IE feature bit
   isn't negotiated
 - Modify the support list of crypto modes and the definition of
   the size of the crypto modes buffer
---

Linlin Zhang (4):
  virtio-blk: Add inline encryption feature bit and configuration
  virtio-blk: Add inline encryption administration commands
  virtio-blk: Add inline encryption request types
  virtio-blk: Add inline encryption security considerations

 admin.tex                               |  16 +-
 device-types/blk/description.tex        | 827 +++++++++++++++++++++++-
 device-types/blk/device-conformance.tex |   1 +
 device-types/blk/driver-conformance.tex |   1 +
 4 files changed, 835 insertions(+), 10 deletions(-)

-- 
2.34.1

