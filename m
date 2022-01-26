Return-Path: <mst@redhat.com>
Date: Wed, 26 Jan 2022 09:40:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 1/4] Add virtio Admin Virtqueue
Message-ID: <20220126093659-mutt-send-email-mst@kernel.org>
References: <20220124093918.34371-1-mgurtovoy@nvidia.com>
 <20220124093918.34371-2-mgurtovoy@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20220124093918.34371-2-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, parav@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, stefanha@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jan 24, 2022 at 11:39:15AM +0200, Max Gurtovoy wrote:
> +Regardless of device offering VIRTIO_F_IN_ORDER, admin queue command buffers
> +are used by the device in out of order manner.

Instead of special-casing AQ I'd like to see a generic capability
addressing this need. For example, TX for virtio net might benefit from
this too. And I'd like to mention, again, VIRTIO_F_PARTIAL_ORDER
proposal as one, arguably cleaner and more generic way to address this.
And if that's not adequate I'd like to address that as part of the
PARTIAL_ORDER proposal, this kind of per-queue in order was definitely
on the radar as it was formulated.

-- 
MST

