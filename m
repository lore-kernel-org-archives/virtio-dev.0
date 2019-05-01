Return-Path: virtio-dev-return-5714-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B64F79875CD
	for <virtio-dev@lists.oasis-open.org>; Fri,  3 May 2019 18:09:38 +0000 (UTC)
Date: Wed, 1 May 2019 13:05:25 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190501170525.GB22391@stefanha-x1.localdomain>
References: <abe4bd97-8010-8fd0-8ded-f9e847a4fdb3@13byte.com>
 <20190429134754.GI7587@stefanha-x1.localdomain>
 <4fcd7456-de22-7f6d-d5ef-939cd3d7cf95@13byte.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Content-Disposition: inline
In-Reply-To: <4fcd7456-de22-7f6d-d5ef-939cd3d7cf95@13byte.com>
Subject: Re: [virtio-dev] Request for a new device number for a virtio-audio
 device.
To: Marco Martinelli - 13Byte srl <marco@13byte.com>
Cc: virtio-dev@lists.oasis-open.org, kraxel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2019 at 07:39:17PM +0200, Marco Martinelli - 13Byte srl wro=
te:
> Il 29/04/19 15:47, Stefan Hajnoczi ha scritto:
> > On Mon, Apr 29, 2019 at 12:22:41AM +0200, Marco Martinelli - 13Byte srl=
 wrote:
> > > I'm not sure how this works, is that number already assigned and I sh=
ould
> > > use that or should I get a new one?
> > >=20
> > > For last, I have a question to clear the things up for me. It is my
> > > understanding that in this mailing list you discuss about the
> > > specifications, not the actual code. What's the usual process when wr=
iting a
> > > new virtio device?
> > > Should I start with writing the code and then document how it works o=
r is it
> > > the opposite? Should I document it and have it approved and then impl=
ement
> > > the specifications?
> > >=20
> > > I know that this may sound like a stupid question, but please be pati=
ent
> > > with me, it's my first time.
> > I suggest posting a draft specification for the new device type before
> > investing too much time in the implementation.
> >=20
> > Then work on the code while the spec discussion is ongoing.  This way
> > you won't have to wait too long before implementation but you also won't
> > find that reviewers are asking for large changes after you completed
> > your work.
> I feared that would be the answer.
> As I stated I'm not familiar with most of the technologies involved. I do=
n't
> know if I have the capabilities to write a draft of the specifications
> without first working on some code to clear things up.
> I'll try my best.

I'm happy to help you get started.

I have a basic understanding of sound cards (mostly from an audio API
and application perspective) and can explain the virtio device model.

Please post the requirements and scope of the device you'd like to
create.  Are you thinking of something general-purpose like the USB
Audio Device Class specification, which can handle many different types
of devices.  Or were you thinking of something more limited?

In terms of virtio concepts, audio streams would be transferred in
chunks over virtqueues.  A "control" virtqueue might be necessary to
configure the device.  It would process configuration request/response
packets.

Stefan

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzJ0cIACgkQnKSrs4Gr
c8jC6Af+N0Ry9gHP+QwroJEKZIBhzHObT9pLW2oslPKBRY07g+cWLxy4QpTCd0D8
5VVIzupvLwb5NHbLyPtIP8Vy/sl3R2+JfLHEUtggoVTf1eT0ox0rXvJxMAyGcBd+
FGQd12qjyZh3keACcYfguoRi2KV3CEC4viT+rWpaiuUeqbHUE+jjTTk3n60obAWD
cwQxUHWhZzpbmAdjoMWdYXq9pMPo3Ob+2cGnbDDMGh5NPUgfZlji8KQZ9qi+cIQu
pOpeuIqM0usDS7MOGMXhVQA6RTu1fxbykt7HQYvIiLsmZb+bxCLMRL9+gK7fjjqQ
AtFh1lJjHH6JuCaJ+U/tw9z6gecO3w==
=Shc8
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--
