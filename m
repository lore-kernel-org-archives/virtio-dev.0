Return-Path: virtio-dev-return-4383-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 3E9F758191F6
	for <virtio-dev@lists.oasis-open.org>; Thu, 14 Jun 2018 05:50:06 -0700 (PDT)
Date: Thu, 14 Jun 2018 15:50:03 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180614144414-mutt-send-email-mst@kernel.org>
References: <1525734594-11134-1-git-send-email-sridhar.samudrala@intel.com>
 <20180611202207-mutt-send-email-mst@kernel.org>
 <dc8b1669-b8b6-fb59-94e2-6e4de6b96572@redhat.com>
 <20180612051432-mutt-send-email-mst@kernel.org>
 <23fc4aa4-ec41-d6e2-3354-10cbfc13b7ec@intel.com>
 <20180612142557-mutt-send-email-mst@kernel.org>
 <b9c88515-cf41-2a9a-078e-9c9e5adbbf14@intel.com>
 <CADGSJ213f8tJpNXuOhv8qRew-Y5VZAwA+srNMrLZYnKdVGLdAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADGSJ213f8tJpNXuOhv8qRew-Y5VZAwA+srNMrLZYnKdVGLdAA@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [Qemu-devel] [PATCH] qemu: Introduce
 VIRTIO_NET_F_STANDBY feature bit to virtio_net
To: Siwei Liu <loseweigh@gmail.com>
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Jason Wang <jasowang@redhat.com>, Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kubakici@wp.pl>, Netdev <netdev@vger.kernel.org>, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, virtualization@lists.linux-foundation.org, aaron.f.brown@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jun 13, 2018 at 06:02:01PM -0700, Siwei Liu wrote:
> >> And it's the guest that needs failover support not the VM.
> >
> >
> > Isn't guest and VM synonymous?

Guest is whatever software is running on top of the hypervisor.

The virtual machine is the interface between the two.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

