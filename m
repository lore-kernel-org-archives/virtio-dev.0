Return-Path: <virtio-comment-return-4517-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Sat, 25 Feb 2023 01:12:31 +0200
Message-ID: <20230224231232.340814-2-parav@nvidia.com>
In-Reply-To: <20230224231232.340814-1-parav@nvidia.com>
References: <20230224231232.340814-1-parav@nvidia.com>
MIME-Version: 1.0
Subject: [virtio-comment] [PATCH 1/2] transport-pci: Use capital alphabets
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Use capital alphabets to write PCI device id
similar to vendor id and existing device id.

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 transport-pci.tex | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/transport-pci.tex b/transport-pci.tex
index 0642107..e271d51 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -61,7 +61,7 @@ \subsection{PCI Device Discovery}\label{sec:Virtio Transp=
ort Options / Virtio Ov
 the PCI Vendor and Device ID of the environment (for informational purpose=
s by the driver).
=20
 Non-transitional devices SHOULD have a PCI Device ID in the range
-0x1040 to 0x107f.
+0x1040 to 0x107F.
 Non-transitional devices SHOULD have a PCI Revision ID of 1 or higher.
 Non-transitional devices SHOULD have a PCI Subsystem Device ID of 0x40 or =
higher.
=20
@@ -70,7 +70,7 @@ \subsection{PCI Device Discovery}\label{sec:Virtio Transp=
ort Options / Virtio Ov
=20
 \drivernormative{\subsubsection}{PCI Device Discovery}{Virtio Transport Op=
tions / Virtio Over PCI Bus / PCI Device Discovery}
 Drivers MUST match devices with the PCI Vendor ID 0x1AF4 and
-the PCI Device ID in the range 0x1040 to 0x107f,
+the PCI Device ID in the range 0x1040 to 0x107F,
 calculated by adding 0x1040 to the Virtio Device ID,
 as indicated in section \ref{sec:Device Types}.
 Drivers for device types listed in section \ref{sec:Virtio
@@ -89,7 +89,7 @@ \subsubsection{Legacy Interfaces: A Note on PCI Device Di=
scovery}\label{sec:Virt
 Transitional devices MUST have the PCI Subsystem Device ID
 matching the Virtio Device ID, as indicated in section \ref{sec:Device Typ=
es}.
 Transitional devices MUST have the Transitional PCI Device ID in
-the range 0x1000 to 0x103f.
+the range 0x1000 to 0x103F.
=20
 This is to match legacy drivers.
=20
--=20
2.26.2


This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

