Return-Path: virtio-dev-return-6837-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C4B36985B4C
	for <virtio-dev@lists.oasis-open.org>; Mon,  2 Mar 2020 11:51:59 +0000 (UTC)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Mon,  2 Mar 2020 13:50:00 +0200
Message-Id: <20200302115003.14877-1-yuri.benditovich@daynix.com>
Subject: [virtio-dev] [PATCH v4 0/3] virtio-net: introduce features defined in the spec
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: yan@daynix.com, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

This series introduce virtio-net features VIRTIO_NET_F_RSC_EXT,
VIRTIO_NET_F_RSS and VIRTIO_NET_F_HASH_REPORT.

Changes from v3: reformatted structure in patch 1

Yuri Benditovich (3):
  virtio-net: Introduce extended RSC feature
  virtio-net: Introduce RSS receive steering feature
  virtio-net: Introduce hash report feature

 include/uapi/linux/virtio_net.h | 102 ++++++++++++++++++++++++++++++--
 1 file changed, 98 insertions(+), 4 deletions(-)

--=20
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

