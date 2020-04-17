Return-Path: virtio-dev-return-7110-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 18DEC986077
	for <virtio-dev@lists.oasis-open.org>; Fri, 17 Apr 2020 09:34:24 +0000 (UTC)
Date: Fri, 17 Apr 2020 05:34:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200417053121-mutt-send-email-mst@kernel.org>
References: <BN6PR1801MB2067FCCE45316C25E5EB82F7C5DA0@BN6PR1801MB2067.namprd18.prod.outlook.com>
 <20200414121724-mutt-send-email-mst@kernel.org>
 <6cd6b9aa-1ee8-d523-aee3-4765dc52202e@redhat.com>
 <20200417023552-mutt-send-email-mst@kernel.org>
 <cbbd4acc-a11f-59af-04b8-896998eda403@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cbbd4acc-a11f-59af-04b8-896998eda403@redhat.com>
Subject: [virtio-dev] Re: [Virtio-networking] Doorbell mapping of vDPA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Jason Wang <jasowang@redhat.com>
Cc: Vitaly Mireyno <vmireyno@marvell.com>, "virtio-networking@redhat.com" <virtio-networking@redhat.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Ariel Elior <aelior@marvell.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Apr 17, 2020 at 05:29:00PM +0800, Jason Wang wrote:
>=20
> On 2020/4/17 =E4=B8=8B=E5=8D=882:37, Michael S. Tsirkin wrote:
> > On Fri, Apr 17, 2020 at 12:19:43PM +0800, Jason Wang wrote:
> > > On 2020/4/15 =E4=B8=8A=E5=8D=8812:20, Michael S. Tsirkin wrote:
> > > > On Tue, Apr 14, 2020 at 01:12:51PM +0000, Vitaly Mireyno wrote:
> > > > > > -----Original Message-----
> > > > > > From: virtio-networking-bounces@redhat.com <virtio-networking-b=
ounces@redhat.com> On Behalf
> > > > > > Of Jason Wang
> > > > > > Sent: Tuesday, 7 April, 2020 10:56
> > > > > > To: virtio-networking@redhat.com; Virtio-Dev <virtio-dev@lists.=
oasis-open.org>
> > > > > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > > > > Subject: [Virtio-networking] Doorbell mapping of vDPA
> > > > > >=20
> > > > > > ---------------------------------------------------------------=
-------
> > > > > > Hi all:
> > > > > >=20
> > > > > > To get native performance of VF, we need to map doorbell to gue=
st to avoid unnecessary vmexit. In
> > > > > > order to do this, we will launch qemu with page-per-vq=3Don. Th=
is means the each doorbell register
> > > > > > should be located at the beginning of 4K page and does not shar=
e the page with other registers. Then
> > > > > > vDPA framework can safely map it into the guest physical addres=
s (GPA) range defined by qemu. It
> > > > > > could be either
> > > > > >=20
> > > > > > 1) a single doorbell register that is used by all virtqueues
> > > > > >=20
> > > > > > or
> > > > > >=20
> > > > > > 2) several different per-vq doorbell registers
> > > > > >=20
> > > > > > If you decide to implement a virtio-pci register layout, need t=
o make sure for notification structure
> > > > > > (4.1.4.4 of virtio spec):
> > > > > >=20
> > > > > > For each virtqueue, the result
> > > > > > ofcap.offset+queue_notify_off*notify_off_multiplier is PAGE_SIZ=
E (e.g
> > > > > > 4K) alignment, and the doorbeel does not share the page with ot=
her registers.
> > > > > >=20
> > > > > > And it would be better if queue_notify_off, notify_off_multipli=
er can be changed via firmware for
> > > > > > extra flexibility.
> > > > > >=20
> > > > > In some cases, these conditions could not be met for a virtio-net=
 hardware device over PCI transport.
> > > > > queue_notify and notify_off_multiplier could not always be fully =
controlled by the firmware. There could be hardware limitations on flexibil=
ity degree of these parameters.
> > > > > Specifically, the limitations I'm thinking of are:
> > > > >    * queue_notify_off>0 and notify_off_multiplier>0
> > > > >    * Several doorbell registers of several virtqueues share the s=
ame page (but don't share the page with other registers).
> > > > >=20
> > > > > Can this be supported in vDPA with direct doorbell mapping?
> > > > >=20
> > > > > Thanks
> > > > There's value in being able to intercept some vqs in software
> > > > while the rest of vqs are handled in hardware.
> > > > E.g. that's the case for e.g. the control vq.
> > >=20
> > > Good point, so in this case, the doorbell of control vq must exclusiv=
ely own
> > > a page.
> > >=20
> > > Or to facilitate the hardware design, we may introduce dedicated
> > > notification area for control vq?
> > >=20
> > > Thanks
> > Well all this would need spec changes.
>=20
>=20
> Yes.
>=20
>=20
> > I'm guessing at this
> > point it's easier to just have hardware send commands to
> > qemu through some channel before using them.
>=20
>=20
> Yes, the plan is to let hardware report the location (offset) of the
> doorbell registers.
>=20
>=20
> >   With SRIOV that would need
> > to be either the PF, or a memory bar of the VF.
>=20
>=20
> So I think what we want is:
>=20
> - map doorbells for non control vqs
> - intercept the control vq doorbell
>=20
> In order to do this, hardware need to make sure that the doorbell of cont=
rol
> vq registers does not share page with any other doorbells.
>=20
> Then qemu may provide a suitable queue_notify_off for control vq which ma=
ke
> sure it can be intercepted independently.
>=20
> Thanks

Right. So this is something we can consider adding to the spec:
classification of VQs as data path/control, and then
a recommendation to separate at least control from data.



>=20
> >=20
> >=20
> > > >=20
> > > > > > Please check and make sure your hardware have such ability and =
feel free to ask if you have questions
> > > > > > (offline if necessary).
> > > > > >=20
> > > > > > Thanks
> > > > > >=20
> > > > > >=20
> > > > > >=20
> > > > > >=20
> > > > > >=20
> > > > > > _______________________________________________
> > > > > > Virtio-networking mailing list
> > > > > > Virtio-networking@redhat.com
> > > > > > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__www.redh=
at.com_mailman_listinfo_virtio-
> > > > > > 2Dnetworking&d=3DDwIGaQ&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DlDHJ2FW5=
2oJ3lqqsArgFRdcevq01tbLQAw
> > > > > > 4A_NO7xgI&m=3DpddgVCz-
> > > > > > orGTuUXATJ4Dmi7vAXatG9w47AmULNC3V9A&s=3D5mfYWbLCjcZO8FcwDqgAc5b=
jE-H-
> > > > > > 4p5TBkRZqP3uMsQ&e=3D


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

