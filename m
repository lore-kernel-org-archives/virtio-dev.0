Return-Path: virtio-dev-return-3927-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id A92985818F9A
	for <virtio-dev@lists.oasis-open.org>; Fri, 20 Apr 2018 09:03:46 -0700 (PDT)
Date: Fri, 20 Apr 2018 19:03:34 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180420185937-mutt-send-email-mst@kernel.org>
References: <1524188524-28411-1-git-send-email-sridhar.samudrala@intel.com>
 <1524188524-28411-3-git-send-email-sridhar.samudrala@intel.com>
 <20180420045657-mutt-send-email-mst@kernel.org>
 <d1bf0771-751b-85bc-4890-8232283131a2@intel.com>
 <20180420183021-mutt-send-email-mst@kernel.org>
 <CAKgT0UeQTx7zJPK3K3eM9xxHfVyHXwJ-G_b8eqGn0bWAyt9aAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UeQTx7zJPK3K3eM9xxHfVyHXwJ-G_b8eqGn0bWAyt9aAg@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH v7 net-next 2/4] net: Introduce generic
 failover module
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Duyck, Alexander H" <alexander.h.duyck@intel.com>, Jakub Kicinski <kubakici@wp.pl>, Jason Wang <jasowang@redhat.com>, Siwei Liu <loseweigh@gmail.com>, Jiri Pirko <jiri@resnulli.us>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Apr 20, 2018 at 08:56:57AM -0700, Alexander Duyck wrote:
> On Fri, Apr 20, 2018 at 8:34 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Fri, Apr 20, 2018 at 08:21:00AM -0700, Samudrala, Sridhar wrote:
> >> > > + finfo = netdev_priv(failover_dev);
> >> > > +
> >> > > + primary_dev = rtnl_dereference(finfo->primary_dev);
> >> > > + standby_dev = rtnl_dereference(finfo->standby_dev);
> >> > > +
> >> > > + if (slave_dev != primary_dev && slave_dev != standby_dev)
> >> > > +         goto done;
> >> > > +
> >> > > + if ((primary_dev && failover_xmit_ready(primary_dev)) ||
> >> > > +     (standby_dev && failover_xmit_ready(standby_dev))) {
> >> > > +         netif_carrier_on(failover_dev);
> >> > > +         netif_tx_wake_all_queues(failover_dev);
> >> > > + } else {
> >> > > +         netif_carrier_off(failover_dev);
> >> > > +         netif_tx_stop_all_queues(failover_dev);
> >> > And I think it's a good idea to get stats from device here too.
> >>
> >> Not sure why we need to get stats from lower devs here?
> >
> > link down is often indication of a hardware problem.
> > lower dev might stop responding down the road.
> >
> >> > > +static const struct net_device_ops failover_dev_ops = {
> >> > > + .ndo_open               = failover_open,
> >> > > + .ndo_stop               = failover_close,
> >> > > + .ndo_start_xmit         = failover_start_xmit,
> >> > > + .ndo_select_queue       = failover_select_queue,
> >> > > + .ndo_get_stats64        = failover_get_stats,
> >> > > + .ndo_change_mtu         = failover_change_mtu,
> >> > > + .ndo_set_rx_mode        = failover_set_rx_mode,
> >> > > + .ndo_validate_addr      = eth_validate_addr,
> >> > > + .ndo_features_check     = passthru_features_check,
> >> > xdp support?
> >>
> >> I think it should be possible to add it be calling the lower dev ndo_xdp routines
> >> with proper checks. can we add this later?
> >
> > I'd be concerned that if you don't xdp userspace will keep poking
> > at lower devs. Then it will stop working if you add this later.
> 
> The failover device is better off not providing in-driver XDP since
> there are already skbs allocated by the time that we see the packet
> here anyway. As such generic XDP is the preferred way to handle this
> since it will work regardless of what lower devices are present.
>
> The only advantage of having XDP down at the virtio or VF level would
> be that it performs better, but at the cost of complexity since we
> would need to rebind the eBPF program any time a device is hotplugged
> out and then back in. For now the current approach is in keeping with
> how bonding and other similar drivers are currently handling this.
> 
> Thanks.
> 
> - Alex

OK fair enough.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

