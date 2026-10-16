Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5834190462
	for <virtio-dev@lists.linux.dev>; Fri, 16 Oct 2026 08:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792140466; cv=none; b=FuN0IOnHeSnt+YBA/zCj0UjKr+GgUdJr7JFHwVjgheOTfjJUrPRhkTjAOxfarTk9Z2WmkPd1yqQ90WHQgrKNmOcp4Zz4V1YVVyx2+YefBf2bVdYOQXPgOPCMAumYeQDgOqY7iC+uTBSv8PryQgTjm4uEeQGhViP7wjN1L6yYnvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792140466; c=relaxed/simple;
	bh=TY4HkB53w5LNIJ4b1cvwKGu9JS+BNkrywmXuFj8u9sk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DK2WanyD+gJz1ARAPiIAxp0fbcZ6j3fXrk6DgXYRXDkM0gcXlHq7wwzVeBmimOTxzMRBXDvFxAuTr2baC+BPVidOS4/uG0BI9Ilg+dMBt/fIuIRL5k1xPBrueCh90SprPYZr95k/iTrNR8OSQwj5OXP8efWa7CHGKKGG68kAZro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jP2wW5cz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U9jBQnKj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jP2wW5cz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U9jBQnKj"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69G8lel01218650
	for <virtio-dev@lists.linux.dev>; Fri, 16 Oct 2026 08:47:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PhJdt6ngwtOi6fr3EGh69VsFGSPCRVWXVOlU8kGTBrQ=; b=jP2wW5czJLHuhan7
	6Z7lOvp9SSAN+cSL5x+OzZQMxPl3dDpTml+1Ve988xx24ffE8s0bahaI6hBzIljU
	yNQVyMfzhaiCFi2qVNHd6oHSWIach6zkx6mq7eLpZqh5WHHSkY/7IIon5Ir6rxVs
	H27tWBTZT31J+YFFc+GF0GfKxPlaaJyh7o9b63YK8VelgrFPwiJr+Byt94oKTUox
	6FtiJ0gB/B2+/GvqPQ4UDwhM6D5h8rbpQZ8TSl5dAXJ4dXTY6gVgkJQRE36NXnwX
	+Lxb2x12NelDQ4+yX2TUK8n6YH5suwbL7NuF1Zq/6saImWfg0k0PI+mvlKEhovdI
	jE67ow==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb5sead58-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Fri, 16 Oct 2026 08:47:43 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-35a04491c56so785022eec.0
        for <virtio-dev@lists.linux.dev>; Fri, 16 Oct 2026 01:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792140463; x=1792745263; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PhJdt6ngwtOi6fr3EGh69VsFGSPCRVWXVOlU8kGTBrQ=;
        b=U9jBQnKjqsTNyaSBHeeRl95ZSQmT1dKcDcK1CRGC5n9CwhDaqH3I2bN7Zy3dg33bt8
         Zw98YaS8MDiD0Oseeixz693zqgbgeCHYED527Qi2azuHTf7rQJcrrPQozo1IsUDbyW9u
         SoIrTUhcdXnMqCknH6FSPVxT/JegqUqmstiC1Szo0viDLnu+DvXYbi+BzaCo11g31709
         Y5C09xhPzW4S/6X6PuEJ7jkxQGWo2LL9gYys4bmi8gVSGh5BiNtDt69SNyC0B151j8I4
         qsGsdw/9FSChXPUwQyfO453nnUeH90+ytdjXZ1whTlVoDdOpLoIgByBmrdDfXcQoXa34
         EnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792140463; x=1792745263;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PhJdt6ngwtOi6fr3EGh69VsFGSPCRVWXVOlU8kGTBrQ=;
        b=kWueN1FidUGB5eIufde2GGdWby3SqdkBHgjI+tWO54kvLVJv6GgMYi0qdgt0BwG72B
         05/nTVV/CwNuCO6nl9YL0djsn/AI4r6LCnt1909g7exLwPxjebi+r4mYm9a4TsxKrFoV
         FQwgpIznV8vVCnChIn9ZPAeQkVmgxGJR0MZwaCD5VkfJ1HaZ+YxbSuO9f1XLtNpJOWKp
         IBSCVtBjXwxXZTc1l1I8+HSbyPZuIjhM+5chhoZ2bxaua1vYSStfvbRxkHn7Lqe15k9l
         hUdT6muaCP7hknrHKoqs1duo/P7zzKd2Er1C1qA6DziZnG3Lgr2ofnC23Q6zOPiUUwW2
         V0Qw==
X-Gm-Message-State: AFq9FYLZrEJBv8MP2YQm2iEtNl/V+fmZKNKI87LoOTW3ugJD/SWYfF0p
	nVkEQCIGUENcL8PVwV8wwpPPd8GcN5eXSb6egqXL7ACQSKKkIXvcp6uAOwsS2PszgS2Xk/RRBVC
	hgDJVOywlw0EKLMCFjJO3GII7H9R2sF2gV31yQhs9YCTg06ZQZzcKGZazYsdhqFNa
X-Gm-Gg: AYBFou2zCWfV8XZZnnV86ZdGwLYt4+HLgPPpPqdIldwf7PXo0BTTDgTGjoHw7izCo/O
	1Ayqy5V0V16qNWwBUQq4cfJ4cYbA0sPtimifZJ8gcWqWmH1qV4PGpJuNLWfqND61o2cqzPPEqo7
	Aj8XTka9N6YVF91PmPgMju+3BlaQnEZm5Ov6m7Or6anNdoETEtc5hcEc6qBGu8gmezyERJsuYWX
	tQHOi94ZZr87amCRGM/BmLcECLju7ogrntUq16Pb6/IBpymVg4t2iYphwqtsYkxY/e3bPfb1d0f
	Rlr0gU5jgSUC51AB2u5TX1YvbplJRWwGNJCpT2f7NeLUdGTQA6xRCsa3iAkCeskU+xNDwohXfh9
	3lCyCwNIeGWKGQ7r8Qe+/0keI01PTgGyonUQhTOfykj+Wl1X9Pa2s9ig=
X-Received: by 2002:a05:693c:41c3:10b0:35c:3057:5ff2 with SMTP id 5a478bee46e88-3602d6e5cf7mr3334720eec.9.1792140462919;
        Fri, 16 Oct 2026 01:47:42 -0700 (PDT)
X-Received: by 2002:a05:693c:41c3:10b0:35c:3057:5ff2 with SMTP id 5a478bee46e88-3602d6e5cf7mr3334579eec.9.1792140460645;
        Fri, 16 Oct 2026 01:47:40 -0700 (PDT)
Received: from [10.110.79.67] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36081ab80f9sm8067504eec.12.2026.10.16.01.47.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 01:47:40 -0700 (PDT)
Message-ID: <77cf6f89-99a3-42cc-a03f-ef61652f3eb4@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 16:47:36 +0800
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
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <20261014054309-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAzNCBTYWx0ZWRfX9+dGet0o2Iud
 FuZN+c/ZmpgppcWSRQTM//TUZKShEJAe2TakBo4qja/RGQI2xmJViPdwe0oH8/Z6z/7LhZl2sZH
 WEBbLKVv1iHiMHSRIM0H2U7d3VVFB2g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAzNCBTYWx0ZWRfXymBQ37KCbrTq
 KYxs3YKN3xxEyk6sSSYem+g+veRIOF2cvqt+4H/b04QpxTXOlXPR50fpObZKZKXj6CvMVMr0Qoe
 w0IHztNvD1jbG+0cR4G22lgrBDe6fmnYW6uUJBi7BmJZLQ7qOTj2SSG5bSSaDiyJLpvpiBywgRv
 hy6RGt2xNkFXN/aulWf7GqPHweeUQMo3FYfy5U8FczFQyhk2DlNuq8HU9YWDyqlhY5t0HLgCMSu
 fQ4xZlrD/Wp7fzuthKReiCMTLCNpY4EXssC0YvMPIXH5VZjnHUNlhX6JrkVhlxFEdcjRTe/p6Vz
 EHUFROUkwmLeWVh0rA7o/hmwY2XfwFQIt4BedTUHNUPE9N4EbHv5CIlo0M+DFC68bd0O3CxgOfE
 Kp4CZIGJNLckJSwiNQ9gGXFlFAoNkAlJIPevvF7LJ8peCnw79k/jcv0HFvjIULB6oT/1ClGa+EI
 3WVpnUGCcqgF2MuOPvw==
X-Authority-Analysis: v=2.4 cv=P4yvFSAu c=1 sm=1 tr=0 ts=6ad1e4af cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=H_xFf_Ocx2Jaw7HwKOoA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: _fdfQIQZHHPq-M34BFYA12yhQsuJZ-Gs
X-Proofpoint-GUID: _fdfQIQZHHPq-M34BFYA12yhQsuJZ-Gs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160034



On 10/14/2026 5:43 PM, Michael S. Tsirkin wrote:
> On Sun, Sep 13, 2026 at 09:16:14AM -0700, Linlin Zhang wrote:
>> From: linlzhan <linlin.zhang@oss.qualcomm.com>
>>
>> Add VIRTIO_BLK_F_CTRL_VQ to advertise control virtqueue support.
>>
>> Define the control virtqueue location, driver queue discovery,
>> and common control request buffer layout. This provides a
>> standard framework for block-device control commands.
>>
>> Signed-off-by: linlzhan <linlin.zhang@oss.qualcomm.com>
>> ---
>>  device-types/blk/description.tex | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/device-types/blk/description.tex b/device-types/blk/description.tex
>> index 3b3a4e7..9bfdc4a 100644
>> --- a/device-types/blk/description.tex
>> +++ b/device-types/blk/description.tex
>> @@ -13,11 +13,16 @@ \subsection{Virtqueues}\label{sec:Device Types / Block Device / Virtqueues}
>>  \item[0] requestq1
>>  \item[\ldots]
>>  \item[N-1] requestqN
>> +\item[N] controlq, if VIRTIO_BLK_F_CTRL_VQ is negotiated
>>  \end{description}
>>  
>>   N=1 if VIRTIO_BLK_F_MQ is not negotiated, otherwise N is set by
>>   \field{num_queues}.
>>  
>> +If VIRTIO_BLK_F_CTRL_VQ is negotiated, the control virtqueue is appended
>> +after the request virtqueues. The control virtqueue is reserved for control
>> +requests defined by this specification.
>> +
>>  \subsection{Feature bits}\label{sec:Device Types / Block Device / Feature bits}
>>  
>>  \begin{description}
>> @@ -73,6 +78,8 @@ \subsection{Feature bits}\label{sec:Device Types / Block Device / Feature bits}
>>      VIRTIO_BLK_REQ_FLAG_OUT_FUA flag in the \field{flags} bitfield of the
>>      \field{virtio_blk_req} structure for VIRTIO_BLK_T_OUT requests.
>>  
>> +\item[VIRTIO_BLK_F_CTRL_VQ (22)] Device supports a control virtqueue.
>> +
>>  \end{description}
>>  
>>  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Block Device / Feature bits / Legacy Interface: Feature bits}
>> @@ -274,6 +281,9 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
>>  \item If the VIRTIO_BLK_F_MQ feature is negotiated, \field{num_queues} field
>>      can be read to determine the number of queues.
>>  
>> +\item If the VIRTIO_BLK_F_CTRL_VQ feature is negotiated, the driver MUST
>> +    identify the control virtqueue as queue N, after all request virtqueues.
>> +
>>  \item If the VIRTIO_BLK_F_SECURE_ERASE feature is negotiated,
>>      \field{max_secure_erase_sectors} and \field{max_secure_erase_seg} can be read
>>      to determine the maximum secure erase sectors and maximum number of
>> @@ -327,6 +337,10 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
>>  The driver MUST NOT negotiate VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA without
>>  VIRTIO_BLK_F_REQ_FLAGS.
>>  
>> +If the VIRTIO_BLK_F_CTRL_VQ feature is negotiated, the driver MUST NOT submit
>> +any request to the control virtqueue unless the request is defined by this
>> +specification.
>> +
>>  \devicenormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
>>  
>>  Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it
>> @@ -454,6 +468,11 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>>  };
>>  \end{lstlisting}
>>  
>> +Control virtqueue requests consist of a type field in an output buffer,
>> +followed by an optional command-specific output buffer, an optional
>> +command-specific input buffer, and a status byte in an input buffer. The
>> +type field and status byte MUST each be in their own buffer.
>> +
>>  The type of the request is either a read (VIRTIO_BLK_T_IN), a write
>>  (VIRTIO_BLK_T_OUT), a discard (VIRTIO_BLK_T_DISCARD), a write zeroes
>>  (VIRTIO_BLK_T_WRITE_ZEROES), a flush (VIRTIO_BLK_T_FLUSH), a get device ID
> 
> let the driver control buffering.
> you want the status as 1st byte of input. Then driver can separate
> it in a buffer of its own.

Thanks, that makes sense.

I'll re-word it as the following:

  - Control virtqueue requests consist of a type field followed by optional
    command-specific device-readable data, and a status byte followed by
    optional command-specific device-writable data.
    The status byte MUST be the first byte of the device-writable portion of the request.

> 
>> -- 
>> 2.34.1
>>
> 

