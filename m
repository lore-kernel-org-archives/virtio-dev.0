Return-Path: virtio-dev-return-4652-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 764B6985B5F
	for <virtio-dev@lists.oasis-open.org>; Mon,  9 Jul 2018 16:10:16 +0000 (UTC)
Date: Mon, 9 Jul 2018 18:10:11 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180709181011.3edc4193.cohuck@redhat.com>
In-Reply-To: <20180709131419.GB6271@rkaganb.sw.ru>
References: <20180629221907.3662-1-venu.busireddy@oracle.com>
	<20180702161404.GA2339@rkaganb.sw.ru>
	<449f1449-ddf6-cd95-976c-14d04d8d503a@oracle.com>
	<20180703095825.GC30904@rkaganb.sw.ru>
	<20180703142817.GA3088@vbusired-vm>
	<20180703165200.180c93bb.cohuck@redhat.com>
	<CADGSJ23+sZiMCx=n=DytZ=TT2z7i0sMhrmnPuFYtuZhSc=qA+Q@mail.gmail.com>
	<20180704141523.377cb66d.cohuck@redhat.com>
	<CADGSJ206U4x0UNTEKu0Lt9K9qA025ajtmnj6ym4PDz4Q-c8RKA@mail.gmail.com>
	<20180706155406.0587733c.cohuck@redhat.com>
	<20180709131419.GB6271@rkaganb.sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] Re: [Qemu-devel] [PATCH v3 0/3] Use of unique
 identifier for pairing virtio and passthrough devices...
To: Roman Kagan <rkagan@virtuozzo.com>
Cc: Siwei Liu <loseweigh@gmail.com>, Venu Busireddy <venu.busireddy@oracle.com>, si-wei liu <si-wei.liu@oracle.com>, "Michael S
 . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 9 Jul 2018 16:14:19 +0300
Roman Kagan <rkagan@virtuozzo.com> wrote:

> On Fri, Jul 06, 2018 at 03:54:06PM +0200, Cornelia Huck wrote:
> > If we want to extend that to other device types, we can add the field
> > in their config space; but I'd rather prefer a more generic "host
> > relays config metainformation" approach.  
> 
> The problem with this approach is that it's too generic and poorly
> scoped.  As a result I guess it's likely to take ages to converge.

I'd certainly not want to wait for it for this particular issue;
however, I think there is value in having this (seeing that at least
Open Stack and s390x DPM already make use of such a mechanism.) But we
can still revisit this later on.

(I'm not too sold on branching out to other device types in general,
but there seems to be demand for it.)

> 
> See for instance the discussion on including vm config metadata in qcow2
> images: I think it's similar in scope (or the absense thereof).
> 
> Roman.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

