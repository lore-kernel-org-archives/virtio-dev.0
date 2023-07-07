Return-Path: <virtio-dev-return-13302-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA262C001B0
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 07:21:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 099622ACA4
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 07:21:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EE671986814
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 07:21:16 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DE9A7984091; Fri,  7 Jul 2023 07:21:16 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C9CE69867EB;
	Fri,  7 Jul 2023 07:21:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Message-ID: <46ab6180-c639-6da4-d6c3-dc8b87345de9@quicinc.com>
Date: Fri, 7 Jul 2023 15:21:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: Jonathon Reinhart <jrreinhart@google.com>
CC: Cornelia Huck <cohuck@redhat.com>, <quic_ztu@quicinc.com>,
        <virtio-dev@lists.oasis-open.org>,
        <virtio-comment@lists.oasis-open.org>
References: <000000000000925c1305ff1f7c76@google.com>
 <fd2e0d5d-a3e9-027a-bec1-d0e821ec6421@quicinc.com>
 <CAJJa5HxA6T+xv--80aWEtGWNx=a-yfNXwNsnyz3s8praHqg6Ew@mail.gmail.com>
Content-Language: en-US
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <CAJJa5HxA6T+xv--80aWEtGWNx=a-yfNXwNsnyz3s8praHqg6Ew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: O2RIo0wdBiaWf-6IkrBzl_vy4Mh09s5q
X-Proofpoint-GUID: O2RIo0wdBiaWf-6IkrBzl_vy4Mh09s5q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_04,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 spamscore=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070066
Subject: Re: [virtio-dev][PATCH 2/2] virtio-spi: add the device specification

Hi Jonathon Reinhart,

     Thank you so much for all your helpful advice and info!

     I took a look at latest Linux SPI driver and found, for 
cs_setup/cs_hold/cs_inactive set in device-tree, there are following two 
conditions:
     1) if SPI controller supports CS timing configuration and CS is not 
using a GPIO line, then the SPI driver set the 
cs_setup/cs_hold/ca_inactive values into the corresponding SPI CS registers;
     2) if CS is using a GPIO line, or SPI controller doesn't support CS 
timing configuration, it is the software to perform the 
cs_setup/cs_hold/cs_inactive delays, which is implemented in function 
spi_set_cs in driver/spi/spi.c.

     So I agree it is necessary to pass cs_setup/cs_hold/cs_inactive to 
the host for each transfer.

     For condition 1, host should set these values into the CS timing 
registers. And as you mentioned "one might require different CS 
setup/hold times, depending on which slave_id they are talking to (on 
the same bus)", if so, host need to overwrite the CS timing registers 
between the two transfers talking to different salve_id.

     For condition 2, SPI driver running in the host performing the 
cs_setup/cs_hold/cs_inactive delays seems more accurate, compared with 
performing delays in guest.


     And the latest virtio spi transfer structure is defined as follows:

      struct spi_transfer_head {
         u8 slave_id;
         u8 bits_per_word;
         u8 cs_change;
         u8 tx_nbits;
	u8 rx_nbits;
	u8 reserved[3];
         u32 mode;
         u32 freq;
         u32 word_delay_ns;
         u32 delay_ns;
         u32 cs_change_delay_ns;
         u32 cs_setup_ns;
         u32 cs_hold_ns;
         u32 cs_inactive_ns;
      };

      @slave_id: chipselect index the SPI transfer used
      @bits_per_word: the number of bits in each SPI transfer word
      @cs_change: True to deselect device before starting the next transfer
      @tx_nbits: number of bits used for writing
      @rx_nbits: number of bits used for reading
      @reserved: reserved for future use
      @mode: the spi mode defines how data is clocked out and in
      @freq: transfer speed
      @word_delay_ns: delay to be inserted between consecutive words of 
a transfer, in ns unit
      @delay_ns: delay to be introduced after this transfer before 
(optionally) changing the chipselect status, in ns unit
      @cs_change_delay_ns: delay between cs deassert and assert when 
cs_change is set, in ns unit
      @cs_setup_ns: delay to be introduced by the controller after CS is 
asserted, in ns unit
      @cs_hold_ns: delay to be introduced by the controller before CS is 
deasserted, in ns unit
      @cs_inactive_ns: delay to be introduced by the controller after CS 
is deasserted, in ns unit


     Could you please help check if this new structure contains enough 
information. Really appreciate for kind help.

Best Regards
Haixu Cui

On 7/1/2023 5:59 AM, Jonathon Reinhart wrote:
>> Hi @jrreinhart@google.com,
>>       Thank you very much for your helpful comments.
>>
>>       I missed the delay and cs_change_delay parameters. I will add both
>> of them, although cs_change_delay can not be set from userspace, but can
>> be set in kernel space.
>>
>>
>>       For CS delays such as PRE_DELAY/POST_DELAY, it seems that they are
>> defined in structure spi_device:
>>
>>       @cs_setup: delay to be introduced by the controller after CS is
>> asserted.
>>
>>       @cs_hold: delay to be introduced by the controller before CS is
>> deasserted.
>>
>>       @cs_inactive: delay to be introduced by the controller after CS is
>> deasserted. If @cs_change_delay is used from @spi_transfer, then the
>> two delays will be added up.
>>
>>       They show the SPI controller ability to control the CS
>> assertion/deassertion timing and should not be changed for each transfer
>> (because thay can be updated by setting structure spi_transfer or
>> structure spi_ioc_transfer). I think it better to define these parameter
>> in host OS rather than in guest OS since it's the host OS to operate the
>> hardware SPI controller directly. Besides, it can also avoid passing the
>> same values from guest to host time after time.
>>
>>       What's your opinion on this topic? Again, thank you very much.
> 
> Hi Haixu,
> 
> I took another look at the Linux structures and attempted to map up the
> delay parameters to the various points in a SPI sequence. Please correct
> me if I'm wrong about any of this.
> 
> Consider this diagram where CS# is an active-low chip select, and SCLK
> is the serial clock:
> 
>        ___.                                                   ._____.
>    CS#    |___________________________________________________|     |___
>           .                                                   .     .
>           .                                                   .     .
>   SCLK ________NNNN___NNNN___NNNN_______NNNN___NNNN___NNNN______________
>           .   .    . .           .     .                  .   .     .
> Delays:  +-A-+    +B+           +--C--+                  +-D-+--E--+
>           .   .    . .           .     .                  .   .     .
>           0   1    2 3           4     5                  6   7     8
>           .   .    .             .     .                  .   .
> Terms:   .   +Word+             .     .                  .   .
>           .   .                  .     .                  .   .
>           .   +-------Frame------+     +-------Frame------+   .
>           .                                                   .
>           +-----------------Transfer--------------------------+
> 
> Using NXP terminology:
> 
>    From 1 to 2 is a "word"     (with e.g. 8 bits).
>    From 1 to 4 is a "frame"    (with 3 words).
>    From 1 to 6 is a "transfer" (with 3 frames).
> 
> Linux does not have the concept of a frame, only a series of transfers
> (a spi_message), each of which can specify whether CS changes or not.
> 
> I've identified these various timing points and attempted to match them
> to the Linux spi_device and spi_transfer parameters:
> 
> A - CS Setup: Delay after CS asserted before clock starts.
>      spi_device.cs_setup
> 
> B - Word Delay: Delay between words.
>      spi_transfer.word_delay
> 
> C - Frame Delay: Delay between frames.
>      (Linux does not have the concept of a SPI "frame".)
> 
> D - CS Hold: Delay after clock stops, and before CS deasserted.
>      spi_device.cs_hold (+ spi_transfer.delay ??)
> 
> E - CS Inactive: Delay after CS deasserted, before asserting again.
>      spi_device.cs_inactive + spi_transfer.cs_change_delay
> 
> 
> While I agree with you that some of these timings are unlikely to change
> from transfer-to-transfer, the subset of which should be specified
> at the device level vs. per-transfer seems somewhat arbitrary. As you
> can see there is some overlap between them.
> 
> If I understand correctly, it appears that the CS hold time *can* be
> controlled on a per-transfer bases, using spi_transfer.delay
> ("after this transfer before changing the chipselect status").
> 
> That leaves CS setup as the only parameter that cannot be influenced on
> a per-transfer basis.
> 
> Theoretically, one might require different CS setup/hold times,
> depending on which slave_id they are talking to (on the same bus).
> In that case, one must set those spi_device parameters to the worst-case
> (maximum) values. However, this is already a Linux limitation, so I'm
> not sure it needs to be improved here.
> 
> I think you've achieved parity with what the Linux kernel API allows,
> and that's probably good enough. As you said, anything else can be
> adjusted in the host OS -- I'm not sure how the guest would go about
> achieving that, though. You're not proposing the use of configuration
> space for virtio-spi, are you?
> 
> Regards,
> Jonathon Reinhart
> 
> 
>>
>> Best Regards
>> Haixu Cui
>>
>> On 6/28/2023 1:06 AM, jrreinhart@google.com wrote:
>>> Hi Haixu,
>>>
>>>> +The \field{word_delay} defines how long to wait between words within
>>>> one SPI transfer,
>>>> +in ns unit.
>>>
>>> I'm a little surprised to see a word_delay but no frame_delay or
>>> transfer_delay.
>>>
>>> For example, many SPI peripherals require a delay after CS is asserted,
>>> but before the first SCLK edge, allowing them to prepare to send data.
>>> (E.g. an ADC might begin taking a sample.)
>>>
>>>
>>> The linux struct spi_transfer has three delay fields:
>>>
>>> * @cs_change_delay: delay between cs deassert and assert when
>>> *      @cs_change is set and @spi_transfer is not the last in
>>> *      @spi_message
>>> * @delay: delay to be introduced after this transfer before
>>> *    (optionally) changing the chipselect status, then starting the
>>> *    next transfer or completing this @spi_message.
>>> * @word_delay: inter word delay to be introduced after each word size
>>> *    (set by bits_per_word) transmission.
>>>
>>> The userspace spidev.h API has only two:
>>>
>>> * @delay_usecs: If nonzero, how long to delay after the last bit
>>> *       transfer before optionally deselecting the device before the
>>> *       next transfer.
>>> * @word_delay_usecs: If nonzero, how long to wait between words within
>>> *       one transfer. This property needs explicit support in the SPI
>>> *       controller, otherwise it is silently ignored.
>>>
>>> The NXP i.MX RT500 SPI (master) controller, for example, has four
>>> configurable delays:
>>>
>>> - PRE_DELAY: After CS assertion, before first SCLK edge.
>>> - POST_DELAY: After a transfer, before CS deassertion.
>>> - FRAME_DELAY: Between frames (which are arbitrarily defined by
>>>     software).
>>> - TRANSFER_DELAY: Minimum CS deassertion time between transfers.
>>>
>>> The NVIDIA Tegra114 SPI controller has:
>>>
>>> - nvidia,cs-setup-clk-count: CS setup timing parameter.
>>> - nvidia,cs-hold-clk-count: CS hold timing parameter.
>>>
>>>
>>> I understand that accurately representing all possible delays might be
>>> difficult or futile, but I'm curious to understand why, of all the
>>> possible delays, inter-word delay was chosen for inclusion.
>>>
>>> In a microcontroller, delays around CS (de)assertion can be customized
>>> by using a GPIO -- rather than the hardware SPI block -- to drive the CS
>>> signal. This way, delays can be inserted where needed. To do so with a
>>> virtualized SPI controller might prove difficult however, as the virtual
>>> channel carrying a CS GPIO signal might not be synchronized to the
>>> channel carrying the SPI data.
>>>
>>> Curious to hear your thoughts.
>>>
>>> Thanks,
>>> Jonathon Reinhart

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

