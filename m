Return-Path: <virtio-dev-return-9713-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 08E7B986304
	for <virtio-dev@lists.oasis-open.org>; Tue,  9 Aug 2022 09:25:32 +0000 (UTC)
Date: Tue, 9 Aug 2022 05:25:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220809052255-mutt-send-email-mst@kernel.org>
References: <20220802044548.9031-1-gavinl@nvidia.com>
 <973632c6-3606-01fb-c584-a6d4774647d8@oracle.com>
 <c4c42174-dcf0-b1e1-a483-0447fbdb1c48@nvidia.com>
 <c173ba21-ad86-6360-5db7-df81de0b0350@oracle.com>
 <465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com>
 <CACGkMEsVG_62yJ5nGmp5ufF_xiEJk2TezQz-QFftF8ezKYLB8A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsVG_62yJ5nGmp5ufF_xiEJk2TezQz-QFftF8ezKYLB8A@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Jason Wang <jasowang@redhat.com>
Cc: Gavin Li <gavinl@nvidia.com>, Si-Wei Liu <si-wei.liu@oracle.com>, "Hemminger, Stephen" <stephen@networkplumber.org>, davem <davem@davemloft.net>, virtualization <virtualization@lists.linux-foundation.org>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, sridhar.samudrala@intel.com, loseweigh@gmail.com, Parav Pandit <parav@nvidia.com>, gavi@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Aug 09, 2022 at 03:44:22PM +0800, Jason Wang wrote:
> > +             unsigned int mtu = vi->dev->mtu;

BTW should this not be max_mtu?  Otherwise if user configures mtu that
is too small we'll add buffers that are too small.  some backends simply
lock up if this happens (I think vhost does).
Maybe we should add a feature to allow packet drop if it's too small.
And send mtu guest to host while we are at it?

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

