Return-Path: virtio-dev-return-7882-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 49F4F9865DD
	for <virtio-dev@lists.oasis-open.org>; Sat,  5 Dec 2020 19:50:53 +0000 (UTC)
Date: Sat, 5 Dec 2020 14:50:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20201205144928-mutt-send-email-mst@kernel.org>
References: <91df7aad-02fc-13ca-4592-0b1bc131c7e4@metux.net>
MIME-Version: 1.0
In-Reply-To: <91df7aad-02fc-13ca-4592-0b1bc131c7e4@metux.net>
Subject: Re: [virtio-dev] Virtio device ID allocation
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Dec 02, 2020 at 12:29:41PM +0100, Enrico Weigelt, metux IT consult =
wrote:
> Hello folks,
>=20
>=20
> I'd like to allocate some virtio devices IDs:
>=20
> a) IDs already used by the Linux kernel:
>=20
>    VIRTIO_ID_FS             =3D 26
>    VIRTIO_ID_PMEM           =3D 27
>    VIRTIO_ID_MAC80211_HWSIM =3D 29
>=20
> b) new devices developed by myself:
>=20
>    VIRTIO_ID_GPIO           =3D 30
>    VIRTIO_ID_LED            =3D 31
>=20
>    (attached spec for gpio, led is still under development)
>=20
> c) planned devices: (no IDs chosen yet)
>=20
>    VIRTIO_CAN
>    VIRTIO_I2C
>    VIRTIO_REGULATOR
>=20
>=20
> best regards,
>=20
> --mtx

So the easiest process to follow to reserve IDs is described here:
https://github.com/oasis-tcs/virtio-spec#use-of-github-issues

> --=20
> ---
> Hinweis: unverschl=C3=BCsselte E-Mails k=C3=B6nnen leicht abgeh=C3=B6rt u=
nd manipuliert
> werden ! F=C3=BCr eine vertrauliche Kommunikation senden Sie bitte ihren
> GPG/PGP-Schl=C3=BCssel zu.
> ---
> Enrico Weigelt, metux IT consult
> Free software and Linux embedded engineering
> info@metux.net -- +49-151-27565287
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

