Return-Path: virtio-dev-return-4280-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 9C0A458180EB
	for <virtio-dev@lists.oasis-open.org>; Tue,  5 Jun 2018 13:38:06 -0700 (PDT)
Date: Tue, 5 Jun 2018 23:37:54 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180605232907-mutt-send-email-mst@kernel.org>
References: <1525734594-11134-1-git-send-email-sridhar.samudrala@intel.com>
 <fcefe501-b410-f1ec-829c-68199edcdbef@intel.com>
 <20180605152344-mutt-send-email-mst@kernel.org>
 <0a69d897-d084-8a7e-a681-86a49ab8f59a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a69d897-d084-8a7e-a681-86a49ab8f59a@intel.com>
Subject: [virtio-dev] Re: [PATCH] qemu: Introduce VIRTIO_NET_F_STANDBY feature bit to
 virtio_net
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Cc: virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, jasowang@redhat.com, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jun 05, 2018 at 01:20:33PM -0700, Samudrala, Sridhar wrote:
> 
> On 6/5/2018 5:33 AM, Michael S. Tsirkin wrote:
> > I don't think this is sufficient.
> 
> Sure. This is not sufficient for a complete solution, but is Qemu the right place
> to manage primary/standby interfaces?
> 
> I think the other steps including plugging/unplugging the primary interface needs
> to handled by some orchestration layer.

I don't see any real benefit to it but yes, you can push it up the stack.
Unfortunately the patch still won't be sufficient then, see below :)

> 
> > 
> > If both primary and standby devices are present, a legacy guest without
> > support for the feature might see two devices with same mac and get
> > confused.
> 
> Yes. Isn't this possible today when a VM is started with a mis-configured domain
> XML file that passes a virtio-net interface and a VF with the same MAC?

Yes, so if you misconfigure the hypervisor then your guest won't run.
Not sure what you are trying to say by this though.

> 
> > 
> > I think that we should only make primary visible after guest acked the
> > backup feature bit.
> 
> The primary can be plugged/unplugged at any time by the management layer.
> So i guess this needs to be handled in the libvirt layer.

management just wants to give the primary to guest and later take it back,
it really does not care about the details of the process,
so I don't see what does pushing it up the stack buy you.

So I don't think it *needs* to be done in libvirt. It probably can if you
add a bunch of hooks so it knows whenever vm reboots, driver binds and
unbinds from device, and can check that backup flag was set.
If you are pushing for a setup like that please get a buy-in
from libvirt maintainers or better write a patch.

> > 
> > And on reset or when backup is cleared in some other way, unplug the
> > primary.
> > 
> > Something like the below will do the job:
> > 
> > Primary device is added with a special "primary-failover" flag.
> 
> Are you suggesting an extension to Qemu to add another flag for
> primary device too?

Exactly.

> > A virtual machine is then initialized with just a standby virtio
> > device. Primary is not yet added.
> > 
> > Later QEMU detects that guest driver device set DRIVER_OK.
> > It then exposes the primary device to the guest, and triggers
> > a device addition event (hot-plug event) for it.
> > 
> > If QEMU detects guest driver removal, it initiates a hot-unplug sequence
> > to remove the primary driver.  In particular, if QEMU detects guest
> > re-initialization (e.g. by detecting guest reset) it immediately removes
> > the primary device.
> > 
> > We can move some of this code to management as well, architecturally it
> > does not make too much sense but it might be easier implementation-wise.
> > 
> > HTH
> > 
> > On Mon, Jun 04, 2018 at 06:41:48PM -0700, Samudrala, Sridhar wrote:
> > > Ping on this patch now that the kernel patches are accepted into davem's net-next tree.
> > > https://patchwork.ozlabs.org/cover/920005/
> > > 
> > > 
> > > On 5/7/2018 4:09 PM, Sridhar Samudrala wrote:
> > > > This feature bit can be used by hypervisor to indicate virtio_net device to
> > > > act as a standby for another device with the same MAC address.
> > > > 
> > > > I tested this with a small change to the patch to mark the STANDBY feature 'true'
> > > > by default as i am using libvirt to start the VMs.
> > > > Is there a way to pass the newly added feature bit 'standby' to qemu via libvirt
> > > > XML file?
> > > > 
> > > > Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> > > > ---
> > > >    hw/net/virtio-net.c                         | 2 ++
> > > >    include/standard-headers/linux/virtio_net.h | 3 +++
> > > >    2 files changed, 5 insertions(+)
> > > > 
> > > > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > > > index 90502fca7c..38b3140670 100644
> > > > --- a/hw/net/virtio-net.c
> > > > +++ b/hw/net/virtio-net.c
> > > > @@ -2198,6 +2198,8 @@ static Property virtio_net_properties[] = {
> > > >                         true),
> > > >        DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOWN),
> > > >        DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
> > > > +    DEFINE_PROP_BIT64("standby", VirtIONet, host_features, VIRTIO_NET_F_STANDBY,
> > > > +                      false),
> > > >        DEFINE_PROP_END_OF_LIST(),
> > > >    };
> > > > diff --git a/include/standard-headers/linux/virtio_net.h b/include/standard-headers/linux/virtio_net.h
> > > > index e9f255ea3f..01ec09684c 100644
> > > > --- a/include/standard-headers/linux/virtio_net.h
> > > > +++ b/include/standard-headers/linux/virtio_net.h
> > > > @@ -57,6 +57,9 @@
> > > >    					 * Steering */
> > > >    #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
> > > > +#define VIRTIO_NET_F_STANDBY      62    /* Act as standby for another device
> > > > +                                         * with the same MAC.
> > > > +                                         */
> > > >    #define VIRTIO_NET_F_SPEED_DUPLEX 63	/* Device set linkspeed and duplex */
> > > >    #ifndef VIRTIO_NET_NO_LEGACY

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

