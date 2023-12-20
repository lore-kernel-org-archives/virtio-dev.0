Return-Path: <virtio-dev-return-14179-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C958BC3DA6E
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Dec 2023 13:51:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1D9962B009
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Dec 2023 13:51:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0476398655D
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Dec 2023 13:51:25 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DD1A9986546; Wed, 20 Dec 2023 13:51:24 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CCE4F986547
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Dec 2023 13:51:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: ohh0jsfJNyO1_FXZBtTVhg-1
From: Cornelia Huck <cohuck@redhat.com>
To: Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, virtio-dev@lists.oasis-open.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, stratos-dev@op-lists.linaro.org, Erik
 Schilling <erik.schilling@linaro.org>, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>, Mathieu Poirier
 <mathieu.poirier@linaro.org>
In-Reply-To: <8b278f33-4702-4a7c-bb80-e11c316234c4@linaro.org>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy
 Ross"
References: <3fbb010e96124cfbffd70709d9ce7a2a458322c8.1701771424.git.viresh.kumar@linaro.org>
 <875y1ciy9h.fsf@redhat.com> <20231206094354.nzjax4lx4e5jwgwo@vireshk-i7>
 <87r0jjfw21.fsf@redhat.com> <877clb61a8.fsf@draig.linaro.org>
 <8b278f33-4702-4a7c-bb80-e11c316234c4@linaro.org>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Wed, 20 Dec 2023 14:50:48 +0100
Message-ID: <87frzxf0ef.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [PATCH] virtio-transport: Clarify requirements

On Mon, Dec 18 2023, Bill Mills <bill.mills@linaro.org> wrote:

> On 12/18/23 9:19 AM, Alex Benn=C3=A9e wrote:
>> Cornelia Huck <cohuck@redhat.com> writes:
>>=20
>>> On Wed, Dec 06 2023, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>>
>>>> On 05-12-23, 14:18, Cornelia Huck wrote:
>>>>> On Tue, Dec 05 2023, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> <snip>
>>>>
>>>> - The transport MUST provide a mechanism for the device and the driver
>>>>    to notify each other, for example about availability of a buffer on
>>>>    the virtqueue.
>>>
>>> Probably a mechanism for the device to notify the driver, and a
>>> mechanism for the driver to notify the device? They can be different, a=
s
>>> long both of them are present.
>>>
>>>>
>>>> - The transport SHOULD provide a mechanism for the driver to initiate
>>>>    a reset of the virtqueues and device.
>>>
>>> Can we mandate a mechanism for a device reset? Reset of virtqueues need=
s
>>> to be optional, I'm not sure whether a SHOULD would be appropriate for
>>> that (or maybe we should finally come up with something for ccw ;)
>>>
>>> Other things that probably should be mandatory:
>>>
>>> - A way for the driver to change the device status. Reading it would
>>>    probably be a strong SHOULD.
>>> - A way to implement config space. (For example, channel devices don't
>>>    have a config space or anything similar enough to repurpose, so I ha=
d
>>>    to invent a mechanism for ccw... maybe future transports will be in
>>>    the same boat.)
>>=20
>> I think Bill has run into problems with config space on OpenAMP setups
>> where there can be no specific trapping between domains making it hard
>> to manage a config space where both sides might want to make updates. I
>> guess the original MMIO transport gets away with it because config space
>> is always in the trap-and-emulate address space in a normal VM/emulation
>> situation.
>>=20
>> Bill,
>>=20
>> Is the plan to introduce a new transport that manages config in a
>> different way?
>>=20
>
> I/We had a couple of ideas.  This is a thorny issue if you want=20
> something that 100% matches the implications of the virtio spec.  If you=
=20
> want something that works with existing virtio protocols it is not as=20
> bad but still tricky.
>
> If you read the virtio spec it implies you could have a device with zero=
=20
> virtqueues and just does things with the config space.  To me this=20
> should be a SHOULD NOT.  Something like "The config space SHOULD NOT be=
=20
> used as a mechanism for frequent changes."
>
> To me the config space is best used as a device to driver info space=20
> with infrequent updates from both sides.  I don't know how that should=20
> be expressed in the spec.

We do have some text suggesting that this should work like that, i.e. in
"Config Space" we say "Device configuration space is generally used for
rarely-changing or initialization-time parameters." and in Appendix B we
say "Device configuration space should only be used for
initialization-time parameters. It is a limited resource with no
synchronization between field written by the driver, so for most uses it
is better to use a virtqueue to update configuration information". I'm
not sure where to add a normative statement, given that this is
something that device types need to take care of.

>
> It is true that virtio-pci and virtio-mmio can signal changes in config=
=20
> space from the driver to the device.  However the device driver can read=
=20
> the config space asynchronously whenever it wants.  The generation=20
> counter was added to fix non-atomic updates from the device.
>
> The generation counter in virtio-mmio and virtio-pci transport config=20
> spaces only work because the hypervisor can see each read attempt to the=
=20
> config space.  The virtio-pci suggests not incrementing the generation=20
> counter unless the guest is doing a read.  (Because the generation=20
> counter on virtio-pci is small.)
>
> In addition, config updates from the driver at not formally signaled and=
=20
> it again relies on the hypervisor intersecting writes to the config space=
.

The configuration space for ccw is really different conceptually: both
reading from and writing to it are initiated by the driver sending
commands, and the architecture makes sure that reads and writes are
processed by the device strictly in the order that the driver sent
them. IOW, unless the device messes up, the driver will get consistent
information.

>
> Anyway I have thought of two solutions for the config space that do not=
=20
> rely on hypervisor magic.
>
> 1) Config generation counter odd =3D=3D update in progress
>
> In OpenAMP we are working on a transport that looks like virtio-mmio but=
=20
> has modifications to allow it to be used w/o hypervisor magic.  A dumb=20
> shared memory and bi-directional notifications should be enough.
>
> In this model we are adding multiple events in each direction.  One=20
> event in each direction is a config space update.  This helps solve the=
=20
> driver -> device config space change notification.  Assuming the driver=
=20
> does not send back to back overlapping changes this should be enough=20
> (but is not perfect.)
>
> To allow asynchronous config space reads by the driver, we could define=
=20
> a 32 bit generation counter where odd numbers meant update in progress.=
=20
> The config space read operation would look similar to the current model=
=20
> =3D> if the two values don't match >>> or are odd <<<, then read again.
>
> Not great but may be workable.
>
> 2) Message based config space
>
> The other transport option I am considering is something that is still=20
> vring/virtqueue based but replaces the transport level structure with a=
=20
> simple message passing facility.
>
> This would apply to all transport level ops (virtqueue discover and=20
> config, feature negotiation, etc) but the config space would work like=20
> below.
>
> In this model there would be no shared config space.  Each side would=20
> have its own copy of the config space and would send messages to make=20
> updates.  The driver side would start empty and would send a message to=
=20
> discover the size of the config space and read its initial value.=20
> Multiple reads may be needed to read the whole initial value if the=20
> config space was large (>128 bytes?).  After the initial sync either=20
> side can make updates and sends the offset, size and value of a region=20
> that contains the change.

If all messages were sent by the driver, this would be very similar to
the ccw implementation. You would still have the device view of the
config space, and the driver could either have its own copy and update
if needed, or just obtain/change information when it actually needs it.
Plus a notification mechanism for device->driver "something changed, you
might want to re-read" (instead of sending a message with the change).

>
> Sorry for the info dump.  I was working on a doc that described the=20
> problems and the AMP virtio-mmio option but it got stalled.  I will try=
=20
> to get it going again.

This is actually very interesting :)


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

