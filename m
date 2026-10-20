Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792466552;
	b=oYnnyyxlMUfi1mAT1AjGw60ZJrJGdn+wW9PWNZ1/f/8XIwabCjfcPDGI6DqaVpx/NAzd
	 D1r3qZ6IY1gAB0Ra6Suk49YxH6u77E/XftmS/cpybQT9kIIACl5LOO4XpY67v0/3g8heR
	 i84fpqq1F+DxzDJ6Z8IlNsEEb/riahKUwSqMc6IruxmRJDy83eCWQ2VV9PDaqZF1rcPXE
	 gIO9GwdYZOAoEJRwUHxdeXgbLehtdrqBP+CRky9IjtK6hNGfGsC6/3LH7jHFA2CEddWVw
	 nMyycqfpV3TqjqrwthT+rY+GI9T5DtAY1ulpNzO75Fayi4c6qa+MDXCcFKBPA9dn6nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792466552;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=FOCR789lVdnIWof8QvCSCWMrCeDacrDW2Fmfo/6r38A=;
	b=cHy4zDRrFkB6fpKodRomuV2NLR8yiGSroAIt53iRUoMGvzcKt1+JP+ekM3MgIgnmOIbC
	 Z7Oq/hZ0tHB+m8mNL10pZHoufxlpBiTT1lB/55VdcLoC12/A/06OOkgd+CDIOwDF3LNiN
	 H+JcadxgCYiDuJPhBDaeQKjUj01XSiXPHd60fnElMsQzNKMFuaR1N3r540gdU8iCI6EJx
	 ucvhA2zsFS3kMv0q2E3bcgDEXIkH6gc0Iv/7zFxenls6T35iOMJNwbEJpmNBCcsISkJ8l
	 N8tQ+g/uYSOX3+JffHulZLpMUkUb7y23MlM+z3bOafxjP9ZhBjsS55Pnm1TjTe75Fhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EPee7Ft3;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eNWoLRNg;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30368606A319
	for <virtio-dev@lists.linux.dev>; Tue, 20 Oct 2026 03:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30368606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EPee7Ft3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eNWoLRNg
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69K0t5ie1210951
	for <virtio-dev@lists.linux.dev>; Tue, 20 Oct 2026 03:22:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FOCR789lVdnIWof8QvCSCWMrCeDacrDW2Fmfo/6r38A=; b=EPee7Ft3bgXH4nkY
	RjR01pZ1ismBmf3QVqTx8lcTOJE1wzEvAdowiIXNNIUVaYHvNEkRyYhGqRxM16bl
	8k+iuYw+UV819I2oIkTZ0reDJcVryqChbTJgaIYorQLarodV2uCq9qmQWh+r/QHI
	wZzEQ36fT58SAl+rh2jsk6wfw1Jk0EDXRaV91sTCc9hZ3p9IjKGBM/V9mSnQziP+
	MBJ8cPOwbX4gvxzQazJ32JfRmvDERf9F1n9fU7z+5ytzC8LyUb7MPi/Yx8LoKkyn
	OH6LX5TVVQezHilftXzSQZvfe4jMQdCnT6w/UZ9r0XupG4GnChysFZ5cDhcGqcFg
	TneVTA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5p0muw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Tue, 20 Oct 2026 03:22:31 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3662e7a9299so1131661eec.1
        for <virtio-dev@lists.linux.dev>; Mon, 19 Oct 2026 20:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792466550; x=1793071350; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FOCR789lVdnIWof8QvCSCWMrCeDacrDW2Fmfo/6r38A=;
        b=eNWoLRNgIfm5O7IxYjF8UQKO84fRJBRlRicvktsBj4ch3TxzUyTCTV0Iq0XAz3hhsa
         kaUyeHWxmPioGQjhSSMdLAcxpMQ37FnJVM8KPiQVAAWTEoTfODI9wXGzkM2E1Ioi8Wxe
         gRXH44r6flKD7E3L7ECqG65itgZniY+UK5P8u6tQcwyWi+iCwL1FlJCo8J3h43vM+p3E
         wzRRHYLbz/eVnsjsAZ4rwa+jMJjBfJClvRhcmfT4vvfjJ69GvwYaWrQeuVNlyakYIQ+s
         qYwC4xrfyQ4Hy1f0aByUBQtUN+2V8x1r4cnxzQ9KnDc9jbPVZcFlHh3LMq404m2+ZwWR
         1tOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792466550; x=1793071350;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FOCR789lVdnIWof8QvCSCWMrCeDacrDW2Fmfo/6r38A=;
        b=WtX7Pnp/TUSpiAzqc5OGCbDesUhJlnmVOfZN+mazd7X5hp/BZqlrg0Wa7+tOw6k0XZ
         azTr9TSWnbbA4LvCcuvL6felYKHWLvZ/so1Tzaza9/sZ5tQeAk1Qy7q/mevgBRTSAM1w
         Toun/b/jEEinyV0V4193dXp0UwE8bic7kSvxsMDPvWTtQAhsPqD6ZQnIL1vjZAr2cwaf
         AGSIxCtc32g5zjK5sAv4XOdOJTTxV89JOxoXIsmylmD7M5KT4GR9kPppSHDCYuHGrJzX
         CYPIn9k+FZU3Dpc08A5J5zqnZ2QR1mldSo8PR1ebaNWqWfcVDpFNJa8TDqMsxR/9PdMp
         4F1w==
X-Forwarded-Encrypted: i=1; AKwUvBy/DpElxKcup//iPtcCag7xHq7KQnPBNW301ZzAZfDHcjQL6kh1/SWJaO3spekeE6+D3ZLYDlbv9rHd@lists.linux.dev
X-Gm-Message-State: AFq9FYIgXhSs3/PhHiAH3pCpiVeXY17848CVx6F7SA+KEah2ygVga6+h
	n94wEPrlZNee7Osy4UE8lvp4hvRsa13r7a8n6DKPqdc37LCC8FIgAIJaMNuhpTBqv0Dn+YtjpxD
	JnaG6AAo7ZzmYZZ77Z3Qwk1HNusg9IFeTmlsrutis3SVoBOX3g81oBV/uuCbClAH7
X-Gm-Gg: AYBFou1lOCDHPzxyut9ETKOmX+HmE7hgX33kGHNuXkMJmIELbhGIfNxVt1+RMI7URo5
	hAx1yaWKM2kY2clHThK2fqKQHSOkFQpi/2+0g1EZjN4RlginTriHzxSKMwE9bbAsgyHhXX8ni29
	eqLR86qrc0hy3LC+fRxuDbB2T0dMvBtZDJe0fjEfFxG26OwhxO3HxdzUZkCAd5e01xmT9rSO8zm
	06RfHSz/kjhn2t3uhslx6ZEkWP8UsUiycASDs+cKBwHQ77/98cL3GYMLqqqnUw10NQwVlCa+FUi
	TSrqNGtVAvOHa4RdOlsHZD1cn8P5MY6n0SZnAVP7WiL5P7Na1U6flZ4m7sJ725cFGdLIr0bQXg5
	E8aqvIYBioaV9YVh+77b+0M3jIXqC3i/mAsz2RtS3zgTX8HcW0g213526
X-Received: by 2002:a05:693c:83c4:10b0:35c:6fbd:a1c2 with SMTP id 5a478bee46e88-3619f1fd1eemr15644721eec.4.1792466550270;
        Mon, 19 Oct 2026 20:22:30 -0700 (PDT)
X-Received: by 2002:a05:693c:83c4:10b0:35c:6fbd:a1c2 with SMTP id 5a478bee46e88-3619f1fd1eemr15644674eec.4.1792466549127;
        Mon, 19 Oct 2026 20:22:29 -0700 (PDT)
Received: from [10.110.10.179] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6ca5sm34567401eec.9.2026.10.19.20.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 20:22:28 -0700 (PDT)
Message-ID: <8537dffb-0cb5-41a3-980c-7970ab1bc927@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 11:22:22 +0800
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
To: Max Gurtovoy <mgurtovoy@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.linux.dev,
        ebiggers@kernel.org, neeraj.soni@oss.qualcomm.com, parav@nvidia.com
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
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <81464321-5371-433b-9373-10818b7dc014@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: mJ3yi3wIUZDNd-U4s8A90n3vSrbAk7R1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAxMiBTYWx0ZWRfXwX8OBxDU/MZ2
 VMibNrGjDTI70eGCVi7ldBiOY4iTVsjnA242MLs+kGatpWVBfazO0gQAuxSKdbeHie1/mp5/FGL
 x6CV+Uz3sJ0afWR4tTHKhPdMnL4v12A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAxMiBTYWx0ZWRfX1osHhGpgxgdF
 x1gRUcl2NmVBFJrNh6Lw+d49bn56r0TCmii14bGSNeoGU7NMVk0Lrz7HhaPo4GSfCm7iDXwlGnS
 yIVuPWTEZjOezgq3/lRqbDodbrQb1vOgMIODYdvBZGasIoV/8ogjLPQIrqjhxOCW+XJaxG3t9VE
 rKdQg3UoozY8YgPWd+Sq49CDsAwkz6j8kQePxtft/KeqZGwPLbDxrAXXSmEtbMjkGrQ2ntB+YR7
 5ess89s4oLbp00R/wxGOdig2T1FWnu6Uz8udFSpGjOW5xoot5Og33jCQ3/+m1xr0wauk2hwONRE
 9j4pYmAXknMmOQfnU46cxLP/idASv/MRtnLH63NfKUqRaqeIh0aDjUJV/FcyBVbPbNuGg+uYv8I
 wckyTpowPtE6TH1qcu8x2nFAXt3TFfeQ3/3igpw45RPcvIHBUmtCq/U6otZZIWkeVcRQyGcxTEz
 i6tkzjl4Kz4fAbzmo8Q==
X-Proofpoint-GUID: mJ3yi3wIUZDNd-U4s8A90n3vSrbAk7R1
X-Authority-Analysis: v=2.4 cv=crUOAF4i c=1 sm=1 tr=0 ts=6ad6de77 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=xo-0DvgAw4pSRefXoH8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200012



On 10/19/2026 8:36 PM, Max Gurtovoy wrote:
> 
> On 19/10/2026 12:24, Linlin Zhang wrote:
>>
>> On 10/15/2026 8:01 PM, Max Gurtovoy wrote:
>>> On 15/10/2026 14:19, Linlin Zhang wrote:
>>>> On 10/14/2026 2:07 AM, Max Gurtovoy wrote:
>>>>> On 13/10/2026 19:23, Linlin Zhang wrote:
>>>>>> On 10/13/2026 7:12 AM, Max Gurtovoy wrote:
>>>>>>> On 08/10/2026 13:15, Michael S. Tsirkin wrote:
>>>>>>>> On Thu, Oct 08, 2026 at 05:17:30PM +0800, Linlin Zhang wrote:
>>>>>>>>> On 9/30/2026 6:46 AM, Max Gurtovoy wrote:
>>>>>>>>>> On 24/09/2026 12:35, Linlin Zhang wrote:
>>>>>>>>>>> On 9/22/2026 9:14 PM, Stefan Hajnoczi wrote:
>>>>>>>>>>>> On Tue, Sep 22, 2026 at 12:29:37PM +0800, Linlin Zhang wrote:
>>>>>>>>>>>>> On 9/18/2026 5:08 AM, Stefan Hajnoczi wrote:
>>>>>>>>>>>>>> On Sun, Sep 13, 2026 at 09:16:13AM -0700, Linlin Zhang wrote:
>>>>>>>>>>>>>>> From: linlzhan <linlin.zhang@oss.qualcomm.com>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> This series adds virtio-blk inline encryption support for devices backed
>>>>>>>>>>>>>>> by storage hardware with an inline crypto engine.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> The protocol exposes device capabilities such as keyslot count, maximum
>>>>>>>>>>>>>>> DUN size, and supported key types. Encrypted requests identify a
>>>>>>>>>>>>>>> provisioned keyslot and carry a 256-bit DUN. Key management and crypto
>>>>>>>>>>>>>>> capability discovery use the block device control virtqueue.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> The control virtqueue is defined as a generic framework so that its
>>>>>>>>>>>>>>> buffer layout and queue placement are independent of any particular
>>>>>>>>>>>>>>> control command. Inline encryption then builds on this framework with
>>>>>>>>>>>>>>> explicit crypto command formats, capability validation, and keyslot
>>>>>>>>>>>>>>> state semantics.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> All key related operatios are handled in the control virtqueue, and
>>>>>>>>>>>>>>> the crypto I/O request is handled in the request queue.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> For background on inline encryption in UFS and eMMC storage, see:
>>>>>>>>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/block/inline-encryption.rst
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> changes in v3:
>>>>>>>>>>>>>>>      - Add a control virtqueue
>>>>>>>>>>>>>>>      - Move key program/evict/derive_sw_secret/generate/prepare/import to
>>>>>>>>>>>>>>>        the control virtqueue
>>>>>>>>>>>>>> Thank you. This was a big change, especially if you already have an
>>>>>>>>>>>>>> implementation. I appreciate it!
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> My main feedback is that the new control virtqueue commands are not yet
>>>>>>>>>>>>>> documented in enough detail so that implementors could implement them.
>>>>>>>>>>>>>> Once you've decided on the precise semantics, error codes, etc and added
>>>>>>>>>>>>>> them to the spec, then this will round off the inline encryption
>>>>>>>>>>>>>> feature. I look forward to reviewing that in the future.
>>>>>>>>>>>>>>
>>>>>>>>>>>>> Thanks a lot for your comment!
>>>>>>>>>>>>>
>>>>>>>>>>>>> Would you please help clarify what the precise semantics are about? detail
>>>>>>>>>>>>> introduction of the filed in the inline encryption control command struct?
>>>>>>>>>>>>> like struct virtio_blk_crypto_key_desc?
>>>>>>>>>>>> By precise semantics, I mean specifying not just the constants and
>>>>>>>>>>>> structs, but documenting what each command does and how it can fail.
>>>>>>>>>>>> Each of the key slot programming commands needs this. There should be at
>>>>>>>>>>>> least one paragraph for each of VIRTIO_BLK_T_CRYPTO_KEYSLOT_PROGRAM,
>>>>>>>>>>>> VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT, VIRTIO_BLK_T_CRYPTO_DERIVE_SW_SECRET,
>>>>>>>>>>>> VIRTIO_BLK_T_CRYPTO_GENERATE_KEY, VIRTIO_BLK_T_CRYPTO_IMPORT_KEY, or
>>>>>>>>>>>> VIRTIO_BLK_T_CRYPTO_PREPARE_KEY.
>>>>>>>>>>>>
>>>>>>>>>>>> For example:
>>>>>>>>>>>>
>>>>>>>>>>>> The VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT command empties a key slot so that
>>>>>>>>>>>> key information is removed and the key slot cannot be used until it is
>>>>>>>>>>>> programmed again. The key slot index is specified by struct
>>>>>>>>>>>> virtio_blk_crypto_key_desc \field{slot} and all other fields in the
>>>>>>>>>>>> struct are ignored. The command succeeds with VIRTIO_BLK_S_OK if the key
>>>>>>>>>>>> slot index is valid, including if the slot is already empty. If the key
>>>>>>>>>>>> slot index is invalid, the command fails with VIRTIO_BLK_S_IOERR.
>>>>>>>>>>>>
>>>>>>>>>>>> Stefan
>>>>>>>>>>> Thanks for the clear example.
>>>>>>>>>>>
>>>>>>>>>>> I'll follow the same approach and add explicit normative semantics for
>>>>>>>>>>> all inline encryption control requests.
>>>>>>>>>> Can you please explain why we need to introduce yet another VQ type for control?
>>>>>>>>>>
>>>>>>>>>> We've added the Admin VQ as a generic VQ for control operations — I'm not sure why it isn't sufficient.
>>>>>>>>>>
>>>>>>>>>> Adding control VQ to each device type seems strange to me after adding a generic Admin VQ.
>>>>>>>>> Thanks for your comment! And I agree that the Admin VQ should be considered before
>>>>>>>>> adding another device-specific control virtqueue.
>>>>>>>>>
>>>>>>>>> My understanding is that some of the inline encryption commands(get_crypto_modes/program key
>>>>>>>>> /derive_sw_secret/evict key) are runtime operations of a specific virtio-blk deivce.
>>>>>>>>> In particular, different virtio block devices may have different storage hardware sources
>>>>>>>>> of crypto modes, and keyslot programming and eviction are invoked through the block device's
>>>>>>>>> keyslot manager, and the programmed virtual keyslots are subsequently referenced by the
>>>>>>>>> encryption requests submitted on that device's request virtqueues. These commands are
>>>>>>>>> not about the management operation of device group.
>>>>>>>>>
>>>>>>>>> There is also a transport compatibility concern. The current virtio SPEC states that
>>>>>>>>> 'Devices and drivers utilizing Virtio Over MMIO do not support VIRTIO_F_ADMIN_VQ'.
>>>>>>>>> virtio MMIO is extensively used, so using the Admin VQ would make the feature unavailable
>>>>>>>>> for that transport unless the proposal also extended the MMIO transport.
>>>>>>>>>
>>>>>>>>> For these reasons, currently I believe that a virtio-blk control virtqueue is the better
>>>>>>>>> fit: it keeps the complete key lifecycle associated with the block device and remains
>>>>>>>>> usable across the transports required by the feature.
>>>>>>>>>
>>>>>>>>> I would appreciate any feedback or insights from you and Stefan on the V5 patch series
>>>>>>>>> posted for review before October ASAP.
>>>>>>>>>
>>>>>>>> Fundamentally, it does not make sense to force all vqs to be admin VQs.
>>>>>>>>
>>>>>>>> Admin vq would make sense if there is complex resource management going
>>>>>>>> on - like what is happening with all the flow control things in the
>>>>>>>> network device, since they have extensive functionality for managing
>>>>>>>> device resources.
>>>>>>>>
>>>>>>>> Random device specific commands - I am not sure we want that.
>>>>>>>> It remains to be proven.
>>>>>>> Admin vq was added for mgmt/control/admin/non-DATA_IO operations.
>>>>>>>
>>>>>>> Fundamentally, it does not make sense to force random device to create new control VQ since we already defined admin VQs for this purpose.
>>>>>>>
>>>>>>> We could have introduced control VQ on each device type, but we didn't.
>>>>>> Thanks for your comment!
>>>>>>
>>>>>> My concern is that these inline encryption commands are tightly coupled
>>>>>> to a specific virtio-blk device rather than providing generic administrative
>>>>>> functionality.
>>>>> We've all the needed plumbing in place in the AQ for device specific admin commands - see virtio-net specific admin commands.
>>>>>
>>>>>> GET_CRYPTO_MODES exposes capabilities of a particular block device, while
>>>>>> PROGRAM_KEY and EVICT_KEY operate on that device's keyslot manager. The
>>>>>> resulting virtual keyslots are then referenced directly by encryption requests
>>>>>> submitted on the same device's request VQs. The entire key lifecycle therefore
>>>>>> remains local to a single virtio-blk instance and its I/O path.
>>>>>>
>>>>>> My understanding is that Admin VQ was introduced primarily for device agnostic
>>>>>> commands. The GET_CRYPTO_MODES/PROGRAM_KEY/EVICT_KEY control commands appear to
>>>>>> be inherently virtio-blk-specific rather than a cross-device interface.
>>>>>>
>>>>>> There is also a transport consideration: VIRTIO_F_ADMIN_VQ is currently
>>>>>> unavailable for virtio-mmio, while the proposed control VQ approach remains
>>>>>> transport-independent.
>>>>> This limitation was introduced because we didn't want to add more noise when AQ was added (it was already a big change).
>>>>>
>>>>> Nothing really prevents adding AQ to mmio transport.
>>>>>
>>>>>> For these reasons, I currently believe a virtio-blk control VQ is the better
>>>>>> fit.
>>>>>>
>>>>>> I'm appreciated if you can give any feedback about it.
>>>>> I think that the correct path is AQ.
>>>>>
>>>>> Introducing another VQ type for the same purpose (mgmt cmds) seems weird and make device implementation harder.
>>>>>
>>>>> It is much harder to implement a new VQ type than a new opcode in the existing AQ.
>>>>>
>>>> Thanks for your comments!
>>>>
>>>> I agree that reusing the existing AQ avoids introducing another VQ type in virtio-blk.
>>> I'm glad that we're aligned on this one.
>>>
>>>> My concern is that AQ is currently not supported with virtio-mmio, and adding such
>>>> support appears to be significantly more involved than introducing a
>>>> virtio-blk-specific control VQ.
>>> I don't think that this is a good enough reason for introducing a new VQ type in Vblk.
>>>
>>> We need the best spec definition, one that will serve us for years to come, rather than worrying about 1-2 weeks of additional effort (to a task which is completely orthogonal for adding enc to vblk, IMO).
>> Thanks for the clarification.
>>
>> I still have one concern about using the Admin VQ here. Since the inline encryption
>> commands are specific to a particular virtio-blk device, how does the host
>> determine which virtio-blk device an Admin VQ command applies to?
> 
> Not sure what do you mean.
> 
> An admin virtqueue belongs to one virtio device (the owner), and every admin command carries
> a group_type and a group_member_id. The spec defines a Self group (group_type 0x0, member id 0x0)
> that contains the owner device itself and no other device.

Thanks for the clarification. I misunderstood this earlier.

> 
> 
>>
>> I couldn't find a host-side Admin VQ implementation, even for virtio-pci. Could you
>> please point me to an existing implementation or example for reference?
> 
> there are examples in Linux for AQ usage for LM and vNET special configs.
Thanks. I was specifically looking for a device-side/host-side implementation that
processes Admin VQ commands, e.g. in QEMU or crosvm, rather than the Linux driver-side
Admin VQ implementation. Is there an existing backend implementation that I could use
as a reference?

> 
>>
>>> The high level spec enhancements I envision are:
>>>
>>>    * Allow ADMIN_VQ on MMIO - Remove VIRTIO_F_ADMIN_VQ from the “reserved” MMIO list. Update the feature-bit text to align.
>>>    * Add two read-only registers to the MMIO register table, mirroring PCI’s admin_queue_index and admin_queue_num. They are valid only when ADMIN_VQ is negotiated. My suggested offsets are 0x0c4 and 0x0c8, which appear unassigned in my version.
>>>    * Reuse the existing queue flow. PCI’s rule refers to num_queues, which MMIO lacks. So either reword it as “admin index is above every regular queue index and index plus count stays within 0x10000”, or add a NumQueues register.
>>>    * State the Self-group scope - An MMIO owner device supports only group type 0x0. Other group types fail with INVALID_GROUP, following the existing validation rule.
>>>
>>>
>>>> Given this constraint, Admin VQ support in virtio MMIO will impact the inline
>>>> encryption support on virtio block, so, I prefer to the virtio-blk-specific
>>>> control VQ as this requirement is a more widely and general request, especially
>>>> in the virtualization platform with a Android guest virtual machine.
>>> This is not a constraint worth considering a non-optimal architecture.
>>>
>>> Creation of VQs takes device resources. We prefer not introducing new VQs if not needed. Adding a new opcode is more reasonable for your requirement.
>>>
>>> Imagine a block device with N resources for VQs: N-1 for request VQ and 1 for Admin VQ. If we need to introduce a new CVQ then it will be instead of one request VQ resource.
>> I agree that the new CVQ would take the place of one request VQ. For a virtio-blk
>> device with N VQs, this would leave N-2 request VQs, with one CVQ and one Admin VQ.
>>
>> I agree this is not ideal. However, if there is no way to handle these
>> block-device-specific commands through the Admin VQ, a dedicated CVQ seems necessary.
> 
> Anything you can do with the CVQ, you can also do with the AQ.
> 
>>
>>> I prefer having a correct architecture.
>>>
>>>
>>>>>>>> But generally why does this go on a special VQ? Is there a reason?
>>>>>>> Also in other related protocols the key mgmt goes throw a NON-IO Queue..
>>>>>>>
>>>>>>>
>>>>>>>> You define distinct request types seemingly and we are not short on types?
>>>>>>>>

