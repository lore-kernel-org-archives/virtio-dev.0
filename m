Return-Path: <virtio-dev-return-14178-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE6B6C3DA6E
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Dec 2023 12:43:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 38ECE70C07
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Dec 2023 12:43:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 22B24986569
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Dec 2023 12:43:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 05AEB986546; Wed, 20 Dec 2023 12:43:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E90D7986547
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Dec 2023 12:43:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: IeKtKedoNkmHTPRxZ6JETw-1
From: Cornelia Huck <cohuck@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, virtio-dev@lists.oasis-open.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, stratos-dev@op-lists.linaro.org, Erik
 Schilling <erik.schilling@linaro.org>, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>, Mathieu Poirier
 <mathieu.poirier@linaro.org>, Matias Ezequiel Vara Larsen
 <matiasevara@gmail.com>, Bill Mills <bill.mills@linaro.org>
In-Reply-To: <87cyv361rv.fsf@draig.linaro.org>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy
 Ross"
References: <3fbb010e96124cfbffd70709d9ce7a2a458322c8.1701771424.git.viresh.kumar@linaro.org>
 <875y1ciy9h.fsf@redhat.com> <87plzk92l8.fsf@draig.linaro.org>
 <87ttoffydj.fsf@redhat.com> <87cyv361rv.fsf@draig.linaro.org>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Wed, 20 Dec 2023 13:43:31 +0100
Message-ID: <87il4tf3ik.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] Re: [PATCH] virtio-transport: Clarify requirements

On Mon, Dec 18 2023, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:

> Cornelia Huck <cohuck@redhat.com> writes:
>
>> On Tue, Dec 05 2023, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>>
>>> Cornelia Huck <cohuck@redhat.com> writes:
>>>
>>>> On Tue, Dec 05 2023, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>>>> +
>>>>> +The device MUST present each event, in a transport defined way, from=
 the
>>>>> +moment it takes place until the driver acknowledges the event.
>>>>
> <snip>
>>>>> +
>>>>> +\drivernormative{\subsection}{Virtio Transport Requirements}{Virtio =
Transport Options}
>>>>> +
>>>>> +The driver MUST NOT access guest memory locations outside what's mad=
e
>>>>> +available by the device to the driver.
>>>>
>>>> I don't think that makes sense -- I'd assume most guest memory locatio=
ns
>>>> do not have anything to do with virtio, and we should try to avoid
>>>> host/guest terminology.
>>>
>>> I agree guest memory isn't the right terminology here. However there ar=
e
>>> discussions about how to implement secure buffers for VirtIO - so for
>>> example a buffer mediated by some sort of secure layer. In those cases
>>> the driver may not have access to it outside of the transactions.=20
>>
>> Yes, I think we need to limit the scope of "guest memory" here. I think
>> we are basically wanting to deal with any memory used by virtio (device
>> type including memory access controlled by it, transport, and the
>> protocol itself). We would be talking about memory made available to the
>> device by the driver for explicit usage to implement the virtio spec. I
>> think this would cover mediation by a secure layer as well (with the
>> driver calling into that secure layer?) Or does the (host) device end up
>> donating memory to the (guest) driver, and we need to make sure it
>> doesn't scribble over it?
>
> I'm not sure if we have example of the host donating memory apart from
> the sort of static partitioning we see with guests on start-up where a
> region is defined as shared. The Xen grant model leaves the guest to
> grant access to its own pages to the backend.
>
> I guess for firmware mediated sharing this would still be driven by the
> guest rather than the host?

Yes, I think the guest telling the firmware which parts of its memory
the host may access is the usual pattern, or at least what I've seen so
far.

>>
>>>>> +
>>>>> +The driver MUST NOT access virtqueue contents before the device noti=
fies
>>>>> +about the readiness of the same.
>>>>> +
>>>>> +The driver MUST NOT access buffers, after it has added them to the
>>>>> +virtqueue and notified the device about their availability. The driv=
er
>>>>> +MAY access them after the device has processed them and notified the
>>>>> +driver of their availability, in a transport defined way.
>>>>> +
>>>>> +The driver MAY ask the device to reset the virtqueues if, for exampl=
e,
>>>>> +the driver times out waiting for a notification from the device for =
a
>>>>> +previously queued request.
>>>>
>>>> Again, I believe this has already been covered in the generic
>>>> sections -- do we instead need to specify that a transport MUST provid=
e
>>>> a method to do xy? (or SHOULD, MAY, as applicable -- it would be good =
to
>>>> list explicitly what is mandatory for a transport to implement, and wh=
at
>>>> is optional.)
>>>
>>> Yes I think so. The s390x channel transport gets referenced because it
>>> has a nice enumerated list of operations. It would be good to codify
>>> which operations are mandatory for all transports and which are
>>> optional.
>>
>> The problem with the ccw transport is that while it has a nice list of
>> operations, (a) it only covers guest-initiated actions,
>
> What examples of host initiated actions are there (aside from an IPI
> indicating a receive VirtQueue has buffers waiting)?

Also notifications for configuration changes; but I think we can put all
of this under the device->driver notification header. (Hmm, we probably
should change all those host/guest references for ccw some day...)

>
>> (b) probably not
>> all of them shold be mandatory (and some of them are more of an artifact
>> of how channel I/O works),
>
> These ones?
>
>   #define CCW_CMD_SET_IND 0x43
>   #define CCW_CMD_SET_CONF_IND 0x53
>   #define CCW_CMD_SET_IND_ADAPTER 0x73

Yes, and also CCW_CMD_SET_VIRTIO_REV (I think there used to be some
interest to implement something like that for mmio, but I don't think
anything ever ended up being specified?)

>
>> and (c) it only implements a subset of the
>> defined operations (which makes the not-implemented ones de facto
>> optional, of course :) But yes, we could use it as a starting point.
>
> Got to start somewhere :-)

Indeed :)


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

