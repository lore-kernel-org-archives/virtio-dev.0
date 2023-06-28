Return-Path: <virtio-dev-return-13118-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4830AEB64DC
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 09:44:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 849F926A46
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 09:44:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7A5BF9865CA
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 09:44:45 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6F7D598656E; Wed, 28 Jun 2023 09:44:45 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5983198656F;
	Wed, 28 Jun 2023 09:44:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Message-ID: <fd2e0d5d-a3e9-027a-bec1-d0e821ec6421@quicinc.com>
Date: Wed, 28 Jun 2023 17:44:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: <jrreinhart@google.com>
CC: Cornelia Huck <cohuck@redhat.com>, <quic_ztu@quicinc.com>,
        <virtio-dev@lists.oasis-open.org>,
        <virtio-comment@lists.oasis-open.org>
References: <000000000000925c1305ff1f7c76@google.com>
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <000000000000925c1305ff1f7c76@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mNRxlDHyG9mbjSMvEGKIIZ-z4VlKFxu5
X-Proofpoint-GUID: mNRxlDHyG9mbjSMvEGKIIZ-z4VlKFxu5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_06,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 phishscore=0 mlxlogscore=622
 lowpriorityscore=0 clxscore=1011 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280084
Subject: Re: [virtio-dev][PATCH 2/2] virtio-spi: add the device specification

Hi @jrreinhart@google.com,
     Thank you very much for your helpful comments.

     I missed the delay and cs_change_delay parameters. I will add both 
of them, although cs_change_delay can not be set from userspace, but can 
be set in kernel space.


     For CS delays such as PRE_DELAY/POST_DELAY, it seems that they are 
defined in structure spi_device:

     @cs_setup: delay to be introduced by the controller after CS is 
asserted.

     @cs_hold: delay to be introduced by the controller before CS is 
deasserted.

     @cs_inactive: delay to be introduced by the controller after CS is
deasserted. If @cs_change_delay is used from @spi_transfer, then the
two delays will be added up.

     They show the SPI controller ability to control the CS 
assertion/deassertion timing and should not be changed for each transfer 
(because thay can be updated by setting structure spi_transfer or 
structure spi_ioc_transfer). I think it better to define these parameter 
in host OS rather than in guest OS since it's the host OS to operate the 
hardware SPI controller directly. Besides, it can also avoid passing the 
same values from guest to host time after time.

     What's your opinion on this topic? Again, thank you very much.

Best Regards
Haixu Cui

On 6/28/2023 1:06 AM, jrreinhart@google.com wrote:
> Hi Haixu,
> 
>> +The \field{word_delay} defines how long to wait between words within
>> one SPI transfer,
>> +in ns unit.
> 
> I'm a little surprised to see a word_delay but no frame_delay or
> transfer_delay.
> 
> For example, many SPI peripherals require a delay after CS is asserted,
> but before the first SCLK edge, allowing them to prepare to send data.
> (E.g. an ADC might begin taking a sample.)
> 
> 
> The linux struct spi_transfer has three delay fields:
> 
> * @cs_change_delay: delay between cs deassert and assert when
> *      @cs_change is set and @spi_transfer is not the last in
> *      @spi_message
> * @delay: delay to be introduced after this transfer before
> *    (optionally) changing the chipselect status, then starting the
> *    next transfer or completing this @spi_message.
> * @word_delay: inter word delay to be introduced after each word size
> *    (set by bits_per_word) transmission.
> 
> The userspace spidev.h API has only two:
> 
> * @delay_usecs: If nonzero, how long to delay after the last bit
> *       transfer before optionally deselecting the device before the
> *       next transfer.
> * @word_delay_usecs: If nonzero, how long to wait between words within
> *       one transfer. This property needs explicit support in the SPI
> *       controller, otherwise it is silently ignored.
> 
> The NXP i.MX RT500 SPI (master) controller, for example, has four
> configurable delays:
> 
> - PRE_DELAY: After CS assertion, before first SCLK edge.
> - POST_DELAY: After a transfer, before CS deassertion.
> - FRAME_DELAY: Between frames (which are arbitrarily defined by
>    software).
> - TRANSFER_DELAY: Minimum CS deassertion time between transfers.
> 
> The NVIDIA Tegra114 SPI controller has:
> 
> - nvidia,cs-setup-clk-count: CS setup timing parameter.
> - nvidia,cs-hold-clk-count: CS hold timing parameter.
> 
> 
> I understand that accurately representing all possible delays might be
> difficult or futile, but I'm curious to understand why, of all the
> possible delays, inter-word delay was chosen for inclusion.
> 
> In a microcontroller, delays around CS (de)assertion can be customized
> by using a GPIO -- rather than the hardware SPI block -- to drive the CS
> signal. This way, delays can be inserted where needed. To do so with a
> virtualized SPI controller might prove difficult however, as the virtual
> channel carrying a CS GPIO signal might not be synchronized to the
> channel carrying the SPI data.
> 
> Curious to hear your thoughts.
> 
> Thanks,
> Jonathon Reinhart

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

