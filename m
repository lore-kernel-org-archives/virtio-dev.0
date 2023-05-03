Return-Path: <virtio-dev-return-12509-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80246C77B75
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 14:05:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A225E44551
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 14:05:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 734A79866B7
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 14:05:27 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 586AD98658B; Wed,  3 May 2023 14:05:27 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9D442986594
	for <virtio-dev@lists.oasis-open.org>; Wed,  3 May 2023 14:04:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: O6UwVBQ2Oqmn9iJcAI0HhQ-1
From: Cornelia Huck <cohuck@redhat.com>
To: Alexander Gordeev <alexander.gordeev@opensynergy.com>, Alexandre Courbot
 <acourbot@chromium.org>
Cc: virtio-dev@lists.oasis-open.org, Keiichi Watanabe
 <keiichiw@chromium.org>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Marcin
 Wojtas <mwojtas@google.com>, Matti =?utf-8?Q?M=C3=B6ll?=
 <Matti.Moell@opensynergy.com>,
 Andrew Gazizov <andrew.gazizov@opensynergy.com>, Enrico Granata
 <egranata@google.com>, Gustavo Padovan <gustavo.padovan@collabora.com>,
 Peter Griffin <peter.griffin@linaro.org>, =?utf-8?Q?Bart=C5=82omiej?=
 Grzesik
 <bag@semihalf.com>, Tomasz Figa <tfiga@chromium.org>, Daniel Almeida
 <daniel.almeida@collabora.com>, Enric Balletbo i Serra
 <eballetb@redhat.com>, Albert Esteve <aesteve@redhat.com>
In-Reply-To: <cbed366a-7f12-8642-18ef-350981279241@opensynergy.com>
Organization: Red Hat GmbH
References: <20221208072325.2259940-1-acourbot@chromium.org>
 <8ec36252-97c6-0378-e25b-fc972ea3a66d@opensynergy.com>
 <CAPBb6MVDKfKOyDFPiOL3fRp4Jn6WwMpSZt6V32EJ1CYW_+rw+w@mail.gmail.com>
 <909867c6-b66c-1281-45a7-38fd0aa32123@opensynergy.com>
 <87cz6mnaqk.fsf@redhat.com>
 <CAPBb6MWNfPH+e8=4zUcq2dV-59OdzTYSuN04Cg2rRPWao-nseQ@mail.gmail.com>
 <877cwttw2x.fsf@redhat.com> <87a60kg9rh.fsf@redhat.com>
 <CAPBb6MX+R-bDgJzracbZq6DE7B0WO=rtqS6GE1QDugdrFLryXw@mail.gmail.com>
 <877cvog030.fsf@redhat.com>
 <CAPBb6MWyVoEuXJoKvJhP-5zp-x5WrDwVWe8mxbXbCwyzfgqW1g@mail.gmail.com>
 <ca84a8f5-71ed-aea8-5751-60403d167283@opensynergy.com>
 <CAPBb6MUDWVK87_kGFen36tDJQoR-Les6djcKVihjuTKQBjweEQ@mail.gmail.com>
 <b5c9d69a-fbec-8046-225f-bdb5850bbd54@opensynergy.com>
 <CAPBb6MUFbZzTTPqztVXQpcPN+PtqrmCoyaD5dySYdP_7EbRDdQ@mail.gmail.com>
 <11372cda-a766-ef50-45d7-ed637b72a31c@opensynergy.com>
 <CAPBb6MVRPn6dM8ap9uDvX_ZHdHGvooq+LB7UGDaWBEuUtK3x=A@mail.gmail.com>
 <cbed366a-7f12-8642-18ef-350981279241@opensynergy.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Wed, 03 May 2023 16:04:15 +0200
Message-ID: <87a5ylzf34.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification

On Fri, Apr 28 2023, Alexander Gordeev <alexander.gordeev@opensynergy.com> wrote:

> On 27.04.23 15:16, Alexandre Courbot wrote:
>> But in any case, that's irrelevant to the guest-host interface, and I
>> think a big part of the disagreement stems from the misconception that
>> V4L2 absolutely needs to be used on either the guest or the host,
>> which is absolutely not the case.
>
> I understand this, of course. I'm arguing, that it is harder to
> implement it, get it straight and then maintain it over years. Also it
> brings limitations, that sometimes can be workarounded in the virtio
> spec, but this always comes at a cost of decreased readability and
> increased complexity. Overall it looks clearly as a downgrade compared
> to virtio-video for our use-case. And I believe it would be the same for
> every developer, that has to actually implement the spec, not just do
> the pass through. So if we think of V4L2 UAPI pass through as a
> compatibility device (which I believe it is), then it is fine to have
> both and keep improving the virtio-video, including taking the best
> ideas from the V4L2 and overall using it as a reference to make writing
> the driver simpler.

Let me jump in here and ask another question:

Imagine that, some years in the future, somebody wants to add a virtio
device for handling video encoding/decoding to their hypervisor.

Option 1: There are different devices to chose from. How is the person
implementing this supposed to pick a device? They might have a narrow
use case, where it is clear which of the devices is the one that needs to
be supported; but they also might have multiple, diverse use cases, and
end up needing to implement all of the devices.

Option 2: There is one device with various optional features. The person
implementing this can start off with a certain subset of features
depending on their expected use cases, and add to it later, if needed;
but the upfront complexity might be too high for specialized use cases.

Leaving concrete references to V4L2 out of the picture, we're currently
trying to decide whether our future will be more like Option 1 or Option
2, with their respective trade-offs.

I'm slightly biased towards Option 2; does it look feasible at all, or
am I missing something essential here? (I had the impression that some
previous confusion had been cleared up; apologies in advance if I'm
misrepresenting things.)

I'd really love to see some kind of consensus for 1.3, if at all
possible :)


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

