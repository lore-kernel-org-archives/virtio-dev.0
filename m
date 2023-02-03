Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH 4/6] transport-pci: Correct spelling errors
Date: Fri, 3 Feb 2023 22:16:18 +0200
Message-ID: <20230203201620.107744-5-parav@nvidia.com>
In-Reply-To: <20230203201620.107744-1-parav@nvidia.com>
References: <20230203201620.107744-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
To: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Now that we have individual files, fix reported spelling errors.

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 transport-pci.tex | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/transport-pci.tex b/transport-pci.tex
index 49c35bd..753703f 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -981,7 +981,7 @@ \subsubsection{Device Initialization}\label{sec:Virtio =
Transport Options / Virti
 Driver MAY fall back on using INT\#x interrupts for a device
 which only supports one MSI-X vector (MSI-X Table Size =3D 0).
=20
-Driver MAY intepret the Table Size as a hint from the device
+Driver MAY interpret the Table Size as a hint from the device
 for the suggested number of MSI-X vectors to use.
=20
 Driver MUST NOT attempt to map an event to a vector
--=20
2.26.2

