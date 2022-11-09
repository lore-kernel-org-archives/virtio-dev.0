Return-Path: <virtio-dev-return-10135-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7E1C4986505
	for <virtio-dev@lists.oasis-open.org>; Wed,  9 Nov 2022 11:33:41 +0000 (UTC)
From: Heng Qi <hengqi@linux.alibaba.com>
Date: Wed,  9 Nov 2022 19:33:34 +0800
Message-Id: <20221109113336.121773-1-hengqi@linux.alibaba.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH 0/2] virtio_net: support inner header hash for GRE-encapsulated packets
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: virtio-dev@lists.oasis-open.org
Cc: Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Heng Qi <henqqi@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

From: Heng Qi <henqqi@linux.alibaba.com>

Now, whether it is a tunnel-encapsulated packet or a normal packet, it can =
be
considered that the hash is calculated over the outer header. For the
tunnel-encapsulated packet in the same flow, the hash is the same under thi=
s
default behavior, and this is a point that can be optimized for multi-queue=
 NICs.

This patch set adds a VIRTIO_NET_HASH_TYPE_GRE_INNER bitmask in \field{hash=
_types},
which supports inner header hash for GRE-encapsulated packets.

Heng Qi (2):
  virtio_net: fix syntax errors
  virtio_net: support inner header hash for GRE-encapsulated packets

 content.tex | 122 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 119 insertions(+), 3 deletions(-)

--=20
2.19.1.6.gb485710b


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

