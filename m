Return-Path: <mst@redhat.com>
Date: Mon, 24 Jan 2022 16:42:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-comment] Re: [virtio] [PATCH] virtio: clarify feature
 negotiation
Message-ID: <20220124132837-mutt-send-email-mst@kernel.org>
References: <20220114225032.290762-1-mst@redhat.com>
 <20220119132319.5ee3821d.pasic@linux.ibm.com>
 <20220119112059-mutt-send-email-mst@kernel.org>
 <87k0eud0bi.fsf@redhat.com>
 <20220121033806.70b55223.pasic@linux.ibm.com>
 <87r191krbg.fsf@redhat.com>
 <20220124174052.1b6b423e.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20220124174052.1b6b423e.pasic@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, virtio@lists.oasis-open.org, Viresh Kumar <viresh.kumar@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jan 24, 2022 at 05:40:52PM +0100, Halil Pasic wrote:
> On Fri, 21 Jan 2022 17:05:07 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > On Fri, Jan 21 2022, Halil Pasic <pasic@linux.ibm.com> wrote:
> > 
> > > On Thu, 20 Jan 2022 14:05:37 +0100
> > > Cornelia Huck <cohuck@redhat.com> wrote:
> > >  
> > >> On Wed, Jan 19 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >>   
> > >> > On Wed, Jan 19, 2022 at 01:23:19PM +0100, Halil Pasic wrote:    
> > 
> > >> My take would be:
> > >> - If the driver wrote a set of feature bits that contain MTU but not
> > >>   VERSION_1, the device MUST provide a valid mtu value in platform
> > >>   endian.
> > >> - If the driver wrote a set of feature bits that contain MTU and
> > >>   VERSION_1, the device MUST provide a valid mtu value in little
> > >>   endian.
> > >> - If the driver has not written the MTU bit, the device MAY provide
> > >>   anything (but it could make an educated guess and provide a valid mtu
> > >>   value in any endianness it thinks the driver might be expecting.)
> > >>   If that is not something that the driver can use, it's really the
> > >>   driver's problem for not setting the feature bit.  
> > >
> > > We actually don't have to take any educated guesses for endinannes. We
> > > can do the transport specific detection.
> > >
> > > The problem with serving whatever is, that we are declaring a bunch of
> > > drivers non-spec-conform with this. Can you name me one driver, that did
> > > the right thing?  
> > 
> > I don't understand how that makes any driver non-conformant...
> 
> In my reading, before this patch the the spec implies, that the driver
> is fine to read and use device-specific config fields to figure out which
> features to write. I'm quoting form the spec "Read device feature bits,
> and write the subset of feature bits understood by the OS and driver to
> the device. During this step the driver MAY read (but MUST NOT write) the
> device-specific configuration fields to check that it can support the
> device before accepting it." (3.1.1 Driver Requirements: Device
> Initialization).
> 
> With this change we basically introduce a new step, which the driver
> is supposed to do in order to get sane values. Instead of
> [read features, read config, write supported features] we say the
> driver should do [read features, write features which could be supported
> (modulo what the config says), read config, write actually supported
> features].
> 
> So the drivers currently out there, that do the early config read to
> validate if they support some of the features don't fulfill the new
> driver requirements. In my reading of the spec, a driver that does
> not some fulfill the driver requirements is non-conform.

It's true. However, that's a generic rule and specific devices
can differ. and if you look at specific instances, you will
see that they typically require that the feature is negotiated.
For example:

\item If the VIRTIO_BLK_F_BLK_SIZE feature is negotiated,
  \field{blk_size} can be read to determine the optimal sector size
  for the driver to use.

so a driver reading blk_size before FEATURES_OK is actually using
an undocumented aspect of the behaviour.

compare this to MTU:

\item[VIRTIO_NET_F_MTU(3)] Device maximum MTU reporting is supported. If
    offered by the device, device advises driver about the value of
    its maximum MTU. If negotiated, the driver uses \field{mtu} as
    the maximum MTU value.

from which it's clear that it can be read even if not
negotiated.

So from that point of view, we are actually relaxing the requirements,
and yes we'll need to carefully go over each instance of
"offered".
I thought I did, but now I did a quick grep again and I found instances
in virtio-iommu.tex and virtio-gpio.tex
Both of these are new, so I think we can just fix them to "negotiated".

Jean-Philippe, Viresh, what do you think? Would it be a problem to
replace offered with negotiated, and restrict iommu and gpio drivers to
access config space after FEATURES_OK?




> Is there a somewhere a hole in my reasoning which makes me reach the
> wrong conclusion? If yes, please point it out.
>
> > we can
> > say that the device should check for the expected endianness via a
> > transport-specific method, but in fact, the guarantee has never been
> > there; it just happened to work in most cases, except the problems on
> > s390x we saw recently. It is reasonable to ask the device to try to use
> > the correct endianness, but it was never a requirement, it all hinged
> > upon the VERSION_1 bit.
> 
> I read this paragraph as: transport specific "modern-legacy" detection
> was never a requirement. I tend to agree with that statement. Although,
> AFAIR Michael at least used to think differently.
> 
> To be more precise, IMHO it was all hinged upon the answer to the
> question: was VERSION_1 _negotiated_ or not? But that is just not good
> enough for _early_ config access.
> 
> > 
> > >
> > > We can pretend that the spec was always clear, and all the implementers
> > > were stupid, and neglected to do the right thing. And this may be the
> > > best course of action. I just want us to speak the truth during review
> > > at least.
> > >  
> > >> 
> > >> We just need to make sure stating that setting relevant feature bits is
> > >> needed if the driver expects to get anything useful back, especially if
> > >> you consider endianness. That problem just does not show up on
> > >> little-endian platforms.  
> > >
> > > Is that relevant form spec perspective? I understand the practical side
> > > of it, but still it feels wrong to use that as an argument. The spec is
> > > not supposed to favor little-endina platforms over big-big endian
> > > platforms in my opinion.  
> > 
> > How would adding some words of guidance favour one endianness over the
> > other? The device should make an effort to get it right; but that did
> > not happen historically anyway.
> > 
> 
> I'm a bit puzzled. I assumed, you were trying to say something like: the
> problem ain't such a big deal because in practice it affects only
> big-endian platforms. I probably misunderstood you. What is the point you
> were trying to make with that paragraph?
> 
> > >> >> 2) In theory, we could have union-type conditional fields. To demonstrate
> > >> >> what I mean here is a stupid example:
> > >> >> struct ThermometherConfig {
> > >> >> union {
> > >> >> u16 temp_in_kelvin;
> > >> >> u16 temp_in_celsius;
> > >> >> u16 temp_in_farenheit;
> > >> >> } temp;
> > >> >> };
> > >> >> where kelvin is the default, but you can get Celsius or Fahrenheit
> > >> >> depending on mutex feature bits.
> > >> >> This also used to be and still is safe after the features have been
> > >> >> negotiated, but with "acknowledged" there is trouble when both the
> > >> >> features are set.    
> > >> >
> > >> > something to worry about in the future but are there cases like
> > >> > this in present? should we worry?    
> > >> 
> > >> I would say that this is simply the driver triggering undefined
> > >> behaviour from the device.
> > >>   
> > >
> > > That is the problem. In this paragraph we are trying to make sure that
> > > the value of the field is valid and meaningful. You say, the driver
> > > messed up. And I agree. But it is hard to pinpoint the requirement
> > > which was violated. Can you help me do that? To be safe, we would
> > > have to stipulate that the "guest features" are valid and acceptable.
> > > I.e. that a FEATURES_OK would succeed. And that is implementation
> > > specific, i.e. determined by the spec.  
> > 
> > Do we really have to specify what happens when the driver tries to make
> > actual use of an invalid feature set? 
> 
> The point is, the driver does not know if the feature set it has written
> is valid or not at the point when early config space access is
> happening. At least not with the current proposal. 
> 
> > If yes, then we need to be clear
> > that the driver must care to never write a feature set with conflicting
> > features, which is a superset of the feature combinations that the
> > device would reject during FEATURES_OK.
> 
> I don't understand this part. Did you mean "subset" in stead of
> "superset"?
> 
> > 
> > >
> > > What bails us out is "can read" which is vague, and does allow for the
> > > field containing garbage. But the problem with that is, that this
> > > non-determinism makes the interface awful to program against: because it
> > > may or may not work.
> > >  
> > >> >    
> > >> >> 3) Features are written in 32 bit chunks. My guess is that what we
> > >> >> want for "features acknowledged is": driver has written each chunk it
> > >> >> knows about at least once. Of course, the question arises, what should
> > >> >> the device do if config is read before that happens.    
> > >> >
> > >> > we are lucky that at present it's just mtu of the net device :).    
> > >> 
> > >> If, say, the driver writes the first chunk with the MTU bit, then reads
> > >> the mtu config field, then writes the second chunk with VERSION_1, it
> > >> should get the mtu in platform-endian (and on the next read after the
> > >> second chunk has been written, in little endian.) I'd say that this is
> > >> simply an issue of the driver not serializing its own reads/writes
> > >> correctly :)
> > >>   
> > >
> > > Point me to the sentence that says the driver did not serialize its own
> > > reads/writes correctly please!
> > >
> > > We can't just come up with requirements when it suits us. Well, we can
> > > but I argue, that should be the last resort.  
> > 
> > What I say is that the driver simply gets things back from the device
> > that are consistent from the device's point of view.
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
> 
> > If it cannot write
> > a set of bits atomically, that it simply needs to expect that it can get
> > different values at different times during the writing process. If it
> > wants consistent values, it must not mix up non-atomic writes and
> > reads -- but that's nothing special.
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
> 
> Regards,
> Halil

