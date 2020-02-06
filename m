Return-Path: virtio-dev-return-6699-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2B4B59860FB
	for <virtio-dev@lists.oasis-open.org>; Thu,  6 Feb 2020 10:21:26 +0000 (UTC)
From: Keiichi Watanabe <keiichiw@chromium.org>
Date: Thu,  6 Feb 2020 19:20:56 +0900
Message-Id: <20200206102058.247258-1-keiichiw@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v3 0/2] Virtio video device specification
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
Cc: linux-media@vger.kernel.org, acourbot@chromium.org, alexlau@chromium.org, daniel@ffwll.ch, dgreid@chromium.org, dstaessens@chromium.org, dmitry.sepp@opensynergy.com, egranata@google.com, fziglio@redhat.com, hverkuil@xs4all.nl, keiichiw@chromium.org, kraxel@redhat.com, marcheu@chromium.org, posciak@chromium.org, spice-devel@lists.freedesktop.org, stevensd@chromium.org, tfiga@chromium.org, uril@redhat.com, samiullah.khawaja@opensynergy.com, kiran.pawar@opensynergy.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,
Here is the 3rd version of virtio-video patches.

This patch set consists of two changes.
The first patch adds the virtio-video protocol. This is an updated version =
of v2 patch [1].
The second patch adds a new feature to use exported objects from different =
virtio devices, which are proposed in [2], as video buffers.

PDFs are avaliable below:
* full version [3]
* only virtio-video section (first patch) [4]
* only virtio-video section (first+second patch) [5]

Best regards,
Keiichi

[1] https://markmail.org/thread/yb25fim2dqfuktgf
[2] https://markmail.org/message/2p5zgfanuv3fgwcu
[3] https://drive.google.com/file/d/1Kl3M6weAm0vV1kj9A5dq2yypLXe_6TS2/view?=
usp=3Dsharing
[4] https://drive.google.com/file/d/1fN_6lft3RPuFKOnBm6P6XCy3fF7wwnu5/view?=
usp=3Dsharing
[5] https://drive.google.com/file/d/1jOsS2WdVhL4PpcWLO8Zukq5J0fXDiWn-/view?=
usp=3Dsharing

Changes v2 -> v3:
* Rename controlq -> commandq.
* Add {QUERY,GET,SET}_CONTROL for bitrate, profile and level.
* Update the definition of virtio_video_format_desc.
  - Remove fields for profiles and levels.
  - Define fields for memory layouts.
  - Stop using FOURCC and define enum virtio_video_format.
* Add a feature flag for non-contiguous memories.
* Add a new section for buffer lifecycle.
* Change RESOURCE_DESTROY to RESOURCE_DESTROY_ALL.
* Add fields in virtio_video_config.
* Remove constants like *_UNDEFINED or *_UNSPEC.
* Rename some constants and structs.
* Change structures and orders of subsections and paragraphs.
* Add more detailed description for each command.
* Address review comments.
* Add a feature for exported objects as a separate patch.

Dmitry Sepp (1):
  virtio-video: Add virtio video device specification

Keiichi Watanabe (1):
  virtio-video: Define a feature for exported objects from different
    virtio devices

 .gitignore                        |    1 +
 content.tex                       |    1 +
 images/video-buffer-lifecycle.dot |   18 +
 make-setup-generated.sh           |    8 +
 virtio-video.tex                  | 1030 +++++++++++++++++++++++++++++
 5 files changed, 1058 insertions(+)
 create mode 100644 .gitignore
 create mode 100644 images/video-buffer-lifecycle.dot
 create mode 100644 virtio-video.tex

--
2.25.0.341.g760bfbb309-goog

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

