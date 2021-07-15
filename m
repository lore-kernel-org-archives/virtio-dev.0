Return-Path: <mst@redhat.com>
Date: Thu, 15 Jul 2021 17:18:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-comment] [PATCH V2 2/2] virtio: introduce STOP status bit
Message-ID: <20210715171738-mutt-send-email-mst@kernel.org>
References: <778ffa63-c0ca-2faa-32da-3c5e71dd1dfe@redhat.com>
 <YOwSGeL+lfTxHuXg@stefanha-x1.localdomain>
 <3ce9775c-64fa-1c9b-6627-55f3b18ac987@redhat.com>
 <YO1kQ8sBkr2eguvi@stefanha-x1.localdomain>
 <8a2037df-e527-dcb4-c4c8-a568885180e4@redhat.com>
 <YO60HpxfZnmfMCMj@stefanha-x1.localdomain>
 <094e15d4-169a-87e9-5ebb-93439ea72831@redhat.com>
 <YO79tuI72kTEWURN@stefanha-x1.localdomain>
 <542aad20-8bca-f5db-647b-41909dacb8d1@nvidia.com>
 <03c6db33-58c8-5357-4c6d-7e5e836b328c@redhat.com>
MIME-Version: 1.0
In-Reply-To: <03c6db33-58c8-5357-4c6d-7e5e836b328c@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
To: Jason Wang <jasowang@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Cornelia Huck <cohuck@redhat.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jul 15, 2021 at 09:38:55AM +0800, Jason Wang wrote:
> 
> 在 2021/7/15 上午12:22, Max Gurtovoy 写道:
> > 
> > On 7/14/2021 6:07 PM, Stefan Hajnoczi wrote:
> > > > It requires much more works than the simple virtqueue interface:
> > > > (the main
> > > > issues is that the function is not self-contained in a single function)
> > > > 
> > > > 1) how to interact with the existing device status state machine?
> > > > 2) how to make it work in a nested environment?
> > > > 3) how to migrate the PF?
> > > > 4) do we need to allow more control other than just stop/freeze
> > > > the device
> > > > in the admin virtqueue? If yes, how to handle the concurrent
> > > > access from PF
> > > > and VF?
> > > > 5) how it is expected to work with non-PCI virtio device?
> > > I guess your device splitting proposal addresses some of these things?
> > > 
> > > Max probably has the most to say about these points.
> > > 
> > > If you want more input I can try to answer too, but I personally am not
> > > developing devices that need this right now, so I might not be the best
> > > person to propose solutions.
> > 
> > I think we mentioned this in the past and agreed that the only common
> > entity between my solution for virtio VF migration to this proposal is
> > the new admin control queue.
> > 
> > I can prepare some draft for this.
> > 
> > In our solution the PF will manage migration process for it's VFs using
> > the PF admin queue. PF is not migratable.
> 
> 
> That limits the use cases.
> 
> 
> > 
> > I don't know who is using nested environments in production so don't
> > know if it worth talking about that.
> 
> 
> There should be plenty users for the nested case.
> 
> 
> > 
> > But, if you would like to implement it for testing, no problem. The VF
> > in level n, probably seen as PF in level n+1. So it can manage the
> > migration process for its nested VFs.
> 
> 
> The PF dependency makes the design almost impossible to be used in a nested
> environment.

Can't we have an emulated PF? This would be the most reasonable thing to
do.

> 
> > 
> > For question 5) what non-PCI devices are interesting in live migration ?
> > 
> 
> Why not? Virtio support transport other than PCI (CCW, MMIO).
> 
> Thanks
> 

