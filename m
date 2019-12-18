Return-Path: virtio-dev-return-6531-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B81DF985EFE
	for <virtio-dev@lists.oasis-open.org>; Wed, 18 Dec 2019 13:02:32 +0000 (UTC)
From: Keiichi Watanabe <keiichiw@chromium.org>
Date: Wed, 18 Dec 2019 22:02:13 +0900
Message-Id: <20191218130214.170703-1-keiichiw@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v2 0/1] VirtIO video device specification
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
Cc: linux-media@vger.kernel.org, acourbot@chromium.org, alexlau@chromium.org, daniel@ffwll.ch, dgreid@chromium.org, dmitry.sepp@opensynergy.com, egranata@google.com, fziglio@redhat.com, hverkuil@xs4all.nl, keiichiw@chromium.org, kraxel@redhat.com, marcheu@chromium.org, posciak@chromium.org, spice-devel@lists.freedesktop.org, stevensd@chromium.org, tfiga@chromium.org, uril@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,
This is the 2nd version of virtio-video patch. The PDF is available in [1].
The first version was sent at [2].

Any feedback would be appreciated. Thank you.

Best,
Keiichi

[1]: https://drive.google.com/drive/folders/1eT5fEckBoor2iHZR4f4GLxYzFMVapO=
Fx?usp=3Dsharing
[2]: https://markmail.org/message/gc6h25acct22niut

Change log:

v2:
* Removed functionalities except encoding and decoding.
* Splited encoder and decoder into different devices that use the same prot=
ocol.
* Replaced GET_FUNCS with GET_CAPABILITY.
* Updated structs for capabilities.
  - Defined new structs and enums such as image formats, profiles, range (m=
in,
  max, step), etc
    * For virtio_video_pixel_format, chose a naming convention that is used
      in DRM. We removed XBGR, NV21 and I422, as they are not used in the
      current draft implementation. https://lwn.net/Articles/806416/
  - Removed virtio_video_control, whose usage was not documented yet and wh=
ich
    is not necessary for the simplest decoding scenario.
  - Removed virtio_video_desc, as it is no longer needed.
* Updated struct virtio_video_config for changes around capabilities.
* Added a way to represent supported combinations of formats.
  - A field "mask" in virtio_video_format_desc plays this role.
* Removed VIRTIO_VIDEO_T_STREAM_{START,STOP} because they don't play any me=
aningful roles.
* Removed VIRTIO_VIDEO_T_STREAM_{ATTACH, DETACH}_BACKING and merged them in=
to RESOURCE_{CREATE, DESTROY}.
* Added a way to notify/specify resource creation method.
  - Added a feature flag.
  - Defined enum virtio_video_mem_type.
  - Added new fields in video_stream_create.
* Modified fields in virtio_video_params.
  - Added crop information.
* Removed enum virtio_video_channel_type because we can get this informatio=
n by image format.
* Renamed virtio_video_pin to virtio_video_buf_type.
  - It's similar to V4L2_BUF_TYPE_VIDEO_{OUTPUT, CAPTURE}.
* Added an error event.
* Reordered some subsections.
* Changed styles to make it consistent with other devices.

Dmitry Sepp (1):
  virtio-video: Add virtio video device specification

 content.tex      |   1 +
 virtio-video.tex | 579 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 580 insertions(+)
 create mode 100644 virtio-video.tex

--
2.24.1.735.g03f4e72817-goog

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

