Return-Path: <virtio-dev-return-9152-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 362A698656C
	for <virtio-dev@lists.oasis-open.org>; Fri, 21 Jan 2022 16:05:15 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20220121033806.70b55223.pasic@linux.ibm.com>
References: <20220114225032.290762-1-mst@redhat.com>
 <20220119132319.5ee3821d.pasic@linux.ibm.com>
 <20220119112059-mutt-send-email-mst@kernel.org>
 <87k0eud0bi.fsf@redhat.com> <20220121033806.70b55223.pasic@linux.ibm.com>
Date: Fri, 21 Jan 2022 17:05:07 +0100
Message-ID: <87r191krbg.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio] [PATCH] virtio: clarify feature
 negotiation
Content-Type: text/plain
To: Halil Pasic <pasic@linux.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, virtio@lists.oasis-open.org, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jan 21 2022, Halil Pasic <pasic@linux.ibm.com> wrote:

> On Thu, 20 Jan 2022 14:05:37 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
>
>> On Wed, Jan 19 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> 
>> > On Wed, Jan 19, 2022 at 01:23:19PM +0100, Halil Pasic wrote:  

>> My take would be:
>> - If the driver wrote a set of feature bits that contain MTU but not
>>   VERSION_1, the device MUST provide a valid mtu value in platform
>>   endian.
>> - If the driver wrote a set of feature bits that contain MTU and
>>   VERSION_1, the device MUST provide a valid mtu value in little
>>   endian.
>> - If the driver has not written the MTU bit, the device MAY provide
>>   anything (but it could make an educated guess and provide a valid mtu
>>   value in any endianness it thinks the driver might be expecting.)
>>   If that is not something that the driver can use, it's really the
>>   driver's problem for not setting the feature bit.
>
> We actually don't have to take any educated guesses for endinannes. We
> can do the transport specific detection.
>
> The problem with serving whatever is, that we are declaring a bunch of
> drivers non-spec-conform with this. Can you name me one driver, that did
> the right thing?

I don't understand how that makes any driver non-conformant... we can
say that the device should check for the expected endianness via a
transport-specific method, but in fact, the guarantee has never been
there; it just happened to work in most cases, except the problems on
s390x we saw recently. It is reasonable to ask the device to try to use
the correct endianness, but it was never a requirement, it all hinged
upon the VERSION_1 bit.

>
> We can pretend that the spec was always clear, and all the implementers
> were stupid, and neglected to do the right thing. And this may be the
> best course of action. I just want us to speak the truth during review
> at least.
>
>> 
>> We just need to make sure stating that setting relevant feature bits is
>> needed if the driver expects to get anything useful back, especially if
>> you consider endianness. That problem just does not show up on
>> little-endian platforms.
>
> Is that relevant form spec perspective? I understand the practical side
> of it, but still it feels wrong to use that as an argument. The spec is
> not supposed to favor little-endina platforms over big-big endian
> platforms in my opinion.

How would adding some words of guidance favour one endianness over the
other? The device should make an effort to get it right; but that did
not happen historically anyway.

>> >> 2) In theory, we could have union-type conditional fields. To demonstrate
>> >> what I mean here is a stupid example:
>> >> struct ThermometherConfig {
>> >> union {
>> >> u16 temp_in_kelvin;
>> >> u16 temp_in_celsius;
>> >> u16 temp_in_farenheit;
>> >> } temp;
>> >> };
>> >> where kelvin is the default, but you can get Celsius or Fahrenheit
>> >> depending on mutex feature bits.
>> >> This also used to be and still is safe after the features have been
>> >> negotiated, but with "acknowledged" there is trouble when both the
>> >> features are set.  
>> >
>> > something to worry about in the future but are there cases like
>> > this in present? should we worry?  
>> 
>> I would say that this is simply the driver triggering undefined
>> behaviour from the device.
>> 
>
> That is the problem. In this paragraph we are trying to make sure that
> the value of the field is valid and meaningful. You say, the driver
> messed up. And I agree. But it is hard to pinpoint the requirement
> which was violated. Can you help me do that? To be safe, we would
> have to stipulate that the "guest features" are valid and acceptable.
> I.e. that a FEATURES_OK would succeed. And that is implementation
> specific, i.e. determined by the spec.

Do we really have to specify what happens when the driver tries to make
actual use of an invalid feature set? If yes, then we need to be clear
that the driver must care to never write a feature set with conflicting
features, which is a superset of the feature combinations that the
device would reject during FEATURES_OK.

>
> What bails us out is "can read" which is vague, and does allow for the
> field containing garbage. But the problem with that is, that this
> non-determinism makes the interface awful to program against: because it
> may or may not work.
>
>> >  
>> >> 3) Features are written in 32 bit chunks. My guess is that what we
>> >> want for "features acknowledged is": driver has written each chunk it
>> >> knows about at least once. Of course, the question arises, what should
>> >> the device do if config is read before that happens.  
>> >
>> > we are lucky that at present it's just mtu of the net device :).  
>> 
>> If, say, the driver writes the first chunk with the MTU bit, then reads
>> the mtu config field, then writes the second chunk with VERSION_1, it
>> should get the mtu in platform-endian (and on the next read after the
>> second chunk has been written, in little endian.) I'd say that this is
>> simply an issue of the driver not serializing its own reads/writes
>> correctly :)
>> 
>
> Point me to the sentence that says the driver did not serialize its own
> reads/writes correctly please!
>
> We can't just come up with requirements when it suits us. Well, we can
> but I argue, that should be the last resort.

What I say is that the driver simply gets things back from the device
that are consistent from the device's point of view. If it cannot write
a set of bits atomically, that it simply needs to expect that it can get
different values at different times during the writing process. If it
wants consistent values, it must not mix up non-atomic writes and
reads -- but that's nothing special.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

