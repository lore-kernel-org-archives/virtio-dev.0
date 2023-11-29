Return-Path: <virtio-dev-return-14082-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E30CC4167B
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Nov 2023 12:42:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C28882B055
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Nov 2023 12:42:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9C0DF986663
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Nov 2023 12:42:17 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7C2D49865ED; Wed, 29 Nov 2023 12:42:17 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6B84A98663F
	for <virtio-dev@lists.oasis-open.org>; Wed, 29 Nov 2023 12:42:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 3gAwcse8OAmxIciL2S6QWA-1
From: Cornelia Huck <cohuck@redhat.com>
To: Viresh Kumar <viresh.kumar@linaro.org>, Haixu Cui
 <quic_haixcui@quicinc.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org,
 harald.mommer@opensynergy.com, broonie@kernel.org,
 qiang4.zhang@linux.intel.com, quic_ztu@quicinc.com,
 alex.bennee@linaro.org, vincent.guittot@linaro.org
In-Reply-To: <20231129113417.7kb6my3mm67zal3q@vireshk-i7>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy
 Ross"
References: <20231124072015.12655-1-quic_haixcui@quicinc.com>
 <20231127101750.6xmthho6lnppyw3k@vireshk-i7>
 <2ca987a6-eeb2-4ed6-9a12-10ae450eb4bf@quicinc.com>
 <20231129073022.ohxsfuawambvh3hm@vireshk-i7>
 <0674be8e-221f-479a-8da2-8a3e59e45bb9@quicinc.com>
 <871qc9x8k2.fsf@redhat.com>
 <9e0c5e5e-db7b-4634-9423-f4db1800b148@quicinc.com>
 <20231129100002.q73wtz6mkfixcbzt@vireshk-i7>
 <5367c2e6-93f1-4a4d-867e-0074b452052a@quicinc.com>
 <20231129113417.7kb6my3mm67zal3q@vireshk-i7>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Wed, 29 Nov 2023 13:42:08 +0100
Message-ID: <87y1egwx27.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [virtio-comment] [PATCH] [PATCH v5] virtio-spi: add the device
 specification

On Wed, Nov 29 2023, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> On 29-11-23, 18:31, Haixu Cui wrote:
>> Hi Viresh,
>> 
>>     Thank you for your helpful comments. In next patch, I will clearly point
>> this out:
>
> Great, finally we are on the same page. Thanks Haixu.
>
>>     "For full-duplex read and write transfer, both \field{tx_buf} and
>> \field{rx_buf} are used and the buffer size of \field{tx_buf} must be same
>> as \field{rx_buf}."
>
> Suggest rewriting as:
>
> In full-duplex transfer mode, both \field{tx_buf} and \field{rx_buf} are sent by
> the driver, \field{tx_buf} followed by \field{rx_buf}. The length of both the
> buffers MUST be same.

Is that in a non-normative section? (Sorry, I've lost track here...) If
so, I would say:

"The length of both buffers has to be the same."

>
>>     And in drivernormative section, I will add a requirement:
>>     "For full-duplex transfer, Virtio SPI driver MUST guarantee the write
>> transfer size is equal to the read transfer size"
>
> Maybe:
>
> drivernormative:
>
> In full-duplex transfer mode, the Virtio SPI driver MUST guarantee that the
> length of both \field{tx_buf} and \field{rx_buf} are same.

s/are same/is the same/

>
> devicenormative:
>
> In full-duplex transfer mode, the Virtio SPI device MUST verify that the length
> of both \field{tx_buf} and \field{rx_buf} are same. In case of any mismatch, the

s/are same/is the same/

> device MUST fail the transfer and notify the driver.

"notify the driver" == "set an appropriate error value"?

Can this be covered by one of the existing error values?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

