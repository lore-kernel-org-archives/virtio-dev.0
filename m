Return-Path: virtio-dev-return-4502-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 9A43F1CB80F3
	for <virtio-dev@lists.oasis-open.org>; Sat, 23 Jun 2018 18:45:51 -0700 (PDT)
Date: Sun, 24 Jun 2018 04:45:36 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180624044436-mutt-send-email-mst@kernel.org>
References: <20180621165913.7e3f4faa.cohuck@redhat.com>
 <CADGSJ22B39JiS14L0yCYQ720-fZcwyUt1wCX1YO-6Y9FhmDKZg@mail.gmail.com>
 <20180622053141-mutt-send-email-mst@kernel.org>
 <CADGSJ23SBEFJCD50K-F-Gt86Q1-i_6iHTmSSjdXDzNnnpWZ_oQ@mail.gmail.com>
 <CADGSJ22nLcz_XaJNzUUdpjQaJY8b5wZs=ohm=B7c2qf2K7_yGA@mail.gmail.com>
 <20180623002628-mutt-send-email-mst@kernel.org>
 <CADGSJ20td7b6He6S1PBSJjCq=bNvgqMGbOjiho2eeQm2pgpK3g@mail.gmail.com>
 <20180623012406-mutt-send-email-mst@kernel.org>
 <CADGSJ211pWKYnuuzcgUqJZiHU+=7H3oQSpp1TnE=+EBjkdmCSQ@mail.gmail.com>
 <CADGSJ22DX8=rNPY+gNS_q=LCYLR5ieoE7oD8p4+8AnpzQsWSCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADGSJ22DX8=rNPY+gNS_q=LCYLR5ieoE7oD8p4+8AnpzQsWSCg@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [Qemu-devel] [PATCH] qemu: Introduce
 VIRTIO_NET_F_STANDBY feature bit to virtio_net
To: Siwei Liu <loseweigh@gmail.com>
Cc: Cornelia Huck <cohuck@redhat.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, aaron.f.brown@intel.com, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kubakici@wp.pl>, Netdev <netdev@vger.kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, Joao Martins <joao.m.martins@oracle.com>, Venu Busireddy <venu.busireddy@oracle.com>, vijay.balakrishna@oracle.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jun 22, 2018 at 05:17:10PM -0700, Siwei Liu wrote:
> I forgot to mention the above has the assumption that we expose both
> STANDBY and UUID feature to QEMU user. In fact, as we're going towards
> not exposing the STANDBY feature directly to user, UUID may be always
> required to enable STANDBY.

Sounds good.

> If not, how do we make sure QEMU can
> control the visibility of primary device?

Hypervisors fundamentally always can control visibility of all
virtual devices.

> Something to be confirmed
> before implementing the code.
> 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

