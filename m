Return-Path: virtio-dev-return-2757-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 506335818F45
	for <virtio-dev@lists.oasis-open.org>; Tue,  5 Dec 2017 07:56:01 -0800 (PST)
Date: Tue, 5 Dec 2017 17:55:45 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171205174833-mutt-send-email-mst@kernel.org>
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
 <1512444796-30615-3-git-send-email-wei.w.wang@intel.com>
 <20171205145950.GF31150@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171205145950.GF31150@stefanha-x1.localdomain>
Subject: Re: [virtio-dev] [PATCH v3 2/7] vhost-pci-net: add vhost-pci-net
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, marcandre.lureau@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, jan.kiszka@siemens.com, avi.cohen@huawei.com, zhiyong.yang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Dec 05, 2017 at 02:59:50PM +0000, Stefan Hajnoczi wrote:
> On Tue, Dec 05, 2017 at 11:33:11AM +0800, Wei Wang wrote:
> > Add the vhost-pci-net device emulation. The device uses bar 2 to expose
> > the remote VM's memory to the guest. The first 4KB of the the bar area
> > stores the metadata which describes the remote memory and vring info.
> 
> This device looks like the beginning of a new "vhost-pci" virtio device
> type.  There are layering violations:
> 
> 1. This has nothing to do with virtio-net or networking, it's purely
>    vhost-pci.  Why is it called vhost-pci-net instead of vhost-pci?
> 
> 2. VirtIODevice does not know about PCI.  It should work over virtio-ccw
>    or virtio-mmio.  This patch talks about BARs inside a VirtIODevice so
>    there is a problem here.

I think the point is how memory is exposed to another guest.  This
device exposes it as a pci bar. I don't think e.g. ccw can do this,
it's all hypercall-based.

> I'm concerned that there is no clear architecture and elements of the
> virtio architecture are being mixed up with no justification.
> 
> Can you explain what you're trying to do?
> 
> Please post a specification for the vhost-pci device so the operation of
> the device can be discussed and is clear to reviewers.



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

