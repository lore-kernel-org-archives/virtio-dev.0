Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88841ADC97
	for <virtio-dev@lists.linux.dev>; Wed, 25 Feb 2026 05:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771997642; cv=none; b=dnkmXAXBaJgUoZOXZMhOsSOKQOlsMrWNOpkl1SPXn8bBQLRg3Al62ptCz51x2+CVRPBW7saqmMm7YhnmWWe6BTgmFBp9k/hgUU3hsij1uiMoR5jt5a4DNCn23UksxDKgrDLK6BCHxmA2vyWVoHlbXEruZc3EQPdcYjP6MAHgDnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771997642; c=relaxed/simple;
	bh=Zs9BwyCN3F9tuOHyitHo/hCRmG/dLBUgS4SWgvL7QpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F/ahpX8xRZDTmJ9Es76A3/Npujl+uoBspRnUyHQN4qZqZmsO95xInNV7cLciolDqXd3J2FOv3oLRM0yINMg81fP/Vu3SdUK4VzxfRlbLEeBaFFWYYo2A7mOCHweEaSsnjRSj6X3UKSN7Ym4osybVJXwSHUew+Bb+kKQKJXLpcxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JfHNNUf4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hXHdyDos; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JfHNNUf4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hXHdyDos"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61P2HGbg583439
	for <virtio-dev@lists.linux.dev>; Wed, 25 Feb 2026 05:33:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oJsYq4UDl1XFmTM7gUdmLB+qk/Rl26q35mDPDl4naeg=; b=JfHNNUf49M1fuLMy
	Dx47LrWJ/NajyYnrQGyCwu+COLo5otGock+/U4o3Tq0MBBeL2lx6zsMsq2c+/AKb
	Q13KPRCqhVdUUWKi+xQKAvsr+WXUa7QHOPECQryD781P0auGb3KxwBXVO8lNQjz3
	30S+If9FSMZeHXKY7uy8pdAX99Qkf6nXFmGmspkCdK7QUpFYb77QftGcWr1FoV7w
	EYI70oEm0Cmskz5zCgrfyp0pxygnJCFfYuB/zaUbKsKHoEU2e1IKskE4PsXwDzs4
	Yu1f+PizS9ZVqGKm2/VsJSq7zilC2plS/JrFdxLPvZ69fr4/gEIrTnkfHwYlEb8C
	WLDBZg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4chg2gt16w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Wed, 25 Feb 2026 05:33:59 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso7888660eec.0
        for <virtio-dev@lists.linux.dev>; Tue, 24 Feb 2026 21:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771997638; x=1772602438; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oJsYq4UDl1XFmTM7gUdmLB+qk/Rl26q35mDPDl4naeg=;
        b=hXHdyDostUbqCOkAEedb4aJTMWpV84F2weu3Yx0KIjmwpTuw+yo2sY0v7hQSGQkjLP
         cWdBaXkSYDLaY5BN4GB64PaeHqWtFSh4z2Vn3OdtWStKVlYMZRCHHQecxqKUvMpLCjbm
         sVxkqgRFDew4Wzi+MeTtnD5I0YYkR5B+t7nbBkuSiCjajCkasL4yUFG9l6L4O5p83QYk
         KbSDHurRk2KjhdkAgsWXXN6SIva2lakQUc4bMDdo1/8qVVehng4nlIrvJ9kGilFMe07R
         8GgV+Po7JONmfEPjemRKjgSuSMJE/Zz/cbLkg1o4WByjtMS1p3b8A9GRwcSjU3YBom9E
         7DIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771997638; x=1772602438;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oJsYq4UDl1XFmTM7gUdmLB+qk/Rl26q35mDPDl4naeg=;
        b=UfiG8iU1TMzvG+j8wb0EPzmuOeDSkD/wUxaU4LEprb1czXNCwBtPSLiY6KNDgB9VHJ
         4oQgsLWctQlUQ4uLqwpwSRZwsedMSXx2tisoau0RooeQfr5Z2IlzbAdYT1GwUtwzrriJ
         U5C4ngA91PuAuRL1nIdYXharaE4pmGpvLDOW5+Dkwvp5ELywPq3kUXASnEZbptJTchO3
         F3CvA9HEx3+yhZgkg2gSw6VVogSuElmF3iaVkhQgNCHbNAuPu/eBFnhi1jlRzdjGC/UR
         n5PS1lq6g2cLahXxhJZm7XGFuu3xj1oUyh38DJlqBJ/S3WLt4HdOx9nQ4l4zEcn10cuZ
         A+xA==
X-Gm-Message-State: AOJu0YwGCPonOtv94g032bpwKzkvsfSv0OgXK7M6tVrTnPsNFDiRHY8G
	DE9WuXkFlwx1SRS3rnoBp3BWZ+J/tksHtNPhaSfzYNvfNCh+rnbgYJvEp90U9wOhCoppahTOu9m
	r7m48xuzlfI9WcDy93n6i6LzUHnsIkNjMiABy3Y/CHbK5oP/sMfPfMnCVRSq0cOJJ
X-Gm-Gg: ATEYQzxWrrle7XNrohbInRNap/gU3bP1ZAEeHzGbrCQmhifEgB0gjIou0tdn8SNjh/m
	v1EogPLrz8CKLOgart6QUQkbaSQDI+H0bebav+b1fWftYnxN2q4k/O6Hf0iIWh+uPdMGWn8EpO4
	qYL17mIjhbajPareIpomHk55HmNBSxph5aY7qQB6+thaMw2n6ncvxv0wCHDzTrm8m6GkMCIiEqi
	lfh+nI+9EAGd6PVCsSgGktpKp2hmqmDpFL+wWQHGZfRZLhGmko2z/fK8ApODZqsG/0tEohJEuXo
	ngFCVNQJ2oFv4/cywg9T17AJy8MaSl+6Dk2jcZlgDWjddWM+FVDzlvXBtrixT/0vcOT6tBogKaE
	ZXw2z+luSZyx9eGUs5MfeaqmPAQLnsgxUxFWkhyK5okJZHUJfMsg2JgUfPc23ZpKW36/zOLr3ve
	+xgOTQ
X-Received: by 2002:a05:693c:25c7:b0:2ba:6978:2b4 with SMTP id 5a478bee46e88-2bd7bd240c3mr6458084eec.20.1771997637840;
        Tue, 24 Feb 2026 21:33:57 -0800 (PST)
X-Received: by 2002:a05:693c:25c7:b0:2ba:6978:2b4 with SMTP id 5a478bee46e88-2bd7bd240c3mr6458071eec.20.1771997636914;
        Tue, 24 Feb 2026 21:33:56 -0800 (PST)
Received: from [10.110.100.120] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7dc167d3sm9255103eec.24.2026.02.24.21.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 21:33:56 -0800 (PST)
Message-ID: <bca448cf-6c18-4c82-806d-f2a25579a02b@oss.qualcomm.com>
Date: Wed, 25 Feb 2026 13:33:17 +0800
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] virtio-blk: Add inline encryption support
To: Stefan Hajnoczi <stefanha@redhat.com>,
        Sebastian Mauritsson <sma@napatech.com>
Cc: virtio-dev@lists.linux.dev, quic_dshaikhu@quicinc.com
References: <20260210083208.472824-1-linlin.zhang@oss.qualcomm.com>
 <20260210083208.472824-2-linlin.zhang@oss.qualcomm.com>
 <20260210211842.GA158755@fedora>
 <fa458358-90c8-408c-a860-8bfdb11658bb@oss.qualcomm.com>
 <20260218215336.GD605390@fedora>
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <20260218215336.GD605390@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 9Ai16FWzkiTBeZKuNjs9cXgtL_J3AugB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDA1MSBTYWx0ZWRfX32k64X6TJX6Y
 Xd4RCUr6UbuzNPcQZFUVQsj2A6VE8+tlAVBWzaByHpAFmWypqCGmdcLMLNhX1Wf3ytN/BsG76KN
 RUYF3/W+b8GVEadD4yExKRS2qIgsLCSIYf299qsIS+fhjBthwYEYNcckyz7XHwCiLjtGvQG5vro
 l2DE2pCR+c2Bmup1A9+BqPbwrLPtwGoghmKzeGEz4FENNArtBiBzc1lfCtoxxORh4zeJ3OqvBRF
 yykhiHSQ14D4mwVVhhAwskOf/zdlmiEFjRTyUlvZbeeAwoUgO4+eIfV/jtrIAGQx9eByB151b6l
 b0JWEkBsxy6/Rg+dqFJ2x7UBSApBXX/L2E2VYZDZvQ+OaF2N+rjsYUJ7jo+Q+44MVQqpClP9LZx
 8GLPQ2cwMQXDrifFRIuqddXNFJkN7WiPaFSqyFM5eETXkRxoqUu/FkCfNN5g3DxpXhcdPfDBYb/
 0oNVNaKter8pa5B3aMg==
X-Authority-Analysis: v=2.4 cv=ftHRpV4f c=1 sm=1 tr=0 ts=699e89c7 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=20KFwNOVAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=wUO_C1X0co5a3evH6FQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 9Ai16FWzkiTBeZKuNjs9cXgtL_J3AugB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015 spamscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602250051



On 2/19/2026 5:53 AM, Stefan Hajnoczi wrote:
> On Sat, Feb 14, 2026 at 03:22:21PM +0800, Linlin Zhang wrote:
>>
>>
>> On 2/11/2026 5:18 AM, Stefan Hajnoczi wrote:
>>> On Tue, Feb 10, 2026 at 12:32:08AM -0800, Linlin Zhang wrote:
>>>> Inline encryption on virtio block can only be supported when
>>>> the new feature bit VIRTIO_BLK_F_ICE is negotiated.
>>>>
>>>> Extend struct virtio_blk_config and struct virtio_blk_req,
>>>> so that crypto capabilities can be got in the frontend and
>>>> encryption metadata can be sent to the backend, together with
>>>> each I/O transaction.
>>>>
>>>> About the inline encryption on UFS or eMMC storage, please
>>>> refer to the Linux inline encryption documentation:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/block/inline-encryption.rst
>>>>
>>>> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/238
>>>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>>>> Signed-off-by: linlzhan <quic_linlzhan@quicinc.com>
>>>> Signed-off-by: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
>>>> ---
>>>>  device-types/blk/description.tex | 110 ++++++++++++++++++++++++++++++-
>>>>  1 file changed, 108 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/device-types/blk/description.tex b/device-types/blk/description.tex
>>>> index 2712ada..60f46af 100644
>>>> --- a/device-types/blk/description.tex
>>>> +++ b/device-types/blk/description.tex
>>>> @@ -66,6 +66,11 @@ \subsection{Feature bits}\label{sec:Device Types / Block Device / Feature bits}
>>>>  	(ZNS). For brevity, these standard documents are referred as "ZBD standards"
>>>>  	from this point on in the text.
>>>>  
>>>> +\item[VIRTIO_BLK_F_ICE(22)] Inline Crypto Extensions are supported. Only when this
>>>> +     feature bit is negotiated, the device need expose crypto characteristics in
>>>> +     configuration space and the driver need provide an extended request header
>>>> +     containing a crypto payload for block I/O.
>>>
>>> Most of the feature bit descriptions are brief and the details are
>>> covered later in the spec. I suggest doing this here too:
>>>
>>>   \item[VIRTIO_BLK_F_ICE (22)] Device supports Inline Crypto Engine functionality.
>>>
>>> I changed the name from Inline Crypto Extensions to Inline Crypto Engine
>>> because that terminology is used in the Linux kernel. Web search results
>>> also favor "inline crypto engine" over "inline crypto extensions". Are
>>> you okay with "engine"?
>> Thanks! ACK
>>
>>>
>>>> +
>>>>  \end{description}
>>>>  
>>>>  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Block Device / Feature bits / Legacy Interface: Feature bits}
>>>> @@ -128,6 +133,10 @@ \subsection{Device configuration layout}\label{sec:Device Types / Block Device /
>>>>                  u8 model;
>>>>                  u8 unused2[3];
>>>>          } zoned;
>>>> +        struct virtio_blk_crypto_characteristics {
>>>> +                __virtio16 slot_info;
>>>> +                __virtio16 reserved;
>>>> +        } crypto;
>>>>  };
>>>>  \end{lstlisting}
>>>>  
>>>> @@ -215,6 +224,18 @@ \subsection{Device configuration layout}\label{sec:Device Types / Block Device /
>>>>  terminated by the device with a "zone resources exceeded" error as defined for
>>>>  specific commands later.
>>>>  
>>>> +If the VIRTIO_BLK_F_ICE feature is negotiated, then in
>>>> +\field{virtio_blk_crypto_characteristics},
>>>> +\begin{itemize}
>>>> +\item \field{slot_info} value packs two 8-bits values to reduce the number of
>>>
>>> 8-bits -> 8-bit
>>
>> ACK
>>
>>>
>>>> +    Configuration Space reads.
>>>> +    \begin{itemize}
>>>> +        \item Bits~\[15:8] (\emph{max\_slots}): the maximum number of supported
>>>> +            crypto key slots.
>>>> +        \item Bits~\[7:0] (\emph{slot\_offset}): an offset applied to slot numbering.
>>>
>>> What is the purpose of slot_offset? This field is not used much in this
>>> spec, maybe it can be removed?
>>>
>>> Does that mean only slots in the range [slot_offset:max_slots) are
>>> available or does it mean that the range is
>>> [slot_offset:slot_offset+max_slots)?
>>
>> Only slots within the range [slot_offset, slot_offset + max_slots) are accessible to the
>> VM. The slot_offset specifies the base physical ICE slot allocated to the VM and is used
>> to translate a virtual slot index into a physical slot.
>>
>> Because the GVM programs and evicts keys directly—without host/PVM involvement—it must
>> supply the resolved physical slot when invoking key operations in TrustZone or the Secure
>> VM.
> 
> It's not clear to me how what you've described offers isolation between
> the PVM and the GVM. What stops the GVM from using key slots outside the
> range that has been assigned to it?
> 
> A few options for isolation come to mind:
> 
> 1. Expose 2 separate virtio-blk devices, one of which is hidden from the
>    GVM and only accessible to the PVM. The PVM can store its data on the
>    hidden device.
> 
> 2. Some kind of VIRTIO Admin queue Virtual Function approach where the
>    PVM can instantiate a virtual function (a sub-device) that the GVM is
>    allowed to access with isolation enforced by the device.
> 
> 3. A single device could be used but the GVM cannot access it directly
>    and needs to go through the PVM.

The slot isolation between GVM and PVM is implemented by the max slots allocated to the GVM and slot offset
the GVM's starting slot relative to the physical starting slot.

For instance, ICE hardware has 64 slots, the max slots allocated to the GVM is 32, and its slot offset is 20.
The keyslot manager in the GVM ensure the virtual slot rang is [0,31], when programming a key, translate the
virtual slot to a physical slot by using the slot offset, that means the physical slot range this GVM used
is [20,51].

The max_slots and slot_offset are configured by PVM, and GVM's virtio frontend only gets them from the configuration
space of its virtio devices. So PVM is responsible to ensure the physical slot range of the GVM is valid.

> 
>>
>>>
>>>> +    \end{itemize}
>>>> +\end{itemize}
>>>> +
>>>>  \subsubsection{Legacy Interface: Device configuration layout}\label{sec:Device Types / Block Device / Device configuration layout / Legacy Interface: Device configuration layout}
>>>>  When using the legacy interface, transitional devices and drivers
>>>>  MUST format the fields in struct virtio_blk_config
>>>> @@ -278,6 +299,10 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
>>>>      \field{zoned} can be read by the driver to determine the zone
>>>>      characteristics of the device. All \field{zoned} fields are read-only.
>>>>  
>>>> +\item If the VIRTIO_BLK_F_ICE feature is negotiated, the fields in
>>>> +    \field{crypto} can be read by the driver to determine the inline crypto
>>>> +    characteristics of the device. All \field{crypto} fields are read-only.
>>>> +
>>>>  \end{enumerate}
>>>>  
>>>>  \drivernormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
>>>> @@ -317,6 +342,9 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
>>>>      driver SHOULD ignore all other fields in \field{zoned}.
>>>>  \end{itemize}
>>>>  
>>>> +If the VIRTIO_BLK_F_ICE feature is negotiated, then the driver MUST validate
>>>> +    the max_slots in \field{slot_info} before the slot usage.
>>>
>>> I'm not sure how the driver is supposed to validate max_slots?
>>
>> It means the diver validate the virtual slot doesn't exceed the max_slots before translating
>> this virtual slot to a physical slot by using slot_offset. 
>>
>> Can I rewrite it as the following?
>>
>>   If the VIRTIO_BLK_F_ICE feature is negotiated, then the driver MUST validate that
>>   the virtual slot received from upper layer doesn't exceed the max_slots in
>>   \field{slot_info} before the slot usage.
> 
> The notion of an "upper layer" can be eliminated so that there is no
> assumption about the software design in the driver:
> 
>   If the VIRTIO_BLK_F_ICE feature is negotiated, then the driver MUST
>   ensure that slot_offset <= \field{payload.slot} < slot_offset +
>   max_slots, where slot_offset and max_slots are the values extracted
>   from \field{crypto.slot_info} in configuration space.

ACK. Thanks!

> 
>>
>>>
>>>> +
>>>>  \devicenormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
>>>>  
>>>>  Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it
>>>> @@ -402,6 +430,13 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
>>>>  \item the device MUST initialize padding bytes \field{unused2} to 0.
>>>>  \end{itemize}
>>>>  
>>>> +If the VIRTIO_BLK_F_ICE feature is negotiated, then the fields in \field{crypto}
>>>> +struct in the configuration space MUST be set by the device.
>>>> +\begin{itemize}
>>>> +\item the \field{slot_info} field of \field{crypto} MUST be set by the device to a
>>>> +    max_slots in the higher 8 bits and slot_offset in the lower 8 bits.
>>>> +\end{itemize}
>>>
>>> There is no need for the \begin{itemize} here. It contains no new
>>> information. The fields were already described in the configuration
>>> space section and the previous sentence already said that the fields in
>>> \field{crypto} must be set by the device.
>>
>> ACK, remove this \begin{itemize} here.
>>
>>>
>>>> +
>>>>  \subsubsection{Legacy Interface: Device Initialization}\label{sec:Device Types / Block Device / Device Initialization / Legacy Interface: Device Initialization}
>>>>  
>>>>  Because legacy devices do not have FEATURES_OK, transitional devices
>>>> @@ -436,6 +471,13 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>>>>          le32 type;
>>>>          le32 reserved;
>>>>          le64 sector;
>>>> +        struct virtio_blk_crypto_payload {
>>>> +            u8 slot;
>>>> +            u8 activate;
>>>> +            le16 reserved1;
>>>> +            le32 reserved2;
>>>> +            le64 data_unit_num;
>>>> +        } payload;
>>>
>>> "payload" is a generic term. crypto_payload would be clearer.
>>>
>>> I wonder whether consistently calling this feature "ice" rather than
>>> "crypto" would help in case self-encrypting drive or other cryptographic
>>> functionality is added to virtio-blk in the future. That way the spec
>>> items related to inline crypto engine functionality will be easy to
>>> differentiate from other crypto functionality.
>>
>> Ok, to differentiate ICE and other cryptographic functionality, can I modify it as
>>
>>   struct virtio_blk_ice_payload {
>>       u8 slot;
>>       u8 activate;
>>       le16 reserved1;
>>       le32 reserved2;
>>       le64 data_unit_num;
>>   } ice_payload;
> 
> Looks good to me, thanks.

Thanks!

> 
>>
>>>
>>>>          u8 data[];
>>>>          u8 status;
>>>>  };
>>>> @@ -445,8 +487,9 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>>>>  (VIRTIO_BLK_T_OUT), a discard (VIRTIO_BLK_T_DISCARD), a write zeroes
>>>>  (VIRTIO_BLK_T_WRITE_ZEROES), a flush (VIRTIO_BLK_T_FLUSH), a get device ID
>>>>  string command (VIRTIO_BLK_T_GET_ID), a secure erase
>>>> -(VIRTIO_BLK_T_SECURE_ERASE), or a get device lifetime command
>>>> -(VIRTIO_BLK_T_GET_LIFETIME).
>>>> +(VIRTIO_BLK_T_SECURE_ERASE), a get device lifetime command
>>>> +(VIRTIO_BLK_T_GET_LIFETIME), or a get device crypto capabilities command
>>>> +(VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES).
>>>>  
>>>>  \begin{lstlisting}
>>>>  #define VIRTIO_BLK_T_IN           0
>>>> @@ -457,12 +500,27 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>>>>  #define VIRTIO_BLK_T_DISCARD      11
>>>>  #define VIRTIO_BLK_T_WRITE_ZEROES 13
>>>>  #define VIRTIO_BLK_T_SECURE_ERASE   14
>>>> +#define VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES   27
>>>
>>> The Linux virtio_blk.c driver assumes that odd numbered constants have
>>> data buffers that are read by the device, so you may run into a bug when
>>> using 27.
>>>
>>> There is an informal convention to use even numbers for read requests
>>> and odd numbers for write requests. It doesn't hurt to try to follow the
>>> convention even though it's not strictly necessary.
>>>
>>> The Linux driver could be fixed when adding support for ICE, but 16 is
>>> available and it's safest to use that.
>>
>> OK. Agree to following the convention. But 16, 18,20,22,24,26 are already used by
>> zone device. Seems 12 is available. Correct it to 12.
>>
>>  #define VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES   12
> 
> In that case I suggest using 28. I don't remember what 12 was used for
> but there may be a historical reason for the gap.

Thanks! Change it to 28.

> 
>>
>>>
>>>>  \end{lstlisting}
>>>>  
>>>>  The \field{sector} number indicates the offset (multiplied by 512) where
>>>>  the read or write is to occur. This field is unused and set to 0 for
>>>>  commands other than read, write and some zone operations.
>>>>  
>>>> +The \field{payload} consists of the encryption information for current
>>>> +request. It is only present when the VIRTIO_BLK_F_ICE feature is negotiated and
>>>> +\field{type} is VIRTIO_BLK_T_IN, VIRTIO_BLK_T_OUT or VIRTIO_BLK_T_FLUSH.
>>>
>>> TODO think about layout
>>
>> rewrite to the following
>>
>>   The \field{ice_payload} consists of the encryption information for current
>>   request. When VIRTIO_BLK_F_ICE is negotiated, the request header layout becomes
>>   that struct virtio_blk_outhdr includes \field{ice_payload} as a fixed-size
>>   extension. For non-ICE requests (or types not using crypto), the driver MUST
>>   set \field{ice_payload} to 0 and device ignores them.
> 
> Sorry, the TODO was a comment to myself while writing my reply :).
> 
> I forgot to investigate. Basically the issue is that the spec must be
> clear on whether:
> 1. A field is absent and fields that follow it are present in the struct
>    layout when a condition is false (e.g. type is not VIRTIO_BLK_T_IN,
>    VIRTIO_BLK_T_OUT, or VIRTIO_BLK_T_FLUSH).
> or
> 2. A field is present but unused (zeroed) when a condition is false.
> 
> #2 is usually easier to implement in code because it avoids creating
> many different struct layouts at runtime depending on conditions like
> negotiated feature bits.
> 
> I was thinking that the ice fields should always be present but should
> be zero when the feature bit is not negotiated or some other condition
> (like the request type) is false. This way it will be much easier to add
> additional fields later without worrying about struct layouts.
> 
> This is how configuration space already works: the offset of the zoned
> field is not affected by whether the device advertises the
> VIRTIO_BLK_F_WRITE_ZEROES feature bit, it just means that the earlier
> write_zeroes_may_unmap field may be unused. This approach should
> probably be used everywhere and the spec language should be careful to
> communicate that the field is still present but zero when unused. It's
> okay for the driver to provide a shorter struct that doesn't include the
> last field(s) to the device when the feature bit is not negotiated
> though.

Thanks. Refer to the statement you shared, try to rewrite it as the following.

  The \field{ice_payload} consists of the encryption information for current
  request. It is not affected by whether the device advertises the
  VIRTIO_BLK_F_ICE feature bit, it just SHOULD be zero when the feature bit is
  not negotiated or the \field{type} is not VIRTIO_BLK_T_IN, VIRTIO_BLK_T_OUT
  or VIRTIO_BLK_T_FLUSH. 

> 
>>
>>>
>>>> +\begin{itemize}
>>>> +\item The \field{slot} field in \field{payload} indicates the ICE
>>>> +  (Inline Crypto Encryption) slot index where the key resides.
>>>> +
>>>> +\item The \field{activate} field in \field{payload} implies this is a
>>>> +  inline encryption request.
>>>> +
>>>> +\item The \field{data_unit_num} field in \field{payload} indicates the
>>>> +  starting block of the request.
>>>
>>> This is a block device, so the term "block" needs to be qualified to
>>> avoid confusion. I guess this is the cryptography concept of a block
>>> rather than the disk concept of a block. Please clarify this in the
>>> text, maybe by explaining that the ICE handles data in fixed-size "data
>>> units" instead of using the word "block".
>>>
>>> Also, can you explain the relationship between the data unit number and
>>> the sector? In simple cases I imagine the data unit number would be the
>>> sector. How is the driver supposed to pick or calculate the data unit
>>> number?
>>
>> The data unit number is the starting IV for AES crypto in ICE hardware, it's
>> a stable value for I/O request targeting to same storage range. It can be set
>> to the file logic block number or the starting sector of BIO. 
> 
> It sounds like the data unit number calculation is up to the driver
> (from the device's perspective) and the important thing is that the same
> data unit number will always be used when reading/writing the same
> logical data location.

Yes. Correct.

> 
>> The upper layer calculates it and passes it to virtio_blk driver in this patch.
>> ICE uses the data unit number and data unit size (the granularity to use for
>> en/decryption) to derive the next data unit number for the next cryptography
>> block. data unit number in ICE increase 1 per data unit size. For instance,
>>   data unit number = 2048
>>   data unit size = 1024 bytes
>> For the first 1024 bytes of the transaction, ICE hardware encrypt the data
>> with IV equal to 2048.
>> For the second 1024 bytes of the transaction, ICE hardware encrypt the data
>> with IV equal to (2048+1=)2049.
>>
>> Rewrite it as bellow.
>>
>>   \item The \field{data_unit_num} field in \field{ice_payload} indicates the
>>   starting IV. It can be the file logic block number or the starting sector
>>   of BIO.
> 
> BIO is a Linux-specific concept, so it would be best to avoid it in the
> VIRTIO spec.
> 
>   \item The \field{data_unit_num} field in \field{ice_payload} indicates
>   the starting IV. In order to successfully encrypt/decrypt data this
>   number must be the same for successive read and write operations to
>   the same logical data location. The driver typically sets it to the
>   file logical block number or the disk sector number.

Thanks! ACK.

> 
>>
>>>
>>>> +\end{itemize}
>>>> +
>>>>  VIRTIO_BLK_T_IN requests populate \field{data} with the contents of sectors
>>>>  read from the block device (in multiples of 512 bytes).  VIRTIO_BLK_T_OUT
>>>>  requests write the contents of \field{data} to the block device (in multiples
>>>> @@ -530,6 +588,47 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>>>>  The \field{device_lifetime_est_typ_b} refers to wear of MLC cells and is provided
>>>>  with the same semantics as \field{device_lifetime_est_typ_a}.
>>>>  
>>>> +VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES requests fetch the storage hardware crypto
>>>> +capabilities into \field{data}. And the \field{data} is of the form
>>>
>>> How does VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES behave when data[] is too
>>> small to fit all the device's crypto capabilities?
>>
>> Add a new field capability_num to the Configuration space header. The total size of
>> \field{data} shall be computed as:
>>   data_size=capability_num×capability_size
>> where capability_size is the size (in bytes) of one capability structure. Therefore, \field{data} contains exactly capability_num contiguous capability entries, each of length capability_size.
>> Add a capability_num field in Configuration space. So it use size per capability
>> multiply capability_num to define the size of \field{data}.
>>
>> Rewrite it as the following.
>>
>>   VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES requests fetch the storage hardware crypto
>>   capabilities into \field{data}. The crypto capabilities is a zero-padded array
>>   up to (\field{capability_num}×capability_size) bytes long, where capability_size
>>   is the size (in bytes) of one capability structure which is in form of
>>   
>>   \begin{lstlisting}
>>     struct virtio_blk_crypto_cap {
>>         u8 alg;
>>         u8 data_unit_size;
>>         u8 key_size;
>>         u8 reserved;
>>     };
>>   \end{lstlisting}
>>   
>>   \begin{itemize}
>>       \item The \field{alg} implies crypto algorithm identifiers.
>>       The device supports reporting and negotiating cryptographic algorithms
>>       using the following algorithm identifiers:
>>       \begin{lstlisting}
>>           CRYPTO_ALG_AES_XTS              = 0x0
>>           CRYPTO_ALG_BITLOCKER_AES_CBC    = 0x1
>>           CRYPTO_ALG_AES_ECB              = 0x2
>>           CRYPTO_ALG_ESSIV_AES_CBC        = 0x3
>>       \end{lstlisting}
>>       These identifiers abstract the underlying hardware crypto implementation
>>       and does not assume any operating‑system‑specific data structures or
>>       constants.
>>       \item The \field{data_unit_size} implies the mask of data unit size. When
>>       bit j in this field (j=7......0) is set, a data unit size of 512*2^j bytes
>>       is selected.
>>       \item The \field{key_size} is the crypto key size identifiers.
>>       \begin{lstlisting}
>>           CRYPTO_KEY_SIZE_INVALID     = 0x0
>>           CRYPTO_KEY_SIZE_128_BITS    = 0x1
>>           CRYPTO_KEY_SIZE_192_BITS    = 0x2
>>           CRYPTO_KEY_SIZE_256_BITS    = 0x3
>>           CRYPTO_KEY_SIZE_512_BITS    = 0x4
>>       \end{lstlisting}
>>       \item The \field{reserved} is unused.
>>   \end{itemize}
>>   
>>   If the \field{data} is too short, it sets status to BLK_S_IO_ERR.
> 
> Looks good. In the final sentence I suggest changing "it" to "the
> device" for clarity.

Thanks! Done.

> 
>>
>>>
>>>> +
>>>> +\begin{lstlisting}
>>>> +struct virtio_blk_crypto_caps {
>>>> +  u8 size;
>>>> +  le32 crypto_capabilities[];
>>>> +};
>>>> +\end{lstlisting}
>>>> +
>>>> +The \field{size} specifies the size of array \field{crypto_capabilities}.
>>>
>>> "number of elements" would be clearer than "size of array" because the
>>> unit (bytes vs array elements) is ambiguous.
>>>
>>> The size field is not necessary since Used Ring descriptors contain
>>> (struct virtq_used_elem in the spec) a len field indicating how many
>>> bytes were written by the device.
>>
>> Remove virtio_blk_crypto_caps in above modification.
>>
>>>
>>>> +The \field{crypto_capabilities} indicates the crypto capabilities supported by the
>>>> +hardware storage for inline encryption.
>>>> +
>>>> +A crypto capability packs four 8-bits values:
>>>> +\begin{itemize}
>>>> +    \item Bits~\[31:24]: crypto algorithm identifiers.
>>>> +    The device supports reporting and negotiating cryptographic algorithms
>>>> +    using the following algorithm identifiers:
>>>> +    \begin{lstlisting}
>>>> +        CRYPTO_ALG_AES_XTS              = 0x0
>>>> +        CRYPTO_ALG_BITLOCKER_AES_CBC    = 0x1
>>>> +        CRYPTO_ALG_AES_ECB              = 0x2
>>>> +        CRYPTO_ALG_ESSIV_AES_CBC        = 0x3
>>>> +    \end{lstlisting}
>>>> +    These identifiers abstract the underlying hardware crypto implementation
>>>> +    and does not assume any operating‑system‑specific data structures or
>>>> +    constants.
>>>> +    \item Bits~\[23:16]: mask of data unit size. When bit j in this field
>>>> +    (j=7......0) is set, a data unit size of 512*2^j bytes is selected.
>>>
>>> Is only one bit ever set in the mask? If so, then maybe just express j
>>> as an 8-bit unsigned integer (i.e. the exponent in 512*2^j) instead of
>>> as a bit mask. It's simpler and increases the range for j.
>>
>> Yes, it's encoded in one-hot encoding. If j is expressed as an 8-bit unsigned integer,
>> it will confused the reader that more than one bit can be set in the mask of data unit
>> size. right? 
> 
> If the field is called the data unit size exponent (data_unit_size_exp)
> then there is no confusion. I agree that calling it a mask would be
> confusing.

Thanks! Update it to data_unit_size_exp.

> 
>>
>>>
>>>> +    \item Bits~\[15:8]: crypto key size identifiers.
>>>> +    \begin{lstlisting}
>>>> +        CRYPTO_KEY_SIZE_INVALID     = 0x0
>>>> +        CRYPTO_KEY_SIZE_128_BITS    = 0x1
>>>> +        CRYPTO_KEY_SIZE_192_BITS    = 0x2
>>>> +        CRYPTO_KEY_SIZE_256_BITS    = 0x3
>>>> +        CRYPTO_KEY_SIZE_512_BITS    = 0x4
>>>> +    \end{lstlisting}
>>>> +    \item Bits~\[7:0]: unused.
>>>> +\end{itemize}
>>>
>>> A struct would be more natural here (the rest of the VIRTIO
>>> specification rarely packs fields into an integer):
>>>
>>>   struct virtio_blk_crypto_cap {
>>>       u8 alg;
>>>       u8 data_unit_size;
>>>       u8 key_size;
>>>       u8 reserved;
>>>   };
>>
>> ACK, see above rewrite statement.
>>
>>>
>>> By the way, Linux seems to call this a "profile" rather than a
>>> "capability". Do you want to use the same name as Linux for consistency?
>>
>> blk-crypto-profile is the keyslot manager which manage the usage of keyslot and
>> also checks if the key configuration set by upper layer can be supported by the
>> ICE hardware. While the capability aims to illustrate the capability provided by
>> the ICE hardware. What we expected is the capability used to initialized
>> blk-crypto-profile in Guest VM.
> 
> I see.
> 
>>
>>>
>>>> +
>>>>  The final \field{status} byte is written by the device: either
>>>>  VIRTIO_BLK_S_OK for success, VIRTIO_BLK_S_IOERR for device or driver
>>>>  error or VIRTIO_BLK_S_UNSUPP for a request unsupported by device:
>>>> @@ -912,6 +1011,13 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>>>>  successfully, failed, or were processed by the device at all if the request
>>>>  failed with VIRTIO_BLK_S_IOERR.
>>>>  
>>>> +The length of \field{data} MUST be a multiple of 4 bytes plus 1 for
>>>> +VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES requests.
>>>> +
>>>> +A driver MUST set \field{activate} to 1 for VIRTIO_BLK_T_IN,VIRTIO_BLK_T_OUT,
>>>> +    and VIRTIO_BLK_T_FLUSH requests that require inline encryption. For other
>>>> +    request types or when inline encryption is not required, it is set to 0.
>>>> +
>>>>  The following requirements only apply if the VIRTIO_BLK_F_ZONED feature is
>>>>  negotiated.
>>>
>>> How does the driver assign a specific capability (algorithm, data unit
>>> size, and key size tuple reported by
>>> VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES) to a slot?
>>>
>>> How does the driver assign the key material for a slot?
>>
>> blk layer will initialize a blk_crypto_key based on the configuration received from
>> FS layer. This blk_crypto_key contains expected algorithm, data unit size and key size expected
>> by the upper layer. When submit_bio, blk_mq tries to program the key included in blk_crypto_key
>> to the ICE hardware slot via blk_crypto_profile. During programming the key, it will compare 
>> the algorithm, data unit size and key size in blk_crypto_key with the capability exposed by ICE
>> hardware.
>>
>> It will follow bellow flow to assign the key material for a slot.
>>   blk_crypto_profile -> virtio_blk driver -> virtio_blk extention -> SCM driver -> TZ
>>
>> That means the driver only maintain the capability in RAM, use it when programming key.
> 
> I don't see an interface for programming the key in this spec patch. The
> Linux block driver interface includes struct blk_crypto_ll_ops with
> driver functions for programming keys. I expected this spec would add
> operations to the virtio-blk device for implementing those functions?

The design is that having a virtio_blk extension driver to handle the initialization of keyslot manager
for virtio block with VIRTIO_BLK_F_ICE feature bit negociated. And this extension driver also define the
implementation of struct blk_crypto_ll_ops with driver functions for programming keys, evicting keys and
derive raw keys. Thees 3 key operation is done in a 'out of band' channel, that LA GVM calls to TrustZone
(or secure VM) directly via SCM driver, bypass PVM.

Add a new Kconfig VIRTIO_BLK_INLINE_CRYPTO, and this config need always to be set as Y when inline encryption
on virtio block is expected.

In such scenario, the key programming/eviction/derivation doesn't affect the virtio block protocol, so I didn't
add it in this patch. Do you think it's necessary to be shown in virtio SPEC in such design?

> 
> Stefan

