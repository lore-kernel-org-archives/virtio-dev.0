Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BB93D4125
	for <virtio-dev@lists.linux.dev>; Thu, 24 Sep 2026 09:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790242562; cv=none; b=mymdXd3DudQ8DgxxchwtW1LN7dQaHbYYdB52SvAL+Cj11FsEvtRcjmoDZSQ4kFXIgwDVte7bwh6i0h5LMS5D6r7gyiJ6H/hb3dLvPietzmgxaIXXRgmNpzAHX2A+FmI4xetZunw2lwfbeIfTbZsdUT4MFCloXiwKdg70NRtldAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790242562; c=relaxed/simple;
	bh=H9SuZLeTFcJHTyIOS6weZ/LCqutgoOBj/5QVMqLHHiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iSuPJlBWkgw/4mqZDxuMs2STy9mjPptXUWqn1pvB9TeYeprOVeK0I5ylwdElYdVADIjBxdIdDI0WGbc4P8BVvq9eu91sP+tKa3ZvBnH7vnWW/CIVSFB8X4+KaCrjerI3ph1JxKSZXpsG9VcwWN1YreNXrk2NGsV9dl2mHSomrhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hlEXU18p; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N0G0BT0l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hlEXU18p";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N0G0BT0l"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O9PEUN2025655
	for <virtio-dev@lists.linux.dev>; Thu, 24 Sep 2026 09:35:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FSjhvpbtEPrbjCuOwaDhpqSU7tuuk37QleC0M+7xPxs=; b=hlEXU18pBR6MAlD8
	1DLu0oudc5yHODrbVhKxkXwnp9yaiuidc49y37zX/tr0ON57QdWvR+nXY+u0Zoea
	WWzb5XWe5IhJjMrDRd5xGqoqAYuawUMaUOoGuUHbQR/yWi0kTnS0sqeltY/ImjYp
	8j/nfynL03dhF3xn8u33XDG9dNG0ZV6gRn0YsD7LvKG/U+qENHZTo+KiFFNXuNtF
	6SzY+/19M0AnomuH24Muc+yBJzUimJbCDiMun+5YUCCSYcjM71aqa9g4xW+vhlJA
	AR3WVJiAmIsQB6D2gM6RONbCXC7thtc3au86ldyRE61cJAJqFJ+9/v6hF4Uj+nPX
	RkjSJA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvsfgsrcn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Thu, 24 Sep 2026 09:35:55 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3284bbaa89dso1822575eec.0
        for <virtio-dev@lists.linux.dev>; Thu, 24 Sep 2026 02:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790242554; x=1790847354; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FSjhvpbtEPrbjCuOwaDhpqSU7tuuk37QleC0M+7xPxs=;
        b=N0G0BT0lySH/r1QZwj0fHKN9e4GExQapOlt0Ok1dWkF7SIRVc0MT0s4LXSeLbAgu1+
         ODfdya0ry+qmBbvhimb24koWEdBpGANWnVx+5qAFF8jl584M/LeyJ+kLQiiZfQyV8+vd
         ObBD5hR6OQ6mfOO2pDV4Fu4ABu4cPrxyA03WRkY2wW6XadKbpjXbbE4+nLm8Ke/8pZy2
         2TMc0ZmBes5ATBd8yTe2dQV2vV0T1bbPBwN8eiUnM1zpCNJZzfLScuf3clQTefYN9iWz
         gs8xAe7jNoLRd98j6YBtBGpcy8Mm5aAHhxeHzaw+vthFKevc/b4BYMD2ToS5f8jfzG07
         YTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790242554; x=1790847354;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FSjhvpbtEPrbjCuOwaDhpqSU7tuuk37QleC0M+7xPxs=;
        b=F6/rT4P56qQUHdVxCESqrswsi4rypd/Lb6ySohkk+Ls7kJgd8hm2IA1CJoBmbiDYJl
         ibA5C72QR6mTRLCq8B24m9ALbSmUJZVVu+JSb5AQu4t9eBvmsR0bMBoSN+lD0V+G7O+6
         LFQkgITg+xbQLeeRVQs7KzbpYX3iHt6G/fI/82JYwWI8NDdvCQ/yEzEXRzpR0/oLIzuF
         EmO9fnOQJoOMBGMoUOq+LDSAeciiQhflddQcJc1MEcGN7d45xf/szYybJedVpE4Yu6yh
         uOQwTRae7UgaklsPdJ9tFJyuUoVmBl9WKVwDRcCVwJMa1RTV6zYzVP1El4L9g/YnzSKx
         7EJw==
X-Gm-Message-State: AFuF++lz2aoZuU8/8cxqNilUw+XPi6TKAj2ihyKIO317emswagv/JiFR
	/o3q7wYHf4XI2obChfagC13v+zIttFXQuqRw83pYFjOM/dk1L6/akPSDZq+N4NJvV/gr30ontUE
	iqqzd9WbDvvQ+T5jQ87a+pfPTCZcvAFqcJuCIJB3v9r1RO2/lmO/ltWi5kJyeHmNINCn8MTG5i5
	s=
X-Gm-Gg: AYBFou2g9Dfjs1aExwlCqlomFMbV3zfj5+RkcCQNat8Kb+/Z1Fizegh1UOWGvjOqjZc
	gw4fX3nZsf/OblTYr6VdyQlMxeV9+jzUdex/nPQf9xHQtzKLxu+7RlNC8ilKKFvBFJ7u6R/ayBH
	DscqIiLuSI+ATjhE5Ala68d2NWQ8aj5XuDxPipVNdQvXO3/9dTQ60aYHbWcW45s8J0s/8ylFF0B
	cA2B5cxpP6ZC04kDgfN1iW3esHda01yZEiO7mlIP6eOz4aVZE480g2IIEry4ulHQT72wbp6DeoH
	B/gCtbfKJ+3nSby6+UdC0qAwjoj6AdM2JmY2iCQRgVzGP6AJAUe9q0wiq3B0WR/Q5nDiPJZDCg2
	GPs9+pixVFj6UfIoIwE/4HxRHsvVCQbQLHQk0T1URcGf+RWBwgpnGPQ==
X-Received: by 2002:a05:7301:4909:b0:33b:dfe3:250d with SMTP id 5a478bee46e88-340034bb387mr1497350eec.23.1790242554017;
        Thu, 24 Sep 2026 02:35:54 -0700 (PDT)
X-Received: by 2002:a05:7301:4909:b0:33b:dfe3:250d with SMTP id 5a478bee46e88-340034bb387mr1497319eec.23.1790242553403;
        Thu, 24 Sep 2026 02:35:53 -0700 (PDT)
Received: from [10.110.80.1] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e96848e18sm11881298eec.17.2026.09.24.02.35.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 02:35:53 -0700 (PDT)
Message-ID: <3a933df3-dff7-4ef3-a120-4c6e22c1fcc1@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 17:35:49 +0800
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
 <2f9affb3-0d1b-4469-9a66-ba052d2d1b6a@oss.qualcomm.com>
 <20260922131442.GB18339@fedora>
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <20260922131442.GB18339@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YfoodARf c=1 sm=1 tr=0 ts=6ab4eefb cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5bPzpBSs5rTE8CNmsBAA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: MAQ218RW18LfmuRJ7IKQaC6RSx9ehSCL
X-Proofpoint-GUID: MAQ218RW18LfmuRJ7IKQaC6RSx9ehSCL
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA0MCBTYWx0ZWRfXxZZH1nuvMSdS
 n82Gf/O2I5umlj1DqPsqmPuqOkglmlG73/SgbP0iNYqKj/YNXQIbutU6vB+XGLj0Hi7RcfgeNiv
 GCY3bJxFScUEu5w4UE2rqcLSSZJ3eBM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA0MCBTYWx0ZWRfX3+aHefrCWK38
 0vkWk/9DIQm5lByz3q3c3eFIC5QweEiwNQNfQrE54CRExlFyyN61BsEfC3Fxp1vv0QLzTpv7HZu
 gXCVHP4RB/EnWgVUSMvRPy+lOelxrO+bfC9xlmO2/HNK57AaZhdu0m2GdJQOKMk1fQbexh9cFxL
 jNHgOeso1N9CjCo9zV5HsLdE9KQwdmcngdxzNouauT4YkFnFLPUbJwyQU48qjSpASVkbX2QoLTo
 OZIS+kwOJCYSYHK7jLTt/SMi4maUPDtTOVKI+GbBIRQnZsSGJG0leDXKZpnb1Ns5nsz58pX1+n6
 XHHFQWxdH4Z+tiGbXJh8xY6ddZ5IX1Jhd8GXAq6pJJNpmklAySvJt6v5YKGQTsUPL+vLDmxvkJl
 XK+ndlogBmptS2N4i/yo2QSk4P4ESswDWa8ANRV4UOlqW7IttqOjbfusmXaIUHV+Ep7qBZsraGx
 PccWuErT4q41AyfjyuQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240040



On 9/22/2026 9:14 PM, Stefan Hajnoczi wrote:
> On Tue, Sep 22, 2026 at 12:29:37PM +0800, Linlin Zhang wrote:
>>
>>
>> On 9/18/2026 5:08 AM, Stefan Hajnoczi wrote:
>>> On Sun, Sep 13, 2026 at 09:16:13AM -0700, Linlin Zhang wrote:
>>>> From: linlzhan <linlin.zhang@oss.qualcomm.com>
>>>>
>>>> This series adds virtio-blk inline encryption support for devices backed
>>>> by storage hardware with an inline crypto engine.
>>>>
>>>> The protocol exposes device capabilities such as keyslot count, maximum
>>>> DUN size, and supported key types. Encrypted requests identify a
>>>> provisioned keyslot and carry a 256-bit DUN. Key management and crypto
>>>> capability discovery use the block device control virtqueue.
>>>>
>>>> The control virtqueue is defined as a generic framework so that its
>>>> buffer layout and queue placement are independent of any particular
>>>> control command. Inline encryption then builds on this framework with
>>>> explicit crypto command formats, capability validation, and keyslot
>>>> state semantics.
>>>>
>>>> All key related operatios are handled in the control virtqueue, and
>>>> the crypto I/O request is handled in the request queue.
>>>>
>>>> For background on inline encryption in UFS and eMMC storage, see:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/block/inline-encryption.rst
>>>>
>>>> changes in v3:
>>>>  - Add a control virtqueue
>>>>  - Move key program/evict/derive_sw_secret/generate/prepare/import to
>>>>    the control virtqueue
>>>
>>> Thank you. This was a big change, especially if you already have an
>>> implementation. I appreciate it!
>>>
>>> My main feedback is that the new control virtqueue commands are not yet
>>> documented in enough detail so that implementors could implement them.
>>> Once you've decided on the precise semantics, error codes, etc and added
>>> them to the spec, then this will round off the inline encryption
>>> feature. I look forward to reviewing that in the future.
>>>
>> Thanks a lot for your comment!
>>
>> Would you please help clarify what the precise semantics are about? detail
>> introduction of the filed in the inline encryption control command struct?
>> like struct virtio_blk_crypto_key_desc?
> 
> By precise semantics, I mean specifying not just the constants and
> structs, but documenting what each command does and how it can fail.
> Each of the key slot programming commands needs this. There should be at
> least one paragraph for each of VIRTIO_BLK_T_CRYPTO_KEYSLOT_PROGRAM,
> VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT, VIRTIO_BLK_T_CRYPTO_DERIVE_SW_SECRET,
> VIRTIO_BLK_T_CRYPTO_GENERATE_KEY, VIRTIO_BLK_T_CRYPTO_IMPORT_KEY, or
> VIRTIO_BLK_T_CRYPTO_PREPARE_KEY.
> 
> For example:
> 
> The VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT command empties a key slot so that
> key information is removed and the key slot cannot be used until it is
> programmed again. The key slot index is specified by struct
> virtio_blk_crypto_key_desc \field{slot} and all other fields in the
> struct are ignored. The command succeeds with VIRTIO_BLK_S_OK if the key
> slot index is valid, including if the slot is already empty. If the key
> slot index is invalid, the command fails with VIRTIO_BLK_S_IOERR.
> 
> Stefan

Thanks for the clear example.

I'll follow the same approach and add explicit normative semantics for
all inline encryption control requests.

