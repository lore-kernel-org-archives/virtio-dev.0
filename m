Return-Path: virtio-dev-return-7503-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BB287985F37
	for <virtio-dev@lists.oasis-open.org>; Tue, 23 Jun 2020 11:13:55 +0000 (UTC)
From: Keiichi Watanabe <keiichiw@chromium.org>
Date: Tue, 23 Jun 2020 20:13:24 +0900
Message-Id: <20200623111325.237158-1-keiichiw@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH RFC v4 0/1] Virtio Video Device Specification
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
Cc: linux-media@vger.kernel.org, acourbot@chromium.org, alexlau@chromium.org, daniel@ffwll.ch, dgreid@chromium.org, dstaessens@chromium.org, dmitry.sepp@opensynergy.com, egranata@google.com, fziglio@redhat.com, hverkuil@xs4all.nl, keiichiw@chromium.org, kraxel@redhat.com, marcheu@chromium.org, posciak@chromium.org, spice-devel@lists.freedesktop.org, stevensd@chromium.org, tfiga@chromium.org, uril@redhat.com, samiullah.khawaja@opensynergy.com, kiran.pawar@opensynergy.com, saket.sinha89@gmail.com, laurent.pinchart@ideasonboard.com, nicolas@ndufresne.ca, mst@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

This is the v4 RFC of virtio video device specification.
PDF versions are available at [1, 2].

Note that this patch depends on a recent patchset "Cross-device resource
sharing" [3].

Here is a list of major changes from v3:
* Redesingned struct definitions for each command and request based on
  discussions at [4].
* Renamed commands/structs/enums to more descriptive names.
* Had different structs and fields for image formats and bitstream formats.
* Added more detailed specification for supported video codecs.
* Made stream_id be allocated by the device.
* Had a single parameter struct per-stream instead of per-queue parameters =
and
  controls.
* Allowed the driver to specify the number of buffers to use via
  "cur_{image,bitstream}_buffers".
* Renamed RESOURCE_CREATE command to RESOURCE_ATTACH command and allow the
  driver to use this command when replacing backing memories as well.

[5] is the diff of the header file from v3. Note that it only contains chan=
ges
in the header. We haven't updated the driver nor device implementation to f=
ocus
on protocol design discussion first.

While it may appear that many parts have been changed since the previous
revision, these changes are to address the issues raised in previous discus=
sions
or/and to make the protocol simpler and easier to prevent misuse.
I'd appreciate any types of feedback.

Best regards,
Keiichi

[1] (full): https://drive.google.com/file/d/1DiOJZfUJ5wvFtnNFQicxt0zkp4Ob1o=
9C/view?usp=3Dsharing
[2] (only video section): https://drive.google.com/file/d/188uAkIWE0BsXETEC=
ez98y5fJKw8rslj3/view?usp=3Dsharing
[3] https://lists.oasis-open.org/archives/virtio-comment/202003/msg00035.ht=
ml
[4] https://markmail.org/thread/c6h3e3zn647qli3w
[5] https://chromium-review.googlesource.com/c/chromiumos/third_party/kerne=
l/+/2164411

Keiichi Watanabe (1):
  virtio-video: Add virtio video device specification

 .gitignore                        |    1 +
 content.tex                       |    1 +
 images/video-buffer-lifecycle.dot |   18 +
 make-setup-generated.sh           |    8 +
 virtio-video.tex                  | 1163 +++++++++++++++++++++++++++++
 5 files changed, 1191 insertions(+)
 create mode 100644 .gitignore
 create mode 100644 images/video-buffer-lifecycle.dot
 create mode 100644 virtio-video.tex

--
2.27.0.111.gc72c7da667-goog

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

