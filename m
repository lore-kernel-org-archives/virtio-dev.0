Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AC833B6C4
	for <virtio-dev@lists.linux.dev>; Fri, 28 Aug 2026 13:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787922514; cv=none; b=KFjRx/ycygy4YXo2WBn6iE3jWrtDu61RtlyW5NsC+BaDLFhwI58gW4Tca3EgwhlMkhCIdwVAl0ZI+IBkWCV8LWRUnJC49oksgNrRRRl61crtBFkG6FIyec+mYgH5cg1PZXLbfx/2sdk79LCwHKtDx9xKF7SXtzea0SaUIcPdmfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787922514; c=relaxed/simple;
	bh=RvHk/ydrzlv1Pv3FYoYNcEQy1QgCzt5L+u7pvaA/E30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bNeX9bfBrnP4rglmkzVeGL3y3ZHj8ikhSiZcYVrhyQaP1vWdqQQi0JZimIhNlxbFVxSHWx4eet4ROsEQJjckGtoUo0AQHm2Xb+UFYZBF5PLG0E+oKQ3x2cA7FFCxmzfPNtytIBviINpFhHpmiMChKtsqUg35XbfJb3WzyJQ4d4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HRJhnnk4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N8r1exI6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HRJhnnk4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N8r1exI6"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SA8BvP3752279
	for <virtio-dev@lists.linux.dev>; Fri, 28 Aug 2026 13:08:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hTz3ao6VS0gN8cHD0GZnhO5WOewzLE7SVahlCN9FCO4=; b=HRJhnnk4VF7BboWV
	poJ/8fZmplmhjKhcXRf2GLW+VgHyhREFHt7jEXmDhTccp8P8f5bsWH1o7slI1GEg
	wIwx0fE4JLj4dIXa1c0PZokakhk0P2epvSbCGGQLLviGCVKhLUyuCEzsiLvK743h
	Kq8Ra9ZEZBypNzyTJZqGQYDlkdbQJUKP3jdOfFPs2j8AXIYrIG7/D7VBDYPKOs/x
	bZuuAGfgWB6KJG1hG68HcY69iy1/41h7zto8sPEcs/gn6YzE3xtms7npxi8hnpkg
	Xj8McAzIQV7sfQBixmu3WWabxP1HX0Ac3M02B0Pi7adgasSw9ajpnU/0NPAvnc9S
	2QuLbw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb8afgm06-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Fri, 28 Aug 2026 13:08:31 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84e1da97175so1221936b3a.0
        for <virtio-dev@lists.linux.dev>; Fri, 28 Aug 2026 06:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787922511; x=1788527311; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hTz3ao6VS0gN8cHD0GZnhO5WOewzLE7SVahlCN9FCO4=;
        b=N8r1exI6CGlc8Gz2Me62n4FXNp5MBeenGv43QNf/mRT0HORjhhMCtNz+p4x2p/gsmk
         gsIp60cEA6FHFVwB9QsC7RpQSUFtRAgKyw/UaiMwKC5ZKYcXFHRtuptsE4xO3vddiLQ9
         NIVTUSQiI6RsRuLU8mZHRxlsXYPLgrWkQwdfP1RCRChJ2U+e4+aqCRINEiDj9xg3fK8Y
         ITfBTHZ+SvlHIpmvZN/kUD6kc1eTS6J5ClUcJ2TWlS+GQMExOBRJYP5YUbNSTLZonXFV
         N6XEl9wwEIMJ9L68mMwGftc9P6uH1FQZFPxxPGDmM9HtsLCsSV1JAGiHxiVOyXU8eJSp
         1sPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787922511; x=1788527311;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hTz3ao6VS0gN8cHD0GZnhO5WOewzLE7SVahlCN9FCO4=;
        b=CyjVyZD2muU1JluhEWU+o7ysXAHscScO+dvTqbA2NwEFjOwpRsZkddltaNTh5Vra73
         9QAgWA7PjvU3OElN9+M+ukjGLHkqP9DFeKowZxNe+7adafLMwRwcY58qSnJunV9B/Z3q
         7fgDa7O3hKfV15BVWCUi4gwjLspCn3Mj2NWw+6oORvd0UlfYRSIcoO9C0rBub2/Cw6Rr
         lhuPU/XajNe/uwtnK16l/KxXmZW7KL66NuwwD02Jr1eL1j70v7Qh8k2RyPlQ2okO4zGJ
         FGwj37rgk+L4fHLH6LddnbtLnc49DmMnY5CGLcvkIqMK6eQJACh4hQIYnThOAkDwk/vg
         EFfQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp5/uhoxvNBBfkYpXCVjPq2iuySKoOOxu20BpURO2P/js0WSWHRJHrn9AcTNTjwkngCo5MPv1b11fSt@lists.linux.dev
X-Gm-Message-State: AFuF++my5bDA8hz8v7ZVZa4jDPWuhv9h8B55K4WkLhnsdj0lO4lzAS9m
	AYBrlTtZGLoushrbOCBKWmyUN6w7a8kLYBwgpkhvHaREYXNACCdGN2Ed4VKZf9OH0uZaPOnb6yd
	pg+0YbE4D1WJe9KkzWjMqP8hRhMyxlgS1bFW9Oupo2JDpzPe+SXdFK//AnMrhP7h8
X-Gm-Gg: AR+sD10ZUbqdBoyvhQt55ZeqeUUBq9f80smrq6GQVmk99I0lBrVyPAa4gtdCPbNsmVG
	YFVFICUKTt9zVk2HH9iqxJZ0RzDYxHev4MeBiwMdcfXqvDF3Z5PgqVXfhfw1FuQxppx0lGgpMgJ
	IZD/Apv+NrQYjZ6XzmKov4Y2Y22bgl4qdyl16WI/Rc7iUJGu03Acp988SyaFpwsYFqE/bI/Z9O0
	jf+2Q5NGpn9UDUIkiJlwMnLmrbEm4eOE7UzOVmdSFs18cpVInPpGvf9G/QRBxt3X3JOqFGytd2b
	ComZZslC5H0P/TNZfnjh38QcnTEYJa9kq99m2hbkbPgPYUeQ81ZKGabLE1f0auTl3i69ccWAwN1
	JXo52kGyakQiYjOKcS7NKSviZitX+iF3w6nKs8h6isZBf6nyJw+BG0v6BI9c=
X-Received: by 2002:a05:6a00:4210:b0:845:cf73:c1d8 with SMTP id d2e1a72fcca58-8562aeab0f7mr15082402b3a.14.1787922510872;
        Fri, 28 Aug 2026 06:08:30 -0700 (PDT)
X-Received: by 2002:a05:6a00:4210:b0:845:cf73:c1d8 with SMTP id d2e1a72fcca58-8562aeab0f7mr15082229b3a.14.1787922510226;
        Fri, 28 Aug 2026 06:08:30 -0700 (PDT)
Received: from [10.110.102.109] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8569f599b16sm528773b3a.10.2026.08.28.06.08.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2026 06:08:29 -0700 (PDT)
Message-ID: <3605b7f4-820e-4a1d-999b-edaf0dbaea41@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 21:08:26 +0800
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] virtio-blk: Add inline encryption support
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>, virtio-dev@lists.linux.dev,
        neeraj.soni@oss.qualcomm.com
References: <20260814142306.3934029-1-linlin.zhang@oss.qualcomm.com>
 <20260819043321.GB9971@sol>
 <97c80fa6-2e04-490a-8b38-c951d7c80486@oss.qualcomm.com>
 <20260819193555.GA470114@fedora>
 <5d1a54d2-9e84-4a85-9124-ac9cbff75fdf@oss.qualcomm.com>
 <20260825233409.GA282683@fedora>
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <20260825233409.GA282683@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: CiTer1pfXJQ9x8xbf7rlrUbR8y4AAGgB
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDExMyBTYWx0ZWRfX7OxRh3OTysO3
 7k7M5Qcr2YB4ImnK+l0PfxpYGrMVV8XW4AEFkSnv9CtMaGknMmo/+iSLV3iWwiPny3SIgGS2AAr
 3ChOPM99YuWr22hcuIElzZSAElaJvC0=
X-Authority-Analysis: v=2.4 cv=IPoyzAvG c=1 sm=1 tr=0 ts=6a91884f cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=U1rKe-ZvQVvvfetv43AA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDExMyBTYWx0ZWRfX01cKFeSRahqL
 gSpU+l5BpIk9ppK6CCwl1R2HzTueIIsiXgEaDD0QvFjwTdyKpgQcYAM2pL8W8CWGvBVQ9RhIHdE
 othvU154zNxa+b9s4iHSP15zAy5YeKLuGgY50B6Y5OabY1NRNA3ecKfpH94cLXobevsxfE4NXAf
 8ZQf5ZcfT3i4hCcDOlgjEHoDcKTd43fJX4NDnfmmQd/oi7ne0zUHcWHKojq/C7uIZ3SyjGtrjTu
 HyQUfOCdHIT+M7YjfnUZ+wZTSe0O5LXjNRjs+SlxvkEmUFQbRRCq95KD5r2AOcfms+OcCRN3B4k
 ksLYCEult2lIjDY20K54tOmfJ46No+3ZdGXDz8hq0HqZdqspfrscfD93NOgvtk64q9AaL3epE45
 t82HAsdUrC5dR+NaRok6xGPZMUkkN1FQTmNbvLIv4kbQieWH9rKTPO1edsGkw+Fm1lquB3/h3bK
 vopRt/b6WakrCOs/3rA==
X-Proofpoint-ORIG-GUID: CiTer1pfXJQ9x8xbf7rlrUbR8y4AAGgB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280113



On 8/26/2026 7:34 AM, Stefan Hajnoczi wrote:
> On Thu, Aug 20, 2026 at 10:37:47PM +0800, Linlin Zhang wrote:
>>
>>
>> On 8/20/2026 3:35 AM, Stefan Hajnoczi wrote:
>>> On Wed, Aug 19, 2026 at 07:30:15PM +0800, Linlin Zhang wrote:
>>>>
>>>>
>>>> On 8/19/2026 12:33 PM, Eric Biggers wrote:
>>>>> On Fri, Aug 14, 2026 at 07:23:01AM -0700, Linlin Zhang wrote:
>>>>>> When the feature is negotiated, the device reports inline encryption
>>>>>> characteristics through virtio_blk_enc_characteristics. Add
>>>>>> VIRTIO_BLK_T_GET_CRYPTO_MODES, VIRTIO_BLK_T_CRYPTO_IN, and
>>>>>> VIRTIO_BLK_T_CRYPTO_OUT so that the driver can discover supported
>>>>>> crypto modes and submit inline-encrypted I/O requests.
>>>>>
>>>>> How is the driver expected to program and evict keyslots?
>>>>
>>>> There are 2 new added drivers, one is virtio blk extension driver which is
>>>> generic, and the other is crypto virtualization driver which is vendor
>>>> specific.
>>>>
>>>> The virtio blk extension driver manages the initialization of blk-crypto-profile,
>>>> and implements the interfaces of blk_crypto_ll_ops.
>>>>
>>>> The crypto virtualization driver performs similar operation like the key handling
>>>> part in ufs-qcom and ice drivers. It forwards the key program/eviction request to
>>>> Trust Zone via SMC call.
>>>>
>>>> For QCOM, the whole flow of key program/eviction is like
>>>>   - block layer passes the request to virtio_blk extension driver via blk_crypto_ll_ops
>>>>   - virtio_blk extension -> crypto virtualization -> qcom_scm -> SCM -> HYP ->TZ
>>>
>>> Can you annotate this with "guest" and "host"? Here is my guess:
>>> - virtio_blk + extension driver: guest
>>> - crypto virtualization + qcom_scm + SCM: guest
>>> - HYP: host
>>> - TZ: host
>>>
>>> If this is correct, then it's unclear to me why a vendor-specific guest
>>> component is involved?
>>
>> Thanks for your comments!
>>
>> That 's correct basically.
>>
>> - Guest VM
>> - virtio-blk + virtio-blk crypto extension
>> - crypto virtualization driver + qcom_scm
>> - SCM interface
>>
>> - Secure World/Platform
>> - Hypervisor
>> - Trust Zone
>>
>> The primary purpose of introducing a vendor-specific guest component is to
>> enable the guest VM to handle key programming and eviction directly through
>> TrustZone, avoiding any dependency on the primary VM for these operations.
> 
> If I understand correctly, you are saying that the qcom_scm driver
> inside the guest (EL1) uses the SMC instruction to trap directly into
> the host's Secure World (EL3) without going through the hypervisor
> (EL2)?
> 

There are 2 kinds of hypervisors. Sorry that I only focused on the type-1
hypervisor previously.

For type-1 hypervisor, qcom_scm driver inside the guest (EL1) uses the
SMC instruction to trap into the hypervisor (EL2) first, and the hypervisor
transfers SMC call to the Secure World (EL3), totally bypass the primary VM.

For type-2 hypervisor, qcom_scm driver inside the guest (EL1) goes to the
host via HAB driver (which is in upstream progress), the host (EL2)
transfers SMC call to the Secure World (EL3).

> If the virtio-blk interface standardized blk_crypto_ll_ops requests,
> then virtqueue requests would instead be used instead of SMC
> instructions and the hypervisor's (EL2) device emulation would handle
> the key programming on behalf of the guest.
> 

Thanks for the point!

The hypervisor's (EL2) device emulation you mean is QEMU, right? 
I said QEMU in the following as the hypervisor's (EL2) device emulation.

If I understand correctly, the key programming flow you suggested is like
the following.

  GVM -> blk_crypto_ll_ops in virtio-blk
      -> virtqueue request
      -> the hypervisor's (EL2) device emulation (QEMU)
      -> key programming in Host module
      -> ICE

To support it, 
  1. need create a new control queue for the transmission of blk_crypto_ll_ops
     requests
  2. in the program key interface of blk_crypto_ll_ops, it has the key
     and the slot index the key provisioned to, Guest VM only knows the
     virtual slots, so the virt_slot need be transferred to the corresponding
     physical one in QEMU or the following flow before programming it to ICE
  3. QEMU is a userspace process, we need add new blk ioctls (like key
     generate/import/prepare ioctls added recently) to allow the
     userpsace client to program a key to ICE

The 3rd point is my main concern, if such ioctls (program/evict/derive_sw_secret)
can be added, especially that the program key ioctl which specifies the key to the exact
slot, and the evict key ioctl which allows the usespace client wipe the key
in a specific slot. I thought it's a high security concern.

Another concern is the broken of key isolation b/w VMs, except more VM exit
operations.

>> Because SCM firmware interfaces can differ across vendors, the design
>> introduces an intermediate crypto virtualization layer. This layer provides
>> a common abstraction for key management operations, while allowing each
>> vendor to implement the backend interfaces according to its specific SCM
>> firmware and security architecture.
> 
> Which layer is the "intermediate crypto virtualization layer" that you
> are describing? I don't see that in this spec proposal. Is it the
> existing blk_crypto_ll_ops struct in Linux?
> 

I mean the 'crypto virtualization driver', which is corresponding to the
crypto_virt.c in the kernel patch series.

See https://lore.kernel.org/all/20260827160806.1295313-3-linlin.zhang@oss.qualcomm.com/

>>> What is the advantage of shipping qcom_scm inside the guest versus
>>> defining a standard virtio-blk interface for blk_crypto_ll_ops that the
>>> hypervisor's virtio-blk device implements via TZ on the host?
>>
>> Keeping SCM in the guest preserves key isolation, minimizes virtio-blk
>> payloads, and avoids additional inter-VM communication.
>>
>> Key programming occurs after a request has entered the block request
>> queue. Performing it through a standard virtio-blk request would require
>> issuing key request in the same request before handling I/O path,
>> introducing dead lock concerns.
> 
> A separate key programming virtqueue can be used to avoid deadlock
> concerns. That way is is still possible to access the key programming
> interface when a request queue is full.
> 

Thanks.
I agree with you. A separate control virtqueue must be added for the
virtio-blk interface standardized blk_crypto_ll_ops requests.

>> In my opinion, passing the encryption key in each virtio-blk request is
>> also undesirable, as it exposes key material outside the guest, increases
>> request size, and adds VM transition overhead.
> 
> I'm not sure there is a significant security benefit since the device
> emulation code in the hypervisor already has access to the plaintext I/O
> buffers, can snoop guest memory, and can cause guest code execution
> (including accessing the qcom_scm driver inside the guest)?
> > Regarding the VM transition overhead, I think you are right unless blk
> crypto changes are made to allow a more efficient request submission
> scheme (like combining key programming with I/O requests if there is a
> bottleneck in the I/O path). However, it's not clear to me whether key
> programming is a performance bottleneck: hopefully key programming does
> not happen in the I/O path and only in the control path when opening a
> file or directory?
> 

Thanks for the clarification.

From the memory visibility perspective, I agree with you that the guest
keys are transparent for the host. From the key's ownership aspect, I
feel that the host programming the key on behalf of the guest leads to
the ownership change, I'm not sure if it's a security concern.

The key programming occurs when submitting BIO to the request in the I/O
path, which means pre read/write from the virito device triggers programing
key first(vm exit -> QEMU -> the host program key module -> TZ -> ICE ->
back to the guest), and then send IO request(vm exit -> QEMU -> the host
I/O path). Compared with the SMC call from GVM solution (implemented in
https://lore.kernel.org/linux-block/20260827160806.1295313-1-linlin.zhang@oss.qualcomm.com/T/#u),
the key programming via virtio involves one 1 more vm exit.

> My concern about the key programming interface being a vendor-specific
> interface beyond the scope of the VIRTIO spec is that I'm not sure if
> there will ever be any other users. In other words, should ICE actually
> go into the VIRTIO spec or is it a vendor-specific functionality?
> 

I have confidence that this is a generic requirement for the virtualization
platform. It's better to have it in the virtio SPEC.
And there is a new common virtio block ops added for the key programming.
This allows the vendor to implement the key program based on their platform.

See https://lore.kernel.org/all/20260827160806.1295313-3-linlin.zhang@oss.qualcomm.com/,
the vendor need implement the virtblk_crypto_variant_ops in 
https://lore.kernel.org/all/20260827160806.1295313-2-linlin.zhang@oss.qualcomm.com/#Z31include:linux:virtio_blk_crypto_ext.h

> The approach with a separate key programming interface seems very
> specific to UFS and Qualcomm's SCM. For example, is it possible to have
> multiple virtio-blk devices with their own ICEs (key spaces) or does
> this design assume there is only one virtio-blk device with ICE per
> guest because existing SoCs only support that?
> 

Yes. This design does allow multiple virtio-blk devices with inline
encryption supported. And per virtio-blk device has its own ICE. Though
only one ICE is assumed in above Linux patch set, a small change can
be made to support different virtio-blk devices with different ICEs,
and don't need update the virtio SPEC.

> It would be cleaner and more obvious from a spec perspective if the key
> programming interface was part of the VIRTIO spec. Then the spec would
> be self-contained and the vendor-specific part would only be in the
> device's implementation on the host without also requiring
> vendor-specific drivers inside the guest.
> 
> I took a look at the few blk_ll_crypto_ops drivers in the Linux kernel
> and they are more or less copy-pasted code that only exists because
> there is no standardized hardware interface. I think we should avoid
> propagating that into VIRTIO and instead just define a key programming
> virtqueue for the virtio-blk device once and for all.
> 

I agree with you that programming interfaces in virtio SPEC makes it more
clear for the one who implements it. Current design is a compromise of
the security concern and the virtio protocol. Implementing it need a
full understanding of the inline encryption feature bit in virtio SPEC
and the virtio blk code in the Linux kernel.(See the above link of
virtio_blk_crypto_ext.h)

Would you please go through the virtio blk inline encryption support
patch (https://lore.kernel.org/all/20260827160806.1295313-3-linlin.zhang@oss.qualcomm.com/)
and double confirm if this combination (virtio spec defines the data
flow for crypto IO, virtio_blk_crypto_ext defines the control flow
of crypto IO) can be accepted?

I'm appreciated your insights.

> Having said that, there is much I don't know about ICE, ARM
> virtualization, etc and I would like to hear your thoughts if you think
> I'm wrong.
> 
> Thanks,
> Stefan
> 
>>
>>>
>>> (We talked about this in the past, but I am still not familiar enough
>>> with the Qualcomm hypervisor architecture to understand.)
>>>
>>> Thanks,
>>> Stefan
>>

