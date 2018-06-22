Return-Path: virtio-dev-return-4491-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id E9F905818F2F
	for <virtio-dev@lists.oasis-open.org>; Fri, 22 Jun 2018 14:43:37 -0700 (PDT)
Date: Sat, 23 Jun 2018 00:43:24 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180623003545-mutt-send-email-mst@kernel.org>
References: <CADGSJ208NRp=bjhSkzF2K5Ft94TwdRs73WfSp4h-_vXvEKwgiQ@mail.gmail.com>
 <20180619125453.2d2dfb2d.cohuck@redhat.com>
 <20180619233001-mutt-send-email-mst@kernel.org>
 <20180620115359.1a3bf6fb.cohuck@redhat.com>
 <20180620170904-mutt-send-email-mst@kernel.org>
 <20180620180619.6b4ee52d.cohuck@redhat.com>
 <20180620224535-mutt-send-email-mst@kernel.org>
 <20180621165913.7e3f4faa.cohuck@redhat.com>
 <20180621211712-mutt-send-email-mst@kernel.org>
 <20180622170955.298900c1.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622170955.298900c1.cohuck@redhat.com>
Subject: Re: [virtio-dev] Re: [Qemu-devel] [PATCH] qemu: Introduce
 VIRTIO_NET_F_STANDBY feature bit to virtio_net
To: Cornelia Huck <cohuck@redhat.com>
Cc: Siwei Liu <loseweigh@gmail.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, aaron.f.brown@intel.com, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kubakici@wp.pl>, Netdev <netdev@vger.kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, Joao Martins <joao.m.martins@oracle.com>, Venu Busireddy <venu.busireddy@oracle.com>, vijay.balakrishna@oracle.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jun 22, 2018 at 05:09:55PM +0200, Cornelia Huck wrote:
> Would it be more helpful to focus on generic
> migration support for vfio instead of going about it device by device?

Just to note this approach is actually device by device *type*.  It's
mostly device agnostic for a given device type so you can migrate
between hosts with very different hardware.

And support for more PV device types has other advantages
such as security and forward compatibility to future hosts.

Finally, it all can happen mostly within QEMU. User is currently
required to enable it but it's pretty lightweight.

OTOH vfio migration generally requires actual device-specific work, and
only works when hosts are mostly identical. When they aren't it's easy
to blame the user, but tools for checking host compatiblity are
currently non-existent. Upper layer management will also have to learn
about host and device compatibility wrt migration. At the moment they
can't even figure it out wrt software versions of vhost in kernel and
dpdk so I won't hold my breath for all of this happening quickly.


-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

