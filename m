Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2056C3195FE
	for <virtio-dev@lists.linux.dev>; Sat, 10 Oct 2026 10:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791629675; cv=none; b=ItPZYRni5KP144T3aMJnWp+QtXNLEF/YKc9tTkqA9Xyc557DGjv/aCig/B2/GNY7z55sD7eH1VBF1BPeURIz8sexKzPDSVbgeR272TjA8k4vAhpEHIfTpVpB9Qj6M7PGJqkjwrfF+h5fUonvtrnF4ukO/Zeb7MZzXIU3VWbTCAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791629675; c=relaxed/simple;
	bh=JyTNM/VxxKiH7YQHYjmu+F1YHpTr8p35EctvKP+Ev30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BiT4giBaAtTI4wIwQV1uF/GQNwy/6wp+6Ce5mUoR2nWjk37rtybQuwfYsa7nEiEHyVAwjeb0n+XqJin+cYQai8eZoNzmuXNl3NVQdmpwP9kBqnwnSYLjBIEXDnf4a6b+322YBm2a1BoxI4EOWP+NxSWaxEqVgmpy9+7nLSV2rA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VZ0Lwo6p; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BIiwQPPu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VZ0Lwo6p";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BIiwQPPu"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69A2eSvq3439135
	for <virtio-dev@lists.linux.dev>; Sat, 10 Oct 2026 10:54:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VARxGUSocydjvDU2AsLgRi58fTdkqvJCIcGv1aTPXRQ=; b=VZ0Lwo6pp/6sI8bU
	LtpI0CEuSgnOdSht29Xtmp/w54O29f64l5uerLImmKO8HgosnBHXhV4Jq4TO2C5G
	ZUWlZbMxSuwY7M3BfM6t3Ix99VrSx1Ze0jKhzo/7N2roR3YVnmpwjUlyKHxLuRRz
	6OSr4qtxlDIn8G4HyiUID/cZBPMoiqQy7HeuE5X2cRupX867QDHcpahXchE8MDh2
	9VFsUXA5kIl2I3RIFOTVaxXbMv8/zsrzG0geEyqhG3A5eVG+Bn67lj+bGve5LC4x
	P103OTB3ciKWJ98jewcWOqYIiDn+d1XlWuPxdQrdXFD4QDyo0oRxTT3fXAf3yBPk
	OaA6Nw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7aqms7ny-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Sat, 10 Oct 2026 10:54:32 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc7361c62b9so349247a12.3
        for <virtio-dev@lists.linux.dev>; Sat, 10 Oct 2026 03:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791629672; x=1792234472; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VARxGUSocydjvDU2AsLgRi58fTdkqvJCIcGv1aTPXRQ=;
        b=BIiwQPPufcCvJiEqqt3Cus3ka8VkFjuJKUdMW4XYF37weNBRgpRzpHWCGRE9H29WSp
         ZQ26hgByJ9aBc4YKbDFvTwQnF/J2a+G+C/fbmlgMAKDbgW/LTmMunTypYkDZUZI88xyW
         iGCfNGigJP/QYzFrm+0cppiKaNXOGyBQ+lUK/Cw4vNHBhUTYqVLwTemEFv3K0OBIcJ2M
         UCYH/mvQqDzajiOHZg50V/c2cFkCelIcCiRk5rZOYu6OnWn7RGNKlFEXrUwEqZFLQQUm
         +EAZDJRjzwYpuiuLS9mZ+asGHYZav0w1szq8IBKLcoeSwd/7XH5sH3dAWtflVG+GBjWy
         xxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791629672; x=1792234472;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VARxGUSocydjvDU2AsLgRi58fTdkqvJCIcGv1aTPXRQ=;
        b=npuoTP22OawR/4kxorHSvzlKzi/GxP72gpUocUSV+PfucCblXrYf3axvsB8EwVaa2a
         /s2jOSQfc0d8GG+bbxkuS0Fq3RE2HlBSCa3HiyA5V9f8S/IvMJVtvaP7NzDJdF9QZ1Ts
         Bza50uIJtY4OtjCNWdIL3qujCcok4SA6SkIuNVm798tbYTMTSJvGSZF51IiPZPqYNn4s
         fF0gLgzgigfgEiu0Ezf8bmof2lUBsKTEWy+lWKzXjC9La1WJy3RqbO8mxy4iVwk7KhJs
         RfoM/HvXI0KuQj+sqKBN5LS+iWD/S2aiCBDQMjDbJZvm+k5T6M+beoZE/vQvVc4U17nz
         i5Ug==
X-Forwarded-Encrypted: i=1; AKwUvBxkT92nVAkvYsj6PjElNBDPRikmID12gZMHo3cUFCzdVtiTugyzRCtquIdCxNZTnrcF7NecLsTOWRQG@lists.linux.dev
X-Gm-Message-State: AFq9FYIOrLdtorFr2p942H/3h2afPNBCJMdXgX4XfYbXANmIvbTzop+Y
	R87AfSEEfCD33L8PAj3fhmeTTNKL2cC7o1f+BH/xLPNbtYWHb68ZUn2NIM8mDMDPz6EYFj7UuQi
	lJmWI23CpkRRcfE7uDR5FDj9dyFHxDmCx1MVXSPDKJDUWHcpGW0DiGk12pnvyOugfjq5mI74VGD
	c=
X-Gm-Gg: AYBFou0R0uOnuZ4AfaJGHxDLPqIyvFvVQkqM+PlcgQNzvxkDecyjB9P/oIDWr3Gsvdf
	tQ6hBbUuBu32FoeH9Vix98Ggi/Uj48GL0VG0ywsEaI5spRv6+ypntaB3QtJJqNE6xrAWe8mprU+
	9bWzm/Fmjqt9Qy194M0KIWRtSgSYUwsiBTkIxkLXpbZpCz/yp48ddMc9U1V0ISlkBrFbMi8A+At
	NDgsZlae6eiW1+UmXsuWtGwgzFVS5g3/LXESd47wiy3FUqt40ob6gePyXHNFcT68hOjI79cSkj+
	/ity6B/L+ZIim2zLmKAs0hrlCUN9/65qPoifeIWJA8UPWuDe7ATJ795RymnD2X1NcX8eSfz/Ejr
	WOavbY+LuZn7l8O1YoZY0TnqsduMkEw==
X-Received: by 2002:a05:6a00:2793:b0:880:d0d9:fece with SMTP id d2e1a72fcca58-897c75e63d2mr3745071b3a.36.1791629671594;
        Sat, 10 Oct 2026 03:54:31 -0700 (PDT)
X-Received: by 2002:a05:6a00:2793:b0:880:d0d9:fece with SMTP id d2e1a72fcca58-897c75e63d2mr3745062b3a.36.1791629671013;
        Sat, 10 Oct 2026 03:54:31 -0700 (PDT)
Received: from [10.231.241.142] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896b68efb86sm2081038b3a.8.2026.10.10.03.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Oct 2026 03:54:30 -0700 (PDT)
Message-ID: <e13d2da8-e8e9-4014-98f0-2c1bfa801d59@oss.qualcomm.com>
Date: Sat, 10 Oct 2026 18:54:06 +0800
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
 <bfbb51cb-8a90-4b23-8ed1-26ea41102dd6@oss.qualcomm.com>
 <20261009081523-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <20261009081523-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEwMDA0MyBTYWx0ZWRfXyXY21Ji6iHFe
 J9DEQ4ojEnvU3PCsRMIwR1qZkQskh72FeBKiGFcHC05041+wKsDCWo89yWbY7li++aQ4Ek8tqtV
 u562htcYXWlHievLOsgr/ECKE1MMtvM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEwMDA0MyBTYWx0ZWRfX2s1KeJVLlwos
 S22YlcmyKpNfSJeQ4ySWnsTC1Iugvlr6xfvNOlo3VqeOmjMbPkXaAbd/8cbroruPGmEczMxz1Kl
 QPdpJEl+t+6glQfL19sNIW11BTAiKsyEuKZTNDn0uYRF61Mn6BKI2YW3DgPKvmrS/QyU47yEmP4
 vNIdgSVjz+7vll4S+ec2O1zYdXnkFwPLujsVOlmUacGfxp62TjFz3zbhNkLL4d4RNjN6AwPkqC1
 LWjzfXc0c4Kjj4G3nEOv7T22ydyXfHt3tDhZag/X5U4vENhSaOMdSBIiLESQTggAOqHymm0l4FB
 X/KoeSDM8gIXhETJojbH0D8WGHe/Bl9VpSbRvNyHAivyXcECdB5RsA4aI7JlTOATTD3j7gOVoqn
 Ej3WfcYfe1M3Tn8tVnreTxSTiui8H3zU5HFbTgR+29u/EwKKcMq7uXrjer/0/KK3xbUpojMKsst
 klh7zjLBclAZ5jZKrJA==
X-Authority-Analysis: v=2.4 cv=Uq32pOwB c=1 sm=1 tr=0 ts=6aca1968 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=aD4TXAOMda-i8ruUh2cA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: Aq7kiAjFaoQEPTauSAYES8tQlMjhxG2X
X-Proofpoint-GUID: Aq7kiAjFaoQEPTauSAYES8tQlMjhxG2X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-10_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610100043



On 10/9/2026 8:25 PM, Michael S. Tsirkin wrote:
> On Fri, Oct 09, 2026 at 07:21:13PM +0800, Linlin Zhang wrote:
>>
>>
>> On 10/8/2026 6:15 PM, Michael S. Tsirkin wrote:
>>> On Thu, Oct 08, 2026 at 05:17:30PM +0800, Linlin Zhang wrote:
>>>>
>>>>
>>>> On 9/30/2026 6:46 AM, Max Gurtovoy wrote:
>>>>>
>>>>> On 24/09/2026 12:35, Linlin Zhang wrote:
>>>>>>
>>>>>> On 9/22/2026 9:14 PM, Stefan Hajnoczi wrote:
>>>>>>> On Tue, Sep 22, 2026 at 12:29:37PM +0800, Linlin Zhang wrote:
>>>>>>>>
>>>>>>>> On 9/18/2026 5:08 AM, Stefan Hajnoczi wrote:
>>>>>>>>> On Sun, Sep 13, 2026 at 09:16:13AM -0700, Linlin Zhang wrote:
>>>>>>>>>> From: linlzhan <linlin.zhang@oss.qualcomm.com>
>>>>>>>>>>
>>>>>>>>>> This series adds virtio-blk inline encryption support for devices backed
>>>>>>>>>> by storage hardware with an inline crypto engine.
>>>>>>>>>>
>>>>>>>>>> The protocol exposes device capabilities such as keyslot count, maximum
>>>>>>>>>> DUN size, and supported key types. Encrypted requests identify a
>>>>>>>>>> provisioned keyslot and carry a 256-bit DUN. Key management and crypto
>>>>>>>>>> capability discovery use the block device control virtqueue.
>>>>>>>>>>
>>>>>>>>>> The control virtqueue is defined as a generic framework so that its
>>>>>>>>>> buffer layout and queue placement are independent of any particular
>>>>>>>>>> control command. Inline encryption then builds on this framework with
>>>>>>>>>> explicit crypto command formats, capability validation, and keyslot
>>>>>>>>>> state semantics.
>>>>>>>>>>
>>>>>>>>>> All key related operatios are handled in the control virtqueue, and
>>>>>>>>>> the crypto I/O request is handled in the request queue.
>>>>>>>>>>
>>>>>>>>>> For background on inline encryption in UFS and eMMC storage, see:
>>>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/block/inline-encryption.rst
>>>>>>>>>>
>>>>>>>>>> changes in v3:
>>>>>>>>>>   - Add a control virtqueue
>>>>>>>>>>   - Move key program/evict/derive_sw_secret/generate/prepare/import to
>>>>>>>>>>     the control virtqueue
>>>>>>>>> Thank you. This was a big change, especially if you already have an
>>>>>>>>> implementation. I appreciate it!
>>>>>>>>>
>>>>>>>>> My main feedback is that the new control virtqueue commands are not yet
>>>>>>>>> documented in enough detail so that implementors could implement them.
>>>>>>>>> Once you've decided on the precise semantics, error codes, etc and added
>>>>>>>>> them to the spec, then this will round off the inline encryption
>>>>>>>>> feature. I look forward to reviewing that in the future.
>>>>>>>>>
>>>>>>>> Thanks a lot for your comment!
>>>>>>>>
>>>>>>>> Would you please help clarify what the precise semantics are about? detail
>>>>>>>> introduction of the filed in the inline encryption control command struct?
>>>>>>>> like struct virtio_blk_crypto_key_desc?
>>>>>>> By precise semantics, I mean specifying not just the constants and
>>>>>>> structs, but documenting what each command does and how it can fail.
>>>>>>> Each of the key slot programming commands needs this. There should be at
>>>>>>> least one paragraph for each of VIRTIO_BLK_T_CRYPTO_KEYSLOT_PROGRAM,
>>>>>>> VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT, VIRTIO_BLK_T_CRYPTO_DERIVE_SW_SECRET,
>>>>>>> VIRTIO_BLK_T_CRYPTO_GENERATE_KEY, VIRTIO_BLK_T_CRYPTO_IMPORT_KEY, or
>>>>>>> VIRTIO_BLK_T_CRYPTO_PREPARE_KEY.
>>>>>>>
>>>>>>> For example:
>>>>>>>
>>>>>>> The VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT command empties a key slot so that
>>>>>>> key information is removed and the key slot cannot be used until it is
>>>>>>> programmed again. The key slot index is specified by struct
>>>>>>> virtio_blk_crypto_key_desc \field{slot} and all other fields in the
>>>>>>> struct are ignored. The command succeeds with VIRTIO_BLK_S_OK if the key
>>>>>>> slot index is valid, including if the slot is already empty. If the key
>>>>>>> slot index is invalid, the command fails with VIRTIO_BLK_S_IOERR.
>>>>>>>
>>>>>>> Stefan
>>>>>> Thanks for the clear example.
>>>>>>
>>>>>> I'll follow the same approach and add explicit normative semantics for
>>>>>> all inline encryption control requests.
>>>>> Can you please explain why we need to introduce yet another VQ type for control?
>>>>>
>>>>> We've added the Admin VQ as a generic VQ for control operations — I'm not sure why it isn't sufficient.
>>>>>
>>>>> Adding control VQ to each device type seems strange to me after adding a generic Admin VQ.
>>>>
>>>> Thanks for your comment! And I agree that the Admin VQ should be considered before
>>>> adding another device-specific control virtqueue.
>>>>
>>>> My understanding is that some of the inline encryption commands(get_crypto_modes/program key
>>>> /derive_sw_secret/evict key) are runtime operations of a specific virtio-blk deivce.
>>>> In particular, different virtio block devices may have different storage hardware sources
>>>> of crypto modes, and keyslot programming and eviction are invoked through the block device's
>>>> keyslot manager, and the programmed virtual keyslots are subsequently referenced by the
>>>> encryption requests submitted on that device's request virtqueues. These commands are
>>>> not about the management operation of device group.
>>>>
>>>> There is also a transport compatibility concern. The current virtio SPEC states that
>>>> 'Devices and drivers utilizing Virtio Over MMIO do not support VIRTIO_F_ADMIN_VQ'.
>>>> virtio MMIO is extensively used, so using the Admin VQ would make the feature unavailable
>>>> for that transport unless the proposal also extended the MMIO transport.
>>>>
>>>> For these reasons, currently I believe that a virtio-blk control virtqueue is the better
>>>> fit: it keeps the complete key lifecycle associated with the block device and remains
>>>> usable across the transports required by the feature.
>>>>
>>>> I would appreciate any feedback or insights from you and Stefan on the V5 patch series
>>>> posted for review before October ASAP.
>>>>
>>>
>>> Fundamentally, it does not make sense to force all vqs to be admin VQs.
>>>
>>> Admin vq would make sense if there is complex resource management going
>>> on - like what is happening with all the flow control things in the
>>> network device, since they have extensive functionality for managing
>>> device resources.
>>>
>>> Random device specific commands - I am not sure we want that.
>>> It remains to be proven.
>>>
>>> But generally why does this go on a special VQ? Is there a reason?
>>>
>>> You define distinct request types seemingly and we are not short on types?
>>>
>>
>> Thanks for your comments!
>>
>> The key programming operation is initiated while preparing a block I/O
>> request and sent to the VQ after the block I/O request has entered the
>> block request queue, before the request is submitted to the device's VQ.
>> see blk_mq_submit_bio(). Using the same virtqueue for both key-program
>> command and normal I/O could lead to bio_queue_enter() called 2 times
>> for the same block queue, which is possible to have deadlock if
>> blk_mq_freeze_queue() is called between above 2 bio_queue_enter() caller.
>>
>> A separate control virtqueue provides an independent execution path for
>> key programming, key eviction, and related operations. It allows these
>> operations to be issued even when the normal request virtqueues are full
>> or unable to make progress. Once the operation completes, the corresponding
>> request can safely reference the programmed virtual keyslot.
>>
>> For such reasons, we believe that a virtio-blk-specific control VQ is a
>> more appropriate mechanism than the standard VQ.
> 
> I don't understand. Do these commands go through bio queue?
> Don't they go to VQ directly, just like you would with the control VQ?
> 

Thanks for your comment! my earlier reply conflated two separate concerns.
Let me address them precisely based on Linux kernel code.

I agree that block-layer queue entry and virtqueue selection are independent
issues.

Whether key program commands going through bio queue or not depends on the
implementation.

  - Option A: Reuse the standard block-request helpers (e.g.,
    blk_mq_alloc_request() + blk_execute_rq(), the same pattern virtblk_get_id()
    uses):
    
      - blk_mq_submit_bio()
         -> blk_crypto_submit_bio()   # outer bio_queue_enter() already held
           -> keyslot manager
             -> virtblk_crypto_keyslot_program()
               -> blk_mq_alloc_request()
                 -> blk_queue_enter()    # deadlock: freeze in progress

    This is not safe at the keyslot-manager call site. Key programming is invoked
    from inside blk_mq_submit_bio(), at a point where the submitting thread already
    holds an unreleased reference from an earlier bio_queue_enter() call on the same
    queue. Calling blk_queue_enter() a second time on the same thread and queue —
    while a concurrent blk_mq_freeze_queue() is in flight — produces a circular wait:
    the freezer blocks waiting for all references (including the outer one) to drop to
    zero, while the submitting thread blocks waiting for the freeze depth to clear.
    Neither can make progress. The problem is not allocation starvation but queue-entry
    reentrancy under freeze. 

    This is the deadlock concern I mentioned last time.

  - Option B: Bypass the block layer entirely and raw-submit to a data VQ (i.e.,
    virtqueue_add_sgs() / virtqueue_kick() directly, just targeting a request VQ instead
    of the control VQ):

    This would indeed sidestep the blk_queue_enter() reentrancy problem. However, it is
    not equivalent to simply adding a new request type — it would require changing the
    data VQ token and completion contract:

    virtblk_done() — the completion callback registered for every data VQ — unconditionally
    calls blk_mq_rq_from_pdu() and then blk_mq_complete_request() for every buffer it pulls
    off the ring. It assumes every returned token is a struct virtblk_req embedded in a
    blk-mq–allocated struct request. A new specific virtblk_crypto_request injected into a
    data VQ ring is not such an object. The completion path has no way to distinguish it,
    and treating it as one computes a bogus request pointer and corrupts blk-mq tag state.

    Making this safe would require adding out-of-band type tagging and dispatch logic into
    the hot I/O completion path, making the data-VQ callback polymorphic in a way that
    currently has no precedent.

    Furthermore, there is a scope mismatch: data VQs are scoped to individual blk-mq hardware
    queues (hctx->queue_num), whereas keyslot management is a per-device operation. On a
    multi-queue device, there is no single canonical data VQ to target. Choosing queue[0]
    arbitrarily concentrates control traffic, causes contention with that hctx's in-flight
    I/O and submission lock (vblk->vqs[i].lock), and can be blocked entirely if that ring
    is saturated.

    In summary, using a data VQ in this way is implementable in principle, but it would require
    changing the established data-VQ token/completion contract and coupling a device-scoped
    control operation to an arbitrarily chosen hctx-scoped queue.

While the separate control virtqueue provides a direct submission path without entering the
block layer, while also providing a distinct request format, completion callback, lock, and
descriptor pool. This keeps key-management operations separate from blk-mq request/tag
and from the per-hardware-queue I/O completion path.

Given the above, I prefer to having a new control VQ. I'm appreciated if you have any
insights about it. 

In addition, the control VQ is currently used for inline encryption. From the virtio
specification perspective, should we state that it is currently used only for inline
encryption, or leave room for future extensions?
