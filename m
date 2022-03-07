Return-Path: <virtio-dev-return-9349-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5F5ED986488
	for <virtio-dev@lists.oasis-open.org>; Mon,  7 Mar 2022 19:47:55 +0000 (UTC)
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Date: Mon,  7 Mar 2022 20:47:14 +0100
Message-Id: <20220307194716.1517565-1-anton.yakovlev@opensynergy.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH 0/1] ALSA: virtio: add support for audio controls
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: virtualization@lists.linux-foundation.org, alsa-devel@alsa-project.org, virtio-dev@lists.oasis-open.org
Cc: Anton Yakovlev <anton.yakovlev@opensynergy.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

Implementation of support for audio controls in accordance with the
proposed extension of the virtio sound device specification [1].

Design=E3=80=80of virtual audio controls is based on and derived from ALSA
audio controls. It allows the driver to perform all standard operations,
such as reading and writing audio control value, as well as working with
metadata (represented in the TLV form).

The driver part was tested on top of the Linux 5.10 kernel.

As a device part was used OpenSynergy proprietary implementation.

[1] https://lists.oasis-open.org/archives/virtio-comment/202104/msg00013.ht=
ml


Anton Yakovlev (1):
  ALSA: virtio: add support for audio controls

 include/uapi/linux/virtio_snd.h | 154 +++++++++++
 sound/virtio/Makefile           |   1 +
 sound/virtio/virtio_card.c      |  21 ++
 sound/virtio/virtio_card.h      |  22 ++
 sound/virtio/virtio_kctl.c      | 464 ++++++++++++++++++++++++++++++++
 5 files changed, 662 insertions(+)
 create mode 100644 sound/virtio/virtio_kctl.c

--=20
2.35.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

