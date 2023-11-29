Return-Path: <virtio-dev-return-14080-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99812C4167B
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Nov 2023 10:31:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 04971C6238
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Nov 2023 10:31:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EB5D7986646
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Nov 2023 10:31:48 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DD64998663F; Wed, 29 Nov 2023 10:31:48 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CBC579865ED;
	Wed, 29 Nov 2023 10:31:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Message-ID: <5367c2e6-93f1-4a4d-867e-0074b452052a@quicinc.com>
Date: Wed, 29 Nov 2023 18:31:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: Cornelia Huck <cohuck@redhat.com>, <virtio-dev@lists.oasis-open.org>,
        <virtio-comment@lists.oasis-open.org>, <harald.mommer@opensynergy.com>,
        <broonie@kernel.org>, <qiang4.zhang@linux.intel.com>,
        <quic_ztu@quicinc.com>, <alex.bennee@linaro.org>,
        <vincent.guittot@linaro.org>
References: <20231124072015.12655-1-quic_haixcui@quicinc.com>
 <20231127101750.6xmthho6lnppyw3k@vireshk-i7>
 <2ca987a6-eeb2-4ed6-9a12-10ae450eb4bf@quicinc.com>
 <20231129073022.ohxsfuawambvh3hm@vireshk-i7>
 <0674be8e-221f-479a-8da2-8a3e59e45bb9@quicinc.com>
 <871qc9x8k2.fsf@redhat.com>
 <9e0c5e5e-db7b-4634-9423-f4db1800b148@quicinc.com>
 <20231129100002.q73wtz6mkfixcbzt@vireshk-i7>
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <20231129100002.q73wtz6mkfixcbzt@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FwDVdeXBAneD1vO6j-vVCwHdzIRdGPGl
X-Proofpoint-GUID: FwDVdeXBAneD1vO6j-vVCwHdzIRdGPGl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_07,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 mlxlogscore=797 priorityscore=1501 bulkscore=0 mlxscore=0
 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311290078
Subject: [virtio-dev] Re: [virtio-comment] [PATCH] [PATCH v5] virtio-spi: add the device
 specification



On 11/29/2023 6:00 PM, Viresh Kumar wrote:
> On 29-11-23, 16:54, Haixu Cui wrote:
>> On 11/29/2023 4:33 PM, Cornelia Huck wrote:
>>> On Wed, Nov 29 2023, Haixu Cui <quic_haixcui@quicinc.com> wrote:
>>>> On 11/29/2023 3:30 PM, Viresh Kumar wrote:
>>>>> On 28-11-23, 20:58, Haixu Cui wrote:
>>>>>> On 11/27/2023 6:17 PM, Viresh Kumar wrote:
>>>>> Hmm, I worked with a SPI controller over a decade ago, and I must be forgetting
>>>>> something here I guess. But from whatever little I remember, with full-duplex
>>>>> transfer, data flows on both MOSI and MISO lines as soon as clock signal is
>>>>> applied.  And so amount of data sent is always be equal to amount of data
>>>>> received by both sides.
>>>>>
>>>>> Also if I see Linux's implementation of the `struct spi_transfer` [1], I see
>>>>> `tx_buf`, `rx_buf` and a single `len` field, which applies to both the buffers.
>>>>> Which I guess is indicating that both buffers are supposed to be of same length.
>>>>>
>>>>> What am I missing ?
>>>>
>>>> Oh so sorry for that. And I don't make it clear. Yes, tx_buf and rx_buf
>>>> have the same size, Linux has such restriction. Just as you mention,
>>>> kernel level spi_transfer has single "len", the same for
>>>> spi_ioc_transfer passed from the userland.
>>>>
>>>> But I am not sure if this is in the scope of the spec. Because this is
>>>> ensured by Linux, but Virtio SPI driver won't also can't verify this.
>>>> This is a prerequisite for virtio spi processing requests.
> 
> I don't think this is a Linux only thing. This is how the SPI protocol is
> designed to begin with. A clock is applied, data from FIFOs of both master and
> slaves gets exchanged over the MOSI and MISO lines... And the length is _always_
> the same. We are talking about the full-duplex mode of the hardware here and
> this is how it works AFAICT.
> 
> So the spec should clearly point this out to avoid any mistakes. Or if you have
> a usecase where you can have different lengths for tx and rx buffers, that I am
> not aware of ?

Hi Viresh,

     Thank you for your helpful comments. In next patch, I will clearly 
point this out:

     "For full-duplex read and write transfer, both \field{tx_buf} and 
\field{rx_buf} are used and the buffer size of \field{tx_buf} must be 
same as \field{rx_buf}."

     And in drivernormative section, I will add a requirement:
     "For full-duplex transfer, Virtio SPI driver MUST guarantee the 
write transfer size is equal to the read transfer size"

     In fact, in my prototype, I only perform the transfers with same 
tx/rx length.

     Much appreciated.

Best Regards
Haixu Cui
> 
>>>> What is your suggestion? How about adding some descriptions here, like
>>>> "for full-duplex, tx_buf and rx_buf are same in size, this is guaranteed
>>>> by the kernel"?
>>>
>>> We must not really make any assumptions in the spec about concrete
>>> implementations (here, the Linux kernel), as someone implementing it in
>>> a different environment will need to make explicit choices.
> 
> I agree. I pointed this out since this is how the protocol works.
> 
>>> So, if tx_buf and rx_buf are required to be of the same size, it needs
>>> to be explicitly stated in the spec, or an implementation might choose
>>> to do it differently.
> 
> --
> Viresh

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

