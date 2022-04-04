Return-Path: <mst@redhat.com>
Date: Mon, 4 Apr 2022 18:29:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 1/1] Introduce MGMT Admin commands
Message-ID: <20220404181653-mutt-send-email-mst@kernel.org>
References: <20220302160237.26742-1-mgurtovoy@nvidia.com>
 <20220302160237.26742-2-mgurtovoy@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20220302160237.26742-2-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, parav@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, stefanha@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Mar 02, 2022 at 06:02:37PM +0200, Max Gurtovoy wrote:
> +It is beyond the scope of the virtio specification to define necessary synchronization in system software to ensure that a virtio PCI VF device
> +interrupt configuration modification is reflected in the PCI device. However, it is expected that any modern system software implementing virtio
> +drivers and PCI subsystem will ensure that any changes occurring in the VF interrupt configuration is either updated in the PCI VF device or
> +such configuration fails.

I am no longer sure this assertion holds. For example, how would the PF
driver ensure that e.g. VFIO is not bound to a VF for passthrough to
a VM and is not configuring the MSI-X configuration of the VF?
I don't really see a way to do that cleanly.

Would you care to post a proof of concept or even a pseudo-code patch?

It appears even harder to support in an (admittedly, uncommon,
but apparently available due to virtio subsystem not necessarily
matching the PF boundary) case where the admin queue is
in a VF and so the admin driver is running within guest.

I thus have been thinking of an alternate approach, where the # of MSIX
vectors does not change, but the # of VQs does.  Since guests do not
currently request more vectors than VQs, this will address the
requirement in a cleaner way that guests should be able to universally
support.  Synchronization then can be achieved by failing the command if
any status bits (or just VIRTIO_CONFIG_S_DRIVER?  did not think too
deeply about the difference ...) in the affected VFs are set indicating
an attached driver. A new feature bit might be required for this and
maybe a new field indicating the actual # of vectors.


-- 
MST

