Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794921139;
	b=cvuTJeTxlquu5JkOaObGRwHeDmUr4hcDp2cStgKlxbQ+CDgxVMve4hY2dib25CMgQh5U
	 yOOT/0+1ESt4Bwd1Y/PPkGuQofIALB8oaBESJsssLvKPu6AHIAWJ+QVuWeL8RClzcpQHz
	 VPfoK5K5nTn/mMOJ6mLgPia7M40XLAmfFMpqTIBR4zRFMwDG9zfVwzGhpxr/EyJ+WRBmu
	 a1l9vlDLHupBQUVmkrsdLF61z1D4xYHOQuH8Z+IuJtzTIie65mf/yVmpvBSM8z+DxGi58
	 MPAvsVErYoY/7VUPDVFZZCJM9NvZ1sEWYXsK4zsZYyteGHFemEZSr1DFq8H078twGRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794921139;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=4K5blrLYfLp82cSpiJ6hRZQ4I2SrkaSacxfbxpQSysU=;
	b=Povguiz3nqmhyAoI87gfunMfDiBGPOpsyFBbFsm6DZ+mJm3zGEgXFpP73rnAfkXvzIbm
	 Vvh+cODp1iWsq8p/jLmQPu+iLVgGJU+Vb42J9C/jGMu1nyCaptoM5eGw+aetopwgsiRo6
	 9qUvLJ8u2l8kBK7otjJo9lPIi3TnkwVlzqdaaOswY9s4DtF+czRFv8w1BHjxAeZESluw1
	 PcAW8MDIA5409i4aGa/MvrFZvfAB4OIFe6USXoOvwriwrE8XdWC4oHTBD4515Tj6/O1y1
	 lEXUIQY99r85c1S1ONkzDnA6Kqevyhj372j34KJ2JQAE3Ga6Kkd91tepAOR8c/jXmuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Y8wWi4mL;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CnPyKJ2g;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CF8606A32C
	for <virtio-dev@lists.linux.dev>; Tue, 17 Nov 2026 13:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1CF8606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Y8wWi4mL;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CnPyKJ2g
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHC17B4081957
	for <virtio-dev@lists.linux.dev>; Tue, 17 Nov 2026 13:12:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4K5blrLYfLp82cSpiJ6hRZQ4I2SrkaSacxfbxpQSysU=; b=Y8wWi4mLQwd3TFwK
	R0y2d3Ghqs+aMylYC1/EV5qERf+A0WW6BRuNqxSXAkg0hOO/DeVUh94SRYsqqOXw
	ETbeBKtfo80vM7EVSbigWZsNDvsb8NasvXdu1DAH4+bfRGcmOK45xigHewZKmg/d
	d7uLiJ9lH2U4sm2RKToxn3HNsmrcwgNYkZVDhJuwsR/kytNy7ftfCaC3jDQDxQbn
	jcy5xeKimIDarvcfmOVQOZdwFSTNNwtt4MoBNSrGD83smMcb/3dze22tE3oPD+20
	aV7eAlt9WTanYdp9pm0F++Q7hD/g7iuKgydpghVmNuKGygD8K4+i0A+SRs/LmZ0i
	NEO7TA==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0gfr1te6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtio-dev@lists.linux.dev>; Tue, 17 Nov 2026 13:12:17 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-71acf48ae14so3287176eaf.0
        for <virtio-dev@lists.linux.dev>; Tue, 17 Nov 2026 05:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794921136; x=1795525936; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4K5blrLYfLp82cSpiJ6hRZQ4I2SrkaSacxfbxpQSysU=;
        b=CnPyKJ2gtKBU/HxzsE8BlSIuOBewBSHUZe7pNVTnXk5U/PcIou/vjkx7nxoOlFuBVt
         SRRxUgOQtZHhWOle/1y9u5pMc302bWgv0kfdeW43R26wQwptZUdh527bcadFXhmzEvPE
         tVk6olJ8Td/KRaEN2pIATGfG51N1SxOTOTTNWSnl13rUCJAspDLkhLBDvBpmixa/60hm
         CcAvviobvm6pliDOvFuCE+S+U91n6Fhu4uEWhlNtriP/lO9TPCNMkgn1u5JawhR1hlFF
         zV9BjDtJUKCMc28TYqsW5nBL1f7TQSynFTbKaRlRJ3VnUDEM8+BDCmBb+H4sCwR2/TXU
         YN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794921136; x=1795525936;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4K5blrLYfLp82cSpiJ6hRZQ4I2SrkaSacxfbxpQSysU=;
        b=Lc8hb7XGmiNR5NU6xUqPe2f0dL8ZNeRlPAgghfplWMcJpMr1HkTmnZRRLZnyXDANpv
         lLgWrua8FYE1QUiggzjs0eaE+tSZxoe67ReCXQcpnSGdqqydYb5VaB7a4yl4vjg3YMoB
         GW6uoUdZxlZdOizpdXOfyy6sVYotUgWDvOZhMyK/4oA2vYDSDTjtcCYNgPYf4rtdKl8h
         duT09qRvpKgMy3iQ6/vxNizBrDfPogf81hxTQXWY04hYIZtJBt5hkMNADjqgU6FbFP0T
         fVdviFMRL/hJaaLFLY0jqYbqQ8CG4cP05iRIDJh9Kb4OIxq4d8UBg4/HyesxV4rYJtoy
         F7Lg==
X-Gm-Message-State: APuU4Z+lE6yqlOt8h6QnSjRbv+TfqC6VFv4T2Hs8KDDxGCWUMwFYCvXJ
	5pUYSI4pmNpmgMSRgHBggR+i0gVDG4QERJO5oPIeco6QdBO/U4x/PoboCX9jyZbBNVNVQLOeLvD
	HdDvSidyuENH0NPj3qOojJ+RF7KDHHmNWFNAb2pq4AYY9uiGZQwTpwv7sFB+ZkJSR
X-Gm-Gg: AYBFou1kWjY2Orl2oqOjqCgnU3ujbiVDn0rcpi0u/qt3wWqh8FGIkwyDPEHf/qJC1Yo
	YiyjuGwniAuCPqLapKmQX0w/GeWzt5WDWM77IV7lLrdzmfUjVbSjTbToHU7tsE67GSVn0+qjgAS
	afwnPESoDKjKQtBAZZErtVVipuyoNWDaZRXed7vcIf5zQq8digQOIdWNCfJjeM8ZnbEUWRD4GZD
	bb5TGubQoB8149JVanj0drPD0NBiKAVNOrr7MkVtw8yMISSkxhhLVyQxnnz/MLvjD+yB+F/Z9++
	ggFqV5Q6yhiPbcJFIcR6UC0xYxpaKKNMVMcpqJnwp9VdXSHF43PIOG5piTcM3UK5SVieHVCWLl0
	AxC7lWqcLSe/09Lo0lOHyTsp73W9uIZOKrs64n5dwDQyv0GhoUua1R1e67aJZ6tIonqu0kBF9F6
	TAaDZs+smOOfK+AR5wAUWkItZRlwjEUw==
X-Received: by 2002:a05:6820:2206:b0:70e:2d38:4b86 with SMTP id 006d021491bc7-71ab4fa06fbmr9692280eaf.16.1794921136304;
        Tue, 17 Nov 2026 05:12:16 -0800 (PST)
X-Received: by 2002:a05:6820:2206:b0:70e:2d38:4b86 with SMTP id 006d021491bc7-71ab4fa06fbmr9692260eaf.16.1794921135717;
        Tue, 17 Nov 2026 05:12:15 -0800 (PST)
Received: from [10.110.92.177] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862beb11508sm6382758a34.3.2026.11.17.05.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 05:12:15 -0800 (PST)
Message-ID: <df871f4d-5c56-41b9-83a7-d5831f2b23e1@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 21:12:10 +0800
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
Subject: Re: [PATCH v6 4/4] virtio-blk: Add inline encryption security
 considerations
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.linux.dev, virtio-comment@lists.linux.dev,
        stefanha@redhat.com, mgurtovoy@nvidia.com, parav@nvidia.com,
        ebiggers@kernel.org, neeraj.soni@oss.qualcomm.com
References: <20261027090945.185178-1-linlin.zhang@oss.qualcomm.com>
 <20261027090945.185178-5-linlin.zhang@oss.qualcomm.com>
 <20261110065058-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <20261110065058-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=X/rHu2Te c=1 sm=1 tr=0 ts=6afc52b1 cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=hm7eBhRZyIYsvCQPfSgA:9 a=QEXdDO2ut3YA:10
 a=rBiNkAWo9uy_4UTK5NWh:22
X-Proofpoint-GUID: KJtjs4NdZOCVN7gZnG1nmpXXXUMThX3Q
X-Proofpoint-ORIG-GUID: KJtjs4NdZOCVN7gZnG1nmpXXXUMThX3Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA1MiBTYWx0ZWRfX13V8QPaVLKO2
 tvz8vNMMRQFyQOvUJNrRhClnuZ3XtNxHSIYzWrwmo5tbjhZOB3qKwrDjZmTzvTnOqn/BgSYmty3
 yxnkcAb6rAmecLvRXB+slmsigcVOSSEoS+V3DkWX8saq2mpto4r2PQyvWLfwpmlldnfCLFeJ+8J
 mZYdvulYXVKXeaMNpG/+5N/8UaP9FWs+w+3Q0pI+lpTaOxxQeNgwq07eDoXsszA8pW39KeOPghU
 +15qFg1gOzmJ9hdgumaAnS7ML9DZSFXVX9oXDJN/y4g8Iko2+49C+v4UiMcd18QbQPip2hfuFdb
 M8vp8tiJtCNNe8+I3HaU+9w9GujqqA4E0YO/HsMKkj3nFNk9e0ca2JZ8/PIh8IsKm+S0qs0tYSw
 t2gltMO1W3SLLkZPSyILOGJ451xnboTKTwu4fbMGviB8Gx9BV9JtOsMsMeqlsTtZkJ2K43aZCCO
 7N+N1okY0RYIMj54Sgg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA1MiBTYWx0ZWRfX0JJ+10b0TGsx
 yL8hGi3Vy5R2lQa9k64IbkVLJISZzA0ACcMHZZjIHdZ2lNBBXMkjKCvWNPsGz2gdOpz2Fp3nUOc
 EaniNosG7nVc1AS8EYsukXvQY6ZkrOE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611170052



On 11/10/2026 8:01 PM, Michael S. Tsirkin wrote:
> 
> Good start! Yet something to improve:
> 
> On Tue, Oct 27, 2026 at 02:09:27AM -0700, Linlin Zhang wrote:
>> Inline encryption protects the data stored on the backend storage, but
>> the device, and therefore the host, is able to read the buffers of both
>> the request virtqueues and the administration virtqueue.
>>
>> Describe the resulting exposure. The data of the requests is transferred
>> in plaintext, so inline encryption is not a means of keeping data
>> confidential from the host, whichever key type is used, and confidential
>> guests cannot rely on it for that.
>>
>> A raw key programmed into a keyslot is visible to the host. A
>> hardware-wrapped key prevents the raw key from being extracted, so that
>> the key can only be used through the device which wrapped it, but does
>> not prevent the host, which is able to send administration commands
>> itself, from using the key through the device.
>> The raw key imported by VIRTIO_BLK_ADMIN_CMD_CRYPTO_IMPORT_KEY and the
>> software secret returned by VIRTIO_BLK_ADMIN_CMD_CRYPTO_DERIVE_SW_SECRET
>> are also visible to the host.
>>
>> This patch adds no normative requirements.
>>
>> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/238
>> Signed-off-by: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
> 
> 
> This needs to be rewritten:
> - use terminology from spec (or standards linked to) do not make up your
>   own
> - address physical device implementations and software ones
> - specific recommendations lacking

Thanks for your comments!

I'd like to double confirm that, this comment is about the commit message, right?

Would you please help clarify about 'specific recommendations lacking'? do you mean
adding some recommendations when and how to use virtio_blk inline encryption? 

For instance, which key type is preferred? 

> 
>> ---
>>  device-types/blk/description.tex | 40 ++++++++++++++++++++++++++++++++
>>  1 file changed, 40 insertions(+)
>>
>> diff --git a/device-types/blk/description.tex b/device-types/blk/description.tex
>> index bbae9af..ca54e50 100644
>> --- a/device-types/blk/description.tex
>> +++ b/device-types/blk/description.tex
>> @@ -1994,6 +1994,46 @@ \subsubsection{Inline Encryption Administration Commands}\label{sec:Device Types
>>  NOT write key material or the derived software secret to the
>>  \field{command_specific_result}.
>>  
>> +\subsubsection{Inline Encryption Security Considerations}\label{sec:Device Types / Block Device / Device Operation / Inline Encryption Security Considerations}
>> +
>> +Inline encryption protects the data stored on the backend storage, for
>> +example against an attacker who obtains the storage medium on its own. It
>> +is not a means of keeping data confidential from the host: the device, and
>> +therefore the host, is able to read the buffers of both the request
>> +virtqueues and the administration virtqueue. A confidential guest, for
>> +example a guest whose memory is protected from the host by a confidential
>> +computing technology, cannot rely on inline encryption to keep its data
>> +confidential from the host, whichever key type it uses.
> 
> 
> Pls reword in terms of device/driver, not host/guest.
> "confidential guest" is also not a common term
> 
> E.g. "an untrusted device", "a driver that does not trust the device".
> You can give examples "e.g. as is common with
> confidential computing configurations".

ACK

> 
> this applies everywhere.
> 
>> +
>> +\begin{note}
>> +Inline encryption does not protect the data of VIRTIO_BLK_T_CRYPTO_OUT and
>> +VIRTIO_BLK_T_CRYPTO_IN requests from the host: that data is transferred in
>> +plaintext in buffers of the request virtqueues.
>> +\end{note}
>> +
>> +When \field{key_type} is VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW, the key material in
>> +the \field{bytes} of struct virtio_blk_crypto_key_desc of a
>> +VIRTIO_BLK_ADMIN_CMD_CRYPTO_KEYSLOT_PROGRAM command is the plaintext key.
> 
> the plaintext key?

Yes, when the key type is VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW, it's the plaintext key
populated from the driver to the device. 

Only when the the key type is VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED, it's a
hardware-wrapped key populated from the driver to the device. 

> 
>> +Any software able to access the buffers of the administration virtqueue,
>> +such as the hypervisor, the device implementation or other software on the
>> +host, can therefore obtain the key, and decrypt the data encrypted with it
>> +at any time, including after the key is no longer in use.
> 
> what does it have to do with software, unclear.

Thanks for this point!

The security implication is not specific to software. What matters is access to
the administration virtqueue buffer: since a RAW key is transferred in plaintext,
any entity with access to that buffer can observe and retain the key material.

Reword it as the following:
  - When \field{key_type} is VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW , the RAW key
    material in the \field{bytes} of struct virtio_blk_crypto_key_desc of a
    VIRTIO_BLK_ADMIN_CMD_CRYPTO_KEYSLOT_PROGRAM command is transferred in
    plaintext through the Admin VQ buffer. Therefore, any entity that can
    read that buffer can read the plaintext key material.

> 
>> +
>> +When \field{key_type} is VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED, a
>> +VIRTIO_BLK_ADMIN_CMD_CRYPTO_KEYSLOT_PROGRAM command only transfers a key
>> +wrapped by the device, and the raw key material is not exposed in its
>> +buffers.
> 
> material?

The struct virtio_blk_crypto_key_desc except slot in it implies a key,
containing key_size, crypto_mode, key_type, key bytes and etc. The key
material here only means the key bytes content.

> 
> the considerations are same or different for different key types?
> pls structures the text to make it clear what applies to what.

ACK.

Yes. The security considerations are different for the two key types. I'll
restructure this section to discuss RAW and HW_WRAPPED keys separately and
make it explicit which considerations apply to each. The new structure is
most like that

  - For RAW key:
    representation
    security exposure
    applicable considerations
  - For HW_WRAPPED key:
    representation
    security property
    applicable considerations
  
  - Considerations for both

> 
> 
>> This prevents the raw key from being extracted, so that the key
>> +can only be used through the device which wrapped it. It does not prevent
>> +the host, which is able to send administration commands itself, from using
>> +the key through the device, for example by converting a long-term wrapped
>> +key it has observed with VIRTIO_BLK_ADMIN_CMD_CRYPTO_PREPARE_KEY and
>> +programming the result into a keyslot. Moreover, a
>> +VIRTIO_BLK_ADMIN_CMD_CRYPTO_IMPORT_KEY command carries the raw key in its
>> +\field{command_specific_data}, and the struct virtio_blk_crypto_sw_secret
>> +returned by a VIRTIO_BLK_ADMIN_CMD_CRYPTO_DERIVE_SW_SECRET command is
>> +visible in its \field{command_specific_result}, so these commands expose
>> +secrets to the host in the same way as raw keys.
> 
> 
> this seems to argue with itself about some kind of protection
> that maybe could be there but is not?

Thanks for your comments!

the file is encrypted by 2 keys - file name key and file content key - which are
derived from a class key.

When the class key is a HW-WRAPPED key, it means the key implied by the struct
virtio_blk_crypto_key_desc except its slot filed is a ephemeral wrapped key.

A long-term wrapped key can be generated by either
VIRTIO_BLK_ADMIN_CMD_CRYPTO_GENERATE_KEY command or
VIRTIO_BLK_ADMIN_CMD_CRYPTO_IMPORT_KEY command. 

Then using VIRTIO_BLK_ADMIN_CMD_CRYPTO_PREPARE_KEY command to get a ephemeral
wrapped key. 

   - the command VIRTIO_BLK_ADMIN_CMD_CRYPTO_IMPORT_KEY exposes plaintext of a
     class key to the entity that has access to the Admin VQ buffers as it needs
     a input key as the class key.

   - the command VIRTIO_BLK_ADMIN_CMD_CRYPTO_GENERATE_KEY returns a long-term
     wrapped key directly, so no key plaintext exposure in Admin VQ buffer.

   - the command VIRTIO_BLK_ADMIN_CMD_CRYPTO_PREPARE_KEY doesn't expose key
     plaintext in the Admin VQ buffers.

  - the command VIRTIO_BLK_ADMIN_CMD_CRYPTO_DERIVE_SW_SECRET returns a raw
    software secret key (plaintext) to the virtio block driver which is the
    key that Linux uses to derive the file name key.

So the most security way is using the wrapped key generated and derived via
GENERATE_KEY and PREPARE_KEY. Even though, there is still risk the DERIVE_SW_SECRET
command return the software secret in form of plain text.

I'll restructure this text and introduce the above clearly.

> 
> 
>> +
>>  \subsubsection{Legacy Interface: Device Operation}\label{sec:Device Types / Block Device / Device Operation / Legacy Interface: Device Operation}
>>  When using the legacy interface, transitional devices and drivers
>>  MUST format the fields in struct virtio_blk_req
>> -- 
>> 2.34.1
> 

