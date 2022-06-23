Return-Path: <jasowang@redhat.com>
MIME-Version: 1.0
References: <20220426225824.5918-1-mgurtovoy@nvidia.com> <20220426225824.5918-3-mgurtovoy@nvidia.com>
 <20220515111056-mutt-send-email-mst@kernel.org> <PH0PR12MB5481DD681A0172899E09BC6CDCCF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220517074130-mutt-send-email-mst@kernel.org> <PH0PR12MB5481D968013490C396CD2944DCDC9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220620055014-mutt-send-email-mst@kernel.org> <PH0PR12MB5481BB1BE6102DC78E555DEDDCB09@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsCrjLWri6TZ3yjf4qTWeXn-Bma-RY1HZFLbVS4ApyuVQ@mail.gmail.com>
 <PH0PR12MB5481E6E87639E07C885666F6DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEuHO5oBgFAkPnOZ8b3z+H5E2xXgM6FqbZdUuZB-2wX0UQ@mail.gmail.com> <PH0PR12MB54812D95E7E8D828831BA268DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB54812D95E7E8D828831BA268DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 23 Jun 2022 11:34:42 +0800
Message-ID: <CACGkMEuF8Eshy8vKfpX_-P66wXGiBowRTwurUMUq9K0FxbfKBA@mail.gmail.com>
Subject: Re: [virtio-comment] RE: [PATCH v5 2/7] Introduce admin command set
Content-Type: text/plain; charset="UTF-8"
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, "aadam@redhat.com" <aadam@redhat.com>, "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jun 23, 2022 at 10:57 AM Parav Pandit <parav@nvidia.com> wrote:
>
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Wednesday, June 22, 2022 10:42 PM
>
> [..]
> > > Are you suggesting only feature bits through register-based transport or all
> > commands via register-based transport?
> >
> > For feature bits, if we don't have admin virtqueue as transport,
> Right.
> Management tasks (features) done via AQ are negotiated via the AQ (regardless of device type being management dev or managed dev).
> It is not replacing usual feature bits negotiation that has strong relationships with device initialization sequence.

Just to clarify,

E.g if the admin virtqueue is implemented in PF. I suggest using the
existing PCI transport based feature negotiation since:

1) we have selector, so we don't need any new registered and we don't
need worry about the scalability
2) the feature negotiated is done once, so we don't need to care about
the performance

This is the way we used for other features that require a specific
type of virtqueue.

If we use admin virtqueue (management device) to be a transport for
e.g scalable functions (managed devices). We must have a command that
is used for feature negotiation for the scalable function (managed
devices).

>
> > I suggest it
> > be negotiated with existing transport: we don't need any extension of the
> > existing transport facility to make it work. If we have admin virtqueue as a
> > transport, we must allow the features of the managed device to be
> > negotiated through the admin virtqueue.
> >
> Regarding above _managed_device_:
>
> In current version the AQ is on the management device (not managed device).
> But AQ as stated is generic to be present on any device that wants to implement AQ.

Yes.

>
> > For other commands, we probably need to analyze it case by case. But if the
> > command is for management only, it should be done via admin virtqueue.
> > (Note that for the MSIX allocation, I do see some vendors allocating it via
> > registers).
> Where do you see it?

E.g Intel E810

> In the spec draft?

No.

Thanks

>
> > If the command is used for basic facilities like the virtqueue reset,
> > it should be allowed to be implemented by any transport (admin virtqueue
> > as well as others like PCI registers).

