Return-Path: virtio-dev-return-4245-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 664E75818F1F
	for <virtio-dev@lists.oasis-open.org>; Fri,  1 Jun 2018 08:42:17 -0700 (PDT)
Date: Fri, 1 Jun 2018 18:42:06 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180601184033-mutt-send-email-mst@kernel.org>
References: <20180523151613.3914-1-venu.busireddy@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523151613.3914-1-venu.busireddy@oracle.com>
Subject: Re: [virtio-dev] [PATCH 0/1] Add "Group Identifier" to virtio PCI
 capabilities.
To: Venu Busireddy <venu.busireddy@oracle.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, May 23, 2018 at 11:16:12AM -0400, Venu Busireddy wrote:
> During live migration involving passthrough devices, the guest needs
> to know which virtio device will be a fail-over device for a given
> passthrough device.
> 
> Extending the virtio specification with a new "Group Identifier"
> capability allows qemu to set up the grouping at the time the guest
> is created. The "Group Identifier" can be as simple as a number, or an
> UUID. The driver can use the group identifier to pair the virtio device
> with the passthrough device. The passthrough device can contain the
> group identifier in the PCIe bridge to which it is attached.
> 
> Venu Busireddy (1):
>   Add "Group Identifier" to virtio PCI capabilities.
> 
>  content.tex | 43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)

Is this a PCI thing, or can this somehow be used with non-PCI
devices? If PCI, we can just add a PCI UUID capability to
virtio without need to worry about the spec.

> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

