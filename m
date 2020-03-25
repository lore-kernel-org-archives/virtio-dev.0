Return-Path: virtio-dev-return-6978-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 17A1F985ECA
	for <virtio-dev@lists.oasis-open.org>; Wed, 25 Mar 2020 10:40:59 +0000 (UTC)
From: Keiichi Watanabe <keiichiw@chromium.org>
Date: Wed, 25 Mar 2020 19:40:38 +0900
Message-Id: <20200325104039.196058-1-keiichiw@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH RFC 0/1] Support virtio objects in virtio-video driver
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org, linux-media@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Dmitry Sepp <dmitry.sepp@opensynergy.com>, Kiran Pawar <Kiran.Pawar@opensynergy.com>, Samiullah Khawaja <samiullah.khawaja@opensynergy.com>, Keiichi Watanabe <keiichiw@chromium.org>, Nikolay Martyanov <Nikolay.Martyanov@opensynergy.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, acourbot@chromium.org, alexlau@chromium.org, egranata@google.com, hverkuil@xs4all.nl, kraxel@redhat.com, posciak@chromium.org, stevensd@chromium.org, tfiga@chromium.org
List-ID: <virtio-dev.lists.oasis-open.org>

This implements a feature in virtio-video driver to use exported virtio
objects as video buffers. So, the users will be able to use resources
allocated by other virtio devices such as virtio-gpu.

The virtio protocol for this feature is proposed by [1].

This commit depends on the following unmerged patches:
* Virtio-video driver patch [2]
* Patch series for virtio cross-device resources [3]
* ChromeOS's local patch to use data_offset for offset of multiplanar
  format [4]

[1]: https://markmail.org/message/wxdne5re7aaugbjg
[2]: https://patchwork.linuxtv.org/patch/61717/
[3]: https://patchwork.kernel.org/project/linux-media/list/?series=3D254707
[4]: https://chromium.googlesource.com/chromiumos/third_party/kernel/+/1057=
eb620ccd3da4632c14df269d545cb9a1ccb2

Keiichi Watanabe (1):
  drivers: media: virtio: Support virtio objects in virtio-video driver

 drivers/media/virtio/virtio_video.h        |  26 +++-
 drivers/media/virtio/virtio_video_dec.c    |   1 +
 drivers/media/virtio/virtio_video_device.c | 131 ++++++++++++++++++++-
 drivers/media/virtio/virtio_video_driver.c |  25 +++-
 drivers/media/virtio/virtio_video_vq.c     |  81 ++++++++++---
 include/uapi/linux/virtio_video.h          |  15 ++-
 6 files changed, 243 insertions(+), 36 deletions(-)

--
2.25.1.696.g5e7596f4ac-goog

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

