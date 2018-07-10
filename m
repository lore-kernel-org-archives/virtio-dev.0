Return-Path: virtio-dev-return-4658-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 17B48985B04
	for <virtio-dev@lists.oasis-open.org>; Tue, 10 Jul 2018 01:58:15 +0000 (UTC)
Date: Tue, 10 Jul 2018 04:58:13 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180710045614-mutt-send-email-mst@kernel.org>
References: <20180629221907.3662-1-venu.busireddy@oracle.com>
 <20180702161404.GA2339@rkaganb.sw.ru>
 <449f1449-ddf6-cd95-976c-14d04d8d503a@oracle.com>
 <20180703095825.GC30904@rkaganb.sw.ru>
 <d5db37d0-5eaf-8942-8ab7-d73057a67e6f@oracle.com>
 <20180709130035.GA6271@rkaganb.sw.ru>
 <9136094e-a510-4201-7c71-d1c49226fa5f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9136094e-a510-4201-7c71-d1c49226fa5f@oracle.com>
Subject: [virtio-dev] Re: [Qemu-devel] [PATCH v3 0/3] Use of unique identifier for pairing
 virtio and passthrough devices...
To: si-wei liu <si-wei.liu@oracle.com>
Cc: Roman Kagan <rkagan@virtuozzo.com>, Venu Busireddy <venu.busireddy@oracle.com>, Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, sridhar.samudrala@intel.com, alexander.h.duyck@intel.com, netdev@vger.kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jul 09, 2018 at 06:11:53PM -0700, si-wei liu wrote:
> What do we buy
> for using a random address during initial discovery and requiring VF to
> complete the handshake?

I don't see advantages to using a random address that is then
changed either: changing a MAC causes network downtime for most users.

> Less network downtime during datapath switching?
> Sorry but that's not a key factor at all for our main goal - live migration.

Isn't avoiding downtime what makes the migration "live"?
If you don't care about it at all just remove the device
and migrate without all these tricks.


-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

