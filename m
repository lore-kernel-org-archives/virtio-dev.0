Return-Path: virtio-dev-return-4660-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 191E0985B04
	for <virtio-dev@lists.oasis-open.org>; Tue, 10 Jul 2018 02:11:22 +0000 (UTC)
Date: Tue, 10 Jul 2018 05:11:18 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180710050913-mutt-send-email-mst@kernel.org>
References: <20180629221907.3662-1-venu.busireddy@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629221907.3662-1-venu.busireddy@oracle.com>
Subject: [virtio-dev] Re: [PATCH v3 0/3] Use of unique identifier for pairing virtio and
 passthrough devices...
To: Venu Busireddy <venu.busireddy@oracle.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jun 29, 2018 at 05:19:03PM -0500, Venu Busireddy wrote:
> The current patch set includes all the feedback received for proposals [3]
> and [4]. For the sake of completeness, patch for the virtio specification
> is also included here. Following is the updated proposal.
> 
> 1. Extend the virtio specification to include a new virtio PCI capability
>    "VIRTIO_PCI_CAP_GROUP_ID_CFG".

....

>  default-configs/arm-softmmu.mak             |   1 +
>  default-configs/i386-softmmu.mak            |   1 +
>  default-configs/x86_64-softmmu.mak          |   1 +
>  hw/pci-bridge/Makefile.objs                 |   1 +
>  hw/pci-bridge/pci_bridge_dev.c              |  10 +
>  hw/pci-bridge/pcie_downstream.c             | 220 ++++++++++++++++++++
>  hw/pci-bridge/pcie_downstream.h             |  10 +
>  hw/pci/pci_bridge.c                         |  34 +++
>  hw/virtio/virtio-pci.c                      |  15 ++
>  hw/virtio/virtio-pci.h                      |   3 +-
>  include/hw/pci/pci.h                        |  37 ++--
>  include/hw/pci/pci_bridge.h                 |   2 +
>  include/hw/pci/pcie.h                       |   1 +
>  include/standard-headers/linux/virtio_pci.h |   8 +
>  14 files changed, 326 insertions(+), 18 deletions(-)
>  create mode 100644 hw/pci-bridge/pcie_downstream.c
>  create mode 100644 hw/pci-bridge/pcie_downstream.h

I don't see the spec patch here.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

