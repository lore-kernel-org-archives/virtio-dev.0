Return-Path: <virtio-dev-return-14061-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61227C197A0
	for <virtio-dev@archiver.kernel.org>; Mon, 20 Nov 2023 11:02:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A7EE93E56E
	for <virtio-dev@archiver.kernel.org>; Mon, 20 Nov 2023 11:02:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7670F986859
	for <virtio-dev@archiver.kernel.org>; Mon, 20 Nov 2023 11:02:54 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 59F3998684D; Mon, 20 Nov 2023 11:02:54 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 47C3398684E
	for <virtio-dev@lists.oasis-open.org>; Mon, 20 Nov 2023 11:02:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: cgzHw3_LM1erQg7AqBec9A-1
Date: Mon, 20 Nov 2023 06:02:47 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Reshetova, Elena" <elena.reshetova@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
Message-ID: <20231120110247.GC540380@fedora>
References: <20231116200245.GA336841@fedora>
 <DM8PR11MB5750765B1310C904A8B1B00BE7B4A@DM8PR11MB5750.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="T9d0AhHQbbggMTd4"
Content-Disposition: inline
In-Reply-To: <DM8PR11MB5750765B1310C904A8B1B00BE7B4A@DM8PR11MB5750.namprd11.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Subject: [virtio-dev] Re: Using packed virtqueues in Confidential VMs

--T9d0AhHQbbggMTd4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 10:13:15AM +0000, Reshetova, Elena wrote:
> Hi Stefan,=20
>=20
> Thank you for following up on this! Please find my comments inline.=20
>=20
> > -----Original Message-----
> > From: Stefan Hajnoczi <stefanha@redhat.com>
> > Sent: Thursday, November 16, 2023 10:03 PM
> > To: Reshetova, Elena <elena.reshetova@intel.com>
> > Cc: Michael S. Tsirkin <mst@redhat.com>; virtio-dev@lists.oasis-open.or=
g;
> > virtualization@lists.linux.dev
> > Subject: Using packed virtqueues in Confidential VMs
> >=20
> > Hi Elena,
> > You raised concerns about using packed virtqueues with untrusted device=
s at
> > Linux Plumbers Conference. I reviewed the specification and did not find
> > fundamental issues that would preclude the use of packed virtqueues in
> > untrusted devices. Do you have more information about issues with packed
> > virtqueues?
>=20
> First of all a bit of clarification: our overall logic for making our fir=
st reference
> release of Linux intel tdx stacks [1] was to enable only minimal required
> functionality and this also applied to numerous modes that virtio provide=
d.=20
> Because for each enabled functionality we would have to do a code audit a=
nd
> a proper fuzzing setup and all of this requires resources.=20
>=20
> The choice of split queue was a natural first step since it is the most s=
traightforward
> to understand (at least it was for us, bare in mind we are not experts in=
 virtio as
> you are) and the fact that there was work already done ([2] and other pat=
ches)
> to harden the descriptors for split queue.=20
>=20
> [1] https://github.com/intel/tdx-tools=20
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/drivers/virtio?h=3Dv6.6-rc4&id=3D72b5e8958738aaa453db5149e6ca3bcf41602=
3b9
>=20
> I remember looking at the packed queue long ago and noticing that at least
> some descriptor fields are under device control and I wasn=E2=80=99t sure=
 why the similar=20
> hardening was not done here as for the split case. However, we had many
> issues to handle in past, and since we didn=E2=80=99t need the packed que=
ue, we
> never went to investigate this further.=20
> It is also possible that we simply misunderstood the code at that point.
>=20
> >=20
> > I also reviewed Linux's virtio_ring.c to look for implementation issues=
=2E One
> > thing I noticed was that detach_buf_packed -> vring_unmap_desc_packed t=
rusts
> > the fields of indirect descriptors that have been mapped to the device:
> >=20
> >   flags =3D le16_to_cpu(desc->flags);
> >=20
> >   dma_unmap_page(vring_dma_dev(vq),
> >                  le64_to_cpu(desc->addr),
> >                  le32_to_cpu(desc->len),
> >                  (flags & VRING_DESC_F_WRITE) ?
> >                  DMA_FROM_DEVICE : DMA_TO_DEVICE);
>=20
>=20
> >=20
> > This could be problematic if the device is able to modify indirect desc=
riptors.
> > However, the indirect descriptor table is mapped with DMA_TO_DEVICE:
> >=20
> >   addr =3D vring_map_single(vq, desc,
> >                           total_sg * sizeof(struct vring_packed_desc),
> >                           DMA_TO_DEVICE);
> >=20
> > There is no problem when there is an enforcing IOMMU that maps the page=
 with
> > read-only permissions but that's not always the case.=20
>=20
> We don=E2=80=99t use IOMMU at the moment for the confidential guest, sinc=
e we don=E2=80=99t
> have to (memory is encrypted/protected) and only explicitly shared pages =
are
> available for the host/devices to modify.=20
> Do I understand it correctly that in our case the indirect descriptor tab=
le will=20
> end up mapped shared for this mode to work and then there is no protectio=
n?=20

Correct.

>=20
> Software devices (QEMU,
> > vhost kernel, or vhost-user) usually have full access to guest RAM. The=
y can
> > cause dma_unmap_page() to be invoked with arguments of their choice (ex=
cept
> > for
> > the first argument) by modifying indirect descriptors.
> >=20
> > I am not sure if this poses a danger since software devices already hav=
e access
> > to guest RAM, but I think this code is risky. It would be safer for the=
 driver
> > to stash away the arguments needed for dma_unmap_page() in memory that =
is
> > not
> > mapped to the device.
> >=20
> > Other than that, I didn't find any issues with the packed virtqueue
> > implementation.
>=20
> Thank you for looking into this! Even if we didn=E2=80=99t need the packe=
d queue,=20
> I am sure other deployments might need it and it would be the best for=20
> virtio to provide all modes that are secure.=20

I looked at the split virtqueue layout code and noticed
vring_unmap_one_split_indirect() does the same thing. So packed and
split virtqueues are the same with respect to loading descriptor fields
=66rom memory that devices without an IOMMU may have overwritten.

The impact of letting an attacker choose most of the arguments to
dma_unmap_page() is not clear to me. There is swiotlb state associated
with every mapping. I haven't read the swiotlb code, so I'm not sure how
robust it is against invalid inputs.

Stefan

--T9d0AhHQbbggMTd4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVbPNYACgkQnKSrs4Gr
c8iEeAgAlm5Nku7MGM7Utq3MuR+sI6zrnQIvnJp49CIMC9ciYqpLgeY/eqUVZtvj
IjEPNhWnkYE65slFTMOnMXr4fvW1i7oYW23Fyb8cAoMUlGoIdtFAG1DjO5MVTBlS
BJl/pinPY0rgeNsVoYGF3BTLL8++ojOKGSQ28xc71yQmT9KAz0BVUhttCAT/tUPm
m2OcKBi3WgkdXezK/TmQHvzybCHKMQXoyyH3e52LRZsDYr8fgO6VUil+I4rD1SFY
y/YuOUtvUUfOKhHqfof1QdwPayVI4YnlUFuisZ6RDm7yhSiEkvZgyHH8otlv1qX0
Zfc9xR8l0q+Dy4kb/6LrPMldmV1lbQ==
=Rfai
-----END PGP SIGNATURE-----

--T9d0AhHQbbggMTd4--

