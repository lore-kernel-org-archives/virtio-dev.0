Return-Path: <virtio-dev-return-9146-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E3CA0986551
	for <virtio-dev@lists.oasis-open.org>; Thu, 20 Jan 2022 13:05:56 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20220119112059-mutt-send-email-mst@kernel.org>
References: <20220114225032.290762-1-mst@redhat.com>
 <20220119132319.5ee3821d.pasic@linux.ibm.com>
 <20220119112059-mutt-send-email-mst@kernel.org>
Date: Thu, 20 Jan 2022 14:05:37 +0100
Message-ID: <87k0eud0bi.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio] [PATCH] virtio: clarify feature
 negotiation
Content-Type: text/plain
To: "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 19 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Jan 19, 2022 at 01:23:19PM +0100, Halil Pasic wrote:
>> On Fri, 14 Jan 2022 17:50:51 -0500
>> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> > Subject: virtio: clarify feature negotiation
>> > @@ -500,8 +500,13 @@ \section{Device Initialization}\label{sec:General Initialization And Device Oper
>> >  
>> >  \item\label{itm:General Initialization And Device Operation /
>> >  Device Initialization / Read feature bits} Read device feature bits, and write the subset of feature bits
>> > -   understood by the OS and driver to the device.  During this step the
>> > -   driver MAY read (but MUST NOT write) the device-specific configuration fields to check that it can support the device before accepting it.
>> > +   understood by the OS and driver to the device.  During this
>> > +   step, after writing the subset of feature bits to the device the
>> > +   driver MAY read (but MUST NOT write) the device-specific
>> > +   configuration fields to validate that it can support the device
>> > +   before accepting it. The driver MAY then repeatedly modify the
>> > +   subset as appropriate, write the new subset and repeat the
>> > +   validation, any number of times.
>> 
>> IMHO don't have an exact definition of what "MAY read device-specific
>> configuration field means". To me, "may read" does not automatically
>> imply that what was read can be interpreted, is valid and meaningful.
>
> Let's say "MAY read (and use)" - is that clear enough?

That would work for me. We just need to make sure that the device
actually MUST present something valid if the feature bit is set
(acknowledged).

>
>> For example there was no harm in reading MTU without having the
>> F_VERSION_1 feature acknowledged before. We did not end up in undefined
>> behavior land, the read_config operation did not blow up in our face,
>> and the field was also "there" if the corresponding feature was offered.
>> The only trouble was that one could not interpret the value of the field,
>> because one could not tell is it big or little endian.

I think there's an elephant in the room: which bits can the device
actually assume to be set or unset?

My take would be:
- If the driver wrote a set of feature bits that contain MTU but not
  VERSION_1, the device MUST provide a valid mtu value in platform
  endian.
- If the driver wrote a set of feature bits that contain MTU and
  VERSION_1, the device MUST provide a valid mtu value in little
  endian.
- If the driver has not written the MTU bit, the device MAY provide
  anything (but it could make an educated guess and provide a valid mtu
  value in any endianness it thinks the driver might be expecting.)
  If that is not something that the driver can use, it's really the
  driver's problem for not setting the feature bit.

We just need to make sure stating that setting relevant feature bits is
needed if the driver expects to get anything useful back, especially if
you consider endianness. That problem just does not show up on
little-endian platforms.

>> 
>> IMHO, we want to accomplish, readable, interpretible, valid and
>> meaningful, before the feature has been negotiated by setting
>> FEATURES_OK.
>> 
>> I see a couple of potential problems with this:
>> 1) The set of acknowledged features may be invalid! For example may end
>> up with feature B acknowledged and feature B not acknowledged, when
>> B depends on A. Before "acknowledge" we used to be safe, because the
>> device would reject FEATURES_OK.
>
> right. but for reading config fields it's probably enough in practice.

It's probably ok to defer actually validating the bits to
FEATURES_OK. If an inconsistent set of feature bits leads to a
poorly-defined value, the device can really provide anything, and the
driver just has to deal with trying to do something that is not valid
anyway. But probably not a problem in practice, I agree.

>
>> 2) In theory, we could have union-type conditional fields. To demonstrate
>> what I mean here is a stupid example:
>> struct ThermometherConfig {
>> union {
>> u16 temp_in_kelvin;
>> u16 temp_in_celsius;
>> u16 temp_in_farenheit;
>> } temp;
>> };
>> where kelvin is the default, but you can get Celsius or Fahrenheit
>> depending on mutex feature bits.
>> This also used to be and still is safe after the features have been
>> negotiated, but with "acknowledged" there is trouble when both the
>> features are set.
>
> something to worry about in the future but are there cases like
> this in present? should we worry?

I would say that this is simply the driver triggering undefined
behaviour from the device.

>
>> 3) Features are written in 32 bit chunks. My guess is that what we
>> want for "features acknowledged is": driver has written each chunk it
>> knows about at least once. Of course, the question arises, what should
>> the device do if config is read before that happens.
>
> we are lucky that at present it's just mtu of the net device :).

If, say, the driver writes the first chunk with the MTU bit, then reads
the mtu config field, then writes the second chunk with VERSION_1, it
should get the mtu in platform-endian (and on the next read after the
second chunk has been written, in little endian.) I'd say that this is
simply an issue of the driver not serializing its own reads/writes
correctly :)

>
>
>> 4) It is pretty obvious to me, that after "features have been
>> acknowledged", we want the driver to read the very same config as
>> if we were in "features have been negotiated" state. The only  difference
>> we want is, that the features must not be "frozen", i.e. the driver
>> should still be able to modify the features.
>
> I can add that, ok.

Ack.

>
>> 5) It ain't clear to me when is the driver supposed to assume that
>> "the features have been acknowledged". I.e. that the expected changes
>> have taken effect. For PCI, as far as I remember, they have this write it
>> and then read it back drill to force side-effects. Would we have to do
>> something like this. I think for FEATURES_OK we have that stuff clearly
>> specified.
>
> Hmm good point.  normally reads do not bypass writes, so you can write
> features and then read config, should work.  only exception is when they
> are different types e.g.  in theory features could be in IO and config
> in memory.  however I think reads from different types of memory can be
> reordered anyway, so that config isn't really legal.  I'll poke at the
> pci spec some more to refresh my memory on this. 
>
>> I don't know if that would be viable, but introducing a FEATURES_ACK
>> status bit would IMHO resolve a bunch of these potential problems, and
>> would also serve as a clear trigger for stuff like vhost (to flush
>> features)
>
> Right. With this proposal I think basically a config read
> flushes features. Which isn't too bad ...
>
>> The only problem, that would remain is that IMHO this is still
>> fundamentally a change that effectively breaks compatibility. IMHO
>> "features acknowledged" is essentially a new feature, which enables
>> a sane use of the config space before FEATURES_OK. But we can't guard it
>> with a feature bit, because the snake would just bite its tail. I'm
>> fine with going down this route. It is just that I would like to be
>> completely transparent about this.
>
> well kind of. But I think the nice thing about it and the reason
> I structured it this way and not as a complete new status bit
> is that it really matches pretty well what the existing
> body of code does, e.g. we don't need any qemu changes at all,
> and most linux and windows drivers except for network with
> the MTU thing are also good to go.

Do we know anything about the state of e.g. hardware implementations?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

