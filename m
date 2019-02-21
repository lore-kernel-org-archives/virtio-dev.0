Return-Path: virtio-dev-return-5483-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E64C69860C4
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Feb 2019 16:22:24 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 21 Feb 2019 16:22:14 +0000
Message-Id: <20190221162219.9790-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH v3 0/5] virtio-blk: discard and write zeroes clarifications
To: virtio-dev@lists.oasis-open.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

v3:
 * Added Patch 5 to explicitly document multi-segment requests
   (including limits and failure semantics)

Several clarifications have been requested for the VIRTIO 1.1 virtio-blk
discard and write zeroes commands.  This series takes care of them.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/32

Stefan Hajnoczi (5):
  virtio-blk: document data[] size constraints
  virtio-blk: move virtio_blk_discard_write_zeroes definition
  virtio-blk: describe write zeroes unmap semantics
  virtio-blk: avoid inconsistent "DISCARD" term
  virtio-blk: clarify semantics of multi-segment discard/write zeroes
    commands

 content.tex | 68 ++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 52 insertions(+), 16 deletions(-)

-- 
2.20.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

