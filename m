Return-Path: <virtio-dev-return-14084-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D321CC10DC2
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Nov 2023 07:33:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3199B2AF86
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Nov 2023 07:33:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1BC97986671
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Nov 2023 07:33:13 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0EF1798666D; Thu, 30 Nov 2023 07:33:13 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EC03A98666F;
	Thu, 30 Nov 2023 07:33:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Message-ID: <26973d80-d7a3-4fa5-b4ba-a83b1b62cb5e@quicinc.com>
Date: Thu, 30 Nov 2023 15:32:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cornelia Huck <cohuck@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>
CC: <virtio-dev@lists.oasis-open.org>, <virtio-comment@lists.oasis-open.org>,
        <harald.mommer@opensynergy.com>, <broonie@kernel.org>,
        <qiang4.zhang@linux.intel.com>, <quic_ztu@quicinc.com>,
        <alex.bennee@linaro.org>, <vincent.guittot@linaro.org>
References: <20231124072015.12655-1-quic_haixcui@quicinc.com>
 <20231127101750.6xmthho6lnppyw3k@vireshk-i7>
 <2ca987a6-eeb2-4ed6-9a12-10ae450eb4bf@quicinc.com>
 <20231129073022.ohxsfuawambvh3hm@vireshk-i7>
 <0674be8e-221f-479a-8da2-8a3e59e45bb9@quicinc.com>
 <871qc9x8k2.fsf@redhat.com>
 <9e0c5e5e-db7b-4634-9423-f4db1800b148@quicinc.com>
 <20231129100002.q73wtz6mkfixcbzt@vireshk-i7>
 <5367c2e6-93f1-4a4d-867e-0074b452052a@quicinc.com>
 <20231129113417.7kb6my3mm67zal3q@vireshk-i7> <87y1egwx27.fsf@redhat.com>
Content-Language: en-US
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <87y1egwx27.fsf@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QhSjRvWc9OijuBlFZLvl8ikxw0Sp9s_Y
X-Proofpoint-ORIG-GUID: QhSjRvWc9OijuBlFZLvl8ikxw0Sp9s_Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_05,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=817 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311300055
Subject: [virtio-dev] Re: [virtio-comment] [PATCH] [PATCH v5] virtio-spi: add the device
 specification

Hi Huck,

On 11/29/2023 8:42 PM, Cornelia Huck wrote:
> On Wed, Nov 29 2023, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 
>> On 29-11-23, 18:31, Haixu Cui wrote:
>>> Hi Viresh,
>>>
>>>      Thank you for your helpful comments. In next patch, I will clearly point
>>> this out:
>>
>> Great, finally we are on the same page. Thanks Haixu.
>>
>>>      "For full-duplex read and write transfer, both \field{tx_buf} and
>>> \field{rx_buf} are used and the buffer size of \field{tx_buf} must be same
>>> as \field{rx_buf}."
>>
>> Suggest rewriting as:
>>
>> In full-duplex transfer mode, both \field{tx_buf} and \field{rx_buf} are sent by
>> the driver, \field{tx_buf} followed by \field{rx_buf}. The length of both the
>> buffers MUST be same.
> 
> Is that in a non-normative section? (Sorry, I've lost track here...) If
> so, I would say:
> 
> "The length of both buffers has to be the same."

This is non-normative section.
> 
>>
>>>      And in drivernormative section, I will add a requirement:
>>>      "For full-duplex transfer, Virtio SPI driver MUST guarantee the write
>>> transfer size is equal to the read transfer size"
>>
>> Maybe:
>>
>> drivernormative:
>>
>> In full-duplex transfer mode, the Virtio SPI driver MUST guarantee that the
>> length of both \field{tx_buf} and \field{rx_buf} are same.
> 
> s/are same/is the same/
> 
>>
>> devicenormative:
>>
>> In full-duplex transfer mode, the Virtio SPI device MUST verify that the length
>> of both \field{tx_buf} and \field{rx_buf} are same. In case of any mismatch, the
> 
> s/are same/is the same/
> 
>> device MUST fail the transfer and notify the driver.
> 
> "notify the driver" == "set an appropriate error value"?
> 
> Can this be covered by one of the existing error values?

I'd like to use VIRTIO_SPI_PARAM_ERR to indicates the buffer size 
inequality issue here because this is in the scope of parameter checking.

Thanks & BR

Haixu Cui

> 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

