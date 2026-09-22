Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F3C3ED5AC
	for <virtio-dev@lists.linux.dev>; Tue, 22 Sep 2026 04:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790051385; cv=none; b=SPUbm8TXtShXnsffcWX35NZexZtsBKPHhl3W8AJNhDepxtbawKBFUhNXHJLf4Gl4J9Y7CC2NdHfk4BSv7iiWq2lcOvt6G0sb21g2wR4IYShb1wJqtpdUGJhRqK3P507UwlCRnL7fOOc4TccvQHV1bXZmUodR7Ert5hXXWsmqbHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790051385; c=relaxed/simple;
	bh=xg8y8j53kUgMr/k11pniWdrfbMQ0QARqjiWtWIs3CKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ToFFyEqBhZJa5KY9ByPgBZJZPPlYL4EU+oUk2yB+eHUMOM+NCk1jvM+OtHkRLAcfErk3P9WhvXsE4ciF/Ph8DDbWjjfMf0WI25f0QepaZGOWGvnucNjjUN/cUg47ZqSAMi2REeAiz1wx8E8SWQGA0skCMOi9UFYuMYyg0IJG0F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XqoYbG9C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fvmKfhfj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XqoYbG9C";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fvmKfhfj"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M00K9b2165613
	for <virtio-dev@lists.linux.dev>; Tue, 22 Sep 2026 04:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fDJKw62ThqeU8k9ly3iVssvcE1pGJqhMKlNJ5iNLjNU=; b=XqoYbG9CUG7GK7Ng
	7Z08sd+aGawVBtob3nJVFD4wSkTRavkqAOQplXMCWJCEaLtd9FE8OoLOVQKDyFkF
	hBJnz54cmLknVhBLgkDSnIRHKzND8X2KI+WeIoM/Kom24VKVLXlkKklKXW7wxI9b
	O1vbfiYMc3KAluN2QFPujjdWfofRGs0bpZdmkGAHKgWIH1aA100KYkIfJ5KAMp/c
	fPDqtFI4DO3qL/sLpMsam3AVJFi36/L7KYeMOvYe5qcGhu1YDpzIUswh5qlIIeud
	qDSUmif2C+EA1/jyEPUmEg9kqWOPUnXHpjnrhjz7zPdnFqCvJ24U4mdi+LnmG9Gp
	cQikLg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu8xet4u0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Tue, 22 Sep 2026 04:29:43 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc1b8088202so3340127a12.3
        for <virtio-dev@lists.linux.dev>; Mon, 21 Sep 2026 21:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790051382; x=1790656182; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fDJKw62ThqeU8k9ly3iVssvcE1pGJqhMKlNJ5iNLjNU=;
        b=fvmKfhfj1xDKqAXOcWshUFvwEoPQY5pL3EGz+BFM6jcHT5adlHof3AWIv4bcr71pHR
         3gbpcKk9qKYnf361a408Fk0Phgw1hyaeSGnn8CPRDMcSUqGlOUUEv7avR7NRxO/pVtAb
         U53foqdHZs1X0dBjjvl3Fjfi7M/1eTuZDCMGWXrE/7SGLkVTglDIFtEMx/GRWXS4NPni
         X4KXkZ1nrofV1L/e1waoVZd85Y0qLzXn9sTv3Vi6IxjgDKiMp8GH6UQUUpTxsdpvEgOd
         P8+fpwuundhU0e9r+H4Sm7F0hrcVkmDCVq292SiYt7vqVitDQYgCKHv0ab8GsjQTK74N
         Euvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790051382; x=1790656182;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fDJKw62ThqeU8k9ly3iVssvcE1pGJqhMKlNJ5iNLjNU=;
        b=Rw89rAqlBqWPM9b4WfsRVxJTrHTTmEkO/0A6c5+zBVCNR2QcBd+kZdUWAg7YfKwok9
         x9sW4LYmch2p+iM+cc+W/G2tHxwEIGPSoxbEBXT8p3wqwcS51Qhf4mtPaQJZGhQCme84
         fQIS8AMZTjA1K30/9KJri5N1rqng6dL5tuToHueslWdYMfttYbNlv0ozGNA9ktZvBkcq
         N+HB4+HoCmIuGzBSkHgn/u0RNTPzU6pTAOwLIOES8hkPfngDUxWMXc4YLi3NpY4EldoN
         xZf6oBn4IT0LrbKTzCNqcQdzyogpmaKFqh7IJSSLVL/bpx+y9WsHaR7QxPsl5ZKmUJpW
         TZOA==
X-Gm-Message-State: AFuF++kc5jkFF2e9itPeYJY9cfdERf1CH1cVeRIUVej9NJBNqowzxUqf
	GE3x6f2GI2RbT7pcMIPucWZ6B9FyMu0oIdKl3ElV+1Td6SEwvz/1UahRbCigffL2pEdXH7z4Y0C
	ay1V2LQBssseqiTuvOXnrQdbBYHO12TIWa/5UjREFQ3mam6ESV1EBsunPJw1ExahW
X-Gm-Gg: AYBFou2Ryq1gGUSRdC6j5Mty3hQ8xGoDcJwvdNQABgEmPXuW0cV50h8ixt1mHTU6rN5
	0JxuhdfZ/09P9lh7vM3X4yPHJ2Nujh6vYMajQAo86UstobPtzfdp3CAba0tSwZdsvFdFWoQ0yVr
	02oZ7ZU4fug18ha3zbahDENfKKsSX/YMyd9F3W88QaHmydMdvZZRsXwUz9s++YGtAE3/BpPHefD
	eFSGIr6oXjT0+a5DfXb0drhkMEL8AWIwOhrwHWOKwjPCWm8r8z0oPzB0ZJg/RbXhlxY2sJTnSUN
	jMqTa8RrDVW5KW3row/53UUhXv2XiRXmgIWUvjB/ISEs7NwUkdopTwbpwLD3CBVpowzplKOnn1r
	Lp6+qeNva72QMbdLAjbkH0GgyQcioDBz5s8vv0GyJuT4sXMDJ4ulVo/z8
X-Received: by 2002:a17:902:f214:b0:2dd:c053:82f6 with SMTP id d9443c01a7336-2ddc0538455mr91533665ad.45.1790051382333;
        Mon, 21 Sep 2026 21:29:42 -0700 (PDT)
X-Received: by 2002:a17:902:f214:b0:2dd:c053:82f6 with SMTP id d9443c01a7336-2ddc0538455mr91533485ad.45.1790051381777;
        Mon, 21 Sep 2026 21:29:41 -0700 (PDT)
Received: from [10.110.14.151] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e612d0c6bsm1966347eec.20.2026.09.21.21.29.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 21:29:41 -0700 (PDT)
Message-ID: <2f9affb3-0d1b-4469-9a66-ba052d2d1b6a@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 12:29:37 +0800
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] virtio-blk: Add inline encryption support
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.linux.dev, ebiggers@kernel.org,
        neeraj.soni@oss.qualcomm.com
References: <20260913161628.368484-1-linlin.zhang@oss.qualcomm.com>
 <20260917210841.GD331587@fedora>
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <20260917210841.GD331587@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: dNQ-m5dfyHn7p36RCJgJKJuBvaRA402R
X-Authority-Analysis: v=2.4 cv=PZhqFShd c=1 sm=1 tr=0 ts=6ab20437 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=F3iCgqpGwKfFVuqGHcQA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: dNQ-m5dfyHn7p36RCJgJKJuBvaRA402R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDA2MiBTYWx0ZWRfX1crfb79OiTQ8
 JjPdHP2poaVaX80KIFFVH5U0jRPN59YQr8TzgihNtH3HKT8tYLcKsbwAuxI59hQ1zH8HC7n3y0k
 WH/ohYQNJRdjBHJMxDKn65ADjd4yW/dqB6MUT5oiheVQ1ps5JjHKRm3uktjVAVN9YFuhDXxOnit
 o64DVTyt2VE6GY3PbqxKMn2tG51ZaPZbF0/23QtbEUw3jzGcmzfgYvyUO60l7C5RlMlwLLompPM
 eM49bhG6g57dnU2BJTbtGF+31i0i1lefKvDf6FiNNgVhSyXHP3IQGH4mWKMIG2cHNVF3gm77Gne
 4QOTYjiIKz0+Tt+oD1BpKI2kpUQMngbgnA+wWnFdSwwOClg0PEbF/CJfW4V8Y/rR4SKYRcyZSHr
 4ml8mSrvAreW0yecl+PQjVgVmUVqGrPERNPzcRW6k0X1uiOXmtSBbmqW0WcbVhpp96B1X0CA8/T
 v/SZGuiwLttn3TvGxhg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDA2MiBTYWx0ZWRfXxkmt3qjIH1cg
 QEAH440O7/immlvwKdEtOso4l5xbIG0ATQwWM+yCjVq0hl00qIm448rA25lbS6DllpLtwgFqWwK
 P2MPHGyS3FdiA+TRCIh9lsptyx2Ijxc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220062



On 9/18/2026 5:08 AM, Stefan Hajnoczi wrote:
> On Sun, Sep 13, 2026 at 09:16:13AM -0700, Linlin Zhang wrote:
>> From: linlzhan <linlin.zhang@oss.qualcomm.com>
>>
>> This series adds virtio-blk inline encryption support for devices backed
>> by storage hardware with an inline crypto engine.
>>
>> The protocol exposes device capabilities such as keyslot count, maximum
>> DUN size, and supported key types. Encrypted requests identify a
>> provisioned keyslot and carry a 256-bit DUN. Key management and crypto
>> capability discovery use the block device control virtqueue.
>>
>> The control virtqueue is defined as a generic framework so that its
>> buffer layout and queue placement are independent of any particular
>> control command. Inline encryption then builds on this framework with
>> explicit crypto command formats, capability validation, and keyslot
>> state semantics.
>>
>> All key related operatios are handled in the control virtqueue, and
>> the crypto I/O request is handled in the request queue.
>>
>> For background on inline encryption in UFS and eMMC storage, see:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/block/inline-encryption.rst
>>
>> changes in v3:
>>  - Add a control virtqueue
>>  - Move key program/evict/derive_sw_secret/generate/prepare/import to
>>    the control virtqueue
> 
> Thank you. This was a big change, especially if you already have an
> implementation. I appreciate it!
> 
> My main feedback is that the new control virtqueue commands are not yet
> documented in enough detail so that implementors could implement them.
> Once you've decided on the precise semantics, error codes, etc and added
> them to the spec, then this will round off the inline encryption
> feature. I look forward to reviewing that in the future.
> 
Thanks a lot for your comment!

Would you please help clarify what the precise semantics are about? detail
introduction of the filed in the inline encryption control command struct?
like struct virtio_blk_crypto_key_desc?

> Stefan

