Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEA6E573
	for <virtio-dev@lists.linux.dev>; Sun, 22 Feb 2026 06:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771740589; cv=none; b=RAYnM3vU+Fx5kO5f3sL6V23rsILAqC+CXD8JMkiiZ9MLX3DZIlRI42ye/PF8L2hgjBamcZdI4IaAjk8vFfXVK2Q9IpMKJMt5JePWO2OIxPnyrja8FYsj3e4Ga+OEh2uCFbAAwURAibTgsOarWmHw5PZA7pkOkwle0RqkBs5X0S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771740589; c=relaxed/simple;
	bh=feYK3X9HL+/mRJHszxC9vmvcX+kyqYvjrJPAowVfu+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UVXG4dLwe2EZzkpsbuxYZuOriypkBZpdWjyKQrVgi2DOgs2jp7m656afl4YIz0ZSDbL3mhY+3Vh7t0BGMa42mDuHzAOhre3lFDeV80EwkQRkVB5xBqRJ2VSoQwBeDdeIXCKuqzzY34t2+c0u0hDh3/5A6R13OC8ybRUSHtp6vFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hL5SNWP/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hL5SNWP/"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61M3nZLn547377;
	Sun, 22 Feb 2026 06:09:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oGV7pOxqqhSygdFkFZILgKiFEU13+EMU8k4gvpPSStA=; b=hL5SNWP/vEqCUQnB
	+wwBO6ua0m9M/NCwCvkgSE9bg2Ao934sAHbQVrymtKMNUfAxFocoMnwznPRsa/NS
	+Z3SaiGWSPK5YeHN3ehUnJcWpXUJKRnzP+uk53Tt+pAtz2MQDHhTMk1LKqmPP/ni
	Qd3hJeNXjw3ar5DJVicvzft1IFcazqIysV3syROZulxNWaoaZJb6EesoyvP4C0jV
	BrvwO26Je+22xCtMphta5QCfaqr0xS6l6omIUx7YwoI8qiNu8ACtmjkh0I15+LDL
	xD53ubK7r2MmoTexJdde4OAIVh/779ZK4WbYjVfldHvOD4F+KXNCW59WqLDa0ESa
	01CgZQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5vgsuag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Feb 2026 06:09:46 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 61M69jau028940
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Feb 2026 06:09:45 GMT
Received: from [10.253.8.33] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 21 Feb
 2026 22:09:43 -0800
Message-ID: <bd48b394-ac9a-4c9a-9f38-afcc4ae8d004@quicinc.com>
Date: Sun, 22 Feb 2026 14:09:40 +0800
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virtio-blk: Add inline encryption support
To: Sebastian Mauritsson <sma@napatech.com>,
        "virtio-dev@lists.linux.dev"
	<virtio-dev@lists.linux.dev>,
        "stefanha@redhat.com" <stefanha@redhat.com>
CC: "quic_dshaikhu@quicinc.com" <quic_dshaikhu@quicinc.com>
References: <20260204172749.GA610283@fedora>
 <20260206171218.1748260-1-quic_linlzhan@quicinc.com>
 <VI0P190MB2641340DAF4AA5886D58B629CE6BA@VI0P190MB2641.EURP190.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Linlin Zhang <quic_linlzhan@quicinc.com>
In-Reply-To: <VI0P190MB2641340DAF4AA5886D58B629CE6BA@VI0P190MB2641.EURP190.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIyMDA1NiBTYWx0ZWRfXxQtVKSc9yE3G
 9wsqVurZRmI6Qn6MzAUvJ0eTFyPq5Qkv5nLY09SM4xzWX/nnSOPjm73SvUH9WYq2+/g5jHCswEE
 VG4CMVKZdWpB3ycTNnDCIM6w1MfMMrB4tDjkR2bTrctN3WI98kSEiugZRYO9iG1hoFlQkGcdYRC
 iyOaNGKZuN/3CoSLzCZvSW7B/mqB7MnIZWhD54Q/WwH15YdU6aDs5bECGbZlCLriNoe0Ixw6gYa
 9vZabBxAAiFn7sIYaXL3Zo/ujw8zqinRWSoV4a/vC1KETI12ScXFHI2ALEs1QSkZBeo/IQYs+d5
 6XjR4iphExJOJWggh0toOm1rvdO0oBa15AZp99WOCeSul8waFRlKGt/KPdX7z8fOxIOme9m9GnP
 hLsUsJzpDteEgcJV/I18NloPW3jaN96Tvki7nXKAeLMp/ZrzH5noWIRBLUhURraz/Jejpo5YSJO
 qpqwJHsPPQccS7pyzfw==
X-Authority-Analysis: v=2.4 cv=W+A1lBWk c=1 sm=1 tr=0 ts=699a9daa cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=XOxgxf62AAAA:8 a=NEAV23lmAAAA:8
 a=COk6AnOGAAAA:8 a=20KFwNOVAAAA:8 a=uRUJHJf9FwpgWwDBh04A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gu-GzIYwBIvN1fC6SyRQ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: f0ekrTdX60CxASfkQJz07aFX4NV2volB
X-Proofpoint-ORIG-GUID: f0ekrTdX60CxASfkQJz07aFX4NV2volB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-21_07,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1011 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602220056



On 2/19/2026 10:35 PM, Sebastian Mauritsson wrote:
> I understand there might be compatibility considerations, but I'm wondering the exact reason for making CRYPTO_ALG_AES_ECB an option? This does not use an IV and is unsuitable for anything other than single-use & single-block encryption.
Would you please share your exact compatibility concerns? I believe the change in this patch only works for that the beckend and virtio block frontend negociates VIRTIO_BLK_F_ICE feature bit. Previous implementation doesn't have such
feature bit, so no impact on the backward compatibility.

With respect to CRYPTO_ALG_AES_ECB, it's just one possible enum of algoritms storage hardware supports. IV in additional
metadate encryption is mainly used by CBC mode.

By the way, please help review the patch in bellow thread sent by OSS mail id due to Qualcomm internal requirement for upstream.
  https://lore.kernel.org/virtio-dev/20260210083208.472824-1-linlin.zhang@oss.qualcomm.com/T/#t

> 
> Best regards, Sebastian
> 
>> -----Original Message-----
>> From: Linlin Zhang <quic_linlzhan@quicinc.com>
>> Sent: Friday, February 6, 2026 6:12 PM
>> To: virtio-dev@lists.linux.dev; stefanha@redhat.com
>> Cc: quic_dshaikhu@quicinc.com
>> Subject: [PATCH v2] virtio-blk: Add inline encryption support
>>
>> From: linlzhan <quic_linlzhan@quicinc.com>
>>
>> Inline encryption on virtio block can only be supported when the new feature
>> bit VIRTIO_BLK_F_ICE is negotiated.
>>
>> Extend struct virtio_blk_config and struct virtio_blk_req, so that crypto
>> capabilities can be got in the frontend and encryption metadata can be sent
>> to the backend, together with each I/O transaction.
>>
>> About the inline encryption on UFS or eMMC storage, please refer to the
>> Linux inline encryption documentation:
>> https://linkprotect.cudasvc.com/url?a=https%3a%2f%2fgit.kernel.org%2fpub
>> %2fscm%2flinux%2fkernel%2fgit%2ftorvalds%2flinux.git%2ftree%2fDocumen
>> tation%2fblock%2finline-encryption.rst&c=E,1,nhL3zMxYwxuFP4QQ8SLhLjz-
>> MYwQ3RGD-PYXU71uhC-OBnxDeaefVyDYQH1A0KvX70THXfl-SWjj-
>> JcDntGGie3bSTNAri0H4_0CtCqU3kyCWRoDg1_N&typo=1
>>
>> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/238
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: linlzhan <quic_linlzhan@quicinc.com>
>> Signed-off-by: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
>> ---
>>
>> changes from v2:
>>  - Add inline encryption link in commit message for a better
>>    backgrond descryption
>>  - Add sufficient descryption for the fields of crypto
>>    capability
>>  - Delete crypto capability in configuration layout, instead
>>    add a new request command to get it
>>  - Correct the terminology in non-normative and normative
>>    sections
>>  - Correct the mail for open source upstream
>> ---
>>
>>  device-types/blk/description.tex | 110 ++++++++++++++++++++++++++++++-
>>  1 file changed, 108 insertions(+), 2 deletions(-)
>>
>> diff --git a/device-types/blk/description.tex b/device-
>> types/blk/description.tex
>> index 2712ada..60f46af 100644
>> --- a/device-types/blk/description.tex
>> +++ b/device-types/blk/description.tex
>> @@ -66,6 +66,11 @@ \subsection{Feature bits}\label{sec:Device Types /
>> Block Device / Feature bits}
>>       (ZNS). For brevity, these standard documents are referred as "ZBD
>> standards"
>>       from this point on in the text.
>>
>> +\item[VIRTIO_BLK_F_ICE(22)] Inline Crypto Extensions are supported. Only
>> when this
>> +     feature bit is negotiated, the device need expose crypto characteristics in
>> +     configuration space and the driver need provide an extended request
>> header
>> +     containing a crypto payload for block I/O.
>> +
>>  \end{description}
>>
>>  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Block
>> Device / Feature bits / Legacy Interface: Feature bits} @@ -128,6 +133,10 @@
>> \subsection{Device configuration layout}\label{sec:Device Types / Block
>> Device /
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
>> @@ -215,6 +224,18 @@ \subsection{Device configuration
>> layout}\label{sec:Device Types / Block Device /  terminated by the device with
>> a "zone resources exceeded" error as defined for  specific commands later.
>>
>> +If the VIRTIO_BLK_F_ICE feature is negotiated, then in
>> +\field{virtio_blk_crypto_characteristics},
>> +\begin{itemize}
>> +\item \field{slot_info} value packs two 8-bits values to reduce the number of
>> +    Configuration Space reads.
>> +    \begin{itemize}
>> +        \item Bits~\[15:8] (\emph{max\_slots}): the maximum number of
>> supported
>> +            crypto key slots.
>> +        \item Bits~\[7:0] (\emph{slot\_offset}): an offset applied to slot
>> numbering.
>> +    \end{itemize}
>> +\end{itemize}
>> +
>>  \subsubsection{Legacy Interface: Device configuration
>> layout}\label{sec:Device Types / Block Device / Device configuration layout /
>> Legacy Interface: Device configuration layout}  When using the legacy
>> interface, transitional devices and drivers  MUST format the fields in struct
>> virtio_blk_config @@ -278,6 +299,10 @@ \subsection{Device
>> Initialization}\label{sec:Device Types / Block Device / Devic
>>      \field{zoned} can be read by the driver to determine the zone
>>      characteristics of the device. All \field{zoned} fields are read-only.
>>
>> +\item If the VIRTIO_BLK_F_ICE feature is negotiated, the fields in
>> +    \field{crypto} can be read by the driver to determine the inline crypto
>> +    characteristics of the device. All \field{crypto} fields are read-only.
>> +
>>  \end{enumerate}
>>
>>  \drivernormative{\subsubsection}{Device Initialization}{Device Types / Block
>> Device / Device Initialization} @@ -317,6 +342,9 @@ \subsection{Device
>> Initialization}\label{sec:Device Types / Block Device / Devic
>>      driver SHOULD ignore all other fields in \field{zoned}.
>>  \end{itemize}
>>
>> +If the VIRTIO_BLK_F_ICE feature is negotiated, then the driver MUST
>> validate
>> +    the max_slots in \field{slot_info} before the slot usage.
>> +
>>  \devicenormative{\subsubsection}{Device Initialization}{Device Types / Block
>> Device / Device Initialization}
>>
>>  Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it @@ -
>> 402,6 +430,13 @@ \subsection{Device Initialization}\label{sec:Device Types /
>> Block Device / Devic  \item the device MUST initialize padding bytes
>> \field{unused2} to 0.
>>  \end{itemize}
>>
>> +If the VIRTIO_BLK_F_ICE feature is negotiated, then the fields in
>> +\field{crypto} struct in the configuration space MUST be set by the device.
>> +\begin{itemize}
>> +\item the \field{slot_info} field of \field{crypto} MUST be set by the device to
>> a
>> +    max_slots in the higher 8 bits and slot_offset in the lower 8 bits.
>> +\end{itemize}
>> +
>>  \subsubsection{Legacy Interface: Device Initialization}\label{sec:Device Types
>> / Block Device / Device Initialization / Legacy Interface: Device Initialization}
>>
>>  Because legacy devices do not have FEATURES_OK, transitional devices @@ -
>> 436,6 +471,13 @@ \subsection{Device Operation}\label{sec:Device Types /
>> Block Device / Device Ope
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
>> @@ -445,8 +487,9 @@ \subsection{Device Operation}\label{sec:Device
>> Types / Block Device / Device Ope  (VIRTIO_BLK_T_OUT), a discard
>> (VIRTIO_BLK_T_DISCARD), a write zeroes  (VIRTIO_BLK_T_WRITE_ZEROES), a
>> flush (VIRTIO_BLK_T_FLUSH), a get device ID  string command
>> (VIRTIO_BLK_T_GET_ID), a secure erase -(VIRTIO_BLK_T_SECURE_ERASE), or
>> a get device lifetime command -(VIRTIO_BLK_T_GET_LIFETIME).
>> +(VIRTIO_BLK_T_SECURE_ERASE), a get device lifetime command
>> +(VIRTIO_BLK_T_GET_LIFETIME), or a get device crypto capabilities
>> +command (VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES).
>>
>>  \begin{lstlisting}
>>  #define VIRTIO_BLK_T_IN           0
>> @@ -457,12 +500,27 @@ \subsection{Device Operation}\label{sec:Device
>> Types / Block Device / Device Ope
>>  #define VIRTIO_BLK_T_DISCARD      11
>>  #define VIRTIO_BLK_T_WRITE_ZEROES 13
>>  #define VIRTIO_BLK_T_SECURE_ERASE   14
>> +#define VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES   27
>>  \end{lstlisting}
>>
>>  The \field{sector} number indicates the offset (multiplied by 512) where  the
>> read or write is to occur. This field is unused and set to 0 for  commands
>> other than read, write and some zone operations.
>>
>> +The \field{payload} consists of the encryption information for current
>> +request. It is only present when the VIRTIO_BLK_F_ICE feature is
>> +negotiated and \field{type} is VIRTIO_BLK_T_IN, VIRTIO_BLK_T_OUT or
>> VIRTIO_BLK_T_FLUSH.
>> +\begin{itemize}
>> +\item The \field{slot} field in \field{payload} indicates the ICE
>> +  (Inline Crypto Encryption) slot index where the key resides.
>> +
>> +\item The \field{activate} field in \field{payload} implies this is a
>> +  inline encryption request.
>> +
>> +\item The \field{data_unit_num} field in \field{payload} indicates the
>> +  starting block of the request.
>> +\end{itemize}
>> +
>>  VIRTIO_BLK_T_IN requests populate \field{data} with the contents of sectors
>> read from the block device (in multiples of 512 bytes).  VIRTIO_BLK_T_OUT
>> requests write the contents of \field{data} to the block device (in multiples
>> @@ -530,6 +588,47 @@ \subsection{Device Operation}\label{sec:Device
>> Types / Block Device / Device Ope  The \field{device_lifetime_est_typ_b}
>> refers to wear of MLC cells and is provided  with the same semantics as
>> \field{device_lifetime_est_typ_a}.
>>
>> +VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES requests fetch the storage
>> +hardware crypto capabilities into \field{data}. And the \field{data} is
>> +of the form
>> +
>> +\begin{lstlisting}
>> +struct virtio_blk_crypto_caps {
>> +  u8 size;
>> +  le32 crypto_capabilities[];
>> +};
>> +\end{lstlisting}
>> +
>> +The \field{size} specifies the size of array \field{crypto_capabilities}.
>> +The \field{crypto_capabilities} indicates the crypto capabilities
>> +supported by the hardware storage for inline encryption.
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
>> +    These identifiers abstract the underlying hardware crypto
>> implementation
>> +    and does not assume any operating‑system‑specific data structures or
>> +    constants.
>> +    \item Bits~\[23:16]: mask of data unit size. When bit j in this field
>> +    (j=7......0) is set, a data unit size of 512*2^j bytes is selected.
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
>> +
>>  The final \field{status} byte is written by the device: either  VIRTIO_BLK_S_OK
>> for success, VIRTIO_BLK_S_IOERR for device or driver  error or
>> VIRTIO_BLK_S_UNSUPP for a request unsupported by device:
>> @@ -912,6 +1011,13 @@ \subsection{Device Operation}\label{sec:Device
>> Types / Block Device / Device Ope  successfully, failed, or were processed by
>> the device at all if the request  failed with VIRTIO_BLK_S_IOERR.
>>
>> +The length of \field{data} MUST be a multiple of 4 bytes plus 1 for
>> +VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES requests.
>> +
>> +A driver MUST set \field{activate} to 1 for
>> VIRTIO_BLK_T_IN,VIRTIO_BLK_T_OUT,
>> +    and VIRTIO_BLK_T_FLUSH requests that require inline encryption. For
>> other
>> +    request types or when inline encryption is not required, it is set to 0.
>> +
>>  The following requirements only apply if the VIRTIO_BLK_F_ZONED feature is
>> negotiated.
>>
>> --
>> 2.34.1
>>
> 
> Disclaimer: This email and any files transmitted with it may contain confidential information intended for the addressee(s) only. The information is not to be surrendered or copied to unauthorized persons. If you have received this communication in error, please notify the sender immediately and delete this e-mail from your system.

