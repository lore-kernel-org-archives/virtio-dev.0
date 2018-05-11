Return-Path: virtio-dev-return-4068-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 3AAAF1CB80EF
	for <virtio-dev@lists.oasis-open.org>; Fri, 11 May 2018 10:16:11 -0700 (PDT)
Date: Fri, 11 May 2018 20:15:58 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180511201450-mutt-send-email-mst@kernel.org>
References: <1525731046-10989-1-git-send-email-sridhar.samudrala@intel.com>
 <1525731046-10989-3-git-send-email-sridhar.samudrala@intel.com>
 <20180507165306.541bd1f2@xeon-e3>
 <e8454b29-d66b-9e20-a887-cb312a63847e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e8454b29-d66b-9e20-a887-cb312a63847e@intel.com>
Subject: [virtio-dev] Re: [PATCH net-next v10 2/4] net: Introduce generic failover module
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com, jiri@resnulli.us, aaron.f.brown@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, May 07, 2018 at 05:24:27PM -0700, Samudrala, Sridhar wrote:
>=20
>=20
> On 5/7/2018 4:53 PM, Stephen Hemminger wrote:
> > On Mon,  7 May 2018 15:10:44 -0700
> > Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:
> >=20
> > > +static struct net_device *net_failover_get_bymac(u8 *mac,
> > > +						 struct net_failover_ops **ops)
> > > +{
> > > +	struct net_device *failover_dev;
> > > +	struct net_failover *failover;
> > > +
> > > +	spin_lock(&net_failover_lock);
> > > +	list_for_each_entry(failover, &net_failover_list, list) {
> > > +		failover_dev =3D rtnl_dereference(failover->failover_dev);
> > > +		if (ether_addr_equal(failover_dev->perm_addr, mac)) {
> > > +			*ops =3D rtnl_dereference(failover->ops);
> > > +			spin_unlock(&net_failover_lock);
> > > +			return failover_dev;
> > > +		}
> > > +	}
> > > +	spin_unlock(&net_failover_lock);
> > > +	return NULL;
> > > +}
> > This is broken if non-ethernet devices such as Infiniband are present.
>=20
> There is check to make sure that a slave and failover devices are of the =
same type in
> net_failover_slave_register()
>=20
> 	failover_dev =3D net_failover_get_bymac(slave_dev->perm_addr, &nfo_ops);
> =A0=A0=A0=A0=A0=A0=A0 if (!failover_dev)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto done;
>=20
> =A0=A0=A0=A0=A0=A0=A0 if (failover_dev->type !=3D slave_dev->type)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto done;
>=20
> Do you think this is not good enough? I had an explicit check for ARPHRD_=
ETHER in
> earlier patchsets, but removed it based on Jiri's comment.

Right but how is ether_addr_equal supposed to work if types are
identical but not ethernet?

This can also benefit from a comment referring to the check in
net_failover_slave_register.

--=20
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

