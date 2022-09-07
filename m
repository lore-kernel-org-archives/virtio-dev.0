Return-Path: <virtio-dev-return-9916-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7EDDF986538
	for <virtio-dev@lists.oasis-open.org>; Wed,  7 Sep 2022 17:15:50 +0000 (UTC)
Date: Wed, 7 Sep 2022 13:15:41 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <YxjRvZr6alY6OkPb@fedora>
References: <877d61wuc0.fsf@linaro.org>
 <87r10svr77.fsf@alyssa.is>
 <YxZbrmFlQZp6rR9E@fedora>
 <YxeEcN+k5fUGt/Yq@work-vm>
 <YxeNkJJwJMsBURXI@fedora>
 <YximF3/B3cgiQzYx@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7wlpPLYkSQR7nCmu"
Content-Disposition: inline
In-Reply-To: <YximF3/B3cgiQzYx@work-vm>
Subject: Re: [virtio-dev] Next VirtIO device for Project Stratos?
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Alyssa Ross <hi@alyssa.is>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, stratos-dev@op-lists.linaro.org, virtio-dev@lists.oasis-open.org, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Viresh Kumar <viresh.kumar@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Mike Holmes <mike.holmes@linaro.org>, Matt Spencer <Matt.Spencer@arm.com>, Peter Griffin <peter.griffin@linaro.org>, Dan Milea <dan.milea@windriver.com>, Bill Mills <bill.mills@linaro.org>, Francois Ozog <francois.ozog@linaro.org>, Johannes Berg <johannes@sipsolutions.net>, Gerd Hoffmann <kraxel@redhat.com>, Arnd Bergmann <arnd.bergmann@linaro.org>, Christian Pinto <c.pinto@virtualopensystems.com>, Namhyung Kim <namhyung@kernel.org>, Petre Eftime <epetre@amazon.com>, Peter Hilber <peter.hilber@opensynergy.com>, Marcel Holtmann <marcel@holtmann.org>, "Michael S. Tsirkin" <mst@redhat.com>, Puck Meerburg <puck@puckipedia.com>, Gurchetan Singh <gurchetansingh@chromium.org>
List-ID: <virtio-dev.lists.oasis-open.org>

--7wlpPLYkSQR7nCmu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 07, 2022 at 03:09:27PM +0100, Dr. David Alan Gilbert wrote:
> * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > On Tue, Sep 06, 2022 at 06:33:36PM +0100, Dr. David Alan Gilbert wrote:
> > > * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > > > On Sat, Sep 03, 2022 at 07:43:08AM +0000, Alyssa Ross wrote:
> > > > > Hi Alex and everyone else, just catching up on some mail and want=
ed to
> > > > > clarify some things:
> > > > >=20
> > > > > Alex Benn=E9e <alex.bennee@linaro.org> writes:
> > > > >=20
> > > > > > This email is driven by a brain storming session at a recent sp=
rint
> > > > > > where we considered what VirtIO devices we should look at imple=
menting
> > > > > > next. I ended up going through all the assigned device IDs hunt=
ing for
> > > > > > missing spec discussion and existing drivers so I'd welcome fee=
dback
> > > > > > from anybody actively using them - especially as my supposition=
s about
> > > > > > device types I'm not familiar with may be way off!
> > > > > >
> > > > > > [...snip...]
> > > > > >
> > > > > > GPU device / 16
> > > > > > ---------------
> > > > > >
> > > > > > This is now a fairly mature part of the spec and has implementa=
tions is
> > > > > > the kernel, QEMU and a vhost-user backend. However as is commen=
surate
> > > > > > with the complexity of GPUs there is ongoing development moving=
 from the
> > > > > > VirGL OpenGL encapsulation to a thing called GFXSTREAM which is=
 meant to
> > > > > > make some things easier.
> > > > > >
> > > > > > A potential area of interest here is working out what the diffe=
rences
> > > > > > are in use cases between virtio-gpu and virtio-wayland. virtio-=
wayland
> > > > > > is currently a ChromeOS only invention so hasn't seen any upstr=
eaming or
> > > > > > specification work but may make more sense where multiple VMs a=
re
> > > > > > drawing only elements of a final display which is composited by=
 a master
> > > > > > program. For further reading see Alyssa's write-up:
> > > > > >
> > > > > >   https://alyssa.is/using-virtio-wl/
> > > > > >
> > > > > > I'm not sure how widely used the existing vhost-user backend is=
 for
> > > > > > virtio-gpu but it could present an opportunity for a more beefy=
 rust-vmm
> > > > > > backend implementation?
> > > > >=20
> > > > > As I understand it, virtio-wayland is effectively deprecated in f=
avour
> > > > > of sending Wayland messages over cross-domain virtio-gpu contexts=
=2E  It's
> > > > > possible to do this now with an upstream kernel, whereas virtio-w=
ayland
> > > > > always required a custom driver in the Chromium kernel.
> > > > >=20
> > > > > But crosvm is still the only implementation of a virtio-gpu devic=
e that
> > > > > supports Wayland over cross-domain contexts, so it would be great=
 to see
> > > > > a more generic implementation.  Especially because, while crosvm =
can
> > > > > share its virtio-gpu device over vhost-user, it does so in a way =
that's
> > > > > incompatible with the standardised vhost-user-gpu as implemented =
by
> > > > > QEMU.  When I asked the crosvm developers in their Matrix channel=
 what
> > > > > it would take to use the standard vhost-user-gpu variant, they sa=
id that
> > > > > the standard variant was lacking functionality they needed, like =
mapping
> > > > > and unmapping GPU buffers into the guest.
> > > >=20
> > > > That sounds somewhat similar to virtiofs and its DAX Window, which =
needs
> > > > vhost-user protocol extensions because of how memory is handled. Da=
vid
> > > > Gilbert wrote the QEMU virtiofs DAX patches, which are under
> > > > development.
> > > >=20
> > > > I took a quick look at the virtio-gpu specs. If the crosvm behavior=
 you
> > > > mentioned is covered in the VIRTIO spec then I guess it's the "host
> > > > visible memory region"?
> > > >=20
> > > > (If it's not in the VIRTIO spec then a spec change needs to be prop=
osed
> > > > first and a vhost-user protocol spec change can then support that n=
ew
> > > > virtio-gpu feature.)
> > > >=20
> > > > The VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB command maps the device's reso=
urce
> > > > into the host visible memory region so that the driver can see it.
> > > >=20
> > > > The virtiofs DAX window uses vhost-user slave channel messages to
> > > > provide file descriptors and offsets for QEMU to mmap. QEMU mmaps t=
he
> > > > file pages into the shared memory region seen by the guest driver.
> > > >=20
> > > > Maybe an equivalent mechanism is needed for virtio-gpu so a device
> > > > resource file descriptor can be passed to QEMU and then mmapped so =
the
> > > > guest driver can see the pages?
> > > >=20
> > > > I think it's possible to unify the virtiofs and virtio-gpu extensio=
ns to
> > > > the vhost-user protocol. Two new slave channel messages are needed:=
 "map
> > > > <fd, offset, len> to shared memory resource <n>" and "unmap <offset,
> > > >  len> from shared memory resource <n>". Both devices could use these
> > > > messages to implement their respective DAX Window and Blob Resource
> > > > functionality.
> > >=20
> > > It might be possible; but there's a bunch of lifetime/alignment/etc
> > > questions to be answered.
> > >=20
> > > For virtiofs DAX we carve out a chunk of a BAR as a 'cache' (unfortun=
ate
> > > name) that we can then do mappings into.
> > >=20
> > > The VHOST_USER_SLAVE_FS_MAP/UNMAP commands can do the mapping:
> > > https://gitlab.com/virtio-fs/qemu/-/commit/7c29854da484afd7ca95acbd2e=
4acfc2c75ef491
> > > https://gitlab.com/virtio-fs/qemu/-/commit/f32bc2524035931856aa218ce1=
8efa029b9eed02
> > >=20
> > > those might do what you want if you can figure out a way to generalise
> > > the bar to map them into.
> > >=20
> > > There are some problems; KVM gets really really upset if you try and
> > > access an area that doesn't have a mapping or is mapped to a truncated
> > > file;  do you want the guest to be able to crash like that?
> >=20
> > I think you are pointing out the existing problems with virtiofs
> > map/unmap and not new issues related to virtio-gpu or generalizing the
> > vhost-user messages?
> >=20
>=20
> Right, although what I don't have a feel of here is the semantics of the
> things that are being mapped in the GPU case, and what possibility that
> the driver mapping them has to pick some bad offset.

I don't know either. I hope Gurchetan or Gerd can explain how the
virtio-gpu Shared Memory Region is used and whether accesses to unmapped
portions of the region are expected.

Stefan

--7wlpPLYkSQR7nCmu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmMY0b0ACgkQnKSrs4Gr
c8hH2wf4od2Dndo2RY552zppe3HgyTZLbDBUojUpwUn5BV8C9N9pKDHGHPahXF1y
jL3A5FGMxOnd7OUBJb0/dEUEV45LBxGq79yNWHaCHMegTZnbyAcmgFCuHmv+Vk7D
a6TtOe6Au+ybLyCgK3H5H5FAWIqdmJ+f/sWjvZGjU4ImKabRM75NNisDhmJ7sshQ
qCVwRyaeE59vvP/GQiUooMMxCtMxbt0/2E39QZwBfsCpTs/ebZXLGgWp568OPix3
ZqBSvE3amYE08vG/Uulr8J9Hw+JjYJR1tLmc8nrsL7en9Ej8dKhx9ipPKU491fp3
FeRoMr4vp6nB3N0UkUZzt2gN0+OX
=DyDw
-----END PGP SIGNATURE-----

--7wlpPLYkSQR7nCmu--

