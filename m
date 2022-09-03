Return-Path: <virtio-dev-return-9884-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
From: Alyssa Ross <hi@alyssa.is>
In-Reply-To: <877d61wuc0.fsf@linaro.org>
References: <877d61wuc0.fsf@linaro.org>
Date: Sat, 03 Sep 2022 07:43:08 +0000
Message-ID: <87r10svr77.fsf@alyssa.is>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Subject: Re: [virtio-dev] Next VirtIO device for Project Stratos?
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, stratos-dev@op-lists.linaro.org, virtio-dev@lists.oasis-open.org, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Mike Holmes <mike.holmes@linaro.org>, Matt Spencer <Matt.Spencer@arm.com>, Peter Griffin <peter.griffin@linaro.org>, Dan Milea <dan.milea@windriver.com>, Bill Mills <bill.mills@linaro.org>, Francois Ozog <francois.ozog@linaro.org>, Johannes Berg <johannes@sipsolutions.net>, Gerd Hoffmann <kraxel@redhat.com>, Arnd Bergmann <arnd.bergmann@linaro.org>, Christian Pinto <c.pinto@virtualopensystems.com>, Namhyung Kim <namhyung@kernel.org>, Petre Eftime <epetre@amazon.com>, Peter Hilber <peter.hilber@opensynergy.com>, Marcel Holtmann <marcel@holtmann.org>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Puck Meerburg <puck@puckipedia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Alex and everyone else, just catching up on some mail and wanted to
clarify some things:

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> This email is driven by a brain storming session at a recent sprint
> where we considered what VirtIO devices we should look at implementing
> next. I ended up going through all the assigned device IDs hunting for
> missing spec discussion and existing drivers so I'd welcome feedback
> from anybody actively using them - especially as my suppositions about
> device types I'm not familiar with may be way off!
>
> [...snip...]
>
> GPU device / 16
> ---------------
>
> This is now a fairly mature part of the spec and has implementations is
> the kernel, QEMU and a vhost-user backend. However as is commensurate
> with the complexity of GPUs there is ongoing development moving from the
> VirGL OpenGL encapsulation to a thing called GFXSTREAM which is meant to
> make some things easier.
>
> A potential area of interest here is working out what the differences
> are in use cases between virtio-gpu and virtio-wayland. virtio-wayland
> is currently a ChromeOS only invention so hasn't seen any upstreaming or
> specification work but may make more sense where multiple VMs are
> drawing only elements of a final display which is composited by a master
> program. For further reading see Alyssa's write-up:
>
>   https://alyssa.is/using-virtio-wl/
>
> I'm not sure how widely used the existing vhost-user backend is for
> virtio-gpu but it could present an opportunity for a more beefy rust-vmm
> backend implementation?

As I understand it, virtio-wayland is effectively deprecated in favour
of sending Wayland messages over cross-domain virtio-gpu contexts.  It's
possible to do this now with an upstream kernel, whereas virtio-wayland
always required a custom driver in the Chromium kernel.

But crosvm is still the only implementation of a virtio-gpu device that
supports Wayland over cross-domain contexts, so it would be great to see
a more generic implementation.  Especially because, while crosvm can
share its virtio-gpu device over vhost-user, it does so in a way that's
incompatible with the standardised vhost-user-gpu as implemented by
QEMU.  When I asked the crosvm developers in their Matrix channel what
it would take to use the standard vhost-user-gpu variant, they said that
the standard variant was lacking functionality they needed, like mapping
and unmapping GPU buffers into the guest.

So if we wanted to push forward with getting making Wayland over
virttio-gpu less crosvm specific, I suppose the first step would be to
figure out with the crosvm developers what functionality is missing in
the vhost-user-gpu protocol.  That would then make it possible to use
crosvm's device (with the Wayland support) with other VMMs like QEMU.

(CCing my colleage Puck, who has also been working with me on getting
Wayland over virtio-gpu up and running outside of Chrome OS.)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmMTBY4ACgkQ+dvtSFmy
ccB34w/9F/Z/38E7I8IOQF5j9KwZCp05tvkNo2eDvtGBLP/MAccWsa1ONNgVwdcl
+d7l1hnp0jmsyJ5nX3Z+6CDVvFO5ZuEZiLUA4dtJPvPDLZAqSIpiXSq4cYkQOfKe
R/NV+PA73rA2oIqQdM7znipJLVuCJV7j5sXXgCjks80XXBdbDzDgFBPreElyZCsO
w2+Vrk+AODbuwYrJbMR1Hj9qzLVtTXnZI7i5P8e4b4/8U67UznBan62NBFqe680n
Ne5/gGSOpbc2aGwlR9NbP1cZnlxsicPwdFRjs1HnSzLLPcZpIQmlajgscP+kAu/p
pll/ka/vUPjML9VYEi0I1ph0GxbObWSsGhXrhtIUm2zIXV+QwcxUoNXr/FM3ojkJ
gXfdWP2Pv3WXEHud/7qXW5MCHipZgrybkUZv7oSsGq3FCZ1syhW9+P2vtvYiD/Kv
VtSQlvMT41rtQK3H0AgwtLpHfKTW95w+67CBSGua7t1CvvGnDqngniZOmA1FsE5d
U4kW1AIOQGiWllmcpkY67B4gUDU2Do7KOuPQTuLoL1BZgZhwByz8qQk0T68o7gAn
3/S9t0fj/fq44wlPRW2uAQLAUS5DGmeckcYtSC2Xo5F+AwDzypzdpACySoyw0Hzl
8PLqG/bXhW6zDEDK95uT4mN4NZvrmv1CFqApnFFdsB7Q/UvKjLI=
=66r7
-----END PGP SIGNATURE-----
--=-=-=--

