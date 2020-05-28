Return-Path: virtio-dev-return-7422-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 38763986066
	for <virtio-dev@lists.oasis-open.org>; Thu, 28 May 2020 14:00:49 +0000 (UTC)
Date: Thu, 28 May 2020 15:00:40 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20200528140040.GD158218@stefanha-x1.localdomain>
References: <0592979c-c8ae-fd28-2ddf-e64b135a7292@redhat.com>
MIME-Version: 1.0
In-Reply-To: <0592979c-c8ae-fd28-2ddf-e64b135a7292@redhat.com>
Subject: Re: [virtio-dev] queue_enable vs QueueReady
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Q0rSlbzrZN6k9QnT"
Content-Disposition: inline
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

--Q0rSlbzrZN6k9QnT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2020 at 09:06:36PM +0800, Jason Wang wrote:
> Hi:
>=20
> I found ambiguity in the virtio specification:
>=20
> In PCI part, it describes the queue_enable as:
>=20
> The driver uses this to selectively prevent the device from executing
> requests from this virtqueue. 1 - enabled; 0 - disabled.
>=20
> In MMIO part, it describes the QueueReady as:
>=20
> Writing one (0x1) to this register notifies the device that it can execut=
e
> requests from this virtual queue. Reading from this register returns the
> last value written to it. Both read and write accesses apply to the queue
> selected by writing to QueueSel.
>=20
> If I understand this correctly, they have the same meaning, but the drive=
r
> requirements section looks conflict:
>=20
> PCI said: The driver MUST NOT write a 0 to queue_enable.
>=20
> MMIO said:
>=20
> To stop using the queue the driver MUST write zero (0x0) to this QueueRea=
dy
> and MUST read the value back to ensure synchronization.
>=20
> So we can't disable a queue via queue_enable but QueueReady. Any reason f=
or
> such inconsistency?

I think MMIO is the outlier here. The device emulation code in QEMU
doesn't deal with queue shutdown. That only happens during device reset,
so it's like that a if the guest disables a virtio-mmio queue then
something undefined will happen on the QEMU side. For example, writing
used elements back to the virtqueue after it has been disabled.

If the VIRTIO spec really intends to support virtqueue shutdown then the
semantics need to be spelled out clearly: what happens to in-flight
requests? How do devices behave that rely on multiple virtqueues during
normal operation (e.g. virtio-vsock where you can't really have rx-only
or tx-only)?

Stefan

--Q0rSlbzrZN6k9QnT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7PxAgACgkQnKSrs4Gr
c8iQxAf9Ff87WXZKiRTByX0rOo5H10g/uTvnUU8k+UUxL8bKgECdFHlXpdbPHhHp
N0x2Mjc7T2PQnPR8VUSmEMbw4fpKCV75uLJ/fEn6k6c6ibHl31JUme5bpn0znq0P
FvYJ5LF3mSL0TfsRLzOGdfrHGfwa04JhNWRqpA2jFJTIX7wZDHOv/ZomItXJMnwZ
iNtJEzLhbJs/6G0miaUXyBFoKIYfi6UEGrd5uqm8R9SPl5z5549Kz9/O2duRKnyv
mqucHpuE0lrwIAidFo/lyH74CdcVwMaSJAs5NigVzEneJ2Njgttje0V8Aud5INi9
EPo9JXvEPIggzUe1wy7paTHBCHSlbA==
=U2vt
-----END PGP SIGNATURE-----

--Q0rSlbzrZN6k9QnT--

