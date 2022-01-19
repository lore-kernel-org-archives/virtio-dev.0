Return-Path: <mst@redhat.com>
Date: Wed, 19 Jan 2022 04:26:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 4/5] virtio-net: add support for VIRTIO_F_ADMIN_VQ
Message-ID: <20220119042012-mutt-send-email-mst@kernel.org>
References: <20220113145103.26894-1-mgurtovoy@nvidia.com>
 <20220113145103.26894-5-mgurtovoy@nvidia.com>
 <20220113125409-mutt-send-email-mst@kernel.org>
 <38c7b7a3-e0d8-d242-8723-11cabbbcb47d@nvidia.com>
 <PH0PR12MB54812553884E5791B8A69DE8DC579@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220117171459-mutt-send-email-mst@kernel.org>
 <631d8512-6a28-a714-4a71-dded3ef9ce3c@redhat.com>
 <20220118002309-mutt-send-email-mst@kernel.org>
 <CACGkMEucTZSOq=yZ6-DjksW_Z_pg9vcA+pM6+iWWiGdpmM8u0Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEucTZSOq=yZ6-DjksW_Z_pg9vcA+pM6+iWWiGdpmM8u0Q@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Jason Wang <jasowang@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 19, 2022 at 12:16:47PM +0800, Jason Wang wrote:
> > We also need
> > - something like injecting cvq commands to control rx mode from the admin device
> > - page fault / dirty page handling
> >
> > these two seem to call for a vq.
> 
> Right, but vq is not necessarily for PF if we had PASID. And with
> PASID we don't even need a dedicated new cvq.

I don't think it's a good idea to mix transactions from
multiple PASIDs on the same vq.

Attaching a PASID to a queue seems more reasonable.
cvq is under guest control, so yes I think a separate
vq is preferable.

What is true is that with subfunctions you would have
PASID per subfunction and then one subfunction for control.

I think a sketch of how things will work with scalable iov can't hurt as
part of this proposal.  And, I'm not sure we should have so much
flexibility: if there's an interface that works for SRIOV and SIOV then
that seems preferable than having distinct transports for SRIOV and
SIOV.


-- 
MST

