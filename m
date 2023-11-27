Return-Path: <virtio-dev-return-14070-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC88C07CB1
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Nov 2023 14:26:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4113B192314
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Nov 2023 14:26:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 31F449863D6
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Nov 2023 14:26:51 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 23D3C9863A1; Mon, 27 Nov 2023 14:26:51 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 169C39863A5
	for <virtio-dev@lists.oasis-open.org>; Mon, 27 Nov 2023 14:26:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: WUtgN4HhOaKtpBu8oVCtdg-1
From: Cornelia Huck <cohuck@redhat.com>
To: Haixu Cui <quic_haixcui@quicinc.com>, virtio-dev@lists.oasis-open.org,
 virtio-comment@lists.oasis-open.org, harald.mommer@opensynergy.com,
 broonie@kernel.org, qiang4.zhang@linux.intel.com
Cc: quic_ztu@quicinc.com
In-Reply-To: <e293b937-42ff-43ba-80c0-bc4683f48db7@quicinc.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy
 Ross"
References: <20231124072015.12655-1-quic_haixcui@quicinc.com>
 <87ttpbxiga.fsf@redhat.com>
 <e293b937-42ff-43ba-80c0-bc4683f48db7@quicinc.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Mon, 27 Nov 2023 15:26:42 +0100
Message-ID: <87il5nxof1.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [PATCH] [PATCH v5] virtio-spi: add the device specification

On Mon, Nov 27 2023, Haixu Cui <quic_haixcui@quicinc.com> wrote:

> On 11/24/2023 11:46 PM, Cornelia Huck wrote:
>> On Fri, Nov 24 2023, Haixu Cui <quic_haixcui@quicinc.com> wrote:
>>> +The \field{chip_select_max_number} is the maximum number of chipselect the host SPI controller supports.
>> 
>> "chipselect" is probably a known term for people familiar with SPI -- is
>> there any definition of those terms that the spec can point to?
>
> Just as Mark said, there is no formal spec for SPI, so no standard spec 
> for such terms referring to. The same for CPHA/CPOL/LSB/MSB, please see 
> below.

If we have nothing to point to, it is probably best to simply
expand/explain the terms on their first usage.

>> Can we point to some documentation that explains CPHA and CPOL?
>
> Here. No standard SPI spec to point to. CPOL/CPHA have definitions in 
> wikipedia(Clock polarity and phase chapter):
>
> https://en.wikipedia.org/wiki/Serial_Peripheral_Interface
>
> How about copying some concise information from wikipedia as Note? Or is 
> referring to such webpage acceptable in this spec.

Not sure if we can do an outright copy (licence compatibility), but
paraphrasing should be fine. (I'd rather not directly reference the
site, because the content is not guaranteed to be stable, but we could
maybe add it as "further reading".)

>>> +For each transfer request, Virtio SPI driver MUST check the fields in structure \field{virtio_spi_transfer_head}
>>> +and MUST reject the request if any filed is invalid or enabling the features not supported by host.
>> 
>> s/filed/field/
>> s/host/device/
>> 
>> Also, isn't the rejecting supposed to be done by the device, as the
>> driver is the party enqueueing the requests? Or do I have some kind of
>> fundamental misunderstanding?
>
> It may be better to filter some invalid requests by driver, as in the 
> request header there are many parameters, and some of them are not 
> supported by device, so it's quite possible that many requests invalid 
> for the device. So if driver can do the first filter, such invalid 
> requests will not be sent at all, this will conserve virtqueue and 
> system overhead.
>
> And this is why exposing device supported features in the config space, 
> it ensures that almost all requests in virtqueue are nice to the backend.
>
> device also will verify the requests again, as the following requirement:
> Virtio SPI device MUST verify the parameters in 
> \field{virtio_spi_transfer_head} after receiving the request,
> and MUST set \field{virtio_spi_transfer_result} as VIRTIO_SPI_PARAM_ERR 
> if not all parameters are valid or some device unsupported features are set.
>
> Although checking the requests twice seems a little redundant, it is 
> more efficient comparing with sending some invalid requests to the device.
>
> What is your opinion? Do you think it is acceptable?

Thanks for your explanation, I think we simply have some terminology
issues. In the virtio spec, "driver" refers to one side of the
driver/device pair, and is used to describe how to communicate with the
device. In this case, "driver" would be the entity interacting with the
device, regardless of how it is implemented, and would be responsible
for sending the requests. Any filtering that would be done in a concrete
implementation (i.e. if you have one component generating the requests,
and then another component filtering them before actually putting them
into the queue) is out of scope for this spec -- we can maybe specify
that the driver should not send invalid requests, but I'm not sure that
this is actually needed.

> Once again, thanks a lot for your support.

You're welcome!


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

