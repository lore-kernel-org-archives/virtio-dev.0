Return-Path: <stefanha@redhat.com>
Date: Mon, 29 Nov 2021 10:29:07 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v3 2/2] virtio: introduce STOP status bit
Message-ID: <YaSrcwhox2b/ZNP3@stefanha-x1.localdomain>
References: <20211111185812.2326093-1-eperezma@redhat.com>
 <20211111185812.2326093-3-eperezma@redhat.com>
 <YZZ4aXdOAA65v10Y@stefanha-x1.localdomain>
 <CAJaqyWcy3J=pSgXQbKch3EA-5swJJBa68qn-VCWFaixctR+ppw@mail.gmail.com>
 <YZzbtcNXRTD1BawU@stefanha-x1.localdomain>
 <CAJaqyWfwX4hUMKw5mK-jwUUDm8WQA2PxUvbD2EOavMUAO1Q0kQ@mail.gmail.com>
 <YZ4gE8+KiiZBK9no@stefanha-x1.localdomain>
 <0862abe5-b1f5-77ba-bddb-097dac21ce99@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zjjkiRMt8OcwSLmg"
Content-Disposition: inline
In-Reply-To: <0862abe5-b1f5-77ba-bddb-097dac21ce99@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, virtio-comment@lists.oasis-open.org, Michael Tsirkin <mst@redhat.com>, Alexander Mikheev <amikheev@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Bodong Wang <bodong@nvidia.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>


--zjjkiRMt8OcwSLmg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 25, 2021 at 10:57:28AM +0800, Jason Wang wrote:
>=20
> =E5=9C=A8 2021/11/24 =E4=B8=8B=E5=8D=887:20, Stefan Hajnoczi =E5=86=99=E9=
=81=93:
> > On Tue, Nov 23, 2021 at 06:00:20PM +0100, Eugenio Perez Martin wrote:
> > > On Tue, Nov 23, 2021 at 1:17 PM Stefan Hajnoczi <stefanha@redhat.com>=
 wrote:
> > > > On Thu, Nov 18, 2021 at 08:58:05PM +0100, Eugenio Perez Martin wrot=
e:
> > > > > On Thu, Nov 18, 2021 at 5:00 PM Stefan Hajnoczi <stefanha@redhat.=
com> wrote:
> > > > > > On Thu, Nov 11, 2021 at 07:58:12PM +0100, Eugenio P=C3=A9rez wr=
ote:
> > > > > > > +the driver MAY change avail_idx in the case of split virtque=
ue, but the new
> > > > > > > +avail_idx MUST be within used_idx and used_idx plus virtqueu=
e size.
> > > > > > I'm trying to understand how this would work. Available buffers=
 may be
> > > > > > consumed out-of-order unless VIRTIO_F_IN_ORDER was negotiated, =
so the
> > > > > > avail ring could contain something like:
> > > > > >=20
> > > > > >    avail.ring =3D [Used, Not used, Used, Not used, ...]
> > > > > >                                                  ^--- avail.idx
> > > > > >=20
> > > > > > There are num_not_used =3D avail.idx - used.idx requests that a=
re "Not
> > > > > > used" in avail.ring.
> > > > > >=20
> > > > > > Does this mean the driver can rewind avail.idx by counting the =
number of
> > > > > > "Not used" buffers and skipping "Used" buffers until it reaches
> > > > > > num_not_used "Not used" buffers?
> > > > > >=20
> > > > > I'm going to also drop the "resume" part for the next version bec=
ause
> > > > > it adds extra complexity not actually needed, and it can be achie=
ved
> > > > > with a full reset in a simpler way.
> > > > >=20
> > > > > But I'll explain it below with your examples. Long story short, t=
he
> > > > > driver only can rewind the available descriptors that are still i=
n the
> > > > > available ring, and the device must flush the ones that cannot re=
cover
> > > > > from the ring.
> > > > >=20
> > > > > > I think there is a known issue with this approach:
> > > > > >=20
> > > > > > Imagine a vring with 4 elements:
> > > > > >=20
> > > > > >    avail.ring =3D [0,        1,    2,    3   ]
> > > > > >                  Not used, used, used, used
> > > > > >                                             ^--- avail.idx
> > > > > >=20
> > > > > > Since the device has used 3 buffers the driver now has space to=
 make
> > > > > > more buffers available. avail.idx wraps back to the start of th=
e ring
> > > > > > and the driver overwrites the first element ("Not used"):
> > > > > >=20
> > > > > >    avail.ring =3D [1,        N/A,  N/A,  N/A]
> > > > > >                  Not used, N/A,  N/A,  N/A
> > > > > >                           ^--- avail.idx
> > > > > >=20
> > > > > > Since vring descriptor 0 is still in use the driver chose descr=
iptor 1
> > > > > > for the new available buffer.
> > > > > >=20
> > > > > > Now we stop the device, knowing there are two buffers available=
 that
> > > > > > have not been used. But avail.ring[] actually only contains the=
 new
> > > > > > buffer (vring descriptor 1) that we made available because we o=
verwrote
> > > > > > the old avail.ring[] element (vring descriptor 0).
> > > > > >=20
> > > > > > What now? Where does the device reset its internal avail_idx to?
> > > > > To be on the same page, in qemu the device maintains two "internal
> > > > > avail idx": shadow_avail_idx (last seen in the available ring, co=
uld
> > > > > be 4 in this case) and last_avail_idx (next descriptor to fetch f=
rom
> > > > > avail, 2). The device must forget shadow_avail_idx and flush the
> > > > > descriptors that cannot recover (0). So last_avail_idx is now 3. =
Now
> > > > > it can stop.
> > > > >=20
> > > > > The proposal allows the device to fail descriptor 0 in a
> > > > > device-specific way, but I think now it was a bad choice.
> > > > >=20
> > > > > The driver cannot move the device's last_avail_idx in this operat=
ion:
> > > > > The device is simply forced to flush used ones to the used ring or
> > > > > descriptor ring in a packed vq case. So the device's internal
> > > > > avail_idx =3D=3D used_idx =3D=3D 3. When the device resumes, it's=
 still 3.
> > > > >=20
> > > > > The device must keep its last_avail_idx through stop and resume c=
ycle.
> > > > Are you saying that all buffers avail->ring[i % ring_size] must be
> > > > completed by the device before the STOP bit is reported where i <=3D
> > > > last_avail_idx?
> > > >=20
> > > > This means the driver can modify avail->ring[i % ring_size] where
> > > > avail_idx >=3D i > used_idx.
> > > >=20
> > > Yes, That's correct. The driver could also decide to modify the
> > > descriptor table instead of the avail ring to do so, but I think the
> > > point is clear now.
> > >=20
> > > Somehow it is thought after the premise that the out of order
> > "Somehow it is thought after the premise" =3D=3D "there is a fundamental
> > design assumption"?
> >=20
> > > descriptors are descriptors that the device must wait to complete
> > > before the pause anyway. Depending on the device, it might prefer to
> > > cancel them, to wait for them, etc. The interesting descriptors to
> > > rewind are the ones that have not reached the device (i > used_idx).
> > > The driver can do whatever it wants with them.
> > >=20
> > > If we assume all the in-flight descriptors are idempotent and we
> > > expose a way for the device to expose them, the model is way more
> > > simpler than this.
> > The constraint that the device has to mark all previously seen "avail"
> > buffers as "used" is problematic. It makes STOP visible to the driver
> > when the device has to fail requests.
>=20
>=20
> I think we need some clarification here on the driver. For doing migratio=
n,
> some kind of mediation is a must.
>=20
> As we've discussed in the previous versions of this proposal, the VMM
> usually won't advertise the STOP feature to guest if we don't want to do
> nested live migration (if we do we can shadow it anyhow).
>=20
> So from the guest point of view it won't see neither STOP nor the inflight
> descriptors.

That's not how I understand STOP semantics. See below.

> > That is incompatible with how
> > devices behave across live migration today. If you want to use STOP for
> > live migration then it's probably necessary to rethink this constraint.
> >=20
> > QEMU's virtio-blk and virtio-scsi device models put failed requests onto
> > a list so they can be retried after problems with the underlying storage
> > have been resolved (e.g. more disk space becomes available and ENOSPC
> > requests can be retried).
>=20
>=20
> A question, I think for those "failure" it's actually not visible from the
> drive? If this is true, from the spec point of view, there are still
> inflight. The VMM may choose to migrate them to the destination and
> re-submit them there. This works more like vhost re-connection.

That's how I would like STOP to work, but the semantics seem to be
different. Eugenio can correct me if this is wrong:

All avail descriptors before the last used descriptor must be marked
used before the device reports the STOP bit. For example:

  avail.ring =3D [1, 2, 3, 4]
  used.ring =3D [3]

The driver writes the STOP bit. Now the device MUST complete 1 and 2
before reporting the STOP bit. Therefore we cannot keep 1 and 2
in flight but it can keep 4 in flight. The problem is that this
conflicts with the virtio-blk/scsi failed requests behavior where 1 and
2 should be kept in flight and migrated.

Stefan

--zjjkiRMt8OcwSLmg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmGkq3MACgkQnKSrs4Gr
c8hSPggAxH0XH8SKDow3V2iHaRuUZq9/bMqicqHuyS9W0iJBjiqWugHGw+j0zYIx
tReOzbSidFn5aUiwsFf0Grvm14dBXzYVqSp9xq9lKoKKiTprA4QArzQOuVyztcl6
53I/K3HI9w8KWisNEPRdjvxJ6cGxeMKdi9T7uy7UhwNjmbXc+VYpee1aKMPTloIR
NWQjzangIhXPOLrPyBImSXyPFypyh57fHmc+xS6th9xDfHeytB57bIZQ34WEDWXK
g2QTRd8feR/am1PNcLSdYrniWBrf0AFTYG5TEQh3hWYQaaoszlkSF2RObKbF/oiT
z8y3u9GuYnjnrnDktJuz/d4lkIU/Tg==
=i3jO
-----END PGP SIGNATURE-----

--zjjkiRMt8OcwSLmg--

