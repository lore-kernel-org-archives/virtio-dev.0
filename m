Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B7F395AED
	for <virtio-dev@lists.linux.dev>; Mon, 19 Oct 2026 03:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792379020; cv=none; b=m0okFE5J6zEDTQ8VWMok5pgDZ+WhtjA4vaDaEoRQIES8Pcf28x3fI13FL3JCvHQdHQ9m1LcNki5z2DJac489+0a/Z9bIy2Rggrk7NjZInKdbo8g3dQOjlLi0yXsuxpSNvgT2W905tlQc5/QXfCIBvZk0MpmOW2/kdXRCLAyaBSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792379020; c=relaxed/simple;
	bh=4AptzRFKChMI/tEZ1M+BCP6PbRzxeltwPZpAv2SdCcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=im+zjXQOXmG8aHVAglzCZ58FyvnkkETaRWz3eeybBtbp2ogmgBcHohhD19nGKNvVXG8Hx9udxqYWMLlR1hHwvIs1VGfBoIngG0m1rovlfrl8b20ZrcQGCrds7jwcz4E6yXLDYTU/AmUwrjKJ+BGUPu3fYskGJdHp60Y+8XMpMBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nuyrCb8+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U/quYNqd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nuyrCb8+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U/quYNqd"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J1FPS7422612
	for <virtio-dev@lists.linux.dev>; Mon, 19 Oct 2026 03:03:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HBVk+tEuQO5g8IlGHKXoR5Zkm1mSIztc8keN2DcAB+U=; b=nuyrCb8+XbDLoN1j
	3FSxfgyyQjfDPFjuKLnki7sDKL0dq/yoMCFMPLKVG5klm0cYqbbB7y0H3JmpPngh
	6JVQySC3vAJHfxhMh6qX/sZMxsyXvcvZg1AKP4zkO4cQWDjBNwTyk7erMG0MfiWM
	QZTSz6ah7ksWYozGzbfCBwf/RenMhln7EKQMgVV1elxm3DjF7k21VUXkVjcagh8B
	YKn46pGRGGNOJhh5M75NQt7ljJavygx321lV5I8u/nNLwJdm/hCH1IPkVl9UVgjb
	e2e+kAytCIaVf5p7l2jyw9ieimKoWSR0XUeRap2khGz/a9EtXV/+ZBvTGiJKw8Fn
	RGP02A==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc2a9me0a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Mon, 19 Oct 2026 03:03:37 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-33713e5e6daso2433033eec.0
        for <virtio-dev@lists.linux.dev>; Sun, 18 Oct 2026 20:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792379017; x=1792983817; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HBVk+tEuQO5g8IlGHKXoR5Zkm1mSIztc8keN2DcAB+U=;
        b=U/quYNqdODiyxCSIlHo8JOxbGVTvoksG4an75/wfBuhEZpATa1Mrqr6vhKcU5JKf4K
         +UW3hzvpUeD2h8dbaU/aXGO6/Yg+ejVyOhL9GAv3aT8LvniCi1aWgAodw+lo5N4TDdnn
         TRfoqv7HtYDzdTts5A0rEH9fpaKX9tDO5GIGqkewQ0kcMW9eW5GboPAsD0VFJIjH/q+M
         MCgZXlw1gDrHsI7L9PE9BHCQQKU3ztqFnLal/KmrMgp9bHefNLQrlvZJwjYdcM+4Xcim
         HLo0jy0ykR4ZdU7TEt0NMTrWtV40my8waoCawTfaL7tPejNAgVdFwrMmH5daJWNj0yz/
         e+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792379017; x=1792983817;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HBVk+tEuQO5g8IlGHKXoR5Zkm1mSIztc8keN2DcAB+U=;
        b=JLW6BZxokIrFi0pRtbfePWFVlvwHpX5EanhlRg3QNSQbY1l4tjepLmZ3sWOWolncZ+
         j7hfOXRkm0Eg+ukD3UfCa1IxKIQvekVBEn8lVKIglXa6ucM/t9AKlSfK2gbh0M0NxrN3
         vXytaca8JN87PL+n3uAPLZA0I48/foj3NitS4iu7spKNKkrLDiU3nVem7UG4HF5gRXoD
         hlceBs3pzwOXc4Dr13R1Wou9cwk12B+guuZx7qLdF+JOzlPIySOyz6jxz1T540FD6aVA
         0ymJz4wx8k5vB19KlVSLcPGk8I7xCy7yQtzQo56nHtgP4VvD6EouBssVNcU8pPy5gjMK
         9cug==
X-Gm-Message-State: AFq9FYJp88jKO044l6/+/cA1Ahydeuig9+QgEkmJbxedyBNvbfRJ4TYF
	sbgbW+tf5xA+1rikXeNgG2h5GcYk4uGhZ0qRFakT3aPBPH421qYi9Uafn2Map6lyBiBRIU40Fg/
	m/q6KkWwdlrDaFs3F2iTvk5vm5ywa8qCPf83sRQgORp+ihdQNFdzkhu85SgXNUCCl
X-Gm-Gg: AYBFou1TVCa8uKuPkzA+fsTOOaxglJDJ3DXKfQhy2pL4UgtES14vq42M/kHdma7dp5P
	En1oEO0U1lExMS6+Kinu4U2zYpSbo+2NQWaqrwe0gitWnvAPpgt9NYmflIYVI+i4T/4y+HVjLil
	19hViosyK+GCiEMD2qJ53aKUVezZe2ENz21i135SA65xF88wTQa102pP1Cy2Y1ok3YqBE4Qs9pl
	LUGbqE74h/bSwC1zSEIMYYUk07F2oTeEe9U0/oRFCNoeJx0rNqoEK9nIN4G3Ylqq3Ywj4Wt5Ytz
	pfXdIwjhUk8jjZrkzR4bTdNf5O7R4evzGcuxNFHEdwJHPcalURfXrAmtVpImTJ/82OyoP6NEvjZ
	GjjaB992Gd9ppuyPQ3N6QjiwoZQ1kJyFvLeFJ34vNBssfmajzu2zpEIvuMA==
X-Received: by 2002:a05:701b:4293:20b0:144:e535:3ef6 with SMTP id a92af1059eb24-18513b9800dmr10495268c88.41.1792379017155;
        Sun, 18 Oct 2026 20:03:37 -0700 (PDT)
X-Received: by 2002:a05:701b:4293:20b0:144:e535:3ef6 with SMTP id a92af1059eb24-18513b9800dmr10495232c88.41.1792379016456;
        Sun, 18 Oct 2026 20:03:36 -0700 (PDT)
Received: from [10.110.10.179] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831b75be5esm31764869c88.16.2026.10.18.20.03.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2026 20:03:36 -0700 (PDT)
Message-ID: <a9846956-4cdf-4aed-a477-1370850a2364@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 11:03:32 +0800
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] virtio-blk: Add the control virtqueue
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.linux.dev, stefanha@redhat.com, ebiggers@kernel.org,
        neeraj.soni@oss.qualcomm.com
References: <20260913161628.368484-1-linlin.zhang@oss.qualcomm.com>
 <20260913161628.368484-2-linlin.zhang@oss.qualcomm.com>
 <20261014054309-mutt-send-email-mst@kernel.org>
 <77cf6f89-99a3-42cc-a03f-ef61652f3eb4@oss.qualcomm.com>
 <20261016054749-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <20261016054749-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAxMSBTYWx0ZWRfX6IgZHTcSoBCc
 5EeT9t0GzY9KU/vF8KAFDA8MSLaXw6Z3R/Fn/Yl76YFU6jGf3V6Tpu8fuIiHtlmdtgT0aHjKwy4
 7SPj589H8iC6qt1wV9s8WTJlK+UXPN0=
X-Proofpoint-GUID: cyn4dH1OSNBse0ZMKcyNtHFb1KSiGuEM
X-Proofpoint-ORIG-GUID: cyn4dH1OSNBse0ZMKcyNtHFb1KSiGuEM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAxMSBTYWx0ZWRfX4PvKjjbMHxkd
 ATY56ac4EG1AXCmLWfWlb84WhPWTzJvHhoMqv/cNra8GkT4YAySLmeIeQYafMcwIUDTT83DROhN
 m7r+s+DQYmbv7u1HxLogD3BZGwoGS4DQh+eGXGrMjURF/j0qp+BBN+p7pV262eleI5BcVeEbfYy
 /UbUq9MVi8/9/jQs7p4c103k2FaSp84ig3MqLIVXNFKMSqVSudnjwMMVll3KgrGFp//t17ekmkh
 x1/TsVhv2UXPLFYtN8NLwuitcrAw5bRxK/a2fKN9U6qUK1i+3gfuQpOcuWNyyGPr69aE6yG2pnW
 oO9jiAhvOOu6cu93HzO97HavnHa57vYOtHzAyklGo3l8HWONoEiks3jYaSB/msYk4pzqo1nxCet
 7dDxS+TKRVih0lXSp8Sj3KY7bPAY8/P2Aa7AsV/vc8Fwg6eVTRTsSbxlm3y7S4018O/Rj+jlLH1
 ILLM5Rr5SQroro7AS3g==
X-Authority-Analysis: v=2.4 cv=PMeaavqC c=1 sm=1 tr=0 ts=6ad5888a cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=K5bLeLPIqTMYuDti20cA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190011



On 10/16/2026 5:48 PM, Michael S. Tsirkin wrote:
> On Fri, Oct 16, 2026 at 04:47:36PM +0800, Linlin Zhang wrote:
>>
>>
>> On 10/14/2026 5:43 PM, Michael S. Tsirkin wrote:
>>> On Sun, Sep 13, 2026 at 09:16:14AM -0700, Linlin Zhang wrote:
>>>> From: linlzhan <linlin.zhang@oss.qualcomm.com>
>>>>
>>>> Add VIRTIO_BLK_F_CTRL_VQ to advertise control virtqueue support.
>>>>
>>>> Define the control virtqueue location, driver queue discovery,
>>>> and common control request buffer layout. This provides a
>>>> standard framework for block-device control commands.
>>>>
>>>> Signed-off-by: linlzhan <linlin.zhang@oss.qualcomm.com>
>>>> ---
>>>>  device-types/blk/description.tex | 19 +++++++++++++++++++
>>>>  1 file changed, 19 insertions(+)
>>>>
>>>> diff --git a/device-types/blk/description.tex b/device-types/blk/description.tex
>>>> index 3b3a4e7..9bfdc4a 100644
>>>> --- a/device-types/blk/description.tex
>>>> +++ b/device-types/blk/description.tex
>>>> @@ -13,11 +13,16 @@ \subsection{Virtqueues}\label{sec:Device Types / Block Device / Virtqueues}
>>>>  \item[0] requestq1
>>>>  \item[\ldots]
>>>>  \item[N-1] requestqN
>>>> +\item[N] controlq, if VIRTIO_BLK_F_CTRL_VQ is negotiated
>>>>  \end{description}
>>>>  
>>>>   N=1 if VIRTIO_BLK_F_MQ is not negotiated, otherwise N is set by
>>>>   \field{num_queues}.
>>>>  
>>>> +If VIRTIO_BLK_F_CTRL_VQ is negotiated, the control virtqueue is appended
>>>> +after the request virtqueues. The control virtqueue is reserved for control
>>>> +requests defined by this specification.
>>>> +
>>>>  \subsection{Feature bits}\label{sec:Device Types / Block Device / Feature bits}
>>>>  
>>>>  \begin{description}
>>>> @@ -73,6 +78,8 @@ \subsection{Feature bits}\label{sec:Device Types / Block Device / Feature bits}
>>>>      VIRTIO_BLK_REQ_FLAG_OUT_FUA flag in the \field{flags} bitfield of the
>>>>      \field{virtio_blk_req} structure for VIRTIO_BLK_T_OUT requests.
>>>>  
>>>> +\item[VIRTIO_BLK_F_CTRL_VQ (22)] Device supports a control virtqueue.
>>>> +
>>>>  \end{description}
>>>>  
>>>>  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Block Device / Feature bits / Legacy Interface: Feature bits}
>>>> @@ -274,6 +281,9 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
>>>>  \item If the VIRTIO_BLK_F_MQ feature is negotiated, \field{num_queues} field
>>>>      can be read to determine the number of queues.
>>>>  
>>>> +\item If the VIRTIO_BLK_F_CTRL_VQ feature is negotiated, the driver MUST
>>>> +    identify the control virtqueue as queue N, after all request virtqueues.
>>>> +
>>>>  \item If the VIRTIO_BLK_F_SECURE_ERASE feature is negotiated,
>>>>      \field{max_secure_erase_sectors} and \field{max_secure_erase_seg} can be read
>>>>      to determine the maximum secure erase sectors and maximum number of
>>>> @@ -327,6 +337,10 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
>>>>  The driver MUST NOT negotiate VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA without
>>>>  VIRTIO_BLK_F_REQ_FLAGS.
>>>>  
>>>> +If the VIRTIO_BLK_F_CTRL_VQ feature is negotiated, the driver MUST NOT submit
>>>> +any request to the control virtqueue unless the request is defined by this
>>>> +specification.
>>>> +
>>>>  \devicenormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
>>>>  
>>>>  Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it
>>>> @@ -454,6 +468,11 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>>>>  };
>>>>  \end{lstlisting}
>>>>  
>>>> +Control virtqueue requests consist of a type field in an output buffer,
>>>> +followed by an optional command-specific output buffer, an optional
>>>> +command-specific input buffer, and a status byte in an input buffer. The
>>>> +type field and status byte MUST each be in their own buffer.
>>>> +
>>>>  The type of the request is either a read (VIRTIO_BLK_T_IN), a write
>>>>  (VIRTIO_BLK_T_OUT), a discard (VIRTIO_BLK_T_DISCARD), a write zeroes
>>>>  (VIRTIO_BLK_T_WRITE_ZEROES), a flush (VIRTIO_BLK_T_FLUSH), a get device ID
>>>
>>> let the driver control buffering.
>>> you want the status as 1st byte of input. Then driver can separate
>>> it in a buffer of its own.
>>
>> Thanks, that makes sense.
>>
>> I'll re-word it as the following:
>>
>>   - Control virtqueue requests consist of a type field followed by optional
>>     command-specific device-readable data, and a status byte followed by
>>     optional command-specific device-writable data.
> 
> ok
> 
>>     The status byte MUST be the first byte of the device-writable portion of the request.
> 
> not that informative and stuff like this belongs in a conformance
> section anyway. 

Thanks! ACK

> 
>>>
>>>> -- 
>>>> 2.34.1
>>>>
>>>
> 

