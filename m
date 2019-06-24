Return-Path: virtio-dev-return-5804-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D20E7985A46
	for <virtio-dev@lists.oasis-open.org>; Mon, 24 Jun 2019 23:30:06 +0000 (UTC)
From: Nikos Dragazis <ndragazis@arrikto.com>
Date: Tue, 25 Jun 2019 02:29:52 +0300
Message-Id: <1561418997-24608-1-git-send-email-ndragazis@arrikto.com>
Subject: [virtio-dev] [PATCH v4 0/5] introduce virtio vhost-user backend device type
To: virtio-dev@lists.oasis-open.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Vangelis Koukis <vkoukis@arrikto.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi everyone,

this PATCH presents an updated version of the RFC virtio device spec for
the virtio-vhost-user device. The initial RFC implementation can be
found here: [1].

In this fourth version of the patch series I have added comformance
targets for the virtio-vhost-user device via a separate commit. I have
also updated the link for the vhost-user protocol specification located
in QEMU's git repo, since it has been reformatted from plain text into
restructured text.

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

Looking forward to your comments.

Thanks,
Nikos

[1] https://lists.oasis-open.org/archives/virtio-dev/201801/msg00110.html

Nikos Dragazis (4):
  vhost-user: minor fixes
  vhost-user: add requirements for the notification capability
  vhost-user: update shared memory capability
  vhost-user: add conformance targets and clauses

Stefan Hajnoczi (1):
  vhost-user: add vhost-user device type

 conformance.tex       |  24 +++-
 content.tex           |   3 +
 introduction.tex      |   1 +
 virtio-vhost-user.tex | 349 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 375 insertions(+), 2 deletions(-)
 create mode 100644 virtio-vhost-user.tex

-- 
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

