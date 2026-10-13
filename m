Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7EA4F4755
	for <virtio-dev@lists.linux.dev>; Tue, 13 Oct 2026 16:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791908617; cv=none; b=eKadK3tgjIhH514N7EpqW4c9oB4MMbNbcHISlCfmDAViX54tY8/chcvTsDXtluXLv3ndkWLT//pFN5rWs8fksWecNyR7BiCokdiVDHT6Q6dYrDYDsxCspsZytVnULE07hcMJ6m8P87hI5dSEE01bKBY4qVWhj9nt7HjgYz5h704=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791908617; c=relaxed/simple;
	bh=GY4NEsmmbcVOlOkJJlLlnTwGKChGTI48y7vWc8S/IX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BctT9Y/WS8KriIYLLVnSicSw1+GTg2C4qOZ3xEZivPMvfOq7ZQ1BIH5dy1eq2qq81zImb+Ea2bwf0hE7WEm/qXlwEnaq3fEIy78yz3lIc4TZ+3H/Hwz2ytM2bOyEtBERU8LjKJAnMLyyIDH6/+PyB03kcaod/tHHjyBKsHX9wh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pVlBUAot; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KYY5GKMj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pVlBUAot";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KYY5GKMj"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DE3SYc442747
	for <virtio-dev@lists.linux.dev>; Tue, 13 Oct 2026 16:23:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	76GqUprVrAtik+GD8HURPizOYkzn8jEKFMKGO95bc68=; b=pVlBUAotF/u2IOWU
	7Mu7aWL3LM4QO48W/1OCcMCCfwNnzudY5nsEqrf3gWS6g7VewPZqZutP0ukIilrs
	4cHZcxA6oCRDeSbgRAT8xnhe8L0DYxQiwxXA4UG6S678O3OMx9olTsLZK0hUJNae
	oQFubNkzLy8nLnEUY29dX1f0C2ztwYS3/F0vOgHchJ7D3x68m0Y45WBtNysySD7D
	2ebOySi8kKhJq6+eijuCuO3qcgiujuWGILCYgur95CTeqwduXEwfMyFHsaLN7quh
	+EMW+L33X9jqFM6lFlmqxpPkxdlrJP1PLSnlPcinTaH1OG/jorpXob7bwcN1RpxP
	Sfd1sA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9n71gxw3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Tue, 13 Oct 2026 16:23:33 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3a6d30f66c9so4188229a91.0
        for <virtio-dev@lists.linux.dev>; Tue, 13 Oct 2026 09:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791908612; x=1792513412; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=76GqUprVrAtik+GD8HURPizOYkzn8jEKFMKGO95bc68=;
        b=KYY5GKMjNPDTRpoih/Emb3y1cy6g9mVnUeaw9he9zTzaGvhOqBUe+u6x1nKgchFhET
         W00utBf8gjqRXJF3Hl0pGnM5+i8a+L4M0YnBh9NdC13HDUF5Qo+55zpS6JBbhd6clhMp
         LbeSGYSRKMCFfD32SJzgDw+WIjYq/I0FcqoDAzD+GGOWOKK2QBMcYK45HzGYfHrPwvBE
         tHO4jy+6eiZlsI5YySV2+XdprAuKkn6aROzUtD5J3DzpmFEaW/6bg4Frh7chTciY5ptK
         QhsCaoF2y8lixDBjNOii7aKvORJLA2j03NOjT7QxHFx9k7r+RYV1QTZqKxmxHQBxP8BI
         pTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791908612; x=1792513412;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=76GqUprVrAtik+GD8HURPizOYkzn8jEKFMKGO95bc68=;
        b=GC4KUcy2NGfvdg6jc8mprpxcHe6EfU11Ag238fs9ygRhtD3Q14Dl8T1A0lhJbJPnJT
         Uv2PsQDbkoxHbVb+l6BEAXq63FGcVSq+udCJ7MM9RX53hINB1/mTOgNc4daTY/oeG38U
         gWFMias3H+ZmUGzcI3Cu8m5oGBaxxlFoDuJUCiQdRmHuMin2Xz9nhKbKQUaRgd92ezwy
         yaa9uCKnWr9IX4BvAHLJLJLGxt/Fx6sVlpAbZQ2lLsjfMz+L82XSre9eTO9S1vSgWCxc
         V/CjIDc8D8gleVn6L7SPG8J+27vOTSJm3uLOlxF2frUmB1BBrywP8PuUeawmNO5DuGw1
         dKPA==
X-Forwarded-Encrypted: i=1; AKwUvBycw61jTNOCaTL71yvIr4YuhFh9BFgtquaR1gfvwzaVBOjm8oOf9pMFwezdcQRyrfnEctvCKyh2cpJc@lists.linux.dev
X-Gm-Message-State: AFq9FYI3/M+PQ5pjnXgH3ZCUDqs1zmF/Gj98ldXni33vCYbHg1QTVUsl
	oH2RbenhqoAiIiLFM+XiXMc3T6q7VYKBhPhaszrzjpGZnLQ0nskuuUVNgAjUrl9Cl5NQPskr8bJ
	jFWzUDGj6CSMN/w6WzOiRrwSrmVIfVsxq7aYf2rSGQF8bMh6HxQPDg4fFp2Z5pM8Z
X-Gm-Gg: AYBFou2jtwNqZwg3ueNY/1c0Y+gTRVodOXOMbaIJabdDSs3h2DEh0Qv3Ikp5WmjVji2
	bs4gFvm0dp7j85Q5AV4LV24eSQqe6Wu6Ri2IJaHi8TiLwqoAdEem1/oB6v8NfHR12WV896FkXiV
	cGQ1ECVM2Utjw51ACu216DHEavCr1BHumnLwTdDmo41zbXOY5dP7imv5TaR8rSpuHnFyeYYj+Dg
	YALQG5bdtlaYjM23oEjswpUiNquWhuZ90Z4IspoRFIBZJOAfVBrpUnjWEO21dvIScfLBIT4bzHO
	AytLPFM73fk63MgSM/rBAt+hGWhkAF3NRzh+BFAqSFztCYeS4MnteKC9hPqLAe2418WHF5i8z77
	Vf+9yffupHFK2XbNh6wNMXWlLuhjq5c5G/B/0BjyZtigK6nPgmGFe0kw=
X-Received: by 2002:a17:90b:3c07:b0:3a7:3474:b1fe with SMTP id 98e67ed59e1d1-3ab36959154mr9082960a91.4.1791908612202;
        Tue, 13 Oct 2026 09:23:32 -0700 (PDT)
X-Received: by 2002:a17:90b:3c07:b0:3a7:3474:b1fe with SMTP id 98e67ed59e1d1-3ab36959154mr9082942a91.4.1791908611474;
        Tue, 13 Oct 2026 09:23:31 -0700 (PDT)
Received: from [10.110.71.97] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3d9e21db1sm6091382a12.16.2026.10.13.09.23.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 09:23:31 -0700 (PDT)
Message-ID: <426abc9a-c7b4-4631-a5fe-3b2bba1d0414@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 00:23:27 +0800
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] virtio-blk: Add inline encryption support
To: Max Gurtovoy <mgurtovoy@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.linux.dev,
        ebiggers@kernel.org, neeraj.soni@oss.qualcomm.com, parav@nvidia.com
References: <20260913161628.368484-1-linlin.zhang@oss.qualcomm.com>
 <20260917210841.GD331587@fedora>
 <2f9affb3-0d1b-4469-9a66-ba052d2d1b6a@oss.qualcomm.com>
 <20260922131442.GB18339@fedora>
 <3a933df3-dff7-4ef3-a120-4c6e22c1fcc1@oss.qualcomm.com>
 <de535820-591b-40f2-b840-d987c3253765@nvidia.com>
 <9515779b-a6da-407f-99f2-011e51683d15@oss.qualcomm.com>
 <20261008060644-mutt-send-email-mst@kernel.org>
 <d503aee0-9920-4c0b-b9a0-c08e505cc3ea@nvidia.com>
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <d503aee0-9920-4c0b-b9a0-c08e505cc3ea@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FuqQbGrq c=1 sm=1 tr=0 ts=6ace5b05 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ufFWXl8YOzUVFAA0NMYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: 5s5XAEiUYfjR2fxMpI46rw7Z9i8AxgUX
X-Proofpoint-ORIG-GUID: 5s5XAEiUYfjR2fxMpI46rw7Z9i8AxgUX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA2NSBTYWx0ZWRfXx+Yg7fB91jFK
 U2chr44rY18k0gpPNHunTGZuycyxsiZxTuUt5ViOpiuahq1NJh/uRcv6jlYSkYWjYRdwEKKZmi4
 dbNfRThwMyAiLQxfhXzvk2WbFpO2kaUPhCL4fyCGtPV3qGx1p3dIopvZK/Tc6iUTp0H560yh5YF
 kISCRYout3ihyhWMxyxvYe1JnrDPZkAcG87SQN1ZhiZ17iM73nejy+iOGFyio9f05sr9zdIGP4Y
 8zid7puEl1dxeiRYR2Btom/nACW5tky+l6kUZV3nMqRUp9RWFSyX7ULT9n/Z8powA/s2WhHyRwt
 dxgFj7o6ylybK4sZM8Jsdz3Djq5ZryayZi8usdl/XsPyJAMEqm+AyJWCN4yBLkSPE+RZbce5azG
 aqfeNSOipBBVKp2VkzdKqRC8YodNhWJHG47i21k8BLOgRqs09k/W596d5Fo4nUA0CTAW3qmXP1H
 sEL8S95hh3jGcHxAJzQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA2NSBTYWx0ZWRfX3Fwxty8+ca7S
 ECUNcgS/xgx9JbgpR3zTaVoUa7jV+Yn1D2lHseeuJT1hSQO8owbnTE2nBm0eMRXJNDXbiMHPmpH
 PuYdeimftj5Qn4Q8lrrEab3rscFLAqw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130065



On 10/13/2026 7:12 AM, Max Gurtovoy wrote:
> 
> On 08/10/2026 13:15, Michael S. Tsirkin wrote:
>> On Thu, Oct 08, 2026 at 05:17:30PM +0800, Linlin Zhang wrote:
>>>
>>> On 9/30/2026 6:46 AM, Max Gurtovoy wrote:
>>>> On 24/09/2026 12:35, Linlin Zhang wrote:
>>>>> On 9/22/2026 9:14 PM, Stefan Hajnoczi wrote:
>>>>>> On Tue, Sep 22, 2026 at 12:29:37PM +0800, Linlin Zhang wrote:
>>>>>>> On 9/18/2026 5:08 AM, Stefan Hajnoczi wrote:
>>>>>>>> On Sun, Sep 13, 2026 at 09:16:13AM -0700, Linlin Zhang wrote:
>>>>>>>>> From: linlzhan <linlin.zhang@oss.qualcomm.com>
>>>>>>>>>
>>>>>>>>> This series adds virtio-blk inline encryption support for devices backed
>>>>>>>>> by storage hardware with an inline crypto engine.
>>>>>>>>>
>>>>>>>>> The protocol exposes device capabilities such as keyslot count, maximum
>>>>>>>>> DUN size, and supported key types. Encrypted requests identify a
>>>>>>>>> provisioned keyslot and carry a 256-bit DUN. Key management and crypto
>>>>>>>>> capability discovery use the block device control virtqueue.
>>>>>>>>>
>>>>>>>>> The control virtqueue is defined as a generic framework so that its
>>>>>>>>> buffer layout and queue placement are independent of any particular
>>>>>>>>> control command. Inline encryption then builds on this framework with
>>>>>>>>> explicit crypto command formats, capability validation, and keyslot
>>>>>>>>> state semantics.
>>>>>>>>>
>>>>>>>>> All key related operatios are handled in the control virtqueue, and
>>>>>>>>> the crypto I/O request is handled in the request queue.
>>>>>>>>>
>>>>>>>>> For background on inline encryption in UFS and eMMC storage, see:
>>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/block/inline-encryption.rst
>>>>>>>>>
>>>>>>>>> changes in v3:
>>>>>>>>>    - Add a control virtqueue
>>>>>>>>>    - Move key program/evict/derive_sw_secret/generate/prepare/import to
>>>>>>>>>      the control virtqueue
>>>>>>>> Thank you. This was a big change, especially if you already have an
>>>>>>>> implementation. I appreciate it!
>>>>>>>>
>>>>>>>> My main feedback is that the new control virtqueue commands are not yet
>>>>>>>> documented in enough detail so that implementors could implement them.
>>>>>>>> Once you've decided on the precise semantics, error codes, etc and added
>>>>>>>> them to the spec, then this will round off the inline encryption
>>>>>>>> feature. I look forward to reviewing that in the future.
>>>>>>>>
>>>>>>> Thanks a lot for your comment!
>>>>>>>
>>>>>>> Would you please help clarify what the precise semantics are about? detail
>>>>>>> introduction of the filed in the inline encryption control command struct?
>>>>>>> like struct virtio_blk_crypto_key_desc?
>>>>>> By precise semantics, I mean specifying not just the constants and
>>>>>> structs, but documenting what each command does and how it can fail.
>>>>>> Each of the key slot programming commands needs this. There should be at
>>>>>> least one paragraph for each of VIRTIO_BLK_T_CRYPTO_KEYSLOT_PROGRAM,
>>>>>> VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT, VIRTIO_BLK_T_CRYPTO_DERIVE_SW_SECRET,
>>>>>> VIRTIO_BLK_T_CRYPTO_GENERATE_KEY, VIRTIO_BLK_T_CRYPTO_IMPORT_KEY, or
>>>>>> VIRTIO_BLK_T_CRYPTO_PREPARE_KEY.
>>>>>>
>>>>>> For example:
>>>>>>
>>>>>> The VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT command empties a key slot so that
>>>>>> key information is removed and the key slot cannot be used until it is
>>>>>> programmed again. The key slot index is specified by struct
>>>>>> virtio_blk_crypto_key_desc \field{slot} and all other fields in the
>>>>>> struct are ignored. The command succeeds with VIRTIO_BLK_S_OK if the key
>>>>>> slot index is valid, including if the slot is already empty. If the key
>>>>>> slot index is invalid, the command fails with VIRTIO_BLK_S_IOERR.
>>>>>>
>>>>>> Stefan
>>>>> Thanks for the clear example.
>>>>>
>>>>> I'll follow the same approach and add explicit normative semantics for
>>>>> all inline encryption control requests.
>>>> Can you please explain why we need to introduce yet another VQ type for control?
>>>>
>>>> We've added the Admin VQ as a generic VQ for control operations — I'm not sure why it isn't sufficient.
>>>>
>>>> Adding control VQ to each device type seems strange to me after adding a generic Admin VQ.
>>> Thanks for your comment! And I agree that the Admin VQ should be considered before
>>> adding another device-specific control virtqueue.
>>>
>>> My understanding is that some of the inline encryption commands(get_crypto_modes/program key
>>> /derive_sw_secret/evict key) are runtime operations of a specific virtio-blk deivce.
>>> In particular, different virtio block devices may have different storage hardware sources
>>> of crypto modes, and keyslot programming and eviction are invoked through the block device's
>>> keyslot manager, and the programmed virtual keyslots are subsequently referenced by the
>>> encryption requests submitted on that device's request virtqueues. These commands are
>>> not about the management operation of device group.
>>>
>>> There is also a transport compatibility concern. The current virtio SPEC states that
>>> 'Devices and drivers utilizing Virtio Over MMIO do not support VIRTIO_F_ADMIN_VQ'.
>>> virtio MMIO is extensively used, so using the Admin VQ would make the feature unavailable
>>> for that transport unless the proposal also extended the MMIO transport.
>>>
>>> For these reasons, currently I believe that a virtio-blk control virtqueue is the better
>>> fit: it keeps the complete key lifecycle associated with the block device and remains
>>> usable across the transports required by the feature.
>>>
>>> I would appreciate any feedback or insights from you and Stefan on the V5 patch series
>>> posted for review before October ASAP.
>>>
>> Fundamentally, it does not make sense to force all vqs to be admin VQs.
>>
>> Admin vq would make sense if there is complex resource management going
>> on - like what is happening with all the flow control things in the
>> network device, since they have extensive functionality for managing
>> device resources.
>>
>> Random device specific commands - I am not sure we want that.
>> It remains to be proven.
> 
> Admin vq was added for mgmt/control/admin/non-DATA_IO operations.
> 
> Fundamentally, it does not make sense to force random device to create new control VQ since we already defined admin VQs for this purpose.
> 
> We could have introduced control VQ on each device type, but we didn't.

Thanks for your comment!

My concern is that these inline encryption commands are tightly coupled
to a specific virtio-blk device rather than providing generic administrative
functionality.

GET_CRYPTO_MODES exposes capabilities of a particular block device, while
PROGRAM_KEY and EVICT_KEY operate on that device's keyslot manager. The
resulting virtual keyslots are then referenced directly by encryption requests
submitted on the same device's request VQs. The entire key lifecycle therefore
remains local to a single virtio-blk instance and its I/O path.

My understanding is that Admin VQ was introduced primarily for device agnostic
commands. The GET_CRYPTO_MODES/PROGRAM_KEY/EVICT_KEY control commands appear to
be inherently virtio-blk-specific rather than a cross-device interface.

There is also a transport consideration: VIRTIO_F_ADMIN_VQ is currently
unavailable for virtio-mmio, while the proposed control VQ approach remains
transport-independent.

For these reasons, I currently believe a virtio-blk control VQ is the better
fit.

I'm appreciated if you can give any feedback about it.

> 
>>
>> But generally why does this go on a special VQ? Is there a reason?
> 
> Also in other related protocols the key mgmt goes throw a NON-IO Queue..
> 
> 
>>
>> You define distinct request types seemingly and we are not short on types?
>>

