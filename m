Return-Path: virtio-dev-return-7943-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7B43D9843E0
	for <virtio-dev@lists.oasis-open.org>; Sun, 24 Jan 2021 16:54:24 +0000 (UTC)
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Date: Sun, 24 Jan 2021 17:53:59 +0100
Message-ID: <20210124165408.1122868-1-anton.yakovlev@opensynergy.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v2 0/9] ALSA: add virtio sound driver
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: virtualization@lists.linux-foundation.org, alsa-devel@alsa-project.org, virtio-dev@lists.oasis-open.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
List-ID: <virtio-dev.lists.oasis-open.org>

This series implements a driver part of the virtio sound device
specification v8 [1].

The driver supports PCM playback and capture substreams, jack and
channel map controls. A message-based transport is used to write/read
PCM frames to/from a device.

The series is based (and was actually tested) on Linus's master
branch [2], on top of

commit 1e2a199f6ccd ("Merge tag 'spi-fix-v5.11-rc4' of ...")

As a device part was used OpenSynergy proprietary implementation.

Any comments are very welcome.

v1->v2 changes:

1. For some reason, in the previous patch series, several patches were
   squashed. Fixed this issue to make the review easier.
2. Added mst@redhat.com to the MAINTAINERS.
3. When creating virtqueues, now only the event virtqueue is disabled.
   It's enabled only after successful initialization of the device.
4. Added additional comments to the reset worker function:
   [2/9] virtio_card.c:virtsnd_reset_fn()
5. Added check that VIRTIO_F_VERSION_1 feature bit is set.
6. Added additional comments to the device removing function:
   [2/9] virtio_card.c:virtsnd_remove()
7. Added additional comments to the tx/rx interrupt handler:
   [5/9] virtio_pcm_msg.c:virtsnd_pcm_msg_complete()
8. Added additional comments to substream release wait function.
   [6/9] virtio_pcm_ops.c:virtsnd_pcm_released()

[1] https://lists.oasis-open.org/archives/virtio-dev/202003/msg00185.html
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git


Anton Yakovlev (9):
  uapi: virtio_ids: add a sound device type ID from OASIS spec
  ALSA: virtio: add virtio sound driver
  ALSA: virtio: handling control messages
  ALSA: virtio: build PCM devices and substream hardware descriptors
  ALSA: virtio: handling control and I/O messages for the PCM device
  ALSA: virtio: PCM substream operators
  ALSA: virtio: introduce jack support
  ALSA: virtio: introduce PCM channel map support
  ALSA: virtio: introduce device suspend/resume support

 MAINTAINERS                     |   9 +
 include/uapi/linux/virtio_ids.h |   1 +
 include/uapi/linux/virtio_snd.h | 361 ++++++++++++++++++++
 sound/Kconfig                   |   2 +
 sound/Makefile                  |   3 +-
 sound/virtio/Kconfig            |  10 +
 sound/virtio/Makefile           |  13 +
 sound/virtio/virtio_card.c      | 577 +++++++++++++++++++++++++++++++
 sound/virtio/virtio_card.h      | 121 +++++++
 sound/virtio/virtio_chmap.c     | 237 +++++++++++++
 sound/virtio/virtio_ctl_msg.c   | 293 ++++++++++++++++
 sound/virtio/virtio_ctl_msg.h   | 122 +++++++
 sound/virtio/virtio_jack.c      | 255 ++++++++++++++
 sound/virtio/virtio_pcm.c       | 582 ++++++++++++++++++++++++++++++++
 sound/virtio/virtio_pcm.h       | 132 ++++++++
 sound/virtio/virtio_pcm_msg.c   | 325 ++++++++++++++++++
 sound/virtio/virtio_pcm_ops.c   | 528 +++++++++++++++++++++++++++++
 17 files changed, 3570 insertions(+), 1 deletion(-)
 create mode 100644 include/uapi/linux/virtio_snd.h
 create mode 100644 sound/virtio/Kconfig
 create mode 100644 sound/virtio/Makefile
 create mode 100644 sound/virtio/virtio_card.c
 create mode 100644 sound/virtio/virtio_card.h
 create mode 100644 sound/virtio/virtio_chmap.c
 create mode 100644 sound/virtio/virtio_ctl_msg.c
 create mode 100644 sound/virtio/virtio_ctl_msg.h
 create mode 100644 sound/virtio/virtio_jack.c
 create mode 100644 sound/virtio/virtio_pcm.c
 create mode 100644 sound/virtio/virtio_pcm.h
 create mode 100644 sound/virtio/virtio_pcm_msg.c
 create mode 100644 sound/virtio/virtio_pcm_ops.c

--=20
2.30.0



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

