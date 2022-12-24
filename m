Return-Path: <virtio-dev-return-10362-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6AB0C986494
	for <virtio-dev@lists.oasis-open.org>; Sat, 24 Dec 2022 18:26:12 +0000 (UTC)
Date: Sat, 24 Dec 2022 13:26:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20221224131902-mutt-send-email-mst@kernel.org>
References: <809854E1-BB69-4639-8B53-C33E88C78E85@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <809854E1-BB69-4639-8B53-C33E88C78E85@holtmann.org>
Subject: Re: [virtio-dev] Correct way to specify virtio_foo_config structures?
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: Marcel Holtmann <marcel@holtmann.org>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Dec 20, 2022 at 03:51:13PM +0100, Marcel Holtmann wrote:
> Hi,
>=20
> what is the correct way for a VIRTIO_F_VERSION_1 modern device to specify=
 the
> virtio_foo_config structure. Should I make it __attribute__((packed))? Wh=
at field
> types should be used. Everything __virtio{16,32} or better __le{16,32}? C=
an we
> have __u8 and do they have to 16-bit or 32-bit aligned.
>=20
> When looking at the various examples, I see multiple combinations. What i=
s the
> prefered virtio_cread accessor method to be used. For example the virtio_=
cread_le
> states something like =E2=80=9Cmodern=E2=80=9D in his comment. So the pre=
ference is to specify
> the virtio_foo_config in little-endian?
>=20
> Any insights are appreciated.
>=20
> Regards
>=20
> Marcel

__leXX and __u8 and things have to be size aligned (so no alignment
requirements for u8 arrays). Add explicit padding as necessary.

__attribute__((packed)) should be generally avoided.

For config access virtio_cread_le/virtio_cwrite_le are preferred.




>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

