Return-Path: <virtio-dev-return-14045-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D3DC4332F
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Nov 2023 15:43:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0EB443E569
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Nov 2023 15:43:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F01AE986CB8
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Nov 2023 15:43:00 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E4FD4986CA8; Wed,  8 Nov 2023 15:43:00 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D0717986CA7;
	Wed,  8 Nov 2023 15:42:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Message-ID: <c08f1b37-51e8-4126-9e1c-40530f468df4@quicinc.com>
Date: Wed, 8 Nov 2023 23:42:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
CC: <virtio-dev@lists.oasis-open.org>, <virtio-comment@lists.oasis-open.org>,
        <harald.mommer@opensynergy.com>, <cohuck@redhat.com>,
        <quic_ztu@quicinc.com>
References: <20231024125346.23546-1-quic_haixcui@quicinc.com>
 <ZUjrDjHpFVReDSgk@finisterre.sirena.org.uk>
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <ZUjrDjHpFVReDSgk@finisterre.sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qEwLnyr_lSbRAW9yMx83whCGBFXscz-Y
X-Proofpoint-GUID: qEwLnyr_lSbRAW9yMx83whCGBFXscz-Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_04,2023-11-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 clxscore=1011 lowpriorityscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311080129
Subject: Re: [virtio-dev] [PATCH v4] virtio-spi: add the device specification

Hi Mark,
     Thank you for your comments, my response is below each of your 
comments.

On 11/6/2023 9:33 PM, Mark Brown wrote:
> On Tue, Oct 24, 2023 at 08:53:46PM +0800, Haixu Cui wrote:
> 
>> virtio-spi is a virtual SPI master and it allows a guest to operate and
>> use the physical SPI master controlled by the host.
> 
> It would be good to avoid introducing new uses of this outdated
> terminology, terms like controller are better.  This is especially true
> for specifications.

Yes! Will use "controller" instead of "master" in next patch.
> 
> It would be good to be copied on future versions of this.
> 
>> +\begin{lstlisting}
>> +struct virtio_spi_config {
>> +	le16 bus_num;
>> +	le16 chip_select_max_number;
> 
> That's a *lot* of potential buses and chip selects...

Here you mean the types of bus_num and chip_select_max_number are "le16"?

Here I use 16 bits because bus_num and num_chipselect in spi_controller 
structure are both 16 bits.

> 
>> +The \field{cs_timing_setting_enable} indicates if the physical SPI master supporting cs timing setting:
>> +	0: physical SPI master doesn't support cs timing setting;
>> +	1: physical SPI master supports cs timing setting.
> 
> This is very vauge - what exactly is meant by "cs timing setting"?  If
> we're specifying anything about timing it should probably be specific
> about which paramters might be controlled and the constraints on how
> they can be set.  It's also a bit surprising that the only parameter
> here is around chip select, there's generally a lot more sensitivity
> around the main clock.

Here I would like to say the support of 3 types of cs delay, that is, 
delay after cs asserted, delay before cs deasserted, delay after cs 
deasserted.

I will update as follows:

The \field{cs_timing_setting_enable} indicates if the host SPI 
controller supports cs delay setting when performing transfer:
         bit 0: delay after cs asserted, 0 means doesn't support and 1
                means support;
         bit 1: delay before cs deasserted, 0 means doesn't support and 1
                means support;
         bit 2: delay after cs deasserted, 0 means doesn't support and 1
                means support;
         other bits are reserved and always set as 0.


> 
>> +\begin{lstlisting}
>> +struct virtio_spi_transfer_head {
>> +        u8 slave_id;
> 
> More outdated terminology.
> 
>> +        u8 bits_per_word;
>> +        u8 cs_change;
>> +        u8 tx_nbits;
>> +        u8 rx_nbits;
>> +	 u8 reserved[3];
> 
> Indentation issue?

Yes, will fix in next patch.
> 
>> +        le32 mode;
>> +        le32 freq;
>> +        le32 word_delay_ns;
>> +        le32 cs_setup_ns;
>> +        le32 cs_delay_hold_ns;
>> +        le32 cs_change_delay_inactive_ns;
> 
> All these parameters depend on controller support but weren't included
> in the feature enumeration above and nothing in the spec seems to cover
> what happens when they can't be supported exactly.

Add another return value:
     #define VIRTIO_SPI_PARAM_ERR    1

If the parameters in \field{virtio_spi_transfer_head} are not all valid, 
or some fields are set as non-zero values but the corresponding features 
are not supported by host, then the backend return VIRTIO_SPI_PARAM_ERR 
to the frontend.

> 
>> +The \field{cs_change} indicates whether to deselect device before starting the
>> +next SPI transfer, 0 means chipselect keep asserted and 1 means chipselect deasserted
>> +then asserted again.
> 
> Note that this is *not* how Linux implements things, and it doesn't
> include any specification of timing constraints.
> 
>> +The \field{tx_nbits} indicates bus width for write transfer:
>> +        0,1: bus width is 1, also known as SINGLE;
>> +	2  : bus width is 2, also known as DUAL;
>> +	4  : bus width is 4, also known as QUAD;
>> +	8  : bus width is 8, also known as OCTAL;
>> +	other values are invalid.
> 
> Width here being in terms of bits.
> 
Updated as:
0,1: 1-bit transfer, also known as SINGLE;
...

>> +The \field{tx_buf} is the buffer for data sent to the device.
>> +
>> +The \field{rx_buf} is the buffer for data received to the device.
> 
> In what format are these buffers presented?  I note that the spec
> supports more than one byte per word (and non-integer number of bytes).

In spi_transfer struct:
     @len: size of rx and tx buffers (in bytes)

Although the bits_per_word can be any value in 0..32, in-memory 
wordsizes are powers of two bytes (e.g. 20 bit samples use 32 bits).
So:
     0 < bits_per_word <=8: one word occupies 1 byte in memory;
     8 < bits_per_word <=16: one word occupies 2 bytes in memory;
     16 < bits_per_word <=32: one word occupies 4 bytes in memory.

In the spec, the format of buffers are u8 array,
     u8 tx_buf[];
     u8 rx_buf[];


Thanks again for your comments and ideas.

Best Regards
Haixu Cui

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

