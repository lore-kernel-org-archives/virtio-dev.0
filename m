Return-Path: <pasic@linux.ibm.com>
Date: Wed, 26 Jan 2022 16:10:36 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [virtio-comment] Re: [virtio] [PATCH] virtio: clarify feature
 negotiation
Message-ID: <20220126161036.09c7c447.pasic@linux.ibm.com>
In-Reply-To: <20220124132837-mutt-send-email-mst@kernel.org>
References: <20220114225032.290762-1-mst@redhat.com>
	<20220119132319.5ee3821d.pasic@linux.ibm.com>
	<20220119112059-mutt-send-email-mst@kernel.org>
	<87k0eud0bi.fsf@redhat.com>
	<20220121033806.70b55223.pasic@linux.ibm.com>
	<87r191krbg.fsf@redhat.com>
	<20220124174052.1b6b423e.pasic@linux.ibm.com>
	<20220124132837-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, virtio@lists.oasis-open.org, Viresh Kumar <viresh.kumar@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 24 Jan 2022 16:42:35 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Jan 24, 2022 at 05:40:52PM +0100, Halil Pasic wrote:
[..]
> > 
> > So the drivers currently out there, that do the early config read to
> > validate if they support some of the features don't fulfill the new
> > driver requirements. In my reading of the spec, a driver that does
> > not some fulfill the driver requirements is non-conform.  
> 
> It's true. However, that's a generic rule and specific devices
> can differ. and if you look at specific instances, you will
> see that they typically require that the feature is negotiated.

IMHO we should be careful about the spec contradicting itself, so I guess
where a generic rule is overruled by device specific rules, we should
use something like "unless stated otherwise in the device specific part
of the specification ..."

> For example:
> 
> \item If the VIRTIO_BLK_F_BLK_SIZE feature is negotiated,
>   \field{blk_size} can be read to determine the optimal sector size
>   for the driver to use.
> 

There are two ways to read this, and right now you are choosing the
first one:
1) This kind of implicitly tells us, that if VIRTIO_BLK_F_BLK_SIZE
feature not yet negotiated, the the driver can not read  and use
the field to determine the optimal sector size.
2) This is just a positive guarantee. This sentence does not tell us
anything about what happens if feature is not (yet) negotiated. And that
could compose with a generic guarantee in a sense, that this sentence
says nothing about our situation, but the generic rule does give us the
guarantee we need (field is readable and valid). 

> so a driver reading blk_size before FEATURES_OK is actually using
> an undocumented aspect of the behaviour.

Which actually does not even work for all supported platforms! 

According to that, commit 82e89ea077b9 ("virtio-blk: Add validation for
block size in config space") is simply bugous, right?

Should we change the linux code accordingly?

> 
> compare this to MTU:
> 
> \item[VIRTIO_NET_F_MTU(3)] Device maximum MTU reporting is supported. If
>     offered by the device, device advises driver about the value of
>     its maximum MTU. If negotiated, the driver uses \field{mtu} as
>     the maximum MTU value.
> 
> from which it's clear that it can be read even if not
> negotiated.

I agree, this was probably the intention, nevertheless we should be
careful to express our intention in a non-ambiguous way (see above).

So is the current QEMU implementation of virtio-net is violating the
spec under certain circumstances? I mean when \field{mtu} is read,
before F_VERSION_1was written, ,  F_VERSION_1 was offered and guest
endiannes is big-endian. 

> 
> So from that point of view, we are actually relaxing the requirements,
> and yes we'll need to carefully go over each instance of
> "offered".

Which requirements do you mean here? The device requirements or the
driver requirements?

> I thought I did, but now I did a quick grep again and I found instances
> in virtio-iommu.tex and virtio-gpio.tex
> Both of these are new, so I think we can just fix them to "negotiated".
> 

[..]

