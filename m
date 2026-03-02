Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721443CCA1A
	for <virtio-dev@lists.linux.dev>; Mon,  2 Mar 2026 14:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772462128; cv=none; b=dLRaqv9tMxeklC7PTKFs9ulxTktgQU1T4MCu/J/9AjeTwfJso4uQZpZmMSLbkjtuFOGyNDHqdskeFFquOJ62o2g7mHil8UExxOS27a17zu0UgQQnQUJ9Nr+fhwySLAVJzEyBBwfYZQM1o7GiIeLo+8yhV4WQ+V6BAhwxZedFr6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772462128; c=relaxed/simple;
	bh=lpW9mEn+cUd3oNgRQiyn+afo48GvUn8xvmLBE1S2KCI=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=mHa7/eFbkxUaMD4MP9qIlu9DFV0A30c+lPjuH1PXCQoYfUJIBRNpJ2/fHxyG2NmQykRX1QIXhgefswUJs9A0yB41VnnhigWb7Gbm2loPfkN0lBfkT2DfGnKs+XtFS1HdmduLJZZoFYqt2I8LGJt6+UyZV7Zx+LixUw2eWTzctEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MI4hJTnE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XfCYJ+B/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MI4hJTnE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XfCYJ+B/"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6229EmcC3630787
	for <virtio-dev@lists.linux.dev>; Mon, 2 Mar 2026 14:35:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=uUlH/XVYhsmWBvKXYwkPA9fn
	FzGFqBfeQQ4GtZQwKjA=; b=MI4hJTnE8cKGPOQZ1IY1e6IB2+0pSH2MAXQeE49K
	kVEm/Q+zWqM3hnDc9ZFpVvTlLS1rVmFvabxJba2LCEc2iSfTLBs6kQOnRCEZ+eEd
	GZdUk6JFc/k5MhpFQbv1GJhGtGWNijNpUKUfkmrfM7fSqco9wFse5h4KdGcuNZPz
	3Q7w4Q3CpGRmtuJOuq9ghx2od2dSlKU4dP7xQ3ekC5gaTYeOe02w0Sb7HJjb5xo7
	EtbiNqmCjk32ZhJ3Sy78craLKRWzsMQxuZfsH5J8JLBRP4ZuY1nzSvygJ2sovdgl
	I1zkghU9b04sK2u/NbalC/iuLYrZVcar5F8WN+hnPpj0NA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn7rhs0rt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Mon, 02 Mar 2026 14:35:23 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-12737f276a2so7586730c88.1
        for <virtio-dev@lists.linux.dev>; Mon, 02 Mar 2026 06:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772462122; x=1773066922; darn=lists.linux.dev;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUlH/XVYhsmWBvKXYwkPA9fnFzGFqBfeQQ4GtZQwKjA=;
        b=XfCYJ+B/NHGga9+wnplzub52l9Un8j47RK8cgamn2yfj41yCwcgWl4BspQjBCOfM61
         ysJJwkZKtLQHTO/rv7H8ZiDCmTUaMdn48jxqy6UMH9QVYPEYf7St77GMyK24JnjkyQpC
         6lULWIITq156dUYdhWRDrBUhFkDXpJ30k6L4LgolKjZZVchWUHGFZPbvqaPGk+KjW/2f
         qQgAUGz6Xcva4yBEn5GTZSI72i8WURET3Ai12RSN2O2KSLs3V29nIu3Peswwi3TR89Z8
         HFMLiFnutURTaMsyIFLGtaTleG1hmN54OG3rcFeSEeFOsv+m2UrGARR+7UnwZo8BQvDu
         gmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772462122; x=1773066922;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uUlH/XVYhsmWBvKXYwkPA9fnFzGFqBfeQQ4GtZQwKjA=;
        b=hHJ/gl87GUFLQvY1zdlMGeJTpZ+8nz4GxjwZ8qnZR56rkdWqSmzi3BCHebd7ha2AL5
         j5XC9LTzmmvtAokan2M9Tj1EqsOv11jxOXgNhaJnMpTcjz9shRzbZzjFGJvht+XOXYhP
         mP1l4xQbLSPwdB5/3IZ2nfZzUWp/J7GKNgT+7BrIH2xxtESNpqbugO/iwp+fD1zZpfbG
         mmZDb87ogEdt7FaSg4cIK5s2GuJQVyKDJoJXO6yKf1GWgWIwXoYNejhiI5tMEjKlfiKX
         mg/osdxe38AT8m54yPDY4mTHiwXfSi37gHtTN1Jg/N6DdXjWe+UkJsOnj/TK4WGdnTS0
         kMAA==
X-Forwarded-Encrypted: i=1; AJvYcCW0Qd8RXPaxe68R6IUPbGFHcLz3k1G6/wC+D7LNYBA0pnJ/8JEi+0tvbIgKiqo5iXJFqG8ImIsdNbA3@lists.linux.dev
X-Gm-Message-State: AOJu0YxMgYsNiC7p+WLBIRvYzFT3ANEI6ye/YdpOwsGWZC4K7tJBvYKj
	i8VEmjoKakWuZpHcRSs+5Mq4vxk7e0sMolFdv+3Wa2RvpOye5rvb6uA5f0Kurb6kM0dUabylzKl
	NF5s6C1/p/M+QzBWxxURbnRDKhowBNS6fGwsjPiVHCGpZLobOAJi8ZpkXMzWagwzv
X-Gm-Gg: ATEYQzxQgx8uvs2vsnZKxHzoxoN+mclh1CViYSoJxGtPlRCwvcs1B9jnmh7yAoD+sCp
	GnhZ2bE+sam8nItnzEGjAVrYVaJOeT0/EhamlGxdsWgXGz8kZ1nPeFMxra1eXN/umQiCS/YYl/z
	dLdIKtJ3XmWJqRPmvjW/oMU/rz2fWnV3j5ApCls7DXmScfwWLfc9qHzfuzG57bwuRr3hXl7KUWl
	EqU2zavl2jra4CACzoZIApvsY/yygyft8+O08bZCDIYYJwS7WpS4Ej2NLcPkuNaDcHWAgLjSmO5
	KAmJbj4xUdWhmUUOpcpnz/hljwRX1dPSyV738DDvk/9F1nLYQ/2qiaBnOAev40Dye+UPCVPY4d5
	7E1k1DcrU4vQzoeq8sWcsNY3qD7Kzihglf4vQqErhM/54nmyaGzqjc9LQS/X/cqW7ZxIDp0AHyw
	CYO0w=
X-Received: by 2002:a05:7022:688b:b0:119:e56b:98be with SMTP id a92af1059eb24-1278fd17ebfmr5258265c88.37.1772462121611;
        Mon, 02 Mar 2026 06:35:21 -0800 (PST)
X-Received: by 2002:a05:7022:688b:b0:119:e56b:98be with SMTP id a92af1059eb24-1278fd17ebfmr5258128c88.37.1772462118616;
        Mon, 02 Mar 2026 06:35:18 -0800 (PST)
Received: from [10.110.66.133] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1279e9950cesm5595395c88.7.2026.03.02.06.35.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 06:35:17 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------W9Tz7LbUDoal3ilRg8rEju7G"
Message-ID: <112986be-3f22-45fe-ac68-6a2c172f629b@oss.qualcomm.com>
Date: Mon, 2 Mar 2026 22:35:13 +0800
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] virtio-blk: Add inline encryption support
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Sebastian Mauritsson <sma@napatech.com>, virtio-dev@lists.linux.dev,
        quic_dshaikhu@quicinc.com
References: <20260210083208.472824-1-linlin.zhang@oss.qualcomm.com>
 <20260210083208.472824-2-linlin.zhang@oss.qualcomm.com>
 <20260210211842.GA158755@fedora>
 <fa458358-90c8-408c-a860-8bfdb11658bb@oss.qualcomm.com>
 <20260218215336.GD605390@fedora>
 <bca448cf-6c18-4c82-806d-f2a25579a02b@oss.qualcomm.com>
 <20260225095502.GB1653802@fedora>
 <22632a98-3d10-4c71-b579-d7aaefe8553d@oss.qualcomm.com>
 <20260301045516.GB42492@fedora>
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <20260301045516.GB42492@fedora>
X-Proofpoint-ORIG-GUID: _L4Poclo3iPUKCbbLjEX3YmAvarYDJZg
X-Proofpoint-GUID: _L4Poclo3iPUKCbbLjEX3YmAvarYDJZg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDEyMiBTYWx0ZWRfX6dBt6erz5481
 9PmizCkK+J4MuLJ4byjxV206/97gS1ae+RpjoqyUdzY3B23FSbm1Josj8dFXXePagIyheI55Gg+
 OIQuKjt5odstRDesohUoVtyg/xsxVD3k8M1fi2hNE4wgs9u+5siaolyX7y8eEg3AQvj2YEgiR+P
 meTmtZftlbYH2hqzBMxFm8h9NcBoWPrUeCMVul3qIAJIDMNfnPMrNkRVq5oD2CSYQwJls5ShFbl
 fSSqG8UNafXXYhXpxIwvYdCL9DPAN1GtVdNIxgGIH+Urx1N6VhW36oPMdCD8ybS/A6mETIo/acr
 /2HJg+zKudMfNtq7TOMH8XVc4CCyf6fvAbkPRsX6q6UL+a3dFcmWnakb7W5dG5sy9sJv5XzHtJf
 66K+iHuK00zxO4Z9wjSjrfWi6oQck4kvKtL4/sJc4VNehunUrf+wCbTxSNyQ8ioekPf4RMSqILi
 41FcF5s3j5dyruo0lYg==
X-Authority-Analysis: v=2.4 cv=cLntc1eN c=1 sm=1 tr=0 ts=69a5a02c cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=r77TgQKjGQsHNAKrUKIA:9
 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=20KFwNOVAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=nCl6r0l3af1n_7mzm0MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=I9PfsFU1soWvA1tt14cA:9 a=IKIoO-ieCDEA:10 a=Tqm15l3OBWQA:10
 a=vr4QvYf-bLy2KjpDp97w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020122

This is a multi-part message in MIME format.
--------------W9Tz7LbUDoal3ilRg8rEju7G
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Appreciate your review in detail. I attached the slide <FBE_virtualization_proposal.pptx>. Please have a look and
let me know if you have any concern. Thanks!

Linlin

On 3/1/2026 12:55 PM, Stefan Hajnoczi wrote:
> On Thu, Feb 26, 2026 at 09:34:01PM +0800, Linlin Zhang wrote:
>>
>>
>> On 2/25/2026 5:55 PM, Stefan Hajnoczi wrote:
>>> On Wed, Feb 25, 2026 at 01:33:17PM +0800, Linlin Zhang wrote:
>>>>
>>>>
>>>> On 2/19/2026 5:53 AM, Stefan Hajnoczi wrote:
>>>>> On Sat, Feb 14, 2026 at 03:22:21PM +0800, Linlin Zhang wrote:
>>>>>>
>>>>>>
>>>>>> On 2/11/2026 5:18 AM, Stefan Hajnoczi wrote:
>>>>>>> On Tue, Feb 10, 2026 at 12:32:08AM -0800, Linlin Zhang wrote:
>>>>>>>> Inline encryption on virtio block can only be supported when
>>>>>>>> the new feature bit VIRTIO_BLK_F_ICE is negotiated.
>>>>>>>>
>>>>>>>> Extend struct virtio_blk_config and struct virtio_blk_req,
>>>>>>>> so that crypto capabilities can be got in the frontend and
>>>>>>>> encryption metadata can be sent to the backend, together with
>>>>>>>> each I/O transaction.
>>>>>>>>
>>>>>>>> About the inline encryption on UFS or eMMC storage, please
>>>>>>>> refer to the Linux inline encryption documentation:
>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/block/inline-encryption.rst
>>>>>>>>
>>>>>>>> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/238
>>>>>>>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>>>>>>>> Signed-off-by: linlzhan <quic_linlzhan@quicinc.com>
>>>>>>>> Signed-off-by: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
>>>>>>>> ---
>>>>>>>>  device-types/blk/description.tex | 110 ++++++++++++++++++++++++++++++-
>>>>>>>>  1 file changed, 108 insertions(+), 2 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/device-types/blk/description.tex b/device-types/blk/description.tex
>>>>>>>> index 2712ada..60f46af 100644
>>>>>>>> --- a/device-types/blk/description.tex
>>>>>>>> +++ b/device-types/blk/description.tex
>>>>>>>> @@ -66,6 +66,11 @@ \subsection{Feature bits}\label{sec:Device Types / Block Device / Feature bits}
>>>>>>>>  	(ZNS). For brevity, these standard documents are referred as "ZBD standards"
>>>>>>>>  	from this point on in the text.
>>>>>>>>  
>>>>>>>> +\item[VIRTIO_BLK_F_ICE(22)] Inline Crypto Extensions are supported. Only when this
>>>>>>>> +     feature bit is negotiated, the device need expose crypto characteristics in
>>>>>>>> +     configuration space and the driver need provide an extended request header
>>>>>>>> +     containing a crypto payload for block I/O.
>>>>>>>
>>>>>>> Most of the feature bit descriptions are brief and the details are
>>>>>>> covered later in the spec. I suggest doing this here too:
>>>>>>>
>>>>>>>   \item[VIRTIO_BLK_F_ICE (22)] Device supports Inline Crypto Engine functionality.
>>>>>>>
>>>>>>> I changed the name from Inline Crypto Extensions to Inline Crypto Engine
>>>>>>> because that terminology is used in the Linux kernel. Web search results
>>>>>>> also favor "inline crypto engine" over "inline crypto extensions". Are
>>>>>>> you okay with "engine"?
>>>>>> Thanks! ACK
>>>>>>
>>>>>>>
>>>>>>>> +
>>>>>>>>  \end{description}
>>>>>>>>  
>>>>>>>>  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Block Device / Feature bits / Legacy Interface: Feature bits}
>>>>>>>> @@ -128,6 +133,10 @@ \subsection{Device configuration layout}\label{sec:Device Types / Block Device /
>>>>>>>>                  u8 model;
>>>>>>>>                  u8 unused2[3];
>>>>>>>>          } zoned;
>>>>>>>> +        struct virtio_blk_crypto_characteristics {
>>>>>>>> +                __virtio16 slot_info;
>>>>>>>> +                __virtio16 reserved;
>>>>>>>> +        } crypto;
>>>>>>>>  };
>>>>>>>>  \end{lstlisting}
>>>>>>>>  
>>>>>>>> @@ -215,6 +224,18 @@ \subsection{Device configuration layout}\label{sec:Device Types / Block Device /
>>>>>>>>  terminated by the device with a "zone resources exceeded" error as defined for
>>>>>>>>  specific commands later.
>>>>>>>>  
>>>>>>>> +If the VIRTIO_BLK_F_ICE feature is negotiated, then in
>>>>>>>> +\field{virtio_blk_crypto_characteristics},
>>>>>>>> +\begin{itemize}
>>>>>>>> +\item \field{slot_info} value packs two 8-bits values to reduce the number of
>>>>>>>
>>>>>>> 8-bits -> 8-bit
>>>>>>
>>>>>> ACK
>>>>>>
>>>>>>>
>>>>>>>> +    Configuration Space reads.
>>>>>>>> +    \begin{itemize}
>>>>>>>> +        \item Bits~\[15:8] (\emph{max\_slots}): the maximum number of supported
>>>>>>>> +            crypto key slots.
>>>>>>>> +        \item Bits~\[7:0] (\emph{slot\_offset}): an offset applied to slot numbering.
>>>>>>>
>>>>>>> What is the purpose of slot_offset? This field is not used much in this
>>>>>>> spec, maybe it can be removed?
>>>>>>>
>>>>>>> Does that mean only slots in the range [slot_offset:max_slots) are
>>>>>>> available or does it mean that the range is
>>>>>>> [slot_offset:slot_offset+max_slots)?
>>>>>>
>>>>>> Only slots within the range [slot_offset, slot_offset + max_slots) are accessible to the
>>>>>> VM. The slot_offset specifies the base physical ICE slot allocated to the VM and is used
>>>>>> to translate a virtual slot index into a physical slot.
>>>>>>
>>>>>> Because the GVM programs and evicts keys directly—without host/PVM involvement—it must
>>>>>> supply the resolved physical slot when invoking key operations in TrustZone or the Secure
>>>>>> VM.
>>>>>
>>>>> It's not clear to me how what you've described offers isolation between
>>>>> the PVM and the GVM. What stops the GVM from using key slots outside the
>>>>> range that has been assigned to it?
>>>>>
>>>>> A few options for isolation come to mind:
>>>>>
>>>>> 1. Expose 2 separate virtio-blk devices, one of which is hidden from the
>>>>>    GVM and only accessible to the PVM. The PVM can store its data on the
>>>>>    hidden device.
>>>>>
>>>>> 2. Some kind of VIRTIO Admin queue Virtual Function approach where the
>>>>>    PVM can instantiate a virtual function (a sub-device) that the GVM is
>>>>>    allowed to access with isolation enforced by the device.
>>>>>
>>>>> 3. A single device could be used but the GVM cannot access it directly
>>>>>    and needs to go through the PVM.
>>>>
>>>> The slot isolation between GVM and PVM is implemented by the max slots allocated to the GVM and slot offset
>>>> the GVM's starting slot relative to the physical starting slot.
>>>>
>>>> For instance, ICE hardware has 64 slots, the max slots allocated to the GVM is 32, and its slot offset is 20.
>>>> The keyslot manager in the GVM ensure the virtual slot rang is [0,31], when programming a key, translate the
>>>> virtual slot to a physical slot by using the slot offset, that means the physical slot range this GVM used
>>>> is [20,51].
>>>>
>>>> The max_slots and slot_offset are configured by PVM, and GVM's virtio frontend only gets them from the configuration
>>>> space of its virtio devices. So PVM is responsible to ensure the physical slot range of the GVM is valid.
>>>
>>> I don't understand how isolation between the PVM and GVM works. To me it
>>> seems like if there is isolation, then it would not be necessary to
>>> expose slot_offset to the GVM. And if there is no isolation, then this
>>> design isn't safe because the PVM is not protected against the GVM.
>>>
>>> I'm probably missing something. Can you explain how isolation is
>>> enforced?
>>
>> Appreciate your quick feedback!
>>
>> The key slots in ICE hardware are used by both PVM/Host and GVMs, the PVM/Host
>> specifies the slot range of each VM used (including itself) by defining starting
>> slot offest and max slots per VM, ensure that there isn't overlapping b/w these
>> slot ranges in physical slot level.
>>
>> In this way, if only the virtual slot in each VM doesn't exceed the max slots
>> allocated to it, the access to its physical ICE slot for one VM doesn' have impact
>> on the ICE slots belonging to the range of other VMs. 
>>
>> You mentioned "this design isn't safe because the PVM is not protected against the
>> GVM", do you mean that the slot_offest and/or max_slots of GVM are tampered by a
>> malixious program, leading to unexpected access from GVM to a physical ICE slot
>> allocated to PVM? If yes, I feel it's not a risk as kernel image can be pretotected
>> via dm-verity/AVB, it's impossible for an attacker to rewrite them in runtime from
>> both PVM and GVM sides.
> 
> There are two separate issues that are still unclear to me:
> 1. The device appears to trust the guest to select valid slot indices.
> 2. How the PVM/GVM share the device.
> 
> About trusting the slot field:
> - In VIRTIO the trust model is that the device does not trust the
>   driver. This is necessary not just for reliability but also to prevent
>   virtualized devices from being exploited by untrusted VMs (escaping
>   confinement, consuming resources not allocated to the VM, etc).
> - Given that the device cannot trust the driver, I don't understand why
>   the interface is designed to require driver cooperation in choosing
>   slot indices within the slot_offset/max_slots range.
> - I expected the interface to expose a max_slots Configuration Space
>   field but slot indices are in the range [0, max_slots) and are
>   validated by the device.

The FBE key programing/eviction in a out-of-band channel here is a compromise for
upstream. The reason I'll show it in the proposal slide.

In such way, the GVM has to transfer the virtio slot to the physical slot, and send it
to Trust Zone during key programming/eviction, bypass slot check in the PVM.
So, slot_offset on hardware must also be provided by the PVM together with max_slots for
the GVM. On the GVM side, the virtio block driver trusts that max_slots and slot_offest.
The layers upper virtio block crypto exteansion driver only see the virtual slots in the
range [0, max_slots) and use it. Only when the virtual slot is passed to virtio block
crypto exteansion driver, this exteansion driver will ensure the virtual slot is resided
in [0, max_slots) and translates it to the physical slot by adding slot_offset.

Sorry, I get your point about your second issue. Hope the slide can give you more
information.

> 
> About the PVM/GVM relationship, please see below where I'm asking about
> the architecture of a system using ICE.
> 
>>>
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>>> +    \end{itemize}
>>>>>>>> +\end{itemize}
>>>>>>>> +
>>>>>>>>  \subsubsection{Legacy Interface: Device configuration layout}\label{sec:Device Types / Block Device / Device configuration layout / Legacy Interface: Device configuration layout}
>>>>>>>>  When using the legacy interface, transitional devices and drivers
>>>>>>>>  MUST format the fields in struct virtio_blk_config
>>>>>>>> @@ -278,6 +299,10 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
>>>>>>>>      \field{zoned} can be read by the driver to determine the zone
>>>>>>>>      characteristics of the device. All \field{zoned} fields are read-only.
>>>>>>>>  
>>>>>>>> +\item If the VIRTIO_BLK_F_ICE feature is negotiated, the fields in
>>>>>>>> +    \field{crypto} can be read by the driver to determine the inline crypto
>>>>>>>> +    characteristics of the device. All \field{crypto} fields are read-only.
>>>>>>>> +
>>>>>>>>  \end{enumerate}
>>>>>>>>  
>>>>>>>>  \drivernormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
>>>>>>>> @@ -317,6 +342,9 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
>>>>>>>>      driver SHOULD ignore all other fields in \field{zoned}.
>>>>>>>>  \end{itemize}
>>>>>>>>  
>>>>>>>> +If the VIRTIO_BLK_F_ICE feature is negotiated, then the driver MUST validate
>>>>>>>> +    the max_slots in \field{slot_info} before the slot usage.
>>>>>>>
>>>>>>> I'm not sure how the driver is supposed to validate max_slots?
>>>>>>
>>>>>> It means the diver validate the virtual slot doesn't exceed the max_slots before translating
>>>>>> this virtual slot to a physical slot by using slot_offset. 
>>>>>>
>>>>>> Can I rewrite it as the following?
>>>>>>
>>>>>>   If the VIRTIO_BLK_F_ICE feature is negotiated, then the driver MUST validate that
>>>>>>   the virtual slot received from upper layer doesn't exceed the max_slots in
>>>>>>   \field{slot_info} before the slot usage.
>>>>>
>>>>> The notion of an "upper layer" can be eliminated so that there is no
>>>>> assumption about the software design in the driver:
>>>>>
>>>>>   If the VIRTIO_BLK_F_ICE feature is negotiated, then the driver MUST
>>>>>   ensure that slot_offset <= \field{payload.slot} < slot_offset +
>>>>>   max_slots, where slot_offset and max_slots are the values extracted
>>>>>   from \field{crypto.slot_info} in configuration space.
>>>>
>>>> ACK. Thanks!
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>>> +
>>>>>>>>  \devicenormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
>>>>>>>>  
>>>>>>>>  Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it
>>>>>>>> @@ -402,6 +430,13 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
>>>>>>>>  \item the device MUST initialize padding bytes \field{unused2} to 0.
>>>>>>>>  \end{itemize}
>>>>>>>>  
>>>>>>>> +If the VIRTIO_BLK_F_ICE feature is negotiated, then the fields in \field{crypto}
>>>>>>>> +struct in the configuration space MUST be set by the device.
>>>>>>>> +\begin{itemize}
>>>>>>>> +\item the \field{slot_info} field of \field{crypto} MUST be set by the device to a
>>>>>>>> +    max_slots in the higher 8 bits and slot_offset in the lower 8 bits.
>>>>>>>> +\end{itemize}
>>>>>>>
>>>>>>> There is no need for the \begin{itemize} here. It contains no new
>>>>>>> information. The fields were already described in the configuration
>>>>>>> space section and the previous sentence already said that the fields in
>>>>>>> \field{crypto} must be set by the device.
>>>>>>
>>>>>> ACK, remove this \begin{itemize} here.
>>>>>>
>>>>>>>
>>>>>>>> +
>>>>>>>>  \subsubsection{Legacy Interface: Device Initialization}\label{sec:Device Types / Block Device / Device Initialization / Legacy Interface: Device Initialization}
>>>>>>>>  
>>>>>>>>  Because legacy devices do not have FEATURES_OK, transitional devices
>>>>>>>> @@ -436,6 +471,13 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>>>>>>>>          le32 type;
>>>>>>>>          le32 reserved;
>>>>>>>>          le64 sector;
>>>>>>>> +        struct virtio_blk_crypto_payload {
>>>>>>>> +            u8 slot;
>>>>>>>> +            u8 activate;
>>>>>>>> +            le16 reserved1;
>>>>>>>> +            le32 reserved2;
>>>>>>>> +            le64 data_unit_num;
>>>>>>>> +        } payload;
>>>>>>>
>>>>>>> "payload" is a generic term. crypto_payload would be clearer.
>>>>>>>
>>>>>>> I wonder whether consistently calling this feature "ice" rather than
>>>>>>> "crypto" would help in case self-encrypting drive or other cryptographic
>>>>>>> functionality is added to virtio-blk in the future. That way the spec
>>>>>>> items related to inline crypto engine functionality will be easy to
>>>>>>> differentiate from other crypto functionality.
>>>>>>
>>>>>> Ok, to differentiate ICE and other cryptographic functionality, can I modify it as
>>>>>>
>>>>>>   struct virtio_blk_ice_payload {
>>>>>>       u8 slot;
>>>>>>       u8 activate;
>>>>>>       le16 reserved1;
>>>>>>       le32 reserved2;
>>>>>>       le64 data_unit_num;
>>>>>>   } ice_payload;
>>>>>
>>>>> Looks good to me, thanks.
>>>>
>>>> Thanks!
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>>>          u8 data[];
>>>>>>>>          u8 status;
>>>>>>>>  };
>>>>>>>> @@ -445,8 +487,9 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>>>>>>>>  (VIRTIO_BLK_T_OUT), a discard (VIRTIO_BLK_T_DISCARD), a write zeroes
>>>>>>>>  (VIRTIO_BLK_T_WRITE_ZEROES), a flush (VIRTIO_BLK_T_FLUSH), a get device ID
>>>>>>>>  string command (VIRTIO_BLK_T_GET_ID), a secure erase
>>>>>>>> -(VIRTIO_BLK_T_SECURE_ERASE), or a get device lifetime command
>>>>>>>> -(VIRTIO_BLK_T_GET_LIFETIME).
>>>>>>>> +(VIRTIO_BLK_T_SECURE_ERASE), a get device lifetime command
>>>>>>>> +(VIRTIO_BLK_T_GET_LIFETIME), or a get device crypto capabilities command
>>>>>>>> +(VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES).
>>>>>>>>  
>>>>>>>>  \begin{lstlisting}
>>>>>>>>  #define VIRTIO_BLK_T_IN           0
>>>>>>>> @@ -457,12 +500,27 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>>>>>>>>  #define VIRTIO_BLK_T_DISCARD      11
>>>>>>>>  #define VIRTIO_BLK_T_WRITE_ZEROES 13
>>>>>>>>  #define VIRTIO_BLK_T_SECURE_ERASE   14
>>>>>>>> +#define VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES   27
>>>>>>>
>>>>>>> The Linux virtio_blk.c driver assumes that odd numbered constants have
>>>>>>> data buffers that are read by the device, so you may run into a bug when
>>>>>>> using 27.
>>>>>>>
>>>>>>> There is an informal convention to use even numbers for read requests
>>>>>>> and odd numbers for write requests. It doesn't hurt to try to follow the
>>>>>>> convention even though it's not strictly necessary.
>>>>>>>
>>>>>>> The Linux driver could be fixed when adding support for ICE, but 16 is
>>>>>>> available and it's safest to use that.
>>>>>>
>>>>>> OK. Agree to following the convention. But 16, 18,20,22,24,26 are already used by
>>>>>> zone device. Seems 12 is available. Correct it to 12.
>>>>>>
>>>>>>  #define VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES   12
>>>>>
>>>>> In that case I suggest using 28. I don't remember what 12 was used for
>>>>> but there may be a historical reason for the gap.
>>>>
>>>> Thanks! Change it to 28.
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>>>  \end{lstlisting}
>>>>>>>>  
>>>>>>>>  The \field{sector} number indicates the offset (multiplied by 512) where
>>>>>>>>  the read or write is to occur. This field is unused and set to 0 for
>>>>>>>>  commands other than read, write and some zone operations.
>>>>>>>>  
>>>>>>>> +The \field{payload} consists of the encryption information for current
>>>>>>>> +request. It is only present when the VIRTIO_BLK_F_ICE feature is negotiated and
>>>>>>>> +\field{type} is VIRTIO_BLK_T_IN, VIRTIO_BLK_T_OUT or VIRTIO_BLK_T_FLUSH.
>>>>>>>
>>>>>>> TODO think about layout
>>>>>>
>>>>>> rewrite to the following
>>>>>>
>>>>>>   The \field{ice_payload} consists of the encryption information for current
>>>>>>   request. When VIRTIO_BLK_F_ICE is negotiated, the request header layout becomes
>>>>>>   that struct virtio_blk_outhdr includes \field{ice_payload} as a fixed-size
>>>>>>   extension. For non-ICE requests (or types not using crypto), the driver MUST
>>>>>>   set \field{ice_payload} to 0 and device ignores them.
>>>>>
>>>>> Sorry, the TODO was a comment to myself while writing my reply :).
>>>>>
>>>>> I forgot to investigate. Basically the issue is that the spec must be
>>>>> clear on whether:
>>>>> 1. A field is absent and fields that follow it are present in the struct
>>>>>    layout when a condition is false (e.g. type is not VIRTIO_BLK_T_IN,
>>>>>    VIRTIO_BLK_T_OUT, or VIRTIO_BLK_T_FLUSH).
>>>>> or
>>>>> 2. A field is present but unused (zeroed) when a condition is false.
>>>>>
>>>>> #2 is usually easier to implement in code because it avoids creating
>>>>> many different struct layouts at runtime depending on conditions like
>>>>> negotiated feature bits.
>>>>>
>>>>> I was thinking that the ice fields should always be present but should
>>>>> be zero when the feature bit is not negotiated or some other condition
>>>>> (like the request type) is false. This way it will be much easier to add
>>>>> additional fields later without worrying about struct layouts.
>>>>>
>>>>> This is how configuration space already works: the offset of the zoned
>>>>> field is not affected by whether the device advertises the
>>>>> VIRTIO_BLK_F_WRITE_ZEROES feature bit, it just means that the earlier
>>>>> write_zeroes_may_unmap field may be unused. This approach should
>>>>> probably be used everywhere and the spec language should be careful to
>>>>> communicate that the field is still present but zero when unused. It's
>>>>> okay for the driver to provide a shorter struct that doesn't include the
>>>>> last field(s) to the device when the feature bit is not negotiated
>>>>> though.
>>>>
>>>> Thanks. Refer to the statement you shared, try to rewrite it as the following.
>>>>
>>>>   The \field{ice_payload} consists of the encryption information for current
>>>>   request. It is not affected by whether the device advertises the
>>>>   VIRTIO_BLK_F_ICE feature bit, it just SHOULD be zero when the feature bit is
>>>>   not negotiated or the \field{type} is not VIRTIO_BLK_T_IN, VIRTIO_BLK_T_OUT
>>>>   or VIRTIO_BLK_T_FLUSH. 
>>>
>>> Sounds good.
>>>
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>>> +\begin{itemize}
>>>>>>>> +\item The \field{slot} field in \field{payload} indicates the ICE
>>>>>>>> +  (Inline Crypto Encryption) slot index where the key resides.
>>>>>>>> +
>>>>>>>> +\item The \field{activate} field in \field{payload} implies this is a
>>>>>>>> +  inline encryption request.
>>>>>>>> +
>>>>>>>> +\item The \field{data_unit_num} field in \field{payload} indicates the
>>>>>>>> +  starting block of the request.
>>>>>>>
>>>>>>> This is a block device, so the term "block" needs to be qualified to
>>>>>>> avoid confusion. I guess this is the cryptography concept of a block
>>>>>>> rather than the disk concept of a block. Please clarify this in the
>>>>>>> text, maybe by explaining that the ICE handles data in fixed-size "data
>>>>>>> units" instead of using the word "block".
>>>>>>>
>>>>>>> Also, can you explain the relationship between the data unit number and
>>>>>>> the sector? In simple cases I imagine the data unit number would be the
>>>>>>> sector. How is the driver supposed to pick or calculate the data unit
>>>>>>> number?
>>>>>>
>>>>>> The data unit number is the starting IV for AES crypto in ICE hardware, it's
>>>>>> a stable value for I/O request targeting to same storage range. It can be set
>>>>>> to the file logic block number or the starting sector of BIO. 
>>>>>
>>>>> It sounds like the data unit number calculation is up to the driver
>>>>> (from the device's perspective) and the important thing is that the same
>>>>> data unit number will always be used when reading/writing the same
>>>>> logical data location.
>>>>
>>>> Yes. Correct.
>>>>
>>>>>
>>>>>> The upper layer calculates it and passes it to virtio_blk driver in this patch.
>>>>>> ICE uses the data unit number and data unit size (the granularity to use for
>>>>>> en/decryption) to derive the next data unit number for the next cryptography
>>>>>> block. data unit number in ICE increase 1 per data unit size. For instance,
>>>>>>   data unit number = 2048
>>>>>>   data unit size = 1024 bytes
>>>>>> For the first 1024 bytes of the transaction, ICE hardware encrypt the data
>>>>>> with IV equal to 2048.
>>>>>> For the second 1024 bytes of the transaction, ICE hardware encrypt the data
>>>>>> with IV equal to (2048+1=)2049.
>>>>>>
>>>>>> Rewrite it as bellow.
>>>>>>
>>>>>>   \item The \field{data_unit_num} field in \field{ice_payload} indicates the
>>>>>>   starting IV. It can be the file logic block number or the starting sector
>>>>>>   of BIO.
>>>>>
>>>>> BIO is a Linux-specific concept, so it would be best to avoid it in the
>>>>> VIRTIO spec.
>>>>>
>>>>>   \item The \field{data_unit_num} field in \field{ice_payload} indicates
>>>>>   the starting IV. In order to successfully encrypt/decrypt data this
>>>>>   number must be the same for successive read and write operations to
>>>>>   the same logical data location. The driver typically sets it to the
>>>>>   file logical block number or the disk sector number.
>>>>
>>>> Thanks! ACK.
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>>> +\end{itemize}
>>>>>>>> +
>>>>>>>>  VIRTIO_BLK_T_IN requests populate \field{data} with the contents of sectors
>>>>>>>>  read from the block device (in multiples of 512 bytes).  VIRTIO_BLK_T_OUT
>>>>>>>>  requests write the contents of \field{data} to the block device (in multiples
>>>>>>>> @@ -530,6 +588,47 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>>>>>>>>  The \field{device_lifetime_est_typ_b} refers to wear of MLC cells and is provided
>>>>>>>>  with the same semantics as \field{device_lifetime_est_typ_a}.
>>>>>>>>  
>>>>>>>> +VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES requests fetch the storage hardware crypto
>>>>>>>> +capabilities into \field{data}. And the \field{data} is of the form
>>>>>>>
>>>>>>> How does VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES behave when data[] is too
>>>>>>> small to fit all the device's crypto capabilities?
>>>>>>
>>>>>> Add a new field capability_num to the Configuration space header. The total size of
>>>>>> \field{data} shall be computed as:
>>>>>>   data_size=capability_num×capability_size
>>>>>> where capability_size is the size (in bytes) of one capability structure. Therefore, \field{data} contains exactly capability_num contiguous capability entries, each of length capability_size.
>>>>>> Add a capability_num field in Configuration space. So it use size per capability
>>>>>> multiply capability_num to define the size of \field{data}.
>>>>>>
>>>>>> Rewrite it as the following.
>>>>>>
>>>>>>   VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES requests fetch the storage hardware crypto
>>>>>>   capabilities into \field{data}. The crypto capabilities is a zero-padded array
>>>>>>   up to (\field{capability_num}×capability_size) bytes long, where capability_size
>>>>>>   is the size (in bytes) of one capability structure which is in form of
>>>>>>   
>>>>>>   \begin{lstlisting}
>>>>>>     struct virtio_blk_crypto_cap {
>>>>>>         u8 alg;
>>>>>>         u8 data_unit_size;
>>>>>>         u8 key_size;
>>>>>>         u8 reserved;
>>>>>>     };
>>>>>>   \end{lstlisting}
>>>>>>   
>>>>>>   \begin{itemize}
>>>>>>       \item The \field{alg} implies crypto algorithm identifiers.
>>>>>>       The device supports reporting and negotiating cryptographic algorithms
>>>>>>       using the following algorithm identifiers:
>>>>>>       \begin{lstlisting}
>>>>>>           CRYPTO_ALG_AES_XTS              = 0x0
>>>>>>           CRYPTO_ALG_BITLOCKER_AES_CBC    = 0x1
>>>>>>           CRYPTO_ALG_AES_ECB              = 0x2
>>>>>>           CRYPTO_ALG_ESSIV_AES_CBC        = 0x3
>>>>>>       \end{lstlisting}
>>>>>>       These identifiers abstract the underlying hardware crypto implementation
>>>>>>       and does not assume any operating‑system‑specific data structures or
>>>>>>       constants.
>>>>>>       \item The \field{data_unit_size} implies the mask of data unit size. When
>>>>>>       bit j in this field (j=7......0) is set, a data unit size of 512*2^j bytes
>>>>>>       is selected.
>>>>>>       \item The \field{key_size} is the crypto key size identifiers.
>>>>>>       \begin{lstlisting}
>>>>>>           CRYPTO_KEY_SIZE_INVALID     = 0x0
>>>>>>           CRYPTO_KEY_SIZE_128_BITS    = 0x1
>>>>>>           CRYPTO_KEY_SIZE_192_BITS    = 0x2
>>>>>>           CRYPTO_KEY_SIZE_256_BITS    = 0x3
>>>>>>           CRYPTO_KEY_SIZE_512_BITS    = 0x4
>>>>>>       \end{lstlisting}
>>>>>>       \item The \field{reserved} is unused.
>>>>>>   \end{itemize}
>>>>>>   
>>>>>>   If the \field{data} is too short, it sets status to BLK_S_IO_ERR.
>>>>>
>>>>> Looks good. In the final sentence I suggest changing "it" to "the
>>>>> device" for clarity.
>>>>
>>>> Thanks! Done.
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>>> +
>>>>>>>> +\begin{lstlisting}
>>>>>>>> +struct virtio_blk_crypto_caps {
>>>>>>>> +  u8 size;
>>>>>>>> +  le32 crypto_capabilities[];
>>>>>>>> +};
>>>>>>>> +\end{lstlisting}
>>>>>>>> +
>>>>>>>> +The \field{size} specifies the size of array \field{crypto_capabilities}.
>>>>>>>
>>>>>>> "number of elements" would be clearer than "size of array" because the
>>>>>>> unit (bytes vs array elements) is ambiguous.
>>>>>>>
>>>>>>> The size field is not necessary since Used Ring descriptors contain
>>>>>>> (struct virtq_used_elem in the spec) a len field indicating how many
>>>>>>> bytes were written by the device.
>>>>>>
>>>>>> Remove virtio_blk_crypto_caps in above modification.
>>>>>>
>>>>>>>
>>>>>>>> +The \field{crypto_capabilities} indicates the crypto capabilities supported by the
>>>>>>>> +hardware storage for inline encryption.
>>>>>>>> +
>>>>>>>> +A crypto capability packs four 8-bits values:
>>>>>>>> +\begin{itemize}
>>>>>>>> +    \item Bits~\[31:24]: crypto algorithm identifiers.
>>>>>>>> +    The device supports reporting and negotiating cryptographic algorithms
>>>>>>>> +    using the following algorithm identifiers:
>>>>>>>> +    \begin{lstlisting}
>>>>>>>> +        CRYPTO_ALG_AES_XTS              = 0x0
>>>>>>>> +        CRYPTO_ALG_BITLOCKER_AES_CBC    = 0x1
>>>>>>>> +        CRYPTO_ALG_AES_ECB              = 0x2
>>>>>>>> +        CRYPTO_ALG_ESSIV_AES_CBC        = 0x3
>>>>>>>> +    \end{lstlisting}
>>>>>>>> +    These identifiers abstract the underlying hardware crypto implementation
>>>>>>>> +    and does not assume any operating‑system‑specific data structures or
>>>>>>>> +    constants.
>>>>>>>> +    \item Bits~\[23:16]: mask of data unit size. When bit j in this field
>>>>>>>> +    (j=7......0) is set, a data unit size of 512*2^j bytes is selected.
>>>>>>>
>>>>>>> Is only one bit ever set in the mask? If so, then maybe just express j
>>>>>>> as an 8-bit unsigned integer (i.e. the exponent in 512*2^j) instead of
>>>>>>> as a bit mask. It's simpler and increases the range for j.
>>>>>>
>>>>>> Yes, it's encoded in one-hot encoding. If j is expressed as an 8-bit unsigned integer,
>>>>>> it will confused the reader that more than one bit can be set in the mask of data unit
>>>>>> size. right? 
>>>>>
>>>>> If the field is called the data unit size exponent (data_unit_size_exp)
>>>>> then there is no confusion. I agree that calling it a mask would be
>>>>> confusing.
>>>>
>>>> Thanks! Update it to data_unit_size_exp.
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>>> +    \item Bits~\[15:8]: crypto key size identifiers.
>>>>>>>> +    \begin{lstlisting}
>>>>>>>> +        CRYPTO_KEY_SIZE_INVALID     = 0x0
>>>>>>>> +        CRYPTO_KEY_SIZE_128_BITS    = 0x1
>>>>>>>> +        CRYPTO_KEY_SIZE_192_BITS    = 0x2
>>>>>>>> +        CRYPTO_KEY_SIZE_256_BITS    = 0x3
>>>>>>>> +        CRYPTO_KEY_SIZE_512_BITS    = 0x4
>>>>>>>> +    \end{lstlisting}
>>>>>>>> +    \item Bits~\[7:0]: unused.
>>>>>>>> +\end{itemize}
>>>>>>>
>>>>>>> A struct would be more natural here (the rest of the VIRTIO
>>>>>>> specification rarely packs fields into an integer):
>>>>>>>
>>>>>>>   struct virtio_blk_crypto_cap {
>>>>>>>       u8 alg;
>>>>>>>       u8 data_unit_size;
>>>>>>>       u8 key_size;
>>>>>>>       u8 reserved;
>>>>>>>   };
>>>>>>
>>>>>> ACK, see above rewrite statement.
>>>>>>
>>>>>>>
>>>>>>> By the way, Linux seems to call this a "profile" rather than a
>>>>>>> "capability". Do you want to use the same name as Linux for consistency?
>>>>>>
>>>>>> blk-crypto-profile is the keyslot manager which manage the usage of keyslot and
>>>>>> also checks if the key configuration set by upper layer can be supported by the
>>>>>> ICE hardware. While the capability aims to illustrate the capability provided by
>>>>>> the ICE hardware. What we expected is the capability used to initialized
>>>>>> blk-crypto-profile in Guest VM.
>>>>>
>>>>> I see.
>>>>>
>>>>>>
>>>>>>>
>>>>>>>> +
>>>>>>>>  The final \field{status} byte is written by the device: either
>>>>>>>>  VIRTIO_BLK_S_OK for success, VIRTIO_BLK_S_IOERR for device or driver
>>>>>>>>  error or VIRTIO_BLK_S_UNSUPP for a request unsupported by device:
>>>>>>>> @@ -912,6 +1011,13 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>>>>>>>>  successfully, failed, or were processed by the device at all if the request
>>>>>>>>  failed with VIRTIO_BLK_S_IOERR.
>>>>>>>>  
>>>>>>>> +The length of \field{data} MUST be a multiple of 4 bytes plus 1 for
>>>>>>>> +VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES requests.
>>>>>>>> +
>>>>>>>> +A driver MUST set \field{activate} to 1 for VIRTIO_BLK_T_IN,VIRTIO_BLK_T_OUT,
>>>>>>>> +    and VIRTIO_BLK_T_FLUSH requests that require inline encryption. For other
>>>>>>>> +    request types or when inline encryption is not required, it is set to 0.
>>>>>>>> +
>>>>>>>>  The following requirements only apply if the VIRTIO_BLK_F_ZONED feature is
>>>>>>>>  negotiated.
>>>>>>>
>>>>>>> How does the driver assign a specific capability (algorithm, data unit
>>>>>>> size, and key size tuple reported by
>>>>>>> VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES) to a slot?
>>>>>>>
>>>>>>> How does the driver assign the key material for a slot?
>>>>>>
>>>>>> blk layer will initialize a blk_crypto_key based on the configuration received from
>>>>>> FS layer. This blk_crypto_key contains expected algorithm, data unit size and key size expected
>>>>>> by the upper layer. When submit_bio, blk_mq tries to program the key included in blk_crypto_key
>>>>>> to the ICE hardware slot via blk_crypto_profile. During programming the key, it will compare 
>>>>>> the algorithm, data unit size and key size in blk_crypto_key with the capability exposed by ICE
>>>>>> hardware.
>>>>>>
>>>>>> It will follow bellow flow to assign the key material for a slot.
>>>>>>   blk_crypto_profile -> virtio_blk driver -> virtio_blk extention -> SCM driver -> TZ
>>>>>>
>>>>>> That means the driver only maintain the capability in RAM, use it when programming key.
>>>>>
>>>>> I don't see an interface for programming the key in this spec patch. The
>>>>> Linux block driver interface includes struct blk_crypto_ll_ops with
>>>>> driver functions for programming keys. I expected this spec would add
>>>>> operations to the virtio-blk device for implementing those functions?
>>>>
>>>> The design is that having a virtio_blk extension driver to handle the initialization of keyslot manager
>>>> for virtio block with VIRTIO_BLK_F_ICE feature bit negociated. And this extension driver also define the
>>>> implementation of struct blk_crypto_ll_ops with driver functions for programming keys, evicting keys and
>>>> derive raw keys. Thees 3 key operation is done in a 'out of band' channel, that LA GVM calls to TrustZone
>>>> (or secure VM) directly via SCM driver, bypass PVM.
>>>>
>>>> Add a new Kconfig VIRTIO_BLK_INLINE_CRYPTO, and this config need always to be set as Y when inline encryption
>>>> on virtio block is expected.
>>>>
>>>> In such scenario, the key programming/eviction/derivation doesn't affect the virtio block protocol, so I didn't
>>>> add it in this patch. Do you think it's necessary to be shown in virtio SPEC in such design?
>>>
>>> It seems like supporting keyslot manager operations via the virtio-blk
>>> device is a possible future use case. The design of VIRTIO_BLK_F_ICE
>>> should allow for adding it in the future so that we can be confident
>>> that no breaking changes will be needed.
>>>
>>> Why are the keyslot manager operations out of band in your TrustZone use
>>> case? Maybe this is related to isolation between the PVM and GVM when
>>> sharing a device, but it's not clear to me that isolation is actually
>>> enforced, so then I see no need for out of band keyslot manager
>>> operations.
>>>
>>> Stefan
>>
>> For ICE based disk encryption (like File-Based Encryption), keyslot manager
>> (implemeneted in blk-crypot-profile.c in latest kernel version) is responsible
>> for forwarding blk-crypto-key from block layer to the bottom layer (i.e.
>> storage driver in Bare Metal) implementing blk_crypto_ll_ops for the key
>> programming/eviction/derivation. 
>>
>> So, for a whole inline encryption support in virtio block, virtio block device
>> must register a keyslot manager and provide the corresponding implementation of
>> blk_crypto_ll_ops. 
>>
>> The reasons of using out-of-band channel are
>>   1. In Bare Metal, the operation of key programming/eviction/derivation is also
>>      through a out-of-band channel.
>>      keyslot manager -> storage driver -> scm driver -> Trust Zone
>>   2. Challenges of using in-band channel
>>      a. Passing the blk-crypot-key to virtio blk backend in userspace through the
>>         virtqueue. The virtio blk backend need pass this blk-crypot-key to block
>>         layer of PVM/Host. But it's not easy to be implemented. Addtional changes
>>         (like adding SET_BLK_CRYPTO_KEY blk ioctl syscal) need to be added in block
>>         layer. In additiona, virtio block backend uses pread/pwrite implementing
>>         I/O in backend, it must ensure that blk-crypto-key is always bound to its
>>         corresponded I/O operation.
>>      b. For key eviction operation, it's totally irrelevant to I/O operation, the
>>         block layer only pass the blk crypto key to virtio block device via keyslot
>>         manager. Even refer to virtblk_get_id to send this request to virtio blk
>>         backend, it faces on similar issue like programming key, that how to populate
>>         blk-crypto-key to the block layer in PVM. Adding EVICT_KEY ioctl seems not a
>>         acceptable way as it exposes key evivtion operation to the userspace.
> 
> Would you be able to post a slide deck that illustrates:
> 
> 1. The bare metal architecture with a UFS ICE device, TrustZone, the
>    kernel (block layer, file systems, etc), userspace applications doing
>    I/O, etc.
> 
> 2. The modified architecture with a virtio-blk ICE device with a virtual
>    machine monitor running in host userspace (i.e. QEMU), the emulated
>    virtio-blk device, PVM/GVM, etc.
> 
> If there is already existing documentation that shows the big picture,
> that would be great. Otherwise it would help if you could draw the
> diagrams.
> 
> I need to understand the architecture in order to review this further.
> 
> Thanks,
> Stefan

--------------W9Tz7LbUDoal3ilRg8rEju7G
Content-Type: application/vnd.openxmlformats-officedocument.presentationml.presentation;
 name="FBE_virtualization_proposal.pptx"
Content-Disposition: attachment; filename="FBE_virtualization_proposal.pptx"
Content-Transfer-Encoding: base64

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
gcl+Eg/5rxR+71jgxQRi9jWofY84CGi+PEWLMlrAdBY4keWy8gm9xsBxSlAUJ3IPTlTvJNE0
euNSzuiUYVmQxE/ZuvRjhxipPrmrrtp0UO8dlBpjRBRMb0SQVYqk+UlCz5tsa7eyqnCnRIfg
ShloHuPDqG9rNEkwPW1r13MD6gEfVIAafnh7QDo7jGj2gL7uc7S7Z0LVpTqZXh0QU63ymFu/
33Xtgdc3+pbjG86w2zF6vts2/HbLcQZ9rzdojeQxt9xy7h5zg5u7HXPL6S1hOY3VYXzLLE+6
6Y8mVsu2Oq5ZH2jUx9lW3MrjbOUh+yBhv+P83VypBgYThA3UrVyeodOkKxIpO/T7PwAAAP//
AwBQSwMEFAAGAAgAAAAhAM2KSaniUAAAPikDABUAAABwcHQvc2xpZGVzL3NsaWRlMy54bWzs
fVuT20aW5vtG7H9A6GGjd2KzlfeLtu2JvMHtaHe3w1K7Z/bFwWJRKo5YZA1JyZIn5r9vJm4E
SIAEi3WBZJjdKhBMJhMnz/nONTP/9K+fbhfJx9l6M18tv3mB/ghfJLPldHU9X7775sU/3qRA
vkg228nyerJYLWffvPg827z412//5//4092rzeI6Cd9ebl5Nvnlxs93evXr5cjO9md1ONn9c
3c2W4bO3q/XtZBvert+9vF5Pfg293i5eYgj5y9vJfPmi+P66z/dXb9/OpzO3mn64nS23eSfr
2WKyDSPf3MzvNmVvd316u1vPNqGb7NuNIX0bnmz6enEd/27u3qxns3i1/Pjd+u713Y/r7OO/
ffxxncyvA71eJMvJbSBL+Nrk1ezT9ofNtrhKPqzn37z4rzTFhvmUgjRcAQoNBcZTBVJMpMci
tZjw/47fRvzVdD3LxvN9RVfED57ldj5drzart9s/Tle3BVFK2obHQLSgbBzef2nhMFJSAiS5
A5pADzBREljmGKQCO2vRf794+e2fXmZjLv9mT/GyeNDiiYvnf5lTI7t4uUeXd+Xl5NWnt+vb
+DeML/n0zYvAVZ/jvy9L4kzzm9Pd3enN31vaTm98S+uX5Q+8rP1oGOWn5eu7fHw2Xu7PloLl
dNnVcjmbblfrV4lfXK1+TaQa6AwKT4xGyAPNpQcWMgQQif8giZBLoTPc9pzBiiaTnFI/rKbv
N/k01j9tTm/t9qY2t8l6tQ3sDyWM/2W0K6aaIAYlwtkkEiwIxLg57VgpJCXPpxNxqYLoNSZ1
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
DM64JphT8w04m8sscq95l53AawKfCXzGBT4dkc18tGVshbVGwo0uyhVKo8wim2UCJTYiqbAR
s9k3cMpuvkIiDQyvCXwm8BkX+FShzT+7JzjjY41qjlSUwKVIZImKEbdaooww9+2YWBKlDIt0
xNfYfcZDWqXmPOIOLcsxlpuiHuBZrter3X2n4HTWx86LNZC8OjvI/35zPbB0OYbXS2T7+67L
ck+IdHFE6gh45mMNeGbcmIxhhTJIbUhSipFMohRh7AArjqggnIwVlgyuLri3An8M8ahUpeB9
ojXUQKQzjJzvAxomu+35KLnZbiqMrPCxwsYKF18fE2GdRm5lZaviw8cImb//uCawGJfzHzfx
/vd8FDfbzSFaf9j88OZq7jT6DFa5e2q/PGwWeR0m3/kiXt4U735ZHIrHVD6h+qfRTS5rPXTF
p9fLm18LeGkIAUjTshKDw6du74gDzc3s8Hm3vJkvHKJE+9V8/Wa2m2+29+5XTHGMnQy7n+XL
GZW71WFxm83vVmufcXq2uJ3v75f5DP13lGMCLPBsKjhGJ46FcAzYVHCMTRwL4RiwqeAYnzgW
wjFgU8ExMXEshGPApoJjcuJYCMeATQXH1MSxEI4BmwqO6YljIRwDNhUcMxPHQjgGbPLva+Zs
bvgC/+7m+x9z5rk3v+Zv3J/kP1cbZ/37eqLznKluZK7n9/Ord18KbwbY7wdPfeo55NM8ftz1
WNZgyre5TeqbmTrFRZ/g1YN7TO8/5Tugq4d3X6q3mZtG9ctPbv9SbJKujvsI/+T9P46Zvz/c
re62/1x5PtZcKI6Dhx/rv98DC4F/V57X+b8P5Tbp/rBf/b6E397l7wrfn/9ws93fzderL8t/
9/smx+K126Plv1yv9oe8GMmpnfpTdo/Lm5vlAvZ93gfQklvrxnO1XzUkN8OilFnMQiV37xl6
+CuH3/x+s8niMK42+PCU+b78DP+NtqZY876dJ0dEj0KQghDvtBxdCP+OnOz3XLofH/a7d7n3
snqz+fg3eNv2ZJoqqORv++3DbkbHeraCsbKWpQzxjEWIW0uQ0tggGhsaYSIiE4cGlFSMmHv2
tFyZ97slgHfNjVnjXN2TWWvO+wnxZ2IpDPEuTU6M0zOtFDJUU5EfiIDP07/PP1/c/lwd1Pia
lxRunxafpeVRjdLFUY0qEzX4AZQiUbpe+xzbpjppA79R7mCa0bEe80tsJWE4RSbNDNJMJyiR
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
5y118i1i90uOaxbxQ8H4axbxy3P7tlnET/3jtlnEbxMHbLOIH4fTNov4tdK5ZRbx88bMZRbx
u5QSB3Jd4kLaSZyInMSN9CNxJP1KXIkeibPPdl6zSNw1aZZvkThclpRvkbjsc7iZKnE6yCdY
lbit0D5YlTheOT5Ylbi+nzFSlTjf0mCUen5FpKZNHaWuSY3UxC6Dj0RqYqfk4LGa2G1++7Ga
2NGH55HYNe35sZrYOe35WE3sfnh4rCZ+SI+O1cQvMi/FTzJPxW8yb8WPMo/FrzKvxc8yz+0N
A3Ejz/trrQKxJq8D5roA3t7eyn8XUwKsYDPXxwMHDnxkrsnDjDVV1uAnjPXPfARxO2f5mFub
XowR8swxEGTAPK9loDsMcn/CPfQZ8XdHgKHPz+BjrPnO9VnAfahu/bnqov8lxjijLoe0l+fN
C8bzRo4mxtgFijFa817RQ/QmcdmP8XelaR/R6e9mqzBDh9hHbH+F0ZIx0ODgpsN5eDvbtHTh
KUOuJnfWpgS5mkobJ2oxTDlkOSxBDhU0QC65KJbrU4JclNLHiaEMU+59lhtZgtz7ykgXTLm5
LDetBLm5yjQDcS655SyXWILcciXRBVMumeUySpBLVjKcWK/sc8ltUnQfFie3Sbnigim3XtF9
WLy+moqOWor7+MSHxY8PFRPu9hQfFm/PKEXHUJec+E9QvP8K/0y5oYqus/h4KdToHp8yxuLj
s3CEplwtRfdh8fPBtOh6l5z4TnxY/Pwr9KApt8/wYXFyerToMOUkNksaX2F0Fo4vzvBhcXLm
bBCYcjL3SvJf4ewr9J/MdfFhcXL6bNdhyslCXlJ8mquLwJSTtUx8WJycvprpMOVk7Sxp/hWu
noXzT/SJD4vXl+GCKz4NHxY/vkQnCArXF7Gn+LB4e05zwd1/Ja2fI93+TDlZO0tar01tcVC4
XsvYxIfFx6c5QnTJydpZ0vPItOY+KHwe/V+ff/Jgl+enxSjFH5IPmLmG+b7t/sx1z1Xc8oUO
bvmCqy59mPmFe95R6f8pzzG5SmN5n43ghKezn/4+W9z7aL9+h6l/vwMPvIe/2vxYO7OF1M02
vlZFGcjG6+Wrv7NK/hfPEFsbxy5W31mQl5fn9INZ1rBOaAIY9ROjk14/0c0pYSSINpstzGYD
S2qq1cJ1S0JCAtdTLTk5OXwO6uzZVdWEhPpqcnKIym3UzMwINSdnqJqXF61ye3X69OncZra6
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
/mBMIB8aJCPz1tTbHFevWjWpVH4Xid8H+apITAGtUIuIRMYIrgju1QYEz63FQOJLxW3qrt8h
X4d8rdRdaCTYrMFiMvIiTpEvDiE126hlpbgtqsKOpmv6Zm76LoFfK8ejml2QvwTN+wwxeJEs
CRlEz8RmMHrC16Xicvikfy3TW/l6UTfz5fPPN59uf/o/AAAA//8DAFBLAwQUAAYACAAAACEA
Xk8KZEABAAAMAgAAFAAAAHBwdC9yZXZpc2lvbkluZm8ueG1sjNFda8MgFAbg+8H+Q/DeeDSf
DU1L0qYw2GX3AyQxrRA1qGs3xv770q+N0V3s8kXO43l1vnxTQ3AQ1kmjS0RDQIHQremk3pXo
ZbvBOQqc57rjg9GiRO/CoeXi8WE+0oRCYcXhSfcmmBTtCl6ivfdjQYhr90JxF5pR6OmsN1Zx
P0W7I53lx0lXA2EAKVFcanSdt/+ZN30vW7E27asS2l8QKwbupwZuL0d3084b3olKttY40/uw
NeqKkdEchR2NPHs0IRQuey1+aj47f0vtIKebA9mV6KOOU9qwusbRqkpwPKMVrtZNimc1VKso
3lRZVH+i4DC9LUQo6HyJGLAUQ4SBbWlcMCgSCCnkiPzlb7LJbyjgLF9XOKYJw3mWUZyn0FCW
VXmafft3PORFnBUsDmOYnXjyu81PPP3h4gsAAP//AwBQSwMECgAAAAAAAAAhAKr7hu4jIwAA
IyMAABcAAABkb2NQcm9wcy90aHVtYm5haWwuanBlZ//Y/+AAEEpGSUYAAQEBAGAAYAAA/9sA
QwADAgIDAgIDAwMDBAMDBAUIBQUEBAUKBwcGCAwKDAwLCgsLDQ4SEA0OEQ4LCxAWEBETFBUV
FQwPFxgWFBgSFBUU/9sAQwEDBAQFBAUJBQUJFA0LDRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU
FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU/8AAEQgAkAEAAwEiAAIRAQMRAf/EAB8AAAEF
AQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUS
ITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZH
SElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqy
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
1lTzEvGb2eNiC1rfWtB6MY3Vj4aYnUL7BQAA//8DAFBLAwQUAAYACAAAACEAhZAaONcAAADO
AQAAIAAAAHBwdC9zbGlkZXMvX3JlbHMvc2xpZGU0LnhtbC5yZWxzrJFBS8QwEIXvgv8hzN2k
XUFENt2LCAuedP0BIZm2YdtJyMyK/ffGg9DCHjx4nDdvvvdg9oeveVKfWDgmstDqBhSSTyHS
YOHj9HL3CIrFUXBTIrSwIMOhu73Zv+HkpB7xGDOrSiG2MIrkJ2PYjzg71ikj1U2fyuykjmUw
2fmzG9DsmubBlDUDug1THYOFcgw7UKcl41/Yqe+jx+fkLzOSXIkwlAT5fYoBK9WVAcWC1it5
bbnXlQ/meq32P2vxT9yrW9JFNr1W+sbU/jYzmy903wAAAP//AwBQSwMEFAAGAAgAAAAhAOzv
xwjXAAAAzgEAACAAAABwcHQvc2xpZGVzL19yZWxzL3NsaWRlNS54bWwucmVsc6yRQUvEMBCF
74L/IczdpF1ERDbdiwgLnnT9ASGZtmHbScjMiv33xoPQwh48eJw3b773YPaHr3lSn1g4JrLQ
6gYUkk8h0mDh4/Ry9wiKxVFwUyK0sCDDobu92b/h5KQe8Rgzq0ohtjCK5Cdj2I84O9YpI9VN
n8rspI5lMNn5sxvQ7JrmwZQ1A7oNUx2DhXIMO1CnJeNf2Knvo8fn5C8zklyJMJQE+X2KASvV
lQHFgtYreW2515UP5nqt9j9r8U/cq1vSRTa9VvrG1P42M5svdN8AAAD//wMAUEsDBBQABgAI
AAAAIQBjXCO0wAAAADcBAAAgAAAAcHB0L3NsaWRlcy9fcmVscy9zbGlkZTYueG1sLnJlbHOM
z71qwzAQB/A90HcQt1eyO4QQLGUpBUOnkD7AIZ1tUVsSOrnEbx+NMXTIeF+/P9dd7sss/iiz
j0FDKxsQFGx0Powafm5f7ycQXDA4nGMgDRsxXMzbobvSjKUe8eQTi6oE1jCVks5KsZ1oQZYx
UaiTIeYFSy3zqBLaXxxJfTTNUeVnA8zOFL3TkHvXgrhtiV6x4zB4S5/RrguF8k+E4tk7+sYt
rqWymEcqGqR87u+WWlkjQJlO7d41DwAAAP//AwBQSwMEFAAGAAgAAAAhAGIls8zXAAAAzgEA
ACAAAABwcHQvc2xpZGVzL19yZWxzL3NsaWRlNy54bWwucmVsc6yRQUvEMBCF74L/IczdpF1Q
RDbdiwgLnnT9ASGZtmHbScjMiv33xoPQwh48eJw3b773YPaHr3lSn1g4JrLQ6gYUkk8h0mDh
4/Ry9wiKxVFwUyK0sCDDobu92b/h5KQe8Rgzq0ohtjCK5Cdj2I84O9YpI9VNn8rspI5lMNn5
sxvQ7JrmwZQ1A7oNUx2DhXIMO1CnJeNf2Knvo8fn5C8zklyJMJQE+X2KASvVlQHFgtYreW25
15UP5nqt9j9r8U/cq1vSRTa9VvrG1P42M5svdN8AAAD//wMAUEsDBBQABgAIAAAAIQCxfF9b
1wAAAM4BAAAgAAAAcHB0L3NsaWRlcy9fcmVscy9zbGlkZTgueG1sLnJlbHOskTFrxDAMhfdC
/4PRXju54SjlnFtK4aBTe/0BxlYSc4llLF1p/n3doZDADR066unpew90OH7Nk/rEwpGShVY3
oDB5CjENFj7OLw+PoFhcCm6ihBYWZDh293eHN5yc1CMeY2ZVKYktjCL5yRj2I86ONWVMddNT
mZ3UsQwmO39xA5pd0+xNWTOg2zDVKVgop7ADdV4y/oVNfR89PpO/zpjkRoRJJMjvUwxYqa4M
KBa0Xslry15XPpjbtdr/rMU/ca9uoatseq30jan9bWY2X+i+AQAA//8DAFBLAwQUAAYACAAA
ACEAtM9YGbkAAAAkAQAALAAAAHBwdC9ub3Rlc01hc3RlcnMvX3JlbHMvbm90ZXNNYXN0ZXIx
LnhtbC5yZWxzjM/BCsIwDAbgu+A7lNxttx1EZO0uIuwq8wFKl3XFrS1tFff2FnZx4MFLIAn/
F1I373kiLwzROMuhpAUQtMr1xmoO9+56OAGJSdpeTs4ihwUjNGK/q284yZRDcTQ+kqzYyGFM
yZ8Zi2rEWUbqPNq8GVyYZcpt0MxL9ZAaWVUURxa+DRAbk7Q9h9D2JZBu8fiP7YbBKLw49ZzR
ph8nWMpZzKAMGhMHStfJWiuaPWCiZpvfxAcAAP//AwBQSwMEFAAGAAgAAAAhANXRkvG8AAAA
NwEAACwAAABwcHQvc2xpZGVMYXlvdXRzL19yZWxzL3NsaWRlTGF5b3V0MS54bWwucmVsc4zP
vQrCMBAH8F3wHcLtJq2DiDR1EcHBRfQBjuTaBtsk5KLo25vRgoPjff3+XLN/TaN4UmIXvIZa
ViDIm2Cd7zXcrsfVFgRn9BbH4EnDmxj27XLRXGjEXI54cJFFUTxrGHKOO6XYDDQhyxDJl0kX
0oS5lKlXEc0de1Lrqtqo9G1AOzPFyWpIJ1uDuL4j/WOHrnOGDsE8JvL5R4Ti0Vk6I2dKhcXU
U9Yg5Xd/tlTLEgGqbdTs3fYDAAD//wMAUEsDBBQABgAIAAAAIQDV0ZLxvAAAADcBAAAsAAAA
cHB0L3NsaWRlTGF5b3V0cy9fcmVscy9zbGlkZUxheW91dDIueG1sLnJlbHOMz70KwjAQB/Bd
8B3C7Satg4g0dRHBwUX0AY7k2gbbJOSi6Nub0YKD4339/lyzf02jeFJiF7yGWlYgyJtgne81
3K7H1RYEZ/QWx+BJw5sY9u1y0VxoxFyOeHCRRVE8axhyjjul2Aw0IcsQyZdJF9KEuZSpVxHN
HXtS66raqPRtQDszxclqSCdbg7i+I/1jh65zhg7BPCby+UeE4tFZOiNnSoXF1FPWIOV3f7ZU
yxIBqm3U7N32AwAA//8DAFBLAwQUAAYACAAAACEASq91OdIAAAC/AQAAKgAAAHBwdC9ub3Rl
c1NsaWRlcy9fcmVscy9ub3Rlc1NsaWRlMS54bWwucmVsc6yQsWoDMQyG90LfwWiPfZchlBJf
llLIkKWkD2Bs3Z3JnWwsJSRvX0NLyUGGDh31S/r0oe3uOk/qgoVjIgutbkAh+RQiDRY+j++r
F1AsjoKbEqGFGzLsuuen7QdOTuoSjzGzqhRiC6NIfjWG/YizY50yUu30qcxOalkGk50/uQHN
umk2ptwzoFsw1T5YKPuwBnW8ZfwLO/V99PiW/HlGkgcnDE8xYAW6MqBY0Po7+Wm0ugLBPPZo
/9ODkiAfHAuWhc1dvhj6NTOLt3dfAAAA//8DAFBLAwQUAAYACAAAACEAmfaZrtMAAAC/AQAA
KgAAAHBwdC9ub3Rlc1NsaWRlcy9fcmVscy9ub3Rlc1NsaWRlMi54bWwucmVsc6yQwWrDMAyG
74O9g9F9dpLDGKNOL2PQQy+lewBhK4lpYhtLG+3b17ANGuhhhx31S/r0oc32vMzqiwqHFC20
ugFF0SUf4mjh4/j+9AKKBaPHOUWycCGGbf/4sDnQjFKXeAqZVaVEtjCJ5Fdj2E20IOuUKdbO
kMqCUssymozuhCOZrmmeTbllQL9iqp23UHa+A3W8ZPoLOw1DcPSW3OdCUe6cMDwHTxWIZSSx
oPV38tPodAWCue/R/qdHTEK8RxYqK5ubfDXU/pqZ1dv7KwAAAP//AwBQSwMEFAAGAAgAAAAh
AH5DMFrTAAAAvwEAACoAAABwcHQvbm90ZXNTbGlkZXMvX3JlbHMvbm90ZXNTbGlkZTMueG1s
LnJlbHOskMFqwzAMhu+DvYPRfXZSyhijTi+j0EMvpXsAYyuJWSIbSx3r29ewDRroYYcd9Uv6
9KHN9mue1CcWjokstLoBheRTiDRYeD/tnl5AsTgKbkqEFi7IsO0eHzZHnJzUJR5jZlUpxBZG
kfxqDPsRZ8c6ZaTa6VOZndSyDCY7/+EGNKumeTbllgHdgqn2wULZhxWo0yXjX9ip76PHt+TP
M5LcOWF4igEr0JUBxYLW38lPY60rEMx9j/Y/PSgJ8sGxYFnY3OSLofbXzCze3l0BAAD//wMA
UEsDBBQABgAIAAAAIQDwiUSe0wAAAL8BAAAqAAAAcHB0L25vdGVzU2xpZGVzL19yZWxzL25v
dGVzU2xpZGU0LnhtbC5yZWxzrJDBasMwDIbvg72D0X12UugYo04vo9BDL6V7AGMriVkiG0sd
69vXsA0a6GGHHfVL+vShzfZrntQnFo6JLLS6AYXkU4g0WHg/7Z5eQLE4Cm5KhBYuyLDtHh82
R5yc1CUeY2ZVKcQWRpH8agz7EWfHOmWk2ulTmZ3UsgwmO//hBjSrpnk25ZYB3YKp9sFC2YcV
qNMl41/Yqe+jx7fkzzOS3DlheIoBK9CVAcWC1t/JT2OtKxDMfY/2Pz0oCfLBsWBZ2Nzki6H2
18ws3t5dAQAA//8DAFBLAwQUAAYACAAAACEArRrczdMAAAC/AQAAKgAAAHBwdC9ub3Rlc1Ns
aWRlcy9fcmVscy9ub3Rlc1NsaWRlNS54bWwucmVsc6yQsWoDMQyG90LfwWivfZchLSW+LCWQ
IUtIH8DYujvTO9lYSmnePoa2kIMMHTrql/TpQ5vt1zypTywcE1lodQMKyacQabDwfto9vYBi
cRTclAgtXJBh2z0+bI44OalLPMbMqlKILYwi+dUY9iPOjnXKSLXTpzI7qWUZTHb+ww1oVk2z
NuWWAd2CqfbBQtmHFajTJeNf2Knvo8e35M8zktw5YXiKASvQlQHFgtbfyU/jWVcgmPse7X96
UBLkg2PBsrC5yRdD7a+ZWby9uwIAAP//AwBQSwMEFAAGAAgAAAAhAPEuEmjTAAAAvwEAACoA
AABwcHQvbm90ZXNTbGlkZXMvX3JlbHMvbm90ZXNTbGlkZTYueG1sLnJlbHOskLFqAzEMhvdA
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
cHQvdGhlbWUvdGhlbWUxLnhtbFBLAQItABQABgAIAAAAIQA/hbhxIgIAACgLAAATAAAAAAAA
AAAAAAAAAALKAABwcHQvdGFibGVTdHlsZXMueG1sUEsBAi0AFAAGAAgAAAAhACl4uOTHAwAA
1gsAACEAAAAAAAAAAAAAAAAAVcwAAHBwdC9zbGlkZUxheW91dHMvc2xpZGVMYXlvdXQxLnht
bFBLAQItABQABgAIAAAAIQA2dlR1RAQAAEIPAAAhAAAAAAAAAAAAAAAAAFvQAABwcHQvc2xp
ZGVMYXlvdXRzL3NsaWRlTGF5b3V0Mi54bWxQSwECLQAUAAYACAAAACEAe0O8XcQGAADPIAAA
FAAAAAAAAAAAAAAAAADe1AAAcHB0L3RoZW1lL3RoZW1lMi54bWxQSwECLQAUAAYACAAAACEA
cCwNT7YGAAC9FgAAHwAAAAAAAAAAAAAAAADU2wAAcHB0L25vdGVzU2xpZGVzL25vdGVzU2xp
ZGUxLnhtbFBLAQItABQABgAIAAAAIQB0t26wZREAAMgpAAAUAAAAAAAAAAAAAAAAAMfiAABw
cHQvbWVkaWEvaW1hZ2UxLmVtZlBLAQItABQABgAIAAAAIQAyQL7NZhEAAMgpAAAUAAAAAAAA
AAAAAAAAAF70AABwcHQvbWVkaWEvaW1hZ2UyLmVtZlBLAQItABQABgAIAAAAIQAV5pfxZBEA
AMgpAAAUAAAAAAAAAAAAAAAAAPYFAQBwcHQvbWVkaWEvaW1hZ2UzLmVtZlBLAQItABQABgAI
AAAAIQDgYB5MYxEAAMgpAAAUAAAAAAAAAAAAAAAAAIwXAQBwcHQvbWVkaWEvaW1hZ2U0LmVt
ZlBLAQItABQABgAIAAAAIQAGF+EntwYAALwWAAAfAAAAAAAAAAAAAAAAACEpAQBwcHQvbm90
ZXNTbGlkZXMvbm90ZXNTbGlkZTIueG1sUEsBAi0AFAAGAAgAAAAhAKP4+6pjAwAAywkAAB8A
AAAAAAAAAAAAAAAAFTABAHBwdC9ub3Rlc1NsaWRlcy9ub3Rlc1NsaWRlMy54bWxQSwECLQAU
AAYACAAAACEAyIOFR2MDAADLCQAAHwAAAAAAAAAAAAAAAAC1MwEAcHB0L25vdGVzU2xpZGVz
L25vdGVzU2xpZGU0LnhtbFBLAQItABQABgAIAAAAIQDAtriAYQMAAMsJAAAfAAAAAAAAAAAA
AAAAAFU3AQBwcHQvbm90ZXNTbGlkZXMvbm90ZXNTbGlkZTUueG1sUEsBAi0AFAAGAAgAAAAh
AO22amphAwAAywkAAB8AAAAAAAAAAAAAAAAA8zoBAHBwdC9ub3Rlc1NsaWRlcy9ub3Rlc1Ns
aWRlNi54bWxQSwECLQAUAAYACAAAACEAuiFMR0IPAADDggAAIQAAAAAAAAAAAAAAAACRPgEA
cHB0L2NoYW5nZXNJbmZvcy9jaGFuZ2VzSW5mbzEueG1sUEsBAi0AFAAGAAgAAAAhAF5PCmRA
AQAADAIAABQAAAAAAAAAAAAAAAAAEk4BAHBwdC9yZXZpc2lvbkluZm8ueG1sUEsBAi0ACgAA
AAAAAAAhAKr7hu4jIwAAIyMAABcAAAAAAAAAAAAAAAAAhE8BAGRvY1Byb3BzL3RodW1ibmFp
bC5qcGVnUEsBAi0AFAAGAAgAAAAhAGQ2rn9nAQAAsQIAABEAAAAAAAAAAAAAAAAA3HIBAGRv
Y1Byb3BzL2NvcmUueG1sUEsBAi0AFAAGAAgAAAAhAGnLjOg+AgAAaAYAABAAAAAAAAAAAAAA
AAAAcnQBAGRvY1Byb3BzL2FwcC54bWxQSwECLQAUAAYACAAAACEASXo8fOoAAAAzAQAAGQAA
AAAAAAAAAAAAAADedgEAZG9jTWV0YWRhdGEvTGFiZWxJbmZvLnhtbFBLAQItABQABgAIAAAA
IQBxWn/XMwEAAHQDAAALAAAAAAAAAAAAAAAAAP93AQBfcmVscy8ucmVsc1BLAQItABQABgAI
AAAAIQAeWo0TlQEAAK8JAAAfAAAAAAAAAAAAAAAAAFt5AQBwcHQvX3JlbHMvcHJlc2VudGF0
aW9uLnhtbC5yZWxzUEsBAi0AFAAGAAgAAAAhANFgZavcAAAAWAIAACwAAAAAAAAAAAAAAAAA
LXsBAHBwdC9zbGlkZU1hc3RlcnMvX3JlbHMvc2xpZGVNYXN0ZXIxLnhtbC5yZWxzUEsBAi0A
FAAGAAgAAAAhANGSThkAAQAA6gMAACAAAAAAAAAAAAAAAAAAU3wBAHBwdC9zbGlkZXMvX3Jl
bHMvc2xpZGUxLnhtbC5yZWxzUEsBAi0AFAAGAAgAAAAhACPzcKTWAAAAzgEAACAAAAAAAAAA
AAAAAAAAkX0BAHBwdC9zbGlkZXMvX3JlbHMvc2xpZGUyLnhtbC5yZWxzUEsBAi0AFAAGAAgA
AAAhAPBu8fLuAAAAUwMAACAAAAAAAAAAAAAAAAAApX4BAHBwdC9zbGlkZXMvX3JlbHMvc2xp
ZGUzLnhtbC5yZWxzUEsBAi0AFAAGAAgAAAAhAIWQGjjXAAAAzgEAACAAAAAAAAAAAAAAAAAA
0X8BAHBwdC9zbGlkZXMvX3JlbHMvc2xpZGU0LnhtbC5yZWxzUEsBAi0AFAAGAAgAAAAhAOzv
xwjXAAAAzgEAACAAAAAAAAAAAAAAAAAA5oABAHBwdC9zbGlkZXMvX3JlbHMvc2xpZGU1Lnht
bC5yZWxzUEsBAi0AFAAGAAgAAAAhAGNcI7TAAAAANwEAACAAAAAAAAAAAAAAAAAA+4EBAHBw
dC9zbGlkZXMvX3JlbHMvc2xpZGU2LnhtbC5yZWxzUEsBAi0AFAAGAAgAAAAhAGIls8zXAAAA
zgEAACAAAAAAAAAAAAAAAAAA+YIBAHBwdC9zbGlkZXMvX3JlbHMvc2xpZGU3LnhtbC5yZWxz
UEsBAi0AFAAGAAgAAAAhALF8X1vXAAAAzgEAACAAAAAAAAAAAAAAAAAADoQBAHBwdC9zbGlk
ZXMvX3JlbHMvc2xpZGU4LnhtbC5yZWxzUEsBAi0AFAAGAAgAAAAhALTPWBm5AAAAJAEAACwA
AAAAAAAAAAAAAAAAI4UBAHBwdC9ub3Rlc01hc3RlcnMvX3JlbHMvbm90ZXNNYXN0ZXIxLnht
bC5yZWxzUEsBAi0AFAAGAAgAAAAhANXRkvG8AAAANwEAACwAAAAAAAAAAAAAAAAAJoYBAHBw
dC9zbGlkZUxheW91dHMvX3JlbHMvc2xpZGVMYXlvdXQxLnhtbC5yZWxzUEsBAi0AFAAGAAgA
AAAhANXRkvG8AAAANwEAACwAAAAAAAAAAAAAAAAALIcBAHBwdC9zbGlkZUxheW91dHMvX3Jl
bHMvc2xpZGVMYXlvdXQyLnhtbC5yZWxzUEsBAi0AFAAGAAgAAAAhAEqvdTnSAAAAvwEAACoA
AAAAAAAAAAAAAAAAMogBAHBwdC9ub3Rlc1NsaWRlcy9fcmVscy9ub3Rlc1NsaWRlMS54bWwu
cmVsc1BLAQItABQABgAIAAAAIQCZ9pmu0wAAAL8BAAAqAAAAAAAAAAAAAAAAAEyJAQBwcHQv
bm90ZXNTbGlkZXMvX3JlbHMvbm90ZXNTbGlkZTIueG1sLnJlbHNQSwECLQAUAAYACAAAACEA
fkMwWtMAAAC/AQAAKgAAAAAAAAAAAAAAAABnigEAcHB0L25vdGVzU2xpZGVzL19yZWxzL25v
dGVzU2xpZGUzLnhtbC5yZWxzUEsBAi0AFAAGAAgAAAAhAPCJRJ7TAAAAvwEAACoAAAAAAAAA
AAAAAAAAgosBAHBwdC9ub3Rlc1NsaWRlcy9fcmVscy9ub3Rlc1NsaWRlNC54bWwucmVsc1BL
AQItABQABgAIAAAAIQCtGtzN0wAAAL8BAAAqAAAAAAAAAAAAAAAAAJ2MAQBwcHQvbm90ZXNT
bGlkZXMvX3JlbHMvbm90ZXNTbGlkZTUueG1sLnJlbHNQSwECLQAUAAYACAAAACEA8S4SaNMA
AAC/AQAAKgAAAAAAAAAAAAAAAAC4jQEAcHB0L25vdGVzU2xpZGVzL19yZWxzL25vdGVzU2xp
ZGU2LnhtbC5yZWxzUEsBAi0AFAAGAAgAAAAhALRAqt5JAgAAGhEAABMAAAAAAAAAAAAAAAAA
044BAFtDb250ZW50X1R5cGVzXS54bWxQSwUGAAAAADgAOAA8EAAATZEBAAAA

--------------W9Tz7LbUDoal3ilRg8rEju7G--
