Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECAB262FD0
	for <virtio-dev@lists.linux.dev>; Thu, 20 Aug 2026 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787236676; cv=none; b=IXL9uXUWpwm1UzQJnI2KnohV31fwXMH2rqsJqQLruUXcqPX1espPyRL1Duj2jw2T8fjGOhQrvnYGDiX+0g4YMwEjooRJ8MuCl66vlxieO+ZqOdIXaTheyFTFbT/f+QAdh0O8n5kgIzNnUaLttTbeTcWypWXcloJBifVXxXQKMKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787236676; c=relaxed/simple;
	bh=1Hi2FTa2uwVE8bIZvFo0DEUql47kxQDP5JYWeMwCc7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Clcj24+Ia+Y8GXOmaGOf2BCfiDiA7TR664ijkHw6X1c+T/op5zufZdR7MhEFIGup/EIb3fkBRQ7i/iS4NvDHx6WjxzIrGk9uqkcSo0UfUUKvC5J8jX5JsAYLP9DC2bhBMl6e5twUI9Zb+RhIbje5Jm4fejKFQETYaLGD+ItFZmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RYnCa1Z5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LzPOto3j; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RYnCa1Z5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LzPOto3j"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KE7mNP3220244
	for <virtio-dev@lists.linux.dev>; Thu, 20 Aug 2026 14:37:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0Enu8BEOifmfAjR85XuWI0sXp9RhtU87AcnraqBvMR4=; b=RYnCa1Z588x6HUoU
	ykscs0QwxUQe1Nwf4hEkZD0ljM5Wb8KUrW3H0moo8Wdgjcm3/G8YbaLMyd1Jht9Y
	7N+Q5usu91Sgv1M8QSWXx4I47NI75VmYBfA/JYVPwQiPIIfwAIe1YHTVgNKxZfCH
	9K/VxzzDVisEvMg8+EnB4X5uF6c8QvKBqxNzeZX6clxodDfKQ+0XUELoRvzhYcAr
	kT1kW0harGc3CRItyShlOZa1/ATAD6s7O76a5xRANUpHJGrgk0vimVnlHCALYzph
	J+hFBkXwoFFcUHIMfJ9xp25NIwqZnhoWdVxAOHCSHGKOTfLad8i6LJpiXuh/jk8g
	s+jflA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5x29hggu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Thu, 20 Aug 2026 14:37:54 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-936e393061dso215682385a.2
        for <virtio-dev@lists.linux.dev>; Thu, 20 Aug 2026 07:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787236673; x=1787841473; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0Enu8BEOifmfAjR85XuWI0sXp9RhtU87AcnraqBvMR4=;
        b=LzPOto3jjkXE7W5QGJQT0IRTdAP4JR0vK8eYiDIBOynSxkDcVeP8raTJ7aqyKhglhr
         7r2o+QR+lCLQ6JDLiPy00B0kPRBOxQ4BIqBRqua2Zi+UDSs9i6a+6ivNO/fqld1IsX2x
         DtOnFBiaq0tAz1vzC4EKfqJ71xA356GDQ6jzhRr91TZfyHORgr3ANnkCRYCCkL//JIVf
         BAEQhoCI07y8TQzneKcLkj11tsir8iQ8WI8ciG1UODb9MThn8UCfawjScKYfvQMoVdBh
         jiO/xjfi711K5H+kBgylyExcYdCAg2AuVgJAI10nmVxVNFDG6LFSua6f+YBoG9iKnojW
         /dhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787236673; x=1787841473;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Enu8BEOifmfAjR85XuWI0sXp9RhtU87AcnraqBvMR4=;
        b=mqFEN2UZvhfbaw7X0kODwlifvO58AgGz6bNvyp00eEKwrk40HZM+aKW3Dk3zSd+Hwb
         P599wn0h9fxgyRDtv20OkGGxgInl325ypa5l+SodEKcDmkW2mol1OSjtglARzFTTWGt4
         O0y2r5NLG8uPrKA1V3QS9yU1sXYinMCJ2fFP9iCXknM/jp3RI/Nm9Pq7COjCVTUs7G13
         GxluA8BH/k0ram9NFGgGjnZnCtAs/z8mPPQ+k3QmngZ4MTDqmBgVjhATS+Fv5DVywJYf
         TOceMZ6UIejFGVAuqjFCvcFnbKVLs18HJe1Klfx/Xxg8ffbLjnpzcLBko9FrH2yd151m
         kK8Q==
X-Forwarded-Encrypted: i=1; AHgh+RoSeaBSbXCQFZSiZmtw9ARqliO2hYgRzBcDB/6z2s5Y0sUAKsDVQ1eOX40GGTVBCuSJUmUJVBI6LxOS@lists.linux.dev
X-Gm-Message-State: AOJu0YyahQQCaB2/1iceqmsTTpD7Q6ZWbyRd5oaF1hrKc3/o+qlhe+XX
	krlSOtbSFC4/t4tOpwPJmLSmcZa7QZsTzWziOmPAy6/NYu2jfXa7iqz7JFGfWJ2YWXUxJBTepcA
	lkpdiAYHqeCylHkLg3iZzof6gRTnvHWamYL/mxVHP5MckCBDe/ksdN9TL71ppdl+l
X-Gm-Gg: AR+sD12coAEu099QX5f0e0iK/b8lp33RAvno/4MOdfa7SvmZF5NnuJihABOZA/0w784
	DroHyuhHVrTW/D8Wmi4e/1t/3NBg980vQwch9uf325YLtzocGrolxmYf9j8a0To2p9VmB41r2yo
	UCe0u+R7uzqAAsnrJbrcrFFXDvBPf1Z5I04tZuyYTcKvs6sQapBx5a+rhW8z6EblENdpgGI467d
	6DXSkLv+PNlNxm5eAMqmLm7+f62rgjAwl69yzqtv+YA3nxVCfiHoi8k5NapRY6dApqwUMA+OZcJ
	nF0z0Eg4puwabADIXlJUjfBKOJ3frJeR4eyE0G9f9c0BX6x4qED3croviF3vwAIXUkviAYeSMld
	LOD1a85F3pSuxLcXyRdrXE16EAB2kT3JYFMDjrFL4rOlkyt/jO05IGqMvJA==
X-Received: by 2002:a05:620a:8006:b0:930:84d0:fd3b with SMTP id af79cd13be357-9371e1e239cmr1188127185a.7.1787236672905;
        Thu, 20 Aug 2026 07:37:52 -0700 (PDT)
X-Received: by 2002:a05:620a:8006:b0:930:84d0:fd3b with SMTP id af79cd13be357-9371e1e239cmr1188118885a.7.1787236672241;
        Thu, 20 Aug 2026 07:37:52 -0700 (PDT)
Received: from [10.110.112.10] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9372058298bsm374847085a.39.2026.08.20.07.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 07:37:51 -0700 (PDT)
Message-ID: <5d1a54d2-9e84-4a85-9124-ac9cbff75fdf@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 22:37:47 +0800
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] virtio-blk: Add inline encryption support
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>, virtio-dev@lists.linux.dev,
        neeraj.soni@oss.qualcomm.com
References: <20260814142306.3934029-1-linlin.zhang@oss.qualcomm.com>
 <20260819043321.GB9971@sol>
 <97c80fa6-2e04-490a-8b38-c951d7c80486@oss.qualcomm.com>
 <20260819193555.GA470114@fedora>
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <20260819193555.GA470114@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: qFZFySF3tJw15BnvJMxRcy1jYXtsT6_a
X-Authority-Analysis: v=2.4 cv=V8BNF+ni c=1 sm=1 tr=0 ts=6a871142 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=k9NA8kh2t99b52R1GTAA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEwOSBTYWx0ZWRfX/acyxwDNvJjG
 wdNojiCIMyBVTls7QRCqzDf6sS1UEIPAAohb654Y8reYITn9bEo+dpeGUTGn47OHZi47c0DjW+0
 qE9boeLaWfmZCq/I+SX8rrigCf6WMB21bNNGYgHt48SzNHtL2LrEI1hEhGV9f1uNcLV7Ybub5TT
 u8roz97J41lMOvaW9CqcS7kJmz8Pz9dthlp6lM339q6j430Rbl3lYwD7/gCyObmaZgEdQTsOhv8
 X5OHz1iU7pWifveqrNoOFg5uu73dlh2d+Z9c+uvUIh1mG0K5B5+R4Mm8r/vdxnsdvsWBlIQVPTc
 ANStKBmJHF/vOH6yMSRjch+ue+GHAhoLZr13m/ysfOwJRLukPB5F7XT3+37fGMV1GBK3Xba1u2L
 nA3EY7s1xXrLL5SMLrsN5L6izBqg0C97Rhcs6Xr/ZXl3XhX20gO0FSNtAe8eO3gR0JzKrUU1M43
 O9UeoK4CVF2pcxdDoXg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEwOSBTYWx0ZWRfX0Mq4oDScJwkM
 NC1+zYW8lwKdelkOB3gqRuQKzJ9FRgWotAzzshCcfhZtINHfYZIz63Q1uoWFPKCINxW56aQfxg8
 2z3fZd3nOB4KqT7UOeCyF32cL6SO9b8=
X-Proofpoint-GUID: qFZFySF3tJw15BnvJMxRcy1jYXtsT6_a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200109



On 8/20/2026 3:35 AM, Stefan Hajnoczi wrote:
> On Wed, Aug 19, 2026 at 07:30:15PM +0800, Linlin Zhang wrote:
>>
>>
>> On 8/19/2026 12:33 PM, Eric Biggers wrote:
>>> On Fri, Aug 14, 2026 at 07:23:01AM -0700, Linlin Zhang wrote:
>>>> When the feature is negotiated, the device reports inline encryption
>>>> characteristics through virtio_blk_enc_characteristics. Add
>>>> VIRTIO_BLK_T_GET_CRYPTO_MODES, VIRTIO_BLK_T_CRYPTO_IN, and
>>>> VIRTIO_BLK_T_CRYPTO_OUT so that the driver can discover supported
>>>> crypto modes and submit inline-encrypted I/O requests.
>>>
>>> How is the driver expected to program and evict keyslots?
>>
>> There are 2 new added drivers, one is virtio blk extension driver which is
>> generic, and the other is crypto virtualization driver which is vendor
>> specific.
>>
>> The virtio blk extension driver manages the initialization of blk-crypto-profile,
>> and implements the interfaces of blk_crypto_ll_ops.
>>
>> The crypto virtualization driver performs similar operation like the key handling
>> part in ufs-qcom and ice drivers. It forwards the key program/eviction request to
>> Trust Zone via SMC call.
>>
>> For QCOM, the whole flow of key program/eviction is like
>>   - block layer passes the request to virtio_blk extension driver via blk_crypto_ll_ops
>>   - virtio_blk extension -> crypto virtualization -> qcom_scm -> SCM -> HYP ->TZ
> 
> Can you annotate this with "guest" and "host"? Here is my guess:
> - virtio_blk + extension driver: guest
> - crypto virtualization + qcom_scm + SCM: guest
> - HYP: host
> - TZ: host
> 
> If this is correct, then it's unclear to me why a vendor-specific guest
> component is involved?

Thanks for your comments!

That 's correct basically.

- Guest VM
- virtio-blk + virtio-blk crypto extension
- crypto virtualization driver + qcom_scm
- SCM interface

- Secure World/Platform
- Hypervisor
- Trust Zone

The primary purpose of introducing a vendor-specific guest component is to
enable the guest VM to handle key programming and eviction directly through
TrustZone, avoiding any dependency on the primary VM for these operations.

Because SCM firmware interfaces can differ across vendors, the design
introduces an intermediate crypto virtualization layer. This layer provides
a common abstraction for key management operations, while allowing each
vendor to implement the backend interfaces according to its specific SCM
firmware and security architecture.

> 
> What is the advantage of shipping qcom_scm inside the guest versus
> defining a standard virtio-blk interface for blk_crypto_ll_ops that the
> hypervisor's virtio-blk device implements via TZ on the host?

Keeping SCM in the guest preserves key isolation, minimizes virtio-blk
payloads, and avoids additional inter-VM communication.

Key programming occurs after a request has entered the block request
queue. Performing it through a standard virtio-blk request would require
issuing key request in the same request before handling I/O path,
introducing dead lock concerns.

In my opinion, passing the encryption key in each virtio-blk request is
also undesirable, as it exposes key material outside the guest, increases
request size, and adds VM transition overhead.

> 
> (We talked about this in the past, but I am still not familiar enough
> with the Qualcomm hypervisor architecture to understand.)
> 
> Thanks,
> Stefan
