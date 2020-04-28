Return-Path: virtio-dev-return-7194-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6BBD5985E1A
	for <virtio-dev@lists.oasis-open.org>; Tue, 28 Apr 2020 08:57:54 +0000 (UTC)
Date: Tue, 28 Apr 2020 09:57:43 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20200428085743.GC15547@stefanha-x1.localdomain>
References: <CAD90VcYAXhRdBhLtuj9wETyTd0kT-o5s6DE31DxN6KENBuDKgQ@mail.gmail.com>
 <20200417094122.GB9261@stefanha-x1.localdomain>
 <CAD90VcYJ1K7jktTJBp=m=aw83AeQ5U0Lcjo2coqE7XFFNHtWKQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAD90VcYJ1K7jktTJBp=m=aw83AeQ5U0Lcjo2coqE7XFFNHtWKQ@mail.gmail.com>
Subject: Re: [virtio-dev] Preferred layout for request/response structs
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TiqCXmo5T1hvSQQg"
Content-Disposition: inline
To: Keiichi Watanabe <keiichiw@chromium.org>
Cc: virtio-dev@lists.oasis-open.org, Alexandre Courbot <acourbot@chromium.org>, Tomasz Figa <tfiga@chromium.org>, Pawel Osciak <posciak@chromium.org>, Alex Lau <alexlau@chromium.org>, David Stevens <stevensd@chromium.org>, Enrico Granata <egranata@google.com>, Dmitry Sepp <dmitry.sepp@opensynergy.com>, Gerd Hoffmann <kraxel@redhat.com>, Chirantan Ekbote <chirantan@chromium.org>, Matti =?iso-8859-1?Q?M=F6ll?= <matti.moell@opensynergy.com>, Samiullah Khawaja <samiullah.khawaja@opensynergy.com>, Kiran Pawar <kiran.pawar@opensynergy.com>, Lingfeng Yang <lfy@google.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2020 at 09:30:30PM +0900, Keiichi Watanabe wrote:
> Hi Stefan,
>=20
> Thank you for your advice!
>=20
> Your comments totally make sense. We should keep structs simple and I
> should have thought the spec and implementation separately.
> tl;dr: I feel comfortable with the following design after rethinking:
>=20
> struct virtio_video_resource_queue {
>   le32 virtio_video_cmd_type type; /* Must be an enum variant
> VIRTIO_VIDEO_CMD_TYPE_RESOURCE_QUEUE */
>   le32 queue_type;
>   ...
> };
> struct virtio_video_resource_queue_resp {
>   le32 virtio_video_resp_type type; /* Must be an enum variant that
> represents the result of the command; Success or error type */
>   ...
> };
>=20
> Regarding the decoding problem in a device, we should define another
> set of structs when implementing the device if it is needed.
> Let me reply to your comments inline and explain the reason of my thought=
.

This and your replies to my comments sounds good.  Thanks!

Stefan

--TiqCXmo5T1hvSQQg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6n8AcACgkQnKSrs4Gr
c8jhGwf/RAD+C1jmedsEl9Rhq+rnEs6lW8PAqjnmRFYF9fYAXHuKef3Vn3rT63zs
lh07YA5ZZEmVQMwDANqkPmz7ZS1lN7Eqi6m1R4HqfyyQYLevhrYbvezfJKBL3KoG
GQ9IpdAfOnBm7u2GTuBw3oidMb2NzxgWgYPtSbhzlNNlv2h9YXhAdDWVdvwvQc50
CT3+Yfp53MD0D2C/cH+o+mnXYEun3fQy9vuiqzxvyZa2nAD9dZHXcilg9KVxREue
C3vK1TVbkhjuNJUvoWagtTzlDwovGoOiBYmTCuZEuJeiXF8eNx6wxHc6iPDNCm4h
oABGBvnRk8l8x54hyah/+8Ba0Ue/FQ==
=LHWG
-----END PGP SIGNATURE-----

--TiqCXmo5T1hvSQQg--

