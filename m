Return-Path: virtio-dev-return-2635-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 54D7158190D3
	for <virtio-dev@lists.oasis-open.org>; Sun, 29 Oct 2017 19:08:49 -0700 (PDT)
Date: Mon, 30 Oct 2017 04:08:46 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171030040341-mutt-send-email-mst@kernel.org>
References: <20160915223915.qjlnlvf2w7u37bu3@redhat.com>
 <AM4PR0501MB27236B71E1B02176F1844ACBD4770@AM4PR0501MB2723.eurprd05.prod.outlook.com>
 <20171025191346-mutt-send-email-mst@kernel.org>
 <AM4PR0501MB2723177BF4E5EE32CC878E8CD4580@AM4PR0501MB2723.eurprd05.prod.outlook.com>
 <20171029162117-mutt-send-email-mst@kernel.org>
 <AM4PR0501MB272332C92A384C97D6975D8DD4580@AM4PR0501MB2723.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM4PR0501MB272332C92A384C97D6975D8DD4580@AM4PR0501MB2723.eurprd05.prod.outlook.com>
Subject: [virtio-dev] Re: packed ring layout proposal v3
To: Ilya Lesokhin <ilyal@mellanox.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, Oct 29, 2017 at 02:34:56PM +0000, Ilya Lesokhin wrote:
> > -----Original Message-----
> > From: Michael S. Tsirkin [mailto:mst@redhat.com]
> > Sent: Sunday, October 29, 2017 4:22 PM
> > To: Ilya Lesokhin <ilyal@mellanox.com>
> > Cc: virtio-dev@lists.oasis-open.org; virtualization@lists.linux-foundation.org
> > Subject: Re: packed ring layout proposal v3
> > 
> > If you do this whats the point of the id? Just use descriptor offset like virtio 0 did.
> > 
> 
> I agree that ID is pointless when requests are completed in order.
> 
> But I'm not sure what you mean by descriptor offset?

Where the descriptor is within the ring.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

