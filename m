Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D1D4A3F02
	for <virtio-dev@lists.linux.dev>; Thu, 15 Oct 2026 11:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792064970; cv=none; b=oo9RUcyyqddjV8m7+qrxWYS1SjemI9feTE41w64q7Z7FLSBwOA8PGs57HWEMX/XDYjTNMOxIU+S6YEW8370VMxKXi0GQahZ1TYSJd++6C8+ww2u8WgZ93FZ2lEul7rpYwdL2E3BohLBjQJKKah4sJxYFb0UlVMysa0xvEdcCvWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792064970; c=relaxed/simple;
	bh=I8JwMXXjl/VK7P4QhxlJ0QnONWprrZGjwQq7LGxpg58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IudruEsbs+p0b8pFu6rxdKx8iZirlrwMh+OzKO9gI3Iunb29rsfO4Vs10sU0qO7jMwwv57ozdL+DhWbEYV40Ux1yDbF9pd401HDiQ5/fGINGGMpHZ+0h+u6ZLPpBtl5nUytUKNs485B8bPOqKGDlv/bxx0fxFEFiDPw+fIRZgmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NSbXiQIs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fnZE63bd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NSbXiQIs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fnZE63bd"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FAQ38i4101541
	for <virtio-dev@lists.linux.dev>; Thu, 15 Oct 2026 11:49:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LSvQfyiuSBcUvqQRkTvO+GIjFqkXPYTf9zTWnhDE4Zc=; b=NSbXiQIs8W+Ki6Nc
	bjFbYzAc99jwwHkgryuaqOqtNtvqenNVTSWLad5HIrU8ZKIOKGWElO7FFRycEQkk
	aCXbRiSg0dSO4Eq0xnz2yzXyGcjqh8JaCLKtBZ18kFf1s05fFaRcGbe25g6lx13x
	RjeX3hw47Wx4vfWZ4imGsPT8ZA/l6swSmio0V2d3yk1z8Uxq3ltLbtlT8XQYrWn3
	uphWd5N6nHeUw2jXngYwsGluniorYlqdKxy+6ccJ9IQlWAn8o9yf0v3TWVuUbpVJ
	G9d0VeiON6CBcsoR18Dnn+ZJN8+9+twQkY1KKvJ0xF9mEdeGscNJ/dU4B/XVgcNt
	+cp2jw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haw2r89u2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Thu, 15 Oct 2026 11:49:27 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3548cdfd2fbso7801268eec.1
        for <virtio-dev@lists.linux.dev>; Thu, 15 Oct 2026 04:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792064967; x=1792669767; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LSvQfyiuSBcUvqQRkTvO+GIjFqkXPYTf9zTWnhDE4Zc=;
        b=fnZE63bdr3NgtiUw+4kQNfq8kUr+HIIb/r6nOXjoWD2ZTDjtvgJBy+7iihW536mv8x
         TgFqJWsRPnvp/P0evfTZIaEJM8MEJOn8msMcSLe1sSAZmWP9GianSRNpvUr3MeDFIafn
         FwjnA5RM5mC/wPB9YxBgggP+0k94eDHhXrEKSZx0T0u5imwwrYUyasX5PnUqpqnS2Lvb
         JKKzCM/IiXQK6Fl26Quh/HVIlx945+UbshmN+7lD4ngullg/GsyfnLHfmXpx/7+Hykvz
         XYRbQ9Jgkf0GrDT9NG/qZRdJM98g3/V64b3tmRt5ycLs4gdLZqhvv72TCkS9S7AczHnR
         CSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792064967; x=1792669767;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LSvQfyiuSBcUvqQRkTvO+GIjFqkXPYTf9zTWnhDE4Zc=;
        b=jxT1mNLP4CqX09qRz0tb+OJPnjSVLZ5tCm96t/XtpzkjfoyISFjqjTICeodXEu0hk5
         F3+eMgwUFvZsSJzn5YZ9L76XlrhIoR7uEJ+EP8UEk5siU2a45P35CNaCBO2XwoKNhM04
         XVBi/eG6tO0PlJABCj7arJV1/uq7kN3UV0LJ5xRTDZCFeaDUC7L+xzFs+GaNwJOP5BUC
         ogURENCvlBf1sVlSDw2dVSnrByaS/vJnO8H4pWYejvSMMPiCwvc9x3Q8zvxUpjjOVVmN
         w8Ok+7BjqZoZVM/R9IH4KD/BDekyjR1W3cgegM6hn7ZfR43jjlGQ9yS7p2vKCukUA0rj
         FQFQ==
X-Forwarded-Encrypted: i=1; AKwUvBwcXB2bZAcZekGZYKQYeb4l+HRjBIs2ohWNE+hGr9dBfFJ1MBUvKMyID4yMofT2SNoGJeLrDqMvxYgh@lists.linux.dev
X-Gm-Message-State: AFq9FYLn58ZofSW4PXvUBsH/GNIrhTCo0izf6bi2PJWbalpcUgkMDCqU
	XBjJRTgzCHgT0rnr6+ZNxeF492hftUIBU/hACsHL0GBRkTWll7peKWSVLjbmXu+F6ciV0XAz8Uy
	AQbjrPRIlK9K49dBcAYmMR/9GHHHZuZ/A3CwyDZaZQuO6EBChhN4kKl57jrNnDeYf
X-Gm-Gg: AYBFou3Gyk8rsHotnCvhi/mr22cyh6ggTDJGaJXiDC7CUl8dGpwiC8zMy9WFETnjjP8
	tFzJwCxFjDGhX12Ezlo5xZ+EdgZgPg0mHOaKFKNE2fU+SnNf05aqtKucIKO/vO+KgwLlnOc/kkS
	EqjhEkL4btKfl/MVsZ0yoiQ5hRDgkaO/5K5RZEVCFSzWhCOP5TYB/LqUnFcpQwTHvgjSm/lhkeS
	Z/6diOCuCkrVfjugaXTkY9RcO1RxiTvzdNohz12INJkHgVplPjq60qDttMFMBH6JS0hnQtWwxeY
	qcC+MmAPVI3weW7FW2dKp2YE6BMI0Od5+X+eMObMesnQyCtiOnMxJr0UMqpe4681dLq1orSn54u
	f1OZEfc2FqZGZ9oBZv+al9WJM5xDsIBPo7x04SdN3y72s/srTqzo6rQDf
X-Received: by 2002:a05:7022:2211:b0:14a:51c8:e9f2 with SMTP id a92af1059eb24-16a62228e97mr36183664c88.31.1792064966469;
        Thu, 15 Oct 2026 04:49:26 -0700 (PDT)
X-Received: by 2002:a05:7022:2211:b0:14a:51c8:e9f2 with SMTP id a92af1059eb24-16a62228e97mr36183615c88.31.1792064965749;
        Thu, 15 Oct 2026 04:49:25 -0700 (PDT)
Received: from [10.110.42.127] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a442ac67sm85974244c88.18.2026.10.15.04.49.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 04:49:25 -0700 (PDT)
Message-ID: <680ef7d9-f4c1-4f8c-9d89-3a65c6731950@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 19:49:21 +0800
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] virtio-blk: Add inline encryption support
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
        Max Gurtovoy
 <mgurtovoy@nvidia.com>, virtio-dev@lists.linux.dev,
        ebiggers@kernel.org, neeraj.soni@oss.qualcomm.com
References: <20260922131442.GB18339@fedora>
 <3a933df3-dff7-4ef3-a120-4c6e22c1fcc1@oss.qualcomm.com>
 <de535820-591b-40f2-b840-d987c3253765@nvidia.com>
 <9515779b-a6da-407f-99f2-011e51683d15@oss.qualcomm.com>
 <20261008060644-mutt-send-email-mst@kernel.org>
 <bfbb51cb-8a90-4b23-8ed1-26ea41102dd6@oss.qualcomm.com>
 <20261009081523-mutt-send-email-mst@kernel.org>
 <e13d2da8-e8e9-4014-98f0-2c1bfa801d59@oss.qualcomm.com>
 <20261012183102-mutt-send-email-mst@kernel.org>
 <7a95c6b2-0a7e-4322-ad77-4e3ea13efdbd@oss.qualcomm.com>
 <20261013190758.GA1301500@shajnocz.csb>
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <20261013190758.GA1301500@shajnocz.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA0NiBTYWx0ZWRfX5vIG58FDark9
 oGym9n4mWgmFtcIVV5d50U0khPxn4aGK3W6WvNbC3BEFwujBZh/yhB5B3WNpYeM0+1fSvkAFqQX
 Lp7Go1Hld6dUAVpjNych+YRQIOVy06Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA0NiBTYWx0ZWRfX6GgM0DKkj+8h
 BiUQXdXydnlma2Mz/2XxcfFeeti6oVA5CAHaPRQWcc6dwLCxn73j+53zYEo5VKn2OdZ1gNmeB6Y
 OfCMXtK2Og/XjDEZSIfCjRKYNTUI7Z2TqCKiPOv0f9xhn1cqJKjyYWNKH0ISsIJZG01pzxKTwvO
 VamXF+nTP4Hsk98R2WcU7PN+ae+qgk+UQ/p752mEs1mXSRFdNtfH6FYjKwL7AjpM2EWSqhBpo9M
 qarY3DVTzTzBjrK2r8C/AG0odIs6XNEgtZh3KwRe6LMDXYu924EFzkDEE2sxtIzP84uMK6uCapS
 PD4R668dO02d7bK5M9tpkpb0qrl0K9d8VAjCbCLo90w7kMkcyOO62InVXLlaFZiC9iuRDm4GG1e
 l6Yr4UnShe/c9byobk/H+NmMwoqX1uinQP8BhRPYy7Lg9cGC3im2LqfY/jAHWVXnQ7FYtNpzAqt
 00D0urYVcUiaHjHjdeQ==
X-Authority-Analysis: v=2.4 cv=BNMmP1QG c=1 sm=1 tr=0 ts=6ad0bdc7 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=-8XRhPiLGLbjqLAzQUYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: 1670WG7On6H7yIbq1Y5Lc7m0com0-Dnk
X-Proofpoint-ORIG-GUID: 1670WG7On6H7yIbq1Y5Lc7m0com0-Dnk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150046



On 10/14/2026 3:07 AM, Stefan Hajnoczi wrote:
> On Wed, Oct 14, 2026 at 12:23:16AM +0800, Linlin Zhang wrote:
>>
>>
>> On 10/13/2026 6:33 AM, Michael S. Tsirkin wrote:
>>> On Sat, Oct 10, 2026 at 06:54:06PM +0800, Linlin Zhang wrote:
>>>>
>>>>
>>>> On 10/9/2026 8:25 PM, Michael S. Tsirkin wrote:
>>>>> On Fri, Oct 09, 2026 at 07:21:13PM +0800, Linlin Zhang wrote:
>>>>>>
>>>>>>
>>>>>> On 10/8/2026 6:15 PM, Michael S. Tsirkin wrote:
>>>>>>> On Thu, Oct 08, 2026 at 05:17:30PM +0800, Linlin Zhang wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 9/30/2026 6:46 AM, Max Gurtovoy wrote:
>>>>>>>>>
>>>>>>>>> On 24/09/2026 12:35, Linlin Zhang wrote:
>>>>>>>>>>
>>>>>>>>>> On 9/22/2026 9:14 PM, Stefan Hajnoczi wrote:
>>>>>>>>>>> On Tue, Sep 22, 2026 at 12:29:37PM +0800, Linlin Zhang wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> On 9/18/2026 5:08 AM, Stefan Hajnoczi wrote:
>>>>>>>>>>>>> On Sun, Sep 13, 2026 at 09:16:13AM -0700, Linlin Zhang wrote:
>>>>>>>>>>>>>> From: linlzhan <linlin.zhang@oss.qualcomm.com>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> This series adds virtio-blk inline encryption support for devices backed
>>>>>>>>>>>>>> by storage hardware with an inline crypto engine.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> The protocol exposes device capabilities such as keyslot count, maximum
>>>>>>>>>>>>>> DUN size, and supported key types. Encrypted requests identify a
>>>>>>>>>>>>>> provisioned keyslot and carry a 256-bit DUN. Key management and crypto
>>>>>>>>>>>>>> capability discovery use the block device control virtqueue.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> The control virtqueue is defined as a generic framework so that its
>>>>>>>>>>>>>> buffer layout and queue placement are independent of any particular
>>>>>>>>>>>>>> control command. Inline encryption then builds on this framework with
>>>>>>>>>>>>>> explicit crypto command formats, capability validation, and keyslot
>>>>>>>>>>>>>> state semantics.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> All key related operatios are handled in the control virtqueue, and
>>>>>>>>>>>>>> the crypto I/O request is handled in the request queue.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> For background on inline encryption in UFS and eMMC storage, see:
>>>>>>>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/block/inline-encryption.rst
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> changes in v3:
>>>>>>>>>>>>>>   - Add a control virtqueue
>>>>>>>>>>>>>>   - Move key program/evict/derive_sw_secret/generate/prepare/import to
>>>>>>>>>>>>>>     the control virtqueue
>>>>>>>>>>>>> Thank you. This was a big change, especially if you already have an
>>>>>>>>>>>>> implementation. I appreciate it!
>>>>>>>>>>>>>
>>>>>>>>>>>>> My main feedback is that the new control virtqueue commands are not yet
>>>>>>>>>>>>> documented in enough detail so that implementors could implement them.
>>>>>>>>>>>>> Once you've decided on the precise semantics, error codes, etc and added
>>>>>>>>>>>>> them to the spec, then this will round off the inline encryption
>>>>>>>>>>>>> feature. I look forward to reviewing that in the future.
>>>>>>>>>>>>>
>>>>>>>>>>>> Thanks a lot for your comment!
>>>>>>>>>>>>
>>>>>>>>>>>> Would you please help clarify what the precise semantics are about? detail
>>>>>>>>>>>> introduction of the filed in the inline encryption control command struct?
>>>>>>>>>>>> like struct virtio_blk_crypto_key_desc?
>>>>>>>>>>> By precise semantics, I mean specifying not just the constants and
>>>>>>>>>>> structs, but documenting what each command does and how it can fail.
>>>>>>>>>>> Each of the key slot programming commands needs this. There should be at
>>>>>>>>>>> least one paragraph for each of VIRTIO_BLK_T_CRYPTO_KEYSLOT_PROGRAM,
>>>>>>>>>>> VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT, VIRTIO_BLK_T_CRYPTO_DERIVE_SW_SECRET,
>>>>>>>>>>> VIRTIO_BLK_T_CRYPTO_GENERATE_KEY, VIRTIO_BLK_T_CRYPTO_IMPORT_KEY, or
>>>>>>>>>>> VIRTIO_BLK_T_CRYPTO_PREPARE_KEY.
>>>>>>>>>>>
>>>>>>>>>>> For example:
>>>>>>>>>>>
>>>>>>>>>>> The VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT command empties a key slot so that
>>>>>>>>>>> key information is removed and the key slot cannot be used until it is
>>>>>>>>>>> programmed again. The key slot index is specified by struct
>>>>>>>>>>> virtio_blk_crypto_key_desc \field{slot} and all other fields in the
>>>>>>>>>>> struct are ignored. The command succeeds with VIRTIO_BLK_S_OK if the key
>>>>>>>>>>> slot index is valid, including if the slot is already empty. If the key
>>>>>>>>>>> slot index is invalid, the command fails with VIRTIO_BLK_S_IOERR.
>>>>>>>>>>>
>>>>>>>>>>> Stefan
>>>>>>>>>> Thanks for the clear example.
>>>>>>>>>>
>>>>>>>>>> I'll follow the same approach and add explicit normative semantics for
>>>>>>>>>> all inline encryption control requests.
>>>>>>>>> Can you please explain why we need to introduce yet another VQ type for control?
>>>>>>>>>
>>>>>>>>> We've added the Admin VQ as a generic VQ for control operations — I'm not sure why it isn't sufficient.
>>>>>>>>>
>>>>>>>>> Adding control VQ to each device type seems strange to me after adding a generic Admin VQ.
>>>>>>>>
>>>>>>>> Thanks for your comment! And I agree that the Admin VQ should be considered before
>>>>>>>> adding another device-specific control virtqueue.
>>>>>>>>
>>>>>>>> My understanding is that some of the inline encryption commands(get_crypto_modes/program key
>>>>>>>> /derive_sw_secret/evict key) are runtime operations of a specific virtio-blk deivce.
>>>>>>>> In particular, different virtio block devices may have different storage hardware sources
>>>>>>>> of crypto modes, and keyslot programming and eviction are invoked through the block device's
>>>>>>>> keyslot manager, and the programmed virtual keyslots are subsequently referenced by the
>>>>>>>> encryption requests submitted on that device's request virtqueues. These commands are
>>>>>>>> not about the management operation of device group.
>>>>>>>>
>>>>>>>> There is also a transport compatibility concern. The current virtio SPEC states that
>>>>>>>> 'Devices and drivers utilizing Virtio Over MMIO do not support VIRTIO_F_ADMIN_VQ'.
>>>>>>>> virtio MMIO is extensively used, so using the Admin VQ would make the feature unavailable
>>>>>>>> for that transport unless the proposal also extended the MMIO transport.
>>>>>>>>
>>>>>>>> For these reasons, currently I believe that a virtio-blk control virtqueue is the better
>>>>>>>> fit: it keeps the complete key lifecycle associated with the block device and remains
>>>>>>>> usable across the transports required by the feature.
>>>>>>>>
>>>>>>>> I would appreciate any feedback or insights from you and Stefan on the V5 patch series
>>>>>>>> posted for review before October ASAP.
>>>>>>>>
>>>>>>>
>>>>>>> Fundamentally, it does not make sense to force all vqs to be admin VQs.
>>>>>>>
>>>>>>> Admin vq would make sense if there is complex resource management going
>>>>>>> on - like what is happening with all the flow control things in the
>>>>>>> network device, since they have extensive functionality for managing
>>>>>>> device resources.
>>>>>>>
>>>>>>> Random device specific commands - I am not sure we want that.
>>>>>>> It remains to be proven.
>>>>>>>
>>>>>>> But generally why does this go on a special VQ? Is there a reason?
>>>>>>>
>>>>>>> You define distinct request types seemingly and we are not short on types?
>>>>>>>
>>>>>>
>>>>>> Thanks for your comments!
>>>>>>
>>>>>> The key programming operation is initiated while preparing a block I/O
>>>>>> request and sent to the VQ after the block I/O request has entered the
>>>>>> block request queue, before the request is submitted to the device's VQ.
>>>>>> see blk_mq_submit_bio(). Using the same virtqueue for both key-program
>>>>>> command and normal I/O could lead to bio_queue_enter() called 2 times
>>>>>> for the same block queue, which is possible to have deadlock if
>>>>>> blk_mq_freeze_queue() is called between above 2 bio_queue_enter() caller.
>>>>>>
>>>>>> A separate control virtqueue provides an independent execution path for
>>>>>> key programming, key eviction, and related operations. It allows these
>>>>>> operations to be issued even when the normal request virtqueues are full
>>>>>> or unable to make progress. Once the operation completes, the corresponding
>>>>>> request can safely reference the programmed virtual keyslot.
>>>>>>
>>>>>> For such reasons, we believe that a virtio-blk-specific control VQ is a
>>>>>> more appropriate mechanism than the standard VQ.
>>>>>
>>>>> I don't understand. Do these commands go through bio queue?
>>>>> Don't they go to VQ directly, just like you would with the control VQ?
>>>>>
>>>>
>>>> Thanks for your comment! my earlier reply conflated two separate concerns.
>>>> Let me address them precisely based on Linux kernel code.
>>>>
>>>> I agree that block-layer queue entry and virtqueue selection are independent
>>>> issues.
>>>>
>>>> Whether key program commands going through bio queue or not depends on the
>>>> implementation.
>>>>
>>>>   - Option A: Reuse the standard block-request helpers (e.g.,
>>>>     blk_mq_alloc_request() + blk_execute_rq(), the same pattern virtblk_get_id()
>>>>     uses):
>>>>     
>>>>       - blk_mq_submit_bio()
>>>>          -> blk_crypto_submit_bio()   # outer bio_queue_enter() already held
>>>>            -> keyslot manager
>>>>              -> virtblk_crypto_keyslot_program()
>>>>                -> blk_mq_alloc_request()
>>>>                  -> blk_queue_enter()    # deadlock: freeze in progress
>>>>
>>>>     This is not safe at the keyslot-manager call site. Key programming is invoked
>>>>     from inside blk_mq_submit_bio(), at a point where the submitting thread already
>>>>     holds an unreleased reference from an earlier bio_queue_enter() call on the same
>>>>     queue. Calling blk_queue_enter() a second time on the same thread and queue —
>>>>     while a concurrent blk_mq_freeze_queue() is in flight — produces a circular wait:
>>>>     the freezer blocks waiting for all references (including the outer one) to drop to
>>>>     zero, while the submitting thread blocks waiting for the freeze depth to clear.
>>>>     Neither can make progress. The problem is not allocation starvation but queue-entry
>>>>     reentrancy under freeze. 
>>>>
>>>>     This is the deadlock concern I mentioned last time.
>>>>
>>>>   - Option B: Bypass the block layer entirely and raw-submit to a data VQ (i.e.,
>>>>     virtqueue_add_sgs() / virtqueue_kick() directly, just targeting a request VQ instead
>>>>     of the control VQ):
>>>>
>>>>     This would indeed sidestep the blk_queue_enter() reentrancy problem. However, it is
>>>>     not equivalent to simply adding a new request type — it would require changing the
>>>>     data VQ token and completion contract:
>>>>
>>>>     virtblk_done() — the completion callback registered for every data VQ — unconditionally
>>>>     calls blk_mq_rq_from_pdu() and then blk_mq_complete_request() for every buffer it pulls
>>>>     off the ring. It assumes every returned token is a struct virtblk_req embedded in a
>>>>     blk-mq–allocated struct request. A new specific virtblk_crypto_request injected into a
>>>>     data VQ ring is not such an object. The completion path has no way to distinguish it,
>>>>     and treating it as one computes a bogus request pointer and corrupts blk-mq tag state.
>>>>
>>>>     Making this safe would require adding out-of-band type tagging and dispatch logic into
>>>>     the hot I/O completion path, making the data-VQ callback polymorphic in a way that
>>>>     currently has no precedent.
>>>>
>>>>     Furthermore, there is a scope mismatch: data VQs are scoped to individual blk-mq hardware
>>>>     queues (hctx->queue_num), whereas keyslot management is a per-device operation. On a
>>>>     multi-queue device, there is no single canonical data VQ to target. Choosing queue[0]
>>>>     arbitrarily concentrates control traffic, causes contention with that hctx's in-flight
>>>>     I/O and submission lock (vblk->vqs[i].lock), and can be blocked entirely if that ring
>>>>     is saturated.
>>>>
>>>>     In summary, using a data VQ in this way is implementable in principle, but it would require
>>>>     changing the established data-VQ token/completion contract and coupling a device-scoped
>>>>     control operation to an arbitrarily chosen hctx-scoped queue.
>>>
>>>
>>> Actually even simpler. Option C: spec allows any mix. Linux practically
>>> can choose a VQ and dedicates it to the key slot management.
>>> It can then submit requests there in any way it wants.
>>> No?
>>
>> Thanks, this seems a simpler implementation. If I understand correctly, the driver could
>> reserve one of the request VQs exclusively for keyslot-management commands and raw-submit
>> the commands to that VQ.
>>
>> But I see a few issues that may need to be defined:
>>   1. This approach depends on VIRTIO_BLK_F_MQ to be negotiated and requires the device to expose
>>      at least two request virtqueues. It would therefore provide no usable fallback for a
>>      single-queue device.
>>   2. All negotiated queues are exposed through the existing requestq interface, and the
>>     spec provides no standardized way to identify one of them as a dedicate queue. Reserving
>>     one request VQ for key management would therefore be a driver/backend convention rather
>>     than an explicitly negotiated device interface. This also decreasing the code portability.
> 
> I'm a little hesitant about this approach because it makes vq affinity
> hard. Today guest drivers that want good multi-core performance will
> dedicate each vq to a specific CPU. In a virtualization use case there
> might be thread pinning on the host side.
> 
> Now if the driver arbitrarily chooses a vq for key slot programming,
> then the host-side pinning may be suboptimal and there is no good way of
> configuring this automatically.

Thanks for pointing it out! 

This indeed a challenge and impact the multi-core performance.

> 
> In practice maybe the convention will be that drivers choose the vq with
> the index num_vcpu+1 as the key slot programming vq. But then, have we
> achieved anything other than baking in an assumption (i.e. convention)
> that is not in the spec? Better to document that officially the vq with
> the index num_vcpus+1 is always used for keyslot programming in the
> VIRTIO spec.

Agree. Taking the above concerns into account, introducing a dedicated
control VQ is less intrusive than changing the semantics of an existing
request VQ to carry control commands.

I lean towards the dedicated VQ.

> 
>>   3. The dedicated queue would still use the normal virtio-blk request framing, including
>>     struct virtio_blk_outhdr, even though fields such as ioprio and sector have no meaningful
>>     semantics for key-management commands. This is workable, but it makes the control protocol
>>     inherit data-request framing that it does not naturally need.
>>
>> If these are acceptable, Option C could avoid adding a new control VQ. But I think the
>> queue-selection and feature-dependency rules would still need to be specified explicitly.
>>
>> Could you please help comments about these above concerns? Taking this concern into account,
>> I feel a dedicate control queue seems more proper.
> 
> I still lean towards the dedicated vq - either the Admin VQ or a
> virtio-blk-specific vq.
> 
>>>
>>>
>>>> While the separate control virtqueue provides a direct submission path without entering the
>>>> block layer, while also providing a distinct request format, completion callback, lock, and
>>>> descriptor pool. This keeps key-management operations separate from blk-mq request/tag
>>>> and from the per-hardware-queue I/O completion path.
>>>>
>>>> Given the above, I prefer to having a new control VQ. I'm appreciated if you have any
>>>> insights about it. 
>>>>
>>>> In addition, the control VQ is currently used for inline encryption. From the virtio
>>>> specification perspective, should we state that it is currently used only for inline
>>>> encryption, or leave room for future extensions?
>>>
>>
> 

