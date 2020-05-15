Return-Path: virtio-dev-return-7346-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1C091986048
	for <virtio-dev@lists.oasis-open.org>; Fri, 15 May 2020 10:14:28 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
Date: Fri, 15 May 2020 12:14:02 +0200
Message-Id: <20200515101402.16597-1-david@redhat.com>
In-Reply-To: <20200507140139.17083-1-david@redhat.com>
References: <20200507140139.17083-1-david@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v4 16/15] virtio-mem: Don't rely on implicit compiler padding for requests
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, teawater <teawaterz@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

The compiler will add padding after the last member, make that explicit.
The size of a request is always 24 bytes. The size of a response always
10 bytes. Add compile-time checks.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: teawater <teawaterz@linux.alibaba.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

Something I noticed while working on the spec (which proves that writing a
virtio-spec makes sense :) ).

---
 drivers/virtio/virtio_mem.c     | 3 +++
 include/uapi/linux/virtio_mem.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 9e523db3bee1..f658fe9149be 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -1770,6 +1770,9 @@ static int virtio_mem_probe(struct virtio_device *vde=
v)
 =09struct virtio_mem *vm;
 =09int rc =3D -EINVAL;
=20
+=09BUILD_BUG_ON(sizeof(struct virtio_mem_req) !=3D 24);
+=09BUILD_BUG_ON(sizeof(struct virtio_mem_resp) !=3D 10);
+
 =09vdev->priv =3D vm =3D kzalloc(sizeof(*vm), GFP_KERNEL);
 =09if (!vm)
 =09=09return -ENOMEM;
diff --git a/include/uapi/linux/virtio_mem.h b/include/uapi/linux/virtio_me=
m.h
index e0a9dc7397c3..a455c488a995 100644
--- a/include/uapi/linux/virtio_mem.h
+++ b/include/uapi/linux/virtio_mem.h
@@ -103,16 +103,19 @@
 struct virtio_mem_req_plug {
 =09__virtio64 addr;
 =09__virtio16 nb_blocks;
+=09__virtio16 padding[3];
 };
=20
 struct virtio_mem_req_unplug {
 =09__virtio64 addr;
 =09__virtio16 nb_blocks;
+=09__virtio16 padding[3];
 };
=20
 struct virtio_mem_req_state {
 =09__virtio64 addr;
 =09__virtio16 nb_blocks;
+=09__virtio16 padding[3];
 };
=20
 struct virtio_mem_req {
--=20
2.25.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

