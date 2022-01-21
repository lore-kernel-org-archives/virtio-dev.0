Return-Path: <pasic@linux.ibm.com>
Date: Fri, 21 Jan 2022 03:38:06 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [virtio-comment] Re: [virtio] [PATCH] virtio: clarify feature
 negotiation
Message-ID: <20220121033806.70b55223.pasic@linux.ibm.com>
In-Reply-To: <87k0eud0bi.fsf@redhat.com>
References: <20220114225032.290762-1-mst@redhat.com>
	<20220119132319.5ee3821d.pasic@linux.ibm.com>
	<20220119112059-mutt-send-email-mst@kernel.org>
	<87k0eud0bi.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, virtio@lists.oasis-open.org, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, 20 Jan 2022 14:05:37 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Wed, Jan 19 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Wed, Jan 19, 2022 at 01:23:19PM +0100, Halil Pasic wrote:  
> >> On Fri, 14 Jan 2022 17:50:51 -0500
> >> "Michael S. Tsirkin" <mst@redhat.com> wrote:  
> >> > Subject: virtio: clarify feature negotiation
> >> > @@ -500,8 +500,13 @@ \section{Device Initialization}\label{sec:General Initialization And Device Oper
> >> >  
> >> >  \item\label{itm:General Initialization And Device Operation /
> >> >  Device Initialization / Read feature bits} Read device feature bits, and write the subset of feature bits
> >> > -   understood by the OS and driver to the device.  During this step the
> >> > -   driver MAY read (but MUST NOT write) the device-specific configuration fields to check that it can support the device before accepting it.
> >> > +   understood by the OS and driver to the device.  During this
> >> > +   step, after writing the subset of feature bits to the device the
> >> > +   driver MAY read (but MUST NOT write) the device-specific
> >> > +   configuration fields to validate that it can support the device
> >> > +   before accepting it. The driver MAY then repeatedly modify the
> >> > +   subset as appropriate, write the new subset and repeat the
> >> > +   validation, any number of times.  
> >> 
> >> IMHO don't have an exact definition of what "MAY read device-specific
> >> configuration field means". To me, "may read" does not automatically
> >> imply that what was read can be interpreted, is valid and meaningful.  
> >
> > Let's say "MAY read (and use)" - is that clear enough?  
> 
> That would work for me. We just need to make sure that the device
> actually MUST present something valid if the feature bit is set
> (acknowledged).
> 
> >  
> >> For example there was no harm in reading MTU without having the
> >> F_VERSION_1 feature acknowledged before. We did not end up in undefined
> >> behavior land, the read_config operation did not blow up in our face,
> >> and the field was also "there" if the corresponding feature was offered.
> >> The only trouble was that one could not interpret the value of the field,
> >> because one could not tell is it big or little endian.  
> 
> I think there's an elephant in the room: which bits can the device
> actually assume to be set or unset?

I really don't understand what is the issue here. Please have a look
at
https://www.mail-archive.com/virtio-dev@lists.oasis-open.org/msg08187.html
and compare the part about "guest features" and "device features" being
distinct "device registers" (or a set of registers for modern) with the
QEMU implementation.

I don't think the initial value of bits in "guest features"
is specified, in the spec. But I may be wrong. If it is unspecified, this
is a little tricky. In practice, I think initially all bits are not set,
at least with QEMU, but I'm not 100% sure. In any case, that is the
most reasonable thing to assume anyway.

The device should consider the bits set currently have the value 1. Bits
are manipulated using the features_write operation, and immediately
after the successful execution of such an op by the device,
the register should have the value that was written, modulo filtering
away features that were not offered in the first place. I think that is
the maximum allowed amount of filtering, although this does not seem to
be specified. 

When is the driver safe to assume that the device has performed the
operation is an entirely different issue. If the filtering confined to
what I described (features not offered in the first place) after writing
the features, the guest knows which feature bits are set. The problem is
only it does not necessarily know when.

> 
> My take would be:
> - If the driver wrote a set of feature bits that contain MTU but not
>   VERSION_1, the device MUST provide a valid mtu value in platform
>   endian.
> - If the driver wrote a set of feature bits that contain MTU and
>   VERSION_1, the device MUST provide a valid mtu value in little
>   endian.
> - If the driver has not written the MTU bit, the device MAY provide
>   anything (but it could make an educated guess and provide a valid mtu
>   value in any endianness it thinks the driver might be expecting.)
>   If that is not something that the driver can use, it's really the
>   driver's problem for not setting the feature bit.

We actually don't have to take any educated guesses for endinannes. We
can do the transport specific detection.

The problem with serving whatever is, that we are declaring a bunch of
drivers non-spec-conform with this. Can you name me one driver, that did
the right thing?

We can pretend that the spec was always clear, and all the implementers
were stupid, and neglected to do the right thing. And this may be the
best course of action. I just want us to speak the truth during review
at least.

> 
> We just need to make sure stating that setting relevant feature bits is
> needed if the driver expects to get anything useful back, especially if
> you consider endianness. That problem just does not show up on
> little-endian platforms.

Is that relevant form spec perspective? I understand the practical side
of it, but still it feels wrong to use that as an argument. The spec is
not supposed to favor little-endina platforms over big-big endian
platforms in my opinion.

> 
> >> 
> >> IMHO, we want to accomplish, readable, interpretible, valid and
> >> meaningful, before the feature has been negotiated by setting
> >> FEATURES_OK.
> >> 
> >> I see a couple of potential problems with this:
> >> 1) The set of acknowledged features may be invalid! For example may end
> >> up with feature B acknowledged and feature B not acknowledged, when
> >> B depends on A. Before "acknowledge" we used to be safe, because the
> >> device would reject FEATURES_OK.  
> >
> > right. but for reading config fields it's probably enough in practice.  
> 
> It's probably ok to defer actually validating the bits to
> FEATURES_OK. If an inconsistent set of feature bits leads to a
> poorly-defined value, the device can really provide anything, and the
> driver just has to deal with trying to do something that is not valid
> anyway. But probably not a problem in practice, I agree.
> 
> >  
> >> 2) In theory, we could have union-type conditional fields. To demonstrate
> >> what I mean here is a stupid example:
> >> struct ThermometherConfig {
> >> union {
> >> u16 temp_in_kelvin;
> >> u16 temp_in_celsius;
> >> u16 temp_in_farenheit;
> >> } temp;
> >> };
> >> where kelvin is the default, but you can get Celsius or Fahrenheit
> >> depending on mutex feature bits.
> >> This also used to be and still is safe after the features have been
> >> negotiated, but with "acknowledged" there is trouble when both the
> >> features are set.  
> >
> > something to worry about in the future but are there cases like
> > this in present? should we worry?  
> 
> I would say that this is simply the driver triggering undefined
> behaviour from the device.
> 

That is the problem. In this paragraph we are trying to make sure that
the value of the field is valid and meaningful. You say, the driver
messed up. And I agree. But it is hard to pinpoint the requirement
which was violated. Can you help me do that? To be safe, we would
have to stipulate that the "guest features" are valid and acceptable.
I.e. that a FEATURES_OK would succeed. And that is implementation
specific, i.e. determined by the spec.

What bails us out is "can read" which is vague, and does allow for the
field containing garbage. But the problem with that is, that this
non-determinism makes the interface awful to program against: because it
may or may not work.

> >  
> >> 3) Features are written in 32 bit chunks. My guess is that what we
> >> want for "features acknowledged is": driver has written each chunk it
> >> knows about at least once. Of course, the question arises, what should
> >> the device do if config is read before that happens.  
> >
> > we are lucky that at present it's just mtu of the net device :).  
> 
> If, say, the driver writes the first chunk with the MTU bit, then reads
> the mtu config field, then writes the second chunk with VERSION_1, it
> should get the mtu in platform-endian (and on the next read after the
> second chunk has been written, in little endian.) I'd say that this is
> simply an issue of the driver not serializing its own reads/writes
> correctly :)
> 

Point me to the sentence that says the driver did not serialize its own
reads/writes correctly please!

We can't just come up with requirements when it suits us. Well, we can
but I argue, that should be the last resort.

[..]

Regards,
Halil

