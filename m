Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213F5374A08
	for <virtio-dev@lists.linux.dev>; Fri, 28 Aug 2026 15:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787932035; cv=none; b=gx5HBY49nkRbOt8WV9rDMgvx2gIy1W5mfALLzpBl+xiKuyznC0YecmLHhYRSC7ASg3QHNKWcB3/CNBQurxg6A8Kke+41Z6zwvM5P9S/gfktsyNtJPAs17fdydHhf7ZrxFxNmILsUJQjFs6XcfkWojzbeLTQgO2Mn2q5LI1o/vgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787932035; c=relaxed/simple;
	bh=YthO7+pVUqDuN249FoXnsjIRX+sda1Ai3EkDpNAXy68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g2xdnUs+Oq6GaRecwk7pwT9b1Ovgx5QxrZL6jPWrFd4FnImhYJW3shZW16kwDnr7fpJ4Q5Lr3IY2P57AK1G+yS4b/3ZrjJUYbsk/m0Hcd5VHldMmPLn6AWzQ2rOfMDxF4sbaX+L2xbtbJr1tMIjXMBhn80JFYtcY3GYo3gBl4Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LNtWPXWS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=emyQn/TG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LNtWPXWS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="emyQn/TG"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SDlS4f3546413
	for <virtio-dev@lists.linux.dev>; Fri, 28 Aug 2026 15:47:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yzw1PXqFGL1Xkx/jPeN3hYWLyW5oOLQsFTMOnbkgJpQ=; b=LNtWPXWS5ahypMid
	eLb1qiPeu4WjgcSoaZrPjZy1sBcIrhkxf6m38TCkUTu/rEw1RvLOWdkf81FbH6Up
	cj50TjY9JYTf0RcL96FyPFRiCfgEpcTpjSNwdctlLz14LqwthkIyaaGu1pqFzCLc
	j4WaSFCsf9CtyjRLTDKsc9x0IcTsJy01UAveQUGqSl/Kc7ICLIYqzEvDI9czS8YL
	M/k7rDAuO9HQZGsLJdUu7LbKm1jykWP+0c9l61jolqVasH9zFClitYZmNuuozLS1
	3PUC0P7BAmyqIhZ6c9NdM8JiEU81cL2+F+A8hv7CzwvjtL3tMub+ANzSuASAdqSv
	3uMqoQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb47n2dbc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Fri, 28 Aug 2026 15:47:06 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-388cfc4848dso1469181a91.3
        for <virtio-dev@lists.linux.dev>; Fri, 28 Aug 2026 08:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787932026; x=1788536826; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yzw1PXqFGL1Xkx/jPeN3hYWLyW5oOLQsFTMOnbkgJpQ=;
        b=emyQn/TG9vSOx7JBpIlF46mC/+4Hv2H4+es8LENtx84zlV8W7iVdghmChm8WHsZ8jh
         iYO0z6ECiqdXlnietf3Yge7+T8BgXUitqNnhuaPe80/OmqL2z+lE7VzwAKYaq2NgW2wj
         k9T/QKlghUhcRi30oEOQ3xK/VzLDt2dtGjjzIp/09JkTO+6/EyJrR+3E4ATNj/nta8gF
         Mp0OjFBy5YVQxxL46jd/jw4iFCv1pgrSg8+BM/MtUKUC7oEDEx8jX7/47n3eDHMhSzJt
         HS5+Ua8FehQpwHUp/OLihBPbNxj7XJFAIjhJ/JFFqMbxSBv51UXUZSHXPf6d0iktYRDn
         sFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787932026; x=1788536826;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yzw1PXqFGL1Xkx/jPeN3hYWLyW5oOLQsFTMOnbkgJpQ=;
        b=s9few8XTOL5Vu58nP1mhSVPaaUQs0EA+5r+3bHbdG+je3KLuu7sdZFQ/WbRCCyKcmi
         /Ddpk4ezsfXQGP6vXUJuPkdxGXsMEj6cBOGNngXtASleU2CTXETttbNFbIhXjDG8i7zU
         cIGQj+8N4yxydGDs2EeAe7TtwqolwTbCV9rTSUnRPhgRY2dxhx8RlA5vf+KHSlpLOoWD
         gOgeRHDfhrLIo6CimkN1WaKVXYTQw5RPzO54BvNVZqpGruWAFJVKDDATHr25wA8jbXwM
         88tQC32wDxW9aioWU5BRHrJzD5X2m5/EJEImngrO01kWsQzPwu/cJy2XTLL6Kl+uRe15
         ZMGA==
X-Gm-Message-State: AFuF++l7gPwQDjG6EgdLLKQz+NR8W1nyjy8sRKyDeONPuEY10KTBXNhB
	7FMhKAP6nPFUZCYaRXV9wDtvGSW9hO2p7T74jQNLmESGwlwwyxWguowmSPc2QH6Fta2TPi4k2h0
	MukyEoGLNCvG+HK/JlELKrIeBR4kKDl3i9L1FCCdg76FxLzUYM083frwO4PHiooFB
X-Gm-Gg: AR+sD13/dwT04ZJqByH3lo2xN7jkLXJGq6ctniJ50gik6BQjtp1NBV93TOujCYHwfgl
	Bfy8PX/Th71eLO1f2XR/IqFhFBEpbmNmr7G/2FgfuzOZplDtbNd4wby6gdTiD/4pc+nMVt+k3ZT
	xzjCMEDG6Jhig6SHhQfg5lNVJdM2iPcAQmXJCRulDgW3eBP40xaJrVktA3/timxI21lut4Yq+PC
	tASFdIBdXbq4ZeoBBIKMIG+0yTkunv6T2CbPbHS2X6pW389qOY4Uc2FlbopFkL7RHgAqtH4BB6G
	6+qicv4Y0p4lpGStg1kL08sT4MvXPudUHwZDfKpPQGfr5Cp3b4u5blFTPRvCBnWrWgEeaX/gbif
	FaCJH6bfTfCPys911fneDue2Eq3NHoZukzniT3QJOVNAOrE/rc2ymj2slGic=
X-Received: by 2002:a17:90a:d2c6:b0:392:c80b:8eff with SMTP id 98e67ed59e1d1-396d0f6cb36mr15799522a91.11.1787932026064;
        Fri, 28 Aug 2026 08:47:06 -0700 (PDT)
X-Received: by 2002:a17:90a:d2c6:b0:392:c80b:8eff with SMTP id 98e67ed59e1d1-396d0f6cb36mr15799424a91.11.1787932025580;
        Fri, 28 Aug 2026 08:47:05 -0700 (PDT)
Received: from [10.110.102.109] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0de4de3sm10203966c88.12.2026.08.28.08.47.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2026 08:47:05 -0700 (PDT)
Message-ID: <4f5ad0ca-de69-4bdf-8d4f-33b94e258205@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 23:47:02 +0800
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] virtio-blk: Add inline encryption support
To: Eric Biggers <ebiggers@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.linux.dev, neeraj.soni@oss.qualcomm.com
References: <20260814142306.3934029-1-linlin.zhang@oss.qualcomm.com>
 <20260819043321.GB9971@sol>
 <97c80fa6-2e04-490a-8b38-c951d7c80486@oss.qualcomm.com>
 <20260819193555.GA470114@fedora>
 <5d1a54d2-9e84-4a85-9124-ac9cbff75fdf@oss.qualcomm.com>
 <20260825233409.GA282683@fedora> <20260827184905.GC2137493@google.com>
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <20260827184905.GC2137493@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=a8YAM0SF c=1 sm=1 tr=0 ts=6a91ad7a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=7LYvqmufGY8V4kgeTd8A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: ic46IvqAAvfbuKbTOFgL0-Ng3Y4cBiNO
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEzNyBTYWx0ZWRfX2WHpVNN9agH0
 JopSskp2DZiBnZYJ/mjqKsI4QwWM8l4Y2sztMmKvJ0fA2pgxoMRZmgzO4p3acfzYnGQ/tGcOD1A
 nRmnBEQjBSJ1x4Efj98FVb05HI04f1I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEzNyBTYWx0ZWRfX/BtHGSa4Qg9j
 CJ2b7r312BGXoMcsjXgykh4c1lZG7PzMZwvuha5dOP5U7Bs6hNEzDCFjPuJb6h82csA/3AZJFYt
 iQa2EbWsmbab9edgEJT25urFwnYG9K3D3ADklDlcLzKF+wH6reufHARcAJYcEL+LCsb6XsdCluK
 CkTI55fHdN6o7oeTikMjz8XTuyW8w/kRpEraOUBhW8g8VnUiE+XPW7J1zhf6FTjVahsHdftUREl
 qh0js62uJpwkNrD9OoHwKDKMd2jX9ZIFq+acappp3Tkw1e18PJIqxQ2z+SFdZGo0RV+kcdwNfWt
 4OZAfAW50g5dsUCb3lm1oOMqeg9Scysd4v98xdW2uYsuI5ohoPrqCK5tSKvJKIhbHj18UDn4fGP
 EZ0tTMQOqhP/+UmNT1Wtz+Q2fcjbi32N44h9UJkC3NcPX2o3o8db5hNOeoyN2rsMdPlzl2QXQB3
 SfAWDeM3io5fmK/XIbg==
X-Proofpoint-GUID: ic46IvqAAvfbuKbTOFgL0-Ng3Y4cBiNO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280137



On 8/28/2026 2:49 AM, Eric Biggers wrote:
> On Tue, Aug 25, 2026 at 07:34:09PM -0400, Stefan Hajnoczi wrote:
>> My concern about the key programming interface being a vendor-specific
>> interface beyond the scope of the VIRTIO spec is that I'm not sure if
>> there will ever be any other users. In other words, should ICE actually
>> go into the VIRTIO spec or is it a vendor-specific functionality?
>>
>> The approach with a separate key programming interface seems very
>> specific to UFS and Qualcomm's SCM. For example, is it possible to have
>> multiple virtio-blk devices with their own ICEs (key spaces) or does
>> this design assume there is only one virtio-blk device with ICE per
>> guest because existing SoCs only support that?
>>
>> It would be cleaner and more obvious from a spec perspective if the key
>> programming interface was part of the VIRTIO spec. Then the spec would
>> be self-contained and the vendor-specific part would only be in the
>> device's implementation on the host without also requiring
>> vendor-specific drivers inside the guest.
>>
>> I took a look at the few blk_ll_crypto_ops drivers in the Linux kernel
>> and they are more or less copy-pasted code that only exists because
>> there is no standardized hardware interface. I think we should avoid
>> propagating that into VIRTIO and instead just define a key programming
>> virtqueue for the virtio-blk device once and for all.
>>
>> Having said that, there is much I don't know about ICE, ARM
>> virtualization, etc and I would like to hear your thoughts if you think
>> I'm wrong.
> 
> Looking at the actual Linux kernel patchset that got sent out today
> (https://lore.kernel.org/linux-block/20260827160806.1295313-1-linlin.zhang@oss.qualcomm.com/T/#u),
> I agree with Stefan.  It would be much simpler (and also much more open
> to other implementations) if the key operations were part of the
> virtio-blk protocol, rather than some unspecified out-of-band thing.

Thanks for your comment!

I replied in detail in the Linux kernel patchset thread.

> 
> - Eric

