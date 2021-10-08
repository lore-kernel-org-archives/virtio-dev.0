Return-Path: <mst@redhat.com>
Date: Fri, 8 Oct 2021 06:12:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2] Add device reset timeout field
Message-ID: <20211008060329-mutt-send-email-mst@kernel.org>
References: <20211006141033.612283-1-parav@nvidia.com>
 <20211006111143-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54811E06DAED3F7D60955A84DCB09@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211006163309-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481990F6F33697BB2F9B6D4DCB19@PH0PR12MB5481.namprd12.prod.outlook.com>
 <87zgrkyfwn.fsf@redhat.com>
 <PH0PR12MB5481CEA27B18421BB8432AD6DCB19@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481CEA27B18421BB8432AD6DCB19@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Oct 07, 2021 at 05:58:09PM +0000, Parav Pandit wrote:
> > >> > > Third how about making e.g. 0 a special value meaning no limit
> > >> > > wait
> > >> forever?
> > >> > The whole idea is to have some finite/deterministic behavior,
> > >>
> > >> I guess I'm being dense, I just don't yet understand the motivation.
> > >> The cost is difficulty in migration since each and every piece of
> > >> hardware will have a different timeout.
> > >>
> > > Such timeout is already there. Advertising timeout doesn't change the LM
> > > flow.
> > > A migrating device at the destination is anyway out of the reset when
> > > migration occurs.
> > 
> > But it introduces values that may be different between different devices of the
> > same type, no? I guess the destination would need to re-read the value to get
> > the current one. Not an insurmountable problem, but still needs some care.
> >
> When a device migrates to destination, it starts from where the device
> left off on the source side.  So yes, destination side, device must be
> usable (out of reset), and after that its current state will be
> overwritten by the migrating device.

I get what you are trying to say here but it's a hack. Nothing
prevents a reset for driver's internal reasons at any point,
and in particular reset is used e.g. for driver removal.

>  If you ask, does migration
> overwrite the reset timeout register value? I would say no, because
> how long device would take to reset is decided by the destination side
> implementation.

Problem is, driver can cache the value on source. Then it's migrated
and used on destination when driver wants to reset the device.
This can lead to a timeout if the destination does not
finish within the source timeout value.

That's why I ask: why do we bother? What's wrong with just waiting
forever or until user gets tired of this and cancels with CTRL-C?
Is there a use-case where that's not good enough?


> And this is probably yet another good reason to define migratable bits
> of a virtio device in the live migration spec extension.

"migratable bits" being what? non-guest visible device state? Sure, would
be great to have.  Don't think it will help in this instance.

-- 
MST

