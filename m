Return-Path: virtio-dev-return-7103-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0BA1D986076
	for <virtio-dev@lists.oasis-open.org>; Fri, 17 Apr 2020 08:25:28 +0000 (UTC)
Date: Fri, 17 Apr 2020 04:25:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200417041738-mutt-send-email-mst@kernel.org>
References: <BN6PR1801MB206742E4081B5E9D957A4FF1C5D90@BN6PR1801MB2067.namprd18.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <BN6PR1801MB206742E4081B5E9D957A4FF1C5D90@BN6PR1801MB2067.namprd18.prod.outlook.com>
Subject: [virtio-dev] Re: [Virtio-networking] Doorbell mapping of vDPA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Vitaly Mireyno <vmireyno@marvell.com>
Cc: Jason Wang <jasowang@redhat.com>, "virtio-networking@redhat.com" <virtio-networking@redhat.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Ariel Elior <aelior@marvell.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Apr 17, 2020 at 07:56:17AM +0000, Vitaly Mireyno wrote:
>=20
> >-----Original Message-----
> >From: Michael S. Tsirkin <mst@redhat.com>
> >Sent: Friday, 17 April, 2020 9:38
> >To: Jason Wang <jasowang@redhat.com>
> >Cc: Vitaly Mireyno <vmireyno@marvell.com>; virtio-networking@redhat.com;=
 Virtio-Dev <virtio-
> >dev@lists.oasis-open.org>; Ariel Elior <aelior@marvell.com>
> >Subject: Re: [Virtio-networking] Doorbell mapping of vDPA
> >
> >----------------------------------------------------------------------
> >On Fri, Apr 17, 2020 at 12:19:43PM +0800, Jason Wang wrote:
> >>
> >> On 2020/4/15 =E4=B8=8A=E5=8D=8812:20, Michael S. Tsirkin wrote:
> >> > On Tue, Apr 14, 2020 at 01:12:51PM +0000, Vitaly Mireyno wrote:
> >> > > > -----Original Message-----
> >> > > > From: virtio-networking-bounces@redhat.com
> >> > > > <virtio-networking-bounces@redhat.com> On Behalf Of Jason Wang
> >> > > > Sent: Tuesday, 7 April, 2020 10:56
> >> > > > To: virtio-networking@redhat.com; Virtio-Dev
> >> > > > <virtio-dev@lists.oasis-open.org>
> >> > > > Cc: Michael S. Tsirkin <mst@redhat.com>
> >> > > > Subject: [Virtio-networking] Doorbell mapping of vDPA
> >> > > >
> >> > > > ----------------------------------------------------------------
> >> > > > ------
> >> > > > Hi all:
> >> > > >
> >> > > > To get native performance of VF, we need to map doorbell to
> >> > > > guest to avoid unnecessary vmexit. In order to do this, we will
> >> > > > launch qemu with page-per-vq=3Don. This means the each doorbell
> >> > > > register should be located at the beginning of 4K page and does
> >> > > > not share the page with other registers. Then vDPA framework can
> >> > > > safely map it into the guest physical address (GPA) range
> >> > > > defined by qemu. It could be either
> >> > > >
> >> > > > 1) a single doorbell register that is used by all virtqueues
> >> > > >
> >> > > > or
> >> > > >
> >> > > > 2) several different per-vq doorbell registers
> >> > > >
> >> > > > If you decide to implement a virtio-pci register layout, need to
> >> > > > make sure for notification structure
> >> > > > (4.1.4.4 of virtio spec):
> >> > > >
> >> > > > For each virtqueue, the result
> >> > > > ofcap.offset+queue_notify_off*notify_off_multiplier is PAGE_SIZE
> >> > > > (e.g
> >> > > > 4K) alignment, and the doorbeel does not share the page with oth=
er registers.
> >> > > >
> >> > > > And it would be better if queue_notify_off,
> >> > > > notify_off_multiplier can be changed via firmware for extra flex=
ibility.
> >> > > >
> >> > > In some cases, these conditions could not be met for a virtio-net =
hardware device over PCI
> >transport.
> >> > > queue_notify and notify_off_multiplier could not always be fully c=
ontrolled by the firmware.
> >There could be hardware limitations on flexibility degree of these param=
eters.
> >> > > Specifically, the limitations I'm thinking of are:
> >> > >   * queue_notify_off>0 and notify_off_multiplier>0
> >> > >   * Several doorbell registers of several virtqueues share the sam=
e page (but don't share the page
> >with other registers).
> >> > >
> >> > > Can this be supported in vDPA with direct doorbell mapping?
> >> > >
> >> > > Thanks
> >> > There's value in being able to intercept some vqs in software while
> >> > the rest of vqs are handled in hardware.
> >> > E.g. that's the case for e.g. the control vq.
> >>
> >>
> >> Good point, so in this case, the doorbell of control vq must
> >> exclusively own a page.
> >>
> >> Or to facilitate the hardware design, we may introduce dedicated
> >> notification area for control vq?
> >>
> >> Thanks
> >
> >Well all this would need spec changes. I'm guessing at this point it's e=
asier to just have hardware send
> >commands to qemu through some channel before using them. With SRIOV that=
 would need to be
> >either the PF, or a memory bar of the VF.
> >
>=20
> Since the control vq will be handled in the SW, I don=E2=80=99t see a pro=
blem for the control vq to own a page (i.e. queue_notify_off of the control=
 vq will be such that the doorbell address will be at the beginning of a ne=
w page)
>=20

Not sure what you mean here. queue_notify_off is shared between all VQs
isn't it? what did I miss? Care giving an example?

Fundamentally low PAGE_MASK bits are not virtualized by hardware.
If we want ability for hypervisor to intercept some but not
all kicks (btw can we pls get back to spec wording Doorbell->kick?)
then devices should leave these bits alone.

If hardware simply ignores the address, then all is well and
hypervisor can map things where-ever it wants.
So as things stand, it does not look like spec needs to be extended.

The problem is with the proposed "flexible driver notification
structure" which removes this flexibility from hypervisor since VQ# is
no longer passed at runtime and so has to be deduced from the address.
I guess that proposal needs to be changed to add flexibility back
in some other way. How about making offset programmable?
I'm not sure who will program it since hypervisor
might have a different page size from guest.
Ideas?

> >
> >>
> >> >
> >> >
> >> > > > Please check and make sure your hardware have such ability and
> >> > > > feel free to ask if you have questions (offline if necessary).
> >> > > >
> >> > > > Thanks
> >> > > >
> >> > > >
> >> > > >
> >> > > >
> >> > > >
> >> > > > _______________________________________________
> >> > > > Virtio-networking mailing list
> >> > > > Virtio-networking@redhat.com
> >> > > > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__www.redha=
t.
> >> > > > com_mailman_listinfo_virtio-
> >> > > > 2Dnetworking&d=3DDwIGaQ&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DlDHJ2FW52=
oJ3lqq
> >> > > > sArgFRdcevq01tbLQAw
> >> > > > 4A_NO7xgI&m=3DpddgVCz-
> >> > > > orGTuUXATJ4Dmi7vAXatG9w47AmULNC3V9A&s=3D5mfYWbLCjcZO8FcwDqgAc5bj=
E-
> >> > > > H-
> >> > > > 4p5TBkRZqP3uMsQ&e=3D
>=20


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

