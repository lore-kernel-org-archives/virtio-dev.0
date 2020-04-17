Return-Path: virtio-dev-return-7126-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 34AA6986083
	for <virtio-dev@lists.oasis-open.org>; Fri, 17 Apr 2020 13:17:47 +0000 (UTC)
Date: Fri, 17 Apr 2020 09:17:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200417091658-mutt-send-email-mst@kernel.org>
References: <BN6PR1801MB2067D788CCD354CE6DE0CF52C5D90@BN6PR1801MB2067.namprd18.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <BN6PR1801MB2067D788CCD354CE6DE0CF52C5D90@BN6PR1801MB2067.namprd18.prod.outlook.com>
Subject: Re: [virtio-dev] Re: [Virtio-networking] Doorbell mapping of vDPA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Vitaly Mireyno <vmireyno@marvell.com>
Cc: Jason Wang <jasowang@redhat.com>, "virtio-networking@redhat.com" <virtio-networking@redhat.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Ariel Elior <aelior@marvell.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Apr 17, 2020 at 12:53:29PM +0000, Vitaly Mireyno wrote:
>=20
> >-----Original Message-----
> >From: Michael S. Tsirkin <mst@redhat.com>
> >Sent: Friday, 17 April, 2020 14:00
> >To: Jason Wang <jasowang@redhat.com>
> >Cc: Vitaly Mireyno <vmireyno@marvell.com>; virtio-networking@redhat.com;=
 Virtio-Dev <virtio-
> >dev@lists.oasis-open.org>; Ariel Elior <aelior@marvell.com>
> >Subject: Re: [virtio-dev] Re: [Virtio-networking] Doorbell mapping of vD=
PA
> >
> >----------------------------------------------------------------------
> >On Fri, Apr 17, 2020 at 06:25:30PM +0800, Jason Wang wrote:
> >>
> >> On 2020/4/17 =E4=B8=8B=E5=8D=886:06, Michael S. Tsirkin wrote:
> >> > On Fri, Apr 17, 2020 at 05:59:29PM +0800, Jason Wang wrote:
> >> > > On 2020/4/17 =E4=B8=8B=E5=8D=885:37, Michael S. Tsirkin wrote:
> >> > > > On Fri, Apr 17, 2020 at 05:31:20PM +0800, Jason Wang wrote:
> >> > > > > On 2020/4/17 =E4=B8=8B=E5=8D=882:39, Michael S. Tsirkin wrote:
> >> > > > > > On Fri, Apr 17, 2020 at 12:22:04PM +0800, Jason Wang wrote:
> >> > > > > > > On 2020/4/17 =E4=B8=8B=E5=8D=8812:19, Jason Wang wrote:
> >> > > > > > > > On 2020/4/15 =E4=B8=8A=E5=8D=8812:20, Michael S. Tsirkin=
 wrote:
> >> > > > > > > > > On Tue, Apr 14, 2020 at 01:12:51PM +0000, Vitaly Mirey=
no wrote:
> >> > > > > > > > > > > -----Original Message-----
> >> > > > > > > > > > > From:virtio-networking-bounces@redhat.com
> >> > > > > > > > > > > <virtio-networking-bounces@redhat.com>  On Behalf
> >> > > > > > > > > > > Of Jason Wang
> >> > > > > > > > > > > Sent: Tuesday, 7 April, 2020 10:56
> >> > > > > > > > > > > To:virtio-networking@redhat.com; Virtio-Dev
> >> > > > > > > > > > > <virtio-dev@lists.oasis-open.org>
> >> > > > > > > > > > > Cc: Michael S. Tsirkin<mst@redhat.com>
> >> > > > > > > > > > > Subject: [Virtio-networking] Doorbell mapping of
> >> > > > > > > > > > > vDPA
> >> > > > > > > > > > >
> >> > > > > > > > > > > --------------------------------------------------
> >> > > > > > > > > > > --------------------
> >> > > > > > > > > > > Hi all:
> >> > > > > > > > > > >
> >> > > > > > > > > > > To get native performance of VF, we need to map
> >> > > > > > > > > > > doorbell to guest to avoid unnecessary vmexit. In
> >> > > > > > > > > > > order to do this, we will launch qemu with page-pe=
r-vq=3Don.
> >> > > > > > > > > > > This means the each doorbell register should be
> >> > > > > > > > > > > located at the beginning of 4K page and does not
> >> > > > > > > > > > > share the page with other registers. Then vDPA
> >> > > > > > > > > > > framework can safely map it into the guest
> >> > > > > > > > > > > physical address (GPA) range defined by qemu. It
> >> > > > > > > > > > > could be either
> >> > > > > > > > > > >
> >> > > > > > > > > > > 1) a single doorbell register that is used by all
> >> > > > > > > > > > > virtqueues
> >> > > > > > > > > > >
> >> > > > > > > > > > > or
> >> > > > > > > > > > >
> >> > > > > > > > > > > 2) several different per-vq doorbell registers
> >> > > > > > > > > > >
> >> > > > > > > > > > > If you decide to implement a virtio-pci register
> >> > > > > > > > > > > layout, need to make sure for notification
> >> > > > > > > > > > > structure
> >> > > > > > > > > > > (4.1.4.4 of virtio spec):
> >> > > > > > > > > > >
> >> > > > > > > > > > > For each virtqueue, the result
> >> > > > > > > > > > > ofcap.offset+queue_notify_off*notify_off_multiplie
> >> > > > > > > > > > > r is PAGE_SIZE (e.g
> >> > > > > > > > > > > 4K) alignment, and the doorbeel does not share the
> >> > > > > > > > > > > page with other registers.
> >> > > > > > > > > > >
> >> > > > > > > > > > > And it would be better if queue_notify_off,
> >> > > > > > > > > > > notify_off_multiplier can be changed via firmware
> >> > > > > > > > > > > for extra flexibility.
> >> > > > > > > > > > >
> >> > > > > > > > > > In some cases, these conditions could not be met for
> >> > > > > > > > > > a virtio-net hardware device over PCI transport.
> >> > > > > > > > > > queue_notify and notify_off_multiplier could not
> >> > > > > > > > > > always be fully controlled by the firmware. There
> >> > > > > > > > > > could be hardware limitations on flexibility degree =
of these parameters.
> >> > > > > > > > > > Specifically, the limitations I'm thinking of are:
> >> > > > > > > > > >    =C2=A0 * queue_notify_off>0 and notify_off_multip=
lier>0
> >> > > > > > > > > >    =C2=A0 * Several doorbell registers of several
> >> > > > > > > > > > virtqueues share the same page (but don't share the =
page with other registers).
> >> > > > > > > > > >
> >> > > > > > > > > > Can this be supported in vDPA with direct doorbell m=
apping?
> >> > > > > > > > > >
> >> > > > > > > > > > Thanks
> >> > > > > > > > > There's value in being able to intercept some vqs in
> >> > > > > > > > > software while the rest of vqs are handled in hardware=
.
> >> > > > > > > > > E.g. that's the case for e.g. the control vq.
> >> > > > > > > > Good point, so in this case, the doorbell of control vq
> >> > > > > > > > must exclusively own a page.
> >> > > > > > > Or we need intercept the doorbells that share a page with
> >> > > > > > > control vq doorbell.
> >> > > > > > >
> >> > > > > > > Thanks
> >> > > > > > Which could be all of them. E.g. with a 4 byte offset, we
> >> > > > > > are talking 1K VQs per a 4k page.
> >> > > > > Yes, so as I replied in another thread. The doorbell of
> >> > > > > control vq should not share page with other doorbells.
> >> > > > Except page size can be as big as 64k on some systems.
> >> > > > The best thing is really if device just allows driver to write
> >> > > > anywhere within the page, taking VQ number from the data.
> >> > > >
> >> > > Just to make sure I understand, then there's no way to map them to=
 guest?
> >> > >
> >> > > Thanks
> >> >
> >> > Then you can map them at any offset.
> >>
> >>
> >> Two more questions.
> >>
> >> 1) If the doorbell of control vq shares 64K pages with other doorbell,
> >> then we can't intercept the control vq doorbell by software.
> >
> >And if hardware requires doorbell e.g. at offset 0x10 in the page, we ca=
n't migrate to a device which
> >needs it at offset 0x0.
> >
> >
> >> 2) Each VF should occupy at least 128K address space without the the
> >> help of flexible notification proposed by Vitaly. Is this too much if
> >> we have several thousands of vDPA instances?
> >>
> >> Thanks
> >
> >I guess ctrl VQs could share a page ...
> >I guess hypervisor can have control over this so that we can just use 4K=
 for the common x86/ARM case.
> >
>=20
>=20
> Just to make sure I understand - The device will still be able to control=
 queue_notify_off for dataplane VQs, right?
> And if we use 4K pages, the control vq can have its own page.

Problem is, e.g. with ppc it's common to have larger page size such as 64k.

> And just to clarify, the "flexible notification" proposal is not instead =
of the queue_notify_off control. The device must have a unique and specific=
 doorbell address per vq. The proposal is that it can have more data in the=
 notification structure itself.
>=20
>=20
> >--
> >MST
>=20


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

