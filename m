Return-Path: <virtio-dev-return-14201-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B728C4706F
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Dec 2023 04:16:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0A739157F17
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Dec 2023 04:16:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F2EB0986384
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Dec 2023 04:16:05 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E5F5F98637C; Tue, 26 Dec 2023 04:16:05 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D235B986378;
	Tue, 26 Dec 2023 04:16:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Message-ID: <0e8c5a22-ba7e-47db-9f72-f385d8f6d8bb@quicinc.com>
Date: Tue, 26 Dec 2023 12:15:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Harald Mommer <harald.mommer@opensynergy.com>,
        <virtio-dev@lists.oasis-open.org>,
        <virtio-comment@lists.oasis-open.org>, <cohuck@redhat.com>,
        <broonie@kernel.org>, <qiang4.zhang@linux.intel.com>,
        <viresh.kumar@linaro.org>
CC: <quic_ztu@quicinc.com>
References: <20231212033317.22198-1-quic_haixcui@quicinc.com>
 <20231212033317.22198-3-quic_haixcui@quicinc.com>
 <95dcd2c7-4b5b-4b04-8748-e9e65374d356@opensynergy.com>
 <d1f7cb96-c95f-4458-9b58-ea1e6335df55@quicinc.com>
 <47dd69ea-ca84-4a17-8cd4-0260e6f117a1@opensynergy.com>
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <47dd69ea-ca84-4a17-8cd4-0260e6f117a1@opensynergy.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vPRdEJc4z2dbtU0wrgL0VgMOFs5Gow9u
X-Proofpoint-ORIG-GUID: vPRdEJc4z2dbtU0wrgL0VgMOFs5Gow9u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312260028
Subject: Re: [virtio-dev][PATCH V9 2/2] virtio-spi: add the device
 specification

Hello Harald,

On 12/22/2023 10:32 PM, Harald Mommer wrote:
> Hello Haixu,
> 
> On 22.12.23 03:28, Haixu Cui wrote:
>> Hello Harald,
>>
>> On 12/21/2023 7:25 PM, Harald Mommer wrote:
>>> Hello,
>>>
>>> On 12.12.23 04:33, Haixu Cui wrote:
>>>> +\field{bits_per_word_mask} is a mask indicating which values of 
>>>> bits_per_word are supported.
>>>> +If bit n of \field{bits_per_word_mask} is set, the bits_per_word 
>>>> with value (n+1) is supported.
>>>> +If all bits are not set, bits_per_word can be any value from 1 to 32.
>>>
>>> "If all bits are not set" is not easy to understand as it means "if 
>>> no bit is set".
>>>
>>> You can of course specify the value 0 this way to make code more 
>>> complicated.
>>>
>>> To make code simple, 0 would be not given this special meaning. To 
>>> allow any value between 1 and 32 solely the value 0xFFFFFFFF would be 
>>> allowed. Which is already possible now without this additional 
>>> sentence for 0. Simply checking whether the respective bit is set in 
>>> the mask and done without having to add senseless additional code to 
>>> handle the special case that the mask is 0.
>>>
>>> Giving 0 the same meaning as 0xFFFFFFFF brings nothing except confusion.
>>>
>> Here I refer to the __spi_validate_bits_per_word in drivers/spi/spi.c, 
>> if bits_per_word_mask of spi controller is 0, no check will be done 
>> for bits_per_word parameter.
>>
>> Above is just the Linux mechanism, I agree with you, 0 and 0xFFFFFFFF 
>> have the same meaning will cause confusion in this spec. I prefer 
>> treating 0 as an invalid value because the backend must support at 
>> least one bits_per_word value.
>>
>> How about updating as:
>> For \field{bits_per_word_mask}, 0 is invalid because at least one 
>> bits_per_word value should be supported.
>>
>> Thanks & Regards
>> Haixu Cui
> 
> Interesting. I know that I had already a comment on this previously. And 
> also now. But sometimes I'm wrong. And here probably in both cases but 
> at least with my last comment.
> 
>   * @bits_per_word_mask: A mask indicating which values of bits_per_word 
> are
>   *    supported by the driver. Bit n indicates that a bits_per_word n+1 is
>   *    suported. If set, the SPI core will reject any transfer with an
>   *    unsupported bits_per_word. If not set, this value is simply ignored,
>   *    and it's up to the individual driver to perform any validation.
> 
> Tried to find out why this is so in Linux. The function 
> __spi_validate_bits_per_word() was introduced by commit 63ab645f4d8b. 
> The member variable bits_per_word_mask in struct spi_master was already 
> introduced by 543bb255a198. The new variable was introduced in a way so 
> that if not set the behavior would not change for existing SPI drivers 
> not (yet) setting the field. At least I deduce that looking into the 
> commits. Made a lot of sense to introduce bits_per_word_mask in commit 
> 543bb255a198 in Linux this way to make a change without causing other 
> changes everywhere. The virtio SPI specification is new, no need to be 
> backwards compatible here so there is no need to have 0 there as "don't 
> check" value. So your proposal to make 0 the invalid value is a good 
> one. So I thought.
> 
> On the other hand: The function __spi_validate_bits_per_word() does not 
> check for anything if bits_per_word_mask is 0. With 0 it does not check 
> for bits_per_word > 32 and it does not check for bits_per_word being a 
> power of 2. It never checks for bits_per_word > 0 but this is a 
> different issue.
> 
> 1.) Now I'm looking into a data sheet from Freescale
> 
> https://www.manualslib.com/manual/1376296/Freescale-Semiconductor-Mk22fn256vdc12.html?page=1053
> 
> and see that the chip can use any frame sizes from 4 to 32. Means also 
> frame sizes which are not a power of 2. Nothing I've seen before but it 
> exists. So the value 0 is indeed needed to allow for those values.
> 
> The chip can only support 4 to 32 bits, so with the 32 bit restriction 
> in the V9 draft we would be fine.
> 
> 2.) 
> https://community.nxp.com/t5/S32K/How-to-send-receive-64bit-or-longer-message-using-SPI/m-p/1476343#M15986
> 
> There are Bits/frame of 8, 10, 24, 32, 40, 64 mentioned in the example. 
> Not only that some of those are no power of 2 and cannot be represented 
> in this bit mask not having 0 but we have also 64 bit frame size. Means 
> restriction to 32 bits has also to fall to support something like this.
> 
> I looked further and found a data sheet from NXP in the internet which 
> should not be there. Maximum frame size for this chip is everything 
> between 8 bits and 4096-bits with some values in between excluded. As 
> bits_per_word is an u8 in Linux and in the draft spec something so 
> strange like this could not be supported by virtio spi nor in Linux.
> 
> => The normal case for the majority of people is 8, 16 and maybe also 32 
> bit SPI.
> 
> => The strange case is non power of 2 values which cannot be represented 
> in the mask not allowing 0. The V9 draft spec is perfect for this.
> 
> => Another strange case is big frame sizes > 32 bit.
> 
> The sentence in draft V7 (on which I moaned, sorry for this) was most 
> probably the perfect one: "If not set, there is no limitation for 
> bits_per_word."

Thank you very much for your detailed explanations.

There are such strange usage scenarios that frame size exceeds 32 bits, 
even 4096 bits. For these strange cases, It's impossible to use only 32 
bits bits_per_word_mask to enumerate all the conditions. Seems that a 
similar situation exists in Linux spi driver also.

Assume a case where the spi controller supports the frame size to be any 
value from 16 to 64, 32 bits mask can only cover the 16 ~ 32 conditions.

Even so, it's not a good idea to expand the bits_per_word_mask, 32 bits 
can cover most of the cases, except for some situations that are not 
commonly used. Besides, it's hard to determine the bit width to cover 
all the cases, and expanding will make the logic more complicated. To 
summarize, I think the following statement is probably proper:

"\field{bits_per_word_mask} is a mask indicating which values of
bits_per_word are supported. If bit n of \field{bits_per_word_mask} is 
set, the bits_per_word with value (n+1) is supported. If 
\field{bits_per_word_mask} is 0, there is no limitation for bits_per_word."

Do you think it is acceptable and appropriate?

Much appreciated, again.

Thanks
Haixu Cui

> 
> Regards
> Harald
> 
> 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

