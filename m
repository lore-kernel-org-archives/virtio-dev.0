Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38E6381AE0
	for <virtio-dev@lists.linux.dev>; Fri, 28 Aug 2026 08:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787905795; cv=none; b=CQavrptnbwJTlxXQR4dYZu8vdRaxEVxn+v2Bt5ZLwpnDc/A5iKc5/LPEBAGrBCtwnDemttv9K9KeVhea8E3f/SgVxAXoQVv+VAjv/7cDqqwWP3P3T/Yyg6JsdC/ecqrUMEfkcWKmgPHDpc0N9ZrPLnSWGHg4P73PZ1WC8aSMJsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787905795; c=relaxed/simple;
	bh=wW2D3HbU83jp5wiNlfQRrq7AE0P283EZUAjJKEOwJlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fFL/iV+MhEXr9I/xz1CjMlrIa3DEleU5iHY3dEyQvlcvQWHTqR22ji3+oFHXWYz9cCM3k7hQRESGDmEmn43c5iFWCHGwKAbHMrfuGhE7SAiRtKZ54rd4iPkX9bD8pSER5y+TGv/l4ytu2G/UeCB79Zs/1kzDc+/hqm2o1eCzvaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p7tW9dOU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WVtMfBn4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p7tW9dOU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WVtMfBn4"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67S66Ywm2761952
	for <virtio-dev@lists.linux.dev>; Fri, 28 Aug 2026 08:29:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x9bjb5dfYQdxtSquWfMgbIrakAAHcMjQbRRCLDv+vlM=; b=p7tW9dOUD2Q8ylpo
	W3C75FrXFULAfCtVJ3hHGm/1h3tlfFWnA+0UNdOmmnJ5AkWG7iho5lBjvePFyhrh
	khwnT7kmqRqHhGcxrNy+khTtkqCxY3h+mJRXzgZF+gKYY9pfTt3rzL50xm7ps74R
	lCYZhp8RLCwxvfANwI5iv17IhdFU/0qSoWnj2pBoIPAY5Dkwezl+j3a60wpUw/xk
	c8q+oajnfiAN7wdM2tXR079UnNhrVnRw2yH/WZvg7vizm4F+L+MTryA5aKiHEMeV
	gfQPUAEsr5YWefOsubOANmssojpTGIQTNZeRP/SzeuIL3ntzyMamw3CN/SmD/Nfm
	JdMjeg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb42p8q7c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Fri, 28 Aug 2026 08:29:51 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cce14a21faso10772785ad.0
        for <virtio-dev@lists.linux.dev>; Fri, 28 Aug 2026 01:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787905791; x=1788510591; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x9bjb5dfYQdxtSquWfMgbIrakAAHcMjQbRRCLDv+vlM=;
        b=WVtMfBn4SUuNilW1OXPPNnpF9IkCNISQu99+mbRyA8l3/gnuSTLNyW/85RBY89eW5A
         KPk7qVrZu/hxvl5gMK0Mw3heNBbcrn1oxQCo8WFY1/gl3bjxLTHxODfhL5E0bGhKqnkP
         uPT6AaaNVIqGj5rPSHn5GawfRsv4WfNAqg7vaZD/AxZvCz+fRYUSjKaPaHdZzuMGHnoO
         WaxR+shFGh76wRROByhLQwVy8QPJPPkBj9pq56Z64Matow5x+VGMvgMTzrkvOXGiTvQF
         cxvKB9hBO5K9EMA9TQfIMGnbNbXwijj/FqXCwFz8e345qqoVu9neWFsMZNRyV1V5l5a9
         zgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787905791; x=1788510591;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x9bjb5dfYQdxtSquWfMgbIrakAAHcMjQbRRCLDv+vlM=;
        b=sc8uMBdiDg6xJc4AxTjG778nHDp+yH7XfPN09OvdLODKuxvUdCpF9h56ukOgRVDjYc
         VvZfM15H1x+eGHsUO+zxQu3dDWv3UlBo2ncikn6+7G+Wt3oJCYZmO+Nw3tzP8SzGWeQW
         BZ7S2iRNMnD6NCKARMJi+AEiO1Lzakv2KV6a9u4b1NGzPQLFujkm6fBizBuepiUo1rNV
         IL1T9jR1PY5+p3mJSDRYDBRZSwsYNuPj3D0DNHufeXeXVt7tLxeqRJtiU/iAic33dB7J
         aju9GtBwhkU9FcklVoARQ89sdMSn0JInxVdmR2qHJn8Cxx/paM8r7mnRFvrbmtsiXibv
         1+Pg==
X-Gm-Message-State: AFuF++kZChMAPVh7DU3wUQWLHutNkZagd0KpZlQcc9V0g3GxpayNr26X
	TUP+/soV2ATz0yjH0wMLLag0WEhMx7L8s6QpQrSkW7P98lwAywClC43AR0N76D6ECLPiiF38QvM
	kASpimB96ex3mjtN1OPMZcqFAZixOUFFiBtON74LE1qzqEATon8WkIGAD2ryXu7SG
X-Gm-Gg: AR+sD13bFFjSBGlcWTbUY1C2zYKbVahRZCxKe+tlTo4Tr9N4E5i+yuEw6R/jz1/PhnL
	EhZvD7rr0sY2M6ZWmhYWMQrZbDQdY1s+/8kN5WU1/YLpGCtGLWKNVEbl07UdJrBDD1ko35E0gcU
	5O9iO+6mKcrMv3jB2XorboDviX3fN7+MXi3okSWs1lkSK+X3U812EkCahe8X5OO36rAslTidUNC
	I1w7ECmg1vzCkNS7eNgdfTIMO/3MvNt3WFBzCAyn9w2pddTOwZlmFzmqn2luABtoLo4RQbU+Sw1
	2BDEffKKBjtusb0Jde7VeQyQ0sePn0+E4qaliHGr4QuK4AojLhj84BGW/97pnldtAOby9jin/ki
	jt6fq4chQKraof3hb7zQ5yk9CmneNwuwiQ6weB/ZKRWjqj7+stMMneoqxR18=
X-Received: by 2002:a17:903:2308:b0:2cc:ac15:ff4c with SMTP id d9443c01a7336-2d72659fedbmr132816925ad.8.1787905790438;
        Fri, 28 Aug 2026 01:29:50 -0700 (PDT)
X-Received: by 2002:a17:903:2308:b0:2cc:ac15:ff4c with SMTP id d9443c01a7336-2d72659fedbmr132816115ad.8.1787905789451;
        Fri, 28 Aug 2026 01:29:49 -0700 (PDT)
Received: from [10.110.102.109] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f8094dasm3739102eec.13.2026.08.28.01.29.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2026 01:29:48 -0700 (PDT)
Message-ID: <92abafd6-e041-4fe6-a0e1-f5b8673b522c@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 16:29:45 +0800
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] virtio-blk: Add inline encryption support
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.linux.dev, ebiggers@kernel.org,
        neeraj.soni@oss.qualcomm.com
References: <20260814142306.3934029-1-linlin.zhang@oss.qualcomm.com>
 <20260819211845.GB470114@fedora>
 <c66459c5-0207-4cc5-bea7-71fe0e600aa1@oss.qualcomm.com>
 <20260821153023.GA564943@fedora>
 <56b6e8ec-f68d-47d7-97af-c5eef814957b@oss.qualcomm.com>
 <20260824154420.GA755926@fedora>
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <20260824154420.GA755926@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Ur24SkaXX-Ufv4-2vzAt9kfmKVxJnBLk
X-Authority-Analysis: v=2.4 cv=ToDWQjXh c=1 sm=1 tr=0 ts=6a9146ff cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=tHjN05fFMw9jgzTzyiwA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: Ur24SkaXX-Ufv4-2vzAt9kfmKVxJnBLk
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA3MSBTYWx0ZWRfX9Ay4iodsyeZb
 0avm79OztTLdh4X0ZpWplVZ6xKzF1o8WgEyZl/35LmiLm/wb+vHFBDP4wpVu2m/O4yxHMoaQ6pV
 zdNETyFp5CVi/LYtj3hOO5HIkW6BlCM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA3MSBTYWx0ZWRfX0js1iGxWXV4F
 D6tDRzketO8qerQ+YiyeRGxEya+s34azZepoB06/esFw/1sajtAzexoZTsvD/JltfNFXd2ry+vn
 Mf10fjL3eDveFI6CZpEu/7Ov4HK0lLOvGfGzU396z7danp5XpgOeH6O8LgKbrZzgdnzBoSvqegD
 5x7H5302S3SqrEewMNZAaI1TmN4ziMajieOrEkUB8txbXUmE/qU8OZVAu1tRDyxxT5W9QXXOYId
 wDRt9Qd4CPxOCAW92HLfCy5gl7JE3/zEN9Tj7DvQmFlnxjKf48YnutXBj9QD1mg2ZYAIS/v3qmI
 sdvwGPtKl0t9/0GhRB35O29v96GHUEJGj5qlwxAU38QwqEZ9jSSQ87U7qh2KTfqtySFqay47UXd
 JkmpS5eIJCjYjl3JGizpvA0rcNgqCHH8MEKTaPD+All3MVZ7/ubHDX5Up9iwSCQYexw6zU/grDW
 vAhZGEt3eLjp5bWJc5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280071



On 8/24/2026 11:44 PM, Stefan Hajnoczi wrote:
> On Sat, Aug 22, 2026 at 06:43:28PM +0800, Linlin Zhang wrote:
>>
>>
>> On 8/21/2026 11:30 PM, Stefan Hajnoczi wrote:
>>> On Fri, Aug 21, 2026 at 12:18:55AM +0800, Linlin Zhang wrote:
>>>>
>>>>
>>>> On 8/20/2026 5:18 AM, Stefan Hajnoczi wrote:
>>>>> On Fri, Aug 14, 2026 at 07:23:01AM -0700, Linlin Zhang wrote:
>>>>>> From: linlzhan <linlin.zhang@oss.qualcomm.com>
>>>>>>
>>>>>> Add VIRTIO_BLK_F_IE to advertise inline encryption support.
>>>>>>
>>>>>> When the feature is negotiated, the device reports inline encryption
>>>>>> characteristics through virtio_blk_enc_characteristics. Add
>>>>>> VIRTIO_BLK_T_GET_CRYPTO_MODES, VIRTIO_BLK_T_CRYPTO_IN, and
>>>>>> VIRTIO_BLK_T_CRYPTO_OUT so that the driver can discover supported
>>>>>> crypto modes and submit inline-encrypted I/O requests.
>>>>>>
>>>>>> Crypto I/O requests carry a virtual key slot index, data unit size,
>>>>>> and initial Data Unit Number (DUN). The device maps the virtual key
>>>>>> slot to a physical key slot in the storage backend and uses these
>>>>>> parameters for inline encryption or decryption.
>>>>>>
>>>>>> Key provisioning is performed through an out-of-band mechanism and is
>>>>>> outside the scope of this device type.
>>>>>>
>>>>>> For background on inline encryption in UFS and eMMC storage, see:
>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/block/inline-encryption.rst
>>>>>>
>>>>>> Change-Id: I83c52456bc0c9dd37f39ff46e6bfe73a715138ca
>>>>>> Signed-off-by: linlzhan <linlin.zhang@oss.qualcomm.com>
>>>>>> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/238
>>>>>> ---
>>>>>>  device-types/blk/description.tex | 297 ++++++++++++++++++++++++++++++-
>>>>>>  1 file changed, 291 insertions(+), 6 deletions(-)
>>>>>>
>>>>>> diff --git a/device-types/blk/description.tex b/device-types/blk/description.tex
>>>>>> index 3b3a4e7..f8a544b 100644
>>>>>> --- a/device-types/blk/description.tex
>>>>>> +++ b/device-types/blk/description.tex
>>>>>> @@ -71,7 +71,16 @@ \subsection{Feature bits}\label{sec:Device Types / Block Device / Feature bits}
>>>>>>  
>>>>>>  \item[VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA (19)] Device supports the
>>>>>>      VIRTIO_BLK_REQ_FLAG_OUT_FUA flag in the \field{flags} bitfield of the
>>>>>> -    \field{virtio_blk_req} structure for VIRTIO_BLK_T_OUT requests.
>>>>>> +    request for VIRTIO_BLK_T_OUT and VIRTIO_BLK_T_CRYPTO_OUT requests.
>>>>>
>>>>> More concise: "bitfield in VIRTIO_BLK_T_OUT and VIRTIO_BLK_T_CRYPTO_OUT requests"?
>>>>
>>>> Thanks for your comments!
>>>>
>>>> Does this makes it clear that \field{flags} refers to the field in struct
>>>> \field{virtio_blk_req}. If so, I'm fine with the change.
>>>
>>> Another option is to explicitly state that VIRTIO_BLK_T_OUT uses
>>> virtio_blk_req and VIRTIO_BLK_T_CRYPTO_OUT uses virtio_blk_req_crypto.
>>> That makes the sentence a longer and a bit unwieldy - I guess why you
>>> dropped the reference to virtio_blk_req? It's up to you which approach
>>> you prefer.
>>>
>>
>> Thanks for the comments!
>>
>> I'd like to reword it as:
>>
>>  - bitfield of both \field{virtio_blk_req} (for VIRTIO_BLK_T_OUT requests) and
>>    \field{virtio_blk_req_crypto} (for VIRTIO_BLK_T_CRYPTO_OUT requests).
> 
> Sounds good.
> 
>>
>>>>
>>>>>
>>>>>> +
>>>>>> +\item[VIRTIO_BLK_F_IE (22)] Only when the storage backend supports inline
>>>>>
>>>>> VIRTIO_BLK_F_INLINE_ENCRYPTION is longer but self-describing. I think
>>>>> that name would be clearer.
>>>>
>>>> ACK
>>>>
>>>>>
>>>>>> +    encryption and this feature bit is negotiated, the data read from or
>>>>>> +    written to the device can be decrypted from or encrypted to the storage
>>>>>> +    via inline crypto engine. Keys are provisioned into key slots of the
>>>>>
>>>>> via an inline crypto engine
>>>>
>>>> ACK
>>>>
>>>>>
>>>>>> +    inline crypto engine through a mechanism outside the scope of this device
>>>>>> +    type, and requests identify, by key slot index, which provisioned key to
>>>>>> +    use. The number of key slots, the maximum DUN size and the supported key
>>>>>> +    types are reported in \field{enc_characteristics}.
>>>>>>  
>>>>>>  \end{description}
>>>>>>  
>>>>>> @@ -135,6 +144,12 @@ \subsection{Device configuration layout}\label{sec:Device Types / Block Device /
>>>>>>                  u8 model;
>>>>>>                  u8 unused2[3];
>>>>>>          } zoned;
>>>>>> +        struct virtio_blk_enc_characteristics {
>>>>>> +                le16 max_slots;
>>>>>> +                u8 max_dun_bytes;
>>>>>> +                u8 key_types;
>>>>>> +                le32 unused3;
>>>>>> +        } enc_characteristics;
>>>>>>  };
>>>>>>  \end{lstlisting}
>>>>>>  
>>>>>> @@ -222,6 +237,39 @@ \subsection{Device configuration layout}\label{sec:Device Types / Block Device /
>>>>>>  terminated by the device with a "zone resources exceeded" error as defined for
>>>>>>  specific commands later.
>>>>>>  
>>>>>> +If the VIRTIO_BLK_F_IE feature is negotiated, then in
>>>>>> +\field{virtio_blk_enc_characteristics},
>>>>>> +\begin{itemize}
>>>>>> +\item \field{max_slots} is the number of key slots allocated to the Guest VM.
>>>>>
>>>>> It is preferable to avoid virtualization-specific terminology like
>>>>> Guest, VM, etc. VIRTIO usage has expanded beyond virtualization and the
>>>>> specification tends to use Driver and Device instead of Guest and Host.
>>>>> How about:
>>>>>
>>>>>   ... is the number of available key slots.
>>>>>
>>>>
>>>> ACK
>>>>
>>>>>> +    It MUST not exceed the number of key slots supported by the inline crypto
>>>>>> +    engine of the device backend storage. Key slots are indexed from 0 to
>>>>>
>>>>> The MUST sentence needs to be moved to the device normative section
>>>>> because the non-normative sections of the specification do not have
>>>>> MUST/SHOULD/etc.
>>>>>
>>>>
>>>> ACK
>>>>
>>>>>> +    \field{max_slots} - 1.
>>>>>> +
>>>>>> +\item \field{max_dun_bytes} is the maximum number of bytes of the Data Unit
>>>>>> +    Number (DUN) that the device supports for any of its supported crypto
>>>>>> +    modes. For example, known inline crypto engines report a
>>>>>> +    \field{max_dun_bytes} of 4 (JEDEC eMMC Command Queue Host Controller
>>>>>> +    Interface, CQHCI) or 8 (JEDEC UFS Host Controller Interface, UFSHCI);
>>>>>> +    a device backed by different inline crypto engine hardware MAY report
>>>>>
>>>>> The MAY clause must go in the device normative section. Or you could
>>>>> reword this to something like "but other values are possible depending
>>>>> on the inline crypto engine hardware".
>>>>>
>>>>
>>>> ACK
>>>>
>>>>>> +    a different value, subject to the constraints in
>>>>>> +    \ref{devicenormative:Device Types / Block Device / Device Initialization}.
>>>>>> +
>>>>>> +\item \field{key_types} is a bitmask of the key types the device supports,
>>>>>> +    using the following values:
>>>>>> +    \begin{lstlisting}
>>>>>> +#define VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW    (1 << 0)
>>>>>> +#define VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED  (1 << 1)
>>>>>> +    \end{lstlisting}
>>>>>> +    VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW indicates that keys are provisioned into
>>>>>> +    key slots in raw (plaintext) form. VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED
>>>>>> +    indicates that the key exists only in ephemerally-wrapped form in memory
>>>>>> +    outside of dedicated hardware, and can only be unwrapped and provisioned
>>>>>> +    into key slots by dedicated hardware (e.g. a hardware key manager). The
>>>>>> +    plaintext key never exists in software-accessible memory.
>>>>>
>>>>> Why is this reported here if the virtio-blk interface has no ability to
>>>>> program key slots? I would expect this information to be part of the key
>>>>> programming interface because the extension driver will need to indicate
>>>>> whether it is using raw keys or hardware-wrapped keys. The virtio-blk
>>>>> driver itself will never never use this information?
>>>>>
>>>>
>>>> key_types describes the key types supported by the hardware. Before keyslot
>>>> programming, the key_type requested by the block layer is validated against
>>>> this set, and only the key with supported key types are accepted for the
>>>> subsequent key programming operation.
>>>
>>> I'm still not sure why virtio-blk should report the key types since
>>> virtio-blk will never be configured with the chosen key type. If we
>>> ignore the Linux blk-crypto implementation for a second, is there a
>>> reason why virtio-blk needs to report this information? It seems like
>>> the choice of key types belongs with the keyslot programming interface
>>> where this information is actually used.
>>>
>>
>> Thanks!
>>
>> Even if we set aside the Linux blk-crypto implementation, the frontend still
>> needs a way to determine whether a key type requested by the upper layer is
>> supported by the underlying hardware.
>>
>> Reporting the supported key types through virtio-blk enables the frontend
>> to validate a requested key type before entering the key programming flow.
>> This fail-fast approach allows the system to determine whether hardware
>> inline encryption can be used or whether it should fall back to software
>> encryption, avoiding unnecessary preparation and key programming operations
>> for unsupported key types.
> 
> It's still not clear to me why the virtio-blk device interface reports
> this information rather than the key programming interface. The fact
> that this information is never used by the driver to program the
> virito-blk device suggests that it belongs elsewhere. 
> 
> Doesn't the key programming interface have a way to report this
> information?
> 

Thanks for your comments!

The key programming interface is only used for programming a key into
a selected slot. At that point, the upper layers have already chosen
the hardware inline-encryption path and are attempting to program
the key.

In contrast, the supported key types are device capabilities. The virtio
block driver should use it to initial a crypto profile bound to the virtio
block device. In this way, before key provisioning begins, the frontend can
determine whether a given encryption context can be accelerated by the
underlying hardware.

Thus, the frontend needs access to the supported key types as
part of device capability discovery, rather than learning about them only
when a key programming request is issued. Exposing key_types through the
virtio-blk device capability allows the frontend to perform this
capability check during initialization and construct an appropriate
crypto profile for upper layers.

In addition, the key programming path still validates the key type before
provisioning the key, but that validation serves as a correctness check
rather than a capability discovery mechanism.

>>>>>> +
>>>>>> +\item \field{unused3} is reserved for future use.
>>>>>> +\end{itemize}
>>>>>> +
>>>>>>  \subsubsection{Legacy Interface: Device configuration layout}\label{sec:Device Types / Block Device / Device configuration layout / Legacy Interface: Device configuration layout}
>>>>>>  When using the legacy interface, transitional devices and drivers
>>>>>>  MUST format the fields in struct virtio_blk_config
>>>>>> @@ -285,6 +333,14 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
>>>>>>      \field{zoned} can be read by the driver to determine the zone
>>>>>>      characteristics of the device. All \field{zoned} fields are read-only.
>>>>>>  
>>>>>> +\item If the VIRTIO_BLK_F_IE feature is negotiated, the fields in
>>>>>> +    \field{enc_characteristics} can be read by the driver to determine the
>>>>>> +    inline encryption capabilities of the device, and a
>>>>>> +    VIRTIO_BLK_T_GET_CRYPTO_MODES request (see
>>>>>> +    \ref{sec:Device Types / Block Device / Device Operation}) can be sent
>>>>>> +    to retrieve the set of supported crypto modes. All
>>>>>> +    \field{enc_characteristics} fields are read-only.
>>>>>> +
>>>>>>  \end{enumerate}
>>>>>>  
>>>>>>  \drivernormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
>>>>>> @@ -312,6 +368,10 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
>>>>>>  offered by the device with the VIRTIO_BLK_Z_HA or VIRTIO_BLK_Z_NONE zone model,
>>>>>>  then the driver MAY negotiate these two bits independently.
>>>>>>  
>>>>>> +Zoned devices do not support inline encryption. If the VIRTIO_BLK_F_ZONED
>>>>>> +feature is offered by the device, then the VIRTIO_BLK_F_IE feature MUST NOT
>>>>>> +be negotiated by the driver.
>>>>>> +
>>>>>>  If the VIRTIO_BLK_F_ZONED feature is negotiated, then
>>>>>>  \begin{itemize}
>>>>>>  \item if the driver that can not support host-managed zoned devices
>>>>>> @@ -327,6 +387,12 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
>>>>>>  The driver MUST NOT negotiate VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA without
>>>>>>  VIRTIO_BLK_F_REQ_FLAGS.
>>>>>>  
>>>>>> +Drivers MUST NOT negotiate the VIRTIO_BLK_F_IE feature if they are
>>>>>> +incapable of provisioning keys into the key slots of the device backend
>>>>>> +storage's inline crypto engine, or of conveying the key slot index,
>>>>>> +data unit size in bits, and Data Unit Number (DUN) per request to
>>>>>> +the device using the \field{virtio_blk_crypto_msg} structure.
>>>>>> +
>>>>>>  \devicenormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
>>>>>>  
>>>>>>  Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it
>>>>>> @@ -341,9 +407,15 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
>>>>>>  If the device that is being initialized is a not a zoned device, the device
>>>>>>  SHOULD NOT offer the VIRTIO_BLK_F_ZONED feature.
>>>>>>  
>>>>>> +A zoned device MUST NOT offer the VIRTIO_BLK_F_IE feature.
>>>>>> +
>>>>>>  The VIRTIO_BLK_F_ZONED feature cannot be properly negotiated without
>>>>>>  FEATURES_OK bit. Legacy devices MUST NOT offer VIRTIO_BLK_F_ZONED feature bit.
>>>>>>  
>>>>>> +The VIRTIO_BLK_F_IE feature cannot be properly negotiated without
>>>>>> +FEATURES_OK bit. Legacy devices MUST NOT offer the VIRTIO_BLK_F_IE feature
>>>>>> +bit.
>>>>>> +
>>>>>>  If the VIRTIO_BLK_F_ZONED feature is not accepted by the driver,
>>>>>>  \begin{itemize}
>>>>>>  \item the device with the VIRTIO_BLK_Z_HA or VIRTIO_BLK_Z_NONE zone model SHOULD
>>>>>> @@ -415,6 +487,26 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
>>>>>>  The device MUST NOT acknowledge FEATURES_OK if the driver sets
>>>>>>  VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA without VIRTIO_BLK_F_REQ_FLAGS.
>>>>>>  
>>>>>> +The device MUST NOT acknowledge FEATURES_OK if the driver negotiates both
>>>>>> +VIRTIO_BLK_F_ZONED and VIRTIO_BLK_F_IE.
>>>>>> +
>>>>>> +If the device is incapable of consuming the \field{virtio_blk_crypto_msg},
>>>>>> +the device SHOULD NOT offer the VIRTIO_BLK_F_IE feature.
>>>>>> +
>>>>>> +If the VIRTIO_BLK_F_IE feature is negotiated, the device MUST set
>>>>>> +\field{max_slots} in \field{enc_characteristics} to a value greater than 0.
>>>>>> +
>>>>>> +If the VIRTIO_BLK_F_IE feature is negotiated, the device MUST set
>>>>>> +\field{key_types} in \field{enc_characteristics} to have at least one of
>>>>>> +VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW or VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED
>>>>>> +set, and MUST NOT set any bit in \field{key_types} other than
>>>>>> +VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW and VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED.
>>>>>> +The device MUST initialize padding bytes \field{unused3} to 0.
>>>>>> +
>>>>>> +The device MUST NOT set \field{max_dun_bytes} in \field{enc_characteristics}
>>>>>> +to 0 or to a value greater than 8, since \field{dun} of
>>>>>> +\field{virtio_blk_crypto_msg} is a fixed 8-byte field.
>>>>>> +
>>>>>>  \subsubsection{Legacy Interface: Device Initialization}\label{sec:Device Types / Block Device / Device Initialization / Legacy Interface: Device Initialization}
>>>>>>  
>>>>>>  Because legacy devices do not have FEATURES_OK, transitional devices
>>>>>> @@ -478,8 +570,8 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>>>>>>  value is the bit index in the \field{flags} bitfield):
>>>>>>  
>>>>>>  \begin{description}
>>>>>> -\item[VIRTIO_BLK_REQ_FLAG_OUT_FUA (0) for VIRTIO_BLK_T_OUT requests] Force Unit
>>>>>> -    Access (FUA) flag.
>>>>>> +\item[VIRTIO_BLK_REQ_FLAG_OUT_FUA (0) for VIRTIO_BLK_T_OUT and
>>>>>> +    VIRTIO_BLK_T_CRYPTO_OUT requests] Force Unit Access (FUA) flag.
>>>>>>  \end{description}
>>>>>>  
>>>>>>  The \field{sector} number indicates the offset (multiplied by 512) where
>>>>>> @@ -886,6 +978,108 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>>>>>>  operation by setting the VIRTIO_BLK_S_ZONE_INVALID_CMD value in
>>>>>>  \field{status} of \field{virtio_blk_req} structure.
>>>>>>  
>>>>>> +The following requirements only apply if the VIRTIO_BLK_F_IE feature is
>>>>>> +negotiated.
>>>>>> +
>>>>>> +In addition to the request types defined for devices without inline
>>>>>> +encryption support, the type of the request can be an inline-encrypted read
>>>>>> +(VIRTIO_BLK_T_CRYPTO_IN), an inline-encrypted write (VIRTIO_BLK_T_CRYPTO_OUT)
>>>>>> +or a get crypto modes command (VIRTIO_BLK_T_GET_CRYPTO_MODES).
>>>>>> +
>>>>>> +\begin{lstlisting}
>>>>>> +#define VIRTIO_BLK_T_CRYPTO_OUT        27
>>>>>> +#define VIRTIO_BLK_T_CRYPTO_IN         28
>>>>>> +#define VIRTIO_BLK_T_GET_CRYPTO_MODES  30
>>>>>> +\end{lstlisting}
>>>>>> +
>>>>>> +VIRTIO_BLK_T_CRYPTO_IN and VIRTIO_BLK_T_CRYPTO_OUT requests behave the same
>>>>>> +as VIRTIO_BLK_T_IN and VIRTIO_BLK_T_OUT requests respectively, except that
>>>>>> +the data in \field{data} is decrypted (for VIRTIO_BLK_T_CRYPTO_IN) or is to
>>>>>> +be encrypted (for VIRTIO_BLK_T_CRYPTO_OUT) by the inline crypto engine in
>>>>>> +the device backend storage using the key already provisioned in the key
>>>>>> +slot identified by the request, combined with the request's Data Unit
>>>>>> +Number (DUN). For this reason, the VIRTIO_BLK_T_CRYPTO_IN and
>>>>>> +VIRTIO_BLK_T_CRYPTO_OUT requests have the layout that is extended to have
>>>>>> +the \field{crypto_msg} field to carry this information:
>>>>>> +
>>>>>> +\begin{lstlisting}
>>>>>> +struct virtio_blk_req_crypto {
>>>>>> +        le32 type;
>>>>>> +        le32 flags;
>>>>>> +        le64 sector;
>>>>>> +        struct virtio_blk_crypto_msg crypto_msg;
>>>>>> +        u8 data[];
>>>>>> +        u8 status;
>>>>>> +};
>>>>>> +\end{lstlisting}
>>>>>> +
>>>>>> +\field{crypto_msg} has the following structure:
>>>>>> +
>>>>>> +\begin{lstlisting}
>>>>>> +struct virtio_blk_crypto_msg {
>>>>>> +        le32 slot;
>>>>>> +        le32 data_unit_size_bits;
>>>>>> +        le64 dun;
>>>>>> +};
>>>>>> +\end{lstlisting}
>>>>>> +
>>>>>> +\field{slot} is the virtual key slot index, in the range from 0 to
>>>>>> +\field{max_slots} - 1 of \field{enc_characteristics}. The device maps this
>>>>>> +virtual key slot index to a physical key slot in the inline crypto engine of
>>>>>> +the device backend storage.
>>>>>> +\field{data_unit_size_bits} is $log_2$ of the data unit size in bytes,
>>>>>> +used for calculating DUNs for sub-requests if the request is split.
>>>>>
>>>>> Mention VIRTIO_BLK_T_CRYPTO_MODES here so the reader knows how the
>>>>> driver will pick a data_unit_size_bits value?
>>>>>
>>>>
>>>> Thanks for pointing it out!
>>>>
>>>> The crypto mode and data unit size are configured by fscrypt and propagated
>>>> through the block layer. After validating that the selected combination is
>>>> supported by the hardware, both values are programmed into the keyslot
>>>> configuration registers. Therefore, data_unit_size is associated with the
>>>> programmed key.
>>>>
>>>> Re-write it as
>>>>   - used for calculating DUNs for sub-requests if the request is split.
>>>>     The value corresponds to the data unit size associated with the
>>>>     programmed key and written into the keyslot configuration registers
>>>>     during key programming.
>>>
>>> Thanks.
>>>
>>>>
>>>>
>>>>>> +\field{dun} is the Data Unit Number, that is, the initial value that the
>>>>>> +inline crypto engine increments by one for each successive data unit of
>>>>>> +the size specified by \field{data_unit_size_bits}, while encrypting or
>>>>>> +decrypting the data of the request.
>>>>>> +
>>>>>> +VIRTIO_BLK_T_GET_CRYPTO_MODES is a read request that returns the data unit
>>>>>> +sizes with which each of the device's crypto modes can be used. The
>>>>>> +response consists of a header followed by zero or more \field{le32}
>>>>>> +bitmask elements, indexed by crypto mode number:
>>>>>> +
>>>>>> +\begin{lstlisting}
>>>>>> +struct virtio_blk_crypto_modes {
>>>>>> +        le32   nr_modes;
>>>>>> +        u8     reserved[4];
>>>>>> +        le32   modes[];
>>>>>> +};
>>>>>> +\end{lstlisting}
>>>>>> +
>>>>>> +The device sets \field{nr_modes} in the response header to the number of
>>>>>> +fully transferred \field{modes} elements in the data buffer. \field{modes[N]},
>>>>>> +for crypto mode number N, is a bitmask indicating the data unit sizes with
>>>>>> +which crypto mode N can be used by the device: the i'th bit of
>>>>>> +\field{modes[N]} is set if crypto mode N can be used with a data unit size
>>>>>> +of $(1 << i)$ bytes. A value of 0 for a \field{modes} element indicates
>>>>>> +that the device does not support the corresponding crypto mode at all.
>>>>>> +Crypto mode number 0 is reserved; \field{modes[0]} is always set to 0 by
>>>>>> +the device.
>>>>>> +
>>>>>> +Crypto mode numbers are assigned by this specification, independently of
>>>>>> +any operating system's internal representation of crypto algorithms, so
>>>>>> +that support for additional crypto modes can be added in future revisions
>>>>>> +of this specification without changing the meaning of previously assigned
>>>>>> +numbers:
>>>>>> +
>>>>>> +\begin{lstlisting}
>>>>>> +#define VIRTIO_BLK_CRYPTO_MODE_AES_256_XTS        1
>>>>>> +#define VIRTIO_BLK_CRYPTO_MODE_AES_128_CBC_ESSIV  2
>>>>>> +#define VIRTIO_BLK_CRYPTO_MODE_ADIANTUM           3
>>>>>> +#define VIRTIO_BLK_CRYPTO_MODE_SM4_XTS            4
>>>>>> +\end{lstlisting}
>>>>>> +
>>>>>> +A driver or device implementation MAY support only a subset of these
>>>>>> +crypto modes. Crypto mode numbers already assigned by this or an earlier
>>>>>> +version of this specification are never reused for a different crypto
>>>>>> +mode; additional crypto modes are assigned new numbers, greater than the
>>>>>> +highest number defined by the version of this specification the
>>>>>> +implementation supports.
>>>>>> +
>>>>>> +VIRTIO_BLK_T_CRYPTO_IN and VIRTIO_BLK_T_GET_CRYPTO_MODES requests are reads,
>>>>>> +and VIRTIO_BLK_T_CRYPTO_OUT requests are writes.
>>>>>> +
>>>>>>  \drivernormative{\subsubsection}{Device Operation}{Device Types / Block Device / Device Operation}
>>>>>>  
>>>>>>  The driver SHOULD check if the content of the \field{capacity} field has
>>>>>> @@ -904,8 +1098,8 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>>>>>>  A driver MUST set \field{sector} to 0 for a VIRTIO_BLK_T_FLUSH request.
>>>>>>  A driver SHOULD NOT include any data in a VIRTIO_BLK_T_FLUSH request.
>>>>>>  
>>>>>> -The length of \field{data} MUST be a multiple of 512 bytes for VIRTIO_BLK_T_IN
>>>>>> -and VIRTIO_BLK_T_OUT requests.
>>>>>> +The length of \field{data} MUST be a multiple of 512 bytes for VIRTIO_BLK_T_IN,
>>>>>> +VIRTIO_BLK_T_OUT, VIRTIO_BLK_T_CRYPTO_IN and VIRTIO_BLK_T_CRYPTO_OUT requests.
>>>>>>  
>>>>>>  The length of \field{data} MUST be a multiple of the size of struct
>>>>>>  virtio_blk_discard_write_zeroes for VIRTIO_BLK_T_DISCARD,
>>>>>> @@ -984,6 +1178,42 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>>>>>>  
>>>>>>  \end{enumerate}
>>>>>>  
>>>>>> +The following requirements only apply if the VIRTIO_BLK_F_IE feature is
>>>>>> +negotiated.
>>>>>> +
>>>>>> +A driver MUST NOT submit a VIRTIO_BLK_T_CRYPTO_IN or VIRTIO_BLK_T_CRYPTO_OUT
>>>>>> +request with a \field{slot} value that is not less than \field{max_slots} of
>>>>>
>>>>> "not less" -> "greater" (too many negatives in this MUST NOT sentence :))
>>>>>
>>>>
>>>> ACK
>>>>
>>>> As \field{slot} starts from 0, correct the statement to
>>>>
>>>>   - request with a \field{slot} value that is greater than \field{max_slots} of
>>>>     \field{enc_characteristics} - 1,
>>>>
>>>>>> +\field{enc_characteristics}, or that identifies a key slot into which no key
>>>>>> +has been provisioned.
>>>>>> +
>>>>>> +A driver MUST set \field{data_unit_size_bits} of a VIRTIO_BLK_T_CRYPTO_IN or
>>>>>> +VIRTIO_BLK_T_CRYPTO_OUT request's \field{crypto_msg} to $log_2$ of the data
>>>>>> +unit size in bytes associated with the key provisioned in the virtual key
>>>>>> +slot identified by \field{slot}. Since data unit sizes are reported by
>>>>>> +VIRTIO_BLK_T_GET_CRYPTO_MODES as a bitmask of \field{le32} elements, a
>>>>>> +driver MUST NOT set \field{data_unit_size_bits} to a value greater than 31.
>>>>>> +
>>>>>> +A driver MUST NOT submit a VIRTIO_BLK_T_CRYPTO_IN or VIRTIO_BLK_T_CRYPTO_OUT
>>>>>> +request with a zero length \field{data}.
>>>>>
>>>>> Does VIRTIO_BLK_T_WRITE_ZEROES need an equivalent
>>>>> VIRTIO_BLK_T_CRYPTO_WRITE_ZEROES request type? If the driver sends
>>>>> VIRTIO_BLK_T_WRITE_ZEROES then the device might write zeroes in
>>>>> plaintext, which isn't what we want.
>>>>>
>>>>
>>>> Yes, it's still cipher text that is flushed into disk even the driver sends
>>>> VIRTIO_BLK_T_WRITE_ZEROES. Need add a VIRTIO_BLK_T_CRYPTO_WRITE_ZEROES request
>>>> type.
>>>>
>>>>>> +
>>>>>> +A driver MUST NOT submit a VIRTIO_BLK_T_CRYPTO_IN or VIRTIO_BLK_T_CRYPTO_OUT
>>>>>> +request unless \field{sector}, multiplied by 512, and the length of
>>>>>> +\field{data}, are both a multiple of $(1 << \field{data_unit_size_bits})$
>>>>>> +bytes.
>>>>>> +
>>>>>> +A driver MUST NOT submit a VIRTIO_BLK_T_CRYPTO_IN or VIRTIO_BLK_T_CRYPTO_OUT
>>>>>> +request if \field{dun} + $N$ - 1 is not representable in
>>>>>> +\field{max_dun_bytes} bytes, where $N$ is the number of data units of
>>>>>> +$2^{\field{data_unit_size_bits}}$ bytes in \field{data}.
>>>>>> +
>>>>>> +A driver MUST treat any crypto mode number that is not less than
>>>>>
>>>>> "not less" -> "greater"
>>>>>
>>>>
>>>> ACK
>>>>
>>>>>> +\field{nr_modes} of a VIRTIO_BLK_T_GET_CRYPTO_MODES response as unsupported
>>>>>> +by the device.
>>>>>> +
>>>>>> +A driver MUST provide a \field{data} buffer of at least
>>>>>> +sizeof(struct virtio_blk_crypto_modes) (8) bytes for a
>>>>>> +VIRTIO_BLK_T_GET_CRYPTO_MODES request.
>>>>>> +
>>>>>>  \devicenormative{\subsubsection}{Device Operation}{Device Types / Block Device / Device Operation}
>>>>>>  
>>>>>>  The device MAY change the content of the \field{capacity} field during
>>>>>> @@ -1030,7 +1260,8 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>>>>>>  
>>>>>>  \item\label{item:flush3} the VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA feature was
>>>>>>    negotiated and the VIRTIO_BLK_REQ_FLAG_OUT_FUA bit in \field{flags} was set in
>>>>>> -  the write request (regardless of whether the VIRTIO_BLK_F_FLUSH or
>>>>>> +  the write request (VIRTIO_BLK_T_OUT or VIRTIO_BLK_T_CRYPTO_OUT, regardless of
>>>>>> +  whether the VIRTIO_BLK_F_FLUSH or
>>>>>>    VIRTIO_BLK_F_CONFIG_WCE features were negotiated, and regardless of the
>>>>>>    current cache mode as expressed by the value of the \field{writeback} field in
>>>>>>    configuration space).
>>>>>> @@ -1225,6 +1456,60 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>>>>>>  handles VIRTIO_BLK_T_ZONE_RESET request for the zone range specified in the
>>>>>>  VIRTIO_BLK_T_SECURE_ERASE request.
>>>>>>  
>>>>>> +The following requirements only apply if the VIRTIO_BLK_F_IE feature is
>>>>>> +negotiated.
>>>>>> +
>>>>>> +If a VIRTIO_BLK_T_CRYPTO_IN or VIRTIO_BLK_T_CRYPTO_OUT request:
>>>>>> +\begin{itemize}
>>>>>> +\item specifies a \field{slot} value that is not less than \field{max_slots},
>>>>>> +    or that identifies a key slot into which no key has been provisioned,
>>>>>> +
>>>>>> +\item specifies a \field{data_unit_size_bits} value greater than 31, or
>>>>>> +    that does not match $log_2$ of the data unit size in bytes associated
>>>>>> +    with the key provisioned in the virtual key slot identified by the
>>>>>> +    \field{slot},
>>>>>> +
>>>>>> +\item specifies a zero length \field{data},
>>>>>> +
>>>>>> +\item specifies a \field{sector}, multiplied by 512, or a length of
>>>>>> +    \field{data}, that is not a multiple of $(1 << \field{data_unit_size_bits})$
>>>>>> +    bytes, or
>>>>>> +
>>>>>> +\item specifies a \field{dun} such that \field{dun} + $N$ - 1 is not
>>>>>> +    representable in \field{max_dun_bytes} bytes, where $N$ is the number
>>>>>> +    of data units of $2^{\field{data_unit_size_bits}}$ bytes in
>>>>>> +    \field{data},
>>>>>> +\end{itemize}
>>>>>> +then the device MUST set the \field{status} byte to VIRTIO_BLK_S_UNSUPP and
>>>>>> +MUST NOT read or write any data.
>>>>>> +
>>>>>> +If a VIRTIO_BLK_T_GET_CRYPTO_MODES request's \field{data} buffer is smaller
>>>>>> +than sizeof(struct virtio_blk_crypto_modes) (8) bytes, the device MUST set
>>>>>> +the \field{status} byte to VIRTIO_BLK_S_UNSUPP and MUST NOT write any data.
>>>>>> +
>>>>>> +If the driver's \field{data} buffer in a VIRTIO_BLK_T_GET_CRYPTO_MODES
>>>>>> +request is not large enough to hold \field{modes} elements up to the
>>>>>> +highest crypto mode number the device supports, the device MUST set
>>>>>> +\field{nr_modes} to the number of complete \field{modes} elements that fit
>>>>>> +in the buffer, and MUST NOT write a partial element.
>>>>>
>>>>> This interface offers no way to query the maximum crypto mode. It seems
>>>>> the assumption is that this will never be needed since the driver
>>>>> hardcodes VIRTIO_BLK_CRYPTO_MODE_* values. It would be more flexible to
>>>>> define VIRTIO_BLK_T_GET_CRYPTO_MODES in a way that queries the device's
>>>>> maximum crypto mode index.
>>>>>
>>>>> The nr_modes field is kind of redundant anyway since the device fills
>>>>> modes[] elements with 0 when the mode is not supported and the driver
>>>>> determines the buffer size (it will not look any further). So the device
>>>>> doesn't really need to tell the driver how many modes were filled in,
>>>>> but it's potentially more useful to tell the driver what the highest
>>>>> crypto mode index is so the driver can size its data buffer correctly in
>>>>> the next VIRTIO_BLK_T_GET_CRYPTO_MODES request.
>>>>>
>>>>> I don't feel strongly about this, but it seems more flexible and it's
>>>>> easy to get this into the spec now, rather than later.
>>>>>
>>>>
>>>> Thanks for the comments.
>>>>
>>>> I agree that exposing the highest crypto mode index would allow the driver
>>>> to allocate the correct buffer size for a subsequent
>>>> VIRTIO_BLK_T_GET_CRYPTO_MODES request.
>>>>
>>>> However, this would imply that a particular crypto mode could be unsupported
>>>> for file-based encryption on one virtio-blk device while being supported on
>>>> another. That does not seem to be a meaningful use case.
>>>>
>>>> Given that AES-256-XTS is currently the only crypto mode with actual hardware
>>>> support, as Eric pointed out, I wonder whether we could simply define all
>>>> inline-encryption crypto modes directly in the virtio specification. In that
>>>> case, the driver would always know the exact buffer size in advance,
>>>> eliminating the need to query the highest mode index. If additional crypto
>>>> modes gain hardware support in the future, the virtio specification could be
>>>> extended accordingly.
>>>
>>> Fair enough, there is no real need for the driver to detect crypto modes
>>> it doesn't know about since they have hardcoded semantics and cannot be
>>> detected at runtime with knowledge of those hardcoded semantics.
>>>
>>> Adding a new crypto mode in the future would involve:
>>> - Adding a VIRTIO_BLK_T_CRYPTO_MODE_FOO feature bit for the new mode
>>>   and a new VIRTIO_BLK_CRYPTO_MODE_FOO constant.
>>> - Old drivers will not negotiate the new feature bit and they will not
>>>   provide enough modes[] elements in VIRTIO_BLK_T_GET_CRYPTO_MODES to
>>>   fetch information about that mode.
>>> - New drivers will need to be updated to negotiate the new feature bit
>>>   and provide enough modes[] elements in VIRTIO_BLK_T_GET_CRYPTO_MODES
>>>   to fetch information about that mode.
>>>
>>> That seems okay. We don't expect many modes to be added.
>>>
>>
>> Thanks!
>>
>> I don't think a new feature bit is needed when a new crypto mode is added,
>> because VIRTIO_BLK_F_INLINE_ENCRYPTION already gates the whole mechanism,
>> and the index of supported crypto modes is already defined in the virtio
>> sepec.
>>
>> Assume that VIRTIO_BLK_F_INLINE_ENCRYPTION has been negotiated.
>>
>> Initially, both the frontend and backend implement the same version of
>> the virtio specification. The frontend allocates a buffer large enough
>> to hold all crypto modes defined by that specification version, and the
>> backend fills the entire buffer accordingly.
>>
>> During future upgrades, there are several possible compatibility scenarios:
>>
>>   1. Both frontend and backend are upgraded to the same newer specification
>>      version
>>      Both sides recognize the same set of crypto modes. The frontend provides
>>      a buffer large enough for all supported modes, and the backend fills it
>>      completely. No compatibility issue arises.
>>
>>   2. Frontend and backend support different specification versions
>>      - Frontend supports more crypto modes than the backend
>>        The frontend allocates a larger buffer. The backend only reports the
>>        crypto modes it recognizes and fills the remaining buffer entries as 0.
>>        No compatibility issue arises.
>>
>>      - Frontend supports fewer crypto modes than the backend
>>        The backend determines the number of entries that can fit in the buffer
>>        provided by the frontend and populates the buffer with the corresponding
>>        subset of its crypto mode list. Any additional crypto modes supported only
>>        by the newer backend are simply not reported. No compatibility issue arises.
>>
>> I'd be interested to hear your thoughts on this. If you agree with the
>> approach and don't have any further concerns, I'll send a v3 series.
>> Patch v2 already addresses most of the issues you pointed out.
> 
> You are right. I'm glad we discussed this and it will be possible to add
> more crypto modes in the future in a compatible way.
> 

Thanks! I am glad we have reached the agreement for it.

I'll move forward with this conclusion.

>>>>>> +
>>>>>> +The device MUST initialize padding bytes \field{reserved} of a
>>>>>> +VIRTIO_BLK_T_GET_CRYPTO_MODES response to 0.
>>>>>> +
>>>>>> +For a VIRTIO_BLK_T_CRYPTO_IN or VIRTIO_BLK_T_CRYPTO_OUT request, the device
>>>>>> +MUST use the key provisioned in the virtual key slot identified by
>>>>>> +\field{slot} of the request's \field{crypto_msg}, combined with \field{dun},
>>>>>> +to decrypt the data read from, or encrypt the data written to, the device
>>>>>> +backend storage. If the device backend storage splits the request into
>>>>>> +sub-requests, each sub-request MUST begin at a byte offset, from the start
>>>>>> +of \field{data}, that is a multiple of $(1 << \field{data_unit_size_bits})$
>>>>>> +bytes, MUST have a length that is a multiple of
>>>>>> +$(1 << \field{data_unit_size_bits})$ bytes, and MUST use, in place of
>>>>>> +\field{dun}, the Data Unit Number
>>>>>> +$\field{dun} + (\mathit{byte\_offset} / (1 << \field{data_unit_size_bits}))$,
>>>>>> +where $\mathit{byte\_offset}$ is that sub-request's starting byte offset
>>>>>> +from the start of \field{data}.
>>>>>> +
>>>>>>  \subsubsection{Legacy Interface: Device Operation}\label{sec:Device Types / Block Device / Device Operation / Legacy Interface: Device Operation}
>>>>>>  When using the legacy interface, transitional devices and drivers
>>>>>>  MUST format the fields in struct virtio_blk_req
>>>>>> -- 
>>>>>> 2.34.1
>>>>>>
>>>>
>>

