Return-Path: virtio-dev-return-5917-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 10739985DB0
	for <virtio-dev@lists.oasis-open.org>; Sat,  3 Aug 2019 21:12:21 +0000 (UTC)
Date: Sat, 3 Aug 2019 17:12:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190803170121-mutt-send-email-mst@kernel.org>
References: <20190726095338.24991-1-stefanha@redhat.com>
 <20190726095338.24991-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726095338.24991-2-stefanha@redhat.com>
Subject: Re: [virtio-dev] [PATCH v5 1/2] content: add virtio file system
 device
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Sage Weil <sweil@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jul 26, 2019 at 10:53:37AM +0100, Stefan Hajnoczi wrote:
> +\subsubsection{Live migration considerations}\label{sec:Device Types / File System Device / Live Migration Considerations}
> +
> +When a guest is migrated to a new host

Please use driver and device here and elsewhere.

> it is necessary to consider the FUSE
> +session and its state.  The continuity of FUSE inode numbers (also known as
> +nodeids) and fh values is necessary so the driver can continue operation
> +without disruption.
> +
> +It is possible to maintain the FUSE session across live migration either by
> +transferring the state or by redirecting requests from the new host to the old
> +host where the state resides.  The details of how to achieve this are
> +implementation-dependent and are not visible at the device interface level.
> +
> +Maintaining version and feature information negotiated by FUSE\_INIT is
> +necessary so that no FUSE protocol feature changes are visible to the driver
> +across live migration.  The FUSE\_INIT information forms part of the FUSE
> +session state that needs to be transferred during live migration.

It bothers me that it's implicit, and is not exposed easily at the
virtio level, so one has to bind a virtqueue and run buffers over it to
even just check whether a given device supports a specific interface and
can be migrated to.

How about exposing the version of the device in the config space?
Spec can require that it matches the contents of the INIT command.

....

> -- 
> 2.21.0
> 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

