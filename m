Return-Path: virtio-dev-return-3392-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 25EFA58180EF
	for <virtio-dev@lists.oasis-open.org>; Fri,  2 Mar 2018 13:36:12 -0800 (PST)
Date: Fri, 2 Mar 2018 23:36:10 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180302233443-mutt-send-email-mst@kernel.org>
References: <1519934923-39372-1-git-send-email-sridhar.samudrala@intel.com>
 <1519934923-39372-3-git-send-email-sridhar.samudrala@intel.com>
 <CADGSJ23tForX9HSvYpC-1wV9v_u15-mzeg8jY7nOO2gaVdjgMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADGSJ23tForX9HSvYpC-1wV9v_u15-mzeg8jY7nOO2gaVdjgMw@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v4 2/2] virtio_net: Extend virtio to use VF datapath when
 available
To: Siwei Liu <loseweigh@gmail.com>
Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, Jiri Pirko <jiri@resnulli.us>, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, Jakub Kicinski <kubakici@wp.pl>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Mar 02, 2018 at 01:11:56PM -0800, Siwei Liu wrote:
> On Thu, Mar 1, 2018 at 12:08 PM, Sridhar Samudrala
> <sridhar.samudrala@intel.com> wrote:
> > This patch enables virtio_net to switch over to a VF datapath when a VF
> > netdev is present with the same MAC address. It allows live migration
> > of a VM with a direct attached VF without the need to setup a bond/team
> > between a VF and virtio net device in the guest.
> >
> > The hypervisor needs to enable only one datapath at any time so that
> > packets don't get looped back to the VM over the other datapath. When a VF
> > is plugged, the virtio datapath link state can be marked as down. The
> > hypervisor needs to unplug the VF device from the guest on the source host
> > and reset the MAC filter of the VF to initiate failover of datapath to
> > virtio before starting the migration. After the migration is completed,
> > the destination hypervisor sets the MAC filter on the VF and plugs it back
> > to the guest to switch over to VF datapath.
> >
> > When BACKUP feature is enabled, an additional netdev(bypass netdev) is
> > created that acts as a master device and tracks the state of the 2 lower
> > netdevs. The original virtio_net netdev is marked as 'backup' netdev and a
> > passthru device with the same MAC is registered as 'active' netdev.
> >
> > This patch is based on the discussion initiated by Jesse on this thread.
> > https://marc.info/?l=linux-virtualization&m=151189725224231&w=2
> >
> > Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> > Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> > ---
> >  drivers/net/virtio_net.c | 683 ++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 682 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index bcd13fe906ca..f2860d86c952 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -30,6 +30,8 @@
> >  #include <linux/cpu.h>
> >  #include <linux/average.h>
> >  #include <linux/filter.h>
> > +#include <linux/netdevice.h>
> > +#include <linux/pci.h>
> >  #include <net/route.h>
> >  #include <net/xdp.h>
> >
> > @@ -206,6 +208,9 @@ struct virtnet_info {
> >         u32 speed;
> >
> >         unsigned long guest_offloads;
> > +
> > +       /* upper netdev created when BACKUP feature enabled */
> > +       struct net_device *bypass_netdev;
> >  };
> >
> >  struct padded_vnet_hdr {
> > @@ -2236,6 +2241,22 @@ static int virtnet_xdp(struct net_device *dev, struct netdev_bpf *xdp)
> >         }
> >  }
> >
> > +static int virtnet_get_phys_port_name(struct net_device *dev, char *buf,
> > +                                     size_t len)
> > +{
> > +       struct virtnet_info *vi = netdev_priv(dev);
> > +       int ret;
> > +
> > +       if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_BACKUP))
> > +               return -EOPNOTSUPP;
> > +
> > +       ret = snprintf(buf, len, "_bkup");
> > +       if (ret >= len)
> > +               return -EOPNOTSUPP;
> > +
> > +       return 0;
> > +}
> > +
> 
> What if the systemd/udevd is not new enough to enforce the
> n<phys_port_name> naming? Would virtio_bypass get a different name
> than the original virtio_net?

You mean people using ethX names? Any hardware config change breaks
these, I don't think that can be helped.

> Should we detect this earlier and fall
> back to legacy mode without creating the bypass netdev and ensalving
> the VF?

I don't think we can do this with existing kernel/userspace APIs.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

