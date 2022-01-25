Return-Path: <virtio-dev-return-9170-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6222198649D
	for <virtio-dev@lists.oasis-open.org>; Tue, 25 Jan 2022 15:22:19 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20220124174052.1b6b423e.pasic@linux.ibm.com>
References: <20220114225032.290762-1-mst@redhat.com>
 <20220119132319.5ee3821d.pasic@linux.ibm.com>
 <20220119112059-mutt-send-email-mst@kernel.org>
 <87k0eud0bi.fsf@redhat.com> <20220121033806.70b55223.pasic@linux.ibm.com>
 <87r191krbg.fsf@redhat.com> <20220124174052.1b6b423e.pasic@linux.ibm.com>
Date: Tue, 25 Jan 2022 16:22:05 +0100
Message-ID: <87fspbkfhe.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio] [PATCH] virtio: clarify feature
 negotiation
Content-Type: text/plain
To: Halil Pasic <pasic@linux.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, virtio@lists.oasis-open.org, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jan 24 2022, Halil Pasic <pasic@linux.ibm.com> wrote:

> On Fri, 21 Jan 2022 17:05:07 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
>
>> On Fri, Jan 21 2022, Halil Pasic <pasic@linux.ibm.com> wrote:
>> 
>> > On Thu, 20 Jan 2022 14:05:37 +0100
>> > Cornelia Huck <cohuck@redhat.com> wrote:
>> >  
>> >> On Wed, Jan 19 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> >>   
>> >> > On Wed, Jan 19, 2022 at 01:23:19PM +0100, Halil Pasic wrote:    
>> >> >> 3) Features are written in 32 bit chunks. My guess is that what we
>> >> >> want for "features acknowledged is": driver has written each chunk it
>> >> >> knows about at least once. Of course, the question arises, what should
>> >> >> the device do if config is read before that happens.    
>> >> >
>> >> > we are lucky that at present it's just mtu of the net device :).    
>> >> 
>> >> If, say, the driver writes the first chunk with the MTU bit, then reads
>> >> the mtu config field, then writes the second chunk with VERSION_1, it
>> >> should get the mtu in platform-endian (and on the next read after the
>> >> second chunk has been written, in little endian.) I'd say that this is
>> >> simply an issue of the driver not serializing its own reads/writes
>> >> correctly :)
>> >>   
>> >
>> > Point me to the sentence that says the driver did not serialize its own
>> > reads/writes correctly please!
>> >
>> > We can't just come up with requirements when it suits us. Well, we can
>> > but I argue, that should be the last resort.  
>> 
>> What I say is that the driver simply gets things back from the device
>> that are consistent from the device's point of view.
>
> That is what I'm concerned about. The current proposal stipulates, that
> the device needs to deliver a consistent config space, when it is in an
> inconsistent state, in a sense that the feature set, that has been
> written, is not supported. For example if I had a feature X2 that depends
> on bit F2 which in turn depends on feature X1 and bit F1, and has a
> config field C2 that is conditional on F2 and needs to be computed during
> initialization of X1 and requires private values that were computed
> during the initialization of the feature X1, I would refuse to
> initialize X2 if bit F1 is not set, because there is no sane way to
> do that without initializing X1 first. An thus there is no sane way
> to compute C2.

Well, if the device can't compute it, it can't... this needs to be
specified on a per-device basis. But I don't see what that has to do
with the device returning something that makes sense from its point of
view? It simply needs a specification that defines a default value for
the field if it hasn't been initialized yet?

>
>> If it cannot write
>> a set of bits atomically, that it simply needs to expect that it can get
>> different values at different times during the writing process. If it
>> wants consistent values, it must not mix up non-atomic writes and
>> reads -- but that's nothing special.
>
> IMHO if the spec promises consistent values under certain conditions,
> then the device needs to deliver consistent values, at least under those
> conditions. Are you telling me "after writing the subset of feature bits
> to the device" somehow includes "in must not mix up ..."?
>
> You said in the hypothesized scenario the driver does not keep it's end
> of the bargain. I asked to point me to the exact points in the spec
> which got violated. I don't see those pointers in your response. Sorry.
> So I'm asking again, can you please tell me which section, which
> paragraph of the spec, or some linked spec is violated?
>
> Or did I misunderstand you? Were you not claiming that the given case
> the driver would be in violation of the spec?

No, neither the driver nor the device are in violation of the spec. The
driver gets what it is supposed to get; if it cannot deal with that,
then it is a bug within the driver.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

