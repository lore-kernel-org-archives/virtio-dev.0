Return-Path: virtio-dev-return-2630-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 7F5545818081
	for <virtio-dev@lists.oasis-open.org>; Wed, 25 Oct 2017 09:20:04 -0700 (PDT)
Date: Wed, 25 Oct 2017 19:20:01 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171025191346-mutt-send-email-mst@kernel.org>
References: <20160915223915.qjlnlvf2w7u37bu3@redhat.com>
 <AM4PR0501MB27236B71E1B02176F1844ACBD4770@AM4PR0501MB2723.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM4PR0501MB27236B71E1B02176F1844ACBD4770@AM4PR0501MB2723.eurprd05.prod.outlook.com>
Subject: [virtio-dev] Re: packed ring layout proposal v3
To: Ilya Lesokhin <ilyal@mellanox.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, Oct 08, 2017 at 06:16:44AM +0000, Ilya Lesokhin wrote:
> > > -----Original Message-----
> > > From: virtualization-bounces@lists.linux-foundation.org
> > > [mailto:virtualization-bounces@lists.linux-foundation.org] On Behalf
> > > Of Michael S. Tsirkin
> > >
> > > This is an update from v2 version.
> >> ...
> > > When driver descriptors are chained in this way, multiple descriptors
> > > are treated as a part of a single transaction containing an optional
> > > write buffer followed by an optional read buffer.
> > > All descriptors in the chain must have the same ID.
> > >
> 
> I apologize for the repost, I didn't realize I have to be a member of the 
> virtio-dev mailing list.
> 
> I'm concerned about the "same ID" requirement in chained descriptors.

It's there really just so we can remove the doubt about which
descriptor's ID should be used. My testing does not show
a performance win from this, so I'm fine with removing this
requirement though I'd be curious to know why is it a problem.

> Assuming out of order execution, how is the driver supposed to re-assign
> unique IDs to the previously chained descriptor?

For example, driver can have a simple allocator for the IDs.


> Is the driver expected to copy original IDs somewhere else before the
> chaining and then restore the IDs after the chain is executed?
>  
> Thanks,
> Ilya

As device overwrites the ID, driver will have to write it out
each time, that's true. It's going to be a requirement even if
descriptors on the chain do not need to have the same ID.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

