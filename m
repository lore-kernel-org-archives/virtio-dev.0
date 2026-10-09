Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA514A64EE
	for <virtio-dev@lists.linux.dev>; Fri,  9 Oct 2026 11:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791544892; cv=none; b=feSCL/YEU/NSPwXkLgHn6DTOe/hx3Na8//TkJOOu9NQUXb9t2k8m4rczLCBz2xj9jnpMmHhcpHUI9a60/LYuOwYDiiHePrzFFBTKlSoEceZWukUCVJetoV09saWZSuChiHH59hmOyX3cu7rVnkPhDWDe7gAlekTC3ogYzKDqp1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791544892; c=relaxed/simple;
	bh=sjGpuoLEYeruIgmqx82SDH5suglgXnlMUDUP7Bqg+n4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nYcaa5hD9L2cMmAmi4ZBU9neOPI6QQ0hRpupRmYiF3TosTumhFSi4b4Ti4Xgi6QlprGPX6OLCcppiO31dfoyqmRuAPAvw44I2SLsVhf61lmilg9ujxr8QRJnXx3UamiTwdS23swUOvMeUOekZzZ+Gy1Bz7LP/3phc6sF5a3QftI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hsiEahUV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kGypbL7+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hsiEahUV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kGypbL7+"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998KG3k1625931
	for <virtio-dev@lists.linux.dev>; Fri, 9 Oct 2026 11:21:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wlBw/My1wI6ihnMUTWbcm0mT2n/iWjNvM6a/fsuNBBA=; b=hsiEahUVxyNy9SbX
	cz7ebxOiH0ib8InMRc4x61dFbKXuQ3X7L5fJIML0jYlGYTmndDnh+NNMHAXFKvYI
	DnAPLS6dC6zSC2S2lecCkdooAF9VXwXP65V/znMZlpBVASpqWv/Jlwj/pD3z7ivK
	Y5ayJ3YU7bIm1g55Wkmp1uNYW9qdzNjChEoW0VoIma9rv+t2r9pYCl9ubcYAyYUl
	00qpw5KVNRuKtHRhxeQaJLCOtCdu8I1VEaF5/UHid+fNU8fUmRk/nNXiL4mNMjPN
	k0UY3waZXQt4kwiChlDosCrnfGUp0NM6Pbq876RLBlb9DdiIp2nTgb2H+iXD4PX7
	lqMbVQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fyj3896-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Fri, 09 Oct 2026 11:21:18 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-154e9d2d94fso1619284c88.0
        for <virtio-dev@lists.linux.dev>; Fri, 09 Oct 2026 04:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791544878; x=1792149678; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wlBw/My1wI6ihnMUTWbcm0mT2n/iWjNvM6a/fsuNBBA=;
        b=kGypbL7+HS/+OvYVJSzUYwolMnzTmp/WMD8p+n7QDz3m9IO2Cvqc8H+4xppgBQVK9M
         okUHLmRApIWSePvVcXvUGS8AC2Vc+GVUPp730xdMDUD6mZQP96T8+NJbp4FEJ35FPsfn
         I+qMzDtrk2sCiGFrEhfPSwB183fJ2cyk2/oryGyBQjYYnTxuVbO7mqgqLMm+6KxNvR3J
         23df7uPavDw2SzO7N4t8oGBAAUehxEs3Afkumw1lqPMufZyT14KHPtX0mHTHP9RgS69n
         8f70musq9a1aQI3stNILUfiy2OzroHIl8Hbs3YlBFDswDnANxqXQeNoZP4GNSUHUkJSW
         Wq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791544878; x=1792149678;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wlBw/My1wI6ihnMUTWbcm0mT2n/iWjNvM6a/fsuNBBA=;
        b=vQ9hb5KkQSLKICJW/pvQbysAi+mvHKtVM5gYeMf3Dq2M88wRcquvdwr8jy/k/n835G
         FgrTYYgINEYj53Kb9HAeMOKORFxUMaj6xSVsPfXSY5AYUk8cxH1Am/sB8jlvMch4Bvqh
         0HCn4//GcEKj6DmUPs6Y3G8iA7/j0lNNg5TYZuWbnv6j0rZr8p0vz3x9d7tQazHsG/wC
         JqeZkDnOVZ+qX1rThcQdfm6z4epSFkQqwaH7kPY7WYgUcUbTISaKPk9vjkiMdNwZW1Kj
         aW+haKIn4xClUNTjbr5vr97CDmjk6ZeumRLo0Qxcw4qKGi4gNrRaInL9jxGO1KBDSP/h
         Q+Vw==
X-Forwarded-Encrypted: i=1; AKwUvBxklqdyv0MrlUIxXAjJbCDmYEDS/lmQFQW5Q6E5HUG5nLLmFFGDA6QuDcMZPURrV/ckrfIi8mUTOFR+@lists.linux.dev
X-Gm-Message-State: AFuF++liGSgqQk8BkfSX2zFNoyYvqSL4Skqo59Ibn8+wKaTUClX+AwCm
	IqjNkvDFvthyTlMlGbzK8E40lzW3aYWRWOztzc1wPPuEjw/7/wtCGuvBhFM0/C4yOsQWv1U5Yy5
	mEj+/ZGYs+A/2EvpObZKBpgCDFcp3563C/n8hZilof6XDl2IYGGYOD03TkWiYZsGi
X-Gm-Gg: AYBFou0ioOydtmNYFyDgSTgJivK5U6KO+4cdLxJ4lHv7deGoRXJnUxjzrrVkef0hIe0
	t0sI60/JDdspOanOJRak6gtABaGRuSFqAxFoinrG0t4WJZyhnEwPgvKM0RctnSvQGWPILY3ahmr
	tGx6r4eUfyh/W8yN99lf/ruuTwI3/D+JSyEV0d2uDDUf2xPOhw8QSfRMbBFbeccSdB1eJYR4JRr
	/ymiohQE6yxbfdPBIwFj3cnb9Xevo9Jle4U0CSf3rKZjQrclqBcVR6D7olsC9Yg4U52VRWD94nB
	Az9SCoAQC30JctDwjyoJytlUuW4MjnStPada87PVLXHWZSuWSJo6nAmGtdQRV8EKM9gaQ7FrYm0
	KH70vrdmGxTaNYxJGt+USHQp/gejZzsudsdblqwFtwVCVafR1GtYQYG+L+g==
X-Received: by 2002:a05:701b:240d:b0:144:eb46:c3f with SMTP id a92af1059eb24-16a572659bamr2480871c88.2.1791544877482;
        Fri, 09 Oct 2026 04:21:17 -0700 (PDT)
X-Received: by 2002:a05:701b:240d:b0:144:eb46:c3f with SMTP id a92af1059eb24-16a572659bamr2480828c88.2.1791544876757;
        Fri, 09 Oct 2026 04:21:16 -0700 (PDT)
Received: from [10.110.71.224] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1698de65af7sm6662581c88.0.2026.10.09.04.21.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 04:21:16 -0700 (PDT)
Message-ID: <bfbb51cb-8a90-4b23-8ed1-26ea41102dd6@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 19:21:13 +0800
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] virtio-blk: Add inline encryption support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>,
        Stefan Hajnoczi
 <stefanha@redhat.com>, virtio-dev@lists.linux.dev,
        ebiggers@kernel.org, neeraj.soni@oss.qualcomm.com
References: <20260913161628.368484-1-linlin.zhang@oss.qualcomm.com>
 <20260917210841.GD331587@fedora>
 <2f9affb3-0d1b-4469-9a66-ba052d2d1b6a@oss.qualcomm.com>
 <20260922131442.GB18339@fedora>
 <3a933df3-dff7-4ef3-a120-4c6e22c1fcc1@oss.qualcomm.com>
 <de535820-591b-40f2-b840-d987c3253765@nvidia.com>
 <9515779b-a6da-407f-99f2-011e51683d15@oss.qualcomm.com>
 <20261008060644-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <20261008060644-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BfpNQbt2 c=1 sm=1 tr=0 ts=6ac8ce2e cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=72rube9TO2g-b54KgnEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-ORIG-GUID: Z7BidkZAjTEpeCtYP_86Su36a5ZdPq3j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0NSBTYWx0ZWRfX9exabw2C7wOn
 urAZmQlJgKWIa2JAsTnN0T0QKY3q6tRBMNFwwyq8siDigeRdz4eX+Rjszq1SSP5a71aTmvolvIs
 j5PGacO68+REfPctx4CLxQnGispd0BKCMcgDGBpHEQ/v/n/SEPhi7CsZgI6ESU7JJ/UuspoY1Z7
 6CP4dXfTxzi3ZQ0eqyBO0EvvfvM6wzpGPxGlBCIzERGbfP08EdWPAs4VHjKg/skmiqvbMZm0FQS
 a4ii/hruu83dN//jljHA/SyDHfCzDYHp1lg0EDM5e3/6IQ8Rz4nQS8HE8r3scfrcXC4+TqQN9dT
 2Y/1WW21z/p38R0RtfMVJ+68hodTb3L2/8NUJ9NKzqxa6u9P/62YZoyZR5CVrWTn3QbJvSQR0vd
 Jav49bz/qiLAaDoX7BpxAODBqhZaazneWxA+9WlQ4fr2VCid30CP2TPzg552/6y69cq4ouARKmW
 NTYATvykzukFeNFOTwQ==
X-Proofpoint-GUID: Z7BidkZAjTEpeCtYP_86Su36a5ZdPq3j
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0NSBTYWx0ZWRfXy1mnhuppCu6W
 jzIQ7dHKu/ffwn/zoaXed5a74Y1smyUJj4uWE/Icka3jHjSeNwdaPVOFMrwHq/5Y0x4x4y00feW
 57GVfdCPCCQe7n3o1YaddMQgW92Actc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090045



On 10/8/2026 6:15 PM, Michael S. Tsirkin wrote:
> On Thu, Oct 08, 2026 at 05:17:30PM +0800, Linlin Zhang wrote:
>>
>>
>> On 9/30/2026 6:46 AM, Max Gurtovoy wrote:
>>>
>>> On 24/09/2026 12:35, Linlin Zhang wrote:
>>>>
>>>> On 9/22/2026 9:14 PM, Stefan Hajnoczi wrote:
>>>>> On Tue, Sep 22, 2026 at 12:29:37PM +0800, Linlin Zhang wrote:
>>>>>>
>>>>>> On 9/18/2026 5:08 AM, Stefan Hajnoczi wrote:
>>>>>>> On Sun, Sep 13, 2026 at 09:16:13AM -0700, Linlin Zhang wrote:
>>>>>>>> From: linlzhan <linlin.zhang@oss.qualcomm.com>
>>>>>>>>
>>>>>>>> This series adds virtio-blk inline encryption support for devices backed
>>>>>>>> by storage hardware with an inline crypto engine.
>>>>>>>>
>>>>>>>> The protocol exposes device capabilities such as keyslot count, maximum
>>>>>>>> DUN size, and supported key types. Encrypted requests identify a
>>>>>>>> provisioned keyslot and carry a 256-bit DUN. Key management and crypto
>>>>>>>> capability discovery use the block device control virtqueue.
>>>>>>>>
>>>>>>>> The control virtqueue is defined as a generic framework so that its
>>>>>>>> buffer layout and queue placement are independent of any particular
>>>>>>>> control command. Inline encryption then builds on this framework with
>>>>>>>> explicit crypto command formats, capability validation, and keyslot
>>>>>>>> state semantics.
>>>>>>>>
>>>>>>>> All key related operatios are handled in the control virtqueue, and
>>>>>>>> the crypto I/O request is handled in the request queue.
>>>>>>>>
>>>>>>>> For background on inline encryption in UFS and eMMC storage, see:
>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/block/inline-encryption.rst
>>>>>>>>
>>>>>>>> changes in v3:
>>>>>>>>   - Add a control virtqueue
>>>>>>>>   - Move key program/evict/derive_sw_secret/generate/prepare/import to
>>>>>>>>     the control virtqueue
>>>>>>> Thank you. This was a big change, especially if you already have an
>>>>>>> implementation. I appreciate it!
>>>>>>>
>>>>>>> My main feedback is that the new control virtqueue commands are not yet
>>>>>>> documented in enough detail so that implementors could implement them.
>>>>>>> Once you've decided on the precise semantics, error codes, etc and added
>>>>>>> them to the spec, then this will round off the inline encryption
>>>>>>> feature. I look forward to reviewing that in the future.
>>>>>>>
>>>>>> Thanks a lot for your comment!
>>>>>>
>>>>>> Would you please help clarify what the precise semantics are about? detail
>>>>>> introduction of the filed in the inline encryption control command struct?
>>>>>> like struct virtio_blk_crypto_key_desc?
>>>>> By precise semantics, I mean specifying not just the constants and
>>>>> structs, but documenting what each command does and how it can fail.
>>>>> Each of the key slot programming commands needs this. There should be at
>>>>> least one paragraph for each of VIRTIO_BLK_T_CRYPTO_KEYSLOT_PROGRAM,
>>>>> VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT, VIRTIO_BLK_T_CRYPTO_DERIVE_SW_SECRET,
>>>>> VIRTIO_BLK_T_CRYPTO_GENERATE_KEY, VIRTIO_BLK_T_CRYPTO_IMPORT_KEY, or
>>>>> VIRTIO_BLK_T_CRYPTO_PREPARE_KEY.
>>>>>
>>>>> For example:
>>>>>
>>>>> The VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT command empties a key slot so that
>>>>> key information is removed and the key slot cannot be used until it is
>>>>> programmed again. The key slot index is specified by struct
>>>>> virtio_blk_crypto_key_desc \field{slot} and all other fields in the
>>>>> struct are ignored. The command succeeds with VIRTIO_BLK_S_OK if the key
>>>>> slot index is valid, including if the slot is already empty. If the key
>>>>> slot index is invalid, the command fails with VIRTIO_BLK_S_IOERR.
>>>>>
>>>>> Stefan
>>>> Thanks for the clear example.
>>>>
>>>> I'll follow the same approach and add explicit normative semantics for
>>>> all inline encryption control requests.
>>> Can you please explain why we need to introduce yet another VQ type for control?
>>>
>>> We've added the Admin VQ as a generic VQ for control operations — I'm not sure why it isn't sufficient.
>>>
>>> Adding control VQ to each device type seems strange to me after adding a generic Admin VQ.
>>
>> Thanks for your comment! And I agree that the Admin VQ should be considered before
>> adding another device-specific control virtqueue.
>>
>> My understanding is that some of the inline encryption commands(get_crypto_modes/program key
>> /derive_sw_secret/evict key) are runtime operations of a specific virtio-blk deivce.
>> In particular, different virtio block devices may have different storage hardware sources
>> of crypto modes, and keyslot programming and eviction are invoked through the block device's
>> keyslot manager, and the programmed virtual keyslots are subsequently referenced by the
>> encryption requests submitted on that device's request virtqueues. These commands are
>> not about the management operation of device group.
>>
>> There is also a transport compatibility concern. The current virtio SPEC states that
>> 'Devices and drivers utilizing Virtio Over MMIO do not support VIRTIO_F_ADMIN_VQ'.
>> virtio MMIO is extensively used, so using the Admin VQ would make the feature unavailable
>> for that transport unless the proposal also extended the MMIO transport.
>>
>> For these reasons, currently I believe that a virtio-blk control virtqueue is the better
>> fit: it keeps the complete key lifecycle associated with the block device and remains
>> usable across the transports required by the feature.
>>
>> I would appreciate any feedback or insights from you and Stefan on the V5 patch series
>> posted for review before October ASAP.
>>
> 
> Fundamentally, it does not make sense to force all vqs to be admin VQs.
> 
> Admin vq would make sense if there is complex resource management going
> on - like what is happening with all the flow control things in the
> network device, since they have extensive functionality for managing
> device resources.
> 
> Random device specific commands - I am not sure we want that.
> It remains to be proven.
> 
> But generally why does this go on a special VQ? Is there a reason?
> 
> You define distinct request types seemingly and we are not short on types?
> 

Thanks for your comments!

The key programming operation is initiated while preparing a block I/O
request and sent to the VQ after the block I/O request has entered the
block request queue, before the request is submitted to the device's VQ.
see blk_mq_submit_bio(). Using the same virtqueue for both key-program
command and normal I/O could lead to bio_queue_enter() called 2 times
for the same block queue, which is possible to have deadlock if
blk_mq_freeze_queue() is called between above 2 bio_queue_enter() caller.

A separate control virtqueue provides an independent execution path for
key programming, key eviction, and related operations. It allows these
operations to be issued even when the normal request virtqueues are full
or unable to make progress. Once the operation completes, the corresponding
request can safely reference the programmed virtual keyslot.

For such reasons, we believe that a virtio-blk-specific control VQ is a
more appropriate mechanism than the standard VQ.
