Return-Path: virtio-dev-return-7123-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0CFCC986077
	for <virtio-dev@lists.oasis-open.org>; Fri, 17 Apr 2020 11:00:16 +0000 (UTC)
Date: Fri, 17 Apr 2020 07:00:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200417062938-mutt-send-email-mst@kernel.org>
References: <BN6PR1801MB2067FCCE45316C25E5EB82F7C5DA0@BN6PR1801MB2067.namprd18.prod.outlook.com>
 <20200414121724-mutt-send-email-mst@kernel.org>
 <6cd6b9aa-1ee8-d523-aee3-4765dc52202e@redhat.com>
 <6bd9fd2b-b3c8-2267-18fd-0ad29cf92020@redhat.com>
 <20200417023805-mutt-send-email-mst@kernel.org>
 <03aa8c83-ed50-9004-25d1-21cdc090d6c3@redhat.com>
 <20200417053429-mutt-send-email-mst@kernel.org>
 <725d5f08-de6c-e918-7df3-6c9fc6c31a27@redhat.com>
 <20200417060640-mutt-send-email-mst@kernel.org>
 <f13ee7bf-80e2-c23b-e3a6-159a12b257ff@redhat.com>
MIME-Version: 1.0
In-Reply-To: <f13ee7bf-80e2-c23b-e3a6-159a12b257ff@redhat.com>
Subject: Re: [virtio-dev] Re: [Virtio-networking] Doorbell mapping of vDPA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Jason Wang <jasowang@redhat.com>
Cc: Vitaly Mireyno <vmireyno@marvell.com>, "virtio-networking@redhat.com" <virtio-networking@redhat.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Ariel Elior <aelior@marvell.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Apr 17, 2020 at 06:25:30PM +0800, Jason Wang wrote:
>=20
> On 2020/4/17 =E4=B8=8B=E5=8D=886:06, Michael S. Tsirkin wrote:
> > On Fri, Apr 17, 2020 at 05:59:29PM +0800, Jason Wang wrote:
> > > On 2020/4/17 =E4=B8=8B=E5=8D=885:37, Michael S. Tsirkin wrote:
> > > > On Fri, Apr 17, 2020 at 05:31:20PM +0800, Jason Wang wrote:
> > > > > On 2020/4/17 =E4=B8=8B=E5=8D=882:39, Michael S. Tsirkin wrote:
> > > > > > On Fri, Apr 17, 2020 at 12:22:04PM +0800, Jason Wang wrote:
> > > > > > > On 2020/4/17 =E4=B8=8B=E5=8D=8812:19, Jason Wang wrote:
> > > > > > > > On 2020/4/15 =E4=B8=8A=E5=8D=8812:20, Michael S. Tsirkin wr=
ote:
> > > > > > > > > On Tue, Apr 14, 2020 at 01:12:51PM +0000, Vitaly Mireyno =
wrote:
> > > > > > > > > > > -----Original Message-----
> > > > > > > > > > > From:virtio-networking-bounces@redhat.com
> > > > > > > > > > > <virtio-networking-bounces@redhat.com>  On Behalf
> > > > > > > > > > > Of Jason Wang
> > > > > > > > > > > Sent: Tuesday, 7 April, 2020 10:56
> > > > > > > > > > > To:virtio-networking@redhat.com; Virtio-Dev
> > > > > > > > > > > <virtio-dev@lists.oasis-open.org>
> > > > > > > > > > > Cc: Michael S. Tsirkin<mst@redhat.com>
> > > > > > > > > > > Subject: [Virtio-networking] Doorbell mapping of vDPA
> > > > > > > > > > >=20
> > > > > > > > > > > -----------------------------------------------------=
-----------------
> > > > > > > > > > > Hi all:
> > > > > > > > > > >=20
> > > > > > > > > > > To get native performance of VF, we need to map doorb=
ell to
> > > > > > > > > > > guest to avoid unnecessary vmexit. In
> > > > > > > > > > > order to do this, we will launch qemu with page-per-v=
q=3Don.
> > > > > > > > > > > This means the each doorbell register
> > > > > > > > > > > should be located at the beginning of 4K page and doe=
s not
> > > > > > > > > > > share the page with other registers. Then
> > > > > > > > > > > vDPA framework can safely map it into the guest physi=
cal
> > > > > > > > > > > address (GPA) range defined by qemu. It
> > > > > > > > > > > could be either
> > > > > > > > > > >=20
> > > > > > > > > > > 1) a single doorbell register that is used by all vir=
tqueues
> > > > > > > > > > >=20
> > > > > > > > > > > or
> > > > > > > > > > >=20
> > > > > > > > > > > 2) several different per-vq doorbell registers
> > > > > > > > > > >=20
> > > > > > > > > > > If you decide to implement a virtio-pci register layo=
ut,
> > > > > > > > > > > need to make sure for notification structure
> > > > > > > > > > > (4.1.4.4 of virtio spec):
> > > > > > > > > > >=20
> > > > > > > > > > > For each virtqueue, the result
> > > > > > > > > > > ofcap.offset+queue_notify_off*notify_off_multiplier i=
s PAGE_SIZE (e.g
> > > > > > > > > > > 4K) alignment, and the doorbeel does not share the pa=
ge with
> > > > > > > > > > > other registers.
> > > > > > > > > > >=20
> > > > > > > > > > > And it would be better if queue_notify_off,
> > > > > > > > > > > notify_off_multiplier can be changed via firmware for
> > > > > > > > > > > extra flexibility.
> > > > > > > > > > >=20
> > > > > > > > > > In some cases, these conditions could not be met for a
> > > > > > > > > > virtio-net hardware device over PCI transport.
> > > > > > > > > > queue_notify and notify_off_multiplier could not always=
 be fully
> > > > > > > > > > controlled by the firmware. There could be hardware lim=
itations
> > > > > > > > > > on flexibility degree of these parameters.
> > > > > > > > > > Specifically, the limitations I'm thinking of are:
> > > > > > > > > >    =C2=A0 * queue_notify_off>0 and notify_off_multiplie=
r>0
> > > > > > > > > >    =C2=A0 * Several doorbell registers of several virtq=
ueues share the
> > > > > > > > > > same page (but don't share the page with other register=
s).
> > > > > > > > > >=20
> > > > > > > > > > Can this be supported in vDPA with direct doorbell mapp=
ing?
> > > > > > > > > >=20
> > > > > > > > > > Thanks
> > > > > > > > > There's value in being able to intercept some vqs in soft=
ware
> > > > > > > > > while the rest of vqs are handled in hardware.
> > > > > > > > > E.g. that's the case for e.g. the control vq.
> > > > > > > > Good point, so in this case, the doorbell of control vq mus=
t exclusively
> > > > > > > > own a page.
> > > > > > > Or we need intercept the doorbells that share a page with con=
trol vq
> > > > > > > doorbell.
> > > > > > >=20
> > > > > > > Thanks
> > > > > > Which could be all of them. E.g. with a 4 byte offset, we are
> > > > > > talking 1K VQs per a 4k page.
> > > > > Yes, so as I replied in another thread. The doorbell of control v=
q should
> > > > > not share page with other doorbells.
> > > > Except page size can be as big as 64k on some systems.
> > > > The best thing is really if device just allows driver to write
> > > > anywhere within the page, taking VQ number from the data.
> > > >=20
> > > Just to make sure I understand, then there's no way to map them to gu=
est?
> > >=20
> > > Thanks
> >=20
> > Then you can map them at any offset.
>=20
>=20
> Two more questions.
>=20
> 1) If the doorbell of control vq shares 64K pages with other doorbell, th=
en
> we can't intercept the control vq doorbell by software.

And if hardware requires doorbell e.g. at offset 0x10 in the page,
we can't migrate to a device which needs it at offset 0x0.


> 2) Each VF should occupy at least 128K address space without the the help=
 of
> flexible notification proposed by Vitaly. Is this too much if we have
> several thousands of vDPA instances?
>=20
> Thanks

I guess ctrl VQs could share a page ...
I guess hypervisor can have control over this so that we
can just use 4K for the common x86/ARM case.

--=20
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

