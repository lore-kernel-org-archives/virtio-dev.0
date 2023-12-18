Return-Path: <virtio-dev-return-14163-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E69EC35274
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Dec 2023 13:12:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A91C22A816
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Dec 2023 13:12:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 851A69864CE
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Dec 2023 13:12:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6AA95986445; Mon, 18 Dec 2023 13:12:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5AA37986478
	for <virtio-dev@lists.oasis-open.org>; Mon, 18 Dec 2023 13:12:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: gNVXSxVjOZuBf0oxaTvjSw-1
From: Cornelia Huck <cohuck@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, virtio-dev@lists.oasis-open.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, stratos-dev@op-lists.linaro.org, Erik
 Schilling <erik.schilling@linaro.org>, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>, Mathieu Poirier
 <mathieu.poirier@linaro.org>, Matias Ezequiel Vara Larsen
 <matiasevara@gmail.com>
In-Reply-To: <87plzk92l8.fsf@draig.linaro.org>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy
 Ross"
References: <3fbb010e96124cfbffd70709d9ce7a2a458322c8.1701771424.git.viresh.kumar@linaro.org>
 <875y1ciy9h.fsf@redhat.com> <87plzk92l8.fsf@draig.linaro.org>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Mon, 18 Dec 2023 14:12:24 +0100
Message-ID: <87ttoffydj.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [PATCH] virtio-transport: Clarify requirements

On Tue, Dec 05 2023, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:

> Cornelia Huck <cohuck@redhat.com> writes:
>
>> On Tue, Dec 05 2023, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>> +
>>> +The device MUST present each event, in a transport defined way, from t=
he
>>> +moment it takes place until the driver acknowledges the event.
>>
>> I don't believe "event" is well-defined here.
>
> Maybe:
>
> "A device initiated transaction can isn't considered complete until
> acknowledged by the driver. As such data MUST remain visible to the
> driver until the transaction is complete"?

Transaction is good, what about:

"Any data associated with a device-initiated transaction MUST remain
accessible to the driver until the driver acknowledges the transaction
to be complete."

>
>>
>>> +
>>> +The device MUST NOT access virtqueue's contents before the driver
>>> +notifies that the queue is ready for access, in a transport defined wa=
y.
>>> +
>>> +The device MUST NOT access buffers on the virtqueue, after it has
>>> +modified them and notified the driver about their availability.
>>> +
>>> +The device MUST reset the virtqueues if requested by the driver, in a
>>> +transport defined way.
>>
>> Isn't all of this already defined in one place of the spec or another?
>
> I think the recent example is the virtio-sound driver continuing to feed
> data into buffers after those buffers where submitted into the
> virtqueue. We should be explicit that the only time both sides of a
> VirtIO implementation can access things at the same time is with
> explicitly shared memory (and you need some sort of mechanism to mediate
> that to avoid chaos).

Fair enough, let's make it explicit if people already stumbled
here. Some rewording suggestions:

"The device MUST NOT access the contents of a virtqueue before the
driver notifies, in a transport defined way, the device that the
virtqueue is ready to be accessed.

The device MUST NOT access or modify buffers on a virtqueue after it has
notified the driver about their availability.

The device MUST reset the virtqueues if requested, in a transport
defined way, by the driver."

>
>>> +
>>> +\drivernormative{\subsection}{Virtio Transport Requirements}{Virtio Tr=
ansport Options}
>>> +
>>> +The driver MUST NOT access guest memory locations outside what's made
>>> +available by the device to the driver.
>>
>> I don't think that makes sense -- I'd assume most guest memory locations
>> do not have anything to do with virtio, and we should try to avoid
>> host/guest terminology.
>
> I agree guest memory isn't the right terminology here. However there are
> discussions about how to implement secure buffers for VirtIO - so for
> example a buffer mediated by some sort of secure layer. In those cases
> the driver may not have access to it outside of the transactions.=20

Yes, I think we need to limit the scope of "guest memory" here. I think
we are basically wanting to deal with any memory used by virtio (device
type including memory access controlled by it, transport, and the
protocol itself). We would be talking about memory made available to the
device by the driver for explicit usage to implement the virtio spec. I
think this would cover mediation by a secure layer as well (with the
driver calling into that secure layer?) Or does the (host) device end up
donating memory to the (guest) driver, and we need to make sure it
doesn't scribble over it?

>>> +
>>> +The driver MUST NOT access virtqueue contents before the device notifi=
es
>>> +about the readiness of the same.
>>> +
>>> +The driver MUST NOT access buffers, after it has added them to the
>>> +virtqueue and notified the device about their availability. The driver
>>> +MAY access them after the device has processed them and notified the
>>> +driver of their availability, in a transport defined way.
>>> +
>>> +The driver MAY ask the device to reset the virtqueues if, for example,
>>> +the driver times out waiting for a notification from the device for a
>>> +previously queued request.
>>
>> Again, I believe this has already been covered in the generic
>> sections -- do we instead need to specify that a transport MUST provide
>> a method to do xy? (or SHOULD, MAY, as applicable -- it would be good to
>> list explicitly what is mandatory for a transport to implement, and what
>> is optional.)
>
> Yes I think so. The s390x channel transport gets referenced because it
> has a nice enumerated list of operations. It would be good to codify
> which operations are mandatory for all transports and which are
> optional.

The problem with the ccw transport is that while it has a nice list of
operations, (a) it only covers guest-initiated actions, (b) probably not
all of them shold be mandatory (and some of them are more of an artifact
of how channel I/O works), and (c) it only implements a subset of the
defined operations (which makes the not-implemented ones de facto
optional, of course :) But yes, we could use it as a starting point.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

