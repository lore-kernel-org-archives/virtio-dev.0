Return-Path: <virtio-dev-return-9249-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8137B98661B
	for <virtio-dev@lists.oasis-open.org>; Thu,  3 Feb 2022 10:36:18 +0000 (UTC)
Date: Thu, 3 Feb 2022 10:36:10 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <YfuwGoRY6LkEOTCp@stefanha-x1.localdomain>
References: <CAOGAQerz6dM+ZStRUiFaSmYCQJsbpij5=S+OU=Ck+bbUKOR+Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="O9/EMo4Ga6BbmRHR"
Content-Disposition: inline
In-Reply-To: <CAOGAQerz6dM+ZStRUiFaSmYCQJsbpij5=S+OU=Ck+bbUKOR+Pw@mail.gmail.com>
Subject: Re: [virtio-dev] virtio-snd spec question
To: Roman Kiryanov <rkir@google.com>
Cc: virtio-dev@lists.oasis-open.org, Anton Yakovlev <anton.yakovlev@opensynergy.com>, chouhan.shreyansh2702@gmail.com
List-ID: <virtio-dev.lists.oasis-open.org>

--O9/EMo4Ga6BbmRHR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 01, 2022 at 03:57:10PM -0800, Roman Kiryanov wrote:
> Hello,
>=20
> I work in Android Studio Emulator and I am currently implementing a
> virtio-snd device. We found a spec draft here:
>=20
> https://github.com/oasis-tcs/virtio-spec/commit/e73c8cdf3e822fd83c26c6de9=
64a947670f93cc3#diff-73045e70aeaf45f93087610437b705e2d320c82a9d29b4027721f5=
f5f3918dc5
>=20
> It mentions four virtqueues: ctl, event, rx and tx. It is not very clear
> where a virtio-snd device should put responses to the ctl requests from t=
he
> linux kernel driver. There is a kernel driver implementation and we have a
> virtio-snd device implemented in another emulator, it uses the same
> virtqueue (ctl) to put ctl responses and the current kernel driver seems
> happy with this.
>=20
> Do you know if this is expected behavior? I am far from an expert here, b=
ut
> I believe the device and the kernel will race here by reading from the sa=
me
> virtqueue: the device could read VirtQueueElement produced by itself befo=
re
> the kernel if the kernel is not fast enough.

CCing Anton and Shreyansh.

Stefan

--O9/EMo4Ga6BbmRHR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmH7sBoACgkQnKSrs4Gr
c8i3EAgArgdjAIUUo8BbeyCoGRTDbaU8+KOuHwNJmuE4xoFDKyXSOac+o1eEeNGh
N1dhJBhP3T8jWfcT/AwAbBqw0kepK66pJjzRIQqDyHwsNG2B7p/chDpxY47J3luG
aIIF7D6AEv0Gt8CIjuiwUqf/Zo7taoVxkmSI2fOlv2c6FS4I+QUg0gsRPDt7q7HN
QfRZdedcTYKaDIcAUxRj+qCXxQETWsuKQ2PW3/wHoP04DgqOpoWxR+1bZMuY+jV6
tX5o29TxRl99dFyZ+cZR7enzvjIyybAh7hbvJ1di2DcwkkQMBcr+oxANemJ5Jb5G
K8O37hzZqRsqPtPwEYo7QDLYUTKfQQ==
=PFH7
-----END PGP SIGNATURE-----

--O9/EMo4Ga6BbmRHR--

