Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8042537DE9E
	for <virtio-dev@lists.linux.dev>; Wed, 15 Apr 2026 11:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776253758; cv=none; b=qkyhnLybjlQPZTmSNkNExnwcwX/q5cv8TDMKwCPrwE7yG94KBLvst1q1xUua2E8UYJGYahgrlrDvbdvFUMivu7aB6WShXS4Tiwwfw+W1bX17UqRKeKtaRzBTF/s3qKMFUpCez28rVU8VHaadXO8B6wYc6/jmzrgek/+m1DH/X1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776253758; c=relaxed/simple;
	bh=QFoHzI4229TgKCdPIuvfUx+IFE9RheRZe93od2jb37w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pe7KOGhIN2gWdI3KIUTsGSyfNXQy246hUoolrGdfLafoTOK7TQE3PRutFk3sbQACUIyTsirCrV944ZZT1GUqjHUoHrRiTtjABOVBv/v/T1rQf092RSwF9Sq/ZQc/jKtwD7ZOS3inZ9wHLsPTTr2HKqLazvJKKXj8XmmuI8j4InA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Uas0sfCw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FClr+qmq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Uas0sfCw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FClr+qmq"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F8lApM731084
	for <virtio-dev@lists.linux.dev>; Wed, 15 Apr 2026 11:49:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jqp+2QqC8vHiBc7zWWVoEK3Y4sUeuCHMKPm0k9sR0bc=; b=Uas0sfCwlKdXiTbU
	eoDPmORWltL7W149VAT9j8MdVUGJjEhMRJpndfX/SMPu2Kj7+x9BS/EdwzRtzb2E
	1QyHlaEi7Yo0F9USGXw+RsQdYi9T1zaIqcDoejVCufdlg2+5ZB+T+fw58Y6UJjhO
	L29oIxkmumzR/8/fHgqHj8ivvRV2uHqpp/mpj853ybP1oiVR4rbsljyP1zsa8VgC
	ywDCz00VZmzz1rbQzLFhTxx4On0bAeiqNE+s1ngiUAI2gfNfFr2hppRTYWbvY+P3
	80DZFNFxfe4gLqJsjWmKg0TT8WRjTpBEZ3mTgRMvKep+o5Syh1ZiWH+4bXdAOgoh
	OkWwJw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dhruubksc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Wed, 15 Apr 2026 11:49:09 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2d8c521be48so2195574eec.1
        for <virtio-dev@lists.linux.dev>; Wed, 15 Apr 2026 04:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776253748; x=1776858548; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jqp+2QqC8vHiBc7zWWVoEK3Y4sUeuCHMKPm0k9sR0bc=;
        b=FClr+qmq2G10OpEd3i/fyvc7Hg518BH2bO6BjGXfORJHjgUAlPYTE1GD7zw4EFrCzL
         SU/TdInYI8xc5Db1bavT4esN8XBb3bHwli4/0Hw+VSO9yEQt97EG6qRLdww8da66UaNf
         4f1r5iDAXDRGcdUY5Zcb+Hz5Y6oxIxvb/+nSlKkYkWmTfE8jFv8iGlPcibps/kHJJ2wS
         YCsgbI3+DBhc1IAyN5cktrrzvB0/ofDZwblppnKH2GZPKcoAtFd4CJYkAXu9Y9i2/aax
         389iv6IJkIVz+a0ePH4MPuxZushzB8zibWtRFEvSK9/KSu/icoNqYYDEL+htkl0XN04A
         9+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776253748; x=1776858548;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jqp+2QqC8vHiBc7zWWVoEK3Y4sUeuCHMKPm0k9sR0bc=;
        b=VnIHsT5fFiuw6c/5ZFv+4WSmjoIhDpoJ9W/xXQ/odHttbxXccSFo75GQNBa8ewNyTq
         xd/kbnJzhJqreo8GEfuP2dX8AS8KIf2Rc8Z0FMI7geMNaYuFSjns/PHsPxpYXltJw4WF
         2K7sD313UTlK9rFNu0ZAu5RlCM2RrLC/nCe4Lx0CUpQ5QYp4uGY5m+QknmqkaZa5eu02
         aX9xBicix1YAzR4lqqQ6pRA6F8s3sWlIDGgM9FMto45aM5xOtwltcCzxKSRbV1y1XPDM
         6ipLfgo4TjB5EsDuP/lWuWBV6l0EqxVjB3vzB3R8SNwuqxDrbGSVcyepH83QvlYeuCkq
         diYw==
X-Forwarded-Encrypted: i=1; AFNElJ+HBdbdLDr8CwVkPEzIwSBpopRfEjhTHaIrGeWZNnfVCnqaKrxvUo8azfEBAQfE5kdvk0fvnky281in@lists.linux.dev
X-Gm-Message-State: AOJu0YxrLuhGE+X6vYf0gbvhScuB4Dixdouqwj0Dnw4n+ZkNqCf6b/AE
	i+r8dRONvTcPs+ro+EnOoxfJqr7Vt4hfFswinKcQy02EEQMck9cigwYzfYHnvnKpVUC6S2SSP40
	rXRxbs6WfcwjsyFPbx7VV5Ro847faALbhUxK29SRbrNo54aJ0C0Wr36rDgorADx7F
X-Gm-Gg: AeBDievo//so5mz64klY+I/swoQFK8ILVMr2Mgvc1vgV0ojajX7pioPmdUOgtFjWJSU
	a6dRtpadAjI/kSCc9xqdlu9AC7gSEMX+c9SjviawAUIg8q5wzq5d8bd09nCmsUSLFDHpXBkRYON
	F83cqa6vTdkEtupTe17WOKyCvfXcE7uNExOUl10nZuWcTRNSpBHJ9vgK+oKFPxzI0IarkmDsfyq
	saIhccSdmbXtwZYFzeJqXVnCugYdBgRcW1OwapJ2a/AMR5oV9HfmpE5sMw5QbAQN/YKYFbMefky
	SVG+CryRuG8QWhoqFmSmBGO6heG3B5SkXwfcU9V23FDcrWg5MiRZmpPcyDKWrjp/yy92RXDY/sY
	RGyFC1MXVOrKoq38VRWmsE5OKhD+9jZRZivlBnSPVWjDjm86TUwIdMlv4Yv3dunGy03vZ/uJHJp
	rGZnA=
X-Received: by 2002:a05:7022:b8c:b0:119:e569:f86d with SMTP id a92af1059eb24-12c352e2a15mr9117434c88.10.1776253747542;
        Wed, 15 Apr 2026 04:49:07 -0700 (PDT)
X-Received: by 2002:a05:7022:b8c:b0:119:e569:f86d with SMTP id a92af1059eb24-12c352e2a15mr9117408c88.10.1776253746449;
        Wed, 15 Apr 2026 04:49:06 -0700 (PDT)
Received: from [10.110.104.16] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c5e63f61csm1502163c88.8.2026.04.15.04.49.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 04:49:06 -0700 (PDT)
Message-ID: <094ef4db-3098-4f34-a0b8-a8149464dda8@oss.qualcomm.com>
Date: Wed, 15 Apr 2026 19:49:01 +0800
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] virtio-blk: Add inline encryption support
To: Stefan Hajnoczi <stefanha@redhat.com>, Eric Biggers <ebiggers@kernel.org>
Cc: Sebastian Mauritsson <sma@napatech.com>, virtio-dev@lists.linux.dev,
        quic_dshaikhu@quicinc.com, neeraj.soni@oss.qualcomm.com,
        Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>
References: <20260210083208.472824-1-linlin.zhang@oss.qualcomm.com>
 <20260210083208.472824-2-linlin.zhang@oss.qualcomm.com>
 <20260210211842.GA158755@fedora>
 <fa458358-90c8-408c-a860-8bfdb11658bb@oss.qualcomm.com>
 <20260218215336.GD605390@fedora>
 <bca448cf-6c18-4c82-806d-f2a25579a02b@oss.qualcomm.com>
 <20260225095502.GB1653802@fedora>
 <22632a98-3d10-4c71-b579-d7aaefe8553d@oss.qualcomm.com>
 <20260301045516.GB42492@fedora>
 <112986be-3f22-45fe-ac68-6a2c172f629b@oss.qualcomm.com>
 <20260330153230.GD154632@fedora>
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <20260330153230.GD154632@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: bnBmv6XQ1WZxAibWNZeaQHiNmtR_gGpv
X-Authority-Analysis: v=2.4 cv=dpfrzVg4 c=1 sm=1 tr=0 ts=69df7b35 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=20KFwNOVAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=7CBlvi-ZfiA1nSr6UYAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDEwOSBTYWx0ZWRfX1o0uGIsHCBIM
 WEec6QDtmdEm0P44kagnmAtwcPwGuclRvQ47/UBeffEzmrJvTiTn/9bqiqP9ilr1g3gFS9/+Ouq
 0WIkMB0Upz6Yieu9AbQHyYnU97y6uVU0sYFWmAAuIrZkwFrJZIfvVui8I9bZ7scMFwbaVdMiZcv
 0i0WFD7iuOlHG1GwnHDXj03gOVZap04aXYeciPso9S6SLd2P4cp4IG8fAhrebk5/i2Yi6Vxs6Bl
 oK40yTSEzGkJ81L5w6NmbdHC0XIKkMnti0T+C/gTjNcH9NULZj9E4RtoIkao4xgqcPWaKQGnZCd
 JfMgaa/Hh8IHGloiH2Qn4hjvzIl25gPQtoes/WZHGkWo23eZNiU68l8pnfz+EG2yv+pvFszc+9Y
 RUvp/2a2ASimR0VOHAAEHR53Qh/RVjv/SzGZAlxpSs6Jr0E7EV4Vbgv9ceFhZKStp+0u5hcN8iH
 1khjR5L4ZutPJ+yzylw==
X-Proofpoint-GUID: bnBmv6XQ1WZxAibWNZeaQHiNmtR_gGpv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150109

Hello Stefan,

Thanks for your review in detail.

Only the host or the PVM knows the detail of physical key slots. There isn't
any request notifying TZ ICE driver which physical slots cllocated to which VM.
So TZ ICE driver cannot validate the physical slot from GVM SCM request.
That is also why we pass physical slot from LA GVM to TZ.

virtio block frontend in LA GVM gets the physical slot offset and max-slot
number from the host/PVM, it's the only way to enforce the isolation on
physical slot passed by LA GVM to TZ in current design. If physical slot
offset or max-slot number in LA GVM is temperred, it will lead to the broken
of slots isolation b/w host/PVM and GVM.

Is this the security problem you mentioned even though Linux kernel is
always protected by Android Verified Boot 2.0?

In-band keyslot manager design leaves slight more complex changes in
the kernel of PVM, and both in-band and out-of-band design request
added encrytion info per I/O request.

And I also added Eric in the thread, who is very professional in the
block crypto encryption. For a better understanding and discussion,
I'll post a patch serial which including changes in virtio_blk of GVM
and changes in block layer/storage layers of PVM, and request you review
before this virtio SPEC is approved，ensure the virtio SPEC is consistent
of the final solution.

Appreciate your detail review again!

Regards,
Linlin


On 3/30/2026 11:32 PM, Stefan Hajnoczi wrote:
> On Mon, Mar 02, 2026 at 10:35:13PM +0800, Linlin Zhang wrote:
>>
>> Appreciate your review in detail. I attached the slide <FBE_virtualization_proposal.pptx>. Please have a look and
>> let me know if you have any concern. Thanks!
> 
> Hi Linlin,
> Thanks for the slides. How does the TZ ICE driver validate GVM SCM
> requests to prevent the GVM from performing key operations on physical
> slots that do not belong to the GVM?
> 
> If the TZ ICE driver enforces isolation on the GVM SCM requests, then I
> don't understand why the GVM uses physical slot indices. It could use
> virtual slot indices and then the slot_offset field is not necessary.
> 
> If the TZ ICE driver does not enforce isolation, then there is probably
> security problem with your design.
> 
> For the record, I prefer an in-band keyslot manager design where the
> virtio-blk device provides the commands needed to program keys. That way
> the virtio-blk interface is self-contained and does not depend on an
> additional third-party component that requires extra drivers. It would
> be cleaner to specify the key operations in virtio-blk and let
> implementors decide how to implement them in the device rather than
> exposing that to the (guest) driver.
> 
> The performance argument seems weak because every I/O request involves
> the PVM anyway and keyslot manager operations should be much less
> frequent than I/O requests.
> 
> The security argument of bypassing the PVM doesn't work because the PVM
> can access GVM RAM anyway, so the key cannot be hidden even if the PVM
> is bypassed during key operations.
> 
> I'm just sharing my opinions with you. I'd be happier for the key
> operations to be included in virtio-blk, but I'm not an expert in ICE
> and ultimately I'm fine with your approach as long as the design is
> coherent and secure.
> 
> Stefan
> 
>>
>> Linlin
>>
>> On 3/1/2026 12:55 PM, Stefan Hajnoczi wrote:
>>> On Thu, Feb 26, 2026 at 09:34:01PM +0800, Linlin Zhang wrote:
>>>>
>>>>
>>>> On 2/25/2026 5:55 PM, Stefan Hajnoczi wrote:
>>>>> On Wed, Feb 25, 2026 at 01:33:17PM +0800, Linlin Zhang wrote:
>>>>>>
>>>>>>
>>>>>> On 2/19/2026 5:53 AM, Stefan Hajnoczi wrote:
>>>>>>> On Sat, Feb 14, 2026 at 03:22:21PM +0800, Linlin Zhang wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2/11/2026 5:18 AM, Stefan Hajnoczi wrote:
>>>>>>>>> On Tue, Feb 10, 2026 at 12:32:08AM -0800, Linlin Zhang wrote:
>>>>>>>>>> Inline encryption on virtio block can only be supported when
>>>>>>>>>> the new feature bit VIRTIO_BLK_F_ICE is negotiated.
>>>>>>>>>>
>>>>>>>>>> Extend struct virtio_blk_config and struct virtio_blk_req,
>>>>>>>>>> so that crypto capabilities can be got in the frontend and
>>>>>>>>>> encryption metadata can be sent to the backend, together with
>>>>>>>>>> each I/O transaction.
>>>>>>>>>>
>>>>>>>>>> About the inline encryption on UFS or eMMC storage, please
>>>>>>>>>> refer to the Linux inline encryption documentation:
>>>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/block/inline-encryption.rst
>>>>>>>>>>
>>>>>>>>>> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/238
>>>>>>>>>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>>>>>>>>>> Signed-off-by: linlzhan <quic_linlzhan@quicinc.com>
>>>>>>>>>> Signed-off-by: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
>>>>>>>>>> ---
>>>>>>>>>>  device-types/blk/description.tex | 110 ++++++++++++++++++++++++++++++-
>>>>>>>>>>  1 file changed, 108 insertions(+), 2 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/device-types/blk/description.tex b/device-types/blk/description.tex
>>>>>>>>>> index 2712ada..60f46af 100644
>>>>>>>>>> --- a/device-types/blk/description.tex
>>>>>>>>>> +++ b/device-types/blk/description.tex
>>>>>>>>>> @@ -66,6 +66,11 @@ \subsection{Feature bits}\label{sec:Device Types / Block Device / Feature bits}
>>>>>>>>>>  	(ZNS). For brevity, these standard documents are referred as "ZBD standards"
>>>>>>>>>>  	from this point on in the text.
>>>>>>>>>>  
>>>>>>>>>> +\item[VIRTIO_BLK_F_ICE(22)] Inline Crypto Extensions are supported. Only when this
>>>>>>>>>> +     feature bit is negotiated, the device need expose crypto characteristics in
>>>>>>>>>> +     configuration space and the driver need provide an extended request header
>>>>>>>>>> +     containing a crypto payload for block I/O.
>>>>>>>>>
>>>>>>>>> Most of the feature bit descriptions are brief and the details are
>>>>>>>>> covered later in the spec. I suggest doing this here too:
>>>>>>>>>
>>>>>>>>>   \item[VIRTIO_BLK_F_ICE (22)] Device supports Inline Crypto Engine functionality.
>>>>>>>>>
>>>>>>>>> I changed the name from Inline Crypto Extensions to Inline Crypto Engine
>>>>>>>>> because that terminology is used in the Linux kernel. Web search results
>>>>>>>>> also favor "inline crypto engine" over "inline crypto extensions". Are
>>>>>>>>> you okay with "engine"?
>>>>>>>> Thanks! ACK
>>>>>>>>
>>>>>>>>>
>>>>>>>>>> +
>>>>>>>>>>  \end{description}
>>>>>>>>>>  
>>>>>>>>>>  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Block Device / Feature bits / Legacy Interface: Feature bits}
>>>>>>>>>> @@ -128,6 +133,10 @@ \subsection{Device configuration layout}\label{sec:Device Types / Block Device /
>>>>>>>>>>                  u8 model;
>>>>>>>>>>                  u8 unused2[3];
>>>>>>>>>>          } zoned;
>>>>>>>>>> +        struct virtio_blk_crypto_characteristics {
>>>>>>>>>> +                __virtio16 slot_info;
>>>>>>>>>> +                __virtio16 reserved;
>>>>>>>>>> +        } crypto;
>>>>>>>>>>  };
>>>>>>>>>>  \end{lstlisting}
>>>>>>>>>>  
>>>>>>>>>> @@ -215,6 +224,18 @@ \subsection{Device configuration layout}\label{sec:Device Types / Block Device /
>>>>>>>>>>  terminated by the device with a "zone resources exceeded" error as defined for
>>>>>>>>>>  specific commands later.
>>>>>>>>>>  
>>>>>>>>>> +If the VIRTIO_BLK_F_ICE feature is negotiated, then in
>>>>>>>>>> +\field{virtio_blk_crypto_characteristics},
>>>>>>>>>> +\begin{itemize}
>>>>>>>>>> +\item \field{slot_info} value packs two 8-bits values to reduce the number of
>>>>>>>>>
>>>>>>>>> 8-bits -> 8-bit
>>>>>>>>
>>>>>>>> ACK
>>>>>>>>
>>>>>>>>>
>>>>>>>>>> +    Configuration Space reads.
>>>>>>>>>> +    \begin{itemize}
>>>>>>>>>> +        \item Bits~\[15:8] (\emph{max\_slots}): the maximum number of supported
>>>>>>>>>> +            crypto key slots.
>>>>>>>>>> +        \item Bits~\[7:0] (\emph{slot\_offset}): an offset applied to slot numbering.
>>>>>>>>>
>>>>>>>>> What is the purpose of slot_offset? This field is not used much in this
>>>>>>>>> spec, maybe it can be removed?
>>>>>>>>>
>>>>>>>>> Does that mean only slots in the range [slot_offset:max_slots) are
>>>>>>>>> available or does it mean that the range is
>>>>>>>>> [slot_offset:slot_offset+max_slots)?
>>>>>>>>
>>>>>>>> Only slots within the range [slot_offset, slot_offset + max_slots) are accessible to the
>>>>>>>> VM. The slot_offset specifies the base physical ICE slot allocated to the VM and is used
>>>>>>>> to translate a virtual slot index into a physical slot.
>>>>>>>>
>>>>>>>> Because the GVM programs and evicts keys directly—without host/PVM involvement—it must
>>>>>>>> supply the resolved physical slot when invoking key operations in TrustZone or the Secure
>>>>>>>> VM.
>>>>>>>
>>>>>>> It's not clear to me how what you've described offers isolation between
>>>>>>> the PVM and the GVM. What stops the GVM from using key slots outside the
>>>>>>> range that has been assigned to it?
>>>>>>>
>>>>>>> A few options for isolation come to mind:
>>>>>>>
>>>>>>> 1. Expose 2 separate virtio-blk devices, one of which is hidden from the
>>>>>>>    GVM and only accessible to the PVM. The PVM can store its data on the
>>>>>>>    hidden device.
>>>>>>>
>>>>>>> 2. Some kind of VIRTIO Admin queue Virtual Function approach where the
>>>>>>>    PVM can instantiate a virtual function (a sub-device) that the GVM is
>>>>>>>    allowed to access with isolation enforced by the device.
>>>>>>>
>>>>>>> 3. A single device could be used but the GVM cannot access it directly
>>>>>>>    and needs to go through the PVM.
>>>>>>
>>>>>> The slot isolation between GVM and PVM is implemented by the max slots allocated to the GVM and slot offset
>>>>>> the GVM's starting slot relative to the physical starting slot.
>>>>>>
>>>>>> For instance, ICE hardware has 64 slots, the max slots allocated to the GVM is 32, and its slot offset is 20.
>>>>>> The keyslot manager in the GVM ensure the virtual slot rang is [0,31], when programming a key, translate the
>>>>>> virtual slot to a physical slot by using the slot offset, that means the physical slot range this GVM used
>>>>>> is [20,51].
>>>>>>
>>>>>> The max_slots and slot_offset are configured by PVM, and GVM's virtio frontend only gets them from the configuration
>>>>>> space of its virtio devices. So PVM is responsible to ensure the physical slot range of the GVM is valid.
>>>>>
>>>>> I don't understand how isolation between the PVM and GVM works. To me it
>>>>> seems like if there is isolation, then it would not be necessary to
>>>>> expose slot_offset to the GVM. And if there is no isolation, then this
>>>>> design isn't safe because the PVM is not protected against the GVM.
>>>>>
>>>>> I'm probably missing something. Can you explain how isolation is
>>>>> enforced?
>>>>
>>>> Appreciate your quick feedback!
>>>>
>>>> The key slots in ICE hardware are used by both PVM/Host and GVMs, the PVM/Host
>>>> specifies the slot range of each VM used (including itself) by defining starting
>>>> slot offest and max slots per VM, ensure that there isn't overlapping b/w these
>>>> slot ranges in physical slot level.
>>>>
>>>> In this way, if only the virtual slot in each VM doesn't exceed the max slots
>>>> allocated to it, the access to its physical ICE slot for one VM doesn' have impact
>>>> on the ICE slots belonging to the range of other VMs. 
>>>>
>>>> You mentioned "this design isn't safe because the PVM is not protected against the
>>>> GVM", do you mean that the slot_offest and/or max_slots of GVM are tampered by a
>>>> malixious program, leading to unexpected access from GVM to a physical ICE slot
>>>> allocated to PVM? If yes, I feel it's not a risk as kernel image can be pretotected
>>>> via dm-verity/AVB, it's impossible for an attacker to rewrite them in runtime from
>>>> both PVM and GVM sides.
>>>
>>> There are two separate issues that are still unclear to me:
>>> 1. The device appears to trust the guest to select valid slot indices.
>>> 2. How the PVM/GVM share the device.
>>>
>>> About trusting the slot field:
>>> - In VIRTIO the trust model is that the device does not trust the
>>>   driver. This is necessary not just for reliability but also to prevent
>>>   virtualized devices from being exploited by untrusted VMs (escaping
>>>   confinement, consuming resources not allocated to the VM, etc).
>>> - Given that the device cannot trust the driver, I don't understand why
>>>   the interface is designed to require driver cooperation in choosing
>>>   slot indices within the slot_offset/max_slots range.
>>> - I expected the interface to expose a max_slots Configuration Space
>>>   field but slot indices are in the range [0, max_slots) and are
>>>   validated by the device.
>>
>> The FBE key programing/eviction in a out-of-band channel here is a compromise for
>> upstream. The reason I'll show it in the proposal slide.
>>
>> In such way, the GVM has to transfer the virtio slot to the physical slot, and send it
>> to Trust Zone during key programming/eviction, bypass slot check in the PVM.
>> So, slot_offset on hardware must also be provided by the PVM together with max_slots for
>> the GVM. On the GVM side, the virtio block driver trusts that max_slots and slot_offest.
>> The layers upper virtio block crypto exteansion driver only see the virtual slots in the
>> range [0, max_slots) and use it. Only when the virtual slot is passed to virtio block
>> crypto exteansion driver, this exteansion driver will ensure the virtual slot is resided
>> in [0, max_slots) and translates it to the physical slot by adding slot_offset.
>>
>> Sorry, I get your point about your second issue. Hope the slide can give you more
>> information.
>>
>>>
>>> About the PVM/GVM relationship, please see below where I'm asking about
>>> the architecture of a system using ICE.
>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>> +    \end{itemize}
>>>>>>>>>> +\end{itemize}
>>>>>>>>>> +
>>>>>>>>>>  \subsubsection{Legacy Interface: Device configuration layout}\label{sec:Device Types / Block Device / Device configuration layout / Legacy Interface: Device configuration layout}
>>>>>>>>>>  When using the legacy interface, transitional devices and drivers
>>>>>>>>>>  MUST format the fields in struct virtio_blk_config
>>>>>>>>>> @@ -278,6 +299,10 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
>>>>>>>>>>      \field{zoned} can be read by the driver to determine the zone
>>>>>>>>>>      characteristics of the device. All \field{zoned} fields are read-only.
>>>>>>>>>>  
>>>>>>>>>> +\item If the VIRTIO_BLK_F_ICE feature is negotiated, the fields in
>>>>>>>>>> +    \field{crypto} can be read by the driver to determine the inline crypto
>>>>>>>>>> +    characteristics of the device. All \field{crypto} fields are read-only.
>>>>>>>>>> +
>>>>>>>>>>  \end{enumerate}
>>>>>>>>>>  
>>>>>>>>>>  \drivernormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
>>>>>>>>>> @@ -317,6 +342,9 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
>>>>>>>>>>      driver SHOULD ignore all other fields in \field{zoned}.
>>>>>>>>>>  \end{itemize}
>>>>>>>>>>  
>>>>>>>>>> +If the VIRTIO_BLK_F_ICE feature is negotiated, then the driver MUST validate
>>>>>>>>>> +    the max_slots in \field{slot_info} before the slot usage.
>>>>>>>>>
>>>>>>>>> I'm not sure how the driver is supposed to validate max_slots?
>>>>>>>>
>>>>>>>> It means the diver validate the virtual slot doesn't exceed the max_slots before translating
>>>>>>>> this virtual slot to a physical slot by using slot_offset. 
>>>>>>>>
>>>>>>>> Can I rewrite it as the following?
>>>>>>>>
>>>>>>>>   If the VIRTIO_BLK_F_ICE feature is negotiated, then the driver MUST validate that
>>>>>>>>   the virtual slot received from upper layer doesn't exceed the max_slots in
>>>>>>>>   \field{slot_info} before the slot usage.
>>>>>>>
>>>>>>> The notion of an "upper layer" can be eliminated so that there is no
>>>>>>> assumption about the software design in the driver:
>>>>>>>
>>>>>>>   If the VIRTIO_BLK_F_ICE feature is negotiated, then the driver MUST
>>>>>>>   ensure that slot_offset <= \field{payload.slot} < slot_offset +
>>>>>>>   max_slots, where slot_offset and max_slots are the values extracted
>>>>>>>   from \field{crypto.slot_info} in configuration space.
>>>>>>
>>>>>> ACK. Thanks!
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>> +
>>>>>>>>>>  \devicenormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
>>>>>>>>>>  
>>>>>>>>>>  Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it
>>>>>>>>>> @@ -402,6 +430,13 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
>>>>>>>>>>  \item the device MUST initialize padding bytes \field{unused2} to 0.
>>>>>>>>>>  \end{itemize}
>>>>>>>>>>  
>>>>>>>>>> +If the VIRTIO_BLK_F_ICE feature is negotiated, then the fields in \field{crypto}
>>>>>>>>>> +struct in the configuration space MUST be set by the device.
>>>>>>>>>> +\begin{itemize}
>>>>>>>>>> +\item the \field{slot_info} field of \field{crypto} MUST be set by the device to a
>>>>>>>>>> +    max_slots in the higher 8 bits and slot_offset in the lower 8 bits.
>>>>>>>>>> +\end{itemize}
>>>>>>>>>
>>>>>>>>> There is no need for the \begin{itemize} here. It contains no new
>>>>>>>>> information. The fields were already described in the configuration
>>>>>>>>> space section and the previous sentence already said that the fields in
>>>>>>>>> \field{crypto} must be set by the device.
>>>>>>>>
>>>>>>>> ACK, remove this \begin{itemize} here.
>>>>>>>>
>>>>>>>>>
>>>>>>>>>> +
>>>>>>>>>>  \subsubsection{Legacy Interface: Device Initialization}\label{sec:Device Types / Block Device / Device Initialization / Legacy Interface: Device Initialization}
>>>>>>>>>>  
>>>>>>>>>>  Because legacy devices do not have FEATURES_OK, transitional devices
>>>>>>>>>> @@ -436,6 +471,13 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>>>>>>>>>>          le32 type;
>>>>>>>>>>          le32 reserved;
>>>>>>>>>>          le64 sector;
>>>>>>>>>> +        struct virtio_blk_crypto_payload {
>>>>>>>>>> +            u8 slot;
>>>>>>>>>> +            u8 activate;
>>>>>>>>>> +            le16 reserved1;
>>>>>>>>>> +            le32 reserved2;
>>>>>>>>>> +            le64 data_unit_num;
>>>>>>>>>> +        } payload;
>>>>>>>>>
>>>>>>>>> "payload" is a generic term. crypto_payload would be clearer.
>>>>>>>>>
>>>>>>>>> I wonder whether consistently calling this feature "ice" rather than
>>>>>>>>> "crypto" would help in case self-encrypting drive or other cryptographic
>>>>>>>>> functionality is added to virtio-blk in the future. That way the spec
>>>>>>>>> items related to inline crypto engine functionality will be easy to
>>>>>>>>> differentiate from other crypto functionality.
>>>>>>>>
>>>>>>>> Ok, to differentiate ICE and other cryptographic functionality, can I modify it as
>>>>>>>>
>>>>>>>>   struct virtio_blk_ice_payload {
>>>>>>>>       u8 slot;
>>>>>>>>       u8 activate;
>>>>>>>>       le16 reserved1;
>>>>>>>>       le32 reserved2;
>>>>>>>>       le64 data_unit_num;
>>>>>>>>   } ice_payload;
>>>>>>>
>>>>>>> Looks good to me, thanks.
>>>>>>
>>>>>> Thanks!
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>>          u8 data[];
>>>>>>>>>>          u8 status;
>>>>>>>>>>  };
>>>>>>>>>> @@ -445,8 +487,9 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>>>>>>>>>>  (VIRTIO_BLK_T_OUT), a discard (VIRTIO_BLK_T_DISCARD), a write zeroes
>>>>>>>>>>  (VIRTIO_BLK_T_WRITE_ZEROES), a flush (VIRTIO_BLK_T_FLUSH), a get device ID
>>>>>>>>>>  string command (VIRTIO_BLK_T_GET_ID), a secure erase
>>>>>>>>>> -(VIRTIO_BLK_T_SECURE_ERASE), or a get device lifetime command
>>>>>>>>>> -(VIRTIO_BLK_T_GET_LIFETIME).
>>>>>>>>>> +(VIRTIO_BLK_T_SECURE_ERASE), a get device lifetime command
>>>>>>>>>> +(VIRTIO_BLK_T_GET_LIFETIME), or a get device crypto capabilities command
>>>>>>>>>> +(VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES).
>>>>>>>>>>  
>>>>>>>>>>  \begin{lstlisting}
>>>>>>>>>>  #define VIRTIO_BLK_T_IN           0
>>>>>>>>>> @@ -457,12 +500,27 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>>>>>>>>>>  #define VIRTIO_BLK_T_DISCARD      11
>>>>>>>>>>  #define VIRTIO_BLK_T_WRITE_ZEROES 13
>>>>>>>>>>  #define VIRTIO_BLK_T_SECURE_ERASE   14
>>>>>>>>>> +#define VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES   27
>>>>>>>>>
>>>>>>>>> The Linux virtio_blk.c driver assumes that odd numbered constants have
>>>>>>>>> data buffers that are read by the device, so you may run into a bug when
>>>>>>>>> using 27.
>>>>>>>>>
>>>>>>>>> There is an informal convention to use even numbers for read requests
>>>>>>>>> and odd numbers for write requests. It doesn't hurt to try to follow the
>>>>>>>>> convention even though it's not strictly necessary.
>>>>>>>>>
>>>>>>>>> The Linux driver could be fixed when adding support for ICE, but 16 is
>>>>>>>>> available and it's safest to use that.
>>>>>>>>
>>>>>>>> OK. Agree to following the convention. But 16, 18,20,22,24,26 are already used by
>>>>>>>> zone device. Seems 12 is available. Correct it to 12.
>>>>>>>>
>>>>>>>>  #define VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES   12
>>>>>>>
>>>>>>> In that case I suggest using 28. I don't remember what 12 was used for
>>>>>>> but there may be a historical reason for the gap.
>>>>>>
>>>>>> Thanks! Change it to 28.
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>>  \end{lstlisting}
>>>>>>>>>>  
>>>>>>>>>>  The \field{sector} number indicates the offset (multiplied by 512) where
>>>>>>>>>>  the read or write is to occur. This field is unused and set to 0 for
>>>>>>>>>>  commands other than read, write and some zone operations.
>>>>>>>>>>  
>>>>>>>>>> +The \field{payload} consists of the encryption information for current
>>>>>>>>>> +request. It is only present when the VIRTIO_BLK_F_ICE feature is negotiated and
>>>>>>>>>> +\field{type} is VIRTIO_BLK_T_IN, VIRTIO_BLK_T_OUT or VIRTIO_BLK_T_FLUSH.
>>>>>>>>>
>>>>>>>>> TODO think about layout
>>>>>>>>
>>>>>>>> rewrite to the following
>>>>>>>>
>>>>>>>>   The \field{ice_payload} consists of the encryption information for current
>>>>>>>>   request. When VIRTIO_BLK_F_ICE is negotiated, the request header layout becomes
>>>>>>>>   that struct virtio_blk_outhdr includes \field{ice_payload} as a fixed-size
>>>>>>>>   extension. For non-ICE requests (or types not using crypto), the driver MUST
>>>>>>>>   set \field{ice_payload} to 0 and device ignores them.
>>>>>>>
>>>>>>> Sorry, the TODO was a comment to myself while writing my reply :).
>>>>>>>
>>>>>>> I forgot to investigate. Basically the issue is that the spec must be
>>>>>>> clear on whether:
>>>>>>> 1. A field is absent and fields that follow it are present in the struct
>>>>>>>    layout when a condition is false (e.g. type is not VIRTIO_BLK_T_IN,
>>>>>>>    VIRTIO_BLK_T_OUT, or VIRTIO_BLK_T_FLUSH).
>>>>>>> or
>>>>>>> 2. A field is present but unused (zeroed) when a condition is false.
>>>>>>>
>>>>>>> #2 is usually easier to implement in code because it avoids creating
>>>>>>> many different struct layouts at runtime depending on conditions like
>>>>>>> negotiated feature bits.
>>>>>>>
>>>>>>> I was thinking that the ice fields should always be present but should
>>>>>>> be zero when the feature bit is not negotiated or some other condition
>>>>>>> (like the request type) is false. This way it will be much easier to add
>>>>>>> additional fields later without worrying about struct layouts.
>>>>>>>
>>>>>>> This is how configuration space already works: the offset of the zoned
>>>>>>> field is not affected by whether the device advertises the
>>>>>>> VIRTIO_BLK_F_WRITE_ZEROES feature bit, it just means that the earlier
>>>>>>> write_zeroes_may_unmap field may be unused. This approach should
>>>>>>> probably be used everywhere and the spec language should be careful to
>>>>>>> communicate that the field is still present but zero when unused. It's
>>>>>>> okay for the driver to provide a shorter struct that doesn't include the
>>>>>>> last field(s) to the device when the feature bit is not negotiated
>>>>>>> though.
>>>>>>
>>>>>> Thanks. Refer to the statement you shared, try to rewrite it as the following.
>>>>>>
>>>>>>   The \field{ice_payload} consists of the encryption information for current
>>>>>>   request. It is not affected by whether the device advertises the
>>>>>>   VIRTIO_BLK_F_ICE feature bit, it just SHOULD be zero when the feature bit is
>>>>>>   not negotiated or the \field{type} is not VIRTIO_BLK_T_IN, VIRTIO_BLK_T_OUT
>>>>>>   or VIRTIO_BLK_T_FLUSH. 
>>>>>
>>>>> Sounds good.
>>>>>
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>> +\begin{itemize}
>>>>>>>>>> +\item The \field{slot} field in \field{payload} indicates the ICE
>>>>>>>>>> +  (Inline Crypto Encryption) slot index where the key resides.
>>>>>>>>>> +
>>>>>>>>>> +\item The \field{activate} field in \field{payload} implies this is a
>>>>>>>>>> +  inline encryption request.
>>>>>>>>>> +
>>>>>>>>>> +\item The \field{data_unit_num} field in \field{payload} indicates the
>>>>>>>>>> +  starting block of the request.
>>>>>>>>>
>>>>>>>>> This is a block device, so the term "block" needs to be qualified to
>>>>>>>>> avoid confusion. I guess this is the cryptography concept of a block
>>>>>>>>> rather than the disk concept of a block. Please clarify this in the
>>>>>>>>> text, maybe by explaining that the ICE handles data in fixed-size "data
>>>>>>>>> units" instead of using the word "block".
>>>>>>>>>
>>>>>>>>> Also, can you explain the relationship between the data unit number and
>>>>>>>>> the sector? In simple cases I imagine the data unit number would be the
>>>>>>>>> sector. How is the driver supposed to pick or calculate the data unit
>>>>>>>>> number?
>>>>>>>>
>>>>>>>> The data unit number is the starting IV for AES crypto in ICE hardware, it's
>>>>>>>> a stable value for I/O request targeting to same storage range. It can be set
>>>>>>>> to the file logic block number or the starting sector of BIO. 
>>>>>>>
>>>>>>> It sounds like the data unit number calculation is up to the driver
>>>>>>> (from the device's perspective) and the important thing is that the same
>>>>>>> data unit number will always be used when reading/writing the same
>>>>>>> logical data location.
>>>>>>
>>>>>> Yes. Correct.
>>>>>>
>>>>>>>
>>>>>>>> The upper layer calculates it and passes it to virtio_blk driver in this patch.
>>>>>>>> ICE uses the data unit number and data unit size (the granularity to use for
>>>>>>>> en/decryption) to derive the next data unit number for the next cryptography
>>>>>>>> block. data unit number in ICE increase 1 per data unit size. For instance,
>>>>>>>>   data unit number = 2048
>>>>>>>>   data unit size = 1024 bytes
>>>>>>>> For the first 1024 bytes of the transaction, ICE hardware encrypt the data
>>>>>>>> with IV equal to 2048.
>>>>>>>> For the second 1024 bytes of the transaction, ICE hardware encrypt the data
>>>>>>>> with IV equal to (2048+1=)2049.
>>>>>>>>
>>>>>>>> Rewrite it as bellow.
>>>>>>>>
>>>>>>>>   \item The \field{data_unit_num} field in \field{ice_payload} indicates the
>>>>>>>>   starting IV. It can be the file logic block number or the starting sector
>>>>>>>>   of BIO.
>>>>>>>
>>>>>>> BIO is a Linux-specific concept, so it would be best to avoid it in the
>>>>>>> VIRTIO spec.
>>>>>>>
>>>>>>>   \item The \field{data_unit_num} field in \field{ice_payload} indicates
>>>>>>>   the starting IV. In order to successfully encrypt/decrypt data this
>>>>>>>   number must be the same for successive read and write operations to
>>>>>>>   the same logical data location. The driver typically sets it to the
>>>>>>>   file logical block number or the disk sector number.
>>>>>>
>>>>>> Thanks! ACK.
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>> +\end{itemize}
>>>>>>>>>> +
>>>>>>>>>>  VIRTIO_BLK_T_IN requests populate \field{data} with the contents of sectors
>>>>>>>>>>  read from the block device (in multiples of 512 bytes).  VIRTIO_BLK_T_OUT
>>>>>>>>>>  requests write the contents of \field{data} to the block device (in multiples
>>>>>>>>>> @@ -530,6 +588,47 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>>>>>>>>>>  The \field{device_lifetime_est_typ_b} refers to wear of MLC cells and is provided
>>>>>>>>>>  with the same semantics as \field{device_lifetime_est_typ_a}.
>>>>>>>>>>  
>>>>>>>>>> +VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES requests fetch the storage hardware crypto
>>>>>>>>>> +capabilities into \field{data}. And the \field{data} is of the form
>>>>>>>>>
>>>>>>>>> How does VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES behave when data[] is too
>>>>>>>>> small to fit all the device's crypto capabilities?
>>>>>>>>
>>>>>>>> Add a new field capability_num to the Configuration space header. The total size of
>>>>>>>> \field{data} shall be computed as:
>>>>>>>>   data_size=capability_num×capability_size
>>>>>>>> where capability_size is the size (in bytes) of one capability structure. Therefore, \field{data} contains exactly capability_num contiguous capability entries, each of length capability_size.
>>>>>>>> Add a capability_num field in Configuration space. So it use size per capability
>>>>>>>> multiply capability_num to define the size of \field{data}.
>>>>>>>>
>>>>>>>> Rewrite it as the following.
>>>>>>>>
>>>>>>>>   VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES requests fetch the storage hardware crypto
>>>>>>>>   capabilities into \field{data}. The crypto capabilities is a zero-padded array
>>>>>>>>   up to (\field{capability_num}×capability_size) bytes long, where capability_size
>>>>>>>>   is the size (in bytes) of one capability structure which is in form of
>>>>>>>>   
>>>>>>>>   \begin{lstlisting}
>>>>>>>>     struct virtio_blk_crypto_cap {
>>>>>>>>         u8 alg;
>>>>>>>>         u8 data_unit_size;
>>>>>>>>         u8 key_size;
>>>>>>>>         u8 reserved;
>>>>>>>>     };
>>>>>>>>   \end{lstlisting}
>>>>>>>>   
>>>>>>>>   \begin{itemize}
>>>>>>>>       \item The \field{alg} implies crypto algorithm identifiers.
>>>>>>>>       The device supports reporting and negotiating cryptographic algorithms
>>>>>>>>       using the following algorithm identifiers:
>>>>>>>>       \begin{lstlisting}
>>>>>>>>           CRYPTO_ALG_AES_XTS              = 0x0
>>>>>>>>           CRYPTO_ALG_BITLOCKER_AES_CBC    = 0x1
>>>>>>>>           CRYPTO_ALG_AES_ECB              = 0x2
>>>>>>>>           CRYPTO_ALG_ESSIV_AES_CBC        = 0x3
>>>>>>>>       \end{lstlisting}
>>>>>>>>       These identifiers abstract the underlying hardware crypto implementation
>>>>>>>>       and does not assume any operating‑system‑specific data structures or
>>>>>>>>       constants.
>>>>>>>>       \item The \field{data_unit_size} implies the mask of data unit size. When
>>>>>>>>       bit j in this field (j=7......0) is set, a data unit size of 512*2^j bytes
>>>>>>>>       is selected.
>>>>>>>>       \item The \field{key_size} is the crypto key size identifiers.
>>>>>>>>       \begin{lstlisting}
>>>>>>>>           CRYPTO_KEY_SIZE_INVALID     = 0x0
>>>>>>>>           CRYPTO_KEY_SIZE_128_BITS    = 0x1
>>>>>>>>           CRYPTO_KEY_SIZE_192_BITS    = 0x2
>>>>>>>>           CRYPTO_KEY_SIZE_256_BITS    = 0x3
>>>>>>>>           CRYPTO_KEY_SIZE_512_BITS    = 0x4
>>>>>>>>       \end{lstlisting}
>>>>>>>>       \item The \field{reserved} is unused.
>>>>>>>>   \end{itemize}
>>>>>>>>   
>>>>>>>>   If the \field{data} is too short, it sets status to BLK_S_IO_ERR.
>>>>>>>
>>>>>>> Looks good. In the final sentence I suggest changing "it" to "the
>>>>>>> device" for clarity.
>>>>>>
>>>>>> Thanks! Done.
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>> +
>>>>>>>>>> +\begin{lstlisting}
>>>>>>>>>> +struct virtio_blk_crypto_caps {
>>>>>>>>>> +  u8 size;
>>>>>>>>>> +  le32 crypto_capabilities[];
>>>>>>>>>> +};
>>>>>>>>>> +\end{lstlisting}
>>>>>>>>>> +
>>>>>>>>>> +The \field{size} specifies the size of array \field{crypto_capabilities}.
>>>>>>>>>
>>>>>>>>> "number of elements" would be clearer than "size of array" because the
>>>>>>>>> unit (bytes vs array elements) is ambiguous.
>>>>>>>>>
>>>>>>>>> The size field is not necessary since Used Ring descriptors contain
>>>>>>>>> (struct virtq_used_elem in the spec) a len field indicating how many
>>>>>>>>> bytes were written by the device.
>>>>>>>>
>>>>>>>> Remove virtio_blk_crypto_caps in above modification.
>>>>>>>>
>>>>>>>>>
>>>>>>>>>> +The \field{crypto_capabilities} indicates the crypto capabilities supported by the
>>>>>>>>>> +hardware storage for inline encryption.
>>>>>>>>>> +
>>>>>>>>>> +A crypto capability packs four 8-bits values:
>>>>>>>>>> +\begin{itemize}
>>>>>>>>>> +    \item Bits~\[31:24]: crypto algorithm identifiers.
>>>>>>>>>> +    The device supports reporting and negotiating cryptographic algorithms
>>>>>>>>>> +    using the following algorithm identifiers:
>>>>>>>>>> +    \begin{lstlisting}
>>>>>>>>>> +        CRYPTO_ALG_AES_XTS              = 0x0
>>>>>>>>>> +        CRYPTO_ALG_BITLOCKER_AES_CBC    = 0x1
>>>>>>>>>> +        CRYPTO_ALG_AES_ECB              = 0x2
>>>>>>>>>> +        CRYPTO_ALG_ESSIV_AES_CBC        = 0x3
>>>>>>>>>> +    \end{lstlisting}
>>>>>>>>>> +    These identifiers abstract the underlying hardware crypto implementation
>>>>>>>>>> +    and does not assume any operating‑system‑specific data structures or
>>>>>>>>>> +    constants.
>>>>>>>>>> +    \item Bits~\[23:16]: mask of data unit size. When bit j in this field
>>>>>>>>>> +    (j=7......0) is set, a data unit size of 512*2^j bytes is selected.
>>>>>>>>>
>>>>>>>>> Is only one bit ever set in the mask? If so, then maybe just express j
>>>>>>>>> as an 8-bit unsigned integer (i.e. the exponent in 512*2^j) instead of
>>>>>>>>> as a bit mask. It's simpler and increases the range for j.
>>>>>>>>
>>>>>>>> Yes, it's encoded in one-hot encoding. If j is expressed as an 8-bit unsigned integer,
>>>>>>>> it will confused the reader that more than one bit can be set in the mask of data unit
>>>>>>>> size. right? 
>>>>>>>
>>>>>>> If the field is called the data unit size exponent (data_unit_size_exp)
>>>>>>> then there is no confusion. I agree that calling it a mask would be
>>>>>>> confusing.
>>>>>>
>>>>>> Thanks! Update it to data_unit_size_exp.
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>> +    \item Bits~\[15:8]: crypto key size identifiers.
>>>>>>>>>> +    \begin{lstlisting}
>>>>>>>>>> +        CRYPTO_KEY_SIZE_INVALID     = 0x0
>>>>>>>>>> +        CRYPTO_KEY_SIZE_128_BITS    = 0x1
>>>>>>>>>> +        CRYPTO_KEY_SIZE_192_BITS    = 0x2
>>>>>>>>>> +        CRYPTO_KEY_SIZE_256_BITS    = 0x3
>>>>>>>>>> +        CRYPTO_KEY_SIZE_512_BITS    = 0x4
>>>>>>>>>> +    \end{lstlisting}
>>>>>>>>>> +    \item Bits~\[7:0]: unused.
>>>>>>>>>> +\end{itemize}
>>>>>>>>>
>>>>>>>>> A struct would be more natural here (the rest of the VIRTIO
>>>>>>>>> specification rarely packs fields into an integer):
>>>>>>>>>
>>>>>>>>>   struct virtio_blk_crypto_cap {
>>>>>>>>>       u8 alg;
>>>>>>>>>       u8 data_unit_size;
>>>>>>>>>       u8 key_size;
>>>>>>>>>       u8 reserved;
>>>>>>>>>   };
>>>>>>>>
>>>>>>>> ACK, see above rewrite statement.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> By the way, Linux seems to call this a "profile" rather than a
>>>>>>>>> "capability". Do you want to use the same name as Linux for consistency?
>>>>>>>>
>>>>>>>> blk-crypto-profile is the keyslot manager which manage the usage of keyslot and
>>>>>>>> also checks if the key configuration set by upper layer can be supported by the
>>>>>>>> ICE hardware. While the capability aims to illustrate the capability provided by
>>>>>>>> the ICE hardware. What we expected is the capability used to initialized
>>>>>>>> blk-crypto-profile in Guest VM.
>>>>>>>
>>>>>>> I see.
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>> +
>>>>>>>>>>  The final \field{status} byte is written by the device: either
>>>>>>>>>>  VIRTIO_BLK_S_OK for success, VIRTIO_BLK_S_IOERR for device or driver
>>>>>>>>>>  error or VIRTIO_BLK_S_UNSUPP for a request unsupported by device:
>>>>>>>>>> @@ -912,6 +1011,13 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>>>>>>>>>>  successfully, failed, or were processed by the device at all if the request
>>>>>>>>>>  failed with VIRTIO_BLK_S_IOERR.
>>>>>>>>>>  
>>>>>>>>>> +The length of \field{data} MUST be a multiple of 4 bytes plus 1 for
>>>>>>>>>> +VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES requests.
>>>>>>>>>> +
>>>>>>>>>> +A driver MUST set \field{activate} to 1 for VIRTIO_BLK_T_IN,VIRTIO_BLK_T_OUT,
>>>>>>>>>> +    and VIRTIO_BLK_T_FLUSH requests that require inline encryption. For other
>>>>>>>>>> +    request types or when inline encryption is not required, it is set to 0.
>>>>>>>>>> +
>>>>>>>>>>  The following requirements only apply if the VIRTIO_BLK_F_ZONED feature is
>>>>>>>>>>  negotiated.
>>>>>>>>>
>>>>>>>>> How does the driver assign a specific capability (algorithm, data unit
>>>>>>>>> size, and key size tuple reported by
>>>>>>>>> VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES) to a slot?
>>>>>>>>>
>>>>>>>>> How does the driver assign the key material for a slot?
>>>>>>>>
>>>>>>>> blk layer will initialize a blk_crypto_key based on the configuration received from
>>>>>>>> FS layer. This blk_crypto_key contains expected algorithm, data unit size and key size expected
>>>>>>>> by the upper layer. When submit_bio, blk_mq tries to program the key included in blk_crypto_key
>>>>>>>> to the ICE hardware slot via blk_crypto_profile. During programming the key, it will compare 
>>>>>>>> the algorithm, data unit size and key size in blk_crypto_key with the capability exposed by ICE
>>>>>>>> hardware.
>>>>>>>>
>>>>>>>> It will follow bellow flow to assign the key material for a slot.
>>>>>>>>   blk_crypto_profile -> virtio_blk driver -> virtio_blk extention -> SCM driver -> TZ
>>>>>>>>
>>>>>>>> That means the driver only maintain the capability in RAM, use it when programming key.
>>>>>>>
>>>>>>> I don't see an interface for programming the key in this spec patch. The
>>>>>>> Linux block driver interface includes struct blk_crypto_ll_ops with
>>>>>>> driver functions for programming keys. I expected this spec would add
>>>>>>> operations to the virtio-blk device for implementing those functions?
>>>>>>
>>>>>> The design is that having a virtio_blk extension driver to handle the initialization of keyslot manager
>>>>>> for virtio block with VIRTIO_BLK_F_ICE feature bit negociated. And this extension driver also define the
>>>>>> implementation of struct blk_crypto_ll_ops with driver functions for programming keys, evicting keys and
>>>>>> derive raw keys. Thees 3 key operation is done in a 'out of band' channel, that LA GVM calls to TrustZone
>>>>>> (or secure VM) directly via SCM driver, bypass PVM.
>>>>>>
>>>>>> Add a new Kconfig VIRTIO_BLK_INLINE_CRYPTO, and this config need always to be set as Y when inline encryption
>>>>>> on virtio block is expected.
>>>>>>
>>>>>> In such scenario, the key programming/eviction/derivation doesn't affect the virtio block protocol, so I didn't
>>>>>> add it in this patch. Do you think it's necessary to be shown in virtio SPEC in such design?
>>>>>
>>>>> It seems like supporting keyslot manager operations via the virtio-blk
>>>>> device is a possible future use case. The design of VIRTIO_BLK_F_ICE
>>>>> should allow for adding it in the future so that we can be confident
>>>>> that no breaking changes will be needed.
>>>>>
>>>>> Why are the keyslot manager operations out of band in your TrustZone use
>>>>> case? Maybe this is related to isolation between the PVM and GVM when
>>>>> sharing a device, but it's not clear to me that isolation is actually
>>>>> enforced, so then I see no need for out of band keyslot manager
>>>>> operations.
>>>>>
>>>>> Stefan
>>>>
>>>> For ICE based disk encryption (like File-Based Encryption), keyslot manager
>>>> (implemeneted in blk-crypot-profile.c in latest kernel version) is responsible
>>>> for forwarding blk-crypto-key from block layer to the bottom layer (i.e.
>>>> storage driver in Bare Metal) implementing blk_crypto_ll_ops for the key
>>>> programming/eviction/derivation. 
>>>>
>>>> So, for a whole inline encryption support in virtio block, virtio block device
>>>> must register a keyslot manager and provide the corresponding implementation of
>>>> blk_crypto_ll_ops. 
>>>>
>>>> The reasons of using out-of-band channel are
>>>>   1. In Bare Metal, the operation of key programming/eviction/derivation is also
>>>>      through a out-of-band channel.
>>>>      keyslot manager -> storage driver -> scm driver -> Trust Zone
>>>>   2. Challenges of using in-band channel
>>>>      a. Passing the blk-crypot-key to virtio blk backend in userspace through the
>>>>         virtqueue. The virtio blk backend need pass this blk-crypot-key to block
>>>>         layer of PVM/Host. But it's not easy to be implemented. Addtional changes
>>>>         (like adding SET_BLK_CRYPTO_KEY blk ioctl syscal) need to be added in block
>>>>         layer. In additiona, virtio block backend uses pread/pwrite implementing
>>>>         I/O in backend, it must ensure that blk-crypto-key is always bound to its
>>>>         corresponded I/O operation.
>>>>      b. For key eviction operation, it's totally irrelevant to I/O operation, the
>>>>         block layer only pass the blk crypto key to virtio block device via keyslot
>>>>         manager. Even refer to virtblk_get_id to send this request to virtio blk
>>>>         backend, it faces on similar issue like programming key, that how to populate
>>>>         blk-crypto-key to the block layer in PVM. Adding EVICT_KEY ioctl seems not a
>>>>         acceptable way as it exposes key evivtion operation to the userspace.
>>>
>>> Would you be able to post a slide deck that illustrates:
>>>
>>> 1. The bare metal architecture with a UFS ICE device, TrustZone, the
>>>    kernel (block layer, file systems, etc), userspace applications doing
>>>    I/O, etc.
>>>
>>> 2. The modified architecture with a virtio-blk ICE device with a virtual
>>>    machine monitor running in host userspace (i.e. QEMU), the emulated
>>>    virtio-blk device, PVM/GVM, etc.
>>>
>>> If there is already existing documentation that shows the big picture,
>>> that would be great. Otherwise it would help if you could draw the
>>> diagrams.
>>>
>>> I need to understand the architecture in order to review this further.
>>>
>>> Thanks,
>>> Stefan
> 
> 

