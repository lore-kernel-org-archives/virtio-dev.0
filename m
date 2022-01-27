Return-Path: <mst@redhat.com>
Date: Thu, 27 Jan 2022 08:05:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/5] Introduce
 VIRTIO_F_ADMIN_VQ_INDIRECT_DESC/VIRTIO_F_ADMIN_VQ_IN_ORDER
Message-ID: <20220127075537-mutt-send-email-mst@kernel.org>
References: <PH0PR12MB5481B99E351B624A27378BC5DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <15063a94-85ae-fd1a-6ff1-458a039d1def@redhat.com>
 <PH0PR12MB5481D5BD8BB8CFDEFA218D2FDC599@PH0PR12MB5481.namprd12.prod.outlook.com>
 <56a7bf50-509d-f9d5-df78-858cb1b156c1@redhat.com>
 <PH0PR12MB548182EBE025ECA44124A11DDC5F9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <b6fc2eb9-8023-29c6-ce59-6a9f3810d057@nvidia.com>
 <20220125070649-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B051AFA529851B0167B3DC209@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220126090911-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548185B0603F0A4C8009EB66DC219@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548185B0603F0A4C8009EB66DC219@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
To: Parav Pandit <parav@nvidia.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, Jason Wang <jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jan 27, 2022 at 03:49:58AM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, January 26, 2022 7:42 PM
> > 
> > On Wed, Jan 26, 2022 at 01:29:27PM +0000, Parav Pandit wrote:
> > >
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Tuesday, January 25, 2022 5:39 PM
> > >
> > > > >
> > > > > So you do agree that managing a managed
> > > > > (create/destroy/setup/etc...) will be done using the AQ of the managing
> > device ?
> > > >
> > > > I think Jason asked that the management commands are split from the
> > > > queue itself, such that they can be implemented in more ways down the
> > road.
> > >
> > > Admin commands involved DMA. And also multiple commands can be
> > enqueued to the device.
> > > I don't see any other construct in the spec other than vq that enables driver
> > and device to achieve both.
> > > Hence split the queue from command is very weird for spec to do.
> > 
> >  VIRTIO_PCI_CAP_SHARED_MEMORY_CFG can do this.
> >
> Device needs to always have shared memory region always in available range for driver to read.
> Driver still needs to copy data from shared region to own memory.
> How DMA Can be done in the host driver PA using shared memory region?

It can't but you don't need DMA if device is writing its own memory.

> In future when SIOV occurs, each new SIOV SF/ADI will require new
> window in the shared regions exposed statically during PCI discovery
> time.

Donnu if it's statically. But we are talking about AQ thing, that
is just per group not per SF, so might not be too bad.

> So it doesn't scale.


Maybe. You said that's the only way to queue commands to device in the
spec, I just responded with a way. No need to code that up right now,
but just something to keep in mind, things are not absolute here.

> > 
> > > A recent addition like virtio_fs_req didn’t adopt this suggestion.
> > >
> > > If we just want to split so that admin commands can be transported via non
> > admin queue, we should remove below line from spec:
> > >
> > > "The Admin command set defines the commands that may be issued only to
> > the admin virtqueue"
> > 
> > sure
> > 
> > > And reword it as below,
> > >
> > > The Admin command set defines the commands to manipulate various
> > features/attributes of another device within the same group...
> > > When VIRTIO_F_ADMIN_VQ feature is negotiated, admin commands must
> > be transported through the admin queue.
> > >
> > > Looks ok?
> > 
> > I see no problem with that.
> 
> Since we agree for this, I considered AQ vs no_AQ as closed topic?

It's always hard to answer questions like this when all I have to go on
is a vague idea of what you mean.  Based on the discussion I am guessing
that your v3 will use the VQ in a way that is not controversial if that
is what you are asking about.
-- 
MST

