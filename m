Return-Path: <virtio-dev-return-8629-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B09909865D2
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Sep 2021 09:12:10 +0000 (UTC)
Date: Thu, 2 Sep 2021 10:12:00 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <YTCVYHyjhdaAPAni@stefanha-x1.localdomain>
References: <87v94ldrqq.fsf@linaro.org>
 <alpine.DEB.2.21.2108041055390.9768@sstabellini-ThinkPad-T480s>
 <YRuSPT9075NuWRYS@stefanha-x1.localdomain>
 <875yvkh1p1.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <875yvkh1p1.fsf@linaro.org>
Subject: [virtio-dev] Re: Enabling hypervisor agnosticism for VirtIO backends
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wqq+Rojkn7jctvdi"
Content-Disposition: inline
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>, Stratos Mailing List <stratos-dev@op-lists.linaro.org>, virtio-dev@lists.oasis-open.org, Arnd Bergmann <arnd.bergmann@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Stefano Stabellini <stefano.stabellini@xilinx.com>, Jan Kiszka <jan.kiszka@siemens.com>, Carl van Schaik <cvanscha@qti.qualcomm.com>, pratikp@quicinc.com, Srivatsa Vaddagiri <vatsa@codeaurora.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Wei.Chen@arm.com, olekstysh@gmail.com, Oleksandr_Tyshchenko@epam.com, Bertrand.Marquis@arm.com, Artem_Mygaiev@epam.com, julien@xen.org, jgross@suse.com, paul@xen.org, xen-devel@lists.xen.org, Elena Afanasova <eafanasova@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--wqq+Rojkn7jctvdi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 01, 2021 at 01:53:34PM +0100, Alex Benn=E9e wrote:
>=20
> Stefan Hajnoczi <stefanha@redhat.com> writes:
>=20
> > [[PGP Signed Part:Undecided]]
> > On Wed, Aug 04, 2021 at 12:20:01PM -0700, Stefano Stabellini wrote:
> >> > Could we consider the kernel internally converting IOREQ messages fr=
om
> >> > the Xen hypervisor to eventfd events? Would this scale with other ke=
rnel
> >> > hypercall interfaces?
> >> >=20
> >> > So any thoughts on what directions are worth experimenting with?
> >> =20
> >> One option we should consider is for each backend to connect to Xen vi=
a
> >> the IOREQ interface. We could generalize the IOREQ interface and make =
it
> >> hypervisor agnostic. The interface is really trivial and easy to add.
> >> The only Xen-specific part is the notification mechanism, which is an
> >> event channel. If we replaced the event channel with something else th=
e
> >> interface would be generic. See:
> >> https://gitlab.com/xen-project/xen/-/blob/staging/xen/include/public/h=
vm/ioreq.h#L52
> >
> > There have been experiments with something kind of similar in KVM
> > recently (see struct ioregionfd_cmd):
> > https://lore.kernel.org/kvm/dad3d025bcf15ece11d9df0ff685e8ab0a4f2edd.16=
13828727.git.eafanasova@gmail.com/
>=20
> Reading the cover letter was very useful in showing how this provides a
> separate channel for signalling IO events to userspace instead of using
> the normal type-2 vmexit type event. I wonder how deeply tied the
> userspace facing side of this is to KVM? Could it provide a common FD
> type interface to IOREQ?

I wondered this too after reading Stefano's link to Xen's ioreq. They
seem to be quite similar. ioregionfd is closer to have PIO/MMIO vmexits
are handled in KVM while I guess ioreq is closer to how Xen handles
them, but those are small details.

It may be possible to use the ioreq struct instead of ioregionfd in KVM,
but I haven't checked each field.

> As I understand IOREQ this is currently a direct communication between
> userspace and the hypervisor using the existing Xen message bus. My
> worry would be that by adding knowledge of what the underlying
> hypervisor is we'd end up with excess complexity in the kernel. For one
> thing we certainly wouldn't want an API version dependency on the kernel
> to understand which version of the Xen hypervisor it was running on.
>=20
> >> There is also another problem. IOREQ is probably not be the only
> >> interface needed. Have a look at
> >> https://marc.info/?l=3Dxen-devel&m=3D162373754705233&w=3D2. Don't we a=
lso need
> >> an interface for the backend to inject interrupts into the frontend? A=
nd
> >> if the backend requires dynamic memory mappings of frontend pages, the=
n
> >> we would also need an interface to map/unmap domU pages.
> >>=20
> >> These interfaces are a lot more problematic than IOREQ: IOREQ is tiny
> >> and self-contained. It is easy to add anywhere. A new interface to
> >> inject interrupts or map pages is more difficult to manage because it
> >> would require changes scattered across the various emulators.
> >
> > Something like ioreq is indeed necessary to implement arbitrary devices=
,
> > but if you are willing to restrict yourself to VIRTIO then other
> > interfaces are possible too because the VIRTIO device model is differen=
t
> > from the general purpose x86 PIO/MMIO that Xen's ioreq seems to
> > support.
>=20
> It's true our focus is just VirtIO which does support alternative
> transport options however most implementations seem to be targeting
> virtio-mmio for it's relative simplicity and understood semantics
> (modulo a desire for MSI to reduce round trip latency handling
> signalling).

Okay.

Stefan

--wqq+Rojkn7jctvdi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmEwlWAACgkQnKSrs4Gr
c8iywwf/UbbZqAAwRx5aV+yxn3NfXRbvDky1X190RHTAps3WhO8yK2JbKJD8iKbQ
rshIvCjdE8gtVEBLo1T+73NCbrLFablTajILJ6OZXpKvUb2Q4xp2v2fowVz49ggv
07MKYC7J+AkIXEIxZ5vocByUaaF150FWIyU8Anb5GDLnF7BVFXF1mM0iqtgELgS7
0/UOVvjXSs63QNWRqIkGNuCsb9E7+cD9Rnn805nrwxi3A1Mr2qJXprgDHOIdc8DZ
GfH+4OCe2sfLjXDg8UD586JC81vR1MR/8XDS7Ojv1/WOwZFvcpboOHp/WBxaxOLU
1VbgmtZyWDa51CFJZBkzq+DRQe8aEw==
=LPa3
-----END PGP SIGNATURE-----

--wqq+Rojkn7jctvdi--

