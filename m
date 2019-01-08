Return-Path: virtio-dev-return-5294-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 88E11985C18
	for <virtio-dev@lists.oasis-open.org>; Tue,  8 Jan 2019 17:25:27 +0000 (UTC)
Date: Tue, 8 Jan 2019 11:25:22 -0600
From: Venu Busireddy <venu.busireddy@oracle.com>
Message-ID: <20190108172522.GA28457@troi>
References: <1546900184-27403-1-git-send-email-venu.busireddy@oracle.com>
 <1546900184-27403-2-git-send-email-venu.busireddy@oracle.com>
 <6f5632f5-1469-7000-9b92-ef2564a63f63@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f5632f5-1469-7000-9b92-ef2564a63f63@oracle.com>
Subject: [virtio-dev] Re: [Qemu-devel] [PATCH v3 1/5] virtio_net: Add VIRTIO_NET_F_STANDBY
 feature bit.
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: si-wei.liu@oracle.com, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 2019-01-09 00:56:38 +0800, Dongli Zhang wrote:
> I am not familiar with libvirt and I would like to play with this only with qemu.
> 
> With failover, we need to hotplug the VF on destination server to VM after live
> migration. However, the VF on destination server would have different mac address.
> 
> How can we specify the mac for the new VF to hotplug via qemu, as VF is only a
> vfio pci device?

How is the VF device on the destination host any different from the VF
on the source host?

As you do on the source host, you first assign the MAC address of
00:00:00:00:00:00 to the VF. After the migration, you assign the same
MAC address as that of the virtio_net device to the VF, and hotadd the VF
device to the VM. And then, after you receive the FAILOVER_PRIMARY_CHANGED
event, set the macvtap device to down state.

Venu

> 
> I am trying to play with this with only qemu (w/o libvirt).
> 
> Thank you very much!
> 
> Dongli Zhang
> 
> On 01/08/2019 06:29 AM, Venu Busireddy wrote:
> > From: Sridhar Samudrala <sridhar.samudrala@intel.com>
> > 
> > This feature bit can be used by a hypervisor to indicate to the virtio_net
> > device that it can act as a standby for another device with the same MAC
> > address.
> > 
> > Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> > Signed-off-by: Venu Busireddy <venu.busireddy@oracle.com>
> > ---
> >  hw/net/virtio-net.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index 385b1a0..411f8fb 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -2198,6 +2198,8 @@ static Property virtio_net_properties[] = {
> >                       true),
> >      DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOWN),
> >      DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
> > +    DEFINE_PROP_BIT64("standby", VirtIONet, host_features, VIRTIO_NET_F_STANDBY,
> > +                      false),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >  
> > 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

