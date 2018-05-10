Return-Path: virtio-dev-return-4061-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id D349B5819121
	for <virtio-dev@lists.oasis-open.org>; Thu, 10 May 2018 03:39:21 -0700 (PDT)
Date: Thu, 10 May 2018 18:39:41 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180510103941.znxka65iluybktuq@debian>
References: <20180504045915.17693-1-tiwei.bie@intel.com>
 <20180510095317.GO1296@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180510095317.GO1296@stefanha-x1.localdomain>
Subject: [virtio-dev] Re: [PATCH v1] virtio: support VIRTIO_F_IO_BARRIER
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org, dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, May 10, 2018 at 10:53:17AM +0100, Stefan Hajnoczi wrote:
> On Fri, May 04, 2018 at 12:59:15PM +0800, Tiwei Bie wrote:
> > diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
> > index 308e2096291f..9fb519a9df28 100644
> > --- a/include/uapi/linux/virtio_config.h
> > +++ b/include/uapi/linux/virtio_config.h
> > @@ -49,7 +49,7 @@
> >   * transport being used (eg. virtio_ring), the rest are per-device feature
> >   * bits. */
> >  #define VIRTIO_TRANSPORT_F_START	28
> > -#define VIRTIO_TRANSPORT_F_END		34
> > +#define VIRTIO_TRANSPORT_F_END		37
> 
> Have you updated "2.2 Feature Bits" in the VIRTIO spec?
> 
> In 1.0 it says:
> 
>  24 to 32
>     Feature bits reserved for extensions to the queue and feature negotiation mechanisms
> 
> This information is out-of-date.
> 

No. In the latest spec draft, it's 24 to 33. And it
becomes out-of-date since VIRTIO_F_RING_PACKED(34)
and VIRTIO_F_IN_ORDER(35) were introduced. Do you
want me to update it in the IO_BARRIER patch or do
you want me to update it in a new patch?

Best regards,
Tiwei Bie

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

