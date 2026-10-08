Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518DE48F848
	for <virtio-dev@lists.linux.dev>; Thu,  8 Oct 2026 09:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791451069; cv=none; b=g9ofEWrXlCRmce+xPHim8iDLQ+RnJog84cECHECNjzXhD42mcWUcAN7eESmdtM07e9m3HZchK2Y9QnN7eEePckNvrYe1voNG4P4+FC2jGuKGTc+QA36qwgOr/bzbo9EpRQ7A8mMFj8cxDD3u9IMieP1Y1uHS6Rm8Dgoa3G+4s/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791451069; c=relaxed/simple;
	bh=+/xtBUCUMR20COen17OxGNuXutbrrVHRKRb9/91xz14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FhIyTwVGW4uAvrRKG1aqJz6YIq0V32tWrR03XOC3g1i1DubpyUq6DtE0hNE0EfG0GN5/fa92YEdpNaMwfFm7kiY+2pEgiIgeThgqG/y8Xnv/hktebm2rPd52ZK5r5AhlXmY7zpOtOrn9XDpCfqRiiNi7ZyI0xKiKDSKnLwaMhI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H0foOmb1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ChXYIb8k; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H0foOmb1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ChXYIb8k"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6987KE0t2560191
	for <virtio-dev@lists.linux.dev>; Thu, 8 Oct 2026 09:17:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h9bHa5lb5u1k3MPtTzp7OwY9EEzU2/HhVQyGJ5zxhtw=; b=H0foOmb1dTL6c67P
	GFqwss9qMa0J65yZhVTA9I4TkvA6wVF/leMBjV+Q9pF3JK0MmxbX6zb+yLUbdYSN
	vY0jq8HMnVN57aOzSnDT8g0+Cg+hH3SqNIin30G87CdSjewR9vlOPbf8dIw3h1Sk
	ux3hevqz5IpNuDTBNCJaGbK2m6/8WF8HMuOr9lUmkjPvIpmVNFuNlOIYxVGx7MfA
	KCIkptHTXiGSODBkxFhbBDMCgzQeC72XZnOjURYgLZZV3h7UZ1l/nxJywm9LFEJQ
	SZ6zDzujq4DLQoq9KWL+/+hvcA7mztCWJZgV3KtEO7q0QYEoNYq8+ZH1yCVmcHdU
	ULA6QA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe822xw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Thu, 08 Oct 2026 09:17:35 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33713e5e6daso6085966eec.0
        for <virtio-dev@lists.linux.dev>; Thu, 08 Oct 2026 02:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791451055; x=1792055855; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h9bHa5lb5u1k3MPtTzp7OwY9EEzU2/HhVQyGJ5zxhtw=;
        b=ChXYIb8kbQzwKMMJPf8xKqdkP+m7UWoyVscdq/ZVEH1RT7oXWvfaY9SlvhWSBfGv9f
         yR7hJkxq6xPVbgY8MMDUkUGCAEVgQROfg3XXU/o6lHVtfoMgixlUomo9eGKRGg2osJfj
         uXEcWaFdVPT9c4R1KUHev8UcOBjUJuDA0bLkA3nSQpqG71zrSYOP2GPoNILcyNCJfMRF
         f2N1r46KISPuM3gzSniS604Xx9Cx5NhziNVMxb4bNR47MFMRqmTTk9uWN8kG2vsjrBml
         CNP9bxj39e6yK9rcmm0Hwaoj1BmD4TNeDlWhObaiS5jQqVLE99VKZH9Ut+/LrDpx9SN2
         zn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791451055; x=1792055855;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h9bHa5lb5u1k3MPtTzp7OwY9EEzU2/HhVQyGJ5zxhtw=;
        b=0AqIR12xRfOj45Gcit9XNFPHtDjx88pfF/G9zttCNIzn2ykiLIEsTy4kAmCRdiMhOG
         K6kmupbKBvlXI08Kb3nAkkqh623HYqrhA8yqoSNs/7c5H20zvbGpzW7XCNEkvcmr3jl/
         vuTOIAVJKKtQd+Ob5cjprYscbEW5NLhnX5rKSEanIwjPBkY9WT7FxR9j38zFeV7Eq+BQ
         xXYDQp2ONcvjCJglIyDd9kzm/f1PAlp+veSbgWjohS6k/vkZRBnfcad27c/qYUi/hmgE
         ojJsc1RC+wzjZP3P0Y7461ZVPmDupU7Zn1RkT1jAVYJFhtQuJ/5YXptOMODgwbJo/y5U
         e7UA==
X-Gm-Message-State: AFuF++kg0any/3ZRl0CWjID/c8BA6vGVcZk0N8WypqUHaEd7JRjBZwgR
	6GRbpO39XMWDcM5FIPU2sZmPlwBGyiFLy7y0Y9PyreOWnG8Vp09vM3q5tjOO9kvsAQ0LyybicUc
	r9ERUmxkKhOTiHODTeN8F0/ENMCrlznfBkQGvp3x5yY+8Or03jsByh1ZWItY4fXDp
X-Gm-Gg: AYBFou1WEtKNmnvhb2rL6HNUYbNbIqb5faeIjCQ4j+cYHexAIVsFewHqLU8Rk+E0rZ7
	+ZPq0jXPjVly/2UN2B2oJTd0dbE90XFhIc521RxshyY6htX6N4xAPNDjkouC3FFbfRhUVSRWB87
	o9UmCnYj4hZPGzeP2bSz+eSin741R6vxNE7JLKB7iBGoz9+P2azQMOLSkFwkQKJV3YG01KlPUv4
	PorHxZuoAR9Z5GVfGAaIFbraw1jhLNIraXoX5mkKKqB1kkEk/i5OcAhYUcTOAyL4P3EV4DDIxTi
	L0s44q67gzPEryuWVeFsHAKDM1hbvEurU4Jp3aNVb/m5+QvbtQT++6ZycqA0pYdhpPR2cburQle
	vA2RYhbTx0brUxFNOtuBohvacDfp0p+x4GDcHDwyAwhkb6znhcQTAN3c=
X-Received: by 2002:a05:7301:5514:b0:341:33a0:2930 with SMTP id 5a478bee46e88-3515de9ee87mr5633052eec.29.1791451054345;
        Thu, 08 Oct 2026 02:17:34 -0700 (PDT)
X-Received: by 2002:a05:7301:5514:b0:341:33a0:2930 with SMTP id 5a478bee46e88-3515de9ee87mr5633020eec.29.1791451053604;
        Thu, 08 Oct 2026 02:17:33 -0700 (PDT)
Received: from [10.110.68.99] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515aeb5c2esm13853783eec.10.2026.10.08.02.17.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 02:17:33 -0700 (PDT)
Message-ID: <9515779b-a6da-407f-99f2-011e51683d15@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 17:17:30 +0800
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] virtio-blk: Add inline encryption support
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.linux.dev, ebiggers@kernel.org,
        neeraj.soni@oss.qualcomm.com
References: <20260913161628.368484-1-linlin.zhang@oss.qualcomm.com>
 <20260917210841.GD331587@fedora>
 <2f9affb3-0d1b-4469-9a66-ba052d2d1b6a@oss.qualcomm.com>
 <20260922131442.GB18339@fedora>
 <3a933df3-dff7-4ef3-a120-4c6e22c1fcc1@oss.qualcomm.com>
 <de535820-591b-40f2-b840-d987c3253765@nvidia.com>
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <de535820-591b-40f2-b840-d987c3253765@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAzNiBTYWx0ZWRfX0nSXZhGO4Zly
 o4KaM8KfHpze0pUoAtm3EMIxO5F+jDw18+2U3wGS7v8Hwufl1Nd71mtjXvNuUSpuW0N1z1KdZFn
 BD0IUZWFU/teYTPZUZ13fENOf4Ka5O7A7hI9QdnDwkzAsZu5biW60jP3TH9B7Z1Wrxj/Q6V6R/J
 SBZfO0FVY2bhjiTOztkfqA71Vuvc5X+RKc4BYFO40DKyBjPDrOPE5/IGLB6Ui+lBgh1k86M8sr4
 7tlhCnbwh3Qd5AoDNMV21j11sbm/7yrAQsmUJNpmFe89oZjwIVrSISyAveU8yb4qlrZjkNcQAtB
 2lFeJi6VViZp56dk59mu9ZMXCQWeR7x3obI+luD4ufh8z06ak93lVJcnLP5YR+qfZT13c0XO1HG
 Pf8nv60AneijS/Y4yDJ/SADhLe9pUjS4MYz5yXB/03nxj8URjp/brH0ZpaaaZPFC2dFOQt3skzb
 TgRm6eNFhG5PjWLiDiA==
X-Proofpoint-GUID: 3zsvT9fZrXS4EV-65hMCMn9L_AUuuoQf
X-Proofpoint-ORIG-GUID: 3zsvT9fZrXS4EV-65hMCMn9L_AUuuoQf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAzNiBTYWx0ZWRfX57OwcQHX0vgV
 K9zjth6UVbiUiFJx4LbQyWoOaTA+Bsg/kpKH13IfTQV5ZpCqkpHKjNUdnjvx6JTBJCbN/VEWDmy
 oeqgKlr1bpoyFki/1PJInI7/um/u6nY=
X-Authority-Analysis: v=2.4 cv=MPT1C8Zl c=1 sm=1 tr=0 ts=6ac75faf cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=aMXBs-Fq8IRRRPBnfU4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080036



On 9/30/2026 6:46 AM, Max Gurtovoy wrote:
> 
> On 24/09/2026 12:35, Linlin Zhang wrote:
>>
>> On 9/22/2026 9:14 PM, Stefan Hajnoczi wrote:
>>> On Tue, Sep 22, 2026 at 12:29:37PM +0800, Linlin Zhang wrote:
>>>>
>>>> On 9/18/2026 5:08 AM, Stefan Hajnoczi wrote:
>>>>> On Sun, Sep 13, 2026 at 09:16:13AM -0700, Linlin Zhang wrote:
>>>>>> From: linlzhan <linlin.zhang@oss.qualcomm.com>
>>>>>>
>>>>>> This series adds virtio-blk inline encryption support for devices backed
>>>>>> by storage hardware with an inline crypto engine.
>>>>>>
>>>>>> The protocol exposes device capabilities such as keyslot count, maximum
>>>>>> DUN size, and supported key types. Encrypted requests identify a
>>>>>> provisioned keyslot and carry a 256-bit DUN. Key management and crypto
>>>>>> capability discovery use the block device control virtqueue.
>>>>>>
>>>>>> The control virtqueue is defined as a generic framework so that its
>>>>>> buffer layout and queue placement are independent of any particular
>>>>>> control command. Inline encryption then builds on this framework with
>>>>>> explicit crypto command formats, capability validation, and keyslot
>>>>>> state semantics.
>>>>>>
>>>>>> All key related operatios are handled in the control virtqueue, and
>>>>>> the crypto I/O request is handled in the request queue.
>>>>>>
>>>>>> For background on inline encryption in UFS and eMMC storage, see:
>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/block/inline-encryption.rst
>>>>>>
>>>>>> changes in v3:
>>>>>>   - Add a control virtqueue
>>>>>>   - Move key program/evict/derive_sw_secret/generate/prepare/import to
>>>>>>     the control virtqueue
>>>>> Thank you. This was a big change, especially if you already have an
>>>>> implementation. I appreciate it!
>>>>>
>>>>> My main feedback is that the new control virtqueue commands are not yet
>>>>> documented in enough detail so that implementors could implement them.
>>>>> Once you've decided on the precise semantics, error codes, etc and added
>>>>> them to the spec, then this will round off the inline encryption
>>>>> feature. I look forward to reviewing that in the future.
>>>>>
>>>> Thanks a lot for your comment!
>>>>
>>>> Would you please help clarify what the precise semantics are about? detail
>>>> introduction of the filed in the inline encryption control command struct?
>>>> like struct virtio_blk_crypto_key_desc?
>>> By precise semantics, I mean specifying not just the constants and
>>> structs, but documenting what each command does and how it can fail.
>>> Each of the key slot programming commands needs this. There should be at
>>> least one paragraph for each of VIRTIO_BLK_T_CRYPTO_KEYSLOT_PROGRAM,
>>> VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT, VIRTIO_BLK_T_CRYPTO_DERIVE_SW_SECRET,
>>> VIRTIO_BLK_T_CRYPTO_GENERATE_KEY, VIRTIO_BLK_T_CRYPTO_IMPORT_KEY, or
>>> VIRTIO_BLK_T_CRYPTO_PREPARE_KEY.
>>>
>>> For example:
>>>
>>> The VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT command empties a key slot so that
>>> key information is removed and the key slot cannot be used until it is
>>> programmed again. The key slot index is specified by struct
>>> virtio_blk_crypto_key_desc \field{slot} and all other fields in the
>>> struct are ignored. The command succeeds with VIRTIO_BLK_S_OK if the key
>>> slot index is valid, including if the slot is already empty. If the key
>>> slot index is invalid, the command fails with VIRTIO_BLK_S_IOERR.
>>>
>>> Stefan
>> Thanks for the clear example.
>>
>> I'll follow the same approach and add explicit normative semantics for
>> all inline encryption control requests.
> Can you please explain why we need to introduce yet another VQ type for control?
> 
> We've added the Admin VQ as a generic VQ for control operations — I'm not sure why it isn't sufficient.
> 
> Adding control VQ to each device type seems strange to me after adding a generic Admin VQ.

Thanks for your comment! And I agree that the Admin VQ should be considered before
adding another device-specific control virtqueue.

My understanding is that some of the inline encryption commands(get_crypto_modes/program key
/derive_sw_secret/evict key) are runtime operations of a specific virtio-blk deivce.
In particular, different virtio block devices may have different storage hardware sources
of crypto modes, and keyslot programming and eviction are invoked through the block device's
keyslot manager, and the programmed virtual keyslots are subsequently referenced by the
encryption requests submitted on that device's request virtqueues. These commands are
not about the management operation of device group.

There is also a transport compatibility concern. The current virtio SPEC states that
'Devices and drivers utilizing Virtio Over MMIO do not support VIRTIO_F_ADMIN_VQ'.
virtio MMIO is extensively used, so using the Admin VQ would make the feature unavailable
for that transport unless the proposal also extended the MMIO transport.

For these reasons, currently I believe that a virtio-blk control virtqueue is the better
fit: it keeps the complete key lifecycle associated with the block device and remains
usable across the transports required by the feature.

I would appreciate any feedback or insights from you and Stefan on the V5 patch series
posted for review before October ASAP.

