Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F6A3E49CD
	for <virtio-dev@lists.linux.dev>; Mon, 19 Oct 2026 09:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792401856; cv=none; b=S0IihX4kkakeihZGVfJe+p27uBV6rnq5QnfXnApS8L8uDWV8g3BgmgumB3ewIidu4xL8tQRx2UefS0YScGpZarEPV28RsoLrN0kiUrn8dfeo466CQgyHD5Uf7+/OcU1Yi2+Ah5LEfZQJPNbGsPG97df0eaOaMavfzqIAq6rOOY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792401856; c=relaxed/simple;
	bh=qRJePBwOoGCZG5pVrNTriqjMCPamNU4+UCRKiFyf3gg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZZj4emRDjSBCDsZWOZwmVVlTkSWJ1+A+2OE3sdr2bRhQJp2UupSrbmmUEfqdFpzykcdy5/fBAxepoCNboNntG8q7h4QZQsWwoxUiA7eAnVfAORapr9vcWLyPqee391OpDHqpGYNg1glU9h90/iGX0kN1r0HDV0NVQMytdwd2tAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ClkwjQXQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d+ciDWBA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ClkwjQXQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d+ciDWBA"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8P7lI1896620
	for <virtio-dev@lists.linux.dev>; Mon, 19 Oct 2026 09:24:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ay1F+/c73s3zy1ib3A6h1vaEHHVkaQJXvbgTkG55Ibc=; b=ClkwjQXQj/F1v6rA
	qIKjt9R3G+hje7J7byU2PEWjDnJ4ZatT9YvWDqBykvXYIP9l5iOb2NiRY4rFoMA4
	3nKaDgfGQM4ssSVsvPrx4jQqL3XKKRAkVyYrWsk0TjYDr16Hq0hCZOiLjkBN+90z
	8LsLZ+3EZ3t8Ok2+vnswMy6p70ERPi7xT8GnKTlUtguz6TbwcD6fji0DqXss9w8I
	2Tx8sfJua7+CYWahGZt8dHrXBk3zOLs9UR0Qr+xvQsUU3zxPoBl8865zdl1rqfxn
	Tb6UKieH+nVAYJumhxYfUrU68YiK7TK90a5nc2UP1Edf5ldjJNzC456nTB5Emb8S
	C0/TGQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdbvr95vt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Mon, 19 Oct 2026 09:24:13 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-341eff9e381so6010893eec.1
        for <virtio-dev@lists.linux.dev>; Mon, 19 Oct 2026 02:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792401852; x=1793006652; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ay1F+/c73s3zy1ib3A6h1vaEHHVkaQJXvbgTkG55Ibc=;
        b=d+ciDWBACI+hCtn1OkW3WOD56YCzGSPuTIhCh6Jn2H3dpT9o9bIpMDtQhAGqiNb7nM
         zpqM43JUnpN7qy1paBNgenCEG1rMDxcQTp5Zfsk3dJGe6WguO/c/1nj6FtR+O+iTMg82
         NjfleJu6NJz+bMH9ZZlL2lNBQPRV8gpS2QTQsrGTqb37i0WigAFGeUFMSv7f3G8KlviF
         M3OZKjT6jiDe7g2Bo1WjlutPKn32O6WVLexPfEHymtFMgfZltXIdDxqTN/pBmMf7YF8Y
         mxfl1v21X0dGqkBrT/R28rUdIVbm4bylevy8xto2jx/FgZaAXD8pG7eZitJILJcaSvrC
         qZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792401852; x=1793006652;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ay1F+/c73s3zy1ib3A6h1vaEHHVkaQJXvbgTkG55Ibc=;
        b=0hCCKfp2rCsoTBjbtOzTexTIZ8IU0ZdlL+EixaQSzdwf55CwerLy/8nWr+ZEWpRHF9
         fYzJaaTbN8cXLaG3DkoflBmEoaxqg0ShuKoIWEQdhkvwEcF7/M4F6SsSixCcjT09RrIX
         9DC5KkD9b6sseEoMOlsCW5fcpqW4IE+cVa9fQywEvGW5+1A9nsViNkkhttCPlXjMh4/o
         a39eUwezYkPFV80GWplvKeI7K8Fl8fQ/w+z64h+vj5Jswkbqn5a6yHUfeDjwFRaTfWKQ
         x7CjvwmPVCsEgBmDuov9Ex1xBIYW6PECDa0ObU7DWh4sJKbt4+qucxz936oaFhiy9/AO
         v/Hw==
X-Forwarded-Encrypted: i=1; AKwUvBwpFsB6nyWlgA3WoCN72OO0tMI2QoxrxYQjixbfn6A1ZLIde6NAwvgV5OK3+OF5ioNOwHtFyuGrG0m3@lists.linux.dev
X-Gm-Message-State: AFq9FYKUk95mZ9d+SF65pmLFCw5LtiTNJjQzx1WZyhzZRHcgA9VNxu+a
	8Mnm1OgjXIcKgoSrzYHboD9PAvV4u8e+5yK0USN35aLcWnm4d8ZYgJo1vmGU8i5vi1Sx18DPB+k
	KDRJuc8bXSI/q22nCSfbjrlrdY4yCePByCoydBeZ/mXIScc28/S098Pvbvp2/+oFM
X-Gm-Gg: AYBFou0MOt1A7MVh5pqgEjjxpXtj0RJIxed5qD0+HdFpd8aTJxO9b2b+vvnO2tJuveT
	m731lJcf0sSbZdjwAa6+GzUwCl7PwCpLC1SYc5FboD4GYEfofkru5HN1PFA8Z8t50l5lILwMHtS
	S8L5QyEPTT53Vm4BYWwfw9NqZbyhzH0Und/9LSun6HvMkj8OVU678Kil4lPoMj7zZ2Iq39rYO+A
	u/7XWPydjM3lkA4CB/92LR5j5ROoxi6WU47ZUtsmFogUbmfVfu0NeKROHzbtbpMEH6Hk/F1g67G
	nWU2kOvsMx8JfOjzLXYI3KOaba9eNMDAwJRtrPhiPjgpQqcA++GaTEKBYDCc5lutBAuE3kaQxHt
	Nz/DdWrAeZ2yF8CPQzTA1mS3RN2PTxt5OigJv4OROMgF7XpE/y8nAEzvr
X-Received: by 2002:a05:7301:4b14:b0:354:1db3:674e with SMTP id 5a478bee46e88-361a1370a53mr11229637eec.6.1792401851744;
        Mon, 19 Oct 2026 02:24:11 -0700 (PDT)
X-Received: by 2002:a05:7301:4b14:b0:354:1db3:674e with SMTP id 5a478bee46e88-361a1370a53mr11229585eec.6.1792401850903;
        Mon, 19 Oct 2026 02:24:10 -0700 (PDT)
Received: from [10.110.10.179] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360819be413sm30792731eec.13.2026.10.19.02.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 02:24:10 -0700 (PDT)
Message-ID: <a78eab07-9192-4725-905e-6f38d7fbac85@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 17:24:06 +0800
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
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
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <0b6fa40c-5a79-4047-9c20-d5c83dc7ee6c@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzNyBTYWx0ZWRfX0m4zzIrYwgcw
 hm0e6yXZyqG6vRidrvX3rZUV//dSxxoY0ie4BYA3Om793uzIvZa7MH0T2DFZBF7uYh2Klk83Xbd
 RqHBwV5H6qk/JDklifT+aKOYWSiblawdfZzPCW3VUuuyTmPW9Yqn6QeG6788C0MLBQcgFN72Jr5
 3NDHX5rmbMWSncwsJLnBzXHF02Eqt/dbB4YENvzdZtruucoOh2lYWTGdi+avXgUrHu1RwBOIMAR
 +grJKvecjfSfrhpulmoahNKkVWavgZBQmwMzHrwMZ+fCHpZh9gr698KE3rD7XWh44d0oE/IAG+y
 qXIVCQxZDnsjDRHqfNVQ/mTIerdh5Xx5u3LtyOT2etvbB+44lQaAlDs/fUt+XqE2lyNnC0n+Jye
 Wa9USFDeg/u02L5J+UH31VF0ZudvsBRMFc1zprigB1wF1jvMnjYr98nkpXq0LirZp2bAZGQB4iS
 vEDHChyjFu8euVO8tIQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzNyBTYWx0ZWRfX76B976U4hosf
 9anSQjjSXAY1aPlWCvn/BxWjQ7jqfPOklGf2EM7N8thMGsfvMXwynEGggE2DfSrP96zJanFIMip
 Q9HidSDKLefGvKrhRahRDme1CAV5Lg4=
X-Proofpoint-GUID: _Rl4Xv_di8YS1vETAhpOcwf7ZCS9OWd0
X-Authority-Analysis: v=2.4 cv=K/+3jCWI c=1 sm=1 tr=0 ts=6ad5e1bd cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=z9A-GKh4SWetKA3jWV4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: _Rl4Xv_di8YS1vETAhpOcwf7ZCS9OWd0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190037



On 10/15/2026 8:01 PM, Max Gurtovoy wrote:
> 
> On 15/10/2026 14:19, Linlin Zhang wrote:
>> On 10/14/2026 2:07 AM, Max Gurtovoy wrote:
>>> On 13/10/2026 19:23, Linlin Zhang wrote:
>>>> On 10/13/2026 7:12 AM, Max Gurtovoy wrote:
>>>>> On 08/10/2026 13:15, Michael S. Tsirkin wrote:
>>>>>> On Thu, Oct 08, 2026 at 05:17:30PM +0800, Linlin Zhang wrote:
>>>>>>> On 9/30/2026 6:46 AM, Max Gurtovoy wrote:
>>>>>>>> On 24/09/2026 12:35, Linlin Zhang wrote:
>>>>>>>>> On 9/22/2026 9:14 PM, Stefan Hajnoczi wrote:
>>>>>>>>>> On Tue, Sep 22, 2026 at 12:29:37PM +0800, Linlin Zhang wrote:
>>>>>>>>>>> On 9/18/2026 5:08 AM, Stefan Hajnoczi wrote:
>>>>>>>>>>>> On Sun, Sep 13, 2026 at 09:16:13AM -0700, Linlin Zhang wrote:
>>>>>>>>>>>>> From: linlzhan <linlin.zhang@oss.qualcomm.com>
>>>>>>>>>>>>>
>>>>>>>>>>>>> This series adds virtio-blk inline encryption support for devices backed
>>>>>>>>>>>>> by storage hardware with an inline crypto engine.
>>>>>>>>>>>>>
>>>>>>>>>>>>> The protocol exposes device capabilities such as keyslot count, maximum
>>>>>>>>>>>>> DUN size, and supported key types. Encrypted requests identify a
>>>>>>>>>>>>> provisioned keyslot and carry a 256-bit DUN. Key management and crypto
>>>>>>>>>>>>> capability discovery use the block device control virtqueue.
>>>>>>>>>>>>>
>>>>>>>>>>>>> The control virtqueue is defined as a generic framework so that its
>>>>>>>>>>>>> buffer layout and queue placement are independent of any particular
>>>>>>>>>>>>> control command. Inline encryption then builds on this framework with
>>>>>>>>>>>>> explicit crypto command formats, capability validation, and keyslot
>>>>>>>>>>>>> state semantics.
>>>>>>>>>>>>>
>>>>>>>>>>>>> All key related operatios are handled in the control virtqueue, and
>>>>>>>>>>>>> the crypto I/O request is handled in the request queue.
>>>>>>>>>>>>>
>>>>>>>>>>>>> For background on inline encryption in UFS and eMMC storage, see:
>>>>>>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/block/inline-encryption.rst
>>>>>>>>>>>>>
>>>>>>>>>>>>> changes in v3:
>>>>>>>>>>>>>     - Add a control virtqueue
>>>>>>>>>>>>>     - Move key program/evict/derive_sw_secret/generate/prepare/import to
>>>>>>>>>>>>>       the control virtqueue
>>>>>>>>>>>> Thank you. This was a big change, especially if you already have an
>>>>>>>>>>>> implementation. I appreciate it!
>>>>>>>>>>>>
>>>>>>>>>>>> My main feedback is that the new control virtqueue commands are not yet
>>>>>>>>>>>> documented in enough detail so that implementors could implement them.
>>>>>>>>>>>> Once you've decided on the precise semantics, error codes, etc and added
>>>>>>>>>>>> them to the spec, then this will round off the inline encryption
>>>>>>>>>>>> feature. I look forward to reviewing that in the future.
>>>>>>>>>>>>
>>>>>>>>>>> Thanks a lot for your comment!
>>>>>>>>>>>
>>>>>>>>>>> Would you please help clarify what the precise semantics are about? detail
>>>>>>>>>>> introduction of the filed in the inline encryption control command struct?
>>>>>>>>>>> like struct virtio_blk_crypto_key_desc?
>>>>>>>>>> By precise semantics, I mean specifying not just the constants and
>>>>>>>>>> structs, but documenting what each command does and how it can fail.
>>>>>>>>>> Each of the key slot programming commands needs this. There should be at
>>>>>>>>>> least one paragraph for each of VIRTIO_BLK_T_CRYPTO_KEYSLOT_PROGRAM,
>>>>>>>>>> VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT, VIRTIO_BLK_T_CRYPTO_DERIVE_SW_SECRET,
>>>>>>>>>> VIRTIO_BLK_T_CRYPTO_GENERATE_KEY, VIRTIO_BLK_T_CRYPTO_IMPORT_KEY, or
>>>>>>>>>> VIRTIO_BLK_T_CRYPTO_PREPARE_KEY.
>>>>>>>>>>
>>>>>>>>>> For example:
>>>>>>>>>>
>>>>>>>>>> The VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT command empties a key slot so that
>>>>>>>>>> key information is removed and the key slot cannot be used until it is
>>>>>>>>>> programmed again. The key slot index is specified by struct
>>>>>>>>>> virtio_blk_crypto_key_desc \field{slot} and all other fields in the
>>>>>>>>>> struct are ignored. The command succeeds with VIRTIO_BLK_S_OK if the key
>>>>>>>>>> slot index is valid, including if the slot is already empty. If the key
>>>>>>>>>> slot index is invalid, the command fails with VIRTIO_BLK_S_IOERR.
>>>>>>>>>>
>>>>>>>>>> Stefan
>>>>>>>>> Thanks for the clear example.
>>>>>>>>>
>>>>>>>>> I'll follow the same approach and add explicit normative semantics for
>>>>>>>>> all inline encryption control requests.
>>>>>>>> Can you please explain why we need to introduce yet another VQ type for control?
>>>>>>>>
>>>>>>>> We've added the Admin VQ as a generic VQ for control operations — I'm not sure why it isn't sufficient.
>>>>>>>>
>>>>>>>> Adding control VQ to each device type seems strange to me after adding a generic Admin VQ.
>>>>>>> Thanks for your comment! And I agree that the Admin VQ should be considered before
>>>>>>> adding another device-specific control virtqueue.
>>>>>>>
>>>>>>> My understanding is that some of the inline encryption commands(get_crypto_modes/program key
>>>>>>> /derive_sw_secret/evict key) are runtime operations of a specific virtio-blk deivce.
>>>>>>> In particular, different virtio block devices may have different storage hardware sources
>>>>>>> of crypto modes, and keyslot programming and eviction are invoked through the block device's
>>>>>>> keyslot manager, and the programmed virtual keyslots are subsequently referenced by the
>>>>>>> encryption requests submitted on that device's request virtqueues. These commands are
>>>>>>> not about the management operation of device group.
>>>>>>>
>>>>>>> There is also a transport compatibility concern. The current virtio SPEC states that
>>>>>>> 'Devices and drivers utilizing Virtio Over MMIO do not support VIRTIO_F_ADMIN_VQ'.
>>>>>>> virtio MMIO is extensively used, so using the Admin VQ would make the feature unavailable
>>>>>>> for that transport unless the proposal also extended the MMIO transport.
>>>>>>>
>>>>>>> For these reasons, currently I believe that a virtio-blk control virtqueue is the better
>>>>>>> fit: it keeps the complete key lifecycle associated with the block device and remains
>>>>>>> usable across the transports required by the feature.
>>>>>>>
>>>>>>> I would appreciate any feedback or insights from you and Stefan on the V5 patch series
>>>>>>> posted for review before October ASAP.
>>>>>>>
>>>>>> Fundamentally, it does not make sense to force all vqs to be admin VQs.
>>>>>>
>>>>>> Admin vq would make sense if there is complex resource management going
>>>>>> on - like what is happening with all the flow control things in the
>>>>>> network device, since they have extensive functionality for managing
>>>>>> device resources.
>>>>>>
>>>>>> Random device specific commands - I am not sure we want that.
>>>>>> It remains to be proven.
>>>>> Admin vq was added for mgmt/control/admin/non-DATA_IO operations.
>>>>>
>>>>> Fundamentally, it does not make sense to force random device to create new control VQ since we already defined admin VQs for this purpose.
>>>>>
>>>>> We could have introduced control VQ on each device type, but we didn't.
>>>> Thanks for your comment!
>>>>
>>>> My concern is that these inline encryption commands are tightly coupled
>>>> to a specific virtio-blk device rather than providing generic administrative
>>>> functionality.
>>> We've all the needed plumbing in place in the AQ for device specific admin commands - see virtio-net specific admin commands.
>>>
>>>> GET_CRYPTO_MODES exposes capabilities of a particular block device, while
>>>> PROGRAM_KEY and EVICT_KEY operate on that device's keyslot manager. The
>>>> resulting virtual keyslots are then referenced directly by encryption requests
>>>> submitted on the same device's request VQs. The entire key lifecycle therefore
>>>> remains local to a single virtio-blk instance and its I/O path.
>>>>
>>>> My understanding is that Admin VQ was introduced primarily for device agnostic
>>>> commands. The GET_CRYPTO_MODES/PROGRAM_KEY/EVICT_KEY control commands appear to
>>>> be inherently virtio-blk-specific rather than a cross-device interface.
>>>>
>>>> There is also a transport consideration: VIRTIO_F_ADMIN_VQ is currently
>>>> unavailable for virtio-mmio, while the proposed control VQ approach remains
>>>> transport-independent.
>>> This limitation was introduced because we didn't want to add more noise when AQ was added (it was already a big change).
>>>
>>> Nothing really prevents adding AQ to mmio transport.
>>>
>>>> For these reasons, I currently believe a virtio-blk control VQ is the better
>>>> fit.
>>>>
>>>> I'm appreciated if you can give any feedback about it.
>>> I think that the correct path is AQ.
>>>
>>> Introducing another VQ type for the same purpose (mgmt cmds) seems weird and make device implementation harder.
>>>
>>> It is much harder to implement a new VQ type than a new opcode in the existing AQ.
>>>
>> Thanks for your comments!
>>
>> I agree that reusing the existing AQ avoids introducing another VQ type in virtio-blk.
> 
> I'm glad that we're aligned on this one.
> 
>> My concern is that AQ is currently not supported with virtio-mmio, and adding such
>> support appears to be significantly more involved than introducing a
>> virtio-blk-specific control VQ.
> 
> I don't think that this is a good enough reason for introducing a new VQ type in Vblk.
> 
> We need the best spec definition, one that will serve us for years to come, rather than worrying about 1-2 weeks of additional effort (to a task which is completely orthogonal for adding enc to vblk, IMO).

Thanks for the clarification.

I still have one concern about using the Admin VQ here. Since the inline encryption
commands are specific to a particular virtio-blk device, how does the host
determine which virtio-blk device an Admin VQ command applies to?

I couldn't find a host-side Admin VQ implementation, even for virtio-pci. Could you
please point me to an existing implementation or example for reference?

> 
> The high level spec enhancements I envision are:
> 
>   * Allow ADMIN_VQ on MMIO - Remove VIRTIO_F_ADMIN_VQ from the “reserved” MMIO list. Update the feature-bit text to align.
>   * Add two read-only registers to the MMIO register table, mirroring PCI’s admin_queue_index and admin_queue_num. They are valid only when ADMIN_VQ is negotiated. My suggested offsets are 0x0c4 and 0x0c8, which appear unassigned in my version.
>   * Reuse the existing queue flow. PCI’s rule refers to num_queues, which MMIO lacks. So either reword it as “admin index is above every regular queue index and index plus count stays within 0x10000”, or add a NumQueues register.
>   * State the Self-group scope - An MMIO owner device supports only group type 0x0. Other group types fail with INVALID_GROUP, following the existing validation rule.
> 
> 
>> Given this constraint, Admin VQ support in virtio MMIO will impact the inline
>> encryption support on virtio block, so, I prefer to the virtio-blk-specific
>> control VQ as this requirement is a more widely and general request, especially
>> in the virtualization platform with a Android guest virtual machine.
> 
> This is not a constraint worth considering a non-optimal architecture.
> 
> Creation of VQs takes device resources. We prefer not introducing new VQs if not needed. Adding a new opcode is more reasonable for your requirement.
> 
> Imagine a block device with N resources for VQs: N-1 for request VQ and 1 for Admin VQ. If we need to introduce a new CVQ then it will be instead of one request VQ resource.

I agree that the new CVQ would take the place of one request VQ. For a virtio-blk
device with N VQs, this would leave N-2 request VQs, with one CVQ and one Admin VQ.

I agree this is not ideal. However, if there is no way to handle these
block-device-specific commands through the Admin VQ, a dedicated CVQ seems necessary.

> 
> I prefer having a correct architecture.
> 
> 
>>>>>> But generally why does this go on a special VQ? Is there a reason?
>>>>> Also in other related protocols the key mgmt goes throw a NON-IO Queue..
>>>>>
>>>>>
>>>>>> You define distinct request types seemingly and we are not short on types?
>>>>>>

