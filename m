Return-Path: <virtio-dev-return-12257-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A79C77B70
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 14:20:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C87A03E30B
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 14:20:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AB4DF9863D7
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 14:20:17 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8A871986353; Mon, 17 Apr 2023 14:20:17 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E663498634A;
	Mon, 17 Apr 2023 14:19:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Message-ID: <3c98e384-b8de-d6b8-d6c0-000ba4a69fa2@quicinc.com>
Date: Mon, 17 Apr 2023 22:19:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: Cornelia Huck <cohuck@redhat.com>, <virtio-dev@lists.oasis-open.org>,
        <virtio-comment@lists.oasis-open.org>
CC: <quic_ztu@quicinc.com>
References: <20230324080806.21229-1-quic_haixcui@quicinc.com>
 <87355qs9ym.fsf@redhat.com>
Content-Language: en-US
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <87355qs9ym.fsf@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: iczjVXtGN4D6He45LlDfKosQH-vyYWbP
X-Proofpoint-GUID: iczjVXtGN4D6He45LlDfKosQH-vyYWbP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_08,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=613 clxscore=1011 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304170129
Subject: [virtio-dev] Re: [PATCH] virtio-spi: add the device specification

Hi Cornelia Huck,
     Thank you so much for your helpful comments. I have them fixed in 
another submission.

Best Regards
Haixu Cui

On 3/27/2023 7:35 PM, Cornelia Huck wrote:
> On Fri, Mar 24 2023, Haixu Cui <quic_haixcui@quicinc.com> wrote:
> 
>> virtio-spi is a virtual SPI master and it allows a guset to operate and
>> use the physical SPI master controlled by the host.
> 
> Please spell out what SPI is the first time you use it.
I explain SPI is the abbreviation of Serial Peripheral Interface.
> 
> Also, please remember to post the separate patch that reserves the ID
> for it.
I have another patch for DEVICE ID for virtio-spi.
> 
>>
>> Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
>> ---
>>   conformance.tex                         |  12 +-
>>   content.tex                             |   1 +
>>   device-types/spi/description.tex        | 153 ++++++++++++++++++++++++
>>   device-types/spi/device-conformance.tex |   7 ++
>>   device-types/spi/driver-conformance.tex |   7 ++
>>   5 files changed, 176 insertions(+), 4 deletions(-)
>>   create mode 100644 device-types/spi/description.tex
>>   create mode 100644 device-types/spi/device-conformance.tex
>>   create mode 100644 device-types/spi/driver-conformance.tex
> 
> (...)
> 
>> diff --git a/device-types/spi/description.tex b/device-types/spi/description.tex
>> new file mode 100644
>> index 0000000..0b69700
>> --- /dev/null
>> +++ b/device-types/spi/description.tex
>> @@ -0,0 +1,153 @@
>> +\section{SPI Master Device}\label{sec:Device Types / SPI Master Device}
>> +
>> +virtio-spi is a virtual SPI master and it allows a guest to operate and use
>> +the physical SPI master devices controlled by the host.
> 
> Here as well; it's even more important that the acronym is expanded at
> least once in the spec.
> 
> Also, does this mean that the device is supposed to be an interface to
> physical SPI master devices? It would be good if this could be framed
> without guest/host terminology (although this can be used as an
> example.) Maybe something like
> 
> "The virtio SPI master device is a virtual SPI (Serial Peripheral
> Interface) master device, potentially interfacing to another SPI master
> device. It allows, for example, for a host to expose access to a
> physical SPI master device controlled by the host to a guest."
> 
virtio-spi is similar to virtio-i2c, so I update the description 
referring to the virtio-i2c specification.
> 
>> +
>> +In a typical host and guest architecture with Virtio SPI, Virtio SPI driver
>> +is the front-end and exists in the guest kernel, Virtio SPI device acts as
>> +the back-end and exists in the host. And VirtQueues assist Virtio SPI driver
>> +and Virtio SPI device in perform VRing operations for communication between
>> +the front-end and the back-end.
> 
> I'm not sure I can parse this properly -- does this mean that a
> virtqueue is used for communication between a front-end and a back-end?
yes, I also update the expression more clear.

> (Didn't look at the remainder of the patch yet.)
> 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

