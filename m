Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794310474;
	b=fRSuK63s/5Y5bVHyQQllxFAZlBRahIaSm/Y8N+HhvO7Lukl3nJRlwwxaIjYaS8uNrHp4
	 r4cOhClOKsMoYn1BtPt+F3JG3iGzhbCH4G4AouBA+hok+lG/hSYFfJspw9fHwmUf6uDfo
	 NfCKy3ooVgf9OSDgd2FGeENHyGS9aTcDdviVabuaGceJNjd/irv2OH1jkqpYz3SllZ/8D
	 Q6a1tCLUxCj9ZLVkCTBN5Rvd2Q5SsnTGqvOduc6blVlYFlm5cQW2kyZG2VjKWJed02pvG
	 03RtYwky/nR93H8rDpiopMDXga4sQ8S4GZlQV1c31pD56DkmTxEjPckjCNj0cItrBHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310474;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=N2RrdInhgyeVJm/IQppXSOIoap28k6YqZ5ZwNk7Uev0=;
	b=mdZRMx5KGP7BgcLWtYdnii+sLaAnDhW2E9A6QrFqEgFxF0PqJq/AF1Yt7zuOkNtWCFqg
	 SlQsmbmogNlnzNX4OoybMXcgeUjZgvAmYtYc+qcD+ClrWQKaG4Kg7fdIKQrRi8EvG8edF
	 uG6dtamqwg7cQKyh6M/Aeyfv/fYnzMV5epYpeFb2b313nYc4OkNGZnOpkp5lqq7F7NaaX
	 obr9y9TwhOolo8hRMMLeAkQ8a60r9ebQbELrjg6nWoJlv70Tl8Nc2FhkmidEUAQa1BPNQ
	 AUwlrwrjBzL9+hzemr8cGxjl0BAAQ+A2c1DbcwBy0LH2t67L+i7dpTPLKajOHtfL8gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=flPNPfKS;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EVlnsZuo;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA03606A32A
	for <virtio-dev@lists.linux.dev>; Tue, 10 Nov 2026 11:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FA03606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=flPNPfKS;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EVlnsZuo
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AAB9uOh3195889
	for <virtio-dev@lists.linux.dev>; Tue, 10 Nov 2026 11:34:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N2RrdInhgyeVJm/IQppXSOIoap28k6YqZ5ZwNk7Uev0=; b=flPNPfKSadZYFRVO
	s/KVyk4kMjNYo8SSXus9gGsN1i9m0XhzRhm3/K2RuY3p9Pca3v0EIbNEo6z3Ashi
	1RkPBStkhnYU9qjWBR5J11d9Kc/HwEqgEsPh08E4icK5XTZdmghWo2VNM4Oa0TCr
	x1U84YKOPtLDx9heHr1Yjj04gt6Vv7Ct+jFHggq5X9HW48LQGMZvFtFhkyDmwX3R
	LgmgxO+nx3UMZADlz+JRxRYEdJZTCT1T8BxwwrfV9jrCkg6ck+eHabMyGVL+q8Bx
	XvY4u17VU/uDfMpGsgH9SgsbvWhjH2dZrKj1FZ4M9Rh4P/QRk39kJ0EElsGDtBYD
	DnVUjA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv03crjse-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Tue, 10 Nov 2026 11:34:31 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso4013045eec.1
        for <virtio-dev@lists.linux.dev>; Tue, 10 Nov 2026 03:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794310471; x=1794915271; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=N2RrdInhgyeVJm/IQppXSOIoap28k6YqZ5ZwNk7Uev0=;
        b=EVlnsZuoBEAQoi8/HmRy+tqZfnlLQGBEHxNBUddjX8w3mTetBafvi9oVWyUjtL2Zd4
         uuVg9vSG5JMbrww9B7x43vM+AcGbXsDoANVBoFqIOupqGQ24Zg4En1KOzzryqqC6nhDZ
         FIqYrL59E9LKwdNPf4+h4MSZnUC+1F8vw25YSmnCNODqLG13QoesdChI4BtvtfEzeBmj
         hi5VoZnA4qV9RbqIVcBqjgBle65SCLLUpK0ihk9SMxo1uh+iaqd/+TQvVwLky5V8DpiS
         hV8D/XFseOlKBCitMNhDEvhKEpZ5AfWq1AJzb0waHovXQezmIe4APJ380dgn6LMIqFD+
         kh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794310471; x=1794915271;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N2RrdInhgyeVJm/IQppXSOIoap28k6YqZ5ZwNk7Uev0=;
        b=2PxlwiQVKMXtiwADe676k/pUSdLyUIr8YAx+FL4rUPhJICpj02175HYHPKNYHaWVdh
         +XpxRBLDHlW/MXoqrKccs5KxmDqe/cAdjBAsQK9gpkjVbWWhsm7W/6z62ebYUlmM3Qk4
         Ehix1SMmIqQOkgUigQAeAtAMplvx1YEKtkuqYCpJEmMrD6OtewAUfphUJcEnA4Z1Z/Kk
         P9ay/EleqzK/N5JVHnmLBEwye4igSvXzae6Dr5nE5edmYj/M5QZj55otRsFYAvtgpVwe
         cO1hw67lyc2gHrwlbe5uXHukv9utYg/dAa9l3bsvvNi9ZPmY9pJG0yPc+/9kESdc4aO/
         N9hA==
X-Gm-Message-State: APuU4Z9nvzOpLw5fpIZoyGRqpx0Ml0FJzU3E0EhseMx58BF51bbkR0Iw
	R18avuV1lJK7Kk0Kv1arIxM69nk9335QdyFzwhrOtMSW51fdIBw1rotUflW7q6XMTGwy76Nj4mD
	14J0lhAMjWmIxqlF3WDknlKnSb9oAxtlBynJFpsHw7HWg6Z3HP1ZhEOs7IN8sGgixgj9IZz94
X-Gm-Gg: AYBFou2nl9moJLOVtvtP01lcP5xOgB9XUo+k+KBm1Gs1XMTfCEC1Z7Nb0Te0sbK7H3C
	vueJLIZ4W+LslCOI8oEfkDsZE46G7QHh5RjOHsW/YWEnvkToIKUVPRUboBpi9lnQ4zsby6lPcU1
	lK4ochGpjmEE5TMVaigtI1gtQlHbL6UUSBhBRPRNP1jeNCDBbgd7/e7B5994Jp+aXDg+ZMNkI8C
	1Qp1ifmNuQK3CTCvR2hn42LDkI7oDJqRHAVXQecGrqi7X1J3MMfUm5cv0KD/04WaE5l9kiyYNwz
	Rhbea9gQPl6ThQXsX0zJDmsyIdrzMebhq0DhEmieAA9O2WzirZM6NRiwa6Pp/oyxhR42SJra7bm
	zg9hmsA8guQjVkeC8oD6HeWWlbFsggW8SqknbVWcZBeHG7fy1gR188pue8ei+aUv6/g21+/HjIQ
	FqNpYnnOVijdk47DxYEflqba7MVIbscN4=
X-Received: by 2002:a05:7300:e3a7:b0:374:c5cd:42cf with SMTP id 5a478bee46e88-3751fc2fb74mr2662981eec.35.1794310470374;
        Tue, 10 Nov 2026 03:34:30 -0800 (PST)
X-Received: by 2002:a05:7300:e3a7:b0:374:c5cd:42cf with SMTP id 5a478bee46e88-3751fc2fb74mr2662949eec.35.1794310469664;
        Tue, 10 Nov 2026 03:34:29 -0800 (PST)
Received: from [10.110.17.252] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751ad6f11csm5765856eec.0.2026.11.10.03.34.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 03:34:29 -0800 (PST)
Message-ID: <ad33bea1-cd2e-4379-a150-7e7d5976f373@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 19:34:25 +0800
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Post: <mailto:virtio-dev@lists.linux.dev>
List-Help: <mailto:virtio-dev+help@lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtio-dev+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/4] Add inline encryption support
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: virtio-dev@lists.linux.dev, virtio-comment@lists.linux.dev,
        stefanha@redhat.com, mst@redhat.com, mgurtovoy@nvidia.com,
        parav@nvidia.com, ebiggers@kernel.org
Cc: neeraj.soni@oss.qualcomm.com
References: <20261027090945.185178-1-linlin.zhang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261027090945.185178-1-linlin.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: U89wi0A-QyUdAo99c6IZYoDvlfkeMXzh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA0NSBTYWx0ZWRfX8u+m3tQlubII
 L7vChjwKbBXQizeHE7qmZqzk1lWAbLpvCmoXggn56+9kGx30H/TL2nBh6J4kRJKaPqQS+7e6EEw
 4C82grjdRoQ1nHw/EZu1yOWM7bqfKH0=
X-Authority-Analysis: v=2.4 cv=FuiQbGrq c=1 sm=1 tr=0 ts=6af30147 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=AnHlLwozOnVvmI4e6GkA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: U89wi0A-QyUdAo99c6IZYoDvlfkeMXzh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA0NSBTYWx0ZWRfX6/M/lPK8ywsN
 fNtWk23bM5NHHrwPMpgV2VIRz8i2vebTzebHMqmZL9IK7ovY/MR461eiV+TnCkHLxxSCf37hfU3
 kml7IOI1K4Q0LHbC2T4gv+EmhXuYNbpoximUkj60z1miYvTHSnzmzKNHLF5L0c/ScJelksdwR6r
 KOUuiTmBuo/68v3JDOdTv4yhKjyU8K687iuubqYUprLku2EVWVUkrnw+673V08uA/rLbFmYTjMd
 PDQT+Nbo04DeAwE02BpmvwfunjK9ATnuJOu1f8oVRehjYC7DsjaQF8x6TRtifeYR5WsL8MWxAAn
 JPgrUl/2Ca3QL1Ki5XpFbJ0mixOHy89cxU8O8zupWlqooyNwfkMoJIrkAR64ZBcI6PhOaomO9U8
 2/HMD3md/qqTdJct2fes7JV3ytqpxsqwG6uGlDnAHasxiwPD8o3NGs+7Gt/SPMygHyFgzGriDrF
 JJFqgHOwK2aL3Arw5Tg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100045

Hi all,

Gentle ping on this proposal.

Following the previous feedback on patch 3, I have updated the inline encryption key management interface to use the Admin VQ instead of a dedicated virtio-blk VQ.

Any further review comments or feedback on the proposed specification changes would be greatly appreciated.

Thanks,
Linlin

On 10/27/2026 5:09 PM, Linlin Zhang wrote:
> This series adds inline encryption support to virtio-blk, for devices
> backed by storage with an inline crypto engine, such as UFS or eMMC.
> 
> The device reports its capabilities in the configuration space: the
> number of keyslots, the maximum Data Unit Number (DUN) size and the
> supported key types (raw and hardware-wrapped). Keys are managed, and
> the supported crypto modes are discovered, with group administration
> commands of the Self group type, so the feature depends on
> VIRTIO_F_ADMIN_VQ. Encrypted reads and writes are still submitted on
> the request virtqueues; each of them identifies a programmed keyslot
> and carries a 256-bit DUN.
> 
> Patch summary:
> 1. Add the feature bit and the configuration fields
> 2. Add the administration commands to manage the keys and to query the
>    supported crypto modes
> 3. Add the encrypted request types
> 4. Describe what inline encryption does and does not protect against,
>    in particular for confidential guests
> 
> This series is independent of, but is intended to be used together
> with, the series adding administration virtqueue support to the MMIO
> transport:
> https://lore.kernel.org/all/20261017114556.1701355-1-parav@nvidia.com/
> 
> For background on inline encryption, see:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/block/inline-encryption.rst
> 
> The new administration command opcodes are allocated from 0x0013, not
> from 0x0012: the group administration commands table in the current
> specification lists 0x0013 - 0x7FFF as the range of commands using
> struct virtio_admin_cmd, so the new commands start at the first opcode
> of that range.
> 
> changes in v6:
>  - Remove the dedicated control virtqueue and VIRTIO_BLK_F_CTRL_VQ; use
>    group administration commands of the Self group type on the
>    administration virtqueue instead, with opcodes 0x0013 - 0x0019
>  - Change feature bit VIRTIO_BLK_F_INLINE_ENCRYPTION to 20
>  - Require VIRTIO_F_ADMIN_VQ to be offered with
>    VIRTIO_BLK_F_INLINE_ENCRYPTION
>  - Never offer VIRTIO_BLK_F_INLINE_ENCRYPTION together with
>    VIRTIO_BLK_F_ZONED, as the zoned write constraints do not guarantee
>    that I/O addresses are aligned to the encryption data unit size
>  - Widen max_slots to 32 bits, matching the 32-bit slot fields
>  - Only report the commands in VIRTIO_ADMIN_CMD_LIST_QUERY if the
>    device offers VIRTIO_BLK_F_INLINE_ENCRYPTION, and the
>    hardware-wrapped key commands only if the device supports
>    hardware-wrapped keys; fail VIRTIO_ADMIN_CMD_LIST_USE enabling them
>    if the feature has not been negotiated
>  - Define the long-term and ephemerally-wrapped forms of
>    hardware-wrapped keys, and which form each command takes and returns
>  - Do not program or evict a keyslot while requests using it are
>    outstanding
>  - Change struct virtio_blk_crypto_key_desc and struct
>    virtio_blk_crypto_key_blob to use variable-length arrays; the key
>    length is given by key_size, and buffer lengths follow the generic
>    administration command rules, except that a command fails if a key
>    would be truncated. Remove VIRTIO_BLK_CRYPTO_MAX_KEY_SIZE
>  - Empty all keyslots on device reset, and fail requests using an empty
>    keyslot with VIRTIO_BLK_S_IOERR
>  - Report a failed GENERATE_KEY with any status other than
>    VIRTIO_ADMIN_STATUS_OK; require a successful DERIVE_SW_SECRET to
>    return the whole software secret; KEYSLOT_EVICT ignores all fields
>    other than slot
>  - Add a 'Security Considerations' subsection
>  - Split the series into four patches
> 
> changes in v5:
>  - Change feature bit value of VIRTIO_BLK_F_CTRL_VQ and
>    VIRTIO_BLK_F_INLINE_ENCRYPTION to 20 and 21 respectively
> 
> changes in v4:
>  - Add a control virtqueue specific subsection for virtio block
>  - Move all control virtqueue request related to this new subsection
>  - Add the precise semantics, error codes, etc for the new control
>    virtqueue commands
>  - Move 'MUST' to the normative section
>  - Use c struct to describe control virtqueue request
> 
> changes in v3:
>  - Add a control virtqueue
>  - Move key program/evict/derive_sw_secret/generate/prepare/import to
>    the control virtqueue
>  - Add the driver and device requirements for the request in the control
>    virtqueue
>  - Extend DUN in crypto message to a fixed four-element array of 64-bit
>    fields
> 
> changes in v2:
>  - Remove virtualization-specific terminology
>  - Move MUST sentence to the device/driver normative section
>  - Add explicit rejection for CRYPTO request if IE feature bit
>    isn't negotiated
>  - Modify the support list of crypto modes and the definition of
>    the size of the crypto modes buffer
> ---
> 
> Linlin Zhang (4):
>   virtio-blk: Add inline encryption feature bit and configuration
>   virtio-blk: Add inline encryption administration commands
>   virtio-blk: Add inline encryption request types
>   virtio-blk: Add inline encryption security considerations
> 
>  admin.tex                               |  16 +-
>  device-types/blk/description.tex        | 827 +++++++++++++++++++++++-
>  device-types/blk/device-conformance.tex |   1 +
>  device-types/blk/driver-conformance.tex |   1 +
>  4 files changed, 835 insertions(+), 10 deletions(-)
> 

