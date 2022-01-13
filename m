Return-Path: <virtio-dev-return-9033-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EBCB9986502
	for <virtio-dev@lists.oasis-open.org>; Thu, 13 Jan 2022 15:18:40 +0000 (UTC)
Date: Thu, 13 Jan 2022 10:18:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220113101726-mutt-send-email-mst@kernel.org>
References: <20220112055755.41011-1-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220112055755.41011-1-jasowang@redhat.com>
Subject: [virtio-dev] Re: [PATCH V2 0/2] virito-pci: PASID support
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Jason Wang <jasowang@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, stefanha@redhat.com, eperezma@redhat.com, lulu@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 12, 2022 at 01:57:53PM +0800, Jason Wang wrote:
> Hi All:
> 
> This series tries to add PASID support for virtio-pci to allow the
> virtqueue to use PASID TLP prefix for PCI transactions. This will be
> useful for future work like, queue assignment, virtqueue
> virtualization and presenting multiple vDPA devices with a single PCI
> device.


Try this:

echo "ab virito virtio" >> ~/.vimrc

and your subjects will be perfect from now on.


> Since we're short of the space for the PCI capabilities, the PCI
> extended capability for virtio structure is introduced that allows the
> PASID configuration structure to use.
> 
> A prototype is implemented with emulated virtio-pci device in [1]. A
> test driver is implemented in [2].
> 
> Please review.
> 
> Thanks
> 
> [1] https://github.com/jasowang/qemu.git virtio-pasid
> [2] https://github.com/jasowang/linux.git virtio-pasid
> 
> Jason Wang (2):
>   virtio-pci: introduce virtio structure PCI Extended Capability
>   virtio-pci: add PASID configuration extended capability
> 
>  content.tex | 244 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 244 insertions(+)
> 
> -- 
> 2.32.0 (Apple Git-132)


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

