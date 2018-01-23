Return-Path: virtio-dev-return-3026-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id CD55A58191EF
	for <virtio-dev@lists.oasis-open.org>; Mon, 22 Jan 2018 18:04:49 -0800 (PST)
Date: Tue, 23 Jan 2018 04:04:35 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180123035619-mutt-send-email-mst@kernel.org>
References: <1515736720-39368-2-git-send-email-sridhar.samudrala@intel.com>
 <CAKgT0Uc8bRoAsXYSr7k27gf5+vh7rF2Dd_kWNB1d38tpZAeRGg@mail.gmail.com>
 <20180117203757-mutt-send-email-mst@kernel.org>
 <058068e5-febd-92c8-e5a9-faf262b82335@intel.com>
 <20180117213527-mutt-send-email-mst@kernel.org>
 <CAKgT0UeyNvVQc11KXc3updJfa9p7a9NcfRC=gP6=ktkjrSkOag@mail.gmail.com>
 <20180122231713-mutt-send-email-mst@kernel.org>
 <7edf772b-627c-6121-3332-479caed524da@intel.com>
 <20180123020332-mutt-send-email-mst@kernel.org>
 <be3864b4-f108-6a7d-8628-204d4d4ae278@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <be3864b4-f108-6a7d-8628-204d4d4ae278@intel.com>
Subject: Re: [virtio-dev] [RFC PATCH net-next v2 1/2] virtio_net: Introduce
 VIRTIO_NET_F_BACKUP feature bit
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Duyck, Alexander H" <alexander.h.duyck@intel.com>, Jakub Kicinski <kubakici@wp.pl>, achiad shochat <achiad.mellanox@gmail.com>, Achiad Shochat <achiad@mellanox.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jan 22, 2018 at 05:34:37PM -0800, Samudrala, Sridhar wrote:
> On 1/22/2018 4:05 PM, Michael S. Tsirkin wrote:
> > On Mon, Jan 22, 2018 at 03:27:40PM -0800, Samudrala, Sridhar wrote:
> > > > > You could probably
> > > > > even handle the Tx queue selection via a simple eBPF program and =
map
> > > > > since the input for whatever is used to select Tx should be pretty
> > > > > simple, destination MAC, source NUMA node, etc, and the data-set
> > > > > shouldn't be too large.
> > > > That sounds interesting. A separate device might make this kind of =
setup
> > > > a bit easier.  Sridhar, did you look into creating a separate devic=
e for
> > > > the virtual bond device at all?  It does not have to be in a separa=
te
> > > > module, that kind of refactoring can come later, but once we commit=
 to
> > > > using the same single device as virtio, we can't change that.
> > > No. I haven't looked into creating a separate device. If we are going=
 to
> > > create a new
> > > device, i guess it has to be of a new device type with its own driver.
> > Well not necessarily - just a separate netdev ops.
> > Kind of like e.g. vlans share a driver with the main driver.
>=20
> Not sure what you meant by vlans sharing a driver with the main driver.
> IIUC, vlans are supported via 802.1q driver and=A0 creates a netdev of ty=
pe
> 'vlan'
> with vlan_netdev_ops

But nothing prevents a single module from registering
multiple ops.


> >=20
> > > As we are using virtio_net to control and manage the VF data path, it=
 is not
> > > clear to me
> > > what is the advantage of creating a new device rather than extending
> > > virtio_net to manage
> > > the VF datapath via transparent bond mechanism.
> > >=20
> > > Thanks
> > > Sridhar
> > So that XDP redirect actions can differentiate between virtio, PT
> > device and the bond. Without it there's no way to redirect
> > to virtio specifically.
> I guess this usecase is for a guest admin to add bpf programs to VF netdev
> and
> redirect frames to virtio.

No - this doesn't make much sense IMHO.  The usecase would be VM
bridging where we process packets incoming on one virtio interface, and
transmit them on another one. It was pointed out using a separate master
netdev and making both virtio and PT its slaves would allow redirect
switch to force virtio, without it it won't be possible to force
redirect to virtio.

How important that use-case is, I am not sure.

>=A0 How does bond enable this feature?
>=20
>=20
> Thanks
> Sridhar

As it's a userspace configuration, I guess for starters we
can punt this to userspace, too.

--=20
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

