Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793442135;
	b=mDHlIdJTPUwrxLe9b7x7v0XSaGDb+b+WOMlpRPCy2+TFdk0244fQkjFsCJmh2qyZeTJE
	 N8JqAwREP3G5/yhBmYZR2c7c2PV4DoS7/Io8ZvISU2BO+pUO99c6sYLQlaJWtuD/xRzC7
	 3kTpxAp/0M0xWMb4xc17akIY1cnec25kwsXZrlcs5gzTlWEARNHkkj6DwRi2wB92o6alA
	 yViTYFWXi8i/8C986pDtjI/M5NoKa+RYTPgUcF5DAlvZhjFhK8bx4wWm5+Cdd01KhZg9J
	 JgQgCGEUZGIa5S56tDQyj9uiCbLyDo0qqfDHKODNTNY2KiQiA/+TXVPYMD4X8xx6cGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793442135;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=mW0GLuDQXLrjGX3D1UlYLfrOI5fHNdnqftXi/IKFCGI=;
	b=FHMybysWi4rBsoqCct5xmoUKokjlQ/Xm1FeurXBPS8+UxKyIuoPKKrnSoJHS0JYlXiYU
	 ecLvGzM5azW5qDxODJ43/0L44EEF/H3udHeVOfV48s9CX4U2/vONnScLNpEK3qtAMHG8F
	 oCPJ3bzMgkEu+FUsikQg2X8VK76Ly/wyNGdL0ZkJ5/b6jiCwf1wgzmhKO2q447BdsN3py
	 37L7yKWFiCmLk93s1wNUxlXokO3x4nflj/GLkoQZUc3FmcHE6cCBDGCffkwt0RD5xhu++
	 iO6ZpfTUjLIL1WhqLrbFU95vdiHYYi1ineZ33XlnQclp+0/drysSuoyps+d3RqGaI0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AhXnsvBA;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WIBX2WGd;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E98606A31A
	for <virtio-dev@lists.linux.dev>; Sat, 31 Oct 2026 10:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16E98606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AhXnsvBA;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WIBX2WGd
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69V4a5tg1175373
	for <virtio-dev@lists.linux.dev>; Sat, 31 Oct 2026 10:22:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mW0GLuDQXLrjGX3D1UlYLfrOI5fHNdnqftXi/IKFCGI=; b=AhXnsvBAxao13mRe
	K0XVd4t0AVBWjnEOH115GY3jqh1xSgurd+5o4KBi6ucf5hNKtSpOqTSLdN4iHKB1
	qS6i0pqF63Y0gDxvyFE2q1SMmL/T46JUvn3HY/KAFPkjGPOVNkkbszzUfYEu/gMw
	SwHlmw4ZFvhfSRya3+7tDh8//uS08daId04j9rNsA4W9NBvcOMacj3tkYsWplIf0
	QHNzSGhw8U4/DRP+sgB75c3mU+docRfhRkEhj9vFrELXtNazIMDCO/o3UEMWDhlj
	gwpMJI9dMts3QneN19G8sZgKQiZhKzIGwWcWYPQD+Z13KRvC4ATygBZj3ymPp/ae
	ra4W5g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn5pkh72p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Sat, 31 Oct 2026 10:22:13 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ada8bc8575so3369071a91.3
        for <virtio-dev@lists.linux.dev>; Sat, 31 Oct 2026 03:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793442133; x=1794046933; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mW0GLuDQXLrjGX3D1UlYLfrOI5fHNdnqftXi/IKFCGI=;
        b=WIBX2WGdOwqMT87zpYYMCHzamqH9oDyAGzk3EeE9f83He9KbQL/J39GQIWKFKRBjKq
         ii2Ocr4lord7d8fP5KXRoF1LCV7oNU5OcDDTV1BHt/Ts/noahj1C6d/HtA9S2hwCdLCU
         ZLaMWsLRtdDmyuk48zM6N1hxgO3tx+UkE51gGJqcMT9Fkw/1NzqituZupJJLkNlBMy3T
         kaGgdHd92IQ351SOig2jOXBm/6ULlX7sUtlbxk2kL3ijWNIslgwjNfyFjSKNnl1WUyss
         mO+tr7UNGDQmXWxNChhYXhneQxJoVkVNTezHaPh1JuexcrEACDg+lhuRN7z+dZ4haP0u
         /SOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793442133; x=1794046933;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mW0GLuDQXLrjGX3D1UlYLfrOI5fHNdnqftXi/IKFCGI=;
        b=x3AyNJqkbSInv0HOTt8B0r0wQYlRor/79QQclS9XnT31CaLlZFwCSFxldwNoMCRjWp
         u2qHvUicbTDzUlcu4Yh+kesgZUDZy5bA+BL6UnuzO5tcgAH+7kAZbydNPFKGEBUedhkc
         N6Zc16VOgujUeJnrLv3Q8ZmqFwBJYPEiUXci4pcV+bqgPWXBKAA4b832JfxJ6lrVJNGV
         q7vrm8rbHavrSvubgYXdhaIwBB9FsophGg3Pe2hF/SNFfz0v6hPu0rTh2zpgK6Gst8bc
         nn45eAR6pHoOb5tz/lc+WvdDQAAa8tiPt0dj7mv7FQNHbg+77GRNBNKMilXLIzgJZbtk
         Zo3w==
X-Gm-Message-State: AFq9FYJ2DNycWPwLFSG/yKKc3ftUe6OojJT+6bE/J8wUKtN7oib1/B11
	rfEUu1ewHa24uwxWK/ZNW5HDAPhuY0vihNW+3zXSJGUGu71DjAGr95mc15snSRUJPHr5uoiPvC/
	Tamj+jpUzvHlAmQ+a4l3EPezkBZK5MCn+3o4LRHWXQIzmv4BQxv1DbwLzFB54fbJ0
X-Gm-Gg: AYBFou3OPDY96mctQ5usuy9uBYq0rG0axcnMaTevM+8A5ALoFvIkMsOtvxsAziod6i9
	LnTxc0axl0TY0ea4Lo2VZI5wMZ4X6cXYPiPWbVIAbaVn0mwUiqIvsjr8FYMJk5Bi5YURyS62WN2
	G18aGt02HRJ0UCaUYIiY69l68R/Ykd07S9hgnj611hJAg6JKI34DVO4iHnxHnpc1LYqlgeuv8/a
	qlUeyZ/JsevMmzVKVkowwqLNPYHPkx6zqN4Yf9ku5DfMGXe+B7QbKxgpCKsjy6qHFnh8hUCJ1Ku
	kArsqEzGyFt7T2fKxc3XEH1ln0+0D0buXjb7MfANLu8+vvwVi4Ibjo5mAUVSOIpUddqKkIdfeNU
	10/JHi5fzzY0QfGlo1UHFamGcQJ7ewCpF+Lw8yXASMkwZvQ1ic+VVI8fxlmucODoO51OIs/FAjw
	QOLsw=
X-Received: by 2002:a17:90b:4b8c:b0:3a8:9d0d:ca50 with SMTP id 98e67ed59e1d1-3ae897c853cmr4257893a91.10.1793442132519;
        Sat, 31 Oct 2026 03:22:12 -0700 (PDT)
X-Received: by 2002:a17:90b:4b8c:b0:3a8:9d0d:ca50 with SMTP id 98e67ed59e1d1-3ae897c853cmr4257874a91.10.1793442131883;
        Sat, 31 Oct 2026 03:22:11 -0700 (PDT)
Received: from [10.231.241.142] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845432e4sm7241145a91.3.2026.10.31.03.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2026 03:22:11 -0700 (PDT)
Message-ID: <8bc63230-0955-4f2c-93a3-b9c76085fd19@oss.qualcomm.com>
Date: Sat, 31 Oct 2026 18:21:46 +0800
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Post: <mailto:virtio-dev@lists.linux.dev>
List-Help: <mailto:virtio-dev+help@lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtio-dev+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] virtio-blk: Add inline encryption support
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>,
        "Michael S. Tsirkin"
 <mst@redhat.com>, parav@nvidia.com,
        Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.linux.dev, ebiggers@kernel.org,
        neeraj.soni@oss.qualcomm.com
References: <20260913161628.368484-1-linlin.zhang@oss.qualcomm.com>
 <20260917210841.GD331587@fedora>
 <2f9affb3-0d1b-4469-9a66-ba052d2d1b6a@oss.qualcomm.com>
 <20260922131442.GB18339@fedora>
 <3a933df3-dff7-4ef3-a120-4c6e22c1fcc1@oss.qualcomm.com>
 <de535820-591b-40f2-b840-d987c3253765@nvidia.com>
 <9515779b-a6da-407f-99f2-011e51683d15@oss.qualcomm.com>
 <20261008060644-mutt-send-email-mst@kernel.org>
 <d503aee0-9920-4c0b-b9a0-c08e505cc3ea@nvidia.com>
 <426abc9a-c7b4-4631-a5fe-3b2bba1d0414@oss.qualcomm.com>
 <4ed90e46-0dc9-40ba-b8a9-800d40b34ef9@nvidia.com>
 <01f3caa9-a1c3-4511-a104-7179ce1791f8@oss.qualcomm.com>
 <0b6fa40c-5a79-4047-9c20-d5c83dc7ee6c@nvidia.com>
 <a78eab07-9192-4725-905e-6f38d7fbac85@oss.qualcomm.com>
 <81464321-5371-433b-9373-10818b7dc014@nvidia.com>
 <8537dffb-0cb5-41a3-980c-7970ab1bc927@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <8537dffb-0cb5-41a3-980c-7970ab1bc927@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: XlpUMI_qmdmrzTvSehN0oayuIZ1-Skbe
X-Authority-Analysis: v=2.4 cv=Z4F5j3RA c=1 sm=1 tr=0 ts=6ae5c155 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=EUspDBNiAAAA:8 a=OaAf0AF_JBTyiOL3-b4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA0MSBTYWx0ZWRfX+204DXM/2fgc
 7J3+AQGMPfcLc+vBemBwwbVK0+/nhcTaiIlo6jzrfSHRSUAcIaTwf4evd8EnuchHQ36PO+74A2x
 F0QyUgLgDCpbyJpAO1hYRwzSjMAjva8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA0MSBTYWx0ZWRfX+XDWf/T4EJWB
 ru5/ANJ9vtvFRCOXh6445KChpcndIRcFoizIYo5Y/nlWCKOkDd1cwaBDXcWNgp552kGbxsOzwPw
 hDa5OjVYhxzI1J9FN8wMzXnjnNKwX13t0G4Kqso5Ac2HvXs+8huq9gra0XbCL3vJZ/xWpJlN4x7
 2r/2hzsrxkKVTvEMlGgsXWHhEHgSkhkWo5Trm/QzGUTGx8ADUu+0R8Jb8fBA0Qspqg+T/gcAKea
 U/PH9hxYyy7ZRLztKaH+k8Trb0wBbRiTgspOBEriUEDLovk7C4vUdueuMEk8cf10Mk3hylwuc/j
 CWthbLx7Xjo64hZInlC7VojCibIrrXCdxpqQv+SplJSquHE5ZwTcZ6vBpUFfyCbyTcskhb5UocO
 kyJS4WuFMoLYTh5O5P1R/ATMb/P1kB7hcY3paccO4DOfrqeYOCIER7Y10/9ckeq8J1rcEjWOly7
 kykd45RMiWD6lSD3Q7w==
X-Proofpoint-ORIG-GUID: XlpUMI_qmdmrzTvSehN0oayuIZ1-Skbe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2610310041



On 10/20/2026 11:22 AM, Linlin Zhang wrote:
> 
> 
> On 10/19/2026 8:36 PM, Max Gurtovoy wrote:
>>
>> On 19/10/2026 12:24, Linlin Zhang wrote:
>>>
>>> On 10/15/2026 8:01 PM, Max Gurtovoy wrote:
>>>> On 15/10/2026 14:19, Linlin Zhang wrote:
>>>>> On 10/14/2026 2:07 AM, Max Gurtovoy wrote:
>>>>>> On 13/10/2026 19:23, Linlin Zhang wrote:
>>>>>>> On 10/13/2026 7:12 AM, Max Gurtovoy wrote:
>>>>>>>> On 08/10/2026 13:15, Michael S. Tsirkin wrote:
>>>>>>>>> On Thu, Oct 08, 2026 at 05:17:30PM +0800, Linlin Zhang wrote:
>>>>>>>>>> On 9/30/2026 6:46 AM, Max Gurtovoy wrote:
>>>>>>>>>>> On 24/09/2026 12:35, Linlin Zhang wrote:
>>>>>>>>>>>> On 9/22/2026 9:14 PM, Stefan Hajnoczi wrote:
>>>>>>>>>>>>> On Tue, Sep 22, 2026 at 12:29:37PM +0800, Linlin Zhang wrote:
>>>>>>>>>>>>>> On 9/18/2026 5:08 AM, Stefan Hajnoczi wrote:
>>>>>>>>>>>>>>> On Sun, Sep 13, 2026 at 09:16:13AM -0700, Linlin Zhang wrote:
>>>>>>>>>>>>>>>> From: linlzhan <linlin.zhang@oss.qualcomm.com>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> This series adds virtio-blk inline encryption support for devices backed
>>>>>>>>>>>>>>>> by storage hardware with an inline crypto engine.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> The protocol exposes device capabilities such as keyslot count, maximum
>>>>>>>>>>>>>>>> DUN size, and supported key types. Encrypted requests identify a
>>>>>>>>>>>>>>>> provisioned keyslot and carry a 256-bit DUN. Key management and crypto
>>>>>>>>>>>>>>>> capability discovery use the block device control virtqueue.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> The control virtqueue is defined as a generic framework so that its
>>>>>>>>>>>>>>>> buffer layout and queue placement are independent of any particular
>>>>>>>>>>>>>>>> control command. Inline encryption then builds on this framework with
>>>>>>>>>>>>>>>> explicit crypto command formats, capability validation, and keyslot
>>>>>>>>>>>>>>>> state semantics.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> All key related operatios are handled in the control virtqueue, and
>>>>>>>>>>>>>>>> the crypto I/O request is handled in the request queue.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> For background on inline encryption in UFS and eMMC storage, see:
>>>>>>>>>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/block/inline-encryption.rst
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> changes in v3:
>>>>>>>>>>>>>>>>      - Add a control virtqueue
>>>>>>>>>>>>>>>>      - Move key program/evict/derive_sw_secret/generate/prepare/import to
>>>>>>>>>>>>>>>>        the control virtqueue
>>>>>>>>>>>>>>> Thank you. This was a big change, especially if you already have an
>>>>>>>>>>>>>>> implementation. I appreciate it!
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> My main feedback is that the new control virtqueue commands are not yet
>>>>>>>>>>>>>>> documented in enough detail so that implementors could implement them.
>>>>>>>>>>>>>>> Once you've decided on the precise semantics, error codes, etc and added
>>>>>>>>>>>>>>> them to the spec, then this will round off the inline encryption
>>>>>>>>>>>>>>> feature. I look forward to reviewing that in the future.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Thanks a lot for your comment!
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Would you please help clarify what the precise semantics are about? detail
>>>>>>>>>>>>>> introduction of the filed in the inline encryption control command struct?
>>>>>>>>>>>>>> like struct virtio_blk_crypto_key_desc?
>>>>>>>>>>>>> By precise semantics, I mean specifying not just the constants and
>>>>>>>>>>>>> structs, but documenting what each command does and how it can fail.
>>>>>>>>>>>>> Each of the key slot programming commands needs this. There should be at
>>>>>>>>>>>>> least one paragraph for each of VIRTIO_BLK_T_CRYPTO_KEYSLOT_PROGRAM,
>>>>>>>>>>>>> VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT, VIRTIO_BLK_T_CRYPTO_DERIVE_SW_SECRET,
>>>>>>>>>>>>> VIRTIO_BLK_T_CRYPTO_GENERATE_KEY, VIRTIO_BLK_T_CRYPTO_IMPORT_KEY, or
>>>>>>>>>>>>> VIRTIO_BLK_T_CRYPTO_PREPARE_KEY.
>>>>>>>>>>>>>
>>>>>>>>>>>>> For example:
>>>>>>>>>>>>>
>>>>>>>>>>>>> The VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT command empties a key slot so that
>>>>>>>>>>>>> key information is removed and the key slot cannot be used until it is
>>>>>>>>>>>>> programmed again. The key slot index is specified by struct
>>>>>>>>>>>>> virtio_blk_crypto_key_desc \field{slot} and all other fields in the
>>>>>>>>>>>>> struct are ignored. The command succeeds with VIRTIO_BLK_S_OK if the key
>>>>>>>>>>>>> slot index is valid, including if the slot is already empty. If the key
>>>>>>>>>>>>> slot index is invalid, the command fails with VIRTIO_BLK_S_IOERR.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Stefan
>>>>>>>>>>>> Thanks for the clear example.
>>>>>>>>>>>>
>>>>>>>>>>>> I'll follow the same approach and add explicit normative semantics for
>>>>>>>>>>>> all inline encryption control requests.
>>>>>>>>>>> Can you please explain why we need to introduce yet another VQ type for control?
>>>>>>>>>>>
>>>>>>>>>>> We've added the Admin VQ as a generic VQ for control operations — I'm not sure why it isn't sufficient.
>>>>>>>>>>>
>>>>>>>>>>> Adding control VQ to each device type seems strange to me after adding a generic Admin VQ.
>>>>>>>>>> Thanks for your comment! And I agree that the Admin VQ should be considered before
>>>>>>>>>> adding another device-specific control virtqueue.
>>>>>>>>>>
>>>>>>>>>> My understanding is that some of the inline encryption commands(get_crypto_modes/program key
>>>>>>>>>> /derive_sw_secret/evict key) are runtime operations of a specific virtio-blk deivce.
>>>>>>>>>> In particular, different virtio block devices may have different storage hardware sources
>>>>>>>>>> of crypto modes, and keyslot programming and eviction are invoked through the block device's
>>>>>>>>>> keyslot manager, and the programmed virtual keyslots are subsequently referenced by the
>>>>>>>>>> encryption requests submitted on that device's request virtqueues. These commands are
>>>>>>>>>> not about the management operation of device group.
>>>>>>>>>>
>>>>>>>>>> There is also a transport compatibility concern. The current virtio SPEC states that
>>>>>>>>>> 'Devices and drivers utilizing Virtio Over MMIO do not support VIRTIO_F_ADMIN_VQ'.
>>>>>>>>>> virtio MMIO is extensively used, so using the Admin VQ would make the feature unavailable
>>>>>>>>>> for that transport unless the proposal also extended the MMIO transport.
>>>>>>>>>>
>>>>>>>>>> For these reasons, currently I believe that a virtio-blk control virtqueue is the better
>>>>>>>>>> fit: it keeps the complete key lifecycle associated with the block device and remains
>>>>>>>>>> usable across the transports required by the feature.
>>>>>>>>>>
>>>>>>>>>> I would appreciate any feedback or insights from you and Stefan on the V5 patch series
>>>>>>>>>> posted for review before October ASAP.
>>>>>>>>>>
>>>>>>>>> Fundamentally, it does not make sense to force all vqs to be admin VQs.
>>>>>>>>>
>>>>>>>>> Admin vq would make sense if there is complex resource management going
>>>>>>>>> on - like what is happening with all the flow control things in the
>>>>>>>>> network device, since they have extensive functionality for managing
>>>>>>>>> device resources.
>>>>>>>>>
>>>>>>>>> Random device specific commands - I am not sure we want that.
>>>>>>>>> It remains to be proven.
>>>>>>>> Admin vq was added for mgmt/control/admin/non-DATA_IO operations.
>>>>>>>>
>>>>>>>> Fundamentally, it does not make sense to force random device to create new control VQ since we already defined admin VQs for this purpose.
>>>>>>>>
>>>>>>>> We could have introduced control VQ on each device type, but we didn't.
>>>>>>> Thanks for your comment!
>>>>>>>
>>>>>>> My concern is that these inline encryption commands are tightly coupled
>>>>>>> to a specific virtio-blk device rather than providing generic administrative
>>>>>>> functionality.
>>>>>> We've all the needed plumbing in place in the AQ for device specific admin commands - see virtio-net specific admin commands.
>>>>>>
>>>>>>> GET_CRYPTO_MODES exposes capabilities of a particular block device, while
>>>>>>> PROGRAM_KEY and EVICT_KEY operate on that device's keyslot manager. The
>>>>>>> resulting virtual keyslots are then referenced directly by encryption requests
>>>>>>> submitted on the same device's request VQs. The entire key lifecycle therefore
>>>>>>> remains local to a single virtio-blk instance and its I/O path.
>>>>>>>
>>>>>>> My understanding is that Admin VQ was introduced primarily for device agnostic
>>>>>>> commands. The GET_CRYPTO_MODES/PROGRAM_KEY/EVICT_KEY control commands appear to
>>>>>>> be inherently virtio-blk-specific rather than a cross-device interface.
>>>>>>>
>>>>>>> There is also a transport consideration: VIRTIO_F_ADMIN_VQ is currently
>>>>>>> unavailable for virtio-mmio, while the proposed control VQ approach remains
>>>>>>> transport-independent.
>>>>>> This limitation was introduced because we didn't want to add more noise when AQ was added (it was already a big change).
>>>>>>
>>>>>> Nothing really prevents adding AQ to mmio transport.
>>>>>>
>>>>>>> For these reasons, I currently believe a virtio-blk control VQ is the better
>>>>>>> fit.
>>>>>>>
>>>>>>> I'm appreciated if you can give any feedback about it.
>>>>>> I think that the correct path is AQ.
>>>>>>
>>>>>> Introducing another VQ type for the same purpose (mgmt cmds) seems weird and make device implementation harder.
>>>>>>
>>>>>> It is much harder to implement a new VQ type than a new opcode in the existing AQ.
>>>>>>
>>>>> Thanks for your comments!
>>>>>
>>>>> I agree that reusing the existing AQ avoids introducing another VQ type in virtio-blk.
>>>> I'm glad that we're aligned on this one.
>>>>
>>>>> My concern is that AQ is currently not supported with virtio-mmio, and adding such
>>>>> support appears to be significantly more involved than introducing a
>>>>> virtio-blk-specific control VQ.
>>>> I don't think that this is a good enough reason for introducing a new VQ type in Vblk.
>>>>
>>>> We need the best spec definition, one that will serve us for years to come, rather than worrying about 1-2 weeks of additional effort (to a task which is completely orthogonal for adding enc to vblk, IMO).
>>> Thanks for the clarification.
>>>
>>> I still have one concern about using the Admin VQ here. Since the inline encryption
>>> commands are specific to a particular virtio-blk device, how does the host
>>> determine which virtio-blk device an Admin VQ command applies to?
>>
>> Not sure what do you mean.
>>
>> An admin virtqueue belongs to one virtio device (the owner), and every admin command carries
>> a group_type and a group_member_id. The spec defines a Self group (group_type 0x0, member id 0x0)
>> that contains the owner device itself and no other device.
> 
> Thanks for the clarification. I misunderstood this earlier.
> 
>>
>>
>>>
>>> I couldn't find a host-side Admin VQ implementation, even for virtio-pci. Could you
>>> please point me to an existing implementation or example for reference?
>>
>> there are examples in Linux for AQ usage for LM and vNET special configs.
> Thanks. I was specifically looking for a device-side/host-side implementation that
> processes Admin VQ commands, e.g. in QEMU or crosvm, rather than the Linux driver-side
> Admin VQ implementation. Is there an existing backend implementation that I could use
> as a reference?
> 
>>
>>>
>>>> The high level spec enhancements I envision are:
>>>>
>>>>    * Allow ADMIN_VQ on MMIO - Remove VIRTIO_F_ADMIN_VQ from the “reserved” MMIO list. Update the feature-bit text to align.
>>>>    * Add two read-only registers to the MMIO register table, mirroring PCI’s admin_queue_index and admin_queue_num. They are valid only when ADMIN_VQ is negotiated. My suggested offsets are 0x0c4 and 0x0c8, which appear unassigned in my version.
>>>>    * Reuse the existing queue flow. PCI’s rule refers to num_queues, which MMIO lacks. So either reword it as “admin index is above every regular queue index and index plus count stays within 0x10000”, or add a NumQueues register.
>>>>    * State the Self-group scope - An MMIO owner device supports only group type 0x0. Other group types fail with INVALID_GROUP, following the existing validation rule.
>>>>
>>>>
>>>>> Given this constraint, Admin VQ support in virtio MMIO will impact the inline
>>>>> encryption support on virtio block, so, I prefer to the virtio-blk-specific
>>>>> control VQ as this requirement is a more widely and general request, especially
>>>>> in the virtualization platform with a Android guest virtual machine.
>>>> This is not a constraint worth considering a non-optimal architecture.
>>>>
>>>> Creation of VQs takes device resources. We prefer not introducing new VQs if not needed. Adding a new opcode is more reasonable for your requirement.
>>>>
>>>> Imagine a block device with N resources for VQs: N-1 for request VQ and 1 for Admin VQ. If we need to introduce a new CVQ then it will be instead of one request VQ resource.
>>> I agree that the new CVQ would take the place of one request VQ. For a virtio-blk
>>> device with N VQs, this would leave N-2 request VQs, with one CVQ and one Admin VQ.
>>>
>>> I agree this is not ideal. However, if there is no way to handle these
>>> block-device-specific commands through the Admin VQ, a dedicated CVQ seems necessary.
>>
>> Anything you can do with the CVQ, you can also do with the AQ.

Thanks for your comments!

Refer to the virtio spec update of Admin VQ support for virtio mmio (see
https://lore.kernel.org/all/20261017114556.1701355-1-parav@nvidia.com/), I added the
Admin VQ support for virtio mmio and update the dedicated control VQ in virtio block
to Admin VQ. The E2E validation of inline encryption in virtio block pass. 

The updated virtio spec for virtio_blk inline encryption can be found in
https://lore.kernel.org/all/20261027090945.185178-1-linlin.zhang@oss.qualcomm.com/

Would you please help review it again?

>>
>>>
>>>> I prefer having a correct architecture.
>>>>
>>>>
>>>>>>>>> But generally why does this go on a special VQ? Is there a reason?
>>>>>>>> Also in other related protocols the key mgmt goes throw a NON-IO Queue..
>>>>>>>>
>>>>>>>>
>>>>>>>>> You define distinct request types seemingly and we are not short on types?
>>>>>>>>>
> 

