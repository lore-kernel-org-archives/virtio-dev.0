Return-Path: <mst@redhat.com>
Date: Thu, 16 Feb 2023 10:49:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v6] virtio-net: Improve introductory description
Message-ID: <20230216104714-mutt-send-email-mst@kernel.org>
References: <20230214180405.364920-1-parav@nvidia.com>
 <87ilg1aehi.fsf@redhat.com>
 <PH0PR12MB5481F4E1099DF88D667DBD2CDCA09@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481F4E1099DF88D667DBD2CDCA09@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>, David Edmondson <david.edmondson@oracle.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Feb 16, 2023 at 02:30:03PM +0000, Parav Pandit wrote:
> 
> > From: Cornelia Huck <cohuck@redhat.com>
> > Sent: Thursday, February 16, 2023 9:10 AM
> > 
> > On Tue, Feb 14 2023, Parav Pandit <parav@nvidia.com> wrote:
> > 
> > > The control VQ of the virtio network device is used beyond advance
> > > steering control. The control VQ dynamically changes multiple features
> > > of the initialized device.
> > >
> > > Hence, update this area of control VQ introductory description at few
> > > places and also place the link to its description.
> > >
> > > Also update the introduction section to better describe receive and
> > > transmit virtqueues.
> > >
> > > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/156
> > > Reviewed-by: David Edmondson <david.edmondson@oracle.com>
> > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > 
> > Are you requesting a vote for this?
> 
> I was not sure if its need voting as most are editorial cleanups, better description, structure movement.
> Please advise if we need voting.


The bylaws are here:
https://github.com/oasis-tcs/virtio-spec/blob/master/README.md
Minor cleanups, including editorial formatting changes, spelling and
typo fixes can be committed directly into git for approval as part of
the next specification approval ballot.

This is way beyond that. And generally when in doubt vote.

-- 
MST

