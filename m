Return-Path: virtio-dev-return-7362-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C8009985F4A
	for <virtio-dev@lists.oasis-open.org>; Mon, 18 May 2020 20:38:36 +0000 (UTC)
From: Nikos Dragazis <ndragazis@arrikto.com>
Date: Mon, 18 May 2020 23:37:11 +0300
Message-Id: <20200518203721.7625-1-ndragazis@arrikto.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v5 00/10] introduce virtio vhost-user backend device type
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi everyone,

this patch presents an updated version of the virtio device spec for the
virtio-vhost-user device. The initial RFC implementation can be found
here: [1]. It=E2=80=99s been a long time since the last revision. I=E2=80=
=99m sending
this patch to kick off the discussion again. I'm Cc-ing Stefan and
Michael who had engaged with this in the past.

In this fifth revision of the patch I have made some minor and major
changes. The most important is the drop of the device-specific PCI
capabilities, as Michael suggested [2]. This guarantees portability
across transports, i.e., the device spec is not bound to the PCI
transport, as it used to be up to this point.

In more detail, the changes in this revision are outlined below. You can
find an HTML version here: [3]. Note that I have kept the commits
separate so that it is easy to track the changes from the previous
revision [4].

Looking forward to your comments.

Thanks,
Nikos

v5 changes:
 * Change device id from #28 to #32
 * Fix definitions of VIRTIO_VHOST_USER_STATUS_{MASTER,SLAVE}_UP bits
 * Remove the extra PCI capabilities and use existing virtio registers
   instead
 * Intercept slave's reply to VHOST_USER_GET_PROTOCOL_FEATURES
 * Some more minor fixes (typos, etc.)

v4 changes:
 * Add comformance targets for the virtio-vhost-user device.
 * Update the reference link for the vhost-user protocol specification.

v3 changes:
 * Device Requirements for the Notification Capability: point out the
   difference between the MSI-X Table Size stored in the Message Control
   register of the MSI-X capability structure and the actual MSI-X Table
   Size

v2 changes:
 * Change device id from #25 to #28


[1] https://lists.oasis-open.org/archives/virtio-dev/201801/msg00110.html
[2] https://lists.oasis-open.org/archives/virtio-dev/201908/msg00014.html
[3] https://ndragazis.github.io/virtio/vvu/v5/virtio-v1.1-cs01.html#x1-4960=
0014
[4] https://lists.oasis-open.org/archives/virtio-dev/201906/msg00036.html

Nikos Dragazis (9):
  vhost-user: minor fixes
  vhost-user: add requirements for the notification capability
  vhost-user: update shared memory capability
  vhost-user: add conformance targets and clauses
  vhost-user: change the device id
  vhost-user: minor fix on status register
  vhost-user: remove the extra PCI capabilities
  vhost-user: intercept slave's reply to
    VHOST_USER_GET_PROTOCOL_FEATURES
  vhost-user: clarify that we are talking about slave-initiated messages

Stefan Hajnoczi (1):
  vhost-user: add vhost-user device type

 conformance.tex       |  11 +-
 content.tex           |   3 +
 introduction.tex      |   1 +
 virtio-vhost-user.tex | 282 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 295 insertions(+), 2 deletions(-)
 create mode 100644 virtio-vhost-user.tex

--=20
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

