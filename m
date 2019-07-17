Return-Path: virtio-dev-return-5861-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D951E985C86
	for <virtio-dev@lists.oasis-open.org>; Wed, 17 Jul 2019 10:48:45 +0000 (UTC)
Date: Wed, 17 Jul 2019 11:48:40 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190717104840.GF7341@stefanha-x1.localdomain>
References: <20190220124613.22661-1-stefanha@redhat.com>
 <20190220124613.22661-3-stefanha@redhat.com>
 <20190618213147-mutt-send-email-mst@kernel.org>
 <20190624135808.GC3833@stefanha-x1.localdomain>
 <20190624100448-mutt-send-email-mst@kernel.org>
 <20190625095515.GG3226@work-vm>
 <20190627100346-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aZoGpuMECXJckB41"
Content-Disposition: inline
In-Reply-To: <20190627100346-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] [PATCH v3 2/2] virtio-fs: add DAX window
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-dev@lists.oasis-open.org, Miklos Szeredi <mszeredi@redhat.com>, Sage Weil <sweil@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--aZoGpuMECXJckB41
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2019 at 10:09:16AM -0400, Michael S. Tsirkin wrote:
> On Tue, Jun 25, 2019 at 10:55:15AM +0100, Dr. David Alan Gilbert wrote:
> > * Michael S. Tsirkin (mst@redhat.com) wrote:
> > > On Mon, Jun 24, 2019 at 02:58:08PM +0100, Stefan Hajnoczi wrote:
> > > > On Tue, Jun 18, 2019 at 09:41:25PM -0400, Michael S. Tsirkin wrote:
> > > > > On Wed, Feb 20, 2019 at 12:46:13PM +0000, Stefan Hajnoczi wrote:
> > > > > > +
> > > > > > +\devicenormative{\paragraph}{Device Operation: DAX Window}{Dev=
ice Types / File System Device / Device Operation / Device Operation: DAX W=
indow}
> > > > > > +
> > > > > > +The device MUST allow mappings that completely or partially ov=
erlap existing mappings within the DAX window.
> > > > >=20
> > > > >=20
> > > > > Any alignment requirements?
> > > >=20
> > > > Good point.  There are alignment requirements and the driver has no=
 way
> > > > of knowing what they are.  I'll find a way to communicate them into=
 the
> > > > guest, either via virtio or via FUSE.
> > > >=20
> > > > > Also, with no limit on mappings, it looks like guest can use up l=
ots of
> > > > > host VMAs quickly. Shouldn't there be a limit on # of mappings?
> > > >=20
> > > > The VM can only deteriorate its own performance, right?
> > >=20
> > > Only if QEMU is put in a container where virtual memory is
> > > limited.
> > > It's generally not a good idea where the only way for
> > > host to make progress is to allocate more memory
> > > without any limit.
> > >=20
> > > If we are in a situation where we need to either kill
> > > the guest or hit swap, none of the choices is good.
> >=20
> > There is a bound; it's cache region size / page size - so
> > that's ~1M mappings worst case (e.g. 4GB cache, 4kB page size)
> > That limit can be bought down if we impose a larger granularity
> > somewhere (and the reality is our kernel uses 2MB mapping chunks I
> > think).
> >=20
> > > > We haven't seen catastrophic problems that bring the system to it's
> > > > knees.
> > >=20
> > > Because you are not running malicious guests?
> >=20
> > Hmm, I didn't realise a process having an excessive number of mappings
> > could harm any other process.
> >=20
> > Dave
>=20
> Well it allocates resources on the host. If you don't
> contain qemu then even just allocating virtual memory
> can make host swap, right? If you contain it then
> qemu will get killed instead but then you need to tell
> guest what not to do so as not to get qemu killed.

I investigated a little.  Linux has a maximum VMA count sysctl that is
affected by mmap and any other places that add/split VMAs:

  vm.max_map_count =3D 65530

This is a sysctl tunable and is kept below 65536 for legacy reasons.
ELF coredumps used to only support ~65536 sections.

The QEMU process needs its own VMAs for shared libraries and other
purposes, so each virtio-fs device should expose a significantly lower
DAX Window mapping limit to the driver.  Let's add a configuration space
field as Michael has suggested.

Regarding denial of service, the DAX Window size determines the overall
amount of host page cache that is accessible by the driver.  Together
with an enforced maximum map count we can allow the administrator to
configure devices so they only provide access to a fraction of the host
page cache, mitigating denial of service issues.

Stefan

--aZoGpuMECXJckB41
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0u/QgACgkQnKSrs4Gr
c8ge4AgAvpEku+f+4H0i7z5A7Y3Va+Q/j/nYYCREEXUfTHD1ieUsU09nkdaskmiO
IeRPnBuTk/unaRjkBJijdW4rC9xC/SuBYYY7kxvaGtUGDsNnPQeTLYt8HeuDaazg
N4SiQPUr4SlX62QD+l5Z5bVq2C2yzK59YeF7QA4idDURRjsdbkOD94ZOREv9Z9OK
m/iv/X+h5dy6z3n5H7/av7XECLClzLswxP55vWbl3KPsOR02Dxqm2P/YhgzpU99M
8Qde4r3IPTRKrhLUPcrsLhOjGGDcFpVLkzv6qc6J/+A1EAQxmyt+p044lGo+IeWa
esWAjVnEhXEW9+7MLGUi9C6cYDRiig==
=Rogr
-----END PGP SIGNATURE-----

--aZoGpuMECXJckB41--
