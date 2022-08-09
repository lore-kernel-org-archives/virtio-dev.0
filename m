Return-Path: <virtio-dev-return-9715-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0831D986304
	for <virtio-dev@lists.oasis-open.org>; Tue,  9 Aug 2022 09:40:51 +0000 (UTC)
MIME-Version: 1.0
References: <20220802044548.9031-1-gavinl@nvidia.com> <973632c6-3606-01fb-c584-a6d4774647d8@oracle.com>
 <c4c42174-dcf0-b1e1-a483-0447fbdb1c48@nvidia.com> <c173ba21-ad86-6360-5db7-df81de0b0350@oracle.com>
 <465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com> <CACGkMEsVG_62yJ5nGmp5ufF_xiEJk2TezQz-QFftF8ezKYLB8A@mail.gmail.com>
 <20220809052255-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220809052255-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 9 Aug 2022 17:40:34 +0800
Message-ID: <CACGkMEv=SXfhEhi2v23Q2-VZBa4Ji9JF1Dyd2PBWQHA44SiyCQ@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Content-Type: text/plain; charset="UTF-8"
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gavin Li <gavinl@nvidia.com>, Si-Wei Liu <si-wei.liu@oracle.com>, "Hemminger, Stephen" <stephen@networkplumber.org>, davem <davem@davemloft.net>, virtualization <virtualization@lists.linux-foundation.org>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, sridhar.samudrala@intel.com, loseweigh@gmail.com, Parav Pandit <parav@nvidia.com>, gavi@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Aug 9, 2022 at 5:25 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Aug 09, 2022 at 03:44:22PM +0800, Jason Wang wrote:
> > > +             unsigned int mtu = vi->dev->mtu;
>
> BTW should this not be max_mtu?

Yes.

> Otherwise if user configures mtu that
> is too small we'll add buffers that are too small.  some backends simply
> lock up if this happens (I think vhost does).

Probably not? If we run out of buffers, we will wait for the next
kick. (Otherwise it would be an guest triggerable behaviour)

> Maybe we should add a feature to allow packet drop if it's too small.

I may miss something but isn't this what most devices will do? (e.g
ethernet have a minimal packet length)

Thanks

> And send mtu guest to host while we are at it?
>
> --
> MST
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

