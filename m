Return-Path: virtio-dev-return-5683-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C0518985CAF
	for <virtio-dev@lists.oasis-open.org>; Tue, 23 Apr 2019 15:18:36 +0000 (UTC)
From: Nikos Dragazis <ndragazis@arrikto.com>
Date: Tue, 23 Apr 2019 18:18:15 +0300
Message-Id: <1556032699-22135-1-git-send-email-ndragazis@arrikto.com>
Subject: [virtio-dev] [PATCH 0/4] introduce virtio vhost-user backend device type
To: virtio-dev@lists.oasis-open.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Vangelis Koukis <vkoukis@arrikto.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi everyone,

this PATCH presents an updated version of the RFC virtio device spec for
the virtio-vhost-user device. The initial RFC implementation can be
found here: [1].

This PATCH is split into four parts:

1. the first commit is just a refactored version of the initial RFC
implementation [1]. I just moved the device spec into a separate .tex
file and changed the device id from #24 to #25 since the former id was
reserved.

2. the second commit fixes some minor issues with the device spec. This
is quite straightforward.

3. the third commit enhances the notification capability with some
device/driver requirements. This makes sense because the notification
capability behaves similarly to the MSI-X capability, thereby having
some requirements that need to be mentioned.

4. the fourth commit synchronizes the shared memory capability with a
recent patch [2] that attempts to standardize a standalone
SHARED_MEMORY_CFG virtio capability.

Looking forward to your comments.

Thanks,
Nikos

[1] https://lists.oasis-open.org/archives/virtio-dev/201801/msg00110.html
[2] https://lists.oasis-open.org/archives/virtio-dev/201902/msg00142.html

Nikos Dragazis (3):
  vhost-user: minor fixes
  vhost-user: add requirements for the notification capability
  vhost-user: update shared memory capability

Stefan Hajnoczi (1):
  vhost-user: add vhost-user device type

 content.tex           |   3 +
 introduction.tex      |   1 +
 virtio-vhost-user.tex | 347 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 351 insertions(+)
 create mode 100644 virtio-vhost-user.tex

-- 
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

