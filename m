Return-Path: <pasic@linux.ibm.com>
Date: Thu, 20 Jan 2022 16:24:29 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [virtio-dev] [PATCH] virtio: clarify feature negotiation
Message-ID: <20220120162429.6fcbfedf.pasic@linux.ibm.com>
In-Reply-To: <20220119183730-mutt-send-email-mst@kernel.org>
References: <20220114225032.290762-1-mst@redhat.com>
	<87k0eyv0az.fsf@redhat.com>
	<20220117172336-mutt-send-email-mst@kernel.org>
	<20220119132343.533d8f61.pasic@linux.ibm.com>
	<20220119105924-mutt-send-email-mst@kernel.org>
	<87pmond38l.fsf@redhat.com>
	<20220119183730-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, virtio@lists.oasis-open.org, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 19 Jan 2022 18:48:04 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Jan 19, 2022 at 06:50:18PM +0100, Cornelia Huck wrote:
> > On Wed, Jan 19 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
[..] 
> > Hm, I would rather interpret the act of "setting FEATURES_OK" as
> > "acknowledging the features it wrote to the device", as in not only "I
> > know those features, and can use them in principle", but in "this is
> > actually a feature combination I can use".  
> 
> that's the feature negotiation is complete part I think.
> 
> 

I agree.

[..]
> > My personal understanding of the terminology is:
> > - acknowledged: the driver has written a feature to the device, and set
> >   FEATURES_OK
> > - negotiated: the bit is acknowledged, and the device has actually
> >   accepted FEATURES_OK
> > 
> > Generally, "acknowledging" a bit does not really carry more weight than
> > simply writing the bit to the device, the big distinction is whether the
> > device accepted FEATURES_OK.  
> 
> Hmm I don't think this is the current reading of the spec. Do you?
> acknowledged is really something we inherited from 0.X
> and never changed, so it always meant "written to device as 1".
> Nothing to do with FEATURES_OK.
> 1.0 added negotiated to deal with FEATURES_OK.
> 

IMHO, the fact that Connie got this wrong is a reason enough to clarify
this thoroughly. Connie isn't exactly new to Virtio, and people with
less exposure are even likelier to get it wrong.

I wasn't aware either that "acknowledged" is a thing for modern devices,
or that it is terminology inherited form 0.X.

So let us say what is in 0.X. I'm quoting form
https://ozlabs.org/~rusty/virtio-spec/virtio-0.9.5.pdf

"The feature bits are negotiated: the device lists all the features it
understands in the Device Features field, and the guest writes the
subset that it understands into the Guest Features field. The only way
to renegotiate is to reset the device."

"Extensible: Virtio PCI devices contain feature bits which are
acknowledged by the guest operating system during device setup. This allows forwards
and backwards compatibility: the device offers all the features it knows
ab out, and the driver acknowledges those it understands and wishes to
use."

So at least 0.9.5 defines "features negotiated" and defines it well, in
a sense that there is no ambiguity about it (when are the features
considered to be negotiated, and how is this done). The only problem
with the definition is, that it ain't extensible! But let us get
back to well defined. In this document, the the "Guest Features" are
defined as single 32 bit field, which may be written (by the driver)
exactly once. And the act of writing "Guest Features" which is an atomic
operation concludes the feature negotiation. The only way to
re-negotiate, i.e. write again to "Guest Features" is to reset and then
re-init the device.

IMHO in this document, there is term "acknowledged" in relation to
feature bits is not defined. "Acknowledge" is rather used as a synonym
for "negotiated" in the second quote. And that is the only feature bits
related occurrence of "acknowledge I could find. The meaning of
"acknowledge" we want here, i.e. the state where the features have been
written, but not yet negotiated (finalized) is not something one can find
in v0.9.5.

BTW one thing I like about v0.9.5 is that it makes very clear, that
"Device Features" and "Guest Features" are two pairs of shoes.


> And I don't really like moving to this variant since acknowledged is then
> a very short transient state. We would be burning a very useful
> term on something that's barely there.
> 
> 
> > So, the things that really matter are, I think,
> > - whether the driver has written VERSION_1, which means that the config
> >   space is supposed to be litte-endian
> > - whether the driver has written any bit that governs an optional field,
> >   which means that the driver may read that field
> > - that weird special case above
> > - whether the device has accepted FEATURES_OK, which means that the
> >   config space layout is fixed and the driver may write to it
> > 
> > That still leaves the problem to find a good term for clearing the bit
> > again... unless we simply talk about the driver setting and clearing it
> > (but how do we express that it needs to make the device aware of it?)
> > 
> > The other big problem is of course legacy... the spec talks of
> > "acknowledging" there, but in the legacy case, it means simply that the
> > driver wrote the bit, as we do not really have an explicit point where
> > the bit has actually been negotiated, it's only implicit. I think
> > phrasing matters for transitional devices, VIRTIO_1, and config space
> > endianness here...  
> 
> 
> So for all of the above reasons I think we are better off
> with keeping the way acknowledging is currently understood in
> spec - really the pre-1.0 meaning.

See my comment above.

> 
> > > We could just add a paragraph explaining the terminology, I just
> > > wish we could be more concise.  
> > 
> > I'm unfortunately struggling to come up with good, waterproof, and
> > understandable terminology covering all cases :(  
> 
> I think if you recall what terminology used to be pre-1.0 things
> will become clearer. 

I disagree.

> And I think the requirement to allow
> early config space access and the idea of detecting legacy
> based on features all predate FEATURES_OK.
> 

I agree with this part.

Regards,
Halil

