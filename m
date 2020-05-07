Return-Path: virtio-dev-return-7268-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2D2AC985E56
	for <virtio-dev@lists.oasis-open.org>; Thu,  7 May 2020 14:02:24 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
Date: Thu,  7 May 2020 16:01:26 +0200
Message-Id: <20200507140139.17083-3-david@redhat.com>
In-Reply-To: <20200507140139.17083-1-david@redhat.com>
References: <20200507140139.17083-1-david@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v4 02/15] MAINTAINERS: Add myself as virtio-mem maintainer
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
index 2926327e4976..014bbf5897c2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17972,6 +17972,13 @@ S:=09Maintained
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
2.25.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

