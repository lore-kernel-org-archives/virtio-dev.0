Return-Path: virtio-dev-return-4447-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 8262F58191A1
	for <virtio-dev@lists.oasis-open.org>; Tue, 19 Jun 2018 20:16:06 -0700 (PDT)
Date: Wed, 20 Jun 2018 06:15:53 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180620061438-mutt-send-email-mst@kernel.org>
References: <1462367134-23894-1-git-send-email-kraxel@redhat.com>
 <20160509144316.GI3372@stefanha-x1.localdomain>
 <1462874939.8035.52.camel@redhat.com>
 <1462879537.8035.53.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1462879537.8035.53.camel@redhat.com>
Subject: Re: [virtio-dev] [PATCH] Add virtio gpu device specification.
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, May 10, 2016 at 01:25:37PM +0200, Gerd Hoffmann wrote:
>   Hi,
> 
> > > > Rendered versions are available here:
> > > >   https://www.kraxel.org/virtio/virtio-v1.0-cs03-virtio-gpu.pdf
> > > >   https://www.kraxel.org/virtio/virtio-v1.0-cs03-virtio-gpu.html#x1-2800007
> 
> > > I guess a non-fenced command only completes when the operation has
> > > finished, too (so that a meaningful success/error value can be
> > > produced)?
> > 
> > When stuff is processed asynchronously the command can complete before
> > the operation actually completed.  Current qemu implementation does that
> > only in 3d mode, when offloading stuff to the hardware (and verifies
> > stuff beforehand, so if you try to kick 3d rendering with an invalid
> > context id qemu will throw an error).
> > 
> > I'll try to make that more clear in the text.
> 
> Updated now.
> 
> cheers,
>   Gerd

Is there a chance you could rebase and post?
This is used widely, I think we shoould have it in 1.1
if at all possible.


> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

