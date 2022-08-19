Return-Path: <virtio-dev-return-9824-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4F8A998648B
	for <virtio-dev@lists.oasis-open.org>; Fri, 19 Aug 2022 14:49:10 +0000 (UTC)
From: Gavin Li <gavinl@nvidia.com>
Date: Fri, 19 Aug 2022 17:49:03 +0300
Message-Id: <20220819144904.3332-2-gavinl@nvidia.com>
In-Reply-To: <20220819144904.3332-1-gavinl@nvidia.com>
References: <20220819144904.3332-1-gavinl@nvidia.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v2 1/2] virtio-net: introduce and use helper function for guest gso support checks
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, sridhar.samudrala@intel.com, jasowang@redhat.com, loseweigh@gmail.com
Cc: parav@nvidia.com, gavi@nvidia.com, gavinl@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>

Probe routine is already several hundred lines.
Use helper function for guest gso support check.

Signed-off-by: Gavin Li <gavinl@nvidia.com>
Reviewed-by: Gavi Teitz <gavi@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
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

