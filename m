Return-Path: virtio-dev-return-4655-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3739D985BD5
	for <virtio-dev@lists.oasis-open.org>; Mon,  9 Jul 2018 18:36:02 +0000 (UTC)
Date: Mon, 9 Jul 2018 21:35:52 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180709210946-mutt-send-email-mst@kernel.org>
References: <20180629221907.3662-1-venu.busireddy@oracle.com>
 <20180702161404.GA2339@rkaganb.sw.ru>
 <449f1449-ddf6-cd95-976c-14d04d8d503a@oracle.com>
 <20180703095825.GC30904@rkaganb.sw.ru>
 <d5db37d0-5eaf-8942-8ab7-d73057a67e6f@oracle.com>
 <20180709130035.GA6271@rkaganb.sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709130035.GA6271@rkaganb.sw.ru>
Subject: [virtio-dev] Re: [Qemu-devel] [PATCH v3 0/3] Use of unique identifier for pairing
 virtio and passthrough devices...
To: Roman Kagan <rkagan@virtuozzo.com>, si-wei liu <si-wei.liu@oracle.com>, Venu Busireddy <venu.busireddy@oracle.com>, Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jul 09, 2018 at 04:00:36PM +0300, Roman Kagan wrote:
> > The assumption of failover driver is that the primary (PT device) will be
> > able to get a datapath once it shows up in the guest .
> 
> I wonder how universal this assumption is

Not universal at all. It is however the simplest
use-case we could think of, and that is as a result already
supported by Linux.

I for one will be happy if we spec out a fuller support
for more use-cases but it's probably orthogonal to
grouping.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

