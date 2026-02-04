Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3E03D5237
	for <virtio-dev@lists.linux.dev>; Wed,  4 Feb 2026 13:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770213441; cv=none; b=HI8uMLVyCa5Pd11IZsEBMl0oQCsxasb2vmmmX4BeZjnTdAV0zLDR+pNN3g95RNrMQDgmeyTDwLETMC1INiMKexWuVKCv3ZF+qdMnois6CXseaN3JKbIUFGlJrxcxmhVxM9AkWc12/cMsamuSDKr4EdeBXqpqjixyAhz123rCNR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770213441; c=relaxed/simple;
	bh=/MKZbqySAKxDP+hs7q1+VlXROZ2adjc6qbOi3U1wLlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BzLxT2hYsJd8Nnx7ryxFd9kmtT0Lyr0Dqo20qaVO8UQAf/nNw8lMHzoZa6RLKNZjc09J0TX+iRFqK6bMDkY6RsTzt7cKXZUDnBk8DPL8qEqVAHHcCWQCviWPbwrIA9Yf2FfcMlNB1Tz/EB7G5k4/Hl7EaSh1QbReGeZzd6hyIEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=l+cFNNp+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="l+cFNNp+"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614CIbB0716186;
	Wed, 4 Feb 2026 13:57:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Xn+9c+4xQutuyL/noZ6FI/HzIowdO8zTmpADvrMaqEQ=; b=l+cFNNp+WzgOgJb9
	E8AzeNi7IS5fCBuO+Ws6K9NalSaPLQf74AJzJqocUJsGL40SUamvW5E2UCz4YbaN
	TE0qC0jxYx+vfc3GhkjXDxLF3JEAFZtKydgrW7WbAHDJVsUjAwxrMsb/T6A/wOb/
	S0e+YNVyoFNvOQGgdchJ98KBr3NKgpff/JKhu8ZYFtU06S7LN+Uy3WLtq3pegRrM
	tiGZnxkdqh54VeKDBd/Gd1Ca4SWFk93KPzZRRT0w1yrbNfgwirdiwZin+zPVqYUB
	D+9Pgf2+50f8QRFNVqOusuKyjpiD/2zrFStjI50R2RLbSpLxUxSye1Xw2F1e+XSz
	D254YA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c3nf63ens-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Feb 2026 13:57:19 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 614DvIpP007931
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Feb 2026 13:57:18 GMT
Received: from [10.231.241.142] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Feb
 2026 05:57:15 -0800
Message-ID: <694c4abd-b86b-4bc4-8d84-588bfb059d6c@quicinc.com>
Date: Wed, 4 Feb 2026 21:57:11 +0800
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] virtio-blk: Add inline encryption support
To: Stefan Hajnoczi <stefanha@redhat.com>
CC: <virtio-dev@lists.linux.dev>, <quic_dshaikhu@quicinc.com>
References: <20260127141432.2617357-1-quic_linlzhan@quicinc.com>
 <20260127142032.2619551-1-quic_linlzhan@quicinc.com>
 <20260127210951.GA96301@fedora>
 <b95cf6c4-db73-49e4-969e-fa7735a07527@quicinc.com>
 <20260202155622.GA405548@fedora>
 <a704fabe-c4cb-4aa0-8460-2c57980650be@quicinc.com>
 <20260203144321.GA445116@fedora>
Content-Language: en-US
From: Linlin Zhang <quic_linlzhan@quicinc.com>
In-Reply-To: <20260203144321.GA445116@fedora>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7zJ5ueL7q2260YbTGZDrqKp_dH_Egqfo
X-Proofpoint-ORIG-GUID: 7zJ5ueL7q2260YbTGZDrqKp_dH_Egqfo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDEwNiBTYWx0ZWRfX08poM1nXnhW+
 G1D3maQfA3kPUWcDJcOrXoacNtcJn4p82xu6wm3Ur43ddth8HTzPoQPup/bpLAZxYNSaD+fQkJ2
 +/tO/csNMQW5ULjsokt+xVuqxeZJIFkXKmRsDUYVsjiLR5bGiRh9TvVJ7HbtXjPHC+bB3z+xTyo
 KAEbV6jJ2rut4LFOvcJjTLmY5yM63yoKrDeJ9ELuBdw6VZFrE6PhkQlfqRojAPcLkDUPhliVvEk
 iHbIv8jUutfNakApCvLHYtjGdGDVptSKy21Oqpey6hhvJdfETEmCu1DdaAQrfETmW8LcEwJy4A+
 4e2nJeWLgwRfkqC8D3gkO9IEbgjWvb3vIo8P5efgF7eeYorgI0AAayYUS0HkZoRKaLmY+LA1Gzp
 qm2gPe2DAJkN/ZDCKCZjjX6LZH1/vTsiGmuYuU1uRX1LF3yZRkNJ7nWJmr00c0cYuo71hi1eOGw
 nOvDVTC11tSjMZTtK6A==
X-Authority-Analysis: v=2.4 cv=doTWylg4 c=1 sm=1 tr=0 ts=6983503f cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8pif782wAAAA:8 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8
 a=COk6AnOGAAAA:8 a=GHTh3x3OGVomrad6bCYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_04,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602040106



On 2/3/2026 10:43 PM, Stefan Hajnoczi wrote:
> On Tue, Feb 03, 2026 at 06:06:33PM +0800, Linlin Zhang wrote:
>>
>>
>> On 2/2/2026 11:56 PM, Stefan Hajnoczi wrote:
>>> On Fri, Jan 30, 2026 at 06:23:55PM +0800, Linlin Zhang wrote:
>>>> Thank you for the review. I’ve added some clarifications and potential updates.
>>>> Could you please take another look before I send a new patch?
>>>>
>>>> On 1/28/2026 5:09 AM, Stefan Hajnoczi wrote:
>>>>> On Tue, Jan 27, 2026 at 10:20:32PM +0800, Linlin Zhang wrote:
>>>>>> From: linlzhan <quic_linlzhan@quicinc.com>
>>>>>>
>>>>>> Inline encryption on virtio block can only be supported when
>>>>>> the new feature bit VIRTIO_BLK_F_ICE is negotiated.
>>>>>>
>>>>>> Extend struct virtio_blk_config and struct virtio_blk_req,
>>>>>> so that crypto capabilities can be got in the frontend and
>>>>>> encryption metadata can be sent to the backend, together with
>>>>>> each I/O transaction.
>>>>>
>>>>> This looks like a Self-Encrypting Drives feature along the lines of TCG
>>>>> Opal:
>>>>> https://en.wikipedia.org/wiki/Opal_Storage_Specification
>>>>>
>>>>> Would it make sense to implement TCG Opal instead of defining a new
>>>>> interface? That would make this more familiar to users and simplify
>>>>> integration into existing tools like sedutil and cryptsetup (e.g. by
>>>>> supporting the <linux/sed-opal.h> ioctl interface).
>>>>
>>>> This patch is for the FBE (File Based Encryption) support on UFS/EMMC
>>>> storage with ICE (Inline Crypto Engine) enabled. TCG Opal is only applicable
>>>> to SED (self-encrypting drives), not applicable to ICE (Inline Crypto Engine).
>>>>
>>>> In Automotive or Embedded scenario, UFS/EMMC generally is used. The disk
>>>> encryption on them is supported by the ICE pipeline of SOC, rather SSD
>>>> controller, so we couldn't use TCG Opal here.
>>>
>>> Okay. Is there a specification that this interface needs to comply with?
>>>
>>> If not, you can include a link to the Linux inline encryption
>>> documentation in the commit description:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/block/inline-encryption.rst
>>>
>>> Having a reference will will help the discussion. That way we can be
>>> confident the VIRTIO spec changes will be widely useful beyond a single
>>> use case and easy to implement in drivers because they follow an
>>> existing interface.
>>
>> ACK
>>
>>>
>>>>
>>>>>
>>>>>> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/238
>>>>>>
>>>>>> Change-Id: Ic23b2137e5d9a599d826e06c279f1b614d79abdf
>>>>>> Signed-off-by: linlzhan <quic_linlzhan@quicinc.com>
>>>>>> ---
>>>>>>  device-types/blk/description.tex | 69 ++++++++++++++++++++++++++++++++
>>>>>>  1 file changed, 69 insertions(+)
>>>>>>
>>>>>> diff --git a/device-types/blk/description.tex b/device-types/blk/description.tex
>>>>>> index 2712ada..23d8dc0 100644
>>>>>> --- a/device-types/blk/description.tex
>>>>>> +++ b/device-types/blk/description.tex
>>>>>> @@ -66,6 +66,11 @@ \subsection{Feature bits}\label{sec:Device Types / Block Device / Feature bits}
>>>>>>  	(ZNS). For brevity, these standard documents are referred as "ZBD standards"
>>>>>>  	from this point on in the text.
>>>>>>  
>>>>>> +\item[VIRTIO_BLK_F_ICE(22)] Inline Crypto Extensions are supported. When this
>>>>>> +     is negotiated, the device exposes crypto characteristics in configuration
>>>>>> +     space and the driver SHALL provide an extended request header containing a
>>>>>
>>>>> SHALL, MUST, MAY, etc are only used in the normative sections of the
>>>>> spec.
>>>>>
>>>>> Why "SHALL"? Does this mean the device must be prepared to receive
>>>>> requests without the payload field when VIRTIO_BLK_F_ICE is negotiated?
>>>>> How should the device behave in that case: fail the request or perform
>>>>> I/O without crypto?
>>>>
>>>> This section - 5.2.3 Feature bits - is a normative section.
>>>
>>> \section{Block Device}\label{sec:Device Types / Block Device}
>>> ...
>>> \subsection{Feature bits}\label{sec:Device Types / Block Device / Feature bits}
>>>
>>> No, this is a non-normative section. The normative sections are the
>>> "Device Requirements" (\devicenormative) and "Driver Requirements"
>>> (\drivernormative) sections.
>>
>> OK, as this is a non-normative section, can I use lowercase 'shall', 'must'.etc here?
> 
> I think that is discouraged to prevent confusion. It can be phrased in a
> descriptive way instead:
> 
>   and the driver provides an extended request header containing a ...
> 
>>
>>>
>>>>
>>>> What's expected for VIRTIO_BLK_F_ICE feature bit is that configuration space
>>>> must be prepared with the exposed crypto characteristics and the virtio block
>>>> frontend must sent a virtblk request with encryption metadata packed into
>>>> when VIRTIO_BLK_F_ICE is negotiated and hardware crypto is supported.
>>>>
>>>> By replacing 'SHALL' with 'MUST' here, Is the following rewording fine?
>>>>
>>>>   Inline Crypto Extensions are supported. When this is negotiated, the device MUST
>>>>   expose crypto characteristics in configuration space and the driver MUST provide
>>>>   an extended request header containing a crypto payload for block I/O if the
>>>>   hardware supports inline crypto. If this feature bit is negotiated, but hardware
>>>>   inline crypto doesn't support, the device SHOULD perform I/O without crypto.
>>>>
>>>> I'll add hw_enabled (type: u8) to virtio_blk_crypto_characteristics to indicate
>>>> whether the host supports hardware inline encryption.
>>>
>>> I still have a question about this: why would a device advertise
>>> VIRTIO_BLK_F_ICE but report hw_enabled = 0? I'm not sure how this is
>>> functionally different from a device that does not report
>>> VIRTIO_BLK_F_ICE. It seems simpler for devices to only advertise
>>> VIRTIO_BLK_F_ICE when they support inline encryption.
>>
>> ACK.
>> Previously I assume VIRTIO_BLK_F_ICE is negotiated even ICE (Inline Crypto Engine)
>> isn't enabled. Seems it isn't needed. a device should only advertise
>> VIRTIO_BLK_F_ICE when ICE is enabled. Correct the statement as the following.
>>
>>   Inline Crypto Extensions are supported. Only when this feature b is negotiated, the device need
>>   expose crypto characteristics in configuration space and the driver need provide
>>   an extended request header containing a crypto payload for block I/O. 
> 
> Good.
> 
>>
>>>
>>>>>
>>>>>> +     crypto payload for block I/O.
>>>>>> +
>>>>>>  \end{description}
>>>>>>  
>>>>>>  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Block Device / Feature bits / Legacy Interface: Feature bits}
>>>>>> @@ -128,6 +133,11 @@ \subsection{Device configuration layout}\label{sec:Device Types / Block Device /
>>>>>>                  u8 model;
>>>>>>                  u8 unused2[3];
>>>>>>          } zoned;
>>>>>> +        struct virtio_blk_crypto_characteristics {
>>>>>> +                __virtio16 slot_info;
>>>>>> +                __virtio16 reserved;
>>>>>> +                __virtio32 capability;
>>>>>> +        } crypto;
>>>>>>  };
>>>>>>  \end{lstlisting}
>>>>>>  
>>>>>> @@ -215,6 +225,25 @@ \subsection{Device configuration layout}\label{sec:Device Types / Block Device /
>>>>>>  terminated by the device with a "zone resources exceeded" error as defined for
>>>>>>  specific commands later.
>>>>>>  
>>>>>> +If the VIRTIO_BLK_F_ICE feature is negotiated, then in
>>>>>> +\field{virtio_blk_crypto_characteristics},
>>>>>> +\begin{itemize}
>>>>>> +\item \field{slot_info} value packs two 8-bits values:
>>>>>> +    \begin{itemize}
>>>>>> +        \item Bits~\[15:8] (\emph{max\_slots}): the maximum number of supported
>>>>>> +            crypto key slots.
>>>>>> +        \item Bits~\[7:0] (\emph{slot\_offset}): an offset applied to slot numbering.
>>>>>> +    \end{itemize}
>>>>>> +\item \field{capability} value packs four 8-bits values:
>>>>>> +    \begin{itemize}
>>>>>> +        \item Bits~\[31:24]: crypto algorithm id.
>>>>>> +        \item Bits~\[23:16]: mask of data unit size.
>>>>>> +        \item Bits~\[15:8]: crypto key size.
>>>>>> +        \item Bits~\[7:0]: unused.
>>>>>> +    \end{itemize}
>>>>>
>>>>> Why are these fields packed? Configuration Space can have u8 fields.
>>>>
>>>> Given that &sect. 4.2.2.2 saying "For the device-specific configuration space,
>>>> the driver MUST use 8 bit wide accesses for 8 bit wide fields, 16 bit wide
>>>> and aligned accesses for 16 bit wide fields and 32 bit wide and aligned
>>>> accesses for 32 and 64 bit wide fields.",  these fields are packed for a
>>>> efficient read from the configuration space.
>>>
>>> I see. I suggest mentioning this explicitly: "value packs two 8-bits
>>> values to reduce the number of Configuration Space reads".
>>
>> ACK
>>
>>>
>>>>>
>>>>> These fields are not sufficiently documented. Where are the crypto
>>>>> algorithm ids listed, etc?
>>>>
>>>> Can I reword it as the following?
>>>
>>> Yes, looks good in general. I have some comments below.
>>>
>>>>
>>>>   \item Bits~\[31:24]: crypto algorithm identifiers.
>>>>   The device SHALL support reporting and negotiating cryptographic
>>>>   algorithms using the following algorithm identifiers:
>>>>   \begin{lstlisting}
>>>>       CRYPTO_ALG_AES_XTS              = 0x0
>>>>       CRYPTO_ALG_BITLOCKER_AES_CBC    = 0x1
>>>>       CRYPTO_ALG_AES_ECB              = 0x2
>>>>       CRYPTO_ALG_ESSIV_AES_CBC        = 0x3
>>>>   \end{lstlisting}
>>>>   These identifiers abstract the underlying hardware crypto implementation
>>>>   and MUST NOT assume any operating‑system‑specific data structures or
>>>>   constants.
>>>
>>> (The MUST NOT part needs to be in a \devicenormative or \drivernormative
>>> sections, but I think "MUST NOT" can be replaced with "does not" here
>>> because it actually describes the design of the interface rather than
>>> imposing requirements on device implementors.)
>>
>> ACK
>>
>>>
>>>>   \item Bits~\[23:16]: mask of data unit size. When bit j in this field
>>>>   (j=0......7)is set, a data unit size of 512*2^j bytes is slected.
>>>
>>> s/)is set/) is set/
>>> s/slected/selected/
>>
>> ACK
>>
>>>
>>> How is the data unit size used? Does it affect the allowed request sizes
>>> of the device?
>>>
>>> For example, if the mask is 0x2, so that mean request sizes must be
>>> multiples of 1 KiB?
>>
>> The data unit size is only used in the control flow of programing a key into
>> ICE slot. It hasn't impact on the virtblk request size.
>> For instance, if the mask is 0x2, so that mean the encryption granularity is
>> (2^1 * 512 = ) 1024 bytes. I.e. ICE hardware increase DUN (Date Unit Number)
>> per 1024 bytes to do encryption/decryption.
> 
> Okay.
> 
>>
>>>
>>> By the way, I'm not sure whether "j=0......7" mean that a mask value of
>>> 0x2 has j=1 or j=6? Usually bits are numbered right-to-left from least
>>> significant bit to most significant bit.
>>
>> A mask value of 0x2 has j=1. It comply with right-to-left number sequence.
> 
> Okay. It might be clearer to write "j=7......0" so the right-to-left
> numbering is shown.

Okay

> 
>>
>>>
>>>>   \item Bits~\[15:8]: crypto key size identifiers.
>>>>   \begin{lstlisting}
>>>>       CRYPTO_KEY_SIZE_INVALID     = 0x0
>>>>       CRYPTO_KEY_SIZE_128_BITS    = 0x1
>>>>       CRYPTO_KEY_SIZE_192_BITS    = 0x2
>>>>       CRYPTO_KEY_SIZE_256_BITS    = 0x3
>>>>       CRYPTO_KEY_SIZE_512_BITS    = 0x4
>>>>   \end{lstlisting}
>>>>
>>>>>
>>>>> How can a device support multiple algorithms? I think Configuration
>>>>> Space may not be flexible enough for this. You could introduce a
>>>>> GET_CRYPTO_INFO request type that allows the driver to fetch arrays of
>>>>> crypto algorithm characteristics.
>>>>
>>>> Virtio block driver need register crypto capability for request_queue of
>>>> virtio block device. That means virtio block frontend need get crypto
>>>> capability before virtio block device is ready. But the request can only
>>>> be sent after the virtio block device is ready. Thus I think it's impossible
>>>> to get such capabilities from the backend via a new request type, event
>>>> though the hardware in the host may support a few algorithms (the actual
>>>> number of algorithms will change depending on the vendor manufacturer.).
>>>> Thus I assume the host only configure and expose one hardware crypto
>>>> capability to the virtual machine and virtio block frontend gets is
>>>> through configuration space.
>>>
>>> The zoned storage feature also needs to use the virtqueues during driver
>>> initialization in order to report zones. Here is the Linux virtio_blk.c
>>> driver code:
>>>
>>> static int virtblk_probe(struct virtio_device *vdev)
>>> {
>>> ...
>>>     virtio_device_ready(vdev);
>>>
>>>     /*
>>>      * All steps that follow use the VQs therefore they need to be
>>>      * placed after the virtio_device_ready() call above.
>>>      */
>>>     if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
>>>         (lim.features & BLK_FEAT_ZONED)) {
>>>             err = blk_revalidate_disk_zones(vblk->disk);
>>>             if (err)
>>>                     goto out_cleanup_disk;
>>>     }
>>>
>>>     err = device_add_disk(&vdev->dev, vblk->disk, virtblk_attr_groups);
>>>
>>> Is it possible to call blk_crypto_register() between
>>> virtio_device_read() and device_add_disk()?
>>
>> Thanks! Referring to zoned storage feature, if we use the virtqueues to
>> get crypto capabilities, we need extend in_hdr in struct virtblk_req to
>> add new fields for crypto capability. Like the following field
>> crypto_append. Is it fine? 
>> we can not use a fixed-size array for crypto capabilities. Because the
>> number of the capabilities differs for different OEMs and storage devices.
>>
>>   struct virtblk_req {
>>       /* Out header */
>>       struct virtio_blk_outhdr out_hdr;
>>   
>>       /* In header */
>>       union {
>>           u8 status;
>>   
>>           /*
>>           * The zone append command has an extended in header.
>>           * The status field in zone_append_in_hdr must always
>>           * be the last byte.
>>           */
>>           struct {
>>               __virtio64 sector;
>>               u8 status;
>>           } zone_append;
>>
>>           struct {
>>               u8 num;
>>               __virtio32 *capabilities;
>>           } crypto_append;
> 
> This is not necessary. Take a look at virtblk_get_id(). It maps the
> id_str buffer so the device can DMA the disk's serial number. The serial
> number field is treated as a data read buffer, not as an in_hdr field.
> 
> Here is how it could work:
> 
>   struct virtio_blk_outhdr {
>       .type = VIRTIO_BLK_T_GET_CRYPTO_PROFILES,
>       .ioprio = 0,
>       .sector = 0
>   };
> 
>   struct virtio_blk_crypto_profile profiles[MAX_PROFILES];
> 
>   u8 status;
> 
> The device fills in profiles[], sets the used buffer element's len field
> to the number of bytes filled in, and sets the status field to
> VIRTIO_BLK_S_OK.
> 
> If profiles[] is too short, it sets status to BLK_S_IO_ERR. The driver
> is expected to increase the size (e.g. double the buffer) and try again.
> Alternatively there could be a num_crypto_profiles field in
> Configuration Space.
> 
> (Many variations are possible. For example, virtio_blk_outhdr's sector
> field could be an offset into the list of profiles, allowing the driver
> to page through profiles without allocating a buffer large enough to
> hold all profiles at a time. But that's probably unnecessary, so I would
> keep it simple.)

Thanks for the clarification! I'll update it in the next patch.

> 
>>       } in_hdr;
>>   
>>       size_t in_hdr_len;
>>   
>>       struct sg_table sg_table;
>>       struct scatterlist sg[];
>>   };
>>
>>>
>>>>
>>>>>
>>>>>> +\end{itemize}
>>>>>> +
>>>>>> +
>>>>>>  \subsubsection{Legacy Interface: Device configuration layout}\label{sec:Device Types / Block Device / Device configuration layout / Legacy Interface: Device configuration layout}
>>>>>>  When using the legacy interface, transitional devices and drivers
>>>>>>  MUST format the fields in struct virtio_blk_config
>>>>>> @@ -278,6 +307,10 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
>>>>>>      \field{zoned} can be read by the driver to determine the zone
>>>>>>      characteristics of the device. All \field{zoned} fields are read-only.
>>>>>>  
>>>>>> +\item If the VIRTIO_BLK_F_ICE feature is negotiated, the fields in
>>>>>> +    \field{crypto} can be read by the driver to determine the inline crypto
>>>>>> +    characteristics of the device. All \field{crypto} fields are read-only.
>>>>>> +
>>>>>>  \end{enumerate}
>>>>>>  
>>>>>>  \drivernormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
>>>>>> @@ -317,6 +350,9 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
>>>>>>      driver SHOULD ignore all other fields in \field{zoned}.
>>>>>>  \end{itemize}
>>>>>>  
>>>>>> +If the VIRTIO_BLK_F_ICE feature is negotiated, then the driver must validate
>>>>>> +    the max_slots in \field{slot_info} before the slot usage.
>>>>>> +
>>>>>>  \devicenormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
>>>>>>  
>>>>>>  Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it
>>>>>> @@ -402,6 +438,16 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
>>>>>>  \item the device MUST initialize padding bytes \field{unused2} to 0.
>>>>>>  \end{itemize}
>>>>>>  
>>>>>> +If the VIRTIO_BLK_F_ICE feature is negotiated, then the fields in \field{cryto}
>>>>>
>>>>> s/cryto/crypto/
>>>>
>>>> Thanks for the correction. Update it in new patch.
>>>>
>>>>>
>>>>>> +struct in the configuration space MUST be set by the device.
>>>>>> +\begin{itemize}
>>>>>> +\item the \field{slot_info} field of \field{crypto} MUST be set by the device to a
>>>>>> +    max_slots in the higher 8 bits and slot_offset in the lower 8 bits.
>>>>>> +
>>>>>> +\item the \field{capability} field of \field{crypto} MUST be set by the device
>>>>>> +    to a crypto capability read from the storage register.
>>>>>> +\end{itemize}
>>>>>> +
>>>>>>  \subsubsection{Legacy Interface: Device Initialization}\label{sec:Device Types / Block Device / Device Initialization / Legacy Interface: Device Initialization}
>>>>>>  
>>>>>>  Because legacy devices do not have FEATURES_OK, transitional devices
>>>>>> @@ -436,6 +482,13 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>>>>>>          le32 type;
>>>>>>          le32 reserved;
>>>>>>          le64 sector;
>>>>>> +        struct virtio_blk_crypto_payload {
>>>>>> +            u8 slot;
>>>>>> +            u8 activate;
>>>>>> +            le16 reserved1;
>>>>>> +            le32 reserved2;
>>>>>> +            le64 data_unit_num;
>>>>>> +        } payload;
>>>>>>          u8 data[];
>>>>>>          u8 status;
>>>>>>  };
>>>>>> @@ -463,6 +516,20 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>>>>>>  the read or write is to occur. This field is unused and set to 0 for
>>>>>>  commands other than read, write and some zone operations.
>>>>>>  
>>>>>> +The \field{payload} consists of the encryption information for current
>>>>>> +request. It need to be set by the driver only when the feature VIRTIO_BLK_F_ICE
>>>>>> +is negotiated.
>>>>>
>>>>> "set" is ambiguous: does it meaning filling in the fields or does it
>>>>> mean the fields are only present when VIRTIO_BLK_F_ICE is negotiated
>>>>> (this distinction is important if other features add more fields after
>>>>> payload in the future).
>>>>>
>>>>> The sentence could be reworded:
>>>>>
>>>>>   It is only present when the VIRTIO_BLK_F_ICE feature is negotiated and
>>>>>   \field{type} is VIRTIO_BLK_T_IN or VIRTIO_BLK_T_OUT.
>>>>>
>>>>> (I'm not sure whether DISCARD, WRITE_ZEROES, or SECURE_ERASE also need
>>>>> the payload field. It seems like GET_ID and GET_LIFETIME do not need the
>>>>> payload field.)
>>>>
>>>> Accept and update it as the following.
>>>>
>>>>   It is only present when the VIRTIO_BLK_F_ICE feature is negotiated and
>>>>   +\field{type} is VIRTIO_BLK_T_IN, VIRTIO_BLK_T_OUT or VIRTIO_BLK_T_FLUSH.
>>>
>>> Thanks.
>>>
>>>>
>>>>>
>>>>>> +\begin{itemize}
>>>>>> +\item The \field{slot} filed in \field{payload} indicates the ICE
>>>>>
>>>>> s/filed/field/
>>>>
>>>> Thanks for the correction. Update it in new patch.
>>>>
>>>>>
>>>>>> +  (Inline Crypto Encryption) slot index where the key resides in.
>>>>>
>>>>> s/where the key resides in/where the key resides/
>>>>
>>>> Thanks for the correction. Update it in new patch.
>>>>
>>>>>
>>>>>> +
>>>>>> +\item The \field{activate} filed in \field{payload} implies this is a
>>>>>
>>>>> s/filed/field/
>>>>
>>>> Thanks for the correction. Update it in new patch.
>>>>
>>>>>
>>>>>> +  encryption request.
>>>>>
>>>>> Does "encryption" really mean just encryption or does it mean
>>>>> encryption for writes and decryption for reads?
>>>>
>>>> Actually encryption request here means both encryption for writes and
>>>> decryption for reads. Need I modify it as the following?
>>>
>>> If writing "encryption/decryption" is too tedious, maybe use the feature
>>> name ("inline encryption"). That way it's clear we're talking about the
>>> feature and not specifically about an encryption operation (vs a
>>> decryption operation).
>>
>> ACK
>>
>>>
>>>>
>>>>   \item The \field{activate} field in \field{payload} implies this is a
>>>>   encryption write request or decryption read request.
>>>>
>>>>>
>>>>>> +
>>>>>> +\item The \field{data_unit_num} filed in \field{payload} indicates the
>>>>>
>>>>> s/filed/field/
>>>>
>>>> Thanks for the correction. Update it in new patch.
>>>>
>>>>>
>>>>>> +  starting block of the request.
>>>>>> +\end{itemize}
>>>>>> +
>>>>>>  VIRTIO_BLK_T_IN requests populate \field{data} with the contents of sectors
>>>>>>  read from the block device (in multiples of 512 bytes).  VIRTIO_BLK_T_OUT
>>>>>>  requests write the contents of \field{data} to the block device (in multiples
>>>>>> @@ -912,6 +979,8 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>>>>>>  successfully, failed, or were processed by the device at all if the request
>>>>>>  failed with VIRTIO_BLK_S_IOERR.
>>>>>>  
>>>>>> +A driver MUST set \field{activate} to 0 for a non VIRTIO_BLK_F_ICE request.
>>>>>
>>>>> Please explicitly list request types where the payload field is present
>>>>> and where activate is optional.
>>>>
>>>> How about adding the following supplement?
>>>>
>>>>   \begin{itemize}
>>>>   \item only when the block request contains crypto context and the request type
>>>
>>> I'm not sure what "when the block request contains crypto context"
>>> means. Is that the same as "when VIRTIO_BLK_F_ICE has been negotiated"?
>>
>> No, crypto context means bio_crypt_ctx in BIO struct.
>>   struct bio {
>>   ...
>>   #ifdef CONFIG_BLK_INLINE_ENCRYPTION
>> 	  struct bio_crypt_ctx	*bi_crypt_context;
>>   #endif
>>   ...
>>   }
>>
>> When VIRTIO_BLK_F_ICE has been negotiated, virtio block backend receives crypto
>> payload from virtio block frontend, and the crypto payload, together with I/O
>> transaction, is sent to block layer of the host finally. The crypto payload is
>> used to construct the bio_crypt_ctx filed of BIO.
> 
> Is that equivalent to struct virtio_blk_crypto_payload in this patch? If
> yes, then I suggest only talking about the payload or slots - concepts
> that are part of the virtio-blk inline crypto interface - instead of
> Linux's bio_crypt_ctx.
> 
> If that's not possible, then the crypto context needs to be defined in
> the spec so that readers know what it means.

Crypto context - bio_crypt_ctx structure - is different with virtio_blk_crypto_payload.
bio_crypt_ctx is the struct bound to BIO and request structs in Linux to imply this is
a inline encryption bio/request. While virtio_blk_crypto_payload is a new struct in this
patch, it is used to issue the inline encryption metadata (slot, activate, DUN) to the
virtio backend, so that the backend virtio device can use such inline encryption metadata
to initialized the crypto info of Storage protocol. For instance, the CCI in DW0 of UTP
Transfer Request Descriptor.

Change it to the following.
  \begin{itemize}
  \item only when the block request contains a valid bio_crypt_ctx and the request type
  is one of VIRTIO_BLK_T_IN, VIRTIO_BLK_T_OUT and VIRTIO_BLK_T_FLUSH,\field{activate} MUST
  be set to 1. bio_crypt_ctx is defined in linux/blk-crypto.h.
    \begin{lstlisting}
    struct bio_crypt_ctx {
        const struct blk_crypto_key     *bc_key;
        u64                             bc_dun[BLK_CRYPTO_DUN_ARRAY_SIZE];
    };
    \end{lstlisting}

> 
>>
>>>
>>>>       is one of VIRTIO_BLK_T_IN, VIRTIO_BLK_T_OUT and VIRTIO_BLK_T_FLUSH,
>>>>       \field{activate} MUST be set to 1.
>>>>
>>>>   \item \field{activate} should be set to 0 for all the other cases.
>>>>   \end{itemize}
>>>>
>>>>>
>>>>>> +
>>>>>>  The following requirements only apply if the VIRTIO_BLK_F_ZONED feature is
>>>>>>  negotiated.
>>>>>>  
>>>>>> -- 
>>>>>> 2.34.1
>>>>>>
>>>>>>
>>>>
>>

