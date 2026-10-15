Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0052440652
	for <virtio-dev@lists.linux.dev>; Thu, 15 Oct 2026 11:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792063176; cv=none; b=N2Iy3PF7tjgbCjDtAvmdHm48K42HsWkP4FF12hr/2zCKjk3gXkyzU6n131CZI7vY95WbX4MPS8E/D3mIARX+HVSXH+P4vGZMWIdykjzpATdZVCmWZVpc1iJsOgcU87Km2I+AcBqckFJnFCRTDvEnCabVKe8lE+jMTIJcl2EbDvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792063176; c=relaxed/simple;
	bh=kPgjDza2ny0P61fL0EhaaWywhbfDKSKnCOxy2GC2dpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hPQDWnlwZROarPmLNdutXCqgNRn7cgYb6pp7j6gvRm8VohjxbAQ/wqxvb102dj8PW+T5cNmy1TmzoByqYi19NnfYvVygUETLTUBGjezkxLi2/weiVvoZJK1geIVtqCGHdGchI2+K5VONKgn7UEncviY8UE1LhYUMBDRYWHaiSLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UjZw6hXt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BMVhtdqY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UjZw6hXt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BMVhtdqY"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9jONS2114148
	for <virtio-dev@lists.linux.dev>; Thu, 15 Oct 2026 11:19:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0cDY3dkV+hPDzsJV79LDfReNGb0PpLtm95pbkP0FpfY=; b=UjZw6hXtCTwcnqNE
	cLep5o3XY7LdIDT35hzPx+fWXF1RJHn1EHw3hPC6CEz1qZMl0wxCaBGy/K6fAJsm
	4L7DjMyLhOITgyIq/Bk3zAqb7+xLoVCGgzEnkObRtFiByX8pOTInjjvHvpcxEcIf
	uL0hqmC3C4sDwwAi2BzQ6gMnru0+bwluXHjFz6ISZ/u9oRMZnIBR+kWmbGc3PCq4
	LvyxFE68RKGOhM/azOfZhS9anEt/+R1VATMOsDZQzPWFEaCqqCL6LrVNhfA/H+ss
	cx1nS3CYOuZXXfwKxMivDZO3BlVpqICHoSB7Q6eJsuIeKVnEg/TFWO76YDJDQXfo
	Wqye3g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hajmyarxb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Thu, 15 Oct 2026 11:19:33 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3abfcf726dcso2030655a91.2
        for <virtio-dev@lists.linux.dev>; Thu, 15 Oct 2026 04:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792063173; x=1792667973; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0cDY3dkV+hPDzsJV79LDfReNGb0PpLtm95pbkP0FpfY=;
        b=BMVhtdqYT9SQOjEMuYccJAA845OpIQydAkCj8yEMykazb3jgWHiqnsvFO6rQrrQU18
         WkmAVUgn5gJX27ohPn5H8lWZGuKLorK5I6C1gzS/d3+JLDlGaANQ5xDFSha5NCSkAP5N
         6zcUuUzkes8ICf7dMgDyz7X2OOSr09j3Fz/sHaiVj2cuWUB0RP6w7FWr1UWEXU46K417
         DwWCO1FdL9jgIAAXRVOUPkU7bF8dYvZha7vfVbhlTh8HLLBLMplaMCwQwVqecFtnkREp
         rXfzwSXW0EKgEoU9X7+t9k8uFvndSON/Grsw2WyRmVdY9I6BI8N/eBGNEZUISlH4yAMu
         M83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792063173; x=1792667973;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0cDY3dkV+hPDzsJV79LDfReNGb0PpLtm95pbkP0FpfY=;
        b=b6/InXptIQgmiRF7qvmxySC9ceQ/IpLxTG+btGmkmLH9aWAQvd1cEZGaxpjjLjKwbd
         6i7UVe4ubW2UmZDHzCJ/5MudLJ9k8MspyeGXdLze7gi6fvzmKdtPik2LOr+gvUU/DeLR
         dkhPFa9cW9mTyVAO+eEYMO5oLkWxKREYHMXJ3EveHvSlc22MjFs8SeHfibdhmSF1QwJt
         1iyRUStYoN8ZDY63zQWQ0bMPZMmuRNM28FswLjAYbcmMymKjOr2pg6MniqvbVox6TmxJ
         AWMOs32YLDE9E5SqTc+TavX2pLuhRO3gI6yp+jaBjyvDdAbuyRMAIcqiYZZuZoIz+ETg
         AydQ==
X-Forwarded-Encrypted: i=1; AKwUvByziitpmCvbzkfXFy3HwmsjzAA+IESIKDzODH3m6i3Wvtam6McVtzEzfmAgdUQWy8pjZhlu/AsxQvxU@lists.linux.dev
X-Gm-Message-State: AFq9FYKhrOJa1RuxtuD/OXxKcIF1X4Le7Qx0q58pWCcnlau8ak/kk3xd
	U0LznlH3td7cNjeqHOboKwuJR3GVNf3SgpG5g17skozMqm9fGjW6n/RFYClbQwgI8uM7cf+UWdS
	9Clpv+wsZBW6eRAIhEv1aijKJAMI80UtTBTZae7MCsuxKykfElRxQiScn30CzYLOT
X-Gm-Gg: AYBFou18l2p7Z9vYC3fWWIOBOg9f95bC7a94xex4SeRORkD5vryOXxZLC/ocJKgmosd
	IR7UXYbXKmebXK7Ak5pc+NZ0XMYnIm0EDBHrOjVNFTa9VyRzhrCWNofKLdiy9O13YvQNIAsexGx
	kRZQwlNloKZxt7gdJzAKalSq4y7sl7rIAOfYLPHXpZ+QqVYKY+qtq9+uZiBwWwbYkRZ69KnfULL
	uP9iB0i37hCb0ggt4iwXVhLBSX6APyaECQm0cjB3XGqjb1CYNkscfNvpCjiHQPmu13W8R4Mm8+x
	f7li40Qg3Kq2VXGH6/dawMWGgQLa1AlztY8TIjbcf8JNEqswSey1exJYHbN5EJFVs3Lrby/kSqH
	CyakNOwmgX6GKrkaEj5hnQScww/Eo+LXvubfCZWBkK3V+WPxZk1HLdNY0
X-Received: by 2002:a17:90b:5106:b0:3ac:9c37:9426 with SMTP id 98e67ed59e1d1-3ac9c379a27mr1753053a91.31.1792063172995;
        Thu, 15 Oct 2026 04:19:32 -0700 (PDT)
X-Received: by 2002:a17:90b:5106:b0:3ac:9c37:9426 with SMTP id 98e67ed59e1d1-3ac9c379a27mr1753026a91.31.1792063172454;
        Thu, 15 Oct 2026 04:19:32 -0700 (PDT)
Received: from [10.110.42.127] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422e4eb2sm81337455ad.74.2026.10.15.04.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 04:19:32 -0700 (PDT)
Message-ID: <01f3caa9-a1c3-4511-a104-7179ce1791f8@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 19:19:28 +0800
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
 <426abc9a-c7b4-4631-a5fe-3b2bba1d0414@oss.qualcomm.com>
 <4ed90e46-0dc9-40ba-b8a9-800d40b34ef9@nvidia.com>
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <4ed90e46-0dc9-40ba-b8a9-800d40b34ef9@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: DAGDx_CnxJppgbw1NPYHzwpUz0czBgH5
X-Proofpoint-ORIG-GUID: DAGDx_CnxJppgbw1NPYHzwpUz0czBgH5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA0NCBTYWx0ZWRfX0BIqU9hM6MdJ
 28o6OU/xTvRVK/JP8KTDInv9Uw2e5wg/PE7W1XICZilSWzwTnF5rSa3eqLez7/udOlXE5nG940n
 0QPbyM77x1+HKKsSMko4D+xdkKFUOeg=
X-Authority-Analysis: v=2.4 cv=TbQDJhQh c=1 sm=1 tr=0 ts=6ad0b6c5 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Xlf491cTACcvATEJsQUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA0NCBTYWx0ZWRfX8XhIxIXPO3ED
 oDwKIJExCrXnRE7KoHW5guPyYV6QKXV5pJCCI0GlJAONykHfn98WePXbZYDbPh7cliMU5DBXIHq
 m3uImZGQ59oCWre1ghMrtwPBO6kVYguAGfNj/31Dbh13iidyFyZFcxtqZE/YQTxP/lLrFvU1h/T
 98GXZtC85+6+MeDWOVir32Eu8X244PJfx/m5J6lfe4NPkIbbjoqhgPDbPX0pn5vaSvK3T59x05d
 Gg4GUndBE2czgeh/QPfai20xLQx93MW9QxMe78R1No1BdNZDkkFLhYZ3XHgQon/4OA8WKWzYCt/
 Uozgp+1AAAm4A0sIZv/ZjoxC9jCE7JjXTHRMdFPK+lAwSMWssaqhABEvNqCtz4ylD2bxYCYiRrP
 HIY/4vTodYalgWM99clPRYFznq0rDRnDfKrVnwrEwwuFrPxPJZ67CMdILgDzE4fxmS2BaNssfSJ
 lnPvwCFcfc0FMO6KKJQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150044



On 10/14/2026 2:07 AM, Max Gurtovoy wrote:
> 
> On 13/10/2026 19:23, Linlin Zhang wrote:
>>
>> On 10/13/2026 7:12 AM, Max Gurtovoy wrote:
>>> On 08/10/2026 13:15, Michael S. Tsirkin wrote:
>>>> On Thu, Oct 08, 2026 at 05:17:30PM +0800, Linlin Zhang wrote:
>>>>> On 9/30/2026 6:46 AM, Max Gurtovoy wrote:
>>>>>> On 24/09/2026 12:35, Linlin Zhang wrote:
>>>>>>> On 9/22/2026 9:14 PM, Stefan Hajnoczi wrote:
>>>>>>>> On Tue, Sep 22, 2026 at 12:29:37PM +0800, Linlin Zhang wrote:
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
>>>>>>>>>>>     - Add a control virtqueue
>>>>>>>>>>>     - Move key program/evict/derive_sw_secret/generate/prepare/import to
>>>>>>>>>>>       the control virtqueue
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
>>>> Fundamentally, it does not make sense to force all vqs to be admin VQs.
>>>>
>>>> Admin vq would make sense if there is complex resource management going
>>>> on - like what is happening with all the flow control things in the
>>>> network device, since they have extensive functionality for managing
>>>> device resources.
>>>>
>>>> Random device specific commands - I am not sure we want that.
>>>> It remains to be proven.
>>> Admin vq was added for mgmt/control/admin/non-DATA_IO operations.
>>>
>>> Fundamentally, it does not make sense to force random device to create new control VQ since we already defined admin VQs for this purpose.
>>>
>>> We could have introduced control VQ on each device type, but we didn't.
>> Thanks for your comment!
>>
>> My concern is that these inline encryption commands are tightly coupled
>> to a specific virtio-blk device rather than providing generic administrative
>> functionality.
> 
> We've all the needed plumbing in place in the AQ for device specific admin commands - see virtio-net specific admin commands.
> 
>>
>> GET_CRYPTO_MODES exposes capabilities of a particular block device, while
>> PROGRAM_KEY and EVICT_KEY operate on that device's keyslot manager. The
>> resulting virtual keyslots are then referenced directly by encryption requests
>> submitted on the same device's request VQs. The entire key lifecycle therefore
>> remains local to a single virtio-blk instance and its I/O path.
>>
>> My understanding is that Admin VQ was introduced primarily for device agnostic
>> commands. The GET_CRYPTO_MODES/PROGRAM_KEY/EVICT_KEY control commands appear to
>> be inherently virtio-blk-specific rather than a cross-device interface.
>>
>> There is also a transport consideration: VIRTIO_F_ADMIN_VQ is currently
>> unavailable for virtio-mmio, while the proposed control VQ approach remains
>> transport-independent.
> 
> This limitation was introduced because we didn't want to add more noise when AQ was added (it was already a big change).
> 
> Nothing really prevents adding AQ to mmio transport.
> 
>>
>> For these reasons, I currently believe a virtio-blk control VQ is the better
>> fit.
>>
>> I'm appreciated if you can give any feedback about it.
> 
> I think that the correct path is AQ.
> 
> Introducing another VQ type for the same purpose (mgmt cmds) seems weird and make device implementation harder.
> 
> It is much harder to implement a new VQ type than a new opcode in the existing AQ.
> 

Thanks for your comments!

I agree that reusing the existing AQ avoids introducing another VQ type in virtio-blk.

My concern is that AQ is currently not supported with virtio-mmio, and adding such
support appears to be significantly more involved than introducing a
virtio-blk-specific control VQ.

Given this constraint, Admin VQ support in virtio MMIO will impact the inline
encryption support on virtio block, so, I prefer to the virtio-blk-specific
control VQ as this requirement is a more widely and general request, especially
in the virtualization platform with a Android guest virtual machine.

> 
>>
>>>> But generally why does this go on a special VQ? Is there a reason?
>>> Also in other related protocols the key mgmt goes throw a NON-IO Queue..
>>>
>>>
>>>> You define distinct request types seemingly and we are not short on types?
>>>>

