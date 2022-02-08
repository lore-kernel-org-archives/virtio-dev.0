Return-Path: <mst@redhat.com>
Date: Tue, 8 Feb 2022 16:00:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 1/4] Add virtio Admin virtqueue
Message-ID: <20220208155906-mutt-send-email-mst@kernel.org>
References: <20220207052843-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548164CFE929F59EEDBD3557DC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220208014039-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548104AB80FA36544DB3D7D0DC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <878rulv6kq.fsf@redhat.com>
 <PH0PR12MB54816EBF061770CC91E0435DDC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220208084022-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548145C554CBE6367318A8F9DC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220208103757-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B7DB7CD220C512397B4CDC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481B7DB7CD220C512397B4CDC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Feb 08, 2022 at 06:52:09PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, February 8, 2022 9:10 PM
> > 
> > On Tue, Feb 08, 2022 at 03:06:16PM +0000, Parav Pandit wrote:
> > >
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Tuesday, February 8, 2022 7:29 PM
> > > >
> > > > > Do we have a concrete example of a command that can be targeted
> > > > > for same
> > > > device and a target device, which requires differentiating their
> > > > destination? If so, lets discuss and then it make sense to add for the well-
> > defined use case.
> > > >
> > > > So e.g. things like controlling NIC's MAC can reasonably be part of
> > > > the same device.
> > > A mac address of NIC can be programmed via the existing control VQ for the
> > self.
> > 
> > Not if it's disabled for the guest.
> > 
> Its unrelated.
> The idea was to issue same command in same way by two devices = primary and secondary.
> And in case of primary, it will refer to secondary device.
> And in second case secondary tells to self.
> 
> So if its disabled by guest, it doesn't matter how guest transports it, either via CVQ or AQ.
> Its disabled.
> Why to re-invent command that exists on CVQ to AQ?

I can go into it but it's beside the point.  I was just trying to help
you come up with use-cases.  Don't like it - come up with your own ones.


> > OK, and Cornelia also said she thinks 64 is necessary.
> > 
> > > So if we really want to cover variety of cases like [1] and some more
> > > complex nested cases, we better define, Device identifier as below,
> > > struct device_identifier {
> > > 	u8 id_length;
> > > 	u8 id[];	/* variable length field
> > > };
> > > For implicitly grouped VFs of a PF, id can be 2 bytes.
> > > For more advance cases it can be a structure consist one or more
> > combination of (a) host id or controller id (b) PF BDF, (c) sf id (d) PASID and
> > more.
> > >
> > > [1]
> > > https://www.kernel.org/doc/Documentation/networking/devlink/devlink-po
> > > rt.rst
> > 
> > I'm fine with this too.
> >
> Since we aim for future proofing and flexibility, variable length id is better than constant u64. It covers the u64 case anyway.
>  
> > --
> > MST

