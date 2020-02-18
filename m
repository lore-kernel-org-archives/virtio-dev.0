Return-Path: virtio-dev-return-6757-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 44462985EA4
	for <virtio-dev@lists.oasis-open.org>; Tue, 18 Feb 2020 20:28:15 +0000 (UTC)
From: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Date: Tue, 18 Feb 2020 21:27:52 +0100
Message-ID: <20200218202753.652093-1-dmitry.sepp@opensynergy.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v2 0/1] Virtio Video V4L2 driver
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
To: linux-media@vger.kernel.org
Cc: virtio-dev@lists.oasis-open.org, acourbot@chromium.org, alexlau@chromium.org, daniel@ffwll.ch, dgreid@chromium.org, dstaessens@chromium.org, egranata@google.com, fziglio@redhat.com, hverkuil@xs4all.nl, keiichiw@chromium.org, kraxel@redhat.com, marcheu@chromium.org, posciak@chromium.org, spice-devel@lists.freedesktop.org, stevensd@chromium.org, tfiga@chromium.org, uril@redhat.com, samiullah.khawaja@opensynergy.com, kiran.pawar@opensynergy.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi all,

This is a v4l2 virtio video driver for the virtio-video device
specification v3 [1].

The first version of the driver was introduced here [2].

Changes v1 -> v2:
* support the v3 spec (mostly)
* add a module parameter to ask for pages from ZONE_DMA

What is not implemented:
* Plane layout flags should be used to propagate number of planes to
  user-space
* There is no real use of stream creation with bitstream format in the
  parameter list. The driver just uses the first bitstream format from
  the list.
* Setting bitrate is done in a different way compared to the spec. This
  is because it has been already agreed on that the way the spec
  currently describes it requires changes.

Potential improvements:
* Do not send stream_create from open. Use corresponding state machine
  condition to do this.
* Do not send stream_destroy from close. Do it in reqbufs(0).
* Cache format and control settings. Reduce calls to the device.

Best regards,
Dmitry.

[1] https://markmail.org/message/dmw3pr4fuajvarth
[2] https://markmail.org/message/wnnv6r6myvgb5at6



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

