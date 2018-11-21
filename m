Return-Path: virtio-dev-return-5009-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E66B2985CA6
	for <virtio-dev@lists.oasis-open.org>; Wed, 21 Nov 2018 18:41:27 +0000 (UTC)
Date: Wed, 21 Nov 2018 13:41:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181121124246-mutt-send-email-mst@kernel.org>
References: <20180920220951-mutt-send-email-mst@kernel.org>
 <CADGSJ23GRrt25k1G9wD3JhA6en4MuXLE9WA24Ep8PLgkyk_4=A@mail.gmail.com>
 <20180927121739-mutt-send-email-mst@kernel.org>
 <CADGSJ22JC9asjQ3nVV5e-ajxB-pggJ6ToMGqG072Q5TvFVCKBQ@mail.gmail.com>
 <20181002083928-mutt-send-email-mst@kernel.org>
 <CADGSJ23NaaPXrgoL1-ySs=SWytE65SORatOFMSapzFsKZUH4yA@mail.gmail.com>
 <20181005101419-mutt-send-email-mst@kernel.org>
 <CADGSJ22QYRX3GBjDqGgauwiHi6p4FpbUwpromD0=nY+w2FDm=Q@mail.gmail.com>
 <20181018233115-mutt-send-email-mst@kernel.org>
 <CAKPgXcH4mokJd7MeTUNjoGzo6Lbyx72cOQPLfKccQLwVHSMArg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAKPgXcH4mokJd7MeTUNjoGzo6Lbyx72cOQPLfKccQLwVHSMArg@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH v4] content: Introduce VIRTIO_NET_F_STANDBY
 feature
To: Sameeh Jubran <sameeh@daynix.com>
Cc: Siwei Liu <loseweigh@gmail.com>, venu.busireddy@oracle.com, cohuck@redhat.com, sridhar.samudrala@intel.com, virtio-dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Great to see you making progress on this!
Some comments below:

On Wed, Nov 21, 2018 at 05:39:38PM +0200, Sameeh Jubran wrote:
> I have created a setup which has two hosts (host A and host B) with X710 =
10G
> cards=A0connected back to back. On one host (I'll refer to this host as h=
ost A) I
> have configured a bridge with the PF interface as well as vitio-net's int=
erface
> (standby) both attached to it.=20

...

> The command line I used:
>=20
> /root/qemu/x86_64-softmmu/qemu-system-x86_64 \
> -netdev tap,id=3Dhostnet0,script=3Dworld_bridge_standalone.sh,downscript=
=3Dno,ifname=3D
> cc17 \
> -device e1000,netdev=3Dhostnet0,mac=3D56:cc:c1:01:cc:21,id=3Dcc17 \

What's e1000 doing here?
Can this be reason you can not talk to host?

> -netdev tap,vhost=3Don,id=3Dhostnet1,script=3Dtest_bridge_standalone.sh,d=
ownscript=3D
> no,ifname=3Dcc1_72,queues=3D4 \
> -device virtio-net,host_mtu=3D1500,netdev=3Dhostnet1,mac=3D8a:f7:20:29:3b=
:cb,id=3D
> cc1_72,vectors=3D10,mq=3Don,primary=3Dcc1_71 \
> -device vfio-pci,host=3D65:02.1,id=3Dcc1_71,standby=3Dcc1_72 \
> -enable-kvm \
> -name netkvm \
> -m 3000M \
> -drive file=3D/dev/shm/fedora_29.qcow2,if=3Dide,id=3Ddrivex \
> -smp 4 \
> -vga qxl \
> -spice port=3D6110,disable-ticketing \
> -device virtio-serial-pci,id=3Dvirtio-serial0,max_ports=3D16,bus=3Dpci.0,=
addr=3D0x7 \
> -chardev spicevmc,name=3Dvdagent,id=3Dvdagent \
> -device virtserialport,nr=3D1,bus=3Dvirtio-serial0.0,chardev=3Dvdagent,na=
me=3D
> com.redhat.spice.0 \
> -chardev socket,path=3D/tmp/qga.sock,server,nowait,id=3Dqga0 \
> -device virtio-serial \
> -device virtserialport,chardev=3Dqga0,name=3Dorg.qemu.guest_agent.0 \
> -monitor stdio


...

> Since I couldn't ping from VM to host B, I did an iperf test between the =
VM and
> host A with the feature enabled and during the test I have unplugged the =
sriov
> device, the device was unplugged successfully and no drops where observed=
 as
> you can see in the results below:
>=20
> [root@dhcp156-44 ~]# ifconfig

Well I suspect this won't tell you anything, this shows packet drops at
the hardware level. When e.g. link is down linux won't send any packets
out. The simplest test is to monitor latency and throughput and see that
while it is lower for the duration of migration, there are no huge
spikes around the switch.

--=20
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

