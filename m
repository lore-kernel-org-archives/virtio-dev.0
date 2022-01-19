Return-Path: <virtio-return-3630-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20220119105924-mutt-send-email-mst@kernel.org>
References: <20220114225032.290762-1-mst@redhat.com>
 <87k0eyv0az.fsf@redhat.com>
 <20220117172336-mutt-send-email-mst@kernel.org>
 <20220119132343.533d8f61.pasic@linux.ibm.com>
 <20220119105924-mutt-send-email-mst@kernel.org>
Date: Wed, 19 Jan 2022 18:50:18 +0100
Message-ID: <87pmond38l.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio] Re: [virtio-dev] [PATCH] virtio: clarify feature negotiation
Content-Type: text/plain
To: "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 19 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Jan 19, 2022 at 01:23:43PM +0100, Halil Pasic wrote:
>> On Mon, 17 Jan 2022 17:26:10 -0500
>> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> 
>> > On Mon, Jan 17, 2022 at 04:39:32PM +0100, Cornelia Huck wrote:
>> > > On Fri, Jan 14 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> > >   
>> > > > We state that drivers can access config fields before FEATURES_OK. We do
>> > > > however need them to write the features before accessing config
>> > > > otherwise our forward compatibility won't work.
>> > > >
>> > > > We require devices to allow access to config space if they
>> > > > offer a feature bit as long as that has been offered, but
>> > > > this can't work of course since we don't know what value
>> > > > does driver expect. What we should have said is "as long
>> > > > as it has been acknowledged".
>> > > >
>> > > > While at it, clarify that drivers can write features
>> > > > repeatedly as long as FEATURES_OK have note been
>> > > > acknowledged.
>> > > >
>> > > > Note: if device denies FEATURES_OK then there's no reason
>> > > > not to allow the driver to try with another set of features.
>> > > > Current drivers do not need such a capability, so leave this
>> > > > idea for another day.
>> > > >
>> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> > > > ---
>> > > >  content.tex | 21 ++++++++++++++++-----
>> > > >  1 file changed, 16 insertions(+), 5 deletions(-)
>> > > >
>> > > > diff --git a/content.tex b/content.tex
>> > > > index 8439cc1..4f46ce9 100644
>> > > > --- a/content.tex
>> > > > +++ b/content.tex
>> > > > @@ -298,10 +298,10 @@ \section{Device Configuration Space}\label{sec:Basic Facilities of a Virtio Devi
>> > > >  \end{note}
>> > > >  
>> > > >  \devicenormative{\subsection}{Device Configuration Space}{Basic Facilities of a Virtio Device / Device Configuration Space}
>> > > > -The device MUST allow reading of any device-specific configuration
>> > > > +The device SHOULD allow reading of any device-specific configuration  
>> > > 
>> > > Why 'SHOULD'? I think the device MUST allow it for features that have
>> > > already been written by the driver, given that is always a subset of the
>> > > features that have been offered by the device.
>> > > 
>> > > Maybe "The device MUST allow reading of any device-specific
>> > > configuration field that is not depending on a feature bit, and any
>> > > device-specific configuration field that is conditional on a feature bit
>> > > that has been written back by the driver, before FEATURES_OK is set by
>> > > the driver. It MAY allow reading of any other configuration field."  
>> > 
>> > 
>> > Like that.
>> > 
>> 
>> I like Michaels original better for the following reason. To me, it is
>> much clearer, that one first SHOULD to do this new "acknowledge" step,
>> and only than is allowed to read the device-specific config. The
>> device-specific config in the most general consists of fields that are
>> conditional on feature bits, and fields that are not conditional but
>> always provided. IMHO Connie's version can be read as: the unconditional
>> ones you can read even before "acknowledging some of the features
>> offered", but for the conditional fields you have to do the
>> "acknowledge" first.
>
> I think I agree, and the problem with that is the transitional
> devices with VERSION_1. If we always make drivers ack features
> first, then devices can rely on VERSION_1 for all of config space.

Do we have any bit other than VERSION_1 that changes the layout for
non-optional config space fields?

>
>
>> > > >  field before FEATURES_OK is set by the driver.  This includes fields which are
>> > > > -conditional on feature bits, as long as those feature bits are offered
>> > > > -by the device.
>> > > > +conditional on feature bits, as long as those feature bits have
>> > > > +been acknowledged by the driver.  
>> > > 
>> > > Better 'written back'? To me, 'acknowledged' carries overtones of
>> > > 'negotiated', and that is not meaningful before FEATURES_OK.  
>> > 
>> > OK.
>> > In that case we should also change this:
>> > 
>> > Device Initialization / Read feature bits} Read device feature bits, and write the subset of feature bits
>> >    understood by the OS and driver to the device.
>> > 
>> > from "write" to "write back"
>> > 
>> 
>> I believe we should define "acknowledge features" once, and then just
>> use the term consistently.
>
> Right, and we use acknowledge features in this sense already.
>
> E.g.
>   If VIRTIO_CONSOLE_F_EMERG_WRITE is set then the driver can use emergency write
>   to output a single character without initializing virtio queues, or even
>   acknowledging the feature.
>
> By the way this one is an exception to the "reads but not writes before
> FEATURES_OK" rule ;) Might be a good idea to call this out here.

Yes, that's a really odd one. But if we take "acknowledging the feature"
to mean "the driver has written the feature bit, and set FEATURES_OK",
it still makes sense, as it is the only time we allow a config space
write before FEATURES_OK.

> and
>
> \item[FEATURES_OK (8)] Indicates that the driver has acknowledged all the
>   features it understands, and feature negotiation is complete.
>
> this meaning actually matches "acknowledge" just meaning "write".

Hm, I would rather interpret the act of "setting FEATURES_OK" as
"acknowledging the features it wrote to the device", as in not only "I
know those features, and can use them in principle", but in "this is
actually a feature combination I can use".

>
>
> I do however have a small problem with this terminology, in that
> what happens if I set a bit and later clear it. I guess when
> I set it I acknowledged it, and the feature is acknowledged. But what if I cleared it?
> Did I unacknowledge it? Is it unacknowledged? I don't think it's a verb even.
> And it's not terribly clear that the last action is what
> matter and previous acknowledgements are ignored.
> We can just say it has not been acknowledged but it's a bit confusing
> in that the feature has been acknowledged, the acknowledgement just
> has been withdrawn.
>
>
> I am not sure I have a better idea for a term though, set and clear
> are confusing since they do not relay the fact that both
> device and driver have to set a bit. negotiated is already
> used for after FEATURES_OK.
>

My personal understanding of the terminology is:
- acknowledged: the driver has written a feature to the device, and set
  FEATURES_OK
- negotiated: the bit is acknowledged, and the device has actually
  accepted FEATURES_OK

Generally, "acknowledging" a bit does not really carry more weight than
simply writing the bit to the device, the big distinction is whether the
device accepted FEATURES_OK.

So, the things that really matter are, I think,
- whether the driver has written VERSION_1, which means that the config
  space is supposed to be litte-endian
- whether the driver has written any bit that governs an optional field,
  which means that the driver may read that field
- that weird special case above
- whether the device has accepted FEATURES_OK, which means that the
  config space layout is fixed and the driver may write to it

That still leaves the problem to find a good term for clearing the bit
again... unless we simply talk about the driver setting and clearing it
(but how do we express that it needs to make the device aware of it?)

The other big problem is of course legacy... the spec talks of
"acknowledging" there, but in the legacy case, it means simply that the
driver wrote the bit, as we do not really have an explicit point where
the bit has actually been negotiated, it's only implicit. I think
phrasing matters for transitional devices, VIRTIO_1, and config space
endianness here...

> We could just add a paragraph explaining the terminology, I just
> wish we could be more concise.

I'm unfortunately struggling to come up with good, waterproof, and
understandable terminology covering all cases :(


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

