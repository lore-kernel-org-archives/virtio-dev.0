Return-Path: virtio-dev-return-2568-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 1F67A5818C6E
	for <virtio-dev@lists.oasis-open.org>; Mon, 25 Sep 2017 15:24:35 -0700 (PDT)
Date: Tue, 26 Sep 2017 01:24:32 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170926011826-mutt-send-email-mst@kernel.org>
References: <20160915223915.qjlnlvf2w7u37bu3@redhat.com>
 <D0158A423229094DA7ABF71CF2FA0DA34E1A46A6@SHSMSX152.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D0158A423229094DA7ABF71CF2FA0DA34E1A46A6@SHSMSX152.ccr.corp.intel.com>
Subject: Re: [virtio-dev] packed ring layout proposal v3
To: "Liang, Cunming" <cunming.liang@intel.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Sep 20, 2017 at 09:11:57AM +0000, Liang, Cunming wrote:
> Hi Michael,
> 
> > -----Original Message-----
> > From: virtio-dev@lists.oasis-open.org [mailto:virtio-dev@lists.oasis-open.org]
> > On Behalf Of Michael S. Tsirkin
> > Sent: Sunday, September 10, 2017 1:06 PM
> > To: virtio-dev@lists.oasis-open.org
> > Cc: virtualization@lists.linux-foundation.org
> > Subject: [virtio-dev] packed ring layout proposal v3
> > 
> [...]
> > * Descriptor ring:
> > 
> > Driver writes descriptors with unique index values and DESC_DRIVER set in
> > flags.
> > Descriptors are written in a ring order: from start to end of ring, wrapping
> > around to the beginning.
> > Device writes used descriptors with correct len, index, and DESC_HW clear.
> > Again descriptors are written in ring order. This might not be the same order
> > of driver descriptors, and not all descriptors have to be written out.
> > 
> > Driver and device are expected to maintain (internally) a wrap-around bit,
> > starting at 0 and changing value each time they start writing out descriptors
> > at the beginning of the ring. This bit is passed as DESC_WRAP bit in the flags
> > field.
> 
> One simple question there, trying to understand the usage of DESC_WRAP flag.
> 
> DESC_WRAP bit is a new flag since v2. It's used to address 'non power-of-2 ring sizes' mentioned in v2?
> 
> Being confused by the statement of wrap-around bit here, it's an internal wrap-around counter represented by single bit (0/1)?
> DESC_WRAP can appear on any descriptor entry in the ring, why it highlights changing value at the beginning of the ring?


No, this is necessary if not all descriptors are overwritten by device
after they are used.

Each time driver overwrites a descriptor, the value in DESC_WRAP changes
which makes it possible for device to detect that there's a new
descriptor.


> > 
> > Flags are always set/cleared last.
> > 
> > Note that driver can write descriptors out in any order, but device will not
> > execute descriptor X+1 until descriptor X has been read as valid.
> > 
> > Driver operation:
> > 
> [...]
> > 
> > DESC_WRAP - device uses this field to detect descriptor change by driver.
> 
> Device uses this field to detect change of wrap-around boundary by driver? 
> 
> [...]
> > 
> > Device operation (using descriptors):
> > 
> [...]
> > 
> > DESC_WRAP - driver uses this field to detect descriptor change by device.
> 
> Driver uses this field to detect change of wrap-around boundary by device?
>
> By using this, driver doesn't need to maintain any internal wrap-around count, but being aware of wrap-around by DESC_WRAP flag.
> 
> 
> Thanks,
> Steve

So v2 simply said descriptor has a single bit: driver writes 1 there,
device writes 0.

This requires device to overwrite each descriptor and people asked 
for a way to communicate where some descriptors are not overwritten.

This new bit helps device distinguish new and old descriptors written by driver.



> > 
> [...]
> > 
> > ---
> > 
> > Note: should this proposal be accepted and approved, one or more
> >       claims disclosed to the TC admin and listed on the Virtio TC
> >       IPR page https://www.oasis-open.org/committees/virtio/ipr.php
> >       might become Essential Claims.
> > Note: the page above is unfortunately out of date and out of
> >       my hands. I'm in the process of updating ipr disclosures
> >       in github instead.  Will make sure all is in place before
> >       this proposal is put to vote. As usual this TC operates under the
> >       Non-Assertion Mode of the OASIS IPR Policy, which protects
> >       anyone implementing the virtio spec.
> > 
> > --
> > MST
> > 
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

