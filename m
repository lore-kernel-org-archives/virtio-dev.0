Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9147625C6EE
	for <virtio-dev@lists.linux.dev>; Thu, 20 Aug 2026 16:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787242745; cv=none; b=sYNXRlkG8RcsJzE9AemjqX2Qj347WTV82IZZW+xNteNPQ4Gma7Octj/iE3BOVE7Y0HqshdXT3FcdpLzQy9meSddaptCYsGCU+QmNJADSl+UFfdcJAwZPwnySZ3War4NClpgZEDxAPx0l15AVwRqKdaJ4LPNBhkIqZNdkJIxz17o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787242745; c=relaxed/simple;
	bh=y8cYtGSS8yKhb0Gx+ABOSDtBztlnPs8FqVzcyNfSVjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UtN8sl+/FJ9BzFhIg3lPSBRL5t6kFZtf09L0yoDChYlTxMzG5N1DkMuwukHKZaS3sNxJTeBhGtzRSpazYieMqh1/K1+BxXQaAh0FNeV0CPSOkZJgBgLWRg+MEUVgvrhcx7hNLelVKKpvljZxPzZJ8KnnWAnEC4RkvCP8LW1Niuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BRyuT0S6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Xu6D+k0q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BRyuT0S6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xu6D+k0q"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KG88jT3492343
	for <virtio-dev@lists.linux.dev>; Thu, 20 Aug 2026 16:19:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lm77NmPBQO7R5Q7EIBOSUWL7ZcGv1gFdIj4ZsGFo4Yw=; b=BRyuT0S61/Ql8Kt+
	0fjGwYlvFDd8VQDuUV58aP/bcB4uC5FzMjsUNAw+10qphz5FOrR3dRhP+HiZtRS4
	ibQoGGmITMHeN7HjHzr3mOf9w4EK+Vd5fZMcCpso9lF9ZEc5CUSBl0PGhaaBSfpU
	0sCWWBG9+dKAPqcdybzApZevHoc7Pbqem9XcyBOa9fLNcKJfKSnoeiU1iMcWCQTg
	eX/gQejoc8kXsIQz/6pBv35YyrqkUexG0RqHkQMpx63AWSSQbuC8/jFWLBzITanS
	bT/y2ONM/3LnrypDwb1OZ6cLXA/NdtjjJg3jbGvVhIfIhBcJDaQuPrgs1DzZl4m7
	M4pxbg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5x29hy9g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Thu, 20 Aug 2026 16:19:01 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb48f41343aso951644a12.1
        for <virtio-dev@lists.linux.dev>; Thu, 20 Aug 2026 09:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787242741; x=1787847541; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lm77NmPBQO7R5Q7EIBOSUWL7ZcGv1gFdIj4ZsGFo4Yw=;
        b=Xu6D+k0qyYdchFMEnZ1zuiE3S1Yu1eDGZGGd/ocPl7P3T1sDoYKGfOAIV+KKcLW3gm
         pDCdSE8sFGlsT8e2Rg60lVOxo8UVDYTUtklvJKf2F+RwAs+DmkDRF3pcMgDjDRPlLXYl
         8k8qrWnko222HJ3GN8Gswvafmmv2euR+smuemt8v8yi3EfLeDMM9tjtue7p0uXG5D2Dt
         ARo8SF2NXFaeXtCAaKVDY8Gx7rvh9nQ5y97GPTN9p2DKds/nZBaFJUNkzC1mq8gYTgrz
         NSOBc+VpzJBsdWJLnpofoen9MVb+jQitWlzIAlaQYLJ2l9jlQlEy2Osv1PD4+OtPHevB
         ijzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787242741; x=1787847541;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lm77NmPBQO7R5Q7EIBOSUWL7ZcGv1gFdIj4ZsGFo4Yw=;
        b=pqd4jED9HBvshUu4SrjCKAt+eOVjWLLExJYdPJjSLamGIPXeAtr2v3tK3/Bhy70p9l
         rh/ENVxxCw11nUO4Q2QyVfq8svesHgaKysNJ81OiYR/AHx12s1PIRdo/KbOdi5Pl8Y16
         vdXkgRWA/8k2t7IF8SZOHK66nxdHgfKBQpC0q7nhIL7WvV11RlHmJLd9acQ488V6MBga
         qFiDn/wYdNPnMfYkUDEKxgCbAJvAIzfdYQ+v09PfzySkDiToFBWo4AOc7JOjuJ6vOPzB
         goHibmq/R4YPXddZk4Qnwu8ysSsLNEk1ttkmOartzRCYOcrAGNYrfX4XhNmhqq5YrRZt
         /Lng==
X-Gm-Message-State: AFuF++nLF5XYCwWaBhkJb9tp3ODQecynUWx823QdvgYiRpqgX2lNOTNV
	bIu71FrftmaU4oZs9TPkcEiGZVYp8vxHwGx9+UZnKMY53qNfnyKKLnkF0JG/2Fx6z680gjHxdk+
	NqZrKUQE6YL2SDmzE/+nq6lJwd73J8TuFzIrsJ2SHIA0PApD4FJ7t6ahYZqee1cpu
X-Gm-Gg: AR+sD13uALUnP6K+naqprKnsu0SZJC4TaIkTpqtdE5TCk9LCuy/Q52n1gbcMFBUq9gS
	rtD2RKcZIXgVgHiJQIqWwWWW03Il13qJH7OuEASI+e7wRlc2a0Qf5ws6yu3LonY4p/ZehMEUQjf
	zyAGlumHgHg02NoHY2OQ0QAROhoWVMEQymm7AeDHucQrUh/BdrdIMQesXvbxdbb1ArdlaNVgBHP
	wk4EZ4xQ39nI4m/X3h6ce/FOZzfoYVNaj3Bz9xTI84ewprDBsyhM951T2gOsEsUcgDIeC4YbWP/
	fRU5+LYc0FPC9scT7Ti7cGiHCWUjlBcPMH6nfk+ew3JkfztapnjsB95iMjAWwP3SlK7XkxbcEFo
	CHJqHvkUhSGXcRYLSqUXiaYwO19ug/LGiD1nK3Y8ie9sHHDbWgBtV5NTQng==
X-Received: by 2002:a17:90b:3907:b0:390:84db:888e with SMTP id 98e67ed59e1d1-395a0697e10mr7143707a91.7.1787242740422;
        Thu, 20 Aug 2026 09:19:00 -0700 (PDT)
X-Received: by 2002:a17:90b:3907:b0:390:84db:888e with SMTP id 98e67ed59e1d1-395a0697e10mr7143643a91.7.1787242739639;
        Thu, 20 Aug 2026 09:18:59 -0700 (PDT)
Received: from [10.110.112.10] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957f96cb76sm7576140a91.1.2026.08.20.09.18.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 09:18:59 -0700 (PDT)
Message-ID: <c66459c5-0207-4cc5-bea7-71fe0e600aa1@oss.qualcomm.com>
Date: Fri, 21 Aug 2026 00:18:55 +0800
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
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <20260819211845.GB470114@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ftfnS9esRdhL9tf3jJnE6myjMLxZ9aYS
X-Authority-Analysis: v=2.4 cv=V8BNF+ni c=1 sm=1 tr=0 ts=6a8728f5 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=SmSP4sxrsydieoVCgVAA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEyMyBTYWx0ZWRfXyRtQwHrHvcDI
 GVILwvWGppolmFyIxSnYyIK9BkjPfTdNYJuK1IZHdM0NyDTmtd6F/38rKoN/4X+sjxuQx44QUjr
 8bXW3ys2lLTEbpcl/jwzc3d6dr4NcNeUWEQlqBXRbiv78Cb/c5EZdHhLm4dFkvYhKWd/N1rw8a3
 UOdCJLbRX/D9HAi1NuE1hEhDcUxENeQ2S8EtWVZ+8QsMcrXnn+z17v43on0/5DvrWpwx7eBT0zU
 tSdO1nr8372R+MmLB/Tu049wIjK+eWIkZ2a+heeL5IHxA0ztpVi9AEtO5jrBi0/NvefOfb+Ptx4
 eN/SW/6oIAstNc+8qpNDoiya4xWcPNlfBvoPUqb4WmP5iqn5pvH+G4Ni6TNhLEmTAHHEHDVutNM
 aTgrouo3qeMq2kZquIqCukWCk48Jh5Rm47W1vajBG6nWBQAkyRnGxYyToeddVS8NwBtfe2NZI0I
 kbxwrtR6Y9iMfr4OdfA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEyMyBTYWx0ZWRfX9ofql6vNq2MS
 iPCE1fj0tZEHRJuCsbcBcljKBLLmgzCkBgnqd+YM0imGCequSc+Qzzkgz204LnsQjp2VEMpZBHp
 vtIUHVw6HFq91T2SGi0lw8DXmNXcA9U=
X-Proofpoint-GUID: ftfnS9esRdhL9tf3jJnE6myjMLxZ9aYS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_01,2026-08-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200123



On 8/20/2026 5:18 AM, Stefan Hajnoczi wrote:
> On Fri, Aug 14, 2026 at 07:23:01AM -0700, Linlin Zhang wrote:
>> From: linlzhan <linlin.zhang@oss.qualcomm.com>
>>
>> Add VIRTIO_BLK_F_IE to advertise inline encryption support.
>>
>> When the feature is negotiated, the device reports inline encryption
>> characteristics through virtio_blk_enc_characteristics. Add
>> VIRTIO_BLK_T_GET_CRYPTO_MODES, VIRTIO_BLK_T_CRYPTO_IN, and
>> VIRTIO_BLK_T_CRYPTO_OUT so that the driver can discover supported
>> crypto modes and submit inline-encrypted I/O requests.
>>
>> Crypto I/O requests carry a virtual key slot index, data unit size,
>> and initial Data Unit Number (DUN). The device maps the virtual key
>> slot to a physical key slot in the storage backend and uses these
>> parameters for inline encryption or decryption.
>>
>> Key provisioning is performed through an out-of-band mechanism and is
>> outside the scope of this device type.
>>
>> For background on inline encryption in UFS and eMMC storage, see:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/block/inline-encryption.rst
>>
>> Change-Id: I83c52456bc0c9dd37f39ff46e6bfe73a715138ca
>> Signed-off-by: linlzhan <linlin.zhang@oss.qualcomm.com>
>> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/238
>> ---
>>  device-types/blk/description.tex | 297 ++++++++++++++++++++++++++++++-
>>  1 file changed, 291 insertions(+), 6 deletions(-)
>>
>> diff --git a/device-types/blk/description.tex b/device-types/blk/description.tex
>> index 3b3a4e7..f8a544b 100644
>> --- a/device-types/blk/description.tex
>> +++ b/device-types/blk/description.tex
>> @@ -71,7 +71,16 @@ \subsection{Feature bits}\label{sec:Device Types / Block Device / Feature bits}
>>  
>>  \item[VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA (19)] Device supports the
>>      VIRTIO_BLK_REQ_FLAG_OUT_FUA flag in the \field{flags} bitfield of the
>> -    \field{virtio_blk_req} structure for VIRTIO_BLK_T_OUT requests.
>> +    request for VIRTIO_BLK_T_OUT and VIRTIO_BLK_T_CRYPTO_OUT requests.
> 
> More concise: "bitfield in VIRTIO_BLK_T_OUT and VIRTIO_BLK_T_CRYPTO_OUT requests"?

Thanks for your comments!

Does this makes it clear that \field{flags} refers to the field in struct
\field{virtio_blk_req}. If so, I'm fine with the change.

> 
>> +
>> +\item[VIRTIO_BLK_F_IE (22)] Only when the storage backend supports inline
> 
> VIRTIO_BLK_F_INLINE_ENCRYPTION is longer but self-describing. I think
> that name would be clearer.

ACK

> 
>> +    encryption and this feature bit is negotiated, the data read from or
>> +    written to the device can be decrypted from or encrypted to the storage
>> +    via inline crypto engine. Keys are provisioned into key slots of the
> 
> via an inline crypto engine

ACK

> 
>> +    inline crypto engine through a mechanism outside the scope of this device
>> +    type, and requests identify, by key slot index, which provisioned key to
>> +    use. The number of key slots, the maximum DUN size and the supported key
>> +    types are reported in \field{enc_characteristics}.
>>  
>>  \end{description}
>>  
>> @@ -135,6 +144,12 @@ \subsection{Device configuration layout}\label{sec:Device Types / Block Device /
>>                  u8 model;
>>                  u8 unused2[3];
>>          } zoned;
>> +        struct virtio_blk_enc_characteristics {
>> +                le16 max_slots;
>> +                u8 max_dun_bytes;
>> +                u8 key_types;
>> +                le32 unused3;
>> +        } enc_characteristics;
>>  };
>>  \end{lstlisting}
>>  
>> @@ -222,6 +237,39 @@ \subsection{Device configuration layout}\label{sec:Device Types / Block Device /
>>  terminated by the device with a "zone resources exceeded" error as defined for
>>  specific commands later.
>>  
>> +If the VIRTIO_BLK_F_IE feature is negotiated, then in
>> +\field{virtio_blk_enc_characteristics},
>> +\begin{itemize}
>> +\item \field{max_slots} is the number of key slots allocated to the Guest VM.
> 
> It is preferable to avoid virtualization-specific terminology like
> Guest, VM, etc. VIRTIO usage has expanded beyond virtualization and the
> specification tends to use Driver and Device instead of Guest and Host.
> How about:
> 
>   ... is the number of available key slots.
> 

ACK

>> +    It MUST not exceed the number of key slots supported by the inline crypto
>> +    engine of the device backend storage. Key slots are indexed from 0 to
> 
> The MUST sentence needs to be moved to the device normative section
> because the non-normative sections of the specification do not have
> MUST/SHOULD/etc.
> 

ACK

>> +    \field{max_slots} - 1.
>> +
>> +\item \field{max_dun_bytes} is the maximum number of bytes of the Data Unit
>> +    Number (DUN) that the device supports for any of its supported crypto
>> +    modes. For example, known inline crypto engines report a
>> +    \field{max_dun_bytes} of 4 (JEDEC eMMC Command Queue Host Controller
>> +    Interface, CQHCI) or 8 (JEDEC UFS Host Controller Interface, UFSHCI);
>> +    a device backed by different inline crypto engine hardware MAY report
> 
> The MAY clause must go in the device normative section. Or you could
> reword this to something like "but other values are possible depending
> on the inline crypto engine hardware".
> 

ACK

>> +    a different value, subject to the constraints in
>> +    \ref{devicenormative:Device Types / Block Device / Device Initialization}.
>> +
>> +\item \field{key_types} is a bitmask of the key types the device supports,
>> +    using the following values:
>> +    \begin{lstlisting}
>> +#define VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW    (1 << 0)
>> +#define VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED  (1 << 1)
>> +    \end{lstlisting}
>> +    VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW indicates that keys are provisioned into
>> +    key slots in raw (plaintext) form. VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED
>> +    indicates that the key exists only in ephemerally-wrapped form in memory
>> +    outside of dedicated hardware, and can only be unwrapped and provisioned
>> +    into key slots by dedicated hardware (e.g. a hardware key manager). The
>> +    plaintext key never exists in software-accessible memory.
> 
> Why is this reported here if the virtio-blk interface has no ability to
> program key slots? I would expect this information to be part of the key
> programming interface because the extension driver will need to indicate
> whether it is using raw keys or hardware-wrapped keys. The virtio-blk
> driver itself will never never use this information?
> 

key_types describes the key types supported by the hardware. Before keyslot
programming, the key_type requested by the block layer is validated against
this set, and only the key with supported key types are accepted for the
subsequent key programming operation.

>> +
>> +\item \field{unused3} is reserved for future use.
>> +\end{itemize}
>> +
>>  \subsubsection{Legacy Interface: Device configuration layout}\label{sec:Device Types / Block Device / Device configuration layout / Legacy Interface: Device configuration layout}
>>  When using the legacy interface, transitional devices and drivers
>>  MUST format the fields in struct virtio_blk_config
>> @@ -285,6 +333,14 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
>>      \field{zoned} can be read by the driver to determine the zone
>>      characteristics of the device. All \field{zoned} fields are read-only.
>>  
>> +\item If the VIRTIO_BLK_F_IE feature is negotiated, the fields in
>> +    \field{enc_characteristics} can be read by the driver to determine the
>> +    inline encryption capabilities of the device, and a
>> +    VIRTIO_BLK_T_GET_CRYPTO_MODES request (see
>> +    \ref{sec:Device Types / Block Device / Device Operation}) can be sent
>> +    to retrieve the set of supported crypto modes. All
>> +    \field{enc_characteristics} fields are read-only.
>> +
>>  \end{enumerate}
>>  
>>  \drivernormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
>> @@ -312,6 +368,10 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
>>  offered by the device with the VIRTIO_BLK_Z_HA or VIRTIO_BLK_Z_NONE zone model,
>>  then the driver MAY negotiate these two bits independently.
>>  
>> +Zoned devices do not support inline encryption. If the VIRTIO_BLK_F_ZONED
>> +feature is offered by the device, then the VIRTIO_BLK_F_IE feature MUST NOT
>> +be negotiated by the driver.
>> +
>>  If the VIRTIO_BLK_F_ZONED feature is negotiated, then
>>  \begin{itemize}
>>  \item if the driver that can not support host-managed zoned devices
>> @@ -327,6 +387,12 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
>>  The driver MUST NOT negotiate VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA without
>>  VIRTIO_BLK_F_REQ_FLAGS.
>>  
>> +Drivers MUST NOT negotiate the VIRTIO_BLK_F_IE feature if they are
>> +incapable of provisioning keys into the key slots of the device backend
>> +storage's inline crypto engine, or of conveying the key slot index,
>> +data unit size in bits, and Data Unit Number (DUN) per request to
>> +the device using the \field{virtio_blk_crypto_msg} structure.
>> +
>>  \devicenormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
>>  
>>  Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it
>> @@ -341,9 +407,15 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
>>  If the device that is being initialized is a not a zoned device, the device
>>  SHOULD NOT offer the VIRTIO_BLK_F_ZONED feature.
>>  
>> +A zoned device MUST NOT offer the VIRTIO_BLK_F_IE feature.
>> +
>>  The VIRTIO_BLK_F_ZONED feature cannot be properly negotiated without
>>  FEATURES_OK bit. Legacy devices MUST NOT offer VIRTIO_BLK_F_ZONED feature bit.
>>  
>> +The VIRTIO_BLK_F_IE feature cannot be properly negotiated without
>> +FEATURES_OK bit. Legacy devices MUST NOT offer the VIRTIO_BLK_F_IE feature
>> +bit.
>> +
>>  If the VIRTIO_BLK_F_ZONED feature is not accepted by the driver,
>>  \begin{itemize}
>>  \item the device with the VIRTIO_BLK_Z_HA or VIRTIO_BLK_Z_NONE zone model SHOULD
>> @@ -415,6 +487,26 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
>>  The device MUST NOT acknowledge FEATURES_OK if the driver sets
>>  VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA without VIRTIO_BLK_F_REQ_FLAGS.
>>  
>> +The device MUST NOT acknowledge FEATURES_OK if the driver negotiates both
>> +VIRTIO_BLK_F_ZONED and VIRTIO_BLK_F_IE.
>> +
>> +If the device is incapable of consuming the \field{virtio_blk_crypto_msg},
>> +the device SHOULD NOT offer the VIRTIO_BLK_F_IE feature.
>> +
>> +If the VIRTIO_BLK_F_IE feature is negotiated, the device MUST set
>> +\field{max_slots} in \field{enc_characteristics} to a value greater than 0.
>> +
>> +If the VIRTIO_BLK_F_IE feature is negotiated, the device MUST set
>> +\field{key_types} in \field{enc_characteristics} to have at least one of
>> +VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW or VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED
>> +set, and MUST NOT set any bit in \field{key_types} other than
>> +VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW and VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED.
>> +The device MUST initialize padding bytes \field{unused3} to 0.
>> +
>> +The device MUST NOT set \field{max_dun_bytes} in \field{enc_characteristics}
>> +to 0 or to a value greater than 8, since \field{dun} of
>> +\field{virtio_blk_crypto_msg} is a fixed 8-byte field.
>> +
>>  \subsubsection{Legacy Interface: Device Initialization}\label{sec:Device Types / Block Device / Device Initialization / Legacy Interface: Device Initialization}
>>  
>>  Because legacy devices do not have FEATURES_OK, transitional devices
>> @@ -478,8 +570,8 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>>  value is the bit index in the \field{flags} bitfield):
>>  
>>  \begin{description}
>> -\item[VIRTIO_BLK_REQ_FLAG_OUT_FUA (0) for VIRTIO_BLK_T_OUT requests] Force Unit
>> -    Access (FUA) flag.
>> +\item[VIRTIO_BLK_REQ_FLAG_OUT_FUA (0) for VIRTIO_BLK_T_OUT and
>> +    VIRTIO_BLK_T_CRYPTO_OUT requests] Force Unit Access (FUA) flag.
>>  \end{description}
>>  
>>  The \field{sector} number indicates the offset (multiplied by 512) where
>> @@ -886,6 +978,108 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>>  operation by setting the VIRTIO_BLK_S_ZONE_INVALID_CMD value in
>>  \field{status} of \field{virtio_blk_req} structure.
>>  
>> +The following requirements only apply if the VIRTIO_BLK_F_IE feature is
>> +negotiated.
>> +
>> +In addition to the request types defined for devices without inline
>> +encryption support, the type of the request can be an inline-encrypted read
>> +(VIRTIO_BLK_T_CRYPTO_IN), an inline-encrypted write (VIRTIO_BLK_T_CRYPTO_OUT)
>> +or a get crypto modes command (VIRTIO_BLK_T_GET_CRYPTO_MODES).
>> +
>> +\begin{lstlisting}
>> +#define VIRTIO_BLK_T_CRYPTO_OUT        27
>> +#define VIRTIO_BLK_T_CRYPTO_IN         28
>> +#define VIRTIO_BLK_T_GET_CRYPTO_MODES  30
>> +\end{lstlisting}
>> +
>> +VIRTIO_BLK_T_CRYPTO_IN and VIRTIO_BLK_T_CRYPTO_OUT requests behave the same
>> +as VIRTIO_BLK_T_IN and VIRTIO_BLK_T_OUT requests respectively, except that
>> +the data in \field{data} is decrypted (for VIRTIO_BLK_T_CRYPTO_IN) or is to
>> +be encrypted (for VIRTIO_BLK_T_CRYPTO_OUT) by the inline crypto engine in
>> +the device backend storage using the key already provisioned in the key
>> +slot identified by the request, combined with the request's Data Unit
>> +Number (DUN). For this reason, the VIRTIO_BLK_T_CRYPTO_IN and
>> +VIRTIO_BLK_T_CRYPTO_OUT requests have the layout that is extended to have
>> +the \field{crypto_msg} field to carry this information:
>> +
>> +\begin{lstlisting}
>> +struct virtio_blk_req_crypto {
>> +        le32 type;
>> +        le32 flags;
>> +        le64 sector;
>> +        struct virtio_blk_crypto_msg crypto_msg;
>> +        u8 data[];
>> +        u8 status;
>> +};
>> +\end{lstlisting}
>> +
>> +\field{crypto_msg} has the following structure:
>> +
>> +\begin{lstlisting}
>> +struct virtio_blk_crypto_msg {
>> +        le32 slot;
>> +        le32 data_unit_size_bits;
>> +        le64 dun;
>> +};
>> +\end{lstlisting}
>> +
>> +\field{slot} is the virtual key slot index, in the range from 0 to
>> +\field{max_slots} - 1 of \field{enc_characteristics}. The device maps this
>> +virtual key slot index to a physical key slot in the inline crypto engine of
>> +the device backend storage.
>> +\field{data_unit_size_bits} is $log_2$ of the data unit size in bytes,
>> +used for calculating DUNs for sub-requests if the request is split.
> 
> Mention VIRTIO_BLK_T_CRYPTO_MODES here so the reader knows how the
> driver will pick a data_unit_size_bits value?
> 

Thanks for pointing it out!

The crypto mode and data unit size are configured by fscrypt and propagated
through the block layer. After validating that the selected combination is
supported by the hardware, both values are programmed into the keyslot
configuration registers. Therefore, data_unit_size is associated with the
programmed key.

Re-write it as
  - used for calculating DUNs for sub-requests if the request is split.
    The value corresponds to the data unit size associated with the
    programmed key and written into the keyslot configuration registers
    during key programming.


>> +\field{dun} is the Data Unit Number, that is, the initial value that the
>> +inline crypto engine increments by one for each successive data unit of
>> +the size specified by \field{data_unit_size_bits}, while encrypting or
>> +decrypting the data of the request.
>> +
>> +VIRTIO_BLK_T_GET_CRYPTO_MODES is a read request that returns the data unit
>> +sizes with which each of the device's crypto modes can be used. The
>> +response consists of a header followed by zero or more \field{le32}
>> +bitmask elements, indexed by crypto mode number:
>> +
>> +\begin{lstlisting}
>> +struct virtio_blk_crypto_modes {
>> +        le32   nr_modes;
>> +        u8     reserved[4];
>> +        le32   modes[];
>> +};
>> +\end{lstlisting}
>> +
>> +The device sets \field{nr_modes} in the response header to the number of
>> +fully transferred \field{modes} elements in the data buffer. \field{modes[N]},
>> +for crypto mode number N, is a bitmask indicating the data unit sizes with
>> +which crypto mode N can be used by the device: the i'th bit of
>> +\field{modes[N]} is set if crypto mode N can be used with a data unit size
>> +of $(1 << i)$ bytes. A value of 0 for a \field{modes} element indicates
>> +that the device does not support the corresponding crypto mode at all.
>> +Crypto mode number 0 is reserved; \field{modes[0]} is always set to 0 by
>> +the device.
>> +
>> +Crypto mode numbers are assigned by this specification, independently of
>> +any operating system's internal representation of crypto algorithms, so
>> +that support for additional crypto modes can be added in future revisions
>> +of this specification without changing the meaning of previously assigned
>> +numbers:
>> +
>> +\begin{lstlisting}
>> +#define VIRTIO_BLK_CRYPTO_MODE_AES_256_XTS        1
>> +#define VIRTIO_BLK_CRYPTO_MODE_AES_128_CBC_ESSIV  2
>> +#define VIRTIO_BLK_CRYPTO_MODE_ADIANTUM           3
>> +#define VIRTIO_BLK_CRYPTO_MODE_SM4_XTS            4
>> +\end{lstlisting}
>> +
>> +A driver or device implementation MAY support only a subset of these
>> +crypto modes. Crypto mode numbers already assigned by this or an earlier
>> +version of this specification are never reused for a different crypto
>> +mode; additional crypto modes are assigned new numbers, greater than the
>> +highest number defined by the version of this specification the
>> +implementation supports.
>> +
>> +VIRTIO_BLK_T_CRYPTO_IN and VIRTIO_BLK_T_GET_CRYPTO_MODES requests are reads,
>> +and VIRTIO_BLK_T_CRYPTO_OUT requests are writes.
>> +
>>  \drivernormative{\subsubsection}{Device Operation}{Device Types / Block Device / Device Operation}
>>  
>>  The driver SHOULD check if the content of the \field{capacity} field has
>> @@ -904,8 +1098,8 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>>  A driver MUST set \field{sector} to 0 for a VIRTIO_BLK_T_FLUSH request.
>>  A driver SHOULD NOT include any data in a VIRTIO_BLK_T_FLUSH request.
>>  
>> -The length of \field{data} MUST be a multiple of 512 bytes for VIRTIO_BLK_T_IN
>> -and VIRTIO_BLK_T_OUT requests.
>> +The length of \field{data} MUST be a multiple of 512 bytes for VIRTIO_BLK_T_IN,
>> +VIRTIO_BLK_T_OUT, VIRTIO_BLK_T_CRYPTO_IN and VIRTIO_BLK_T_CRYPTO_OUT requests.
>>  
>>  The length of \field{data} MUST be a multiple of the size of struct
>>  virtio_blk_discard_write_zeroes for VIRTIO_BLK_T_DISCARD,
>> @@ -984,6 +1178,42 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>>  
>>  \end{enumerate}
>>  
>> +The following requirements only apply if the VIRTIO_BLK_F_IE feature is
>> +negotiated.
>> +
>> +A driver MUST NOT submit a VIRTIO_BLK_T_CRYPTO_IN or VIRTIO_BLK_T_CRYPTO_OUT
>> +request with a \field{slot} value that is not less than \field{max_slots} of
> 
> "not less" -> "greater" (too many negatives in this MUST NOT sentence :))
> 

ACK

As \field{slot} starts from 0, correct the statement to

  - request with a \field{slot} value that is greater than \field{max_slots} of
    \field{enc_characteristics} - 1,

>> +\field{enc_characteristics}, or that identifies a key slot into which no key
>> +has been provisioned.
>> +
>> +A driver MUST set \field{data_unit_size_bits} of a VIRTIO_BLK_T_CRYPTO_IN or
>> +VIRTIO_BLK_T_CRYPTO_OUT request's \field{crypto_msg} to $log_2$ of the data
>> +unit size in bytes associated with the key provisioned in the virtual key
>> +slot identified by \field{slot}. Since data unit sizes are reported by
>> +VIRTIO_BLK_T_GET_CRYPTO_MODES as a bitmask of \field{le32} elements, a
>> +driver MUST NOT set \field{data_unit_size_bits} to a value greater than 31.
>> +
>> +A driver MUST NOT submit a VIRTIO_BLK_T_CRYPTO_IN or VIRTIO_BLK_T_CRYPTO_OUT
>> +request with a zero length \field{data}.
> 
> Does VIRTIO_BLK_T_WRITE_ZEROES need an equivalent
> VIRTIO_BLK_T_CRYPTO_WRITE_ZEROES request type? If the driver sends
> VIRTIO_BLK_T_WRITE_ZEROES then the device might write zeroes in
> plaintext, which isn't what we want.
> 

Yes, it's still cipher text that is flushed into disk even the driver sends
VIRTIO_BLK_T_WRITE_ZEROES. Need add a VIRTIO_BLK_T_CRYPTO_WRITE_ZEROES request
type.

>> +
>> +A driver MUST NOT submit a VIRTIO_BLK_T_CRYPTO_IN or VIRTIO_BLK_T_CRYPTO_OUT
>> +request unless \field{sector}, multiplied by 512, and the length of
>> +\field{data}, are both a multiple of $(1 << \field{data_unit_size_bits})$
>> +bytes.
>> +
>> +A driver MUST NOT submit a VIRTIO_BLK_T_CRYPTO_IN or VIRTIO_BLK_T_CRYPTO_OUT
>> +request if \field{dun} + $N$ - 1 is not representable in
>> +\field{max_dun_bytes} bytes, where $N$ is the number of data units of
>> +$2^{\field{data_unit_size_bits}}$ bytes in \field{data}.
>> +
>> +A driver MUST treat any crypto mode number that is not less than
> 
> "not less" -> "greater"
> 

ACK

>> +\field{nr_modes} of a VIRTIO_BLK_T_GET_CRYPTO_MODES response as unsupported
>> +by the device.
>> +
>> +A driver MUST provide a \field{data} buffer of at least
>> +sizeof(struct virtio_blk_crypto_modes) (8) bytes for a
>> +VIRTIO_BLK_T_GET_CRYPTO_MODES request.
>> +
>>  \devicenormative{\subsubsection}{Device Operation}{Device Types / Block Device / Device Operation}
>>  
>>  The device MAY change the content of the \field{capacity} field during
>> @@ -1030,7 +1260,8 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>>  
>>  \item\label{item:flush3} the VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA feature was
>>    negotiated and the VIRTIO_BLK_REQ_FLAG_OUT_FUA bit in \field{flags} was set in
>> -  the write request (regardless of whether the VIRTIO_BLK_F_FLUSH or
>> +  the write request (VIRTIO_BLK_T_OUT or VIRTIO_BLK_T_CRYPTO_OUT, regardless of
>> +  whether the VIRTIO_BLK_F_FLUSH or
>>    VIRTIO_BLK_F_CONFIG_WCE features were negotiated, and regardless of the
>>    current cache mode as expressed by the value of the \field{writeback} field in
>>    configuration space).
>> @@ -1225,6 +1456,60 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>>  handles VIRTIO_BLK_T_ZONE_RESET request for the zone range specified in the
>>  VIRTIO_BLK_T_SECURE_ERASE request.
>>  
>> +The following requirements only apply if the VIRTIO_BLK_F_IE feature is
>> +negotiated.
>> +
>> +If a VIRTIO_BLK_T_CRYPTO_IN or VIRTIO_BLK_T_CRYPTO_OUT request:
>> +\begin{itemize}
>> +\item specifies a \field{slot} value that is not less than \field{max_slots},
>> +    or that identifies a key slot into which no key has been provisioned,
>> +
>> +\item specifies a \field{data_unit_size_bits} value greater than 31, or
>> +    that does not match $log_2$ of the data unit size in bytes associated
>> +    with the key provisioned in the virtual key slot identified by the
>> +    \field{slot},
>> +
>> +\item specifies a zero length \field{data},
>> +
>> +\item specifies a \field{sector}, multiplied by 512, or a length of
>> +    \field{data}, that is not a multiple of $(1 << \field{data_unit_size_bits})$
>> +    bytes, or
>> +
>> +\item specifies a \field{dun} such that \field{dun} + $N$ - 1 is not
>> +    representable in \field{max_dun_bytes} bytes, where $N$ is the number
>> +    of data units of $2^{\field{data_unit_size_bits}}$ bytes in
>> +    \field{data},
>> +\end{itemize}
>> +then the device MUST set the \field{status} byte to VIRTIO_BLK_S_UNSUPP and
>> +MUST NOT read or write any data.
>> +
>> +If a VIRTIO_BLK_T_GET_CRYPTO_MODES request's \field{data} buffer is smaller
>> +than sizeof(struct virtio_blk_crypto_modes) (8) bytes, the device MUST set
>> +the \field{status} byte to VIRTIO_BLK_S_UNSUPP and MUST NOT write any data.
>> +
>> +If the driver's \field{data} buffer in a VIRTIO_BLK_T_GET_CRYPTO_MODES
>> +request is not large enough to hold \field{modes} elements up to the
>> +highest crypto mode number the device supports, the device MUST set
>> +\field{nr_modes} to the number of complete \field{modes} elements that fit
>> +in the buffer, and MUST NOT write a partial element.
> 
> This interface offers no way to query the maximum crypto mode. It seems
> the assumption is that this will never be needed since the driver
> hardcodes VIRTIO_BLK_CRYPTO_MODE_* values. It would be more flexible to
> define VIRTIO_BLK_T_GET_CRYPTO_MODES in a way that queries the device's
> maximum crypto mode index.
> 
> The nr_modes field is kind of redundant anyway since the device fills
> modes[] elements with 0 when the mode is not supported and the driver
> determines the buffer size (it will not look any further). So the device
> doesn't really need to tell the driver how many modes were filled in,
> but it's potentially more useful to tell the driver what the highest
> crypto mode index is so the driver can size its data buffer correctly in
> the next VIRTIO_BLK_T_GET_CRYPTO_MODES request.
> 
> I don't feel strongly about this, but it seems more flexible and it's
> easy to get this into the spec now, rather than later.
> 

Thanks for the comments.

I agree that exposing the highest crypto mode index would allow the driver
to allocate the correct buffer size for a subsequent
VIRTIO_BLK_T_GET_CRYPTO_MODES request.

However, this would imply that a particular crypto mode could be unsupported
for file-based encryption on one virtio-blk device while being supported on
another. That does not seem to be a meaningful use case.

Given that AES-256-XTS is currently the only crypto mode with actual hardware
support, as Eric pointed out, I wonder whether we could simply define all
inline-encryption crypto modes directly in the virtio specification. In that
case, the driver would always know the exact buffer size in advance,
eliminating the need to query the highest mode index. If additional crypto
modes gain hardware support in the future, the virtio specification could be
extended accordingly.

>> +
>> +The device MUST initialize padding bytes \field{reserved} of a
>> +VIRTIO_BLK_T_GET_CRYPTO_MODES response to 0.
>> +
>> +For a VIRTIO_BLK_T_CRYPTO_IN or VIRTIO_BLK_T_CRYPTO_OUT request, the device
>> +MUST use the key provisioned in the virtual key slot identified by
>> +\field{slot} of the request's \field{crypto_msg}, combined with \field{dun},
>> +to decrypt the data read from, or encrypt the data written to, the device
>> +backend storage. If the device backend storage splits the request into
>> +sub-requests, each sub-request MUST begin at a byte offset, from the start
>> +of \field{data}, that is a multiple of $(1 << \field{data_unit_size_bits})$
>> +bytes, MUST have a length that is a multiple of
>> +$(1 << \field{data_unit_size_bits})$ bytes, and MUST use, in place of
>> +\field{dun}, the Data Unit Number
>> +$\field{dun} + (\mathit{byte\_offset} / (1 << \field{data_unit_size_bits}))$,
>> +where $\mathit{byte\_offset}$ is that sub-request's starting byte offset
>> +from the start of \field{data}.
>> +
>>  \subsubsection{Legacy Interface: Device Operation}\label{sec:Device Types / Block Device / Device Operation / Legacy Interface: Device Operation}
>>  When using the legacy interface, transitional devices and drivers
>>  MUST format the fields in struct virtio_blk_req
>> -- 
>> 2.34.1
>>

