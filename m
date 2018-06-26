Return-Path: virtio-dev-return-4545-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id B39B71CB80ED
	for <virtio-dev@lists.oasis-open.org>; Tue, 26 Jun 2018 10:43:05 -0700 (PDT)
Date: Tue, 26 Jun 2018 20:42:53 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180626204237-mutt-send-email-mst@kernel.org>
References: <20180623002628-mutt-send-email-mst@kernel.org>
 <CADGSJ20td7b6He6S1PBSJjCq=bNvgqMGbOjiho2eeQm2pgpK3g@mail.gmail.com>
 <20180623012406-mutt-send-email-mst@kernel.org>
 <CADGSJ211pWKYnuuzcgUqJZiHU+=7H3oQSpp1TnE=+EBjkdmCSQ@mail.gmail.com>
 <CADGSJ22DX8=rNPY+gNS_q=LCYLR5ieoE7oD8p4+8AnpzQsWSCg@mail.gmail.com>
 <da144f8f-65cd-45d9-3c81-6c8ca1fb25fe@intel.com>
 <20180626044650-mutt-send-email-mst@kernel.org>
 <20180626171732.5038f53f.cohuck@redhat.com>
 <20180626183706-mutt-send-email-mst@kernel.org>
 <20180626180316.3723422f.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626180316.3723422f.cohuck@redhat.com>
Subject: Re: [virtio-dev] Re: [Qemu-devel] [PATCH] qemu: Introduce
 VIRTIO_NET_F_STANDBY feature bit to virtio_net
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Siwei Liu <loseweigh@gmail.com>, Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, aaron.f.brown@intel.com, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kubakici@wp.pl>, Netdev <netdev@vger.kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, Joao Martins <joao.m.martins@oracle.com>, Venu Busireddy <venu.busireddy@oracle.com>, vijay.balakrishna@oracle.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jun 26, 2018 at 06:03:16PM +0200, Cornelia Huck wrote:
> Ok, that makes me conclude that we definitely need to involve the
> libvirt folks before we proceed further with defining QEMU interfaces.

That's always a wise thing to do.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

