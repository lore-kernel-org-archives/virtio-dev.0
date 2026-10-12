Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72F042FCD8
	for <virtio-dev@lists.linux.dev>; Mon, 12 Oct 2026 14:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816704; cv=none; b=LifoY8Adcdib1WAWdO8M+89tCFay1ZHVgfXmaM27gdxml1xpg8DMe6TGpvijTLwUTGjjGRvLDhdeNHg2+3nWa61pZAfiWfvFOm3FKxY3RFmejK1k/MezodLTAf8JYRZTZQ48ScJx9taNmhEzwStjZSehR3osZi+moKmuVTgH/KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816704; c=relaxed/simple;
	bh=XmQkfHD9zZ0BoeERrPugV6ZCN9thz0TqK96X2pWjQKM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JHtWqvJWxU9CHtazfBCQMEbBUq6uMV+vGgEBvZBGjviAJsQVCDRmRXQr/yp4PJ/8bkYKiWGFt1KYysFeFOABl4I5/lS+R4QBU7+tYCwQuQwCu6qecNLPKXpgtkg93jkbpovZ6Lj+pv3QONgb9MqDiOKbFlKqLc0UrFviWUB3aCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=doR8hShC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FSvxPRhy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="doR8hShC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FSvxPRhy"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CBxvk51404990
	for <virtio-dev@lists.linux.dev>; Mon, 12 Oct 2026 14:51:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bmzeCZfaHaI2WE7gWjTTMAXLci8S+Je9fw7bNdngpTw=; b=doR8hShC8xTo8YVi
	afxwMHv9PMrqiAE2aQ3df4bHtkfMFMurY5m7XlGUD8Hur77wbTjJJ4nF7AZSOTFq
	EMgDUNn6EkVPkUye+7JxySC1gmGTzVXxoLKB84zPGma3dfFuWyXG/49VfGKJdb3L
	5au0u8LU4SsbSs2IOowZQNFbf4XUSaZxHbxxkEGnavFgDeuiJEvE3xlAGQ6ftYSa
	kLaYgg5Xf4CjMIUlGDQ2vzQb0ZwFBtCYJzfV4XHoxEJPKTmxHbn9iOQzRW6A5vgB
	Nz29V6nidAF7QN1Ri49QivEVmnoBmDt4CgWnfYdvBSDZ+0cnTUfCPK7KDibBqMjv
	UllITQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8v7ksmqc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Mon, 12 Oct 2026 14:51:41 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30bcb065bfdso4112696eec.0
        for <virtio-dev@lists.linux.dev>; Mon, 12 Oct 2026 07:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791816701; x=1792421501; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bmzeCZfaHaI2WE7gWjTTMAXLci8S+Je9fw7bNdngpTw=;
        b=FSvxPRhy5Jr+XCQc8OzSxiPtVUdt+Mc9Fiw/Emoy0w7b6+p4oaGXSy5obXjrpYCqhz
         0mjFcu8eTbdVvQ4meLwiL3ueFhIos/S4XcyyDg3Ex73LQ9T2sLchR36qRIEaoJ8cZvJ2
         gjQGl5HZ5MMqfrRXIjLXWztfrrp6iRcIMdDRPN3zBTl+gopndvR7ZZfUmBnlbwZ3XhmM
         8GQOxVcfRfs+0TowkqZvwX8AE8F2Q7k6fnmDXPmgsv0W8It1rjYko2TkaCOS6o81UHs3
         ka7fySQMTMGRgI2D0keeRswSmmlm3xifBQLblfadW5L5h1rHs8jmGaao4i09qvep2uFG
         qdZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791816701; x=1792421501;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bmzeCZfaHaI2WE7gWjTTMAXLci8S+Je9fw7bNdngpTw=;
        b=2sT6d/IlUng8DRO0d7HrNSx7WAbgZkHn+V+OS9wl1DnRVhg6Rs+mmlU6BXPH9k3XSC
         ig5egKY6+5JWYBBmVw7+9TPoeYWWbaNyyGyyKiyph4FWyOXKvEHVfzPTRE52NevmVgyJ
         xH/3pVV3wr4N4Q8kr4o5nPy3t9HgeoxuRNkMCujkhF/joIcLrziP8bSF/fx7ZjXqSGlF
         /Fz7otmilzo0QMDH0+Py+xiof1ljb2WcvwglTIAmC/LOfnle2uyKsUgT6sBN5Uu8lWFi
         15l4Mm0yrMwMcmRa8tacbqM145FMbrrqKuP+cfzHp72EFm075S9E52ZIStMFPbng/DxY
         qdYQ==
X-Gm-Message-State: AFq9FYI86BrLotcgmq6sRutyIWrqcdbj2+MJ/sV0e6Ff/JEz4sfGYZqA
	EveUcmFJDLfHYAM2uYHTRYmxJF2etNAnk0zmIb8I/hwBiYLfTANy6CGjw71Q8nGbp5sug5clhr/
	gbKn6cdG52xJpZibVOkxgv7J3xw4DJ2dQQWmBWKIzZKfknUgDlersP0NAeo0cGE+D8USbmzha
X-Gm-Gg: AYBFou2dqEHw/3oMPTO1nMjedwBZVLtPNg204GMO+3Xr4SR4O81A2d3QR29rlTwjFPE
	l98Rwv0/9Q5GYWnHE1p1rVUWHIuE6KcPSXerbVF9+LEvEy0vw/J1SNCH72D3ox8H5ozkwabN9jy
	f6Iso3KybnfArvsrERHS13WgMUk0pXtrisT7ts9rDydZb06CIthnW4E38R7j42M8gze9p14I8Xw
	adnuSeeg/CDgJ9WHdIOpBXMnkl+Wts0YLhMceAICSrgjsybI932vb8DLp6sC2dw+4sZGfjoPFj4
	Hbo2cMVQFaFN8OuP26a6LfT/fBgacSBnF1e9iJ7+GYivpN5WJ549XG1CRVmfraK2HH2pRURH7Mo
	qisVa/yJPfI5CiYFDzgK7uqjxuwjkD4N+vYpVP12bBmrIFZqUACIi8Q8w3A==
X-Received: by 2002:a05:7301:541a:b0:351:4564:19d3 with SMTP id 5a478bee46e88-3537e107c45mr16452555eec.27.1791816700943;
        Mon, 12 Oct 2026 07:51:40 -0700 (PDT)
X-Received: by 2002:a05:7301:541a:b0:351:4564:19d3 with SMTP id 5a478bee46e88-3537e107c45mr16452506eec.27.1791816700094;
        Mon, 12 Oct 2026 07:51:40 -0700 (PDT)
Received: from [10.110.57.134] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb1e05esm35467631eec.25.2026.10.12.07.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 07:51:39 -0700 (PDT)
Message-ID: <14186766-8636-49eb-9666-f89a6f838d7e@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 22:51:36 +0800
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] virtio-blk: Add inline encryption support
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: virtio-dev@lists.linux.dev, ebiggers@kernel.org,
        neeraj.soni@oss.qualcomm.com
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
 <e13d2da8-e8e9-4014-98f0-2c1bfa801d59@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <e13d2da8-e8e9-4014-98f0-2c1bfa801d59@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1OSBTYWx0ZWRfX2/F2jhO08Id4
 R23iDhkoEMonTyCFHQ9yWCCyw8XAhJMyoM9f1yfCFXF0owVKTHnMcsxnDZFe6f/k/Lh7iJkecqB
 m1ax0xVH9kiksGh8x01Jc1Bf3lSUovI41M8xA4rDrtU/rkz+50vD5EDVmjtjc2LYi0n4WLYg+4x
 GUnN/Lbhln76hwQ2zyzPaI8OHI+C6dn3QWw128dz1SKx/hldWYRugL5waddqEsQ9ZKONc35bB2A
 Fl0oAVrDlIsrf5UdSPJPNEYeUJwjMWVi1crZnUpZaFWGQste+uD1PDw7nxbfqPjgsOl/wouJwRg
 gn8g4VjfQTu21petTjFNUtH5ikHvzz1VroHcBwm6tNA674rzHCNIZrdDjO84L1aQV+i50c7VByj
 nkIJycV5of6zgx1YG4YKmWZrUK0f3wDbf0zHrK0p8sT5DNQv2P5jQIFtEsYMl5dV6xcXj21f2eS
 3l++15xGk+nwY33nrhA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1OSBTYWx0ZWRfX11avOeG4NN3H
 xmBUVWoyvLsaTXx9JnEiR9QCQJJ3fbvUY8ZAf2tWUAYUw97ZkfaSX7NG6RABRGG7KmsUsfjJ2+5
 hSceHIQ+lf79U2NJ+L3QUugknz5TYv8=
X-Authority-Analysis: v=2.4 cv=VOtIDNPX c=1 sm=1 tr=0 ts=6accf3fd cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=-SApMDMzhCixqWWDJfwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: ItYz4SXCFhmxcgpAwxnRNDEwSuXPQ5h_
X-Proofpoint-ORIG-GUID: ItYz4SXCFhmxcgpAwxnRNDEwSuXPQ5h_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120059



On 10/10/2026 6:54 PM, Linlin Zhang wrote:
> 
> 
> On 10/9/2026 8:25 PM, Michael S. Tsirkin wrote:
>> On Fri, Oct 09, 2026 at 07:21:13PM +0800, Linlin Zhang wrote:
>>>
>>>
>>> On 10/8/2026 6:15 PM, Michael S. Tsirkin wrote:
>>>> On Thu, Oct 08, 2026 at 05:17:30PM +0800, Linlin Zhang wrote:
>>>>>
>>>>>
>>>>> On 9/30/2026 6:46 AM, Max Gurtovoy wrote:
>>>>>>
>>>>>> On 24/09/2026 12:35, Linlin Zhang wrote:
>>>>>>>
>>>>>>> On 9/22/2026 9:14 PM, Stefan Hajnoczi wrote:
>>>>>>>> On Tue, Sep 22, 2026 at 12:29:37PM +0800, Linlin Zhang wrote:
>>>>>>>>>
>>>>>>>>> On 9/18/2026 5:08 AM, Stefan Hajnoczi wrote:
>>>>>>>>>> On Sun, Sep 13, 2026 at 09:16:13AM -0700, Linlin Zhang wrote:
>>>>>>>>>>> From: linlzhan <linlin.zhang@oss.qualcomm.com>
>>>>>>>>>>>
>>>>>>>>>>> This series adds virtio-blk inline encryption support for devices backed
>>>>>>>>>>> by storage hardware with an inline crypto engine.
>>>>>>>>>>>
>>>>>>>>>>> The protocol exposes device capabilities such as keyslot count, maximum
>>>>>>>>>>> DUN size, and supported key types. Encrypted requests identify a
>>>>>>>>>>> provisioned keyslot and carry a 256-bit DUN. Key management and crypto
>>>>>>>>>>> capability discovery use the block device control virtqueue.
>>>>>>>>>>>
>>>>>>>>>>> The control virtqueue is defined as a generic framework so that its
>>>>>>>>>>> buffer layout and queue placement are independent of any particular
>>>>>>>>>>> control command. Inline encryption then builds on this framework with
>>>>>>>>>>> explicit crypto command formats, capability validation, and keyslot
>>>>>>>>>>> state semantics.
>>>>>>>>>>>
>>>>>>>>>>> All key related operatios are handled in the control virtqueue, and
>>>>>>>>>>> the crypto I/O request is handled in the request queue.
>>>>>>>>>>>
>>>>>>>>>>> For background on inline encryption in UFS and eMMC storage, see:
>>>>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/block/inline-encryption.rst
>>>>>>>>>>>
>>>>>>>>>>> changes in v3:
>>>>>>>>>>>   - Add a control virtqueue
>>>>>>>>>>>   - Move key program/evict/derive_sw_secret/generate/prepare/import to
>>>>>>>>>>>     the control virtqueue
>>>>>>>>>> Thank you. This was a big change, especially if you already have an
>>>>>>>>>> implementation. I appreciate it!
>>>>>>>>>>
>>>>>>>>>> My main feedback is that the new control virtqueue commands are not yet
>>>>>>>>>> documented in enough detail so that implementors could implement them.
>>>>>>>>>> Once you've decided on the precise semantics, error codes, etc and added
>>>>>>>>>> them to the spec, then this will round off the inline encryption
>>>>>>>>>> feature. I look forward to reviewing that in the future.
>>>>>>>>>>
>>>>>>>>> Thanks a lot for your comment!
>>>>>>>>>
>>>>>>>>> Would you please help clarify what the precise semantics are about? detail
>>>>>>>>> introduction of the filed in the inline encryption control command struct?
>>>>>>>>> like struct virtio_blk_crypto_key_desc?
>>>>>>>> By precise semantics, I mean specifying not just the constants and
>>>>>>>> structs, but documenting what each command does and how it can fail.
>>>>>>>> Each of the key slot programming commands needs this. There should be at
>>>>>>>> least one paragraph for each of VIRTIO_BLK_T_CRYPTO_KEYSLOT_PROGRAM,
>>>>>>>> VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT, VIRTIO_BLK_T_CRYPTO_DERIVE_SW_SECRET,
>>>>>>>> VIRTIO_BLK_T_CRYPTO_GENERATE_KEY, VIRTIO_BLK_T_CRYPTO_IMPORT_KEY, or
>>>>>>>> VIRTIO_BLK_T_CRYPTO_PREPARE_KEY.
>>>>>>>>
>>>>>>>> For example:
>>>>>>>>
>>>>>>>> The VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT command empties a key slot so that
>>>>>>>> key information is removed and the key slot cannot be used until it is
>>>>>>>> programmed again. The key slot index is specified by struct
>>>>>>>> virtio_blk_crypto_key_desc \field{slot} and all other fields in the
>>>>>>>> struct are ignored. The command succeeds with VIRTIO_BLK_S_OK if the key
>>>>>>>> slot index is valid, including if the slot is already empty. If the key
>>>>>>>> slot index is invalid, the command fails with VIRTIO_BLK_S_IOERR.
>>>>>>>>
>>>>>>>> Stefan
>>>>>>> Thanks for the clear example.
>>>>>>>
>>>>>>> I'll follow the same approach and add explicit normative semantics for
>>>>>>> all inline encryption control requests.
>>>>>> Can you please explain why we need to introduce yet another VQ type for control?
>>>>>>
>>>>>> We've added the Admin VQ as a generic VQ for control operations — I'm not sure why it isn't sufficient.
>>>>>>
>>>>>> Adding control VQ to each device type seems strange to me after adding a generic Admin VQ.
>>>>>
>>>>> Thanks for your comment! And I agree that the Admin VQ should be considered before
>>>>> adding another device-specific control virtqueue.
>>>>>
>>>>> My understanding is that some of the inline encryption commands(get_crypto_modes/program key
>>>>> /derive_sw_secret/evict key) are runtime operations of a specific virtio-blk deivce.
>>>>> In particular, different virtio block devices may have different storage hardware sources
>>>>> of crypto modes, and keyslot programming and eviction are invoked through the block device's
>>>>> keyslot manager, and the programmed virtual keyslots are subsequently referenced by the
>>>>> encryption requests submitted on that device's request virtqueues. These commands are
>>>>> not about the management operation of device group.
>>>>>
>>>>> There is also a transport compatibility concern. The current virtio SPEC states that
>>>>> 'Devices and drivers utilizing Virtio Over MMIO do not support VIRTIO_F_ADMIN_VQ'.
>>>>> virtio MMIO is extensively used, so using the Admin VQ would make the feature unavailable
>>>>> for that transport unless the proposal also extended the MMIO transport.
>>>>>
>>>>> For these reasons, currently I believe that a virtio-blk control virtqueue is the better
>>>>> fit: it keeps the complete key lifecycle associated with the block device and remains
>>>>> usable across the transports required by the feature.
>>>>>
>>>>> I would appreciate any feedback or insights from you and Stefan on the V5 patch series
>>>>> posted for review before October ASAP.
>>>>>
>>>>
>>>> Fundamentally, it does not make sense to force all vqs to be admin VQs.
>>>>
>>>> Admin vq would make sense if there is complex resource management going
>>>> on - like what is happening with all the flow control things in the
>>>> network device, since they have extensive functionality for managing
>>>> device resources.
>>>>
>>>> Random device specific commands - I am not sure we want that.
>>>> It remains to be proven.
>>>>
>>>> But generally why does this go on a special VQ? Is there a reason?
>>>>
>>>> You define distinct request types seemingly and we are not short on types?
>>>>
>>>
>>> Thanks for your comments!
>>>
>>> The key programming operation is initiated while preparing a block I/O
>>> request and sent to the VQ after the block I/O request has entered the
>>> block request queue, before the request is submitted to the device's VQ.
>>> see blk_mq_submit_bio(). Using the same virtqueue for both key-program
>>> command and normal I/O could lead to bio_queue_enter() called 2 times
>>> for the same block queue, which is possible to have deadlock if
>>> blk_mq_freeze_queue() is called between above 2 bio_queue_enter() caller.
>>>
>>> A separate control virtqueue provides an independent execution path for
>>> key programming, key eviction, and related operations. It allows these
>>> operations to be issued even when the normal request virtqueues are full
>>> or unable to make progress. Once the operation completes, the corresponding
>>> request can safely reference the programmed virtual keyslot.
>>>
>>> For such reasons, we believe that a virtio-blk-specific control VQ is a
>>> more appropriate mechanism than the standard VQ.
>>
>> I don't understand. Do these commands go through bio queue?
>> Don't they go to VQ directly, just like you would with the control VQ?
>>
> 
> Thanks for your comment! my earlier reply conflated two separate concerns.
> Let me address them precisely based on Linux kernel code.
> 
> I agree that block-layer queue entry and virtqueue selection are independent
> issues.
> 
> Whether key program commands going through bio queue or not depends on the
> implementation.
> 
>   - Option A: Reuse the standard block-request helpers (e.g.,
>     blk_mq_alloc_request() + blk_execute_rq(), the same pattern virtblk_get_id()
>     uses):
>     
>       - blk_mq_submit_bio()
>          -> blk_crypto_submit_bio()   # outer bio_queue_enter() already held
>            -> keyslot manager
>              -> virtblk_crypto_keyslot_program()
>                -> blk_mq_alloc_request()
>                  -> blk_queue_enter()    # deadlock: freeze in progress
> 
>     This is not safe at the keyslot-manager call site. Key programming is invoked
>     from inside blk_mq_submit_bio(), at a point where the submitting thread already
>     holds an unreleased reference from an earlier bio_queue_enter() call on the same
>     queue. Calling blk_queue_enter() a second time on the same thread and queue —
>     while a concurrent blk_mq_freeze_queue() is in flight — produces a circular wait:
>     the freezer blocks waiting for all references (including the outer one) to drop to
>     zero, while the submitting thread blocks waiting for the freeze depth to clear.
>     Neither can make progress. The problem is not allocation starvation but queue-entry
>     reentrancy under freeze. 
> 
>     This is the deadlock concern I mentioned last time.
> 
>   - Option B: Bypass the block layer entirely and raw-submit to a data VQ (i.e.,
>     virtqueue_add_sgs() / virtqueue_kick() directly, just targeting a request VQ instead
>     of the control VQ):
> 
>     This would indeed sidestep the blk_queue_enter() reentrancy problem. However, it is
>     not equivalent to simply adding a new request type — it would require changing the
>     data VQ token and completion contract:
> 
>     virtblk_done() — the completion callback registered for every data VQ — unconditionally
>     calls blk_mq_rq_from_pdu() and then blk_mq_complete_request() for every buffer it pulls
>     off the ring. It assumes every returned token is a struct virtblk_req embedded in a
>     blk-mq–allocated struct request. A new specific virtblk_crypto_request injected into a
>     data VQ ring is not such an object. The completion path has no way to distinguish it,
>     and treating it as one computes a bogus request pointer and corrupts blk-mq tag state.
> 
>     Making this safe would require adding out-of-band type tagging and dispatch logic into
>     the hot I/O completion path, making the data-VQ callback polymorphic in a way that
>     currently has no precedent.
> 
>     Furthermore, there is a scope mismatch: data VQs are scoped to individual blk-mq hardware
>     queues (hctx->queue_num), whereas keyslot management is a per-device operation. On a
>     multi-queue device, there is no single canonical data VQ to target. Choosing queue[0]
>     arbitrarily concentrates control traffic, causes contention with that hctx's in-flight
>     I/O and submission lock (vblk->vqs[i].lock), and can be blocked entirely if that ring
>     is saturated.
> 
>     In summary, using a data VQ in this way is implementable in principle, but it would require
>     changing the established data-VQ token/completion contract and coupling a device-scoped
>     control operation to an arbitrarily chosen hctx-scoped queue.
> 
> While the separate control virtqueue provides a direct submission path without entering the
> block layer, while also providing a distinct request format, completion callback, lock, and
> descriptor pool. This keeps key-management operations separate from blk-mq request/tag
> and from the per-hardware-queue I/O completion path.
> 
> Given the above, I prefer to having a new control VQ. I'm appreciated if you have any
> insights about it. 
> 
> In addition, the control VQ is currently used for inline encryption. From the virtio
> specification perspective, should we state that it is currently used only for inline
> encryption, or leave room for future extensions?

Qualcomm has customers' use case that requires inline encryption support in virtio-blk
to enable hardware-based file-based encryption (FBE) in guest VMs. The corresponding
product release depends on the virtio specification changes proposed in this series.

Would you please help review the v5 patch series below?

https://lore.kernel.org/all/20260929042152.4099414-1-linlin.zhang@oss.qualcomm.com/

Any comments, feedback, or approval would be greatly appreciated.

-Linlin
