Return-Path: <virtio-dev-return-14053-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DE9C4332F
	for <virtio-dev@archiver.kernel.org>; Fri, 10 Nov 2023 02:37:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DFE3E44552
	for <virtio-dev@archiver.kernel.org>; Fri, 10 Nov 2023 02:37:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DAFE0986D03
	for <virtio-dev@archiver.kernel.org>; Fri, 10 Nov 2023 02:37:46 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CEA2B986CF2; Fri, 10 Nov 2023 02:37:46 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BA053986CF3;
	Fri, 10 Nov 2023 02:37:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Message-ID: <cda9cfc8-1897-4fcf-9b30-1ad9c81185e6@quicinc.com>
Date: Fri, 10 Nov 2023 10:37:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
CC: Harald Mommer <harald.mommer@opensynergy.com>,
        <virtio-dev@lists.oasis-open.org>,
        <virtio-comment@lists.oasis-open.org>, <cohuck@redhat.com>,
        <quic_ztu@quicinc.com>
References: <20231024125346.23546-1-quic_haixcui@quicinc.com>
 <ZUjrDjHpFVReDSgk@finisterre.sirena.org.uk>
 <c08f1b37-51e8-4126-9e1c-40530f468df4@quicinc.com>
 <ZUuxfbkSboAFQIQF@finisterre.sirena.org.uk>
 <ab11fb3c-296f-41a3-92c7-2e8dddb4369f@quicinc.com>
 <ZUzaZt4flHQgsBzu@finisterre.sirena.org.uk>
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <ZUzaZt4flHQgsBzu@finisterre.sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gFYCy36jNg9uVGVl9i1BV4MpAd0eigYw
X-Proofpoint-GUID: gFYCy36jNg9uVGVl9i1BV4MpAd0eigYw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_17,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 malwarescore=0 mlxlogscore=711 suspectscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100020
Subject: Re: [virtio-dev] [PATCH v4] virtio-spi: add the device specification



On 11/9/2023 9:11 PM, Mark Brown wrote:
> On Thu, Nov 09, 2023 at 07:21:57PM +0800, Haixu Cui wrote:
> 
>>     For checking the parameters above in virtio_spi_transfer_head, I'd like
>> to add these field in config space:
> 
>>      5. freq_max_speed: if non-zero, maximum clock rate support, in Hz
>>                  unit. if 0, no limitation.
>>
>>      6. max_word_delay_ns: if non-zero, the maximum word delay supported.
>>                  if 0, word delay is not supported to introduce.
>>
>>      7. max_delay_after_cs_asserted: if non-zero, the maximum cs setup
>>                  delay supported.if 0, cs setup delay is not supported to
>>                  introduce
>>
>>      8. max_delay_before_cs_deassert: if non-zero, the maximum
>>                  cs_delay_hold_ns delay supported.if 0, cs setup delay is
>>                  not supported to introduce
>>
>>      9. max_delay_after_cs_deassert: if non-zero, the maximum
>>                  cs_change_delay_inactive_ns delay supported.if 0, cs
>>                  setup delay is not supported to introduce
> 
> I think this all makes sense - for the above we probably also need to
> say that if the value requested by the client can't be met exactly we
> either treat it as a minimum or maximum depending on the delays and
> choose the next value (probably a maximum for the clock and minimum for
> the rest).  So for example if the client requests 21MHz and the
> controller can only select 20MHz or 25MHz then it should pick 20MHz.

Sure, I will update to make it more flexible.

Thanks a lot.

Best Regards
Haixu Cui

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

