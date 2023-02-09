Return-Path: <virtio-dev-return-10855-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 83008986580
	for <virtio-dev@lists.oasis-open.org>; Thu,  9 Feb 2023 12:00:41 +0000 (UTC)
From: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>
Date: Thu,  9 Feb 2023 12:59:15 +0100
Message-Id: <20230209115916.917569-1-aiswarya.cyriac@opensynergy.com>
MIME-Version: 1.0
Subject: [virtio-dev] [RESEND PATCH 0/1] ALSA: virtio: add support for audio controls
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: mst@redhat.com, jasowang@redhat.com, perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: Anton Yakovlev <anton.yakovlev@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

From: Anton Yakovlev <anton.yakovlev@opensynergy.com>

Implementation of support for audio controls in accordance with the
extension of the virtio sound device specification[1] planned for
virtio-v1.3-cs01.

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
2.25.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

