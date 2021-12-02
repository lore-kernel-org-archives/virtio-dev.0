Return-Path: <stefanha@redhat.com>
Date: Thu, 2 Dec 2021 09:44:36 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v3 2/2] virtio: introduce STOP status bit
Message-ID: <YaiVhNMNBAhbhzvr@stefanha-x1.localdomain>
References: <20211111185812.2326093-3-eperezma@redhat.com>
 <YZZ4aXdOAA65v10Y@stefanha-x1.localdomain>
 <CAJaqyWcy3J=pSgXQbKch3EA-5swJJBa68qn-VCWFaixctR+ppw@mail.gmail.com>
 <YZzbtcNXRTD1BawU@stefanha-x1.localdomain>
 <CAJaqyWfwX4hUMKw5mK-jwUUDm8WQA2PxUvbD2EOavMUAO1Q0kQ@mail.gmail.com>
 <YZ4gE8+KiiZBK9no@stefanha-x1.localdomain>
 <0862abe5-b1f5-77ba-bddb-097dac21ce99@redhat.com>
 <YaSrcwhox2b/ZNP3@stefanha-x1.localdomain>
 <CAJaqyWfDDohTFjGu+VEX+5tfsxA9D0VsxMeZEyjFDOKM=Q-1Pw@mail.gmail.com>
 <CACGkMEsUmOvJrQtrNosqOdMKxtFS91hkcBRJjxGeMyScjdduAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4en+kRS1oKqfbtTI"
Content-Disposition: inline
In-Reply-To: <CACGkMEsUmOvJrQtrNosqOdMKxtFS91hkcBRJjxGeMyScjdduAg@mail.gmail.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, virtio-comment@lists.oasis-open.org, Michael Tsirkin <mst@redhat.com>, Alexander Mikheev <amikheev@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Bodong Wang <bodong@nvidia.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>


--4en+kRS1oKqfbtTI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 02, 2021 at 10:40:57AM +0800, Jason Wang wrote:
> On Tue, Nov 30, 2021 at 12:56 AM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Mon, Nov 29, 2021 at 11:29 AM Stefan Hajnoczi <stefanha@redhat.com> =
wrote:
> > >
> > > On Thu, Nov 25, 2021 at 10:57:28AM +0800, Jason Wang wrote:
> > > >
> > > > =E5=9C=A8 2021/11/24 =E4=B8=8B=E5=8D=887:20, Stefan Hajnoczi =E5=86=
=99=E9=81=93:
> > > > > On Tue, Nov 23, 2021 at 06:00:20PM +0100, Eugenio Perez Martin wr=
ote:
> > > > > > On Tue, Nov 23, 2021 at 1:17 PM Stefan Hajnoczi <stefanha@redha=
t.com> wrote:
> > > > > > > On Thu, Nov 18, 2021 at 08:58:05PM +0100, Eugenio Perez Marti=
n wrote:
> > > > > > > > On Thu, Nov 18, 2021 at 5:00 PM Stefan Hajnoczi <stefanha@r=
edhat.com> wrote:
> > > > > > > > > On Thu, Nov 11, 2021 at 07:58:12PM +0100, Eugenio P=C3=A9=
rez wrote:
> > > > > > > > > > +the driver MAY change avail_idx in the case of split v=
irtqueue, but the new
> > > > > > > > > > +avail_idx MUST be within used_idx and used_idx plus vi=
rtqueue size.
> > > > > > > > > I'm trying to understand how this would work. Available b=
uffers may be
> > > > > > > > > consumed out-of-order unless VIRTIO_F_IN_ORDER was negoti=
ated, so the
> > > > > > > > > avail ring could contain something like:
> > > > > > > > >
> > > > > > > > >    avail.ring =3D [Used, Not used, Used, Not used, ...]
> > > > > > > > >                                                  ^--- ava=
il.idx
> > > > > > > > >
> > > > > > > > > There are num_not_used =3D avail.idx - used.idx requests =
that are "Not
> > > > > > > > > used" in avail.ring.
> > > > > > > > >
> > > > > > > > > Does this mean the driver can rewind avail.idx by countin=
g the number of
> > > > > > > > > "Not used" buffers and skipping "Used" buffers until it r=
eaches
> > > > > > > > > num_not_used "Not used" buffers?
> > > > > > > > >
> > > > > > > > I'm going to also drop the "resume" part for the next versi=
on because
> > > > > > > > it adds extra complexity not actually needed, and it can be=
 achieved
> > > > > > > > with a full reset in a simpler way.
> > > > > > > >
> > > > > > > > But I'll explain it below with your examples. Long story sh=
ort, the
> > > > > > > > driver only can rewind the available descriptors that are s=
till in the
> > > > > > > > available ring, and the device must flush the ones that can=
not recover
> > > > > > > > from the ring.
> > > > > > > >
> > > > > > > > > I think there is a known issue with this approach:
> > > > > > > > >
> > > > > > > > > Imagine a vring with 4 elements:
> > > > > > > > >
> > > > > > > > >    avail.ring =3D [0,        1,    2,    3   ]
> > > > > > > > >                  Not used, used, used, used
> > > > > > > > >                                             ^--- avail.idx
> > > > > > > > >
> > > > > > > > > Since the device has used 3 buffers the driver now has sp=
ace to make
> > > > > > > > > more buffers available. avail.idx wraps back to the start=
 of the ring
> > > > > > > > > and the driver overwrites the first element ("Not used"):
> > > > > > > > >
> > > > > > > > >    avail.ring =3D [1,        N/A,  N/A,  N/A]
> > > > > > > > >                  Not used, N/A,  N/A,  N/A
> > > > > > > > >                           ^--- avail.idx
> > > > > > > > >
> > > > > > > > > Since vring descriptor 0 is still in use the driver chose=
 descriptor 1
> > > > > > > > > for the new available buffer.
> > > > > > > > >
> > > > > > > > > Now we stop the device, knowing there are two buffers ava=
ilable that
> > > > > > > > > have not been used. But avail.ring[] actually only contai=
ns the new
> > > > > > > > > buffer (vring descriptor 1) that we made available becaus=
e we overwrote
> > > > > > > > > the old avail.ring[] element (vring descriptor 0).
> > > > > > > > >
> > > > > > > > > What now? Where does the device reset its internal avail_=
idx to?
> > > > > > > > To be on the same page, in qemu the device maintains two "i=
nternal
> > > > > > > > avail idx": shadow_avail_idx (last seen in the available ri=
ng, could
> > > > > > > > be 4 in this case) and last_avail_idx (next descriptor to f=
etch from
> > > > > > > > avail, 2). The device must forget shadow_avail_idx and flus=
h the
> > > > > > > > descriptors that cannot recover (0). So last_avail_idx is n=
ow 3. Now
> > > > > > > > it can stop.
> > > > > > > >
> > > > > > > > The proposal allows the device to fail descriptor 0 in a
> > > > > > > > device-specific way, but I think now it was a bad choice.
> > > > > > > >
> > > > > > > > The driver cannot move the device's last_avail_idx in this =
operation:
> > > > > > > > The device is simply forced to flush used ones to the used =
ring or
> > > > > > > > descriptor ring in a packed vq case. So the device's intern=
al
> > > > > > > > avail_idx =3D=3D used_idx =3D=3D 3. When the device resumes=
, it's still 3.
> > > > > > > >
> > > > > > > > The device must keep its last_avail_idx through stop and re=
sume cycle.
> > > > > > > Are you saying that all buffers avail->ring[i % ring_size] mu=
st be
> > > > > > > completed by the device before the STOP bit is reported where=
 i <=3D
> > > > > > > last_avail_idx?
> > > > > > >
> > > > > > > This means the driver can modify avail->ring[i % ring_size] w=
here
> > > > > > > avail_idx >=3D i > used_idx.
> > > > > > >
> > > > > > Yes, That's correct. The driver could also decide to modify the
> > > > > > descriptor table instead of the avail ring to do so, but I thin=
k the
> > > > > > point is clear now.
> > > > > >
> > > > > > Somehow it is thought after the premise that the out of order
> > > > > "Somehow it is thought after the premise" =3D=3D "there is a fund=
amental
> > > > > design assumption"?
> > > > >
> > > > > > descriptors are descriptors that the device must wait to comple=
te
> > > > > > before the pause anyway. Depending on the device, it might pref=
er to
> > > > > > cancel them, to wait for them, etc. The interesting descriptors=
 to
> > > > > > rewind are the ones that have not reached the device (i > used_=
idx).
> > > > > > The driver can do whatever it wants with them.
> > > > > >
> > > > > > If we assume all the in-flight descriptors are idempotent and we
> > > > > > expose a way for the device to expose them, the model is way mo=
re
> > > > > > simpler than this.
> > > > > The constraint that the device has to mark all previously seen "a=
vail"
> > > > > buffers as "used" is problematic. It makes STOP visible to the dr=
iver
> > > > > when the device has to fail requests.
> > > >
> > > >
> > > > I think we need some clarification here on the driver. For doing mi=
gration,
> > > > some kind of mediation is a must.
> > > >
> > > > As we've discussed in the previous versions of this proposal, the V=
MM
> > > > usually won't advertise the STOP feature to guest if we don't want =
to do
> > > > nested live migration (if we do we can shadow it anyhow).
> > > >
> > > > So from the guest point of view it won't see neither STOP nor the i=
nflight
> > > > descriptors.
> > >
> > > That's not how I understand STOP semantics. See below.
> > >
> > > > > That is incompatible with how
> > > > > devices behave across live migration today. If you want to use ST=
OP for
> > > > > live migration then it's probably necessary to rethink this const=
raint.
> > > > >
> > > > > QEMU's virtio-blk and virtio-scsi device models put failed reques=
ts onto
> > > > > a list so they can be retried after problems with the underlying =
storage
> > > > > have been resolved (e.g. more disk space becomes available and EN=
OSPC
> > > > > requests can be retried).
> > > >
> > > >
> > > > A question, I think for those "failure" it's actually not visible f=
rom the
> > > > drive? If this is true, from the spec point of view, there are still
> > > > inflight. The VMM may choose to migrate them to the destination and
> > > > re-submit them there. This works more like vhost re-connection.
> > >
> > > That's how I would like STOP to work, but the semantics seem to be
> > > different. Eugenio can correct me if this is wrong:
> > >
> > > All avail descriptors before the last used descriptor must be marked
> > > used before the device reports the STOP bit. For example:
> > >
> > >   avail.ring =3D [1, 2, 3, 4]
> > >   used.ring =3D [3]
> > >
> > > The driver writes the STOP bit. Now the device MUST complete 1 and 2
> > > before reporting the STOP bit. Therefore we cannot keep 1 and 2
> > > in flight but it can keep 4 in flight. The problem is that this
> > > conflicts with the virtio-blk/scsi failed requests behavior where 1 a=
nd
> > > 2 should be kept in flight and migrated.
>=20
> Ok, so I think I get your comments on the vhost. Regarding the failed
> requests behaviour, it looks like it's an implementation specific
> feature which is out of the virtio spec. If we want to preserve the
> behaviour, we need to extend the virtio spec.
>=20
> Some quick thoughts:
>=20
> 1) extend the virtio-blk error codes
> 2) allow to configure the behaviour (report, ignore, stop) on error
> via config space or control vq
> 3) signal the error via config interrupt
>=20
> With all of the above, it may provide a virtio-blk that is fully
> compatible with what is provided by qemu. Considering its complexity,
> I wonder if we can start from something simple and build the features
> gradually. If I was not wrong, we can start by exposing something to
> make it work like vhost-(user)-blk. When all of those facilities were
> implemented in the spec, vhost-vDPA got those facilities as well. Then
> it looks to me it's sufficient to define:
>=20
> 1) STOP
> 2) indices state synchronization
> 3) inflight descriptors report (is this a must?)
>=20
> Or even 3) could be optional, to make things easier, having 1) and 2)
> makes it sufficient to migrate the networking devices. And we can do
> 3) on top?

I suggest:

1. STOP
2. vhost-style get_vring_base() to fetch last_avail_idx
3. Device state save/load

Under this model the driver can rewind the avail ring, but only back to
last_avail_idx. This gives the device the freedom to keep in-flight
requests like virtio-blk/scsi's failed requests list. Information about
those requests will be transferred as part of device state save/load.

This patch series just needs to define STOP. Rewinding descriptors
requires a new get_vring_base()-style operation while the device is in
the stopped state. This can be proposed separately. Device state
save/load can also be proposed separately.

Stefan

--4en+kRS1oKqfbtTI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmGolYQACgkQnKSrs4Gr
c8jmcQf+NRcOl1kjrK2HMpaWBXFl2qm+tkbDi/g0Yu4130zxJyzWL8QXmQmWponh
+ZzsZdzAfumBfCqpy/XFp1sJf9IxHCc40npLkC793BZBXvgn6vY18RNIzcsoEcJJ
gcRMqBFt8LiiUYS6T0YvlflNo+0X10bJF/MLLU8XjOQLvG0Ir1+bCGh1xv6BSbh+
iBt/gdTlBIrLjPM1oAMLDiXCUSkASD8wUuo5v+DEoipt1Kby2st+rpGy5k/qUqe9
ibnoV0EBbfI+K/q6gQoJYX5CpFhxOn0fhy/WppPPNR5aC3FIMSoy4D+6n83nRfCh
1EIURAWhG2uDbTGxP21Kpd6dw5jh6w==
=XwNJ
-----END PGP SIGNATURE-----

--4en+kRS1oKqfbtTI--

