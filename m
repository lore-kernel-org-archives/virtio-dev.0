Return-Path: virtio-dev-return-4035-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 4D2BF581916A
	for <virtio-dev@lists.oasis-open.org>; Wed,  2 May 2018 13:30:11 -0700 (PDT)
Date: Wed, 2 May 2018 23:30:02 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180502232907-mutt-send-email-mst@kernel.org>
References: <1524848820-42258-1-git-send-email-sridhar.samudrala@intel.com>
 <1524848820-42258-3-git-send-email-sridhar.samudrala@intel.com>
 <20180428090601.GL5632@nanopsycho.orion>
 <20180502161542.GI19250@nanopsycho>
 <052e2c60-dc4c-d6a0-0159-fc1821cb4365@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <052e2c60-dc4c-d6a0-0159-fc1821cb4365@intel.com>
Subject: [virtio-dev] Re: [PATCH net-next v9 2/4] net: Introduce generic failover module
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Cc: Jiri Pirko <jiri@resnulli.us>, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com, aaron.f.brown@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, May 02, 2018 at 10:51:12AM -0700, Samudrala, Sridhar wrote:
>=20
>=20
> On 5/2/2018 9:15 AM, Jiri Pirko wrote:
> > Sat, Apr 28, 2018 at 11:06:01AM CEST, jiri@resnulli.us wrote:
> > > Fri, Apr 27, 2018 at 07:06:58PM CEST, sridhar.samudrala@intel.com wro=
te:
> > [...]
> >=20
> >=20
> > > > +
> > > > +	err =3D netdev_rx_handler_register(slave_dev, net_failover_handle=
_frame,
> > > > +					 failover_dev);
> > > > +	if (err) {
> > > > +		netdev_err(slave_dev, "can not register failover rx handler (err=
 =3D %d)\n",
> > > > +			   err);
> > > > +		goto err_handler_register;
> > > > +	}
> > > > +
> > > > +	err =3D netdev_upper_dev_link(slave_dev, failover_dev, NULL);
> > > Please use netdev_master_upper_dev_link().
> > Don't forget to fillup struct netdev_lag_upper_info - NETDEV_LAG_TX_TYP=
E_ACTIVEBACKUP
> >=20
> >=20
> > Also, please call netdev_lower_state_changed() when the active slave
> > device changes from primary->backup of backup->primary and whenever link
> > state of a slave changes
> >=20
> Sure. will look into it.=A0 Do you think this will help with the issue
> you saw with having to change mac on standy twice to get the init scripts
> working? We are now going to block changing the mac on both standby and
> failover.
>=20
> Also, i was wondering if we should set dev->flags to IFF_MASTER on failov=
er
> and IFF_SLAVE on primary and standby.

We do need a way to find things out, that's for sure.
How does userspace know it's a failover
config and find the failover device right now?

> netvsc does this.
> Does this help with the init scripts and network manager to skip slave
> devices for dhcp requests?

Try it?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

