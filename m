Return-Path: virtio-dev-return-4444-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id E813F1CB80EE
	for <virtio-dev@lists.oasis-open.org>; Tue, 19 Jun 2018 13:32:18 -0700 (PDT)
Date: Tue, 19 Jun 2018 23:32:06 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180619233001-mutt-send-email-mst@kernel.org>
References: <20180612051432-mutt-send-email-mst@kernel.org>
 <23fc4aa4-ec41-d6e2-3354-10cbfc13b7ec@intel.com>
 <20180612142557-mutt-send-email-mst@kernel.org>
 <b9c88515-cf41-2a9a-078e-9c9e5adbbf14@intel.com>
 <CADGSJ213f8tJpNXuOhv8qRew-Y5VZAwA+srNMrLZYnKdVGLdAA@mail.gmail.com>
 <20180614120231.0a72bd5f.cohuck@redhat.com>
 <CADGSJ23WnTmVKHezm3t0V6M2sWeHaOUoTjdXkmrvbO0EF83hMg@mail.gmail.com>
 <20180615134815.6613620e.cohuck@redhat.com>
 <CADGSJ208NRp=bjhSkzF2K5Ft94TwdRs73WfSp4h-_vXvEKwgiQ@mail.gmail.com>
 <20180619125453.2d2dfb2d.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619125453.2d2dfb2d.cohuck@redhat.com>
Subject: Re: [virtio-dev] Re: [Qemu-devel] [PATCH] qemu: Introduce
 VIRTIO_NET_F_STANDBY feature bit to virtio_net
To: Cornelia Huck <cohuck@redhat.com>
Cc: Siwei Liu <loseweigh@gmail.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, aaron.f.brown@intel.com, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kubakici@wp.pl>, Netdev <netdev@vger.kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, Joao Martins <joao.m.martins@oracle.com>, Venu Busireddy <venu.busireddy@oracle.com>, vijay.balakrishna@oracle.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jun 19, 2018 at 12:54:53PM +0200, Cornelia Huck wrote:
> Sorry about dragging mainframes into this, but this will only work for
> homogenous device coupling, not for heterogenous. Consider my vfio-pci
> + virtio-net-ccw example again: The guest cannot find out that the two
> belong together by checking some group ID, it has to either use the MAC
> or some needs-to-be-architectured property.
> 
> Alternatively, we could propose that mechanism as pci-only, which means
> we can rely on mechanisms that won't necessarily work on non-pci
> transports. (FWIW, I don't see a use case for using vfio-ccw to pass
> through a network card anytime in the near future, due to the nature of
> network cards currently in use on s390.)

That's what it boils down to, yes.  If there's need to have this for
non-pci devices, then we should put it in config space.
Cornelia, what do you think?

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

