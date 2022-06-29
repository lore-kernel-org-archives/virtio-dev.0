Return-Path: <mst@redhat.com>
Date: Wed, 29 Jun 2022 05:02:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-comment] RE: [PATCH v5 2/7] Introduce admin command set
Message-ID: <20220629045321-mutt-send-email-mst@kernel.org>
References: <PH0PR12MB5481D968013490C396CD2944DCDC9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220620055014-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481BB1BE6102DC78E555DEDDCB09@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsCrjLWri6TZ3yjf4qTWeXn-Bma-RY1HZFLbVS4ApyuVQ@mail.gmail.com>
 <PH0PR12MB5481E6E87639E07C885666F6DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEuHO5oBgFAkPnOZ8b3z+H5E2xXgM6FqbZdUuZB-2wX0UQ@mail.gmail.com>
 <PH0PR12MB54812D95E7E8D828831BA268DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEuF8Eshy8vKfpX_-P66wXGiBowRTwurUMUq9K0FxbfKBA@mail.gmail.com>
 <20220628095247-mutt-send-email-mst@kernel.org>
 <CACGkMEtrcOhvO=bgdkszCb+Pc8aydG4Wh4CZhPTGVvvywoV2kQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtrcOhvO=bgdkszCb+Pc8aydG4Wh4CZhPTGVvvywoV2kQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Jason Wang <jasowang@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, "aadam@redhat.com" <aadam@redhat.com>, "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jun 29, 2022 at 04:43:18PM +0800, Jason Wang wrote:
> On Tue, Jun 28, 2022 at 10:24 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Jun 23, 2022 at 11:34:42AM +0800, Jason Wang wrote:
> > > On Thu, Jun 23, 2022 at 10:57 AM Parav Pandit <parav@nvidia.com> wrote:
> > > >
> > > >
> > > > > From: Jason Wang <jasowang@redhat.com>
> > > > > Sent: Wednesday, June 22, 2022 10:42 PM
> > > >
> > > > [..]
> > > > > > Are you suggesting only feature bits through register-based transport or all
> > > > > commands via register-based transport?
> > > > >
> > > > > For feature bits, if we don't have admin virtqueue as transport,
> > > > Right.
> > > > Management tasks (features) done via AQ are negotiated via the AQ (regardless of device type being management dev or managed dev).
> > > > It is not replacing usual feature bits negotiation that has strong relationships with device initialization sequence.
> > >
> > > Just to clarify,
> > >
> > > E.g if the admin virtqueue is implemented in PF. I suggest using the
> > > existing PCI transport based feature negotiation since:
> > >
> > > 1) we have selector, so we don't need any new registered and we don't
> > > need worry about the scalability
> >
> >
> > I think this is a point that needs addressing.
> >
> > To be more specific. The concern raised was that feature bits are memory
> > mapped. Accessing them on PCI requires an MMIO write. According to the
> > PCI spec it is not legal for a device to defer accepting a write until
> > another write is accepted (since that leads to deadlocks).
> > Thus any info programmed using MMIO writes has to reside in
> > on-card memory and can not be offloaded to system RAM.
> 
> Probably, but it can be offloaded via other ways. We had already used
> 2 for e.g feature_sel, it works for the past 5+ years, I guess having
> 4 more should work for the future 10 years. We only have this "issue"
> for some specific hardware (e.g we used to have similar discussion
> when somebody posted pci endpoint device support for virtio-net).
> 
> Note that this is only an "issue" for the management device (PF),

The claim was that for nesting purposes we might want to add
admin queue to the VFs as well.

> having several more bytes of register just for the PF doesn't seem
> expensive. We know we can use admin virtqueue as a transport for
> managed devices.

Did you post a prototype spec patch of this at some point? I do not recall.

> >
> > After thinking about these issues I have an idea:
> >
> > At the moment VQs are already never programmed before FEATURES_OK,
> > features are never programmed after FEATURES_OK.
> > This implies that device can actually store features in
> > VQ state registers temporarily until FEATURES_OK.
> > This is more than 24 bytes of memory per VQ, with at least
> > one data VQ and one admin VQ, this will be sufficient for a long time.
> 
> Something like
> 
> struct virtio_pci_common_cfg {
>       union {
>             virtqueue_state;
>              features;
>        }
> }
> 
> ?


Yea! Except in verilog.

> >
> > Thus, all that we need to do is prohibit programming VQs
> > before FEATURES_OK more strongly.
> > I can work on that if the idea is acceptable to others.
> 
> Note sure, it looks to me if such kind of device is popular, it might
> be better to have new PCI transport for non-register behaviour
> devices.
> 
> Thanks
> 
> >
> >
> >
> 
> >
> > --
> > MST
> >

