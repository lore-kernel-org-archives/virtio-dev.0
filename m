Return-Path: virtio-dev-return-5989-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 70D02985CB7
	for <virtio-dev@lists.oasis-open.org>; Fri, 16 Aug 2019 20:26:49 +0000 (UTC)
From: Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
Date: Fri, 16 Aug 2019 22:26:27 +0200
Message-ID: <20190816202628.14818-1-Mikhail.Golubev@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Subject: [virtio-dev] [RFC] snd: Add virtio sound device specification
To: virtio-dev@lists.oasis-open.org
Cc: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

This patch proposes virtio specification for new virtio sound device. Any
feedback would be greatly appreciated. Previous version of the proposal: [1=
].

Reference implementation is now available and located here:

 * QEMU v4.1.0-rc3 device:
   https://github.com/OpenSynergy/qemu/tree/virtio-snd-draft

 * Linux kernel 5.2-rc7 driver:
   https://github.com/OpenSynergy/linux/tree/virtio-snd-draft

How to use:

1) Set the SND_VIRTIO configuration option in Linux kernel config to
  enable virtio-snd in a guest.

2) QEMU command line must contain virtio-snd-pci device configuration:

  a) ALSA backend:
    -audiodev id=3Dsndbe,driver=3Dalsa,out.try-poll=3Doff,\
    -device virtio-snd-pci

    Polling mode must be disabled because QEMU will freeze until
    playback is stopped.

  b) PulseAudio backend:
    -audiodev id=3Dsndbe,driver=3Dpa,server=3D/run/user/1000/pulse/native,\
    -device virtio-snd-pci

[1]: https://lists.oasis-open.org/archives/virtio-dev/201905/msg00013.html

Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Signed-off-by: Mikhail Golubev <Mikhail.Golubev@opensynergy.com>


Please mind our privacy notice<https://www.opensynergy.com/datenschutzerkla=
erung/privacy-notice-for-business-partners-pursuant-to-article-13-of-the-ge=
neral-data-protection-regulation-gdpr/> pursuant to Art. 13 GDPR. // Unsere=
 Hinweise zum Datenschutz gem. Art. 13 DSGVO finden Sie hier.<https://www.o=
pensynergy.com/de/datenschutzerklaerung/datenschutzhinweise-fuer-geschaefts=
partner-gem-art-13-dsgvo/>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

