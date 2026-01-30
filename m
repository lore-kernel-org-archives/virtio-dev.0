Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9783F3451CE
	for <virtio-dev@lists.linux.dev>; Fri, 30 Jan 2026 10:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769768643; cv=none; b=N8oByEAyUkLQDhjWVrpHbqnevStGzqGwcMTbVrUekwcX3wVrsMpZYc98LPe9TJhZVJbzfg1Y1EUOW/rxl/dqzMzDOzi3oYB51g2ROmB2nXelijyxmcP2QSp6gFIbqMZEcKHof2ScZJ1xp1U75HLddQ2S7lKzK7v7Y7fMTWb6708=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769768643; c=relaxed/simple;
	bh=Jfw7JctYrUoIu3XaNjmT8fYM/CKy25MUCkabu/FIr3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KoHqGP6NLAcDaF/QoMv0TZW8cOB/pozztFxFRXExMuyjztnUg6RYA4YPD9iW0J1JfMmsgxSlNdWFt6epuMPPm/iIkgBouF3ZyP2X3NbxWmYmecscr3sWGDNbEv6s4eG/Z1mnwl6wFAOlF1fEbVCYfkQUxAcXCsYyADr3gw2l90o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=p4XfDnol; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="p4XfDnol"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UAHUBV995921;
	Fri, 30 Jan 2026 10:24:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KnTo8bcZnyqtc5wCV0dHZ56GMr/eKsK0ORGCVb9eeHE=; b=p4XfDnolOQnmPbi8
	dOfRB9bIzNP5lwRt3bFGlQQurWdipPVR7za1fYg7cZ0oP0uLhZRUlwoYnvY5Ezwz
	SlKWQ9Od2o6jo5jASgk8en01gdpd5wS9UThjqiXcjUIR7/43sFaJqIsGm+TLpU2/
	pioowrU6amTTZJEQK69Iy22MM93Q8bofB0vthhLE4YtZ1D/+I/eFxfZvxfnj47+0
	2EKH/rrhlTEBJ2ICkUoi4XERx0MqcoDaK9VuQMefl39L6O79HYClSDQl+DLhE7a4
	qwVzWAW2KL1Cj6iif+WGYOHkGDyimd24xpLy9xWEbQlzD9h+ZOEEjvKKbH5R65wF
	hV5RLA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0bvvjqwv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Jan 2026 10:24:00 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 60UANxWb001083
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Jan 2026 10:23:59 GMT
Received: from [10.231.241.142] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 30 Jan
 2026 02:23:58 -0800
Message-ID: <b95cf6c4-db73-49e4-969e-fa7735a07527@quicinc.com>
Date: Fri, 30 Jan 2026 18:23:55 +0800
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
Content-Language: en-US
From: Linlin Zhang <quic_linlzhan@quicinc.com>
In-Reply-To: <20260127210951.GA96301@fedora>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=ZdEQ98VA c=1 sm=1 tr=0 ts=697c86c0 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8pif782wAAAA:8 a=NEAV23lmAAAA:8 a=COk6AnOGAAAA:8
 a=rYUqQy7G8cwvnHzHI_EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: cLJNLRt35jxIt_mtQrqiB7MNuYHaiWXz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDA4NCBTYWx0ZWRfX8fHq82gMp6C9
 k2uThTdQzbD3J0NvnTp44sRVz3Cux+UMC7N+dUCR30fIYMzlArVeMBNGkk7ALNhv8+0vD36Vn2c
 FclFjXqLr9H1ZZb9nyRyT/3Og4aV+QpVmg48uBEw5OC8ghVG/1zr2QT2lq3r+Zj4ouNAQm5iwcF
 fX2VBphPul0+aBCvpQR64ChGy4DEYisYxc79XcLHaEr2DUZEdEKoogTX34sdWDjehV1NKaAX5y4
 BmnGqJ8ZiyoK9F7Xr9eDFFcOWVgOSJ/Wy0RI9YOthSbhQ3I6VikCO3D+n0OB7O3PnWsFgG2ay/l
 8geHCtlGCnu5QpyweoWD/jSVgp1RUXnSOomoZ1uU3fkwIajlhAOP6H5YvBMka2rRHp/CPT868HA
 Ab9ntFIUXseOE16BqwD+/SfGYi70TJlerBNXOSNXYcpB0HdeflJRYQIkHTS5FT5f8Wbwyw12zAm
 giwm9/6Iy+PzQ7M9Weg==
X-Proofpoint-ORIG-GUID: cLJNLRt35jxIt_mtQrqiB7MNuYHaiWXz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_01,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601300084

Thank you for the review. I’ve added some clarifications and potential updates.
Could you please take another look before I send a new patch?

On 1/28/2026 5:09 AM, Stefan Hajnoczi wrote:
> On Tue, Jan 27, 2026 at 10:20:32PM +0800, Linlin Zhang wrote:
>> From: linlzhan <quic_linlzhan@quicinc.com>
>>
>> Inline encryption on virtio block can only be supported when
>> the new feature bit VIRTIO_BLK_F_ICE is negotiated.
>>
>> Extend struct virtio_blk_config and struct virtio_blk_req,
>> so that crypto capabilities can be got in the frontend and
>> encryption metadata can be sent to the backend, together with
>> each I/O transaction.
> 
> This looks like a Self-Encrypting Drives feature along the lines of TCG
> Opal:
> https://en.wikipedia.org/wiki/Opal_Storage_Specification
> 
> Would it make sense to implement TCG Opal instead of defining a new
> interface? That would make this more familiar to users and simplify
> integration into existing tools like sedutil and cryptsetup (e.g. by
> supporting the <linux/sed-opal.h> ioctl interface).

This patch is for the FBE (File Based Encryption) support on UFS/EMMC
storage with ICE (Inline Crypto Engine) enabled. TCG Opal is only applicable
to SED (self-encrypting drives), not applicable to ICE (Inline Crypto Engine).

In Automotive or Embedded scenario, UFS/EMMC generally is used. The disk
encryption on them is supported by the ICE pipeline of SOC, rather SSD
controller, so we couldn't use TCG Opal here.

> 
>> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/238
>>
>> Change-Id: Ic23b2137e5d9a599d826e06c279f1b614d79abdf
>> Signed-off-by: linlzhan <quic_linlzhan@quicinc.com>
>> ---
>>  device-types/blk/description.tex | 69 ++++++++++++++++++++++++++++++++
>>  1 file changed, 69 insertions(+)
>>
>> diff --git a/device-types/blk/description.tex b/device-types/blk/description.tex
>> index 2712ada..23d8dc0 100644
>> --- a/device-types/blk/description.tex
>> +++ b/device-types/blk/description.tex
>> @@ -66,6 +66,11 @@ \subsection{Feature bits}\label{sec:Device Types / Block Device / Feature bits}
>>  	(ZNS). For brevity, these standard documents are referred as "ZBD standards"
>>  	from this point on in the text.
>>  
>> +\item[VIRTIO_BLK_F_ICE(22)] Inline Crypto Extensions are supported. When this
>> +     is negotiated, the device exposes crypto characteristics in configuration
>> +     space and the driver SHALL provide an extended request header containing a
> 
> SHALL, MUST, MAY, etc are only used in the normative sections of the
> spec.
> 
> Why "SHALL"? Does this mean the device must be prepared to receive
> requests without the payload field when VIRTIO_BLK_F_ICE is negotiated?
> How should the device behave in that case: fail the request or perform
> I/O without crypto?

This section - 5.2.3 Feature bits - is a normative section.

What's expected for VIRTIO_BLK_F_ICE feature bit is that configuration space
must be prepared with the exposed crypto characteristics and the virtio block
frontend must sent a virtblk request with encryption metadata packed into
when VIRTIO_BLK_F_ICE is negotiated and hardware crypto is supported.

By replacing 'SHALL' with 'MUST' here, Is the following rewording fine?

  Inline Crypto Extensions are supported. When this is negotiated, the device MUST
  expose crypto characteristics in configuration space and the driver MUST provide
  an extended request header containing a crypto payload for block I/O if the
  hardware supports inline crypto. If this feature bit is negotiated, but hardware
  inline crypto doesn't support, the device SHOULD perform I/O without crypto.

I'll add hw_enabled (type: u8) to virtio_blk_crypto_characteristics to indicate
whether the host supports hardware inline encryption.

> 
>> +     crypto payload for block I/O.
>> +
>>  \end{description}
>>  
>>  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Block Device / Feature bits / Legacy Interface: Feature bits}
>> @@ -128,6 +133,11 @@ \subsection{Device configuration layout}\label{sec:Device Types / Block Device /
>>                  u8 model;
>>                  u8 unused2[3];
>>          } zoned;
>> +        struct virtio_blk_crypto_characteristics {
>> +                __virtio16 slot_info;
>> +                __virtio16 reserved;
>> +                __virtio32 capability;
>> +        } crypto;
>>  };
>>  \end{lstlisting}
>>  
>> @@ -215,6 +225,25 @@ \subsection{Device configuration layout}\label{sec:Device Types / Block Device /
>>  terminated by the device with a "zone resources exceeded" error as defined for
>>  specific commands later.
>>  
>> +If the VIRTIO_BLK_F_ICE feature is negotiated, then in
>> +\field{virtio_blk_crypto_characteristics},
>> +\begin{itemize}
>> +\item \field{slot_info} value packs two 8-bits values:
>> +    \begin{itemize}
>> +        \item Bits~\[15:8] (\emph{max\_slots}): the maximum number of supported
>> +            crypto key slots.
>> +        \item Bits~\[7:0] (\emph{slot\_offset}): an offset applied to slot numbering.
>> +    \end{itemize}
>> +\item \field{capability} value packs four 8-bits values:
>> +    \begin{itemize}
>> +        \item Bits~\[31:24]: crypto algorithm id.
>> +        \item Bits~\[23:16]: mask of data unit size.
>> +        \item Bits~\[15:8]: crypto key size.
>> +        \item Bits~\[7:0]: unused.
>> +    \end{itemize}
> 
> Why are these fields packed? Configuration Space can have u8 fields.

Given that &sect. 4.2.2.2 saying "For the device-specific configuration space,
the driver MUST use 8 bit wide accesses for 8 bit wide fields, 16 bit wide
and aligned accesses for 16 bit wide fields and 32 bit wide and aligned
accesses for 32 and 64 bit wide fields.",  these fields are packed for a
efficient read from the configuration space.

> 
> These fields are not sufficiently documented. Where are the crypto
> algorithm ids listed, etc?

Can I reword it as the following?

  \item Bits~\[31:24]: crypto algorithm identifiers.
  The device SHALL support reporting and negotiating cryptographic
  algorithms using the following algorithm identifiers:
  \begin{lstlisting}
      CRYPTO_ALG_AES_XTS              = 0x0
      CRYPTO_ALG_BITLOCKER_AES_CBC    = 0x1
      CRYPTO_ALG_AES_ECB              = 0x2
      CRYPTO_ALG_ESSIV_AES_CBC        = 0x3
  \end{lstlisting}
  These identifiers abstract the underlying hardware crypto implementation
  and MUST NOT assume any operating‑system‑specific data structures or
  constants.
  \item Bits~\[23:16]: mask of data unit size. When bit j in this field
  (j=0......7)is set, a data unit size of 512*2^j bytes is slected.
  \item Bits~\[15:8]: crypto key size identifiers.
  \begin{lstlisting}
      CRYPTO_KEY_SIZE_INVALID     = 0x0
      CRYPTO_KEY_SIZE_128_BITS    = 0x1
      CRYPTO_KEY_SIZE_192_BITS    = 0x2
      CRYPTO_KEY_SIZE_256_BITS    = 0x3
      CRYPTO_KEY_SIZE_512_BITS    = 0x4
  \end{lstlisting}

> 
> How can a device support multiple algorithms? I think Configuration
> Space may not be flexible enough for this. You could introduce a
> GET_CRYPTO_INFO request type that allows the driver to fetch arrays of
> crypto algorithm characteristics.

Virtio block driver need register crypto capability for request_queue of
virtio block device. That means virtio block frontend need get crypto
capability before virtio block device is ready. But the request can only
be sent after the virtio block device is ready. Thus I think it's impossible
to get such capabilities from the backend via a new request type, event
though the hardware in the host may support a few algorithms (the actual
number of algorithms will change depending on the vendor manufacturer.).
Thus I assume the host only configure and expose one hardware crypto
capability to the virtual machine and virtio block frontend gets is
through configuration space.

> 
>> +\end{itemize}
>> +
>> +
>>  \subsubsection{Legacy Interface: Device configuration layout}\label{sec:Device Types / Block Device / Device configuration layout / Legacy Interface: Device configuration layout}
>>  When using the legacy interface, transitional devices and drivers
>>  MUST format the fields in struct virtio_blk_config
>> @@ -278,6 +307,10 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
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
>> @@ -317,6 +350,9 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
>>      driver SHOULD ignore all other fields in \field{zoned}.
>>  \end{itemize}
>>  
>> +If the VIRTIO_BLK_F_ICE feature is negotiated, then the driver must validate
>> +    the max_slots in \field{slot_info} before the slot usage.
>> +
>>  \devicenormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
>>  
>>  Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it
>> @@ -402,6 +438,16 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
>>  \item the device MUST initialize padding bytes \field{unused2} to 0.
>>  \end{itemize}
>>  
>> +If the VIRTIO_BLK_F_ICE feature is negotiated, then the fields in \field{cryto}
> 
> s/cryto/crypto/

Thanks for the correction. Update it in new patch.

> 
>> +struct in the configuration space MUST be set by the device.
>> +\begin{itemize}
>> +\item the \field{slot_info} field of \field{crypto} MUST be set by the device to a
>> +    max_slots in the higher 8 bits and slot_offset in the lower 8 bits.
>> +
>> +\item the \field{capability} field of \field{crypto} MUST be set by the device
>> +    to a crypto capability read from the storage register.
>> +\end{itemize}
>> +
>>  \subsubsection{Legacy Interface: Device Initialization}\label{sec:Device Types / Block Device / Device Initialization / Legacy Interface: Device Initialization}
>>  
>>  Because legacy devices do not have FEATURES_OK, transitional devices
>> @@ -436,6 +482,13 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
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
>>          u8 data[];
>>          u8 status;
>>  };
>> @@ -463,6 +516,20 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>>  the read or write is to occur. This field is unused and set to 0 for
>>  commands other than read, write and some zone operations.
>>  
>> +The \field{payload} consists of the encryption information for current
>> +request. It need to be set by the driver only when the feature VIRTIO_BLK_F_ICE
>> +is negotiated.
> 
> "set" is ambiguous: does it meaning filling in the fields or does it
> mean the fields are only present when VIRTIO_BLK_F_ICE is negotiated
> (this distinction is important if other features add more fields after
> payload in the future).
> 
> The sentence could be reworded:
> 
>   It is only present when the VIRTIO_BLK_F_ICE feature is negotiated and
>   \field{type} is VIRTIO_BLK_T_IN or VIRTIO_BLK_T_OUT.
> 
> (I'm not sure whether DISCARD, WRITE_ZEROES, or SECURE_ERASE also need
> the payload field. It seems like GET_ID and GET_LIFETIME do not need the
> payload field.)

Accept and update it as the following.

  It is only present when the VIRTIO_BLK_F_ICE feature is negotiated and
  +\field{type} is VIRTIO_BLK_T_IN, VIRTIO_BLK_T_OUT or VIRTIO_BLK_T_FLUSH.

> 
>> +\begin{itemize}
>> +\item The \field{slot} filed in \field{payload} indicates the ICE
> 
> s/filed/field/

Thanks for the correction. Update it in new patch.

> 
>> +  (Inline Crypto Encryption) slot index where the key resides in.
> 
> s/where the key resides in/where the key resides/

Thanks for the correction. Update it in new patch.

> 
>> +
>> +\item The \field{activate} filed in \field{payload} implies this is a
> 
> s/filed/field/

Thanks for the correction. Update it in new patch.

> 
>> +  encryption request.
> 
> Does "encryption" really mean just encryption or does it mean
> encryption for writes and decryption for reads?

Actually encryption request here means both encryption for writes and
decryption for reads. Need I modify it as the following?

  \item The \field{activate} field in \field{payload} implies this is a
  encryption write request or decryption read request.

> 
>> +
>> +\item The \field{data_unit_num} filed in \field{payload} indicates the
> 
> s/filed/field/

Thanks for the correction. Update it in new patch.

> 
>> +  starting block of the request.
>> +\end{itemize}
>> +
>>  VIRTIO_BLK_T_IN requests populate \field{data} with the contents of sectors
>>  read from the block device (in multiples of 512 bytes).  VIRTIO_BLK_T_OUT
>>  requests write the contents of \field{data} to the block device (in multiples
>> @@ -912,6 +979,8 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>>  successfully, failed, or were processed by the device at all if the request
>>  failed with VIRTIO_BLK_S_IOERR.
>>  
>> +A driver MUST set \field{activate} to 0 for a non VIRTIO_BLK_F_ICE request.
> 
> Please explicitly list request types where the payload field is present
> and where activate is optional.

How about adding the following supplement?

  \begin{itemize}
  \item only when the block request contains crypto context and the request type
      is one of VIRTIO_BLK_T_IN, VIRTIO_BLK_T_OUT and VIRTIO_BLK_T_FLUSH,
      \field{activate} MUST be set to 1.

  \item \field{activate} should be set to 0 for all the other cases.
  \end{itemize}

> 
>> +
>>  The following requirements only apply if the VIRTIO_BLK_F_ZONED feature is
>>  negotiated.
>>  
>> -- 
>> 2.34.1
>>
>>

