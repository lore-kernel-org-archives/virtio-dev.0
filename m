Return-Path: <virtio-dev-return-14192-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E90C46CD4
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Dec 2023 08:44:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 928972A820
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Dec 2023 08:44:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7E01698664C
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Dec 2023 08:44:20 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6E9579865BA; Thu, 21 Dec 2023 08:44:20 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5AE739865B8
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Dec 2023 08:44:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: qj0L6TJlPACTCK4bMYcMMA-1
From: Cornelia Huck <cohuck@redhat.com>
To: Haixu Cui <quic_haixcui@quicinc.com>, virtio-dev@lists.oasis-open.org,
 virtio-comment@lists.oasis-open.org, harald.mommer@opensynergy.com,
 broonie@kernel.org, qiang4.zhang@linux.intel.com, viresh.kumar@linaro.org
Cc: quic_ztu@quicinc.com
In-Reply-To: <e076f6b7-595e-4910-96c9-96366faadfe8@quicinc.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy
 Ross"
References: <20231212033317.22198-1-quic_haixcui@quicinc.com>
 <20231212033317.22198-3-quic_haixcui@quicinc.com>
 <87wmtbg4ad.fsf@redhat.com>
 <e076f6b7-595e-4910-96c9-96366faadfe8@quicinc.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Thu, 21 Dec 2023 09:44:09 +0100
Message-ID: <87cyv0eyhy.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: Re: [virtio-dev][PATCH V9 2/2] virtio-spi: add the device
 specification

On Thu, Dec 21 2023, Haixu Cui <quic_haixcui@quicinc.com> wrote:

> Hi Cornelia,
>      Much appreciated for your comments and please refer to my response.
>
> On 12/18/2023 7:04 PM, Cornelia Huck wrote:
>> On Tue, Dec 12 2023, Haixu Cui <quic_haixcui@quicinc.com> wrote:
>> 
>> [BTW: A changelog would be useful, either in the patch or in the cover
>> letter.]
>
> Sure, I summarize the major changes between these versions and will add 
> in next patch:
>
> changelog:
> v8->v9:
> - add explanation of bits_per_word_mask in config space
> v7->v8:
> - change device to host
> v6->v7:
> - fix the format problem, syntax problem
> v5->v6:
> - use driver/device instead guest/host
> - add the definition of some terminologies
> - use controller instead of master throughout the spec
> - add buffer length validation for full-duplex transfer
> v4->v5:
> - use controller instead of master
> - fix indentation issue
> - extend the config space to expose the backend supported features
> - add another result value to indicate parameter error
> - add device and driver requirement about parameter checkig
> v3->v4:
> - fix the spell error
> - bus_num is not SOC-specific, remove it
> - add driver requirement to deal with the situation that the cs delay
> parameters are not 0 but the backend doesn't support cs timing setting
> v2->v3
> - remove unnecessary statements and driver implimentation details
> - add the parameters about cs timing delay and transfer delay
> - use "le32" instead of "u32"
> - swap the rx_buf and tx_buf in the request format
> - add the parameters about transfer bit width
> v1->v2:
> - explain SPI when it is firstly used
> - update the ambiguous expression of virtqueue
> v0->v1:
> - add definition of abbreviation SPI
> - remove the ID

Thanks. Might be best to add this in the cover letter.

> ---
>
>> 
>>> The Virtio SPI (Serial Peripheral Interface) device is a virtual
>>> SPI controller that allows the driver to operate and use the SPI
>>> controller under the control of the host.
>>>
>>> This patch adds the specification for virtio-spi.
>>>
>>> Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
>>> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
>>> ---
>>>   device-types/spi/description.tex        | 281 ++++++++++++++++++++++++
>>>   device-types/spi/device-conformance.tex |   7 +
>>>   device-types/spi/driver-conformance.tex |   7 +
>>>   3 files changed, 295 insertions(+)
>>>   create mode 100644 device-types/spi/description.tex
>>>   create mode 100644 device-types/spi/device-conformance.tex
>>>   create mode 100644 device-types/spi/driver-conformance.tex
>>>
>>> diff --git a/device-types/spi/description.tex b/device-types/spi/description.tex
>> 
>> Please move inclusion of this new file into content.tex here, instead of
>> including a not-yet-existing file in the previous patch.
>> 
>> (...)
>
>
> Sorry, I don't quite understand here. Maybe I should not add the 
> following line in content.tex, is that so?
>
> \input{device-types/spi/description.tex}

No, please add this line; but do so in this patch instead of the
previous one that only changes the wording.

>
>> 
>>> +\field{mode_func_supported} indicates whether the following features are supported or not:
>>> +        bit 0-1: CPHA feature,
>>> +            0b00: invalid, must support as least one CPHA setting.
>>> +            0b01: supports CPHA=0 only;
>>> +            0b10: supports CPHA=1 only;
>>> +            0b11: supports CPHA=0 and CPHA=1;
>>> +
>>> +        bit 2-3: CPOL feature,
>>> +            0b00: invalid, must support as least one CPOL setting.
>>> +            0b01: supports CPOL=0 only;
>>> +            0b10: supports CPOL=1 only;
>>> +            0b11: supports CPOL=0 and CPOL=1;
>>> +
>>> +        bit 4: chipselect active high feature, 0 for unsupported and 1 for supported,
>>> +            chipselect active low must always be supported.
>>> +
>>> +        bit 5: LSB first feature, 0 for unsupported and 1 for supported, MSB first must always be
>>> +            supported.
>>> +
>>> +        bit 6: loopback mode feature, 0 for unsupported and 1 for supported, normal mode
>>> +            must always be supported.
>>> +
>>> +Note: CPOL is clock polarity and CPHA is clock phase. If CPOL is 0, the clock idles at the logical
>>> +low voltage, otherwise it idles at the logical high voltage. CPHA determines how data is outputted
>>> +and sampled.
>> 
>> Shouldn't you also specify what CPHA==0 and CPHA==1 mean?
>> 
>
> Yes, I will add the following explanation:
>
> If CPHA is 0, the first bit is outputted immediately when chipselect is 
> active and subsequent bits are outputted on the clock edges when clock 

s/when clock/when the clock/

> transitions from active level to idle level. Data is sampled on the 
> clock edges when clock transitions from idle level to active level.

same

>
> If CPHA is 1, the first bit is outputted on the fist clock edge after 
> chipselect is active, subsequent bits are outputted on the clock edges 
> when clock transitions from idle level to active level. Data is sampled 

same

> on the clock edges when clock transitions from active level to idle level.

same


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

