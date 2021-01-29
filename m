Return-Path: virtio-dev-return-7964-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CA788986589
	for <virtio-dev@lists.oasis-open.org>; Fri, 29 Jan 2021 15:58:31 +0000 (UTC)
Date: Fri, 29 Jan 2021 10:58:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20210129105653-mutt-send-email-mst@kernel.org>
References: <875d1495-9511-4b5d-062c-2063ee9bed7e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <875d1495-9511-4b5d-062c-2063ee9bed7e@redhat.com>
Subject: [virtio-dev] Re: Packed ring only devices clarification
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Jason Wang <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jan 29, 2021 at 09:38:25AM +0100, Maxime Coquelin wrote:
> Hello,
> 
> In the Virtqueues section of the Virtio specification [0], it is
> mentioned that:
> 
> "
> Every driver and device supports either the Packed or the Split
> Virtqueue format, or both.
> "
> 
> However, it seems there is no way to differentiate whether the device
> supports both split and packed ring, or only packed ring by reading
> its features bits.
> 
> In the case of live-migration, it means we would need to trigger a
> features negotiation before the migration is initiated, and see if
> FEATURES_OK device status bit is set. Still, we could not be sure a
> failure would be due to the device supporting only packed ring.
> 
> Is my understanding correct?


The simple answer is that live migration is transparent to
guests and so isn't ATM described by the virtio spec.

devices implementing live migration need not constrain
themselves to using the feature bits described in the spec,
e.g. vhost-user has its own "protocol features".

> If so, maybe we would need to introduce a new feature bit for split
> ring, and also a feature bit indicating compliance with the new spec
> version for backward compatibility:
> 
> VIRTIO_F_VERSION_1_2(39):
>     This indicates compliance with Virtio version 1.2 specification.
> 
> VIRTIO_F_RING_SPLIT(40):
>     This feature indicates support for the split virtqueue layout as
>     described in 2.6 Split Virtqueues.
> 
> 
> Best regards,
> Maxime
> 
> [0]:
> https://docs.oasis-open.org/virtio/virtio/v1.1/csprd01/virtio-v1.1-csprd01.html#x1-230005


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

