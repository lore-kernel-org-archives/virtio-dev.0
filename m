Return-Path: virtio-dev-return-6707-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D0C4F9847E3
	for <virtio-dev@lists.oasis-open.org>; Mon, 10 Feb 2020 13:39:05 +0000 (UTC)
Date: Mon, 10 Feb 2020 14:38:56 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20200210133856.cethya3kuzbagzw4@sirius.home.kraxel.org>
References: <20200207182842.770bfb27@collabora.com>
MIME-Version: 1.0
In-Reply-To: <20200207182842.770bfb27@collabora.com>
Subject: [virtio-dev] Re: [RFC] Upstreaming virtio-wayland (or an alternative)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Zach Reizner <zachr@chromium.org>, David Stevens <stevensd@chromium.org>, =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tomasz Figa <tfiga@chromium.org>, virtio-dev@lists.oasis-open.org, Alexandros Frantzis <alexandros.frantzis@collabora.co.uk>
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> #1 might require extra care if we want to make it safe, as pointed
> out by Stefan here [4] (but I wonder if the problem is not the same
> for a virtio-wayland based solution). Of course you also need a bit of
> infrastructure to register FD <-> VFD mappings (VFD being a virtual
> file descriptor that's only used as unique IDs identifying the resource
> backed by the local FD). FD <-> VFD mappings would have to be created
> by the subsystem in charge of the object backing the FD (virtio-gpu for
> exported GEM buffers, virtio-vdec for video buffers, vsock for unix
> sockets if we decide to bridge unix and vsock sockets to make it
> transparent, ...). The FD <-> VFD mapping would also have to be created
> on the host side, probably by the virtio device implementation
> (virglrenderer for GEM bufs for instance), which means host and guest
> need a way to inform the other end that a new FD <-> VFD mapping has
> been created so the other end can create a similar mapping (I guess this
> requires extra device-specific commands to work). Note that this
> solution doesn't look so different from the virtio-dmabuf [5] approach
> proposed by Gerd a few months back, it's just extended to be a global
> VFD <-> FD registry instead of a dmabuf <-> unique-handle one. One
> great thing about this approach is that we can re-use it for any kind
> of FD sharing, not just dmabufs.

A dedicated is most likely not going to happen.  Probably virtio-gpu and
possibly other devices too will support attaching a unique handle (a
uuid probably) to a dma-buf, then share buffers like this:

  (1) guest userspace export virtio-gpu resource as dma-buf
  (2) guest kernel generates uuid, sends uuid to the host (or maybe we
      let the host generate the uuid, not clear yet), attaches it to
      the (guest) dma-buf.
  (3) guest userspace imports the dma-buf into virtio-vdev
  (4) virtio-vdec driver finds the uuid attached to the buffer and passes
      it on to the host,
  (5) virtio-vdev device can use the uuid to lookup the buffer on the
      host, then have the host decoder send the data directly to the
      host gpu ...

It certainly makes sense to use this for wayland too, so you just pass
around the uuid if you want pass around a dma-buf (no matter which of
the three solutions).

> #2 is a bit challenging, since it requires the proxy to know about all
> possible kind of FDs and do a FD <-> unique handle conversion with some
> help from the subsystem backing the FD. For dmabufs, that means we
> need to know who created the dmabuf, or assume that only one device is
> used for all allocations (virtio-gpu?).

See above, the uuid idea should simplify this.

> #3 is pretty similar to #1 in its design except that, instead of using
> the VSOCK infrastructure it's using a new type of virtio device. I
> guess it has the same pros and cons #1 has, and the name should probably
> be changed to reflect the fact that it can transmit any kind of data not
> just wayland.

Even though vsock looks simple at first it isn't when you look at the
details.  You'll want support more streams than virtqueues.  So you'll
go multiplex.  You want good performance, but you also don't want allow
streams to DoS the device by filling up the queue.

Thats why I don't like the new virtio device idea much and would prefer
vhost being reused, either directly (#1) or via proxy (#2).

Note that vhost aims to be hypervisor-agnostic and we have (unless I
missed something) three transports for it: virtio, vmware and hyperv.
So extending that with virtio-only features might not be the best idea.

Also it is a fact that approach #1 didn't went anywhere so far but we
have a working implementation of approach #3.  So I guess I wouldn't
veto approach #3 if you pick it after evaluating the options on the
table.

Final note: We have a new kid on the block: virtio-fs.  I think
virtio-fs with dax enabled should allow for shared file mappings between
host and guest.  That is something a proxy (#2) might be able to make
use of.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

