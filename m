Return-Path: virtio-dev-return-3087-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id E71A85819113
	for <virtio-dev@lists.oasis-open.org>; Fri, 26 Jan 2018 14:14:33 -0800 (PST)
Date: Sat, 27 Jan 2018 00:14:20 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180127000831-mutt-send-email-mst@kernel.org>
References: <1515736720-39368-1-git-send-email-sridhar.samudrala@intel.com>
 <1515736720-39368-3-git-send-email-sridhar.samudrala@intel.com>
 <CADGSJ22BsdB-hDb0xebSyWrwDuBJaFACjb26PDoqAd2Ah+tsQg@mail.gmail.com>
 <20180122233205-mutt-send-email-mst@kernel.org>
 <CADGSJ209vrdjnEAweLg84FwN3sf+1W+APmvB=NjFkMNAhsOyrg@mail.gmail.com>
 <20180124004556-mutt-send-email-mst@kernel.org>
 <CADGSJ2308J=tb1B1zrPi0bFzqYSoLfJsRZxBg6wT+wuCfRO6vw@mail.gmail.com>
 <731db0a0-85e7-a88e-6e0e-c540086347b5@intel.com>
 <CADGSJ205yeyGV2nJ9Cr=FwPypxAHb12jx3WitS6UmWSJ9VP42Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADGSJ205yeyGV2nJ9Cr=FwPypxAHb12jx3WitS6UmWSJ9VP42Q@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [RFC PATCH net-next v2 2/2] virtio_net: Extend
 virtio to use VF datapath when available
To: Siwei Liu <loseweigh@gmail.com>
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, Jakub Kicinski <kubakici@wp.pl>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jan 26, 2018 at 01:46:42PM -0800, Siwei Liu wrote:
> > and the VM is not expected to do any tuning/optimizations on the VF driver
> > directly,
> > i think the current patch that follows the netvsc model of 2 netdevs(virtio
> > and vf) should
> > work fine.
> 
> OK. For your use case that's fine. But that's too specific scenario
> with lots of restrictions IMHO, perhaps very few users will benefit
> from it, I'm not sure. If you're unwilling to move towards it, we'd
> take this one and come back with a generic solution that is able to
> address general use cases for VF/PT live migration .

I think that's a fine approach. Scratch your own itch!  I imagine a very
generic virtio-switchdev providing host routing info to guests could
address lots of usecases. A driver could bind to that one and enslave
arbitrary other devices.  Sounds reasonable.

But given the fundamental idea of a failover was floated at least as
early as 2013, and made 0 progress since precisely because it kept
trying to address more and more features, and given netvsc is already
using the basic solution with some success, I'm not inclined to block
this specific effort waiting for the generic one.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

