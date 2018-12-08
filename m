Return-Path: virtio-dev-return-5147-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D0E13985B20
	for <virtio-dev@lists.oasis-open.org>; Sat,  8 Dec 2018 13:28:53 +0000 (UTC)
Date: Sat, 8 Dec 2018 21:26:57 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20181208132656.GA29772@dpdk-tbie>
References: <20181207084842.13133-1-tiwei.bie@intel.com>
 <20181207131058-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181207131058-mutt-send-email-mst@kernel.org>
Subject: [virtio-dev] Re: [RFC 0/3] virtio_ring: define flags as shifts consistently
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, virtio-dev@lists.oasis-open.org, wexu@redhat.com, jfreimann@redhat.com, maxime.coquelin@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Dec 07, 2018 at 01:11:42PM -0500, Michael S. Tsirkin wrote:
> On Fri, Dec 07, 2018 at 04:48:39PM +0800, Tiwei Bie wrote:
> > This is a follow up of the discussion in this thread:
> > https://patchwork.ozlabs.org/patch/1001015/#2042353
> 
> How was this tested? I'd suggest building virtio
> before and after the changes, stripped binary
> should be exactly the same.

Sure, I will do the test with scripts/objdiff.

> 
> 
> > Tiwei Bie (3):
> >   virtio_ring: define flags as shifts consistently
> >   virtio_ring: add VIRTIO_RING_NO_LEGACY
> >   virtio_ring: use new vring flags
> > 
> >  drivers/virtio/virtio_ring.c     | 100 ++++++++++++++++++-------------
> >  include/uapi/linux/virtio_ring.h |  61 +++++++++++++------
> >  2 files changed, 103 insertions(+), 58 deletions(-)
> > 
> > -- 
> > 2.17.1

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

