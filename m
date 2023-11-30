Return-Path: <virtio-dev-return-14085-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3090AC4167B
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Nov 2023 07:36:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9A0F874DC0
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Nov 2023 07:36:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 94034986699
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Nov 2023 07:36:47 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 88479986671; Thu, 30 Nov 2023 07:36:47 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 76DDB98666F;
	Thu, 30 Nov 2023 07:36:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Message-ID: <b3af0fd5-80ce-49c4-a70e-48b8c3104177@quicinc.com>
Date: Thu, 30 Nov 2023 15:36:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Viresh Kumar <viresh.kumar@linaro.org>, Cornelia Huck <cohuck@redhat.com>
CC: <virtio-dev@lists.oasis-open.org>, <virtio-comment@lists.oasis-open.org>,
        <harald.mommer@opensynergy.com>, <broonie@kernel.org>,
        <qiang4.zhang@linux.intel.com>, <quic_ztu@quicinc.com>,
        <alex.bennee@linaro.org>, <vincent.guittot@linaro.org>
References: <20231127101750.6xmthho6lnppyw3k@vireshk-i7>
 <2ca987a6-eeb2-4ed6-9a12-10ae450eb4bf@quicinc.com>
 <20231129073022.ohxsfuawambvh3hm@vireshk-i7>
 <0674be8e-221f-479a-8da2-8a3e59e45bb9@quicinc.com>
 <871qc9x8k2.fsf@redhat.com>
 <9e0c5e5e-db7b-4634-9423-f4db1800b148@quicinc.com>
 <20231129100002.q73wtz6mkfixcbzt@vireshk-i7>
 <5367c2e6-93f1-4a4d-867e-0074b452052a@quicinc.com>
 <20231129113417.7kb6my3mm67zal3q@vireshk-i7> <87y1egwx27.fsf@redhat.com>
 <20231130041311.3azypbxfoujkwhj7@vireshk-i7>
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <20231130041311.3azypbxfoujkwhj7@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 919SK-JViEVsyFD2HQFZidF9JW8BHbRv
X-Proofpoint-GUID: 919SK-JViEVsyFD2HQFZidF9JW8BHbRv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_05,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 mlxscore=0 priorityscore=1501 phishscore=0 adultscore=0 mlxlogscore=835
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311300056
Subject: [virtio-dev] Re: [virtio-comment] [PATCH] [PATCH v5] virtio-spi: add the device
 specification



On 11/30/2023 12:13 PM, Viresh Kumar wrote:
> On 29-11-23, 13:42, Cornelia Huck wrote:
>> On Wed, Nov 29 2023, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>
>>> On 29-11-23, 18:31, Haixu Cui wrote:
>>>> Hi Viresh,
>>>>
>>>>      Thank you for your helpful comments. In next patch, I will clearly point
>>>> this out:
>>>
>>> Great, finally we are on the same page. Thanks Haixu.
>>>
>>>>      "For full-duplex read and write transfer, both \field{tx_buf} and
>>>> \field{rx_buf} are used and the buffer size of \field{tx_buf} must be same
>>>> as \field{rx_buf}."
>>>
>>> Suggest rewriting as:
>>>
>>> In full-duplex transfer mode, both \field{tx_buf} and \field{rx_buf} are sent by
>>> the driver, \field{tx_buf} followed by \field{rx_buf}. The length of both the
>>> buffers MUST be same.
>>
>> Is that in a non-normative section? (Sorry, I've lost track here...)

Hi Viresh，
> 
> I think yes, though I am not sure where Haixu will put it eventually :)

I would like to put it in normative section, both for driver and device.

> 
>> If
>> so, I would say:
>>
>> "The length of both buffers has to be the same."
> 
> That's better. Thanks.
> 
>>> device MUST fail the transfer and notify the driver.
>>
>> "notify the driver" == "set an appropriate error value"?
>>
>> Can this be covered by one of the existing error values?
> 
> I think yes, this can be handled by the Param error.

Yes, this seems still in scope of parameter checking.

> 

Thanks & Best Regards

Haixu Cui

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

