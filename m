Return-Path: <virtio-dev-return-14196-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 465FEC46CD2
	for <virtio-dev@archiver.kernel.org>; Fri, 22 Dec 2023 02:29:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9581E26A3A
	for <virtio-dev@archiver.kernel.org>; Fri, 22 Dec 2023 02:29:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8D569986661
	for <virtio-dev@archiver.kernel.org>; Fri, 22 Dec 2023 02:29:08 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 816669865E0; Fri, 22 Dec 2023 02:29:08 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6D7479865C1;
	Fri, 22 Dec 2023 02:29:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Message-ID: <d1f7cb96-c95f-4458-9b58-ea1e6335df55@quicinc.com>
Date: Fri, 22 Dec 2023 10:28:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Harald Mommer <harald.mommer@opensynergy.com>,
        <virtio-dev@lists.oasis-open.org>,
        <virtio-comment@lists.oasis-open.org>, <cohuck@redhat.com>,
        <broonie@kernel.org>, <qiang4.zhang@linux.intel.com>,
        <viresh.kumar@linaro.org>
CC: <quic_ztu@quicinc.com>
References: <20231212033317.22198-1-quic_haixcui@quicinc.com>
 <20231212033317.22198-3-quic_haixcui@quicinc.com>
 <95dcd2c7-4b5b-4b04-8748-e9e65374d356@opensynergy.com>
Content-Language: en-US
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <95dcd2c7-4b5b-4b04-8748-e9e65374d356@opensynergy.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7geK3B6IZC_isolVNOGgKSrQtV9Ow1x8
X-Proofpoint-ORIG-GUID: 7geK3B6IZC_isolVNOGgKSrQtV9Ow1x8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 suspectscore=0 mlxlogscore=849 clxscore=1011 malwarescore=0 phishscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312220013
Subject: Re: [virtio-dev][PATCH V9 2/2] virtio-spi: add the device
 specification

Hello Harald,

On 12/21/2023 7:25 PM, Harald Mommer wrote:
> Hello,
> 
> On 12.12.23 04:33, Haixu Cui wrote:
>> +\field{bits_per_word_mask} is a mask indicating which values of 
>> bits_per_word are supported.
>> +If bit n of \field{bits_per_word_mask} is set, the bits_per_word with 
>> value (n+1) is supported.
>> +If all bits are not set, bits_per_word can be any value from 1 to 32.
> 
> "If all bits are not set" is not easy to understand as it means "if no 
> bit is set".
> 
> You can of course specify the value 0 this way to make code more 
> complicated.
> 
> To make code simple, 0 would be not given this special meaning. To allow 
> any value between 1 and 32 solely the value 0xFFFFFFFF would be allowed. 
> Which is already possible now without this additional sentence for 0. 
> Simply checking whether the respective bit is set in the mask and done 
> without having to add senseless additional code to handle the special 
> case that the mask is 0.
> 
> Giving 0 the same meaning as 0xFFFFFFFF brings nothing except confusion.
> 
Here I refer to the __spi_validate_bits_per_word in drivers/spi/spi.c, 
if bits_per_word_mask of spi controller is 0, no check will be done for 
bits_per_word parameter.

Above is just the Linux mechanism, I agree with you, 0 and 0xFFFFFFFF 
have the same meaning will cause confusion in this spec. I prefer 
treating 0 as an invalid value because the backend must support at least 
one bits_per_word value.

How about updating as:
For \field{bits_per_word_mask}, 0 is invalid because at least one 
bits_per_word value should be supported.

Thanks & Regards
Haixu Cui

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

