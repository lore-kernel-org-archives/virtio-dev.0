Return-Path: virtio-dev-return-5940-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C40BD984399
	for <virtio-dev@lists.oasis-open.org>; Mon, 12 Aug 2019 13:55:17 +0000 (UTC)
Date: Mon, 12 Aug 2019 14:55:08 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190812135508.GJ9959@stefanha-x1.localdomain>
References: <20190726095338.24991-1-stefanha@redhat.com>
 <20190726095338.24991-3-stefanha@redhat.com>
 <20190726074048-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VIOdPewhitSMo36n"
Content-Disposition: inline
In-Reply-To: <20190726074048-mutt-send-email-mst@kernel.org>
Subject: [virtio-dev] Re: [PATCH v5 2/2] virtio-fs: add DAX window
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Sage Weil <sweil@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--VIOdPewhitSMo36n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2019 at 07:41:57AM -0400, Michael S. Tsirkin wrote:
> On Fri, Jul 26, 2019 at 10:53:38AM +0100, Stefan Hajnoczi wrote:
> > Describe how shared memory region ID 0 is the DAX window and how
> > FUSE_SETUPMAPPING maps file ranges into the window.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
>=20
> Are there any security considerations with this memory sharing?
> If yes it might be a good idea to add a chapter about that,
> and functionality/performance/security tradeoffs involved.

I'll add statements about security.  In light of recent security attacks
we should mention timing side-channel attacks, although the general
security model is that each virtio-fs client has full access to the
files in the shared directory and therefore a certain level of trust is
already required since race conditions and data corruption are possible
anyway.

Stefan

--VIOdPewhitSMo36n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1Rb7wACgkQnKSrs4Gr
c8gB3AgAiqaFhxMfnaQJ8U+tzPAV7HVDLJnEuKJljsm1Kqt6rnqpYopDT4NLd3KJ
hprlvazRGgcM1v+pHVfveuNkML+YJtghq9UUfQM05d6/zkdtNZIYT3rmQ0Ggk757
YYJVvrq49bd265b243niCCFzxMIkg5+V8eUjIKXAt5/R0PV1Stfg6A9vsvR0VA14
5dhraR4ifQM6inn+Vszf6SRecsENcoJvPV48st9gM1k4kVJrLSAWsPeWQ5lm/2bf
/Tpf3nWCb0QO4RInSM0TGmJTjTvxg8qxXl4XbB3zjcNZSvLtICZVkvSWa9SkMKah
nVGsW9mxitqCcpv56uWwnLgucC4eAQ==
=K2IL
-----END PGP SIGNATURE-----

--VIOdPewhitSMo36n--
