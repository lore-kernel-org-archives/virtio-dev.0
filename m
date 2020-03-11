Return-Path: virtio-dev-return-6931-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DC08A985FDA
	for <virtio-dev@lists.oasis-open.org>; Wed, 11 Mar 2020 17:16:46 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
Date: Wed, 11 Mar 2020 18:14:22 +0100
Message-Id: <20200311171422.10484-11-david@redhat.com>
In-Reply-To: <20200311171422.10484-1-david@redhat.com>
References: <20200311171422.10484-1-david@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v2 10/10] MAINTAINERS: Add myself as virtio-mem maintainer
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Let's make sure patches/bug reports find the right person.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f6dcd1233935..ee0e7cbca5c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17937,6 +17937,13 @@ S:=09Maintained
 F:=09drivers/iommu/virtio-iommu.c
 F:=09include/uapi/linux/virtio_iommu.h
=20
+VIRTIO MEM DRIVER
+M:=09David Hildenbrand <david@redhat.com>
+L:=09virtualization@lists.linux-foundation.org
+S:=09Maintained
+F:=09drivers/virtio/virtio_mem.c
+F:=09include/uapi/linux/virtio_mem.h
+
 VIRTUAL BOX GUEST DEVICE DRIVER
 M:=09Hans de Goede <hdegoede@redhat.com>
 M:=09Arnd Bergmann <arnd@arndb.de>
--=20
2.24.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

