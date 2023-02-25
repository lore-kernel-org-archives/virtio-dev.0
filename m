Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH v1 1/2] transport-pci: Use lowecase alphabets
Date: Sun, 26 Feb 2023 00:06:35 +0200
Message-ID: <20230225220636.429990-2-parav@nvidia.com>
In-Reply-To: <20230225220636.429990-1-parav@nvidia.com>
References: <20230225220636.429990-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
To: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Use uniformly lowercase alphabets to write PCI vendor id and device id.

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v0->v1:
- use all lowercase letters to define device and vedor id
---
 transport-pci.tex | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/transport-pci.tex b/transport-pci.tex
index 0642107..9f9f076 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -18,8 +18,8 @@ \section{Virtio Over PCI Bus}\label{sec:Virtio Transport =
Options / Virtio Over P
=20
 \subsection{PCI Device Discovery}\label{sec:Virtio Transport Options / Vir=
tio Over PCI Bus / PCI Device Discovery}
=20
-Any PCI device with PCI Vendor ID 0x1AF4, and PCI Device ID 0x1000 through
-0x107F inclusive is a virtio device. The actual value within this range
+Any PCI device with PCI Vendor ID 0x1af4, and PCI Device ID 0x1000 through
+0x107f inclusive is a virtio device. The actual value within this range
 indicates which virtio device is supported by the device.
 The PCI Device ID is calculated by adding 0x1040 to the Virtio Device ID,
 as indicated in section \ref{sec:Device Types}.
@@ -28,7 +28,7 @@ \subsection{PCI Device Discovery}\label{sec:Virtio Transp=
ort Options / Virtio Ov
=20
 \devicenormative{\subsubsection}{PCI Device Discovery}{Virtio Transport Op=
tions / Virtio Over PCI Bus / PCI Device Discovery}
=20
-Devices MUST have the PCI Vendor ID 0x1AF4.
+Devices MUST have the PCI Vendor ID 0x1af4.
 Devices MUST either have the PCI Device ID calculated by adding 0x1040
 to the Virtio Device ID, as indicated in section \ref{sec:Device
 Types} or have the Transitional PCI Device ID depending on the device type=
,
@@ -69,13 +69,13 @@ \subsection{PCI Device Discovery}\label{sec:Virtio Tran=
sport Options / Virtio Ov
 to drive the device.
=20
 \drivernormative{\subsubsection}{PCI Device Discovery}{Virtio Transport Op=
tions / Virtio Over PCI Bus / PCI Device Discovery}
-Drivers MUST match devices with the PCI Vendor ID 0x1AF4 and
+Drivers MUST match devices with the PCI Vendor ID 0x1af4 and
 the PCI Device ID in the range 0x1040 to 0x107f,
 calculated by adding 0x1040 to the Virtio Device ID,
 as indicated in section \ref{sec:Device Types}.
 Drivers for device types listed in section \ref{sec:Virtio
 Transport Options / Virtio Over PCI Bus / PCI Device Discovery}
-MUST match devices with the PCI Vendor ID 0x1AF4 and
+MUST match devices with the PCI Vendor ID 0x1af4 and
 the Transitional PCI Device ID indicated in section
  \ref{sec:Virtio
 Transport Options / Virtio Over PCI Bus / PCI Device Discovery}.
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
@@ -688,7 +688,7 @@ \subsubsection{Vendor data capability}\label{sec:Virtio
 Devices CAN present multiple Vendor data capabilities with
 either different or identical \field{vendor_id} values.
=20
-The value \field{vendor_id} MUST NOT equal 0x1AF4.
+The value \field{vendor_id} MUST NOT equal 0x1af4.
=20
 The size of the Vendor data capability MUST be a multiple of 4 bytes.
=20
--=20
2.26.2

