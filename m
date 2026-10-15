Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7ED370ACA
	for <virtio-dev@lists.linux.dev>; Thu, 15 Oct 2026 15:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792079178; cv=none; b=b53hcRtvjCG+mGsdMxVBj+SGevkigZsGHX+ndBFnh8zRHJxId2248Y4mRFn2JWbWsS4na/6vqBH5/zf3ia/9BpNQ0E//diHS8jR5jUOT6HitzeYcfVjGvsJUH+F5tbg4D+0AyqqspABEtiZScKv8yJkv0EkG4Jdmm+8RF8zaWZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792079178; c=relaxed/simple;
	bh=r4UAtq/PZDYyTBPERK5fOAq7vgoUUgK7K4r9N4+uP6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fv7c+DS1MbpdAjC329wOIQpL0mbFkcV+4IorcAQCqmJhVeeyvjQ4hnCRj7pHgndFuH40XSLQDKFo6/Y574J0Y3Rmq/KOl6mjswU/FZcISy3didQo4dclyofBNMMqNatRByYRmCt5gq7A9t0E4vtsBKzlW65hMIe6LzRt6/CwRv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EOASplge; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eGj9/wjo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EOASplge";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eGj9/wjo"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FAPuYX1596362
	for <virtio-dev@lists.linux.dev>; Thu, 15 Oct 2026 15:46:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6AkhA3lfVzyAgL1UK4uUbtJHT2agEV5WTwwlLPlxq0o=; b=EOASplgek7qLnxCD
	JFqwiuWOZ/bhUB2eR/KW+gX17UYu1P8jbOA8TO7FtcqI0/3rDRWuxFKkFctm9Agw
	8UwfvFwfgrpD6mPEzQOLqrgJ+E10qGIXCJqZFWZCTJrQNzSe2b0XWr9kCFIIEhPe
	aFU9TwWJdA2NOKdWveGWDtby0DmHxRZ1h2LrO1rS/0P4XHIZmukN4cPvfNQBfPCC
	/psm62SCxDPr39Cos72jsvheNO3CFFJL1hsNf7XGClpCiP9rVZ2xW5xxRLg3tWJM
	9ac2+z8Elhyjx6Q4heDJPOeAjxbss5T+OaqicG3AlOJOmFHX7hGTO+SbRDLOiE+D
	pToTYg==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haw2v98wm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Thu, 15 Oct 2026 15:46:00 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5e8078ac577so1644229e0c.3
        for <virtio-dev@lists.linux.dev>; Thu, 15 Oct 2026 08:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792079159; x=1792683959; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6AkhA3lfVzyAgL1UK4uUbtJHT2agEV5WTwwlLPlxq0o=;
        b=eGj9/wjooSwEE4wa9I9bYASWYhuFj5kLZwEcB7jMvdpPHW3UdS9jAc25g3z4fqPoB0
         BqTIr2dEJkfo6P2gswEOFLgp8bRsogpz4kYi2qcctABOkn5UO7gV5dJA6hkKZ63lW2J4
         cK0mWDHc7Bw5mOkPETsmv8w0LjnamqzPY+he90M3GV1DzssAaqP92QgjP0+JiGlP77pg
         cvOS93owG0qsc4Gffg9e9Eyg921GhEoB9ol4NH8YJ0Vl+PrwZZUZEUA4u5LO8tqNFlRw
         jlJ6LC68nak+7gY2wZIyiIkGc+1Dw9thzx/x5kdbnOQzr4X09c1gVVgNg59YQzTJsUXV
         xNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792079159; x=1792683959;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6AkhA3lfVzyAgL1UK4uUbtJHT2agEV5WTwwlLPlxq0o=;
        b=quVuJczRT2PdKAU6Il6PLRLjWrU5WiNxsufru451EnemYn5c87tjpJQtCHz3kAo6zA
         7joH40nEUrmfYrz2pTTlKRDJuLRrqzRz0tXLXkMgG/aOue1gzENuDtRifoERpQYupfzB
         nH1OjmTsHvE+w9bz9FBLUCv1hehpD8i0IaGCqW1J5T7e8Cj4+/Y5hzQ91mNWaui9Of82
         ICkcpufGCRVtwZ45+u262EQmmWSIeTQBBh6+BT5x4u3VQaJe9cXNo6kZwT4ILdlEggka
         rkylM4VV7ey2l24R0VXiHx7ZEOHeQX0xJNGr9j77fYNQ0WzbrbeXIFBFXTHNByoW3DxU
         pbow==
X-Gm-Message-State: AFq9FYIauR5v7akDQ8wBlv9B1c/pSaXKbtoPsQv0bCv/3Dna9Aybw9FV
	R/yXyz7jcVghh8QeAevnsZCWUqYmjAxGCYOlBYiYSVEpxz1pUodotu6QbzUQCRhn9s0niXLAQSn
	D8OZ/fFb838A64xplWn0vSNYa403jrMZ/tD0MYqvHnKp2UHjsY+l6nDlb6qpUr7lE
X-Gm-Gg: AYBFou0SuJPzZJ1jMKoHEtWI5spQ2zW+j66dUtxB+foVhbXjhR7fSlfu7DYIKdJSb5L
	Os3Hzaj9otvjGpuMxGTI2gPaMG0VhOlx8DyMmMQVkyb+pOlK672K9Si0PKOcd+3gw263Tq3Yqne
	R47CzNhCpwM3VkdGqtbkCr/WP71RE/QizQf9rDkT7BbbjLcOR/z1s5H2AYhVk8rsrwpN+W5Hyo0
	tMBtExRtK8B+ETc+ASk0GojaBQqSp+lcTGxQ92s/TnlP27FPj0X1zlluE0jYdmodIO59n/aIJDV
	k6Z3A2sNXiR4Bl+z1Ynkl/EqPV4KNttKEKHabvXLPbNodNQkv3Ibp1EMzXJkPSmGFnUoyB6FVtY
	WKTv+zQwcVO+QM1bdVGZiXcgXbmDWirVG7tkaIkWxL4Fibba1cqKxrc9P
X-Received: by 2002:a05:6122:4f91:b0:5c9:a60b:e5cb with SMTP id 71dfb90a1353d-5e91f4fba39mr6400334e0c.14.1792079159273;
        Thu, 15 Oct 2026 08:45:59 -0700 (PDT)
X-Received: by 2002:a05:6122:4f91:b0:5c9:a60b:e5cb with SMTP id 71dfb90a1353d-5e91f4fba39mr6400318e0c.14.1792079158549;
        Thu, 15 Oct 2026 08:45:58 -0700 (PDT)
Received: from [10.110.42.127] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5e91cb292a5sm13750053e0c.7.2026.10.15.08.45.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 08:45:58 -0700 (PDT)
Message-ID: <8c75e5ba-3f9a-4511-9183-4ebedf473a4b@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 23:45:53 +0800
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] virtio-blk: Add inline encryption support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.linux.dev, stefanha@redhat.com, ebiggers@kernel.org,
        neeraj.soni@oss.qualcomm.com
References: <20260913161628.368484-1-linlin.zhang@oss.qualcomm.com>
 <20261014054146-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <20261014054146-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA2MiBTYWx0ZWRfX0g/3iTGtExvz
 UxV1gbbBAPOz+yUFs8x9iNDrQM81eAurqbGWxsh7yEoFI5ZisPp8FVHjJgc56HHKeYMt3BQn60w
 ZBFDty4FkXawf8dYqJ6yAjTeJ/gwGjmehrkAphnsF5QgLb7BIfKz09K/pMKLCvKhfBNtl6LU0pS
 5uxO3darBAGfXkZ39LqkBrGovV5adlWMBcLvzJUEic2/8KuHxUCVvY5nownPJDDynU6VhyBKSBT
 BTo5Iw+w+hmRlnVFm2oDL/Iou/oOrKUMi1RmQ01ji9v+sghJ2jvfXxAvgczXJ5bYujZ8yr7WMGW
 1dBkVSxW2i4oJYRX4xS5Vg4P6KZE4c9qiWXEK1Et7o6prWCNtjwm0orpfH/Y8k+2xyikOG95oR6
 IHLioBK/P3VHzqquNKqTCJDOn56VggvrznyiAP8ZytTnblzVCWd4y9ntLSHRb2a1/n+NBTsNnrR
 i0Nt5oo0PpC39zwryyg==
X-Proofpoint-ORIG-GUID: krqsSL86uNO3kmPN_ePMFV1woF1j6Q3J
X-Proofpoint-GUID: krqsSL86uNO3kmPN_ePMFV1woF1j6Q3J
X-Authority-Analysis: v=2.4 cv=G/CJgNk5 c=1 sm=1 tr=0 ts=6ad0f538 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pCuJhOb9LoCgYOxXNk4A:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA2MiBTYWx0ZWRfX8uXNuNxbLzve
 SjE7eeFTVUJnLjIccXQmheU3kCCP6gVWdHfXQO4VbSsSUGXIZrZzGdDPPsWIVALJ4xRAT+rN62t
 yDdt7rM3NDHvpBX8RWyG7Fc6fcm8Ftg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150062



On 10/14/2026 5:48 PM, Michael S. Tsirkin wrote:
> First, this needs to be reposed to virtio-comment.
> 
> On Sun, Sep 13, 2026 at 09:16:13AM -0700, Linlin Zhang wrote:
>> From: linlzhan <linlin.zhang@oss.qualcomm.com>
>>
>> This series adds virtio-blk inline encryption support for devices backed
>> by storage hardware with an inline crypto engine.
>>
>> The protocol exposes device capabilities such as keyslot count, maximum
>> DUN size, and supported key types. Encrypted requests identify a
>> provisioned keyslot and carry a 256-bit DUN. Key management and crypto
>> capability discovery use the block device control virtqueue.
>>
>> The control virtqueue is defined as a generic framework so that its
>> buffer layout and queue placement are independent of any particular
>> control command. Inline encryption then builds on this framework with
>> explicit crypto command formats, capability validation, and keyslot
>> state semantics.
>>
>> All key related operatios are handled in the control virtqueue, and
>> the crypto I/O request is handled in the request queue.
>>
>> For background on inline encryption in UFS and eMMC storage, see:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/block/inline-encryption.rst
> 
> 
> What I worry about, is that after all the effort, virtio
> crypto is being deprecated upstream.
> 
> So please tell us:

Thanks for raising these concerns.

> - how do we know this will be different?

The intended use case is different from virtio-crypto.

This proposal associates virtio-blk to the existing Linux block-layer
inline encryption framework. The filesystem and block layer continue to
define the encryption policy and associate encryption contexts with I/O
requests. The proposed virtio-blk extension only provides the mechanism
needed to manage inline-encryption keyslots and submit encrypted block
I/O through the virtual block device.

Similar keyslot-management and per-I/O encryption-context models are
already used by Linux storage drivers such as UFS and eMMC. Therefore,
this proposal is not intended to introduce a new guest-facing
general-purpose cryptographic subsystem, it just extends the inline
encryption support into the virtio block device.

> - what was the response in upstream linux?

The Linux virtio-blk driver changes have been posted for upstream review:

v1: https://lore.kernel.org/all/d81e347e-8ca7-40a1-a428-5bce6f0d4b02@oss.qualcomm.com/
v4: https://lore.kernel.org/all/20261009041727.3170811-1-linlin.zhang@oss.qualcomm.com/

virtio-spec v1: https://lore.kernel.org/all/20260814142306.3934029-1-linlin.zhang@oss.qualcomm.com/

The changes have not been accepted upstream yet. The feedback received
so far has focused mainly on the design of how to handle the keyslot
management requests. I will continue coordinating the spec and Linux
driver changes, so that the change in the spec always keeps coordinate
with that in the upstream Linux driver.

> - what are some plans for use of this?

The use case is hardware-backed file-based encryption for guest VMs in
embedded and automotive virtualization environments. In this environment,
the guest uses the Linux/Android file-based encryption stack and the
block inline-encryption framework, while the underlying storage
encryption capability is provided through the host-side storage
stack and hardware.

> 
> I also feel this needs a security section, given how
> security sensitive this can be. E.g. is this safe to
> enable for confidential computing guests?

About the 'security sensitive', do you mean the key material transmitted
in the VQ? 

The security properties of the keyslot-management interface depend on
the type of key material provided by the driver and on the key-handling
mechanism implemented by the device.

For inline encryption with raw key scenario - an unconventional use case,
the plaintext encryption key is provided through the control VQ, the
virtio block backend has access to those keys and therefore needs to be
trusted with the key material. This may not be appropriate for
confidential computing guests where the host is outside the guest's
trusted computing base.

When hardware-wrapped keys are used, the control request only contain
the ephemeral-wrapped key material. Exposing the wrapped key through
the VQ does not necessarily expose the plaintext encryption key to the
host as the plaintext key can only be recovered and used within the
dedicate hardware, and cannot be recovered by the host/backend

Therefore, whether this proposal is suitable for a confidential
computing guest depends on the key type, the backend trust model, and
the guarantees provided by the underlying hardware.

Do you think if this trust assumption need be added in this new security
section explicitly or not? and also together with keyslot isolation between guests,
key cleanup on eviction/reset, and the interaction between keyslot
management and outstanding I/O?

> 
> Thanks!
> 
>> changes in v3:
>>  - Add a control virtqueue
>>  - Move key program/evict/derive_sw_secret/generate/prepare/import to
>>    the control virtqueue
>>  - Add the driver and device requirements for the request in the control
>>    virtqueue
>>  - Extend DUN in crypto message to a fixed four-element array of 64-bit
>>    fields 
>>
>> changes in v2:
>>  - Revmove virtualization-specific terminology
>>  - Move MUST sentence to the device/driver normative section
>>  - Add explicit rejection for CRYPTO request if IE feature bit
>>    isn't negociated
>>  - Modify the support list of crypto modes and the definition of
>>    the size of the crypto modes buffer
>> ---
>>
>> linlzhan (2):
>>   virtio-blk: Add the control virtqueue
>>   virtio-blk: Add inline encryption support
>>
>>  device-types/blk/description.tex | 457 +++++++++++++++++++++++++++++--
>>  1 file changed, 441 insertions(+), 16 deletions(-)
>>
>> -- 
>> 2.34.1
>>
> 

