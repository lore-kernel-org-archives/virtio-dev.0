Return-Path: <virtio-dev-return-14164-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FCCC35274
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Dec 2023 14:02:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3A44B2B061
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Dec 2023 14:02:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5B486986514
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Dec 2023 14:02:49 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3D40E986445; Mon, 18 Dec 2023 14:02:49 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2D261986478
	for <virtio-dev@lists.oasis-open.org>; Mon, 18 Dec 2023 14:02:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 8NJyui4xMliA5Zfdr-UCbw-1
From: Cornelia Huck <cohuck@redhat.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, stratos-dev@op-lists.linaro.org, Erik Schilling
 <erik.schilling@linaro.org>, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>, Mathieu Poirier
 <mathieu.poirier@linaro.org>
In-Reply-To: <20231206094354.nzjax4lx4e5jwgwo@vireshk-i7>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy
 Ross"
References: <3fbb010e96124cfbffd70709d9ce7a2a458322c8.1701771424.git.viresh.kumar@linaro.org>
 <875y1ciy9h.fsf@redhat.com> <20231206094354.nzjax4lx4e5jwgwo@vireshk-i7>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Mon, 18 Dec 2023 15:02:30 +0100
Message-ID: <87r0jjfw21.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [PATCH] virtio-transport: Clarify requirements

On Wed, Dec 06 2023, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> On 05-12-23, 14:18, Cornelia Huck wrote:
>> On Tue, Dec 05 2023, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> > +\section{Virtio Transport Requirements}\label{sec:Virtio Transport Options / Virtio Transport Requirements}
>> > +
>> > +\devicenormative{\subsection}{Virtio Transport Requirements}{Virtio Transport Options}
>> 
>> I'm not sure we can introduce MUST (NOT) requirements for basic
>> functionality after the spec has been published for quite a time already
>> (although I'd assume every implementation is fulfilling the requirements
>> anyway)... thoughts?
>
> Fair point. I think it would be okay to use MUST (NOT) if we are sure
> that the existing implementations are fulfilling the requirements.
> Else maybe we can use SHOULD (NOT) ?

Yes, I think if we are just spelling out things explicitly in one place
that have been required anyway (by existing transports etc.), we are
fine using MUST; everything where someone could have chosen a different
implementation needs to be SHOULD.

(...)

>> > +\drivernormative{\subsection}{Virtio Transport Requirements}{Virtio Transport Options}
>> > +
>> > +The driver MUST NOT access guest memory locations outside what's made
>> > +available by the device to the driver.
>> 
>> I don't think that makes sense -- I'd assume most guest memory locations
>> do not have anything to do with virtio, and we should try to avoid
>> host/guest terminology.
>
> Hmm, you are right about the guest/host terminology. This comes mostly
> from the MMIO transport section, where a guest presents 0x100 bytes of
> memory, followed by configuration space (whose length is device/driver
> dependent). The MMIO section has this:
>
> "The driver MUST NOT access memory locations not described in the
> table \ref{tab:Virtio Transport Options / Virtio Over MMIO / MMIO Device Register Layout}
> (or, in case of the configuration space, described in the device specification),
> MUST NOT write to the read-only registers (direction R) and
> MUST NOT read from the write-only registers (direction W)."

Thanks for clarifying where this came from! See my suggestions in the
other fork of this thread.

>
>> > +The driver MUST NOT write to the read-only memory area and MUST NOT read
>> > +from the write-only memory area.
>> 
>> Which memory areas does that refer to? Parts of the transport-specific
>> data structures?
>
> Yes, based again on the above MMIO section, but perhaps apply to other
> transports as well..

I think we can't assume transports to use r/o and w/o memory areas in
all cases -- for example, ccw is largely based on passing buffers
around. Of course, if you look at the actual structures, there are
always fields that are to be used for reading or writing only.

>
>> > +The driver MUST acknowledge events presented by the device, as mandated
>> > +by the transport.
>> 
>> I don't think this is quite correct in the absolute -- for example, it
>> should be fine to not acknowledge events if some overriding event comes
>> along, or if the driver initiates a reset.
>
> What about:
>
> The driver SHOULD acknowledge events presented by the device, as
> mandated by the transport, unless a new event from the device
> overrides the previous one or the driver initiates a reset.

Should we do s/events/notifications/, or do we also cover transactions
initiated by the device explicitly (I'd assume that the device would
notify the driver im- or explicitly if it has to do something?)

>
>> > +The driver MUST NOT access virtqueue contents before the device notifies
>> > +about the readiness of the same.
>> > +
>> > +The driver MUST NOT access buffers, after it has added them to the
>> > +virtqueue and notified the device about their availability. The driver
>> > +MAY access them after the device has processed them and notified the
>> > +driver of their availability, in a transport defined way.
>> > +
>> > +The driver MAY ask the device to reset the virtqueues if, for example,
>> > +the driver times out waiting for a notification from the device for a
>> > +previously queued request.
>> 
>> Again, I believe this has already been covered in the generic
>> sections
>
> Right, but having it all at a single place makes it more convenient,
> instead of looking at implementations.

In that case, I'm fine for the first two; however, I'm not sure what the
third one adds here -- I don't think we ever said anything about when
the driver can initiate a reset, it can basically be at any time, and it
overrides whatever the device did if we reword the statement above.

>
>> do we instead need to specify that a transport MUST provide
>> a method to do xy? (or SHOULD, MAY, as applicable -- it would be good to
>> list explicitly what is mandatory for a transport to implement, and what
>> is optional.)
>
> Hmm, yeah sounds good. How about these ?
>
> - The transport MUST provide a mechanism for device discovery at the
>   driver's end.

"The transport MUST provide a mechanism for a driver to discover a
device" ?

>
> - The transport must provide a mechanism for the driver to identify
>   the device type.

Ack.

>
> - The transport MUST provide a mechanism for the driver to share
>   virtqueue configurations with the device.

"a mechanism for communicating virtqueue configurations between the
device and the driver" ?

That gives us more flexibility.

>
> - The transport SHOULD allow multiple virtqueues per device. The
>   number of virtqueues for a pair of device-driver are governed by the
>   individual device protocol.

Isn't that a MUST, depending on the device type?

>
> - The transport MUST provide shared memory regions between the device
>   and the driver for the implementation of virtqueues.

We probably shouldn't talk about providing shared memory regions, but
instead mandate that the transport provides a mechanism that the device
and the driver use to access memory for implementing virtqueues.

>
> - The transport MUST provide a mechanism for the device and the driver
>   to notify each other, for example about availability of a buffer on
>   the virtqueue.

Probably a mechanism for the device to notify the driver, and a
mechanism for the driver to notify the device? They can be different, as
long both of them are present.

>
> - The transport SHOULD provide a mechanism for the driver to initiate
>   a reset of the virtqueues and device.

Can we mandate a mechanism for a device reset? Reset of virtqueues needs
to be optional, I'm not sure whether a SHOULD would be appropriate for
that (or maybe we should finally come up with something for ccw ;)

Other things that probably should be mandatory:

- A way for the driver to change the device status. Reading it would
  probably be a strong SHOULD.
- A way to implement config space. (For example, channel devices don't
  have a config space or anything similar enough to repurpose, so I had
  to invent a mechanism for ccw... maybe future transports will be in
  the same boat.)


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

