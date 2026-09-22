Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA1553A380
	for <virtio-dev@lists.linux.dev>; Tue, 22 Sep 2026 11:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075444; cv=none; b=B46Z1de1lAia54vU4K4yOJlxuRXTGPQfdaGRwtKN430kH6KR9RHJRDMufdOZv7f+BAGls3MvLhRbXlw+jfWyYtPijXay3dlR1WaZX2ZnDyM559RrBus1mI36/BJVuK3phk0Lny0q18wyq6qAwv9B7fUGkz8lGCg6zT/l+vN+Zbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075444; c=relaxed/simple;
	bh=AgxA8AE4aguOCbdx31cMy0eGZZosrIOgeilN+iwBhkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YNQjTg7gHOVIC6+vN8PBzN4miNwicUdO0kV5HuFt9h7M2hQuQatx2klMtzh1RbgCp5Jdf+E6QygbcaxcAtRTMVoC6xW8iHEwCm18GuqPnvRqvOSS+04KquJRANyvV8yY/ZwcBzskqgVlJFwJ8YG1/KX6aZZFUqbIXTS1lsUWyro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IFfzPsxj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IHB7VQUZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IFfzPsxj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IHB7VQUZ"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M7vcVU2174413
	for <virtio-dev@lists.linux.dev>; Tue, 22 Sep 2026 11:10:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	74YUfjOqUBVMgbuQDzu+av5v2XQAkdrhzSl56amgSWM=; b=IFfzPsxj3s15KmmT
	kCxskGTVVmJuV4YlWgst2ih3iwrab+4S6u7xGTE2aF5l6cju60fafABaCb6lMrfl
	rcZ0vV0y5lVdihif6aAPK7Y5qRzlu3F/U4k63hkHfsAonwIK3EkyQciPKB+KcNWY
	H4cA0gRLr4SuEXCC8Sux6QWqwGtzCfXw5LVKsG93gr0dfpsFIj3I1Pw6TY6M6gTD
	9+3vCkS/AJez7+HMifqDOX5ZrpIRVV6fNu0HvhCpSUMj+d3kfTjSmw4HdqnmpozN
	dWbzPFuDnYhlObqwgx6CzPd9DHgzabySrh8tz+IEN3V41hKfgu/VLmnTbyfheOtD
	OiO6/w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gufsqa350-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Tue, 22 Sep 2026 11:10:41 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cc73f47bdcso65936245ad.3
        for <virtio-dev@lists.linux.dev>; Tue, 22 Sep 2026 04:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790075440; x=1790680240; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=74YUfjOqUBVMgbuQDzu+av5v2XQAkdrhzSl56amgSWM=;
        b=IHB7VQUZzN6QNHCQVTH4Lgq5mUsrPbdySA6p3A4amvKMweyntwaXJqy2oTPVQ1SZTL
         8WjIcC1IhHmgTAwo/s7V94PUljc1cjGYah3EE9sOTQcdgJyOjraDF7tcTV5NMYlxXYvw
         tZZC1IDEU/pPB4ybsrETIYnXRIZADqZh7oCG4BX/1WVipRaEImjx8XkVoLkuUdR93XPS
         SE7CIpiigtwpDmbbT46Sdtc0h/CPqm27lcJrm78NiDt+f/An6IjlKU2fVgu/e6JJMZ4n
         xwND07Z6gGBmHYV9iZUZJ/eEQtH9Ijrill/R22mIRyGn+d8u5b9NAyksBR8dodYJwqZc
         3PTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790075440; x=1790680240;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=74YUfjOqUBVMgbuQDzu+av5v2XQAkdrhzSl56amgSWM=;
        b=v6huMDXzK2mgFqQXWBtVTkjBG3vHyIQDBaYocIZCpEEJ02Z5yDdHMGIMWB0oTRFAi+
         Xiy8eQ5N7/lQsPJFFXVcxuFj9qnP/c8J4L47PT4vpZzUrZIbWr5K/0ohONKEgFNjI93P
         WSprVh8OKdXzxNGuzSjOhYsumAaubjMsB22nUEvq6zvPkvApqC7p33/YNqdgd1ywf9Vw
         acfinww1NZole6Ayc4/ykvPNn9vwZw0AnP2Vc0BLabPuQNJYWMKHdCzP0SBPzsax+e0P
         9H06YzLza6BE2uIIpSnOIQfMxrjRIMl/UyfYO3IWucUKPNmWCe1YW0IwMSSLqXRradnU
         jc4A==
X-Gm-Message-State: AFuF++l7wz/NbbGiS/Xi8Z/ZXFBgoWWq9sAfAeVgQzrRpeVWFvflUxCz
	M4yACAGMMB9aMvhMx/Usfmo4ckJQHRAGapLIn1NMm4NnK6/DoqRLenidVOD3HjSqEeWlBx2eaUL
	temPN6LAyVep1ZQFtWkaDN0mAwMWBDAVtqiRcYN6MpwgsZrc6lCzqntXuKuGstal8JAeEe+6T6H
	c=
X-Gm-Gg: AYBFou1SmKy0RVhEOxyRQ5sTQ7e8ATYdZM52AFKhIXgpfuqj9nVAGHdMYmc3+rA6ctz
	64phLInwU8LaYSh4+mM+muZKo6BkyBkmDwJdJpaneLaITJWViS135UfpjsNbN0DklKZHWve5CRh
	hTVSWbNDHrIRAcP98zNZ4yryUEhdDIpCNguxhioEG6jqrDix8izrcCJ2rCHHblySO0/9P9cW34Q
	qqWCeq3ZMSWo9mYWcU831tJ0kiFdJoNakFdukAMEM9io1L4f2lJ7+Pi4EA4XyxlJYw9xeIEJgxO
	60uGw8TzpI35n80zl7GTEbCDGpfXoTTGhghUpmRBhdCYh26rWCqKdodDEvbKjziw+SmDW/8bxzk
	ozx6y2498Uw436cxBt8iJBocaiuiaQKBnSziHv3VZD4D1wJJO5sGvJZKhag==
X-Received: by 2002:a17:902:d54a:b0:2dd:ad73:c980 with SMTP id d9443c01a7336-2df609ce5bdmr10450255ad.24.1790075440550;
        Tue, 22 Sep 2026 04:10:40 -0700 (PDT)
X-Received: by 2002:a17:902:d54a:b0:2dd:ad73:c980 with SMTP id d9443c01a7336-2df609ce5bdmr10449845ad.24.1790075440037;
        Tue, 22 Sep 2026 04:10:40 -0700 (PDT)
Received: from [10.110.85.183] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e612708d6sm4196288eec.7.2026.09.22.04.10.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 04:10:39 -0700 (PDT)
Message-ID: <b1e4cbf9-6f5b-4f5c-bafa-4394ff3c666b@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 19:10:34 +0800
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] virtio-blk: Add the control virtqueue
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.linux.dev, ebiggers@kernel.org,
        neeraj.soni@oss.qualcomm.com
References: <20260913161628.368484-1-linlin.zhang@oss.qualcomm.com>
 <20260913161628.368484-2-linlin.zhang@oss.qualcomm.com>
 <20260917201647.GB331587@fedora>
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <20260917201647.GB331587@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: HVByUKQl_9eD017tkShpGCgGhKBb-bjC
X-Proofpoint-GUID: HVByUKQl_9eD017tkShpGCgGhKBb-bjC
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE2MSBTYWx0ZWRfX8Nk3VCeYAXL9
 u3Bj9vszH5C8j84/OrgmYUAd1XONAH5t+/rL74ZwZE7GokO143SWN7mTH5efZdaCxgooBNQiNau
 G+6cAXKvHussHZE/vy7yA/hJRNht4y8=
X-Authority-Analysis: v=2.4 cv=NKBAaE6g c=1 sm=1 tr=0 ts=6ab26231 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=mkMtH7XpAAAA:8 a=EUspDBNiAAAA:8 a=nqCGKatIELq8TwjyTg8A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=I9Slk6e--tAXHahELIuT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE2MSBTYWx0ZWRfX6Mb9l78sDo16
 DJsGd6viuU0IxcwU/M8Qyss6ssYTD+RZGWmDclY8gGf9ufrEEdjBmp+U3BvxmHhddit+MQmYSkC
 53fG2Cwk28IY8x0zqoU9dGzodvl438w++xdHw1B9WP+E9pNECQbgDRuf3TgQGb4W/wL9Nv8prmp
 MZ45gbIXJywwCftBlNUUJY4E5jUNKPdJllSrDMmH5psrrkbMpuG91FFsX22LtfNNceLwERlfvGA
 NRHDnLy/3d2ptFIwyQBULC418cp6bvhxjeOdp5cxuPy6sGD8XUn5u8oGaE4BJUMduptbjz2/2mb
 lGEXVRqNQapd0mDelpojN7e3u+k7P3ULUPTW104O9fFsZQeQYmLJX7Ky5275h/qZk5l8PgosqT4
 sCeL8UJeY9Qs2WRAspC0L9175ieqwvizztBkO9KdvLGGkUyGwmasNqVD1JsJ+E/pONuo4xi251k
 oCaCwdaHKWuySt8fERA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220161



On 9/18/2026 4:16 AM, Stefan Hajnoczi wrote:
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
> 
> Please move this paragraph to a separate subsection dedicate the control
> virtqueue (like virtio-net's 5.1.9.5 Control Virtqueue in VIRTIO 1.4,
> https://docs.oasis-open.org/virtio/virtio/v1.4/virtio-v1.4.html#x1-2850009:~:text=5%2E1%2E9%2E5%20Control%20Virtqueue).
> 
> I recommend defining a separate struct virtio_blk_ctrl similar to
> virtio-net's struct virtio_net_ctrl to illustrate the layout more
> clearly than a paragraph of text could.
> 

ACK. Thanks for your comment!

A separate struct virtio_blk_ctrl will be defined in the next patch.


>> +followed by an optional command-specific output buffer, an optional
>> +command-specific input buffer, and a status byte in an input buffer. The
>> +type field and status byte MUST each be in their own buffer.
> 
> Message framing is up to the driver and the device spec cannot dictate
> specific framing:
> https://docs.oasis-open.org/virtio/virtio/v1.4/virtio-v1.4.html#x1-390004
> 

ACK

The message framing will be defined in the format of the new struct virtio_blk_ctrl.

>> +
>>  The type of the request is either a read (VIRTIO_BLK_T_IN), a write
>>  (VIRTIO_BLK_T_OUT), a discard (VIRTIO_BLK_T_DISCARD), a write zeroes
>>  (VIRTIO_BLK_T_WRITE_ZEROES), a flush (VIRTIO_BLK_T_FLUSH), a get device ID
>> -- 
>> 2.34.1
>>

