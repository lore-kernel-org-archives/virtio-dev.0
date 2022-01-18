Return-Path: <mst@redhat.com>
Date: Tue, 18 Jan 2022 02:37:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/5] Introduce
 VIRTIO_F_ADMIN_VQ_INDIRECT_DESC/VIRTIO_F_ADMIN_VQ_IN_ORDER
Message-ID: <20220118023435-mutt-send-email-mst@kernel.org>
References: <20220113121203-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B90FF747D56377A0A850DC579@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220117170442-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54818033A0BD96EA9493C51ADC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118011731-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816DB30F23511266B8F35EDC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118014737-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B99E351B624A27378BC5DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118021228-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812D3C38DE9E8E1B4E4BE7DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54812D3C38DE9E8E1B4E4BE7DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jan 18, 2022 at 07:21:02AM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, January 18, 2022 12:44 PM
> > 
> > On Tue, Jan 18, 2022 at 07:07:03AM +0000, Parav Pandit wrote:
> > > Can you please review current proposal as well before we revise v2?
> > 
> > I think what you listed amounts to a significant rework and will make things
> > easier to review. Not 100% sure you need more feedback at this point.
> 
> With 
> (a) the motivation that Jason mentioned for config vqs, vectors etc,
> (b) the msix config/query of this proposal
> (c) your description to handle them in uniform way,
> (d) understanding the scale inefficiency, on-die resources, multiple outstanding cmds discussion in the thread,
> 
> I would like to receive feedback that we all agree to configure these values via AQ.
> Rest of the plumbing on AQ etc to address comments to complete in v2, once this looks ok.

Go ahead and wait if you like, that was just my advice because
personally if I see a mega-thread like this one on the list I just wait
for the next version. Review time has to be viewed as more precious than
developer time, otherwise things do not scale.

Or to put it more succinctly, iterating quickly is recipe for success.
-- 
MST

