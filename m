Return-Path: <virtio-dev-return-12515-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B76B5C77B7F
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 15:53:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CD7FA3F543
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 15:53:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C4B2F9866AE
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 15:53:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id ADA5598658B; Wed,  3 May 2023 15:53:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9B482986594
	for <virtio-dev@lists.oasis-open.org>; Wed,  3 May 2023 15:53:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: V8CFW8d1NIuyDY03d5t4xQ-1
From: Cornelia Huck <cohuck@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Alexander Gordeev <alexander.gordeev@opensynergy.com>, Alexandre Courbot
 <acourbot@chromium.org>, virtio-dev@lists.oasis-open.org, Keiichi Watanabe
 <keiichiw@chromium.org>, Marcin  Wojtas <mwojtas@google.com>, Matti
 =?utf-8?Q?M=C3=B6ll?= <Matti.Moell@opensynergy.com>, Andrew Gazizov
 <andrew.gazizov@opensynergy.com>, Enrico Granata <egranata@google.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>, Peter Griffin
 <peter.griffin@linaro.org>, =?utf-8?Q?Bart=C5=82omiej?=  Grzesik
 <bag@semihalf.com>, Tomasz
 Figa <tfiga@chromium.org>, Daniel Almeida <daniel.almeida@collabora.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>, Albert Esteve
 <aesteve@redhat.com>
In-Reply-To: <87354dtp30.fsf@linaro.org>
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
 <87a5ylzf34.fsf@redhat.com> <87354dtp30.fsf@linaro.org>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Wed, 03 May 2023 17:53:24 +0200
Message-ID: <87bkj1h0nf.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification

On Wed, May 03 2023, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:

> Cornelia Huck <cohuck@redhat.com> writes:
>
>> On Fri, Apr 28 2023, Alexander Gordeev <alexander.gordeev@opensynergy.co=
m> wrote:
>>
>>> On 27.04.23 15:16, Alexandre Courbot wrote:
>>>> But in any case, that's irrelevant to the guest-host interface, and I
>>>> think a big part of the disagreement stems from the misconception that
>>>> V4L2 absolutely needs to be used on either the guest or the host,
>>>> which is absolutely not the case.
>>>
>>> I understand this, of course. I'm arguing, that it is harder to
>>> implement it, get it straight and then maintain it over years. Also it
>>> brings limitations, that sometimes can be workarounded in the virtio
>>> spec, but this always comes at a cost of decreased readability and
>>> increased complexity. Overall it looks clearly as a downgrade compared
>>> to virtio-video for our use-case. And I believe it would be the same fo=
r
>>> every developer, that has to actually implement the spec, not just do
>>> the pass through. So if we think of V4L2 UAPI pass through as a
>>> compatibility device (which I believe it is), then it is fine to have
>>> both and keep improving the virtio-video, including taking the best
>>> ideas from the V4L2 and overall using it as a reference to make writing
>>> the driver simpler.
>>
>> Let me jump in here and ask another question:
>>
>> Imagine that, some years in the future, somebody wants to add a virtio
>> device for handling video encoding/decoding to their hypervisor.
>>
>> Option 1: There are different devices to chose from. How is the person
>> implementing this supposed to pick a device? They might have a narrow
>> use case, where it is clear which of the devices is the one that needs t=
o
>> be supported; but they also might have multiple, diverse use cases, and
>> end up needing to implement all of the devices.
>>
>> Option 2: There is one device with various optional features. The person
>> implementing this can start off with a certain subset of features
>> depending on their expected use cases, and add to it later, if needed;
>> but the upfront complexity might be too high for specialized use cases.
>>
>> Leaving concrete references to V4L2 out of the picture, we're currently
>> trying to decide whether our future will be more like Option 1 or Option
>> 2, with their respective trade-offs.
>>
>> I'm slightly biased towards Option 2; does it look feasible at all, or
>> am I missing something essential here? (I had the impression that some
>> previous confusion had been cleared up; apologies in advance if I'm
>> misrepresenting things.)
>>
>> I'd really love to see some kind of consensus for 1.3, if at all
>> possible :)
>
> I think feature discovery and extensibility is a key part of the VirtIO
> paradigm which is why I find the virtio-v4l approach limiting. By
> pegging the device to a Linux API we effectively limit the growth of the
> device specification to as fast as the Linux API changes. I'm not fully
> immersed in v4l but I don't think it is seeing any additional features
> developed for it and its limitations for camera are one of the reasons
> stuff is being pushed to userspace in solutions like libcamera:
>
>   How is libcamera different from V4L2?
>
>   We see libcamera as a continuation of V4L2. One that can more easily
>   handle the recent advances in hardware design. As embedded cameras have
>   developed, all of the complexity has been pushed on to the developers.
>   With libcamera, all of that complexity is simplified and a single model
>   is presented to application developers.

Ok, that is interesting; thanks for the information.

>
> That said its not totally our experience to have virtio devices act as
> simple pipes for some higher level protocol. The virtio-gpu spec says
> very little about the details of how 3D devices work and simply offers
> an opaque pipe to push a (potentially propriety) command stream to the
> back end. As far as I'm aware the proposals for Vulkan and Wayland
> device support doesn't even offer a feature bit but simply changes the
> graphics stream type in the command packets.
>
> We could just offer a VIRTIO_VIDEO_F_V4L feature bit, document it as
> incompatible with other feature bits and make that the baseline
> implementation but it's not really in the spirit of what VirtIO is
> trying to achieve.

I'd not be in favour of an incompatible feature flag,
either... extensions are good, but conflicting features is something
that I'd like to avoid.

So, given that I'd still prefer to have a single device: How well does
the proposed virtio-video device map to a Linux driver implementation
that hooks into V4L2? If the general process flow is compatible and it
is mostly a question of wiring the parts together, I think pushing that
part of the complexity into the Linux driver is a reasonable
trade-off. Being able to use an existing protocol is nice, but if that
protocol is not perceived as flexible enough, it is probably not worth
encoding it into a spec. (Similar considerations apply to hooking up the
device in the hypervisor.)

Sorry about asking all those basic questions, but I really rely on the
judgment of people familiar with the infrastructure and use cases so
that we end up with a specification that is actually usable in the long
term. Too many details are likely to confuse me :)


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

