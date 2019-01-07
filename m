Return-Path: virtio-dev-return-5272-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 204E3985A63
	for <virtio-dev@lists.oasis-open.org>; Mon,  7 Jan 2019 17:58:59 +0000 (UTC)
Date: Mon, 7 Jan 2019 11:58:54 -0600
From: Venu Busireddy <venu.busireddy@oracle.com>
Message-ID: <20190107175854.GA6932@troi>
References: <1544458548-5986-1-git-send-email-venu.busireddy@oracle.com>
 <1544458548-5986-3-git-send-email-venu.busireddy@oracle.com>
 <6f1e76f0-4871-95fb-4691-d10c216a0826@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f1e76f0-4871-95fb-4691-d10c216a0826@redhat.com>
Subject: [virtio-dev] Re: [Qemu-devel] [PATCH 2/3] virtio_net: Add support for "Data Path
 Switching" during Live Migration.
To: Eric Blake <eblake@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 2018-12-10 13:28:42 -0600, Eric Blake wrote:
> On 12/10/18 10:15 AM, Venu Busireddy wrote:
> > Added two new events, FAILOVER_PLUG_PRIMARY and FAILOVER_UNPLUG_PRIMARY.
> > The first is emitted when the guest negotiates the F_STANDBY feature
> > bit. The second is emitted when the virtio_net driver is removed, either
> > manually or as a result of guest reboot. Management stack can use these
> > events to determine when to plug/unplug the VF device to/from the guest.
> > 
> > Also, the Virtual Functions will be automatically removed from the guest
> > if the guest is rebooted. To properly identify the VFIO devices that
> > must be removed, a new property named "x-failover-primary" is added to
> > the vfio-pci devices. Only the vfio-pci devices that have this property
> > enabled are removed from the guest upon reboot.
> > 
> > Signed-off-by: Venu Busireddy <venu.busireddy@oracle.com>
> > ---
> 
> > +++ b/qapi/net.json
> > @@ -683,3 +683,47 @@
> >   ##
> >   { 'event': 'NIC_RX_FILTER_CHANGED',
> >     'data': { '*name': 'str', 'path': 'str' } }
> > +
> > +##
> > +# @FAILOVER_PLUG_PRIMARY:
> > +#
> > +# Emitted when the guest successfully loads the driver after the STANDBY
> > +# feature bit is negotiated.
> > +#
> > +# @device: Indicates the virtio_net device.
> > +#
> > +# @path: Indicates the device path.
> > +#
> > +# Since: 3.0
> 
> You've missed 3.0, and even 3.1.  This should be 4.0.

Sorry for the delay in responding...

Posted v2 including your suggestion at
https://lists.oasis-open.org/archives/virtio-dev/201901/msg00046.html

Thanks!

> 
> > +#
> > +# Example:
> > +#
> > +# <- {"timestamp": {"seconds": 1432121972, "microseconds": 744001},
> > +#     "event": "FAILOVER_PLUG_PRIMARY",
> > +#     "data": {"device": "net0", "path": "/machine/peripheral/net0/virtio-backend"} }
> > +#
> > +##
> > +{ 'event': 'FAILOVER_PLUG_PRIMARY',
> > +  'data': {'*device': 'str', 'path': 'str'} }
> > +
> > +##
> > +# @FAILOVER_UNPLUG_PRIMARY:
> > +#
> > +# Emitted when the guest resets the virtio_net driver.
> > +# The reset can be the result of either unloading the driver or a reboot.
> > +#
> > +# @device: Indicates the virtio_net device.
> > +#
> > +# @path: Indicates the device path.
> > +#
> > +# Since: 3.0
> 
> and again
> 
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

