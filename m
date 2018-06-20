Return-Path: virtio-dev-return-4464-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id B29415819138
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Jun 2018 12:49:01 -0700 (PDT)
Date: Wed, 20 Jun 2018 22:48:58 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180620224535-mutt-send-email-mst@kernel.org>
References: <CADGSJ213f8tJpNXuOhv8qRew-Y5VZAwA+srNMrLZYnKdVGLdAA@mail.gmail.com>
 <20180614120231.0a72bd5f.cohuck@redhat.com>
 <CADGSJ23WnTmVKHezm3t0V6M2sWeHaOUoTjdXkmrvbO0EF83hMg@mail.gmail.com>
 <20180615134815.6613620e.cohuck@redhat.com>
 <CADGSJ208NRp=bjhSkzF2K5Ft94TwdRs73WfSp4h-_vXvEKwgiQ@mail.gmail.com>
 <20180619125453.2d2dfb2d.cohuck@redhat.com>
 <20180619233001-mutt-send-email-mst@kernel.org>
 <20180620115359.1a3bf6fb.cohuck@redhat.com>
 <20180620170904-mutt-send-email-mst@kernel.org>
 <20180620180619.6b4ee52d.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620180619.6b4ee52d.cohuck@redhat.com>
Subject: Re: [virtio-dev] Re: [Qemu-devel] [PATCH] qemu: Introduce
 VIRTIO_NET_F_STANDBY feature bit to virtio_net
To: Cornelia Huck <cohuck@redhat.com>
Cc: Siwei Liu <loseweigh@gmail.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, aaron.f.brown@intel.com, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kubakici@wp.pl>, Netdev <netdev@vger.kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, Joao Martins <joao.m.martins@oracle.com>, Venu Busireddy <venu.busireddy@oracle.com>, vijay.balakrishna@oracle.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jun 20, 2018 at 06:06:19PM +0200, Cornelia Huck wrote:
> In any case, I'm not sure anymore why we'd want the extra uuid.

It's mostly so we can have e.g. multiple devices with same MAC
(which some people seem to want in order to then use
then with different containers).

But it is also handy for when you assign a PF, since then you
can't set the MAC.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

