Return-Path: <mst@redhat.com>
Date: Tue, 25 Jan 2022 13:05:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-comment] Re: [virtio] [PATCH] virtio: clarify feature
 negotiation
Message-ID: <20220125130459-mutt-send-email-mst@kernel.org>
References: <20220114225032.290762-1-mst@redhat.com>
 <20220119132319.5ee3821d.pasic@linux.ibm.com>
 <20220119112059-mutt-send-email-mst@kernel.org>
 <87k0eud0bi.fsf@redhat.com>
 <20220121033806.70b55223.pasic@linux.ibm.com>
 <87r191krbg.fsf@redhat.com>
 <20220124174052.1b6b423e.pasic@linux.ibm.com>
 <20220124132837-mutt-send-email-mst@kernel.org>
 <87ilu7kgmd.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87ilu7kgmd.fsf@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, virtio@lists.oasis-open.org, Viresh Kumar <viresh.kumar@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jan 25, 2022 at 03:57:30PM +0100, Cornelia Huck wrote:
> On Mon, Jan 24 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > It's true. However, that's a generic rule and specific devices
> > can differ. and if you look at specific instances, you will
> > see that they typically require that the feature is negotiated.
> > For example:
> >
> > \item If the VIRTIO_BLK_F_BLK_SIZE feature is negotiated,
> >   \field{blk_size} can be read to determine the optimal sector size
> >   for the driver to use.
> >
> > so a driver reading blk_size before FEATURES_OK is actually using
> > an undocumented aspect of the behaviour.
> >
> > compare this to MTU:
> >
> > \item[VIRTIO_NET_F_MTU(3)] Device maximum MTU reporting is supported. If
> >     offered by the device, device advises driver about the value of
> >     its maximum MTU. If negotiated, the driver uses \field{mtu} as
> >     the maximum MTU value.
> >
> > from which it's clear that it can be read even if not
> > negotiated.
> >
> > So from that point of view, we are actually relaxing the requirements,
> > and yes we'll need to carefully go over each instance of
> > "offered".
> > I thought I did, but now I did a quick grep again and I found instances
> > in virtio-iommu.tex and virtio-gpio.tex
> > Both of these are new, so I think we can just fix them to "negotiated".
> 
> Considering this, should we actually add any requirements as to when
> fields are valid? The device may present a value that is always valid if
> it offers the corresponding feature, or that value may change depending
> on what is actually negotiated by the driver. Maybe a statement that the
> actual validity of a field's value before negotiation is device type
> dependant?

Yes, that makes sense.

-- 
MST

