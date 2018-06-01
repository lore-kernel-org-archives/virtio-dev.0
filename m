Return-Path: virtio-dev-return-4240-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 22A745818EFF
	for <virtio-dev@lists.oasis-open.org>; Fri,  1 Jun 2018 04:22:48 -0700 (PDT)
Date: Fri, 1 Jun 2018 19:22:50 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180601112250.GA11839@debian>
References: <20180601105950.10632-1-tiwei.bie@intel.com>
 <20180601131647.5d02da18.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180601131647.5d02da18.cohuck@redhat.com>
Subject: [virtio-dev] Re: [PATCH v2] virtio: update the comments for transport features
To: Cornelia Huck <cohuck@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jun 01, 2018 at 01:16:47PM +0200, Cornelia Huck wrote:
> On Fri,  1 Jun 2018 18:59:50 +0800
> Tiwei Bie <tiwei.bie@intel.com> wrote:
> 
> > The existing comments for transport features are out dated.
> 
> s/out dated/outdated/

Thanks for catching this typo!

> 
[...]
> > +/*
> > + * Virtio feature bits VIRTIO_TRANSPORT_F_START through
> > + * VIRTIO_TRANSPORT_F_END are reserved for the transport
> > + * being used (e.g. virtio_ring, virtio_pci etc.), the
> > + * rest are per-device feature bits.
> > + */
> >  #define VIRTIO_TRANSPORT_F_START	28
> >  #define VIRTIO_TRANSPORT_F_END		38
> >  
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Thanks for your review!

Best regards,
Tiwei Bie

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

