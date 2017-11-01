Return-Path: virtio-dev-return-2643-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Date: Wed, 1 Nov 2017 16:59:25 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171101162357-mutt-send-email-mst@kernel.org>
References: <20171029125225.lx4ezpkbvjjsjv3x@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171029125225.lx4ezpkbvjjsjv3x@localhost.localdomain>
Subject: [virtio-dev] Re: Virtio BoF minutes from KVM Forum 2017
To: Jens Freimann <jfreimann@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, virtio-comment@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, Oct 29, 2017 at 01:52:25PM +0100, Jens Freimann wrote:
> Ilya: - you might have more completions than descriptors available
> - partial descriptor chains are a problem for hardware because you might have
>  to read a bunch of conscriptors twice - how would you do deal with a big
> buffer that cointains a large number of
>  small packets with respect to completions?
> - is one bit for completion enough? right now it means descriptor was actually
>  used. how to we signal when it was completed?

I am not sure I understand the difference. Under virtio, driver makes a
descriptor available, then device reads/writes memory depending on
descriptor type, then marks it as used.

What does completed mean?

> - concerned about not being able to do scatter/gatter with the ring layout.
>  Network drivers heavily using indirect buffers.  - for a hardware
> implementation a completion ring is a very convenient form for
>  some use cases, so we want an efficient implementation for them. If we had an
>  inline descriptor then a completion ring is just a normal ring and we won't
>  need another ring type.
> - doesn't like the fact that we need to do a linear scan to find the length of
>  a descriptor chain. It would be nice if we could have the length of the chain
>  in the first descriptor (i.e. the number of chained descriptors, not the number
>  of posted descriptors which can be deduced from the id field)

Not responding to rest of points since I don't understand the basic
assumption above yet.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

