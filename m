Return-Path: <virtio-dev-return-9866-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A18DC98644E
	for <virtio-dev@lists.oasis-open.org>; Wed, 31 Aug 2022 13:06:25 +0000 (UTC)
From: Gavin Li <gavinl@nvidia.com>
Date: Wed, 31 Aug 2022 16:05:40 +0300
Message-ID: <20220831130541.81217-2-gavinl@nvidia.com>
In-Reply-To: <20220831130541.81217-1-gavinl@nvidia.com>
References: <20220831130541.81217-1-gavinl@nvidia.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH RESEND v4 1/2] virtio-net: introduce and use helper function for guest gso support checks
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: stephen@networkplumber.org, davem@davemloft.net, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kuba@kernel.org, sridhar.samudrala@intel.com, jasowang@redhat.com, loseweigh@gmail.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, mst@redhat.com
Cc: gavi@nvidia.com, parav@nvidia.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Si-Wei Liu <si-wei.liu@oracle.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Probe routine is already several hundred lines.
Use helper function for guest gso support check.

Signed-off-by: Gavin Li <gavinl@nvidia.com>
Reviewed-by: Gavi Teitz <gavi@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
changelog:
v1->v2
- Add new patch
---
 drivers/net/virtio_net.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 9cce7dec7366..e1904877d461 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3682,6 +3682,14 @@ static int virtnet_validate(struct virtio_device *vd=
ev)
 =09return 0;
 }
=20
+static bool virtnet_check_guest_gso(const struct virtnet_info *vi)
+{
+=09return (virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO4) ||
+=09=09virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO6) ||
+=09=09virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_ECN) ||
+=09=09virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_UFO));
+}
+
 static int virtnet_probe(struct virtio_device *vdev)
 {
 =09int i, err =3D -ENOMEM;
@@ -3777,10 +3785,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 =09spin_lock_init(&vi->refill_lock);
=20
 =09/* If we can receive ANY GSO packets, we must allocate large ones. */
-=09if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
-=09    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6) ||
-=09    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_ECN) ||
-=09    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO))
+=09if (virtnet_check_guest_gso(vi))
 =09=09vi->big_packets =3D true;
=20
 =09if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))
--=20
2.31.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

