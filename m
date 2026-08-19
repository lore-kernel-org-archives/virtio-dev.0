Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217E936DA18
	for <virtio-dev@lists.linux.dev>; Wed, 19 Aug 2026 11:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787137808; cv=none; b=IG6Pymlzfxu8eUndLQJit/dC4mVuYFbq1WWKY7YNZWKyVoklOGJM2guvp5HU1pHdvH7IsHgrbVVsVLZdQ6JbgJjOCoI5dH7/zxILS8Zh0qcpFHM1DpW4FzvlyMeP7x5o8QRoSVUozaFO8GJCFhhJym0F2tzVk5VGjZyUdakGuS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787137808; c=relaxed/simple;
	bh=zaOQQZoj2wwjw6CtHsJjFT46d2QD5QjqON0zkGF8CZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dBqCs3Gj/eRNDQ635buYC5CXQI/Y+2PpRmp9epBS0WWYnpRoywbJxaT4hnpVEk6Pd9lmpExIAnO25xuh+bngpMQa4xLBPRjxzinrD1vgpt4rDfdv2UuwrO6YvCwJjOob3kHr6jfbv6hwG+jeMA6jzfDSdqAyuiu9eqq0nE3TOoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=km3vQFB6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RPF2+fG3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="km3vQFB6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RPF2+fG3"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JA85mU307180
	for <virtio-dev@lists.linux.dev>; Wed, 19 Aug 2026 11:10:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JFHtmrCPYCFmnICmy1shctjEEfSfTAKGMCxDKvgG2BU=; b=km3vQFB6bCxtcPfq
	4yx0dNAwf4OzQLLCuHdphcUo4oTjkwT0hWpMUSQqaukOva0esXEh3SGA261kfY8v
	BJWiXk/4X3Tc1N+/b1DC37ZPsqFTsdLnySwtu+HyngKQ3NG9PcwaIVv91Mxdb5f2
	1XA+q8WyYd7HVLMeL69/yRUzTInFQ4z0VmceEb3R71rU3aY/n4Q1hhVjG0yRgnUj
	n0AHWu5tZwoWDsvQqj2x12+nolY9HFcWPgURWTQQO1VaEk0xjnNbgIFRvqlKEV6h
	rzCysRDppHhUhUVY/fzM/1X7sPutcyhek0ArYuU//C7DhTPexKpI1D4cI748mv5G
	3WsvWw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfmauqx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Wed, 19 Aug 2026 11:10:05 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-395543dc382so1231573a91.0
        for <virtio-dev@lists.linux.dev>; Wed, 19 Aug 2026 04:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787137805; x=1787742605; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JFHtmrCPYCFmnICmy1shctjEEfSfTAKGMCxDKvgG2BU=;
        b=RPF2+fG3ZKBzPlVYWjv9f0dVdY7f6XFKFUzDroRwFAlw+HGkyWXt4SOzmB1s2/sPgQ
         Bn8nTnWKdKl2jwaowScuCRlt75D2R7BoGLzoFlTiIQqUePYAQo+pcX0wzu1czehXZU5/
         jQ5UhVNZzRpRV4ZZbeB6eJzL8ACs3rB8FB5K0Z5qemyAEfcEWKbsMjJA2Wwn6otUv3H6
         Csu7Grw/NkhSgW8Th1uN2nU0Ds8G9nIdTcBc5VMA4CnbxAM2JDl3pB+kv39kJxJ4za0w
         +/oA1HHwU14M8QTlpUJuXOvlyPV5l1RQ0r7k3ylQIXsmrLlDpMVJKNL7KjfbQl/vdJ+K
         V3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787137805; x=1787742605;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JFHtmrCPYCFmnICmy1shctjEEfSfTAKGMCxDKvgG2BU=;
        b=jI/wKHJu37xbTv/2xK4WvAfCKDs9KOSL4oBvxTsKDXyooYAq7Tqomr7/VnWQqyxWAS
         +D98Xstunrd4vV+6wAKoM7rRDss/0Kn14cEpmDZimlDZy5kZptPoo5q/BZOl3rMEia+H
         DWXig/BgGDpZmzMf9uUzXtxQrBZLGLTPPMbYeHdVizN2ST/x7xNPXULn/5+2Nb3q2x9w
         TiRceyjYz38MR0alCCRgJP9syTRP2RH8tRMIEL1DRJJREX3INKepSJL1fqXQjWxrE7Z/
         csvFORuNokiOq7nQ1GJ/wjvumjmSuUkrrlUVhObDzC5l6mSl34NU6tRjuc4iqNT6fCle
         mzdA==
X-Gm-Message-State: AFuF++la4vNF4BPFoa9yICXo4SgWxRrin0rhhbfptdpxtANjIn71Tzve
	Z3YwFiwD6QiqChccqxTdVoUUScpLsP8/8XPOsP1nZgorwCGrFrE3ATi0fc8NwhzlIXLsIuPXkFJ
	oAtTuhipqg8D13aicTuUSfOKf3dxDN4T0nkIVhNl68fsfD3F+CViA0br0jCDjwf3gd/1/Wrye
X-Gm-Gg: AR+sD13nLjH4KKzlOgNk80XrawXazQqPHrU83GD+yLs0Zb/S6oCtjQ/wEXppacn92bB
	zG+f9E+ViDQljjCJT7iLJ6i4llhgmGQNivnGpn4J1KPRjmY/A5zdsggQxe+IPgZ9gkshyE8oYku
	p91aTrx2HVtcRTyHyrAmmLZQv2Y+rE4eGO7xY/FlniYAxUndONmtNmyxgiJEDYzY7NI6F0juIY5
	9zmnN/meh80j5AyLN03JjamXZC0t4bf1hq9nCjrFFSCIq7EeJlE6Ycs39/sNOp4AwNvzcahg98G
	qS5yocQpTb3m5VIwYB156l0A51VI2v7tboA8a/Xtb+23+qrzJae9/0qWzzfWPiE2xJUTugN72ud
	9bZCl+4AN9wF8xVPgA/Wxt7FC9qTrc8ybe/5F85uD+6hC5k3Y+gJsTYGZYw==
X-Received: by 2002:a17:90b:4a46:b0:37f:e326:6557 with SMTP id 98e67ed59e1d1-3958083fc60mr7111095a91.4.1787137804458;
        Wed, 19 Aug 2026 04:10:04 -0700 (PDT)
X-Received: by 2002:a17:90b:4a46:b0:37f:e326:6557 with SMTP id 98e67ed59e1d1-3958083fc60mr7110953a91.4.1787137803833;
        Wed, 19 Aug 2026 04:10:03 -0700 (PDT)
Received: from [10.110.91.219] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ad699c9sm6819232c88.8.2026.08.19.04.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 04:10:03 -0700 (PDT)
Message-ID: <74d6681f-f1b9-49b4-8d23-1be057d619be@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 19:10:00 +0800
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
 <20260819042915.GA9971@sol>
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <20260819042915.GA9971@sol>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: TypE_f8jOenT3kQcgcKdcMEjrR8vhWJr
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA4NiBTYWx0ZWRfX3mrGiI+QoD8U
 JxjvqhZVBek9/PwJBKEeFylh85GfUvGdfDjSwouyWSdz6GHzQHekNvyljM7zryW+9piIR3GkhSV
 1ZerwM4di2TYGUVHaeJ3Eju8lAuM9C8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA4NiBTYWx0ZWRfXwdaU08KMzpST
 41ccBXC+Sm0gsKe4W+q48POjrwTDZJRfdHxHR2XX3s79SEUIR70A8Olc7iyoPAg2f5yRp5rhKJ9
 wF4r1r3DQBHMyKUbZy9eEhTQmiTV0+KdgN3wF0laEnvgfj+1EeCwF/+WYDGawZv16vZuBwn2mRv
 JavDPFx279c8V3xfFMYxxlX9G15Ya2WcRErMxu56gz4Xn0fjEDnoj6uOoK+OSC3FoJZenW3qjKT
 BAtxLpV49XFoM9BkkAGLWbM6/DihmSD9Yn8KPMs5WArDzMQqX02XUsVWpltw4kQNxDtzlstTnSP
 Ihj/oDbhhb3smTKuWdOBwni/6z5w7OvxtVr8nU7HEkdLe6NE7UQM6lnJGYmERF9hXDHkOhNTaTB
 FqTohTOEvqsyPBupi1qtUen1eGPX0+X2826Je3yLeA64Or+Iwi6LiZ7O/p0g21PTImdPk96bUYC
 pge22UyqjX0YRrPqH9w==
X-Authority-Analysis: v=2.4 cv=aNrAb79m c=1 sm=1 tr=0 ts=6a858f0d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=qI2d_F5Fybie4yWD5GQA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: TypE_f8jOenT3kQcgcKdcMEjrR8vhWJr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190086



On 8/19/2026 12:29 PM, Eric Biggers wrote:
> On Fri, Aug 14, 2026 at 07:23:01AM -0700, Linlin Zhang wrote:
>> +\begin{lstlisting}
>> +#define VIRTIO_BLK_CRYPTO_MODE_AES_256_XTS        1
>> +#define VIRTIO_BLK_CRYPTO_MODE_AES_128_CBC_ESSIV  2
>> +#define VIRTIO_BLK_CRYPTO_MODE_ADIANTUM           3
>> +#define VIRTIO_BLK_CRYPTO_MODE_SM4_XTS            4
>> +\end{lstlisting}
> 
> Is there a use case for any of these other than AES-256-XTS?  I guess
> you copied this list from the fscrypt file contents encryption modes.
> But there are a variety of historical reasons for fscrypt's list.
> There's no reason for virtio-blk to have exactly the same list.
> 
> For inline encryption hardware, AES-256-XTS is the one that is actually
> used.
> 
> Let's simply specify AES-256-XTS for now, unless there's an actual
> reason to support more.
> 
> - Eric

ACK.Thanks for your comments!

I'm not sure if the crypto modes except AES_256_XTS is supported or not by
other vendors' inline encryption hardware. so, I made them aligned with the
crypto modes defined in blk-crypto driver to avoid the functional deficiency.

With your confirmation, I agree to only maintain AES-256-XTS for now.

