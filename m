Return-Path: virtio-dev-return-4544-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 41A2E1CB807B
	for <virtio-dev@lists.oasis-open.org>; Tue, 26 Jun 2018 09:03:32 -0700 (PDT)
Date: Tue, 26 Jun 2018 18:03:16 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180626180316.3723422f.cohuck@redhat.com>
In-Reply-To: <20180626183706-mutt-send-email-mst@kernel.org>
References: <CADGSJ23SBEFJCD50K-F-Gt86Q1-i_6iHTmSSjdXDzNnnpWZ_oQ@mail.gmail.com>
	<CADGSJ22nLcz_XaJNzUUdpjQaJY8b5wZs=ohm=B7c2qf2K7_yGA@mail.gmail.com>
	<20180623002628-mutt-send-email-mst@kernel.org>
	<CADGSJ20td7b6He6S1PBSJjCq=bNvgqMGbOjiho2eeQm2pgpK3g@mail.gmail.com>
	<20180623012406-mutt-send-email-mst@kernel.org>
	<CADGSJ211pWKYnuuzcgUqJZiHU+=7H3oQSpp1TnE=+EBjkdmCSQ@mail.gmail.com>
	<CADGSJ22DX8=rNPY+gNS_q=LCYLR5ieoE7oD8p4+8AnpzQsWSCg@mail.gmail.com>
	<da144f8f-65cd-45d9-3c81-6c8ca1fb25fe@intel.com>
	<20180626044650-mutt-send-email-mst@kernel.org>
	<20180626171732.5038f53f.cohuck@redhat.com>
	<20180626183706-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] Re: [Qemu-devel] [PATCH] qemu: Introduce
 VIRTIO_NET_F_STANDBY feature bit to virtio_net
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Siwei Liu <loseweigh@gmail.com>, Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, aaron.f.brown@intel.com, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kubakici@wp.pl>, Netdev <netdev@vger.kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, Joao Martins <joao.m.martins@oracle.com>, Venu Busireddy <venu.busireddy@oracle.com>, vijay.balakrishna@oracle.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 26 Jun 2018 18:38:51 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Jun 26, 2018 at 05:17:32PM +0200, Cornelia Huck wrote:
> > On Tue, 26 Jun 2018 04:50:25 +0300
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >  =20
> > > On Mon, Jun 25, 2018 at 10:54:09AM -0700, Samudrala, Sridhar wrote: =
=20
> > > > > > > > Might not neccessarily be something wrong, but it's very li=
mited to
> > > > > > > > prohibit the MAC of VF from changing when enslaved by failo=
ver.   =20
> > > > > > > You mean guest changing MAC? I'm not sure why we prohibit tha=
t.   =20
> > > > > > I think Sridhar and Jiri might be better person to answer it. My
> > > > > > impression was that sync'ing the MAC address change between all=
 3
> > > > > > devices is challenging, as the failover driver uses MAC address=
 to
> > > > > > match net_device internally.   =20
> > > >=20
> > > > Yes. The MAC address is assigned by the hypervisor and it needs to =
manage the movement
> > > > of the MAC between the PF and VF.=C2=A0 Allowing the guest to chang=
e the MAC will require
> > > > synchronization between the hypervisor and the PF/VF drivers. Most =
of the VF drivers
> > > > don't allow changing guest MAC unless it is a trusted VF.   =20
> > >=20
> > > OK but it's a policy thing. Maybe it's a trusted VF. Who knows?
> > > For example I can see host just
> > > failing VIRTIO_NET_CTRL_MAC_ADDR_SET if it wants to block it.
> > > I'm not sure why VIRTIO_NET_F_STANDBY has to block it in the guest.
> > >  =20
> >=20
> > So, what I get from this is that QEMU needs to be able to control all
> > of standby, uuid, and mac to accommodate the different setups
> > (respectively have libvirt/management software set it up). Is the host
> > able to find out respectively define whether a VF is trusted? =20
>=20
> You do it with ip link I think but QEMU doesn't normally do this,
> it relies on libvirt to poke at host kernel and supply the info.
>=20

Ok, that makes me conclude that we definitely need to involve the
libvirt folks before we proceed further with defining QEMU interfaces.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

