Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH] changelog: Fix missing reference to driver notifications
Date: Thu, 16 Feb 2023 07:34:57 +0200
Message-ID: <20230216053457.414126-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Cited commit in fixes tag missed to update the reference to drivers
notifications section in past change log.
Fix the reference.

Fixes: be2ce1ee17e0 ("content.tex Fix Driver notifications label")
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 cl-os.tex | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cl-os.tex b/cl-os.tex
index 5ae8a7b..a7364b7 100644
--- a/cl-os.tex
+++ b/cl-os.tex
@@ -254,7 +254,7 @@
=20
 Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
=20
-See \ref{sec:Virtqueues / Driver notifications}.
+See \ref{sec:Basic Facilities of a Virtio Device / Driver notifications}.
  } \\
 \hline
 8f2c4e03eae8 & 27 Oct 2019 & Eugenio P=C3=A9rez & { block: Add multiqueue
--=20
2.26.2

