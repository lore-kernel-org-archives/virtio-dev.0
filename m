Return-Path: virtio-dev-return-7983-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5FE269864B3
	for <virtio-dev@lists.oasis-open.org>; Tue,  9 Feb 2021 12:40:35 +0000 (UTC)
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Date: Tue, 9 Feb 2021 13:40:01 +0100
Message-ID: <20210209124011.1224628-1-anton.yakovlev@opensynergy.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v3 0/9] ALSA: add virtio sound driver
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

As a device part was used OpenSynergy proprietary implementation.

Any comments are very welcome.

v3 changes:
- Fixed license headers for all files.
- Many coding style and kernel doc fixes.
- Replaced devm_kmalloc/devm_kfree with kmalloc/kfree wherever appropriate.
- Made the names of the card and PCM devices more informative.
- To process the DEVICE_NEEDS_RESET status, simply call device_reprobe().
- For control messages replaced atomic_t by refcount_t for the reference co=
unter
  and simplified the general logic.
- Use vmalloc'ed managed buffer for PCM substreams.
- Replaced all atomic fields in the virtio substream structure with
  non-atomic + spinlock.
- Use the non-atomic PCM ops.
- Use ops->sync_stop() to release the substream on the device side.
- Rebased and tested on top of v5.11-rc6.

v2 changes:
- For some reason, in the previous patch series, several patches were
  squashed. Fixed this issue to make the review easier.
- Added mst@redhat.com to the MAINTAINERS.
- When creating virtqueues, now only the event virtqueue is disabled.
  It's enabled only after successful initialization of the device.
- Added additional comments to the reset worker function:
  [2/9] virtio_card.c:virtsnd_reset_fn()
- Added check that VIRTIO_F_VERSION_1 feature bit is set.
- Added additional comments to the device removing function:
  [2/9] virtio_card.c:virtsnd_remove()
- Added additional comments to the tx/rx interrupt handler:
  [5/9] virtio_pcm_msg.c:virtsnd_pcm_msg_complete()
- Added additional comments to substream release wait function.
  [6/9] virtio_pcm_ops.c:virtsnd_pcm_released()

[1] https://lists.oasis-open.org/archives/virtio-dev/202003/msg00185.html


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
 include/uapi/linux/virtio_snd.h | 334 +++++++++++++++++++++
 sound/Kconfig                   |   2 +
 sound/Makefile                  |   3 +-
 sound/virtio/Kconfig            |  10 +
 sound/virtio/Makefile           |  13 +
 sound/virtio/virtio_card.c      | 462 +++++++++++++++++++++++++++++
 sound/virtio/virtio_card.h      | 113 ++++++++
 sound/virtio/virtio_chmap.c     | 219 ++++++++++++++
 sound/virtio/virtio_ctl_msg.c   | 311 ++++++++++++++++++++
 sound/virtio/virtio_ctl_msg.h   |  78 +++++
 sound/virtio/virtio_jack.c      | 233 +++++++++++++++
 sound/virtio/virtio_pcm.c       | 499 ++++++++++++++++++++++++++++++++
 sound/virtio/virtio_pcm.h       | 121 ++++++++
 sound/virtio/virtio_pcm_msg.c   | 393 +++++++++++++++++++++++++
 sound/virtio/virtio_pcm_ops.c   | 493 +++++++++++++++++++++++++++++++
 17 files changed, 3293 insertions(+), 1 deletion(-)
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

