Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28446263C8F
	for <virtio-dev@lists.linux.dev>; Sat, 14 Feb 2026 07:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771053768; cv=none; b=J4G5ygNzU2Gd+woYln43gMbc754XfnWtTYqNRc2MCf8HFCf71upz9P0kX8a0TYKUWrOmwZeAlj6reGJoXrSwt5cjl0rsF9w2Vg9abHj9PLDcLVHzLosL6OMDBYqCtSaiDEmmtUwO7OSS/F/XFNHkv1yqFak9HSOchA5t74J/W7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771053768; c=relaxed/simple;
	bh=lTB/JRX2ENmRRMWdXXvMDFFalS6GaI9h6WpUwfIs6lg=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BGTfuqu3pYMby6X+rmJ9uSMQvXvScNWjKzP6+LYtUd1KKhRq6zXDf+R1tsJcjq+t1BhBpBlacdPMVwyojKS1jtJQmJx9Qagcpo1vMk4fzTeaR23b2Bqb4s6mO/Dek+raHABhztiwZFEwwBhLl8h3Z9TXt++zjnQgnLaWLPEiGAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RH48aE+4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VjsunauJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RH48aE+4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VjsunauJ"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61E3ZDDi1260219
	for <virtio-dev@lists.linux.dev>; Sat, 14 Feb 2026 07:22:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pJBmwE4c+VIP+7EKeok6n4kT0ctoBcezUlAuwLcBbP0=; b=RH48aE+4bDV4LkfR
	R/MbiWBppSsRFunbnDqAoKGvs0LItEaQfsGNYvUaSjtqpa7vz0v+iq3M8lEgj4g7
	naG8Vq9JOLZX16MNLXv1nY4T8mBZ6aSpV0XTeNrn5aeMgJOLmnbyDLWJ4THtrU7s
	GCVxbHjcPUiedyl80BAhextbuuRDyvGBcTYnAA9HHkxkwoigY78fpuRDJckesdMx
	dTp26gt+wI3Am1LJP+8iKfioFbQIH+FO3f5Lt1Po9wWLF1A1WMNBHptZuntAYX2m
	E/JnD//rflCNvpCyLAHR0mOPLrcbxI9PiJywtgzYDd2lzw3Q3OTyfaHkGZfwvcyO
	Hle1KA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cah930adg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Sat, 14 Feb 2026 07:22:44 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c5291b89733so1314906a12.0
        for <virtio-dev@lists.linux.dev>; Fri, 13 Feb 2026 23:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771053764; x=1771658564; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pJBmwE4c+VIP+7EKeok6n4kT0ctoBcezUlAuwLcBbP0=;
        b=VjsunauJzQzPHD8D6q+K9CirJ73kD/2GPekfFxN13gXkdWkgBbViUdL9B7OgVa/wvI
         mLLZ1DeTasz4jhcr9TDy3Tb5CAdLmsJwOhFjx8op0ty50e2oFrOnwkkrusKFUvWmpjxH
         HhoYILaARfrA7BZLMGEWDZCUFzHrc4DrRcFdsIRTu+cZtv1BFxjls2b7w1QiiIoTIvus
         5ul+CtI6qiTsMXfaXLofK8a2w3mp6Qc8rItVCeC+PKpJYaIlBGs+MTPbE2LG7ifAI/Hn
         aXYy2wQfEmidjALTOa/8W+WDw7kvv/wrzDiPumKu48Gep+rK0LKkpZkIKdPtez3DIC7E
         c2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771053764; x=1771658564;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pJBmwE4c+VIP+7EKeok6n4kT0ctoBcezUlAuwLcBbP0=;
        b=Uce3MPoZcjQQHUkOfEXLW9OKI9m3oRtpqs4kPSdl54+55EyuSj7QrN+EWwX04OqjeW
         0tP5MbVr+S3dBTJfx94lducARi+69a7lIC2qCWf6Tj+INUJXJoVBleL+SkCaAa3tNcy3
         iABwtHw8Qr+SdAYezntYbpZb49JnPGZysp83uEjyjPIXd7A3wrG3KmkvavoOICuOWJNg
         yYxnBk1Fvl3CEQTMbB+LIee1h+sKvzMVRc7zdgdy2rQ6HiyySmN/5ZTXOJ+MAYXynILc
         mXb5ZX4FLhuIsMG6HXqeAHB+3SVOL+PWR9ORUAXeAUnxlCDGhgS0UAr3/ErZ0MbFG4+N
         tPBQ==
X-Gm-Message-State: AOJu0YyKWkIjtqtnyxZ4ld/w1BJSDubegubTkQIbHCOW2RyUy/swfbV8
	pR49IaAhR4VkFCBzA1KdrMUClDo6k/g8D9E/44ZJbGS34fQ2fUh4MhdaZpzDU3CGrtJq8Ol3UBG
	IInbNUUoL9KeBAfiZWoY4fVQG0iA21Gkr2I1rTYxYae4v6b9McMIZR1gsSbSPOoE92rrAAG/Uoi
	Y=
X-Gm-Gg: AZuq6aLKr9CL3qLwc1ikdvevYcgWDqiGkTgbfWqOuWbTS5ULhUg/eaDr1I697bSxDPX
	zeYJSJRKAS9kfQwxduQbtOO7kTlTVmhwxhN9HMWdQKigDgYj/fYhBkJ+Myz9Bm40rUoIMLEPl5X
	lSliqSQHWrJUduIpAFPlBlqAS4oWZg1jbQgdiStRhQjscc5Mybs5ismx9A6XBvtSACanBLLS1Gg
	4m+px3YTaYQ3TJDg0hMtCEd4fLVQC7VLM/cSugiycORV2PunF0I9ZyJXO00oDce0g+J7GrBjuNg
	nIahqzXg/lPhvw5df0nGmW4jwNVGZC5XRoIvQLXO9ixCUu3tn7vUcbtU5pZ5hvm7iiG0rMer0nj
	5s5wyI9IsPi/dvUa9gOxsiAZO9/bZrmyiJOFa8gVoJQOOorV8ZGtIG6CF
X-Received: by 2002:a05:6a00:158b:b0:81c:92ec:ccf3 with SMTP id d2e1a72fcca58-824c94a0946mr4008500b3a.19.1771053763854;
        Fri, 13 Feb 2026 23:22:43 -0800 (PST)
X-Received: by 2002:a05:6a00:158b:b0:81c:92ec:ccf3 with SMTP id d2e1a72fcca58-824c94a0946mr4008482b3a.19.1771053763180;
        Fri, 13 Feb 2026 23:22:43 -0800 (PST)
Received: from [192.168.0.109] ([183.198.161.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6a2c6b1sm4655827b3a.10.2026.02.13.23.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 23:22:42 -0800 (PST)
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
X-Google-Original-From: Linlin Zhang <linllin.zhang@oss.qualcomm.com>
Message-ID: <fa458358-90c8-408c-a860-8bfdb11658bb@oss.qualcomm.com>
Date: Sat, 14 Feb 2026 15:22:21 +0800
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] virtio-blk: Add inline encryption support
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.linux.dev, quic_dshaikhu@quicinc.com
References: <20260210083208.472824-1-linlin.zhang@oss.qualcomm.com>
 <20260210083208.472824-2-linlin.zhang@oss.qualcomm.com>
 <20260210211842.GA158755@fedora>
Content-Language: en-US
In-Reply-To: <20260210211842.GA158755@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: WFyRCDP1Wz6TY3UxWLPLMoGOL8KROJwr
X-Authority-Analysis: v=2.4 cv=IdiKmGqa c=1 sm=1 tr=0 ts=699022c5 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=KMp1NlSGHhKXgsdGuDW/Tg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=20KFwNOVAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=sG0xULyZH6W0yMdJom8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE0MDA1NiBTYWx0ZWRfX2MCD0cToydZA
 zvKfB6NvyFzlg0B8j1BBhFo30VMv+p/m0sVmORL/ejldax3wPOghgD7R0QoG072UsXQ9QSU4lD6
 /OUl0gPQHymhMef0TzHJy/kTFgLY8M9EcgeuTLN0C816kffHniNYbreAAfjDzDv6d1uBPhjsxA/
 iFV6SBatewFYM9H64gBtdWG7Bg+f5yRMXV6pzxrR2bVORuhoDpE0ImIZyfVnNA0x1Kf5W/v9hCK
 vPqcUwnz0f/HIE8tRsVYQj144+r1Iw6ZqJbftC9L6dm8hTnqjxecsp9FTgJKn0bzdFBse7z/da8
 fSAqbILPGt+ShBVTXTATDNf3h4dBUoZz5suAncWhqnnymW1t6AJx6qxqPDtO3ocxfxqhD8ZNj7c
 uRvVxcp19QGA1umpTdRuAZ/ebic+RooJTKMGvhhB+oeVjMncZm0opBUXFNWdKwTQ0dqk7MtNR9x
 DgVJzW5Pw6phVu7EAsA==
X-Proofpoint-ORIG-GUID: WFyRCDP1Wz6TY3UxWLPLMoGOL8KROJwr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_05,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0 suspectscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602140056



On 2/11/2026 5:18 AM, Stefan Hajnoczi wrote:
> On Tue, Feb 10, 2026 at 12:32:08AM -0800, Linlin Zhang wrote:
>> Inline encryption on virtio block can only be supported when
>> the new feature bit VIRTIO_BLK_F_ICE is negotiated.
>>
>> Extend struct virtio_blk_config and struct virtio_blk_req,
>> so that crypto capabilities can be got in the frontend and
>> encryption metadata can be sent to the backend, together with
>> each I/O transaction.
>>
>> About the inline encryption on UFS or eMMC storage, please
>> refer to the Linux inline encryption documentation:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/block/inline-encryption.rst
>>
>> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/238
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: linlzhan <quic_linlzhan@quicinc.com>
>> Signed-off-by: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
>> ---
>>  device-types/blk/description.tex | 110 ++++++++++++++++++++++++++++++-
>>  1 file changed, 108 insertions(+), 2 deletions(-)
>>
>> diff --git a/device-types/blk/description.tex b/device-types/blk/description.tex
>> index 2712ada..60f46af 100644
>> --- a/device-types/blk/description.tex
>> +++ b/device-types/blk/description.tex
>> @@ -66,6 +66,11 @@ \subsection{Feature bits}\label{sec:Device Types / Block Device / Feature bits}
>>  	(ZNS). For brevity, these standard documents are referred as "ZBD standards"
>>  	from this point on in the text.
>>  
>> +\item[VIRTIO_BLK_F_ICE(22)] Inline Crypto Extensions are supported. Only when this
>> +     feature bit is negotiated, the device need expose crypto characteristics in
>> +     configuration space and the driver need provide an extended request header
>> +     containing a crypto payload for block I/O.
> 
> Most of the feature bit descriptions are brief and the details are
> covered later in the spec. I suggest doing this here too:
> 
>   \item[VIRTIO_BLK_F_ICE (22)] Device supports Inline Crypto Engine functionality.
> 
> I changed the name from Inline Crypto Extensions to Inline Crypto Engine
> because that terminology is used in the Linux kernel. Web search results
> also favor "inline crypto engine" over "inline crypto extensions". Are
> you okay with "engine"?
Thanks! ACK

> 
>> +
>>  \end{description}
>>  
>>  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Block Device / Feature bits / Legacy Interface: Feature bits}
>> @@ -128,6 +133,10 @@ \subsection{Device configuration layout}\label{sec:Device Types / Block Device /
>>                  u8 model;
>>                  u8 unused2[3];
>>          } zoned;
>> +        struct virtio_blk_crypto_characteristics {
>> +                __virtio16 slot_info;
>> +                __virtio16 reserved;
>> +        } crypto;
>>  };
>>  \end{lstlisting}
>>  
>> @@ -215,6 +224,18 @@ \subsection{Device configuration layout}\label{sec:Device Types / Block Device /
>>  terminated by the device with a "zone resources exceeded" error as defined for
>>  specific commands later.
>>  
>> +If the VIRTIO_BLK_F_ICE feature is negotiated, then in
>> +\field{virtio_blk_crypto_characteristics},
>> +\begin{itemize}
>> +\item \field{slot_info} value packs two 8-bits values to reduce the number of
> 
> 8-bits -> 8-bit

ACK

> 
>> +    Configuration Space reads.
>> +    \begin{itemize}
>> +        \item Bits~\[15:8] (\emph{max\_slots}): the maximum number of supported
>> +            crypto key slots.
>> +        \item Bits~\[7:0] (\emph{slot\_offset}): an offset applied to slot numbering.
> 
> What is the purpose of slot_offset? This field is not used much in this
> spec, maybe it can be removed?
> 
> Does that mean only slots in the range [slot_offset:max_slots) are
> available or does it mean that the range is
> [slot_offset:slot_offset+max_slots)?

Only slots within the range [slot_offset, slot_offset + max_slots) are accessible to the
VM. The slot_offset specifies the base physical ICE slot allocated to the VM and is used
to translate a virtual slot index into a physical slot.

Because the GVM programs and evicts keys directly—without host/PVM involvement—it must
supply the resolved physical slot when invoking key operations in TrustZone or the Secure
VM.

> 
>> +    \end{itemize}
>> +\end{itemize}
>> +
>>  \subsubsection{Legacy Interface: Device configuration layout}\label{sec:Device Types / Block Device / Device configuration layout / Legacy Interface: Device configuration layout}
>>  When using the legacy interface, transitional devices and drivers
>>  MUST format the fields in struct virtio_blk_config
>> @@ -278,6 +299,10 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
>>      \field{zoned} can be read by the driver to determine the zone
>>      characteristics of the device. All \field{zoned} fields are read-only.
>>  
>> +\item If the VIRTIO_BLK_F_ICE feature is negotiated, the fields in
>> +    \field{crypto} can be read by the driver to determine the inline crypto
>> +    characteristics of the device. All \field{crypto} fields are read-only.
>> +
>>  \end{enumerate}
>>  
>>  \drivernormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
>> @@ -317,6 +342,9 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
>>      driver SHOULD ignore all other fields in \field{zoned}.
>>  \end{itemize}
>>  
>> +If the VIRTIO_BLK_F_ICE feature is negotiated, then the driver MUST validate
>> +    the max_slots in \field{slot_info} before the slot usage.
> 
> I'm not sure how the driver is supposed to validate max_slots?

It means the diver validate the virtual slot doesn't exceed the max_slots before translating
this virtual slot to a physical slot by using slot_offset. 

Can I rewrite it as the following?

  If the VIRTIO_BLK_F_ICE feature is negotiated, then the driver MUST validate that
  the virtual slot received from upper layer doesn't exceed the max_slots in
  \field{slot_info} before the slot usage.

> 
>> +
>>  \devicenormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
>>  
>>  Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it
>> @@ -402,6 +430,13 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
>>  \item the device MUST initialize padding bytes \field{unused2} to 0.
>>  \end{itemize}
>>  
>> +If the VIRTIO_BLK_F_ICE feature is negotiated, then the fields in \field{crypto}
>> +struct in the configuration space MUST be set by the device.
>> +\begin{itemize}
>> +\item the \field{slot_info} field of \field{crypto} MUST be set by the device to a
>> +    max_slots in the higher 8 bits and slot_offset in the lower 8 bits.
>> +\end{itemize}
> 
> There is no need for the \begin{itemize} here. It contains no new
> information. The fields were already described in the configuration
> space section and the previous sentence already said that the fields in
> \field{crypto} must be set by the device.

ACK, remove this \begin{itemize} here.

> 
>> +
>>  \subsubsection{Legacy Interface: Device Initialization}\label{sec:Device Types / Block Device / Device Initialization / Legacy Interface: Device Initialization}
>>  
>>  Because legacy devices do not have FEATURES_OK, transitional devices
>> @@ -436,6 +471,13 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>>          le32 type;
>>          le32 reserved;
>>          le64 sector;
>> +        struct virtio_blk_crypto_payload {
>> +            u8 slot;
>> +            u8 activate;
>> +            le16 reserved1;
>> +            le32 reserved2;
>> +            le64 data_unit_num;
>> +        } payload;
> 
> "payload" is a generic term. crypto_payload would be clearer.
> 
> I wonder whether consistently calling this feature "ice" rather than
> "crypto" would help in case self-encrypting drive or other cryptographic
> functionality is added to virtio-blk in the future. That way the spec
> items related to inline crypto engine functionality will be easy to
> differentiate from other crypto functionality.

Ok, to differentiate ICE and other cryptographic functionality, can I modify it as

  struct virtio_blk_ice_payload {
      u8 slot;
      u8 activate;
      le16 reserved1;
      le32 reserved2;
      le64 data_unit_num;
  } ice_payload;

> 
>>          u8 data[];
>>          u8 status;
>>  };
>> @@ -445,8 +487,9 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>>  (VIRTIO_BLK_T_OUT), a discard (VIRTIO_BLK_T_DISCARD), a write zeroes
>>  (VIRTIO_BLK_T_WRITE_ZEROES), a flush (VIRTIO_BLK_T_FLUSH), a get device ID
>>  string command (VIRTIO_BLK_T_GET_ID), a secure erase
>> -(VIRTIO_BLK_T_SECURE_ERASE), or a get device lifetime command
>> -(VIRTIO_BLK_T_GET_LIFETIME).
>> +(VIRTIO_BLK_T_SECURE_ERASE), a get device lifetime command
>> +(VIRTIO_BLK_T_GET_LIFETIME), or a get device crypto capabilities command
>> +(VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES).
>>  
>>  \begin{lstlisting}
>>  #define VIRTIO_BLK_T_IN           0
>> @@ -457,12 +500,27 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>>  #define VIRTIO_BLK_T_DISCARD      11
>>  #define VIRTIO_BLK_T_WRITE_ZEROES 13
>>  #define VIRTIO_BLK_T_SECURE_ERASE   14
>> +#define VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES   27
> 
> The Linux virtio_blk.c driver assumes that odd numbered constants have
> data buffers that are read by the device, so you may run into a bug when
> using 27.
> 
> There is an informal convention to use even numbers for read requests
> and odd numbers for write requests. It doesn't hurt to try to follow the
> convention even though it's not strictly necessary.
> 
> The Linux driver could be fixed when adding support for ICE, but 16 is
> available and it's safest to use that.

OK. Agree to following the convention. But 16, 18,20,22,24,26 are already used by
zone device. Seems 12 is available. Correct it to 12.

 #define VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES   12

> 
>>  \end{lstlisting}
>>  
>>  The \field{sector} number indicates the offset (multiplied by 512) where
>>  the read or write is to occur. This field is unused and set to 0 for
>>  commands other than read, write and some zone operations.
>>  
>> +The \field{payload} consists of the encryption information for current
>> +request. It is only present when the VIRTIO_BLK_F_ICE feature is negotiated and
>> +\field{type} is VIRTIO_BLK_T_IN, VIRTIO_BLK_T_OUT or VIRTIO_BLK_T_FLUSH.
> 
> TODO think about layout

rewrite to the following

  The \field{ice_payload} consists of the encryption information for current
  request. When VIRTIO_BLK_F_ICE is negotiated, the request header layout becomes
  that struct virtio_blk_outhdr includes \field{ice_payload} as a fixed-size
  extension. For non-ICE requests (or types not using crypto), the driver MUST
  set \field{ice_payload} to 0 and device ignores them.

> 
>> +\begin{itemize}
>> +\item The \field{slot} field in \field{payload} indicates the ICE
>> +  (Inline Crypto Encryption) slot index where the key resides.
>> +
>> +\item The \field{activate} field in \field{payload} implies this is a
>> +  inline encryption request.
>> +
>> +\item The \field{data_unit_num} field in \field{payload} indicates the
>> +  starting block of the request.
> 
> This is a block device, so the term "block" needs to be qualified to
> avoid confusion. I guess this is the cryptography concept of a block
> rather than the disk concept of a block. Please clarify this in the
> text, maybe by explaining that the ICE handles data in fixed-size "data
> units" instead of using the word "block".
> 
> Also, can you explain the relationship between the data unit number and
> the sector? In simple cases I imagine the data unit number would be the
> sector. How is the driver supposed to pick or calculate the data unit
> number?

The data unit number is the starting IV for AES crypto in ICE hardware, it's
a stable value for I/O request targeting to same storage range. It can be set
to the file logic block number or the starting sector of BIO. 

The upper layer calculates it and passes it to virtio_blk driver in this patch.
ICE uses the data unit number and data unit size (the granularity to use for
en/decryption) to derive the next data unit number for the next cryptography
block. data unit number in ICE increase 1 per data unit size. For instance,
  data unit number = 2048
  data unit size = 1024 bytes
For the first 1024 bytes of the transaction, ICE hardware encrypt the data
with IV equal to 2048.
For the second 1024 bytes of the transaction, ICE hardware encrypt the data
with IV equal to (2048+1=)2049.

Rewrite it as bellow.

  \item The \field{data_unit_num} field in \field{ice_payload} indicates the
  starting IV. It can be the file logic block number or the starting sector
  of BIO.

> 
>> +\end{itemize}
>> +
>>  VIRTIO_BLK_T_IN requests populate \field{data} with the contents of sectors
>>  read from the block device (in multiples of 512 bytes).  VIRTIO_BLK_T_OUT
>>  requests write the contents of \field{data} to the block device (in multiples
>> @@ -530,6 +588,47 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>>  The \field{device_lifetime_est_typ_b} refers to wear of MLC cells and is provided
>>  with the same semantics as \field{device_lifetime_est_typ_a}.
>>  
>> +VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES requests fetch the storage hardware crypto
>> +capabilities into \field{data}. And the \field{data} is of the form
> 
> How does VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES behave when data[] is too
> small to fit all the device's crypto capabilities?

Add a new field capability_num to the Configuration space header. The total size of
\field{data} shall be computed as:
  data_size=capability_num×capability_size
where capability_size is the size (in bytes) of one capability structure. Therefore, \field{data} contains exactly capability_num contiguous capability entries, each of length capability_size.
Add a capability_num field in Configuration space. So it use size per capability
multiply capability_num to define the size of \field{data}.

Rewrite it as the following.

  VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES requests fetch the storage hardware crypto
  capabilities into \field{data}. The crypto capabilities is a zero-padded array
  up to (\field{capability_num}×capability_size) bytes long, where capability_size
  is the size (in bytes) of one capability structure which is in form of
  
  \begin{lstlisting}
    struct virtio_blk_crypto_cap {
        u8 alg;
        u8 data_unit_size;
        u8 key_size;
        u8 reserved;
    };
  \end{lstlisting}
  
  \begin{itemize}
      \item The \field{alg} implies crypto algorithm identifiers.
      The device supports reporting and negotiating cryptographic algorithms
      using the following algorithm identifiers:
      \begin{lstlisting}
          CRYPTO_ALG_AES_XTS              = 0x0
          CRYPTO_ALG_BITLOCKER_AES_CBC    = 0x1
          CRYPTO_ALG_AES_ECB              = 0x2
          CRYPTO_ALG_ESSIV_AES_CBC        = 0x3
      \end{lstlisting}
      These identifiers abstract the underlying hardware crypto implementation
      and does not assume any operating‑system‑specific data structures or
      constants.
      \item The \field{data_unit_size} implies the mask of data unit size. When
      bit j in this field (j=7......0) is set, a data unit size of 512*2^j bytes
      is selected.
      \item The \field{key_size} is the crypto key size identifiers.
      \begin{lstlisting}
          CRYPTO_KEY_SIZE_INVALID     = 0x0
          CRYPTO_KEY_SIZE_128_BITS    = 0x1
          CRYPTO_KEY_SIZE_192_BITS    = 0x2
          CRYPTO_KEY_SIZE_256_BITS    = 0x3
          CRYPTO_KEY_SIZE_512_BITS    = 0x4
      \end{lstlisting}
      \item The \field{reserved} is unused.
  \end{itemize}
  
  If the \field{data} is too short, it sets status to BLK_S_IO_ERR.

> 
>> +
>> +\begin{lstlisting}
>> +struct virtio_blk_crypto_caps {
>> +  u8 size;
>> +  le32 crypto_capabilities[];
>> +};
>> +\end{lstlisting}
>> +
>> +The \field{size} specifies the size of array \field{crypto_capabilities}.
> 
> "number of elements" would be clearer than "size of array" because the
> unit (bytes vs array elements) is ambiguous.
> 
> The size field is not necessary since Used Ring descriptors contain
> (struct virtq_used_elem in the spec) a len field indicating how many
> bytes were written by the device.

Remove virtio_blk_crypto_caps in above modification.

> 
>> +The \field{crypto_capabilities} indicates the crypto capabilities supported by the
>> +hardware storage for inline encryption.
>> +
>> +A crypto capability packs four 8-bits values:
>> +\begin{itemize}
>> +    \item Bits~\[31:24]: crypto algorithm identifiers.
>> +    The device supports reporting and negotiating cryptographic algorithms
>> +    using the following algorithm identifiers:
>> +    \begin{lstlisting}
>> +        CRYPTO_ALG_AES_XTS              = 0x0
>> +        CRYPTO_ALG_BITLOCKER_AES_CBC    = 0x1
>> +        CRYPTO_ALG_AES_ECB              = 0x2
>> +        CRYPTO_ALG_ESSIV_AES_CBC        = 0x3
>> +    \end{lstlisting}
>> +    These identifiers abstract the underlying hardware crypto implementation
>> +    and does not assume any operating‑system‑specific data structures or
>> +    constants.
>> +    \item Bits~\[23:16]: mask of data unit size. When bit j in this field
>> +    (j=7......0) is set, a data unit size of 512*2^j bytes is selected.
> 
> Is only one bit ever set in the mask? If so, then maybe just express j
> as an 8-bit unsigned integer (i.e. the exponent in 512*2^j) instead of
> as a bit mask. It's simpler and increases the range for j.

Yes, it's encoded in one-hot encoding. If j is expressed as an 8-bit unsigned integer,
it will confused the reader that more than one bit can be set in the mask of data unit
size. right? 

> 
>> +    \item Bits~\[15:8]: crypto key size identifiers.
>> +    \begin{lstlisting}
>> +        CRYPTO_KEY_SIZE_INVALID     = 0x0
>> +        CRYPTO_KEY_SIZE_128_BITS    = 0x1
>> +        CRYPTO_KEY_SIZE_192_BITS    = 0x2
>> +        CRYPTO_KEY_SIZE_256_BITS    = 0x3
>> +        CRYPTO_KEY_SIZE_512_BITS    = 0x4
>> +    \end{lstlisting}
>> +    \item Bits~\[7:0]: unused.
>> +\end{itemize}
> 
> A struct would be more natural here (the rest of the VIRTIO
> specification rarely packs fields into an integer):
> 
>   struct virtio_blk_crypto_cap {
>       u8 alg;
>       u8 data_unit_size;
>       u8 key_size;
>       u8 reserved;
>   };

ACK, see above rewrite statement.

> 
> By the way, Linux seems to call this a "profile" rather than a
> "capability". Do you want to use the same name as Linux for consistency?

blk-crypto-profile is the keyslot manager which manage the usage of keyslot and
also checks if the key configuration set by upper layer can be supported by the
ICE hardware. While the capability aims to illustrate the capability provided by
the ICE hardware. What we expected is the capability used to initialized
blk-crypto-profile in Guest VM.

> 
>> +
>>  The final \field{status} byte is written by the device: either
>>  VIRTIO_BLK_S_OK for success, VIRTIO_BLK_S_IOERR for device or driver
>>  error or VIRTIO_BLK_S_UNSUPP for a request unsupported by device:
>> @@ -912,6 +1011,13 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>>  successfully, failed, or were processed by the device at all if the request
>>  failed with VIRTIO_BLK_S_IOERR.
>>  
>> +The length of \field{data} MUST be a multiple of 4 bytes plus 1 for
>> +VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES requests.
>> +
>> +A driver MUST set \field{activate} to 1 for VIRTIO_BLK_T_IN,VIRTIO_BLK_T_OUT,
>> +    and VIRTIO_BLK_T_FLUSH requests that require inline encryption. For other
>> +    request types or when inline encryption is not required, it is set to 0.
>> +
>>  The following requirements only apply if the VIRTIO_BLK_F_ZONED feature is
>>  negotiated.
> 
> How does the driver assign a specific capability (algorithm, data unit
> size, and key size tuple reported by
> VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES) to a slot?
> 
> How does the driver assign the key material for a slot?

blk layer will initialize a blk_crypto_key based on the configuration received from
FS layer. This blk_crypto_key contains expected algorithm, data unit size and key size expected
by the upper layer. When submit_bio, blk_mq tries to program the key included in blk_crypto_key
to the ICE hardware slot via blk_crypto_profile. During programming the key, it will compare 
the algorithm, data unit size and key size in blk_crypto_key with the capability exposed by ICE
hardware.

It will follow bellow flow to assign the key material for a slot.
  blk_crypto_profile -> virtio_blk driver -> virtio_blk extention -> SCM driver -> TZ

That means the driver only maintain the capability in RAM, use it when programming key.

> 
> Stefan

