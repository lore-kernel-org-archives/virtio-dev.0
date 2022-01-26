Return-Path: <mst@redhat.com>
Date: Wed, 26 Jan 2022 10:03:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 1/4] Add virtio Admin Virtqueue
Message-ID: <20220126095925-mutt-send-email-mst@kernel.org>
References: <20220124093918.34371-1-mgurtovoy@nvidia.com>
 <20220124093918.34371-2-mgurtovoy@nvidia.com>
 <20220126093659-mutt-send-email-mst@kernel.org>
 <292327c4-1916-4237-a96c-13ed013fbef6@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <292327c4-1916-4237-a96c-13ed013fbef6@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, parav@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, stefanha@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 26, 2022 at 04:54:22PM +0200, Max Gurtovoy wrote:
> 
> On 1/26/2022 4:40 PM, Michael S. Tsirkin wrote:
> > On Mon, Jan 24, 2022 at 11:39:15AM +0200, Max Gurtovoy wrote:
> > > +Regardless of device offering VIRTIO_F_IN_ORDER, admin queue command buffers
> > > +are used by the device in out of order manner.
> > Instead of special-casing AQ I'd like to see a generic capability
> > addressing this need. For example, TX for virtio net might benefit from
> > this too. And I'd like to mention, again, VIRTIO_F_PARTIAL_ORDER
> > proposal as one, arguably cleaner and more generic way to address this.
> 
> We already suggested a special capability for IN_ORDER for AQ and you asked
> to drop it. We drop it and agreed that AQ will be OOO.
> 
> Why are we going back here ?

That's a misunderstanding. Currently all VQs of a device follow same
ordering. So I suggested making AQ just follow ordering of rest of VQs
of the device.

> You also mentioned that this patch set is already big enough so why solve
> all the problems we can think of in this one ?

Right. So just leave the ordering be for now, driver can just skip
IN_ORDER and use AQ without it if it wants to.

> Why mixing
> VIRTIO_F_PARTIAL_ORDER here ?

PARTIAL_ORDER has its own patch, no need to mix it in. Reusing that
seems cleaner than special-casing here though, we do try to have
reusable modules, otherwise things just get out of hand quickly.

> > And if that's not adequate I'd like to address that as part of the
> > PARTIAL_ORDER proposal, this kind of per-queue in order was definitely
> > on the radar as it was formulated.
> > 

