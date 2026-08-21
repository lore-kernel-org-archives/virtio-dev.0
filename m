Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB4447DF99
	for <virtio-dev@lists.linux.dev>; Fri, 21 Aug 2026 12:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787316555; cv=none; b=BjuCJeyLEgRpTfolqPwV7OAJlvXEIW3UP/9Pf5pY8LjJsR/O3O81wx+VbRCDNBcXkwV+Kw2VKiEPWJ87h3RmpJSU2ZRKWS1YwbutohiFxDCdWUL13psvuyeU2ZSAH1CSjjJJSIRGBSWjLw2HktOQqpGrqH9zRqSm2/fC7Ea4N+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787316555; c=relaxed/simple;
	bh=wRyJelsyyprV8Kja8NYTdlrUJnkyk1+1pBQnvX3/OLA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=E/QtzCK7AUvHs5/14/IjCb4vuZpP5vAA0rS9dX/+vzAt0lLb6rmU/fZVg75/BtwN/+u+lhSnSP2VcSdhXsMEx4psmLeE35NP51ERR+4W3BEec4gCV1tGWcMEfoDPL0sFBvB7r1aHhfR8eLHOd5hEQsBpoVNen6UPIykxYkh/z+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J4ctCGJ+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=REp0XqY/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J4ctCGJ+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="REp0XqY/"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LBpxkt1899753
	for <virtio-dev@lists.linux.dev>; Fri, 21 Aug 2026 12:49:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ko5RZXdX0YG5wld7lu67WNJLX2SxT2epAmZ1A+dVjjg=; b=J4ctCGJ+YtnIDMs5
	26fp1LyOTBivSp8sJcfAva3vNVprulY3hzBhoWWSdOmJUEhZBW0gEYsM0m3Qqkco
	FU+QCcCCue3X8OQ5b/5kQLVEERTKZQJywg41CoxN6hmlNxYtYX2rGq/JHelStxaZ
	/IMi9zga40Ms/fqiOH2uPGUMGML23l2Owv1MHe0UlNfH4p67rFVqLql53vcClxPL
	uFAUlVKxQb/0gRKxsgETvAnXD2aMOU1lJRlkaZO039ZOLJIh4dvfH8lRyju6NZZr
	U6wjFEKwAYs+10OkpokaCUhsYjnpJBIXdYsO9Bppz8KEssZ24C6oZruf+AzIWBKj
	nE6I3g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6fue1pqq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Fri, 21 Aug 2026 12:49:08 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d63bad3d09so13407645ad.3
        for <virtio-dev@lists.linux.dev>; Fri, 21 Aug 2026 05:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787316548; x=1787921348; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ko5RZXdX0YG5wld7lu67WNJLX2SxT2epAmZ1A+dVjjg=;
        b=REp0XqY/mU8S+1fVdDWg3wFqzsU3s/mOVgy1CTyGiXRPeojN6Onfpojze0eEerqTOP
         ZJlzE307pwuhciSHk6vSGK91j8fAYrf30YNhac/n0avBQEBYqu6R/hSgeTUna4MLfyv8
         3o7/2FdG4svRbXr+BtoMrYDGXS8x7U05nEznxsv1zk34aIjs8sspXTCdTyVk5Bk2wKsN
         o/CO/noc2ebkMF9vkT18g6ROMyfVsGaWnrHlKLWSdG2IisnvkiEGgdNBpWPDHqr9rmPi
         jUAzCam+zVie867CFHMGNhk300+QH8OpRYNUd5dF5yC8qhyfaEV7KN1c2dONJHw054bG
         jxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787316548; x=1787921348;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ko5RZXdX0YG5wld7lu67WNJLX2SxT2epAmZ1A+dVjjg=;
        b=Fa07dlssfnao9Jl5qJyCITzmdDHnqqsa8waYZZTcWz3a71c25B+GRBad0xuxralF1F
         YUlf42X+88Soj4uJJDSJxThv8Y0eWA1j5pcQGHZIplYuMm3DXeFbGGxL8C5bBuy0+WIc
         +aISN3s4+ImljgVUpS1xXK0+MNCLQbIB6HiOHISyXINkNoB5BFjcPE7JqfBpx75OfSJ0
         jkmyN1M0zdrArgUwUWkFCw+xMUB4+cK2j0Z8NG6zFZo1jxjGYQk5JnjZyxhh5amcwpdV
         Mr2AFgr3lX6HWNfFQP16Vv/3vt+y/0u9I9BravV5DybzPXNEUy51FmE2qFqzsfSP8vwB
         iQAg==
X-Gm-Message-State: AFuF++kZHfKJE+jxgOOsyIP1JiBYZGJfLAsTnVudV+vYmfvXPuzGMo/l
	XAXuRXvR5zPtVZm/1hFZtDrbnk6EgeEyRi6Tctleah9FheRwXNEdIgriTFnQ9ykUlifxM/EFk/+
	CmTBMLKBgccTQgdlkwLTlnsOk1dQK6wHsKN20r4aw2pbjrhKowz/wK32L054PE17ps99pCIYMjY
	8=
X-Gm-Gg: AR+sD10++GWM06can1dOyBm0swN+1baGf0Nfg0WAwkx2WwwcwR5wfbcWXUmd4B6exh5
	jUMLArBn8BHtdpbBDNDSXb6rny0V2A23ChCc6vCFsuX7nuaTtXX9GcXladNBwS66oAdnsUlA5s0
	y5ONTFJTnHzqAzRxpmLwD55MQuajCVfDPYctQnEq9JoMMEUVRCZLCZmy3P6EGfx8cdbDktYRPxE
	fVD/cK6JSG2dtP3EpdoUJN/u6Rt2bAQfNVk0qKqIM5uGEIqywtBrhQg2hetG4fOtrCPepO+S92S
	z3lrkOGF64eJvo1gERiB3/dvpfrdB3p3AgIJEM/ovh5PUoJPxtEoUYYQI3KYrAjUFdsPCUPvyjE
	zmVz6n43yO9+7pNKqVwHmatCydCoCsSHlXlOCZ3fnuWuxMm/KHOUH07on+A==
X-Received: by 2002:a17:902:e552:b0:2c9:b8b7:5d27 with SMTP id d9443c01a7336-2d64ade4a00mr108896535ad.1.1787316547868;
        Fri, 21 Aug 2026 05:49:07 -0700 (PDT)
X-Received: by 2002:a17:902:e552:b0:2c9:b8b7:5d27 with SMTP id d9443c01a7336-2d64ade4a00mr108895555ad.1.1787316547386;
        Fri, 21 Aug 2026 05:49:07 -0700 (PDT)
Received: from [10.110.67.136] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62d5544b5sm18223625ad.8.2026.08.21.05.49.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 05:49:07 -0700 (PDT)
Message-ID: <8ee0da17-1d2b-4465-8fd5-3f6ab401d729@oss.qualcomm.com>
Date: Fri, 21 Aug 2026 20:49:03 +0800
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] virtio-blk: Add inline encryption support
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.linux.dev, ebiggers@kernel.org,
        neeraj.soni@oss.qualcomm.com
References: <20260814142306.3934029-1-linlin.zhang@oss.qualcomm.com>
 <20260819211845.GB470114@fedora>
 <c66459c5-0207-4cc5-bea7-71fe0e600aa1@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <c66459c5-0207-4cc5-bea7-71fe0e600aa1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA5NiBTYWx0ZWRfX/xBU1lDK+bN/
 NUE5G6PE/XBkjnnCsGLynrGpo7HC9FWQp5aM8PoT1NlMEoDICyIMiK5mhteWUi5OsyxNjF9Vpim
 Tukq/E+82ilarXBrBn4+Eh3tOjFXIG4=
X-Authority-Analysis: v=2.4 cv=U9+iy+ru c=1 sm=1 tr=0 ts=6a884944 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=XxpHCOzB2h34jXki_DYA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: H6wtbiApiL7S3i8h9kH4t0fuDr0Uj2n1
X-Proofpoint-ORIG-GUID: H6wtbiApiL7S3i8h9kH4t0fuDr0Uj2n1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA5NiBTYWx0ZWRfX6fFx/+qFWEr/
 9nRCRChSQ59qz4ssUW+w2L2acu4e6haOFC8QLJzZjaFS9frpoHYL3D9q+bHlu/ftkBomtIbUeG6
 0aJ0Z9FT5+qbHSgC5UQOsRaLeTchNrkh5K4zjwuxcKXYM76NkrK/K0G2qAMgVGCDr+HrYi9KYQu
 Y/CdY/6KtNej5bII4cyrjbyK+L13h3IAuqjskDN4qIZZbZsmQ5yZ4fYtbZsXkMNNjLvUbdOvAIr
 ezAFsZZA0hV3gHJCK099irFZHgDB4xg2QffK/MLtnyTAbJpsF+Wpo+NDpLmFLvnoxrOreAh5aXE
 DoxboB2evBuRl5ZdEiuHd91l8LSu62/I/DSit/W7j7CXq4Bqk7PxyMtfe1CLcYm/yTzZCysUknr
 D5a+XKb/7Xu9MOVG1QJ/vBIhPcfPY/In4cjBKpOJjMeFE3BA35vg3R8cKKPfXklUXXMuLmxc6TX
 N4zQCVoV5EqwX8ki7FA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210096



On 8/21/2026 12:18 AM, Linlin Zhang wrote:
> 
> 
> On 8/20/2026 5:18 AM, Stefan Hajnoczi wrote:
>> On Fri, Aug 14, 2026 at 07:23:01AM -0700, Linlin Zhang wrote:
> 
>>> +\field{enc_characteristics}, or that identifies a key slot into which no key
>>> +has been provisioned.
>>> +
>>> +A driver MUST set \field{data_unit_size_bits} of a VIRTIO_BLK_T_CRYPTO_IN or
>>> +VIRTIO_BLK_T_CRYPTO_OUT request's \field{crypto_msg} to $log_2$ of the data
>>> +unit size in bytes associated with the key provisioned in the virtual key
>>> +slot identified by \field{slot}. Since data unit sizes are reported by
>>> +VIRTIO_BLK_T_GET_CRYPTO_MODES as a bitmask of \field{le32} elements, a
>>> +driver MUST NOT set \field{data_unit_size_bits} to a value greater than 31.
>>> +
>>> +A driver MUST NOT submit a VIRTIO_BLK_T_CRYPTO_IN or VIRTIO_BLK_T_CRYPTO_OUT
>>> +request with a zero length \field{data}.
>>
>> Does VIRTIO_BLK_T_WRITE_ZEROES need an equivalent
>> VIRTIO_BLK_T_CRYPTO_WRITE_ZEROES request type? If the driver sends
>> VIRTIO_BLK_T_WRITE_ZEROES then the device might write zeroes in
>> plaintext, which isn't what we want.
>>
> 
> Yes, it's still cipher text that is flushed into disk even the driver sends
> VIRTIO_BLK_T_WRITE_ZEROES. Need add a VIRTIO_BLK_T_CRYPTO_WRITE_ZEROES request
> type.
> 

I double-checked VIRTIO_BLK_T_WRITE_ZEROES. Since a request may consist of
multiple non-contiguous segments, handling DUN calculation becomes difficult
if the backend needs to divide the request. Because both sector offset and
data length per segment need be aligned with Data Unit Size, and only the DUN
for the first segment can be appended to the crypto message in the virtio reqeust.

For this reason, I would prefer not to introduce VIRTIO_BLK_T_CRYPTO_WRITE_ZEROES,
consistent with the treatment of discard/erase requests.

I'm appreciated if you have any thoughts about it.
