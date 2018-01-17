Return-Path: virtio-dev-return-2991-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 243D65818039
	for <virtio-dev@lists.oasis-open.org>; Wed, 17 Jan 2018 11:57:44 -0800 (PST)
Date: Wed, 17 Jan 2018 21:57:37 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180117213527-mutt-send-email-mst@kernel.org>
References: <1515736720-39368-1-git-send-email-sridhar.samudrala@intel.com>
 <1515736720-39368-2-git-send-email-sridhar.samudrala@intel.com>
 <CAKgT0Uc8bRoAsXYSr7k27gf5+vh7rF2Dd_kWNB1d38tpZAeRGg@mail.gmail.com>
 <20180117203757-mutt-send-email-mst@kernel.org>
 <058068e5-febd-92c8-e5a9-faf262b82335@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <058068e5-febd-92c8-e5a9-faf262b82335@intel.com>
Subject: Re: [virtio-dev] [RFC PATCH net-next v2 1/2] virtio_net: Introduce
 VIRTIO_NET_F_BACKUP feature bit
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Duyck, Alexander H" <alexander.h.duyck@intel.com>, Jakub Kicinski <kubakici@wp.pl>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 17, 2018 at 11:25:41AM -0800, Samudrala, Sridhar wrote:
>=20
>=20
> On 1/17/2018 11:02 AM, Michael S. Tsirkin wrote:
> > On Wed, Jan 17, 2018 at 10:15:52AM -0800, Alexander Duyck wrote:
> > > On Thu, Jan 11, 2018 at 9:58 PM, Sridhar Samudrala
> > > <sridhar.samudrala@intel.com> wrote:
> > > > This feature bit can be used by hypervisor to indicate virtio_net d=
evice to
> > > > act as a backup for another device with the same MAC address.
> > > >=20
> > > > Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> > > > ---
> > > >   drivers/net/virtio_net.c        | 2 +-
> > > >   include/uapi/linux/virtio_net.h | 3 +++
> > > >   2 files changed, 4 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 12dfc5fee58e..f149a160a8c5 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -2829,7 +2829,7 @@ static struct virtio_device_id id_table[] =3D=
 {
> > > >          VIRTIO_NET_F_GUEST_ANNOUNCE, VIRTIO_NET_F_MQ, \
> > > >          VIRTIO_NET_F_CTRL_MAC_ADDR, \
> > > >          VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
> > > > -       VIRTIO_NET_F_SPEED_DUPLEX
> > > > +       VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_BACKUP
> > > >=20
> > > >   static unsigned int features[] =3D {
> > > >          VIRTNET_FEATURES,
> > > > diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/v=
irtio_net.h
> > > > index 5de6ed37695b..c7c35fd1a5ed 100644
> > > > --- a/include/uapi/linux/virtio_net.h
> > > > +++ b/include/uapi/linux/virtio_net.h
> > > > @@ -57,6 +57,9 @@
> > > >                                           * Steering */
> > > >   #define VIRTIO_NET_F_CTRL_MAC_ADDR 23  /* Set MAC address */
> > > >=20
> > > > +#define VIRTIO_NET_F_BACKUP      62    /* Act as backup for anothe=
r device
> > > > +                                        * with the same MAC.
> > > > +                                        */
> > > >   #define VIRTIO_NET_F_SPEED_DUPLEX 63   /* Device set linkspeed an=
d duplex */
> > > >=20
> > > >   #ifndef VIRTIO_NET_NO_LEGACY
> > > I'm not a huge fan of the name "backup" since that implies that the
> > > Virtio interface is only used if the VF is not present, and there are
> > > multiple instances such as dealing with east/west or
> > > broadcast/multicast traffic where it may be desirable to use the
> > > para-virtual interface rather then deal with PCI overhead/bottleneck
> > > to send the packet.
> > Right now hypervisors mostly expect that yes, only one at a time is
> > used.  E.g. if you try to do multicast sending packets on both VF and
> > virtio then you will end up with two copies of each packet.
>=20
> I think we want to use only 1 interface to=A0 send out any packet. In cas=
e of
> broadcast/multicasts it would be an optimization to send them via virtio =
and
> this patch series adds that optimization.

Right that's what I think we should rather avoid for now.

It's *not* an optimization if there's a single VM on this host,
or if a specific multicast group does not have any VMs on same
host.

I'd rather we just sent everything out on the PT if that's
there. The reason we have virtio in the picture is just so
we can migrate without downtime.


> In the receive path,=A0 the broadcasts should only go the PF and reach th=
e VM
> via vitio so that the VM doesn't see duplicate broadcasts.
>=20
>=20
> >=20
> > To me the east/west scenario looks like you want something
> > more similar to a bridge on top of the virtio/PT pair.
> >=20
> > So I suspect that use-case will need a separate configuration bit,
> > and possibly that's when you will want something more powerful
> > such as a full bridge.
>=20
> east-west optimization of unicasts would be a harder problem to solve as
> somehow the hypervisor needs to indicate the VM about the local dest. macs

Using a bridge with a dedicated device for east/west would let
bridge use standard learning techniques for that perhaps?


> >=20
> >=20
> > > What if instead of BACKUP we used the name SIDE_CHANNEL? Basically it
> > > is a bit of double entendre as we are using the physical MAC address
> > > to provide configuration information, and then in addition this
> > > interface acts as a secondary channel for passing frames to and from
> > > the guest rather than just using the VF.
> > >=20
> > > Just a thought.
> > >=20
> > > Thanks.
> > >=20
> > > - Alex
> > I just feel that's a very generic name, not conveying enough information
> > about how they hypervisor expects the pair of devices to be used.
> >=20

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

