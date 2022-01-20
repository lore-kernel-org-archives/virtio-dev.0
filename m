Return-Path: <virtio-comment-return-2603-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20220119183730-mutt-send-email-mst@kernel.org>
References: <20220114225032.290762-1-mst@redhat.com>
 <87k0eyv0az.fsf@redhat.com>
 <20220117172336-mutt-send-email-mst@kernel.org>
 <20220119132343.533d8f61.pasic@linux.ibm.com>
 <20220119105924-mutt-send-email-mst@kernel.org>
 <87pmond38l.fsf@redhat.com>
 <20220119183730-mutt-send-email-mst@kernel.org>
Date: Thu, 20 Jan 2022 13:39:48 +0100
Message-ID: <87mtjqd1ij.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [virtio-dev] [PATCH] virtio: clarify feature negotiation
Content-Type: text/plain
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 19 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Jan 19, 2022 at 06:50:18PM +0100, Cornelia Huck wrote:
>> On Wed, Jan 19 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> 
>> > On Wed, Jan 19, 2022 at 01:23:43PM +0100, Halil Pasic wrote:
>> >> On Mon, 17 Jan 2022 17:26:10 -0500
>> >> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> >> 
>> >> > On Mon, Jan 17, 2022 at 04:39:32PM +0100, Cornelia Huck wrote:
>> >> > > On Fri, Jan 14 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> >> > > >  field before FEATURES_OK is set by the driver.  This includes fields which are
>> >> > > > -conditional on feature bits, as long as those feature bits are offered
>> >> > > > -by the device.
>> >> > > > +conditional on feature bits, as long as those feature bits have
>> >> > > > +been acknowledged by the driver.  
>> >> > > 
>> >> > > Better 'written back'? To me, 'acknowledged' carries overtones of
>> >> > > 'negotiated', and that is not meaningful before FEATURES_OK.  
>> >> > 
>> >> > OK.
>> >> > In that case we should also change this:
>> >> > 
>> >> > Device Initialization / Read feature bits} Read device feature bits, and write the subset of feature bits
>> >> >    understood by the OS and driver to the device.
>> >> > 
>> >> > from "write" to "write back"
>> >> > 
>> >> 
>> >> I believe we should define "acknowledge features" once, and then just
>> >> use the term consistently.
>> >
>> > Right, and we use acknowledge features in this sense already.
>> >
>> > E.g.
>> >   If VIRTIO_CONSOLE_F_EMERG_WRITE is set then the driver can use emergency write
>> >   to output a single character without initializing virtio queues, or even
>> >   acknowledging the feature.
>> >
>> > By the way this one is an exception to the "reads but not writes before
>> > FEATURES_OK" rule ;) Might be a good idea to call this out here.
>> 
>> Yes, that's a really odd one. But if we take "acknowledging the feature"
>> to mean "the driver has written the feature bit, and set FEATURES_OK",
>> it still makes sense, as it is the only time we allow a config space
>> write before FEATURES_OK.
>
>
> If you look at qemu it's actually the new meaning, not FEATURES_OK.
> And it's actually useful like this - e.g. driver can oops
> before FEATURES_OK.

I think actually either is fine, as it's some kind of negated
statement.

>
>> > and
>> >
>> > \item[FEATURES_OK (8)] Indicates that the driver has acknowledged all the
>> >   features it understands, and feature negotiation is complete.
>> >
>> > this meaning actually matches "acknowledge" just meaning "write".
>> 
>> Hm, I would rather interpret the act of "setting FEATURES_OK" as
>> "acknowledging the features it wrote to the device", as in not only "I
>> know those features, and can use them in principle", but in "this is
>> actually a feature combination I can use".
>
> that's the feature negotiation is complete part I think.
>
>
>> >
>> >
>> > I do however have a small problem with this terminology, in that
>> > what happens if I set a bit and later clear it. I guess when
>> > I set it I acknowledged it, and the feature is acknowledged. But what if I cleared it?
>> > Did I unacknowledge it? Is it unacknowledged? I don't think it's a verb even.
>> > And it's not terribly clear that the last action is what
>> > matter and previous acknowledgements are ignored.
>> > We can just say it has not been acknowledged but it's a bit confusing
>> > in that the feature has been acknowledged, the acknowledgement just
>> > has been withdrawn.
>> >
>> >
>> > I am not sure I have a better idea for a term though, set and clear
>> > are confusing since they do not relay the fact that both
>> > device and driver have to set a bit. negotiated is already
>> > used for after FEATURES_OK.
>> >
>> 
>> My personal understanding of the terminology is:
>> - acknowledged: the driver has written a feature to the device, and set
>>   FEATURES_OK
>> - negotiated: the bit is acknowledged, and the device has actually
>>   accepted FEATURES_OK
>> 
>> Generally, "acknowledging" a bit does not really carry more weight than
>> simply writing the bit to the device, the big distinction is whether the
>> device accepted FEATURES_OK.
>
> Hmm I don't think this is the current reading of the spec. Do you?
> acknowledged is really something we inherited from 0.X
> and never changed, so it always meant "written to device as 1".
> Nothing to do with FEATURES_OK.
> 1.0 added negotiated to deal with FEATURES_OK.
>
> And I don't really like moving to this variant since acknowledged is then
> a very short transient state. We would be burning a very useful
> term on something that's barely there.

Hm... so it seems "acknowledged" is really legacy from, well, legacy,
and we should not go ahead and change its meaning.

>
>
>> So, the things that really matter are, I think,
>> - whether the driver has written VERSION_1, which means that the config
>>   space is supposed to be litte-endian
>> - whether the driver has written any bit that governs an optional field,
>>   which means that the driver may read that field
>> - that weird special case above
>> - whether the device has accepted FEATURES_OK, which means that the
>>   config space layout is fixed and the driver may write to it
>> 
>> That still leaves the problem to find a good term for clearing the bit
>> again... unless we simply talk about the driver setting and clearing it
>> (but how do we express that it needs to make the device aware of it?)
>> 
>> The other big problem is of course legacy... the spec talks of
>> "acknowledging" there, but in the legacy case, it means simply that the
>> driver wrote the bit, as we do not really have an explicit point where
>> the bit has actually been negotiated, it's only implicit. I think
>> phrasing matters for transitional devices, VIRTIO_1, and config space
>> endianness here...
>
>
> So for all of the above reasons I think we are better off
> with keeping the way acknowledging is currently understood in
> spec - really the pre-1.0 meaning.

Yeah. We should probably spell it out, though.

"A feature bit is said to have been acknowledged if the driver has
written the bit to the device."

...which leads us back to the problem that "unacknowledge" is not really
a word (or at least not a well-defined one.)

Maybe we can use something like:

"A feature bit is said to have been unacknowledged if the driver has
cleared a previously acknowledged bit and written the resulting set of
feature bits to the device."

>
>> > We could just add a paragraph explaining the terminology, I just
>> > wish we could be more concise.
>> 
>> I'm unfortunately struggling to come up with good, waterproof, and
>> understandable terminology covering all cases :(
>
> I think if you recall what terminology used to be pre-1.0 things
> will become clearer. And I think the requirement to allow
> early config space access and the idea of detecting legacy
> based on features all predate FEATURES_OK.

It seems the "early config space access" thing only made it into the
spec after FEATURES_OK had already been introduced... but I think the
idea that VERSION_1 set denotes non-legacy was there from the start.


This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

