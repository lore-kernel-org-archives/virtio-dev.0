Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH 2/2] transport-pci: Move transitional device id to legacy section
Date: Sat, 25 Feb 2023 01:12:32 +0200
Message-ID: <20230224231232.340814-3-parav@nvidia.com>
In-Reply-To: <20230224231232.340814-1-parav@nvidia.com>
References: <20230224231232.340814-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
To: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Currently PCI device requirements section contains mix of normative
statements for for regular (non transitional) device and
transitional device under one section.

Some requirements of the transitional device are also located in
legacy interface section which is the right section for it.

Hence,
1. Move transitional device requirements to their designated Legacy
   interface section
2. Describe regular device requirements without quoting it as "non
   transitional device"

While at it, write the description using a singular object definition.

This is only an editorial change.

This patch is on top of [1].

[1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00578.html

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 transport-pci.tex | 70 ++++++++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 34 deletions(-)

diff --git a/transport-pci.tex b/transport-pci.tex
index e271d51..9686cc8 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -28,46 +28,24 @@ \subsection{PCI Device Discovery}\label{sec:Virtio Tran=
sport Options / Virtio Ov
=20
 \devicenormative{\subsubsection}{PCI Device Discovery}{Virtio Transport Op=
tions / Virtio Over PCI Bus / PCI Device Discovery}
=20
-Devices MUST have the PCI Vendor ID 0x1AF4.
-Devices MUST either have the PCI Device ID calculated by adding 0x1040
+The device MUST have the PCI Vendor ID 0x1AF4.
+The device MUST calculate PCI Device ID by adding 0x1040
 to the Virtio Device ID, as indicated in section \ref{sec:Device
-Types} or have the Transitional PCI Device ID depending on the device type=
,
-as follows:
-
-\begin{tabular}{|l|c|}
-\hline
-Transitional PCI Device ID  &  Virtio Device    \\
-\hline \hline
-0x1000      &   network device     \\
-\hline
-0x1001     &   block device     \\
-\hline
-0x1002     & memory ballooning (traditional)  \\
-\hline
-0x1003     &      console       \\
-\hline
-0x1004     &     SCSI host      \\
-\hline
-0x1005     &  entropy source    \\
-\hline
-0x1009     &   9P transport     \\
-\hline
-\end{tabular}
+Types}
=20
 For example, the network device with the Virtio Device ID 1
-has the PCI Device ID 0x1041 or the Transitional PCI Device ID 0x1000.
-
-The PCI Subsystem Vendor ID and the PCI Subsystem Device ID MAY reflect
-the PCI Vendor and Device ID of the environment (for informational purpose=
s by the driver).
+has the PCI Device ID 0x1041.
=20
-Non-transitional devices SHOULD have a PCI Device ID in the range
-0x1040 to 0x107F.
-Non-transitional devices SHOULD have a PCI Revision ID of 1 or higher.
-Non-transitional devices SHOULD have a PCI Subsystem Device ID of 0x40 or =
higher.
+The device SHOULD have a PCI Device ID in the range 0x1040 to 0x107F.
+The device SHOULD have a PCI Revision ID of 1 or higher.
+The device SHOULD have a PCI Subsystem Device ID of 0x40 or higher.
=20
 This is to reduce the chance of a legacy driver attempting
 to drive the device.
=20
+The PCI Subsystem Vendor ID and the PCI Subsystem Device ID MAY reflect
+the PCI Vendor and Device ID of the environment (for informational purpose=
s by the driver).
+
 \drivernormative{\subsubsection}{PCI Device Discovery}{Virtio Transport Op=
tions / Virtio Over PCI Bus / PCI Device Discovery}
 Drivers MUST match devices with the PCI Vendor ID 0x1AF4 and
 the PCI Device ID in the range 0x1040 to 0x107F,
@@ -85,8 +63,32 @@ \subsection{PCI Device Discovery}\label{sec:Virtio Trans=
port Options / Virtio Ov
 PCI Subsystem Device ID value.
=20
 \subsubsection{Legacy Interfaces: A Note on PCI Device Discovery}\label{se=
c:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery / L=
egacy Interfaces: A Note on PCI Device Discovery}
-Transitional devices MUST have a PCI Revision ID of 0.
-Transitional devices MUST have the PCI Subsystem Device ID
+
+The transitional device has one of the following PCI Device ID
+depending on the device type:
+
+\begin{tabular}{|l|c|}
+\hline
+Transitional PCI Device ID  &  Virtio Device    \\
+\hline \hline
+0x1000      &   network device     \\
+\hline
+0x1001     &   block device     \\
+\hline
+0x1002     & memory ballooning (traditional)  \\
+\hline
+0x1003     &      console       \\
+\hline
+0x1004     &     SCSI host      \\
+\hline
+0x1005     &  entropy source    \\
+\hline
+0x1009     &   9P transport     \\
+\hline
+\end{tabular}
+
+The transitional device MUST have a PCI Revision ID of 0.
+The transitional device MUST have the PCI Subsystem Device ID
 matching the Virtio Device ID, as indicated in section \ref{sec:Device Typ=
es}.
 Transitional devices MUST have the Transitional PCI Device ID in
 the range 0x1000 to 0x103F.
--=20
2.26.2

