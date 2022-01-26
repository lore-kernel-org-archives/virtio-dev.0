Return-Path: <mst@redhat.com>
Date: Wed, 26 Jan 2022 09:11:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/5] Introduce
 VIRTIO_F_ADMIN_VQ_INDIRECT_DESC/VIRTIO_F_ADMIN_VQ_IN_ORDER
Message-ID: <20220126090911-mutt-send-email-mst@kernel.org>
References: <PH0PR12MB54816DB30F23511266B8F35EDC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118014737-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B99E351B624A27378BC5DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <15063a94-85ae-fd1a-6ff1-458a039d1def@redhat.com>
 <PH0PR12MB5481D5BD8BB8CFDEFA218D2FDC599@PH0PR12MB5481.namprd12.prod.outlook.com>
 <56a7bf50-509d-f9d5-df78-858cb1b156c1@redhat.com>
 <PH0PR12MB548182EBE025ECA44124A11DDC5F9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <b6fc2eb9-8023-29c6-ce59-6a9f3810d057@nvidia.com>
 <20220125070649-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B051AFA529851B0167B3DC209@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481B051AFA529851B0167B3DC209@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
To: Parav Pandit <parav@nvidia.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, Jason Wang <jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 26, 2022 at 01:29:27PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, January 25, 2022 5:39 PM
> 
> > >
> > > So you do agree that managing a managed (create/destroy/setup/etc...)
> > > will be done using the AQ of the managing device ?
> > 
> > I think Jason asked that the management commands are split from the queue
> > itself, such that they can be implemented in more ways down the road.
> 
> Admin commands involved DMA. And also multiple commands can be enqueued to the device.
> I don't see any other construct in the spec other than vq that enables driver and device to achieve both.
> Hence split the queue from command is very weird for spec to do.

 VIRTIO_PCI_CAP_SHARED_MEMORY_CFG can do this.


> A recent addition like virtio_fs_req didn’t adopt this suggestion.
> 
> If we just want to split so that admin commands can be transported via non admin queue, we should remove below line from spec:
> 
> "The Admin command set defines the commands that may be issued only to the admin virtqueue"

sure

> And reword it as below,
> 
> The Admin command set defines the commands to manipulate various features/attributes of another device within the same group...
> When VIRTIO_F_ADMIN_VQ feature is negotiated, admin commands must be transported through the admin queue.
> 
> Looks ok?

I see no problem with that.

-- 
MST

