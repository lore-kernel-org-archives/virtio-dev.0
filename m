Return-Path: <virtio-comment-return-3645-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Sun, 1 Jan 2023 20:10:48 +0200
Message-ID: <20230101181048.325305-1-parav@nvidia.com>
MIME-Version: 1.0
Subject: [virtio-comment] [PATCH v2] virtio-network: Clarify VLAN filter table configuration
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: mst@redhat.com, virtio-dev@lists.oasis-open.org
Cc: virtio-comment@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>, Si-Wei Liu <si-wei.liu@oracle.com>
List-ID: <virtio-dev.lists.oasis-open.org>

The filtering behavior of the VLAN filter commands is not very clear as
discussed in thread [1].

Hence, add the command description and device requirements for it.

[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg912392.html
Fixes: https://github.com/oasis-tcs/virtio-spec/issues/147
Suggested-by: Si-Wei Liu <si-wei.liu@oracle.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v1->v2:
- adapt to new file path
v0->v1:
- added missing conformance section link
---
 .../virtio-network/device-conformance.tex     |  1 +
 device-types/virtio-network/device.tex        | 23 +++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/device-types/virtio-network/device-conformance.tex b/device-ty=
pes/virtio-network/device-conformance.tex
index c686377..54f6783 100644
--- a/device-types/virtio-network/device-conformance.tex
+++ b/device-types/virtio-network/device-conformance.tex
@@ -9,6 +9,7 @@
 \item \ref{devicenormative:Device Types / Network Device / Device Operatio=
n / Processing of Incoming Packets}
 \item \ref{devicenormative:Device Types / Network Device / Device Operatio=
n / Control Virtqueue / Packet Receive Filtering}
 \item \ref{devicenormative:Device Types / Network Device / Device Operatio=
n / Control Virtqueue / Setting MAC Address Filtering}
+\item \ref{devicenormative:Device Types / Network Device / Device Operatio=
n / Control Virtqueue / VLAN Filtering}
 \item \ref{devicenormative:Device Types / Network Device / Device Operatio=
n / Control Virtqueue / Gratuitous Packet Sending}
 \item \ref{devicenormative:Device Types / Network Device / Device Operatio=
n / Control Virtqueue / Automatic receive steering in multiqueue mode}
 \item \ref{devicenormative:Device Types / Network Device / Device Operatio=
n / Control Virtqueue / Receive-side scaling (RSS) / RSS processing}
diff --git a/device-types/virtio-network/device.tex b/device-types/virtio-n=
etwork/device.tex
index e7cdd6f..1b8fde9 100644
--- a/device-types/virtio-network/device.tex
+++ b/device-types/virtio-network/device.tex
@@ -1210,6 +1210,29 @@ \subsubsection{Control Virtqueue}\label{sec:Device T=
ypes / Network Device / Devi
 Both the VIRTIO_NET_CTRL_VLAN_ADD and VIRTIO_NET_CTRL_VLAN_DEL
 command take a little-endian 16-bit VLAN id as the command-specific-data.
=20
+VIRTIO_NET_CTRL_VLAN_ADD command adds the specified VLAN to the VLAN
+filtering table.
+
+VIRTIO_NET_CTRL_VLAN_DEL command removes specified VLAN from the VLAN
+filtering table which was previously added using
+VIRTIO_NET_CTRL_VLAN_ADD command.
+
+\devicenormative{\subparagraph}{VLAN Filtering}{Device Types / Network Dev=
ice / Device Operation / Control Virtqueue / VLAN Filtering}
+
+When VIRTIO_NET_F_CTRL_VLAN is not negotiated, the device accepts all
+VLAN tagged packets which matches  device's filter configuration.
+
+When VIRTIO_NET_F_CTRL_VLAN is negotiated, the device starts with empty
+VLAN filtering table.
+
+When VIRTIO_NET_F_CTRL_VLAN is negotiated, the device accepts all the
+VLAN tagged packets whose VLAN tag is found in the VLAN filtering table;
+device should drop all VLAN tagged packets whose VLAN tag is not found
+in the VLAN filtering table.
+
+When VIRTIO_NET_F_CTRL_VLAN is negotiated, the device accepts all
+untagged packets which matches device's filter configuration.
+
 \subparagraph{Legacy Interface: VLAN Filtering}\label{sec:Device Types / N=
etwork Device / Device Operation / Control Virtqueue / VLAN Filtering / Leg=
acy Interface: VLAN Filtering}
 When using the legacy interface, transitional devices and drivers
 MUST format the VLAN id
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

