Return-Path: virtio-dev-return-7878-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ED8419865B9
	for <virtio-dev@lists.oasis-open.org>; Wed,  2 Dec 2020 11:29:43 +0000 (UTC)
From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <91df7aad-02fc-13ca-4592-0b1bc131c7e4@metux.net>
Date: Wed, 2 Dec 2020 12:29:41 +0100
MIME-Version: 1.0
Subject: [virtio-dev] Virtio device ID allocation
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Hello folks,


I'd like to allocate some virtio devices IDs:

a) IDs already used by the Linux kernel:

   VIRTIO_ID_FS             =3D 26
   VIRTIO_ID_PMEM           =3D 27
   VIRTIO_ID_MAC80211_HWSIM =3D 29

b) new devices developed by myself:

   VIRTIO_ID_GPIO           =3D 30
   VIRTIO_ID_LED            =3D 31

   (attached spec for gpio, led is still under development)

c) planned devices: (no IDs chosen yet)

   VIRTIO_CAN
   VIRTIO_I2C
   VIRTIO_REGULATOR


best regards,

--mtx

--=20
---
Hinweis: unverschl=C3=BCsselte E-Mails k=C3=B6nnen leicht abgeh=C3=B6rt und=
 manipuliert
werden ! F=C3=BCr eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schl=C3=BCssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

