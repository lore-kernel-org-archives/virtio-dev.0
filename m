Return-Path: <virtio-dev-return-14050-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 943CBC4332F
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Nov 2023 11:22:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DBB0242A7F
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Nov 2023 11:22:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D2D01986CDF
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Nov 2023 11:22:12 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C75A5986CCE; Thu,  9 Nov 2023 11:22:12 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B655B986CCF;
	Thu,  9 Nov 2023 11:22:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Message-ID: <ab11fb3c-296f-41a3-92c7-2e8dddb4369f@quicinc.com>
Date: Thu, 9 Nov 2023 19:21:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>,
        Harald Mommer
	<harald.mommer@opensynergy.com>
CC: <virtio-dev@lists.oasis-open.org>, <virtio-comment@lists.oasis-open.org>,
        <harald.mommer@opensynergy.com>, <cohuck@redhat.com>,
        <quic_ztu@quicinc.com>
References: <20231024125346.23546-1-quic_haixcui@quicinc.com>
 <ZUjrDjHpFVReDSgk@finisterre.sirena.org.uk>
 <c08f1b37-51e8-4126-9e1c-40530f468df4@quicinc.com>
 <ZUuxfbkSboAFQIQF@finisterre.sirena.org.uk>
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <ZUuxfbkSboAFQIQF@finisterre.sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: f8rkKW4-VagrPrCOH5pbhn_zzxNi9mH2
X-Proofpoint-ORIG-GUID: f8rkKW4-VagrPrCOH5pbhn_zzxNi9mH2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_10,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311090083
Subject: Re: [virtio-dev] [PATCH v4] virtio-spi: add the device specification

Hi Mark,

     For the "le16" type and byte ordering issue, Harald replies in 
another email, let's mainly discuss about checking parameters and 
exposing the backend supported features.


     struct virtio_spi_transfer_head {
         u8 chip_select;
         u8 bits_per_word;
         u8 cs_change;
         u8 tx_nbits;
         u8 rx_nbits;
         u8 reserved[3];
         le32 mode;
         le32 freq;
         le32 word_delay_ns;
         le32 cs_setup_ns;
         le32 cs_delay_hold_ns;
         le32 cs_change_delay_inactive_ns;
    };

    For checking the parameters above in virtio_spi_transfer_head, I'd 
like to add these field in config space:

     1. bits_per_word_mask, in Linux spi driver, 
__spi_validate_bits_per_word will use this field to validate 
bits_per_word parameters for each transfer

     2. cs_change_supported, 0 for unsupported and 1 for supported

     3. tx_nbits and rx_nbits:
        bit 0: 2-bit transfer supported;
        bit 1: 4-bit transfer supported;
        bit 2: 8-bit transfer supported;
        other bits reserved as 0, and 1-bit transfer should always 
supported.

     4. mode_feature_supported:
        bit 0-1: CPHA supported,
                 0b00: supports CPHA=0 and CPHA=1
                 0b01: only supports CPHA=0
                 0b10: only supports CPHA=1
                 0b11: invalid, should support as least one CPHA setting
        bit 2-3: CPOL supported
                 0b00: supports CPOL=0 and CPOL=1
                 0b01: only supports CPOL=0
                 0b10: only supports CPOL=1
                 0b11: invalid, should support as least one CPOL setting
        bit 4: CS_HIGH, if 1, supports chipselect active high, else
                 only supports chepselect active low.
        bit 3: LSB_FIRST, if 0, only supports MSB first transfer, if 1,
                 supports LSB first transfer
        bit 4: LOOP, if 1, support loopback mode, if 0, only supports
                 normal mode.

     5. freq_max_speed: if non-zero, maximum clock rate support, in Hz
                 unit. if 0, no limitation.

     6. max_word_delay_ns: if non-zero, the maximum word delay supported.
                 if 0, word delay is not supported to introduce.

     7. max_delay_after_cs_asserted: if non-zero, the maximum cs setup
                 delay supported.if 0, cs setup delay is not supported to
                 introduce

     8. max_delay_before_cs_deassert: if non-zero, the maximum
                 cs_delay_hold_ns delay supported.if 0, cs setup delay is
                 not supported to introduce

     9. max_delay_after_cs_deassert: if non-zero, the maximum
                 cs_change_delay_inactive_ns delay supported.if 0, cs
                 setup delay is not supported to introduce


Driver Requirement：

If Virtio SPI device announce it doesn't support any feature, Virtio SPI 
driver MUST reject the request if the corresponding feature field in 
request header is not zero.

Virtio SPI driver MUST reject the request if the freq exceeds the 
non-zero value of freq_max_speed filed in config space.

If any delay field in config space is set as non-zero, Virtio SPI driver 
MUST reject the request if the corresponding delay in request header 
exceeds the value in config space.


Do you think this mechanism, backend exposing its supported features and 
abilities through config space so Virtio SPI driver can filter and check 
before sending requests, is reasonable? And seems much stronger. A rule 
to validate seems necessary because the parameters in request header may 
differ in each transfer.

Looking forward to your advice and suggestion, if you agree that this 
mechanism is better, I will add it in next patch. Thank you so much.

Best Regard
Haixu Cui


On 11/9/2023 12:04 AM, Mark Brown wrote:
> On Wed, Nov 08, 2023 at 11:42:40PM +0800, Haixu Cui wrote:
>> On 11/6/2023 9:33 PM, Mark Brown wrote:
>>> On Tue, Oct 24, 2023 at 08:53:46PM +0800, Haixu Cui wrote:
> 
>>>> +	le16 bus_num;
>>>> +	le16 chip_select_max_number;
> 
>>> That's a *lot* of potential buses and chip selects...
> 
>> Here you mean the types of bus_num and chip_select_max_number are "le16"?
> 
>> Here I use 16 bits because bus_num and num_chipselect in spi_controller
>> structure are both 16 bits.
> 
> Yeah, I think that's more for padding/alignment reasons than anything
> else.  TBH I wondered if just going for a standard int might be better,
> it's the combination of picking a smaller type but one that's relatively
> large for the domain.
> 
>> The \field{cs_timing_setting_enable} indicates if the host SPI controller
>> supports cs delay setting when performing transfer:
>>          bit 0: delay after cs asserted, 0 means doesn't support and 1
>>                 means support;
>>          bit 1: delay before cs deasserted, 0 means doesn't support and 1
>>                 means support;
>>          bit 2: delay after cs deasserted, 0 means doesn't support and 1
>>                 means support;
>>          other bits are reserved and always set as 0.
> 
> That looks a lot clearer.  There's still a potential issue with the fact
> that there might be limited configurability (eg, only a few values
> supported).  Perhaps we need a discovery mechanism, or perhaps
> specifying handling of inexact support might be good enough (see below)?
> 
>>>> +        le32 mode;
>>>> +        le32 freq;
>>>> +        le32 word_delay_ns;
>>>> +        le32 cs_setup_ns;
>>>> +        le32 cs_delay_hold_ns;
>>>> +        le32 cs_change_delay_inactive_ns;
> 
>>> All these parameters depend on controller support but weren't included
>>> in the feature enumeration above and nothing in the spec seems to cover
>>> what happens when they can't be supported exactly.
> 
>> Add another return value:
>>      #define VIRTIO_SPI_PARAM_ERR    1
> 
>> If the parameters in \field{virtio_spi_transfer_head} are not all valid, or
>> some fields are set as non-zero values but the corresponding features are
>> not supported by host, then the backend return VIRTIO_SPI_PARAM_ERR to the
>> frontend.
> 
> That looks good for things like the mode, for the frequencies, delays
> and so on it seems like we need either some specified handling of values
> that can't be supported exactly (eg, freq is a maximum, delays are a
> minimum) or an enumeration mechanism so the guest knows what values will
> be accepted.  The enumeration might be a bit unweildy since you can get
> huge numbers of values - Linux currently uses the latter approach.
> 
>>>> +The \field{tx_buf} is the buffer for data sent to the device.
>>>> +
>>>> +The \field{rx_buf} is the buffer for data received to the device.
>>>
>>> In what format are these buffers presented?  I note that the spec
>>> supports more than one byte per word (and non-integer number of bytes).
>>
>> In spi_transfer struct:
>>      @len: size of rx and tx buffers (in bytes)
>>
>> Although the bits_per_word can be any value in 0..32, in-memory wordsizes
>> are powers of two bytes (e.g. 20 bit samples use 32 bits).
>> So:
>>      0 < bits_per_word <=8: one word occupies 1 byte in memory;
>>      8 < bits_per_word <=16: one word occupies 2 bytes in memory;
>>      16 < bits_per_word <=32: one word occupies 4 bytes in memory.
>>
>> In the spec, the format of buffers are u8 array,
>>      u8 tx_buf[];
>>      u8 rx_buf[];
> 
> What byte ordering are the multi-byte words in - CPU native or a
> particular endianness (eg, wire native)?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

