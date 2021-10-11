Return-Path: <mst@redhat.com>
Date: Mon, 11 Oct 2021 12:00:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2] Add device reset timeout field
Message-ID: <20211011115716-mutt-send-email-mst@kernel.org>
References: <PH0PR12MB5481378DF0CE74777A5BEC90DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211008071903-mutt-send-email-mst@kernel.org>
 <87lf33ybz7.fsf@redhat.com>
 <PH0PR12MB5481270F843DEC30A49972F3DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211008085134-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816AD1011E3806A4A26B27DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211008185926-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54814DF6BE5016FB4D941847DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <871r4ry5do.fsf@redhat.com>
 <PH0PR12MB5481502C480B6A7C1B61DFD6DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481502C480B6A7C1B61DFD6DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Oct 11, 2021 at 03:44:14PM +0000, Parav Pandit wrote:
> > > This is unlikely to work the reset is completed. Because a real device
> > implementing this would prefer to do this in fw for 1000 virtio devices sitting on
> > the physical card.
> > > And it is very much driven by such implementation at device devel.
> > > So it cannot update the counter value if reset is not completed for the device.
> > >
> > > I think read only device reset timeout is most elegant option during device
> > initialization phase that eliminates infinite loop of today.
> > 
> > Why can't a driver just go ahead and do a timeout regardless? 
> o.k. lets consider this thought exercise. What is the timeout value that driver will choose if device doesn't specify one?
> I explained in previous thread and you acked that actual fw based device may take longer to initialize than pure sw implementation backend.
> In second example a pre-boot device can take even longer initialization time.
> Sriov VF device may initialize lot faster.
> Instead of driver having such transport, and device specific checks, (or some very short or very long timeout), we propose, that let device mention such timeout value.

Parav I think you are conflating reset with initialization time.
initialization is just for host boot which takes seconds anyway -
but no, minutes is not reasonable their, either.
reset affects guest boot. This needs to complete in milliseconds.

This conflation is IMHO one of the problems with this proposal.

-- 
MST

