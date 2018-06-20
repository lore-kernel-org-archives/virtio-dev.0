Return-Path: virtio-dev-return-4462-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 945F758191B0
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Jun 2018 08:42:34 -0700 (PDT)
Date: Wed, 20 Jun 2018 16:42:21 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180620154221.GC4714@stefanha-x1.localdomain>
References: <1470324277-19300-1-git-send-email-stefanha@redhat.com>
 <20180620061634-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ABTtc+pdwF7KHXCz"
Content-Disposition: inline
In-Reply-To: <20180620061634-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] [PATCH v7] vsock: add vsock device
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Christian Borntraeger <borntraeger@de.ibm.com>, Matt Benjamin <mbenjamin@redhat.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Ian Campbell <ian.campbell@docker.com>, Gerd Hoffmann <kraxel@redhat.com>, Asias He <asias.hejun@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--ABTtc+pdwF7KHXCz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 20, 2018 at 06:19:28AM +0300, Michael S. Tsirkin wrote:
> On Thu, Aug 04, 2016 at 04:24:37PM +0100, Stefan Hajnoczi wrote:
> > The virtio vsock device is a zero-configuration socket communications
> > device.  It is designed as a guest<->host management channel suitable
> > for communicating with guest agents.
> >=20
> > vsock is designed with the sockets API in mind and the driver is
> > typically implemented as an address family (at the same level as
> > AF_INET).  Applications written for the sockets API can be ported with
> > minimal changes (similar amount of effort as adding IPv6 support to an
> > IPv4 application).
> >=20
> > Unlike the existing console device, which is also used for guest<->host
> > communication, multiple clients can connect to a server at the same time
> > over vsock.  This limitation requires console-based users to arbitrate
> > access through a single client.  In vsock they can connect directly and
> > do not have to synchronize with each other.
> >=20
> > Unlike network devices, no configuration is necessary because the device
> > comes with its address in the configuration space.
> >=20
> > The vsock device was prototyped by Gerd Hoffmann and Asias He.  I picked
> > the code and design up from them.
> >=20
> > VIRTIO-151
> >=20
> > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > Cc: Asias He <asias.hejun@gmail.com>
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> It's been a while. Stefan, did the implementation change since then?
> If not shouldn't we vote on this?

I'll rebase and check it before sending the next revision.

Stefan

--ABTtc+pdwF7KHXCz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbKnXdAAoJEJykq7OBq3PIktcH/j1w+2YyVeYKQsXVugZu0u0X
apVKmHAp5a/ZnsXHttnQ8e3RkcC25J5shV4OcytWxzxZAPGs6J41PyCW5HUSlv7X
ai+FJmyI1tQ7gs55S6X9bY8qnvq8L5Osu8WWFgfybraRlobnuqkiJ4ig8wFfF1hG
j9bNrK5U5gy4TfTmP8fi6s0cvfLmPj/oEqDg03tLuWcbIDAhAR+GmUvyYA29753J
4NbFDxUzepaKd8hjHDWVkXT7PdoE+X8VMKxC5wpWWrhoBqb9QiDIUonmplh6bGGA
4+4bWLYSD3RmELXvXfbg7ACb42OCH+JSPbMgk0pNKeKJ8gE+vvco2mOsGDl6+MI=
=r+GT
-----END PGP SIGNATURE-----

--ABTtc+pdwF7KHXCz--
