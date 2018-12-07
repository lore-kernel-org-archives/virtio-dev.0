Return-Path: virtio-dev-return-5144-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F294C985B10
	for <virtio-dev@lists.oasis-open.org>; Fri,  7 Dec 2018 18:11:57 +0000 (UTC)
Date: Fri, 7 Dec 2018 13:11:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181207131058-mutt-send-email-mst@kernel.org>
References: <20181207084842.13133-1-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207084842.13133-1-tiwei.bie@intel.com>
Subject: [virtio-dev] Re: [RFC 0/3] virtio_ring: define flags as shifts consistently
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, virtio-dev@lists.oasis-open.org, wexu@redhat.com, jfreimann@redhat.com, maxime.coquelin@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Dec 07, 2018 at 04:48:39PM +0800, Tiwei Bie wrote:
> This is a follow up of the discussion in this thread:
> https://patchwork.ozlabs.org/patch/1001015/#2042353

How was this tested? I'd suggest building virtio
before and after the changes, stripped binary
should be exactly the same.


> Tiwei Bie (3):
>   virtio_ring: define flags as shifts consistently
>   virtio_ring: add VIRTIO_RING_NO_LEGACY
>   virtio_ring: use new vring flags
> 
>  drivers/virtio/virtio_ring.c     | 100 ++++++++++++++++++-------------
>  include/uapi/linux/virtio_ring.h |  61 +++++++++++++------
>  2 files changed, 103 insertions(+), 58 deletions(-)
> 
> -- 
> 2.17.1

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

