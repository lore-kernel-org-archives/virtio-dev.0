Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C5241DE15
	for <virtio-dev@lists.linux.dev>; Wed, 19 Aug 2026 11:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787139026; cv=none; b=sKrMx4ocLaDtrvJZWTyvrpDk3xiWDqMZ9DS+EW2z1yLD+Drx+63H8ttYf19m3et4bSz0YbyJNGQvhGYqv83o/FHqPJe+gM46csECZv3u4JJOvKq/ybbpDpmLGKlxXNpDLvkZXG1E9TF/rsJXK/DHinesyazncCmdt0a4JlCzVOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787139026; c=relaxed/simple;
	bh=+vzz//nMxESuBZkcL39YOvYHEuiN17xPZ1yJ0HeNEIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jlICkaXbZusk9ea56fB7zjXZopcXAtGdqURVNpTT9M5VR4EzKJMKv3ni4Vu2/ymv6G7/P6koOekUCmzeWbEhaOrtDwlVja1vJwQOIPzuav/lK0x0W9ycD90//8lCDGywEWGnMrpefQ+4vTOzBckYbA0gWmTRo+GfjTE3qSHkNjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nV+6ihua; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VbYMXWJE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nV+6ihua";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VbYMXWJE"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JA88kj307306
	for <virtio-dev@lists.linux.dev>; Wed, 19 Aug 2026 11:30:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tfzhFxx49Ng/Lw7aPVVzH8MTlHpI/xVyGba7siIcfUo=; b=nV+6ihuaZ72h6SLV
	MNPetRGj4+YNWs+AOsYDyFpPmC8gConlZsS8c28IgTQ8UngUhZL5g5/W+Fj29wMY
	tTXYDwlOHYruWJT8HlPjBmuMgQk08xV5/0IldqPWh7fIYzCYWoMIXwr4KkfGFAH2
	WsdJmqODOogQUkukZlg758zx1YeC4KK6yRwEyqXbImdpRjgSuB2R/22PjuJsmWEd
	xPO9Y6qyqjzmeVKOyob1n6l6fnpk1erz1E5JvmVQLBVtiQrC7IHa327u1aPr58Vj
	5+ozZXdwjUeaKq1ukwsVJBd3NMe9K+B1jE55aPaNC+A/afv20yoT2f49UWRAp4qp
	G7H5Nw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfmax6b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Wed, 19 Aug 2026 11:30:21 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc11b5dd54dso1786251a12.3
        for <virtio-dev@lists.linux.dev>; Wed, 19 Aug 2026 04:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787139020; x=1787743820; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tfzhFxx49Ng/Lw7aPVVzH8MTlHpI/xVyGba7siIcfUo=;
        b=VbYMXWJEjiFR+blV+7Or9NggKBF0Ahf+3JBd86w+0KkIcv10PQ+pLeq4eKxxVHeldi
         1zMCDpmyuEfGI+mX4oKy/YJKalOiR3VPeojSpRllxddHfrFjZgeY2SJxfIJUuSt86Y86
         t6E81eAdFgQlAJt6dMnQhKReIC0NMP29Km/jUf3Wn/lHUhd+tL9Ee8OYVF8B3dFV+LlL
         cYTyzUhCiilB02UVxHae/qzXXNyy1QgvabfgT1SAL8GJnyrY07pnRN9Cak/m8VaXXsJm
         9pPHFbOm//2QTLbaMbGWwvihZKixK6vhHVA9PYfeXC1l+LIlAtfqgbrdUJVFHK6RGYrm
         aBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787139020; x=1787743820;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tfzhFxx49Ng/Lw7aPVVzH8MTlHpI/xVyGba7siIcfUo=;
        b=b/vYkO9UK/H8PlhTI0LoC6lQTBQlZOrHw4j6e7H7dJpAKISVVubLddRFtbVRdnf8N0
         dsPGl/RrQUEWPolE1YgwkXLRzuhsd7prNAkZjI7USMRkNpX/y3J8YbI0jbAMHL09Qq6L
         UHtzLyZN2mMOT1KhBaqqytkTUZtBteaf43IlvWasyDdvMGbAmTUGUDGHPbwNgZxSwZOm
         plPEGumzBisNc/xiX7Kui/X2blwWAJY04deyKSJxMQcK2AwIM/RHbbj29PiDJw9B/o9k
         hYsMO+0MtuwyTnCU5GxgdEl3KGXfmTXyqInIeSXdJOJ43rqhG2zWwS9kazmL0nAfkWPv
         WjQw==
X-Gm-Message-State: AOJu0YzShRus2q3W2eRlxY9QSe5pVKvUdUdfq4PJdLXBKLY9WssevoTS
	54eXaN7+XzAvjUavtMcCaRj077k/r6+in7IGqopgBUp3OAsjZtkHKsyv4gemuKZ3f6ULCzXl+Zc
	+XEs3Z4t3wM4Gqv8nra0vmE+rRdCohkv7gTQHQyiBwuo1DHEgNqjqljQ7ZZth/4tT
X-Gm-Gg: AR+sD13K24QRJ5cmhym6QOtwRuWH2Pj8jFH/YTyIBTYXQAB55m8a7Z57BeZcVqRxIZr
	SngcjGs2eSmTAuUAMQpWxLUFuNFAqkK1Z/0GG5Vzcy9KlaDRxFkh7xdb8Nfz2tea3QemKnLzwDX
	qyxDbWdsWroG7gzV+Vvq1aMsGftuDUJ+AVf5dw8uC8ETmI7qebxPYrMfF2svmh0gj9lks32dSxB
	daUru5iNZHjOT47fIl2mpnyUSfAphKuQhvLZ59XSFqSK5Y/G3GFUX2wSb1VZcL4FkIDXQDAKqqG
	SNzUu9MM2RTYxOdydQBMQRMyd33ImHN1q4MRgFtGFXX9YC+02LWIZCJ5kyjRR2vIt1UhCWii0cJ
	9FAm8ZBsdpQ+iI/aXNxN1wgB4skLbhHfwkJd0GO5Z+dgdfFy6hwCqt2Oy+Q==
X-Received: by 2002:a05:6a20:3d19:b0:3bf:b1d3:393e with SMTP id adf61e73a8af0-3cd00dcb3dfmr8444311637.2.1787139020200;
        Wed, 19 Aug 2026 04:30:20 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d19:b0:3bf:b1d3:393e with SMTP id adf61e73a8af0-3cd00dcb3dfmr8444150637.2.1787139019564;
        Wed, 19 Aug 2026 04:30:19 -0700 (PDT)
Received: from [10.110.91.219] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf175399sm11588454eec.26.2026.08.19.04.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 04:30:19 -0700 (PDT)
Message-ID: <97c80fa6-2e04-490a-8b38-c951d7c80486@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 19:30:15 +0800
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] virtio-blk: Add inline encryption support
To: Eric Biggers <ebiggers@kernel.org>
Cc: virtio-dev@lists.linux.dev, stefanha@redhat.com,
        neeraj.soni@oss.qualcomm.com
References: <20260814142306.3934029-1-linlin.zhang@oss.qualcomm.com>
 <20260819043321.GB9971@sol>
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <20260819043321.GB9971@sol>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: u7L05JdJ8ERJFDFiXL15g39Ta_a--Ble
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA4OCBTYWx0ZWRfX4ZvHAvXwXLDg
 3XDrwlxli8NiN60VqbtIURCWphZO//2xGTqv6nGrJwexyusc3Oiv9A5bowf76h+bXlJ1HMkiVvV
 iSF+XvsG5cNvXojaWoNiwtXxf9NRqcI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA4OCBTYWx0ZWRfX2dhjmoesCD6q
 4F78chfGUT9h/8OF/sCIt2OMYgEuM++LrBIRFCREcSsSuSiHZNmytvz7CfWtPVSw/ZEHe9VO0vQ
 b8lb/TN1W2G1arsy6mEqEgo5T+uI93suPV3p/vzu+u9hra4+QHQOJimZUuz7OJHR8TbluHhsmMf
 rim7MhZDhzdE8ogxvPp8Jkm0g9YYTnCFKtkL79B+Ha4BPrujUQ0+RU49md5Yn11QngJw+sngRo4
 kKD+5JdQvv7AjRT2eCSyYnwsHmEMWYHeMcGLq0DtEOZMTN0W2XOF3tUnBBuEaINuWrnlW5KQo6S
 f+0wc1KH8ZgJmhjDytwGHaJ1TU5jFVDsWb3nFVMHytCJSmeunJ8xmg8pO91CTfJLoL76e4tMHzk
 3wolF1vGvNoOhhJmNtc07DEHm5AytVIEqkR9Tg97pZBL5GVa9qY48qz6aUnRaYMNwSgbVnlxXse
 ov9J6kfAjIQDVnUwxRA==
X-Authority-Analysis: v=2.4 cv=aNrAb79m c=1 sm=1 tr=0 ts=6a8593cd cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=1gXo-Xp9jihwCi8IHJAA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: u7L05JdJ8ERJFDFiXL15g39Ta_a--Ble
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190088



On 8/19/2026 12:33 PM, Eric Biggers wrote:
> On Fri, Aug 14, 2026 at 07:23:01AM -0700, Linlin Zhang wrote:
>> When the feature is negotiated, the device reports inline encryption
>> characteristics through virtio_blk_enc_characteristics. Add
>> VIRTIO_BLK_T_GET_CRYPTO_MODES, VIRTIO_BLK_T_CRYPTO_IN, and
>> VIRTIO_BLK_T_CRYPTO_OUT so that the driver can discover supported
>> crypto modes and submit inline-encrypted I/O requests.
> 
> How is the driver expected to program and evict keyslots?

There are 2 new added drivers, one is virtio blk extension driver which is
generic, and the other is crypto virtualization driver which is vendor
specific.

The virtio blk extension driver manages the initialization of blk-crypto-profile,
and implements the interfaces of blk_crypto_ll_ops.

The crypto virtualization driver performs similar operation like the key handling
part in ufs-qcom and ice drivers. It forwards the key program/eviction request to
Trust Zone via SMC call.

For QCOM, the whole flow of key program/eviction is like
  - block layer passes the request to virtio_blk extension driver via blk_crypto_ll_ops
  - virtio_blk extension -> crypto virtualization -> qcom_scm -> SCM -> HYP ->TZ

The vendors can implement their own crypto virtualization driver.

> 
>> For background on inline encryption in UFS and eMMC storage, see:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/block/inline-encryption.rst
> 
> Is there a corresponding Linux driver patch so that we can see how this
> is intended to be used?
> 
> - Eric

Thanks for your review!
I'm preparing the Linux driver patch series and will push them to your
review in a few days.

