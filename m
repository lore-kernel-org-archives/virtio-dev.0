Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B97A3876BB
	for <virtio-dev@lists.linux.dev>; Sat, 22 Aug 2026 10:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787393051; cv=none; b=kR/Ezn2vY3yB7GZ8xUHTgl/zasOBH1jvZ+34qIVhneslJ5QZdSt890CGlz6ASDvpzcwFZwAV1RcqCyDdo52c3ZR0QG+3qr2rctT+46JMUyf1r8t1Sxae10GpeYI8nenF2qY5C2ffOVJyxzMgdhr299v9eHK60+7COK9Iztw3+Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787393051; c=relaxed/simple;
	bh=CkFGwAZhUOeq2XyEnUpazHpdMxwnQ8uWrz0G/xKv82c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IIr//DDyIbzdcbKf7z7Fx/fgWXnqufbNCpYIHuj6WFyy8ytyKi9OEGuuHgez4aLpmsO++wTvZYKQlBuk/kbP61E3W43KQV9I9bhU6MIdSTBW3OF8pj3qvEDUKLz1IScEVkCk3qDqJwv3Uk+a2Hgi5lDhpvPCLJyYKc/JXWWphtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LoRbQY64; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DLp2PN1A; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LoRbQY64";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DLp2PN1A"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67M7xcG71002259
	for <virtio-dev@lists.linux.dev>; Sat, 22 Aug 2026 10:04:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uCYKuE1REgSBChjofbPe4Bn8xZBUJrUzY2LVawGVn2Y=; b=LoRbQY64tK7XWjzo
	ReUgsqVz6gn9s+RleLC15uiUoqcZaFF1r24fM2gVMQroKGHnUnmVbDit3NRwttho
	Fm5eXkYAu1S3ul0UMtZqOn7TEx4cAXdJgHDszRAKyWk/C/s1D9auts1nGx+i0oY/
	9hYT0jMNr5x45af8+8qkDrX9RgUI4fE3sqzgi3OCctxptAeQbh0ZKXZIrzu1DiOx
	Batl76DHG1nIu4k+bkCDh8npBmSW316kb1ZGNsi47jenkFr40NaAlMb2uoCXXGFL
	l31kmcLwlz5kHIGuOguiXPBcAuIyQgXhWLKnJdAfAZALthV+ZdR5wRYzubo980Ga
	6gkmzw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g740a0xgn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Sat, 22 Aug 2026 10:04:08 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cbee5bab340so2426937a12.2
        for <virtio-dev@lists.linux.dev>; Sat, 22 Aug 2026 03:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787393046; x=1787997846; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uCYKuE1REgSBChjofbPe4Bn8xZBUJrUzY2LVawGVn2Y=;
        b=DLp2PN1AF1g8y1zTRa4nBTg1+USzuA7IGik0homfzuVHvw+1mHCSNN30RtkCzJQPOV
         HC2ueEm3gFszGue3L5bp7x980W27hI5Inj1gwZJvlQHxBsmD4xpWH0ZcDbIj2qpEgVMB
         tgXvCnc0B6iTmUuNFuy688pR2zBP1R3H+i4MREGt1I4Pr512oPsozNNRhftmwiTLA3ri
         WY6s5/NkiLttvqZd7Ee+kmb4wRTMAYzRG8oltgAykdnPcuLmsUGAT7XXst4sbEV41ga0
         F5BsdE3ZGuGwB8ZliINKaBl3rVwb05es+gZNyB7A7FGXduZoeu3Dj3re3AwetYgxbb6J
         v94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787393046; x=1787997846;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uCYKuE1REgSBChjofbPe4Bn8xZBUJrUzY2LVawGVn2Y=;
        b=mALLmiW8xOUjS+rXZJdB6s2jz49GK7dk3tFq3pwZwEkjZQ8i43nxPDDD+5C9siGvG+
         KSbvIdTtL6cy01j3mqmBHxA6wY8Yt5o40EVmDoF5ichX5UhpOYT9ZfSbnHdg+IkEFSj8
         HhH588ei2LWbbDNTgzJIAol6a1hUSVQzfdhD/NHdW6HCtAD9ul8FEGL1kxr3/SEGJK7S
         3XzbJvGkSMxyihtOQ1bdgnMybohRn0kUVqhShsahls6ENnF8fdtUANe8RTo6O/IOpOuN
         5WJXlEIB9v8DV4zYkeNkSUTmCtH4UkS0S6xPnZkkEHAF6H7mhfgo1GnMS6d+2yWSLkL4
         IH3A==
X-Gm-Message-State: AFuF++ns0rnrNcMsgrTpvaiqIsRyc8m+J1Wxw1MO4yeU/xCxEB6P+rWs
	hJ0yKNwu+gIvNBf3Wk3HPsVWZkThS4IsTM+kUztTJxHPYUJ8m4y4hwhRNtLJB+gchgItYInGk70
	UIw9kQlLmiNFTZzqehR2f/3ZA2w+ERRXVWtAoR9HPP9soM0TF6QC8lzcoF9hQxENd
X-Gm-Gg: AR+sD13tVb0hB4sgi3sfBzpcwxGFeBIgbzw6XYcdUrR3tCmuEsICCmfmgWD//sKRJHA
	vDY/objbzrOLQ6Rws4b2uW8mkut7eH6Z2yk3ugxKkUAdzncA2C72n87+cMc2EgsyDlmNwMA17X6
	a//K8VSC1ciLA4PuPcuXkn3LBHoiVYPpHEfKnvWCNcuxH2GryXwMWJs58HK0zVjmriHJFOw9Nbf
	UeskDqvZ6HrHArAHJApatr/6xN4aYKDBrVVJbSmAZwr14VPEXiO62Uh7pfGhzShnanThr8JBZuv
	oM20dvK6xPQOn7R9pjom5gDhEscAeYNvPNGtPQg7FQN4Qdd2ygqtiWJlCMqpANAZpkD4lerBbwk
	a//dwqHIoHrZSty0la4o6AEdGIJIJ5Lcyp0GmDXd+FEzKM1UWrggDcAsKkA==
X-Received: by 2002:a05:6a21:6118:b0:3a0:bc61:62e6 with SMTP id adf61e73a8af0-3cd2feae8b2mr24084035637.8.1787393045922;
        Sat, 22 Aug 2026 03:04:05 -0700 (PDT)
X-Received: by 2002:a05:6a21:6118:b0:3a0:bc61:62e6 with SMTP id adf61e73a8af0-3cd2feae8b2mr24083940637.8.1787393045427;
        Sat, 22 Aug 2026 03:04:05 -0700 (PDT)
Received: from [10.110.27.147] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f91d37cesm6082179eec.15.2026.08.22.03.04.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 03:04:05 -0700 (PDT)
Message-ID: <f018905a-662a-407b-84e5-589e9dc15f50@oss.qualcomm.com>
Date: Sat, 22 Aug 2026 18:04:02 +0800
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
 <8ee0da17-1d2b-4465-8fd5-3f6ab401d729@oss.qualcomm.com>
 <20260821153351.GB564943@fedora>
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <20260821153351.GB564943@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIyMDA4MSBTYWx0ZWRfX7hrT5IyLuun6
 +CelNMsai2d/O0OD3B/0AMpzehHUj1E/sfWSf3Dbinbcr/roDT9RYF0wu/SlHJHQzLz3BAXrhT4
 uWx68QLdHon+1/bgpvkOubg1r5G2OZ1hg8VDKjl3bOZTDN+gGu3JdQoLp7VEpX4kt1pfmR0UN0p
 I1Qki4P0Nx7YtP+V/cA/G9q2gpdIhuPzULXND1oEtJ6mT6lHXGZloSH/NAyL9R7U6wv9NA3g8Bz
 WhydTRlqCMrdsSFZIEvTphGzWsgclM7QYLp5UK8NENMc0U2imzQxSHkz0sIzC7jBw5YWVT3jpZ4
 rNgfrlB0xzhxU/CxyCnKTjkffpWudNRfB1Z8f9xNqpMGDh2m5Xklva+azTON3PboM7gs8fZXPL4
 SWoiRIrbNHl3jrddd3mTYAa78HRrTKWUMJL6wM5YgpL8IzMFiLhAC/1RR5Mc9iMARbCAPlxWL4l
 K2XE9g1e82otg4ZraQg==
X-Authority-Analysis: v=2.4 cv=HZgkiCE8 c=1 sm=1 tr=0 ts=6a897418 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=XDZ0OqISkSXJCW26VVgA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: cIYHL5AVaWSdDj10HAJ8f2yOym2GP602
X-Proofpoint-GUID: cIYHL5AVaWSdDj10HAJ8f2yOym2GP602
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIyMDA4MSBTYWx0ZWRfX8l0Nyn/B7Bbt
 YTiIT6AKcTwTo6LuyV7UwiR8sMlJz9trxubyVF8UxuupFjU1J1MJY+FfrBVIRjN8yq3m4nGyyqC
 oKhCpZmFNKidgMRXZ9veXIPL33yqBKo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-22_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608220081



On 8/21/2026 11:33 PM, Stefan Hajnoczi wrote:
> On Fri, Aug 21, 2026 at 08:49:03PM +0800, Linlin Zhang wrote:
>>
>>
>> On 8/21/2026 12:18 AM, Linlin Zhang wrote:
>>>
>>>
>>> On 8/20/2026 5:18 AM, Stefan Hajnoczi wrote:
>>>> On Fri, Aug 14, 2026 at 07:23:01AM -0700, Linlin Zhang wrote:
>>>
>>>>> +\field{enc_characteristics}, or that identifies a key slot into which no key
>>>>> +has been provisioned.
>>>>> +
>>>>> +A driver MUST set \field{data_unit_size_bits} of a VIRTIO_BLK_T_CRYPTO_IN or
>>>>> +VIRTIO_BLK_T_CRYPTO_OUT request's \field{crypto_msg} to $log_2$ of the data
>>>>> +unit size in bytes associated with the key provisioned in the virtual key
>>>>> +slot identified by \field{slot}. Since data unit sizes are reported by
>>>>> +VIRTIO_BLK_T_GET_CRYPTO_MODES as a bitmask of \field{le32} elements, a
>>>>> +driver MUST NOT set \field{data_unit_size_bits} to a value greater than 31.
>>>>> +
>>>>> +A driver MUST NOT submit a VIRTIO_BLK_T_CRYPTO_IN or VIRTIO_BLK_T_CRYPTO_OUT
>>>>> +request with a zero length \field{data}.
>>>>
>>>> Does VIRTIO_BLK_T_WRITE_ZEROES need an equivalent
>>>> VIRTIO_BLK_T_CRYPTO_WRITE_ZEROES request type? If the driver sends
>>>> VIRTIO_BLK_T_WRITE_ZEROES then the device might write zeroes in
>>>> plaintext, which isn't what we want.
>>>>
>>>
>>> Yes, it's still cipher text that is flushed into disk even the driver sends
>>> VIRTIO_BLK_T_WRITE_ZEROES. Need add a VIRTIO_BLK_T_CRYPTO_WRITE_ZEROES request
>>> type.
>>>
>>
>> I double-checked VIRTIO_BLK_T_WRITE_ZEROES. Since a request may consist of
>> multiple non-contiguous segments, handling DUN calculation becomes difficult
>> if the backend needs to divide the request. Because both sector offset and
>> data length per segment need be aligned with Data Unit Size, and only the DUN
>> for the first segment can be appended to the crypto message in the virtio reqeust.
>>
>> For this reason, I would prefer not to introduce VIRTIO_BLK_T_CRYPTO_WRITE_ZEROES,
>> consistent with the treatment of discard/erase requests.
>>
>> I'm appreciated if you have any thoughts about it.
> 
> The storage stack supports devices that do not have write zeroes
> operations, so I don't think there is any problem - except that the
> performance benefits of write zeroes are lost.
> 
> It's worth adding a sentence to the spec as a reminder that only
> VIRTIO_BLK_T_CRYPTO_WRITE/READ are encrypted so drivers must not reach
> for write_zeroes, etc since they are not encrypted.
> 

Thanks!

I agree with you, and follow your advice to add bellow in in
\drivernormative{\subsubsection}{Device Operation}{Device Types / Block Device / Device Operation}

  - If the driver would otherwise use a virtual key slot's inline encryption
    to encrypt the data written to a range of the device backend storage,
    the driver MUST NOT submit a VIRTIO_BLK_T_WRITE_ZEROES request for that
    range: doing so would cause literal zero bytes to be written to the
    device backend storage, bypassing the inline crypto engine, which a
    later VIRTIO_BLK_T_CRYPTO_IN request covering the same range would then
    misinterpret as ciphertext. The driver MUST instead submit a
    VIRTIO_BLK_T_CRYPTO_OUT request whose \field{data} consists entirely of
    zero bytes, so that the device backend storage receives properly
    encrypted ciphertext for that range.

> And the Linux driver implementation needs to be careful not to send
> write zeroes.
> 

Yes. The current Linux implementation already handles this correctly
in Linux File System (FS). Linux FS, which is the primary user of
inline encryption, distinguishes between fscrypt and non-fscrypt
requests, so VIRTIO_BLK_T_WRITE_ZEROES can only be issued through the
non-fscrypt path and is never used for encrypted I/O.

> Stefan


