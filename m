Return-Path: <virtio-comment-return-3431-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Mon, 5 Sep 2022 16:27:26 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <YxZbrmFlQZp6rR9E@fedora>
References: <877d61wuc0.fsf@linaro.org>
 <87r10svr77.fsf@alyssa.is>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="c7tEaSGzqf2OUO02"
Content-Disposition: inline
In-Reply-To: <87r10svr77.fsf@alyssa.is>
Subject: [virtio-comment] Re: [virtio-dev] Next VirtIO device for Project Stratos?
To: Alyssa Ross <hi@alyssa.is>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, stratos-dev@op-lists.linaro.org, virtio-dev@lists.oasis-open.org, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Viresh Kumar <viresh.kumar@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Mike Holmes <mike.holmes@linaro.org>, Matt Spencer <Matt.Spencer@arm.com>, Peter Griffin <peter.griffin@linaro.org>, Dan Milea <dan.milea@windriver.com>, Bill Mills <bill.mills@linaro.org>, Francois Ozog <francois.ozog@linaro.org>, Johannes Berg <johannes@sipsolutions.net>, Gerd Hoffmann <kraxel@redhat.com>, Arnd Bergmann <arnd.bergmann@linaro.org>, Christian Pinto <c.pinto@virtualopensystems.com>, Namhyung Kim <namhyung@kernel.org>, Petre Eftime <epetre@amazon.com>, Peter Hilber <peter.hilber@opensynergy.com>, Marcel Holtmann <marcel@holtmann.org>, "Michael S. Tsirkin" <mst@redhat.com>, Puck Meerburg <puck@puckipedia.com>, Gurchetan Singh <gurchetansingh@chromium.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--c7tEaSGzqf2OUO02
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 03, 2022 at 07:43:08AM +0000, Alyssa Ross wrote:
> Hi Alex and everyone else, just catching up on some mail and wanted to
> clarify some things:
>=20
> Alex Benn=E9e <alex.bennee@linaro.org> writes:
>=20
> > This email is driven by a brain storming session at a recent sprint
> > where we considered what VirtIO devices we should look at implementing
> > next. I ended up going through all the assigned device IDs hunting for
> > missing spec discussion and existing drivers so I'd welcome feedback
> > from anybody actively using them - especially as my suppositions about
> > device types I'm not familiar with may be way off!
> >
> > [...snip...]
> >
> > GPU device / 16
> > ---------------
> >
> > This is now a fairly mature part of the spec and has implementations is
> > the kernel, QEMU and a vhost-user backend. However as is commensurate
> > with the complexity of GPUs there is ongoing development moving from the
> > VirGL OpenGL encapsulation to a thing called GFXSTREAM which is meant to
> > make some things easier.
> >
> > A potential area of interest here is working out what the differences
> > are in use cases between virtio-gpu and virtio-wayland. virtio-wayland
> > is currently a ChromeOS only invention so hasn't seen any upstreaming or
> > specification work but may make more sense where multiple VMs are
> > drawing only elements of a final display which is composited by a master
> > program. For further reading see Alyssa's write-up:
> >
> >   https://alyssa.is/using-virtio-wl/
> >
> > I'm not sure how widely used the existing vhost-user backend is for
> > virtio-gpu but it could present an opportunity for a more beefy rust-vmm
> > backend implementation?
>=20
> As I understand it, virtio-wayland is effectively deprecated in favour
> of sending Wayland messages over cross-domain virtio-gpu contexts.  It's
> possible to do this now with an upstream kernel, whereas virtio-wayland
> always required a custom driver in the Chromium kernel.
>=20
> But crosvm is still the only implementation of a virtio-gpu device that
> supports Wayland over cross-domain contexts, so it would be great to see
> a more generic implementation.  Especially because, while crosvm can
> share its virtio-gpu device over vhost-user, it does so in a way that's
> incompatible with the standardised vhost-user-gpu as implemented by
> QEMU.  When I asked the crosvm developers in their Matrix channel what
> it would take to use the standard vhost-user-gpu variant, they said that
> the standard variant was lacking functionality they needed, like mapping
> and unmapping GPU buffers into the guest.

That sounds somewhat similar to virtiofs and its DAX Window, which needs
vhost-user protocol extensions because of how memory is handled. David
Gilbert wrote the QEMU virtiofs DAX patches, which are under
development.

I took a quick look at the virtio-gpu specs. If the crosvm behavior you
mentioned is covered in the VIRTIO spec then I guess it's the "host
visible memory region"?

(If it's not in the VIRTIO spec then a spec change needs to be proposed
first and a vhost-user protocol spec change can then support that new
virtio-gpu feature.)

The VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB command maps the device's resource
into the host visible memory region so that the driver can see it.

The virtiofs DAX window uses vhost-user slave channel messages to
provide file descriptors and offsets for QEMU to mmap. QEMU mmaps the
file pages into the shared memory region seen by the guest driver.

Maybe an equivalent mechanism is needed for virtio-gpu so a device
resource file descriptor can be passed to QEMU and then mmapped so the
guest driver can see the pages?

I think it's possible to unify the virtiofs and virtio-gpu extensions to
the vhost-user protocol. Two new slave channel messages are needed: "map
<fd, offset, len> to shared memory resource <n>" and "unmap <offset,
 len> from shared memory resource <n>". Both devices could use these
messages to implement their respective DAX Window and Blob Resource
functionality.

>=20
> So if we wanted to push forward with getting making Wayland over
> virttio-gpu less crosvm specific, I suppose the first step would be to
> figure out with the crosvm developers what functionality is missing in
> the vhost-user-gpu protocol.  That would then make it possible to use
> crosvm's device (with the Wayland support) with other VMMs like QEMU.
>=20
> (CCing my colleage Puck, who has also been working with me on getting
> Wayland over virtio-gpu up and running outside of Chrome OS.)

I have CCed David Gilbert (virtiofs DAX Window) and Gurchetan Singh
(virtio-gpu shared memory region).

Stefan

--c7tEaSGzqf2OUO02
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmMWW64ACgkQnKSrs4Gr
c8jbhggAwvf/cj/7058cHv0YvQUO4vRzTqXEx3aP1nWS1eTp0iZbXVa2PmB2fzDx
Eo1INezrXfHP1Lky5z+DZiIVaBKurDDo2kHYj5VyHpzvw9qap/w+A3OArTghTXj6
vEfDUafsRJUt44xgLTRVN+feUZKOx9xsnCCYFCeqhIgyltwjjn9WIg3WsXExrPgJ
iqhMXztG5H+EE42EOv5ilEIcAJb9NN7rrmGrGt7fHs0BH2KFID4XaKU0bdCDdFVD
61pZdc0lZC4dns+6xh4NbKhikR+TZsrq61/ENcVIGZwhtxnaI4xAs3kGOka3drwI
6bxzAhIETL95aTpgr2EXC/UrixA13Q==
=iIK1
-----END PGP SIGNATURE-----

--c7tEaSGzqf2OUO02--

