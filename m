Return-Path: <virtio-dev-return-13580-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA14EE4996
	for <virtio-dev@archiver.kernel.org>; Tue, 22 Aug 2023 13:44:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 61D382B014
	for <virtio-dev@archiver.kernel.org>; Tue, 22 Aug 2023 13:44:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 49E569863A9
	for <virtio-dev@archiver.kernel.org>; Tue, 22 Aug 2023 13:44:20 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 34F16986377; Tue, 22 Aug 2023 13:44:20 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 22EF2986378
	for <virtio-dev@lists.oasis-open.org>; Tue, 22 Aug 2023 13:44:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Message-ID: <7a6e617b-4a1b-80fd-04b1-30fe0ba0b988@quicinc.com>
Date: Tue, 22 Aug 2023 21:43:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To: Harald Mommer <harald.mommer@opensynergy.com>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "cohuck@redhat.com" <cohuck@redhat.com>
CC: "quic_ztu@quicinc.com" <quic_ztu@quicinc.com>,
        Mikhail Golubev-Ciuchea
	<Mikhail.Golubev-Ciuchea@opensynergy.com>
References: <20230417140353.870-1-quic_haixcui@quicinc.com>
 <20230417140353.870-3-quic_haixcui@quicinc.com>
 <ae8892c5-5eb2-72c9-9b74-cde7162094a2@opensynergy.com>
 <bca0df0a-2111-1f2f-69a9-3a2ea08fd37a@quicinc.com>
 <4374acf6-ecea-3a02-1058-42521beef0d7@opensynergy.com>
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <4374acf6-ecea-3a02-1058-42521beef0d7@opensynergy.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LJA9fMdTsYFchgLWo7gO4ID0syoBZzGV
X-Proofpoint-GUID: LJA9fMdTsYFchgLWo7gO4ID0syoBZzGV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_13,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 adultscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308220104
Subject: Re: [virtio-dev][PATCH 2/2] virtio-spi: add the device specification

Hi Harald Mommer,

     Thank you for your comments and please refer to my following replies.

On 8/10/2023 6:40 PM, Harald Mommer wrote:
> Hello,
> 
> a quick incomplete on. I'm currently with both hands in an attempt to 
> implement a virtio SPI device for our proprietary hypervisor based on 
> the draft specification and your E-Mail. Means I see now some more 
> things while implementing.
> 
> u32 len; /* @len: transfer length.*/
> 
> is this a byte or a word count?
> 
> The comment in Linux for the length field in struct spi_ioc_transfer is
> 
> /* @len: Length of tx and rx buffers, in bytes. */ so I assume this here 
> is also a byte count.
> 
> As we have only one len I think it's still needed to look at the device 
> readable and device writable descriptor sizes to decide on half duplex 
> read, half duplex write or full duplex. Having still to do this the 
> transfer length in the len field may be redundant (superfluous) 
> information.

"len" is byte count.

You are right, "len" parameter seems redundant. Virtqueue used to pass 
parameters between front-end and back-end and its descriptor is defined 
as follows(refer to: 
https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/listings/virtio_queue.h): 


struct virtq_desc {
         /* Address (guest-physical). */
         le64 addr;
         /* Length. */
         le32 len;
         /* The flags as indicated above. */
         le16 flags;
         /* We chain unused descriptors via this, too */
         le16 next;
};

For the rx_buf or tx_buf descriptor, len member shows the transfer 
length, so it is not necessary to pass "len" in the head structure.
I will remove "len" in next version.


> 
> No problem with this, I'm now only at a point where I want to be sure 
> whether this is meant as a byte length (vs. a word length).
> 
> Then there is no u32. There is le32. Only RPMB uses be32 but they have a 
> special reason to do this. The byte order must be defined for 16 and 32 
> bit values!

Yes! Use "le32" instead of "u32" in next patch.

> 
> On 20.07.23 09:50, Haixu Cui wrote:
>> Hi Harald Mommer,
>>
>>     Thank you so much for all your helpful advice and info!
>>
>>     I have updated the transfer request as follows:
>>
>>     struct spi_transfer_head {
>>           u8 slave_id;
>>           u8 bits_per_word;
>>           u8 cs_change;
>>           u8 tx_nbits;
>>           u8 rx_nbits;
>>           u8 reserved[3];
>>           u32 len;
>>           u32 mode;
>>           u32 freq;
>>           u32 word_delay_ns;
>>           u32 cs_setup_ns;
>>           u32 cs_delay_hold_ns;
>>           u32 cs_change_delay_inactive_ns;
>>     };
>>
>>     struct spi_transfer_end {
>>           u8 result;
>>     };
> May become "struct spi_transfer_result result" for naming reasons with 
> same content, see below. Just a proposal which may not be followed, see 
> below.
>>
>>     struct virtio_spi_transfer_req {
>>         struct spi_transfer_head head;
>>         u8 rx_buf[];
>>         u8 tx_buf[];
>>         struct spi_end end;
> Above this was "struct spi_transfer_end"
>>
>>     };

Agreed! Will change to "struct spi_transfer_result".

>>
> Device readable must go before device writable. So rx_buf[] and tx_buf[] 
> still have to be swapped.

Yes, rx_buf and tx_buf should be swapped.

> 
> I need to separate struct virtio_spi_transfer_req in my C implementation to
> 
> struct virtio_spi_transfer_req_out { /* Device readable */
>      struct spi_transfer_head head;
>      u8 tx_buf[]; /* Variable array at the end of the structure, gcc is 
> happy */
> };
> 
> struct virtio_spi_transfer_req_in { /* Device writable */
>      u8 rx_buf[];
>      /* "struct spi_transfer_end result;" is behind rx_buf but variable 
> array must be last element for gcc for reasons */
> };
> 
> Means you have to calculate the address where the result code is to be 
> written from some length information. Can be done. But then I should be 
> sure about the address. And this I can only be after all the length 
> information (head, device writable) are checked for consistency. Clumsy 
> and asking for mistakes.
> 
> However what also could be done (but you may have to obey alignment 
> requirement for rx_buf[] when words are transferred and may have to add 
> some padding in "struct spi_transfer_result", I don't know this currently):
> 
> struct virtio_spi_transfer_req_in { /* Device writable */
>      struct spi_transfer_result result; /* The result code is the 1st 
> device writable byte */
>      u8 rx_buf[];
> };
> 
> With this definition there was no need to calculate the address of the 
> result byte. Just a thought to make life easier.

As I just mentioned, front-end sends the buffer base address and 
transfer length to the back-end using virtq_desc structure, rather than 
sending the data directly.
And the virtq_desc length is always 16 bytes, so there has nothing to do 
with the sending order.

> 
>> Also I add the member and field definition as follows:
>>
>>     @slave_id: chipselect index the SPI transfer used.
>>
>>     @bits_per_word: the number of bits in each SPI transfer word.
>>
>>     @cs_change: whether to deselect device after finishing this transfer
>>         before starting the next transfer, 0 means cs keep asserted and
>>         1 means cs deasserted then asserted again.
>>
>>     @tx_nbits: bus width for write transfer.
>>         0,1: bus width is 1, also known as SINGLE
>>         2  : bus width is 2, also known as DUAL
>>         4  : bus width is 4, also known as QUAD
>>         8  : bus width is 8, also known as OCTAL
>>         other values are invalid.
>>
>>     @rx_nbits: bus width for read transfer.
>>         0,1: bus width is 1, also known as SINGLE
>>         2  : bus width is 2, also known as DUAL
>>         4  : bus width is 4, also known as QUAD
>>         8  : bus width is 8, also known as OCTAL
>>         other values are invalid.
>>
>>     @reserved: for future use.
>>
>>     @len: transfer length.
> Improve comment!

Actually, it is byte count.
len will be removed.

>>
>>     @mode: SPI transfer mode.
>>         bit 0: CPHA, determines the timing (i.e. phase) of the data
>>             bits relative to the clock pulses.For CPHA=0, the
>>             "out" side changes the data on the trailing edge of the
>>             preceding clock cycle, while the "in" side captures the data
>>             on (or shortly after) the leading edge of the clock cycle.
>>             For CPHA=1, the "out" side changes the data on the leading
>>             edge of the current clock cycle, while the "in" side
>>             captures the data on (or shortly after) the trailing edge of
>>             the clock cycle.
>>         bit 1: CPOL, determines the polarity of the clock. CPOL=0 is a
>>             clock which idles at 0, and each cycle consists of a pulse
>>             of 1. CPOL=1 is a clock which idles at 1, and each cycle
>>             consists of a pulse of 0.
>>         bit 2: CS_HIGH, if 1, chip select active high, else active low.
>>         bit 3: LSB_FIRST, determines per-word bits-on-wire, if 0, MSB
>>             first, else LSB first.
>>         bit 4: LOOP, loopback mode.
>>
>>     @freq: the transfer speed in Hz.
>>
>>     @word_delay_ns: delay to be inserted between consecutive words of a
>>         transfer, in ns unit.
>>     @cs_setup_ns: delay to be introduced after CS is asserted, in ns
>>         unit.
>>     @cs_delay_hold_ns: delay to be introduced before CS is deasserted
>>         for each transfer, in ns unit.
>>     @cs_change_delay_inactive_ns: delay to be introduced after CS is
>>         deasserted and before next asserted, in ns unit.
>>
>>
>>     Could you please help review the transfer request above again to 
>> check if the interface is clear and enough for back-end to perform SPI 
>> transfers. Thank you again for your comments. 
> I'm working and I'll come back on this.
>> Best Regards
>> Haixu Cui 
> 
> Regards
> Harald Mommer
> 
> 

According to your helpful comments and suggestion, I will submit another 
patch as soon as possible.

Best Regards & Thanks
Haixu Cui

> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

