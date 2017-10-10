Return-Path: virtio-dev-return-2605-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id F144858191C8
	for <virtio-dev@lists.oasis-open.org>; Tue, 10 Oct 2017 02:56:49 -0700 (PDT)
From: "Liang, Cunming" <cunming.liang@intel.com>
Date: Tue, 10 Oct 2017 09:56:44 +0000
Message-ID: <D0158A423229094DA7ABF71CF2FA0DA34E7DE4D3@SHSMSX104.ccr.corp.intel.com>
References: <20160915223915.qjlnlvf2w7u37bu3@redhat.com>
 <D0158A423229094DA7ABF71CF2FA0DA34E1A46A6@SHSMSX152.ccr.corp.intel.com>
 <20170926011826-mutt-send-email-mst@kernel.org>
 <7A0DC0C9-F148-4161-B2D1-8D8D14D8B9A1@cisco.com>
 <20170928023112-mutt-send-email-mst@kernel.org>
 <D0158A423229094DA7ABF71CF2FA0DA34E1AD49B@SHSMSX152.ccr.corp.intel.com>
 <20171001063817-mutt-send-email-mst@kernel.org>
 <20171004123901.oomueufqg52uhas4@localhost.localdomain>
 <20171004155532-mutt-send-email-mst@kernel.org>
In-Reply-To: <20171004155532-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: RE: [virtio-dev] packed ring layout proposal v3
To: "Michael S. Tsirkin" <mst@redhat.com>, Jens Freimann <jfreimann@redhat.com>
Cc: "Steven Luong (sluong)" <sluong@cisco.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-ID: <virtio-dev.lists.oasis-open.org>



> -----Original Message-----
> From: virtio-dev@lists.oasis-open.org [mailto:virtio-dev@lists.oasis-open=
.org]
> On Behalf Of Michael S. Tsirkin
> Sent: Wednesday, October 4, 2017 8:58 PM
> To: Jens Freimann <jfreimann@redhat.com>
> Cc: Liang, Cunming <cunming.liang@intel.com>; Steven Luong (sluong)
> <sluong@cisco.com>; virtio-dev@lists.oasis-open.org;
> virtualization@lists.linux-foundation.org
> Subject: Re: [virtio-dev] packed ring layout proposal v3
>=20
> On Wed, Oct 04, 2017 at 02:39:01PM +0200, Jens Freimann wrote:
> > On Sun, Oct 01, 2017 at 04:08:29AM +0000, Michael S. Tsirkin wrote:
> > > On Thu, Sep 28, 2017 at 09:44:35AM +0000, Liang, Cunming wrote:
> > > >
> > > > Get it now. Please correct me if I missing something.
> > > >
> > > >
> > > > Flags status hints,
> > > >
> > > > - DESC_DRIVER only: driver owns the descriptor w/o available info
> > > > ready for device to use
> > > >
> > > > - DESC_DRIVER | DESC_WRAP: driver has prepared an available
> > > > descriptor, device hasn't used it yet
> > > >
> > > > - None: device has used the descriptor, and write descriptor out
> > > >
> > > > - DESC_WRAP only: shall not happen, device make sure to clear it
> > > >
> > > >
> > > > Polling behavior is,
> > > >
> > > > - Device monitor DESC_WRAP bit set or not; If set, go to use
> > > > descriptor and clear DESC_DRIVER bit in the end (note: always need
> > > > to clear DESC_WRAP)
> > > >
> > > > - Driver monitor DESC_DRIVER bit cleared or not; If cleared,
> > > > reclaim descriptor(set DESC_DRIVER) and set DESC_WRAP once new
> > > > available descriptor get ready to go
> > > >
> > > >
> > > > --
> > > > Steve
> > >
> > >
> > > Hmm no, not what I had in mind.
> > >
> > > DESC_DRIVER: used by driver to poll. Driver sets it when writing a
> > > descriptor.  Device clears it when overwriting a descriptor.
> > > Thus driver uses DESC_DRIVER to detect that device data in
> > > descriptor is valid.
> >
> > Basically DESC_HW from v2 split in two?
>=20
> Yes in order to avoid overwriting all descriptors.
>=20
> > >
> > > DESC_WRAP: used by device to poll. Driver sets it to a *different*
> > > value every time it overwrites a descriptor. How to achieve it?
> > > since descriptors are written out in ring order, simply maintain the
> > > current value internally (start value 1) and flip it every time you
> > > overwrite the first descriptor.
> > > Device leaves it intact when overwriting a descriptor.
Ok, get it now.

> >
> > This is confusing me a bit.
> >
> > My understanding is: 1. the internally kept wrap value only flipped
> > when the first descriptor is overwritten
> >
> > 2. the moment the first descriptor is written the internal wrap value
> > is flipped 0->1 or 1->0 and this value is written to every descriptor
> > DESC_WRAP until we reach the first descriptor again
That's right, it's also my take.
DESC_WRAP is only used by driver, device does nothing with that flag.

>=20
> Yes this is what I tried to say. Can you suggest a better wording then?
The term of DESC_WRAP is fine to me.

>=20
> > >
> > > After writing down this explanation, I think the names aren't great.
> > >
> > > Let me try an alternative explanation.
> > >
> > > ---------------
> > > A two-bit field, DRIVER_OWNER, signals the buffer ownership.
> > > It has 4 possible values:
> > > values 0x1, 0x11 are written by driver values 0x0, 0x10 are written
> > > by device
> >
> > The 0x prefix might add to the confusion here. It is really just two
> > bits, no?
>=20
> Ouch. Yes I meant 0b. Thanks!
0b00, 0b10 are written by device?
I suppose device can only clear high bit, can keep low bit no change.
Then the value written by device can be either 0b01 or 0b00, but 0b10 means=
 to set high bit, no?

>=20
> > > each time driver writes out a descriptor, it must make sure that the
> > > high bit in OWNER changes.
> > >
> > > each time device writes out a descriptor, it must make sure that the
> > > high bit in OWNER does not change.
Typo here? It should be "..., it must make sure that the low bit in OWNER d=
oes not change."?
For high bit in OWNER, each time devices writes out a descriptor, it must m=
ake sure to clear high bit in OWNER.
=20
> > >
> > > this is exactly the same functionally, DRIVER is high bit and WRAP
> > > is the low bit.  Does this make things clearer?
> >
> > So far it makes sense to me.
It sounds good.

> > > ---------------
> > >
> > >
> > >
> > > Maybe the difference between device and driver is confusing. We can
> > > fix that by changing the values.
> > > Here is an alternative. Let me know if you like it better - I need
> > > to think a bit more to make sure it works, but to give you an idea:
> > >
> > >
> > > ---------------
> > > A two-bit field, DRIVER_OWNER, signals the buffer ownership.
> > > It has 4 possible values:
> > > values 0x1, 0x10 are written by driver values 0x0, 0x11 are written
> > > by device
> > >
> > > each time driver writes out a descriptor, it must make sure that the
> > > high bit in OWNER changes. Thus first time it writes 0x10, next time
> > > 0x1, then 0x10 again.
> > >
> > > each time device writes out a descriptor, it must make sure that the
> > > low bit in OWNER changes.  Thus first time it writes 0x11, next time
> > > 0x0, then 0x11 again.
> >
> > DESC_WRAP is changed by the device now, so this would work differently
> > than in the scenario from above. This would mean we don't need the
> > internally kept wrap value, right?
>=20
> I think no but I did not complete simulating this yet so I don't yet know=
 if it
> even works.
>=20
> >
> > regards,
> > Jens
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

