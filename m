Return-Path: <virtio-dev-return-10370-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Sun, 25 Dec 2022 02:37:27 +0200
Message-ID: <20221225003727.103495-1-parav@nvidia.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v1] virtio-network: Clarify VLAN filter table configuration
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: mst@redhat.com, virtio-dev@lists.oasis-open.org
Cc: virtio-comment@lists.oasis-open.org, si-wei.liu@oracle.com, Parav
 Pandit <parav@nvidia.com>
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
v0->v1:
- added missing conformance section link
---
 conformance.tex    |  1 +
 virtio-network.tex | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/conformance.tex b/conformance.tex
index c3c1d3e..478fb80 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -412,6 +412,7 @@ \section{Conformance Targets}\label{sec:Conformance / C=
onformance Targets}
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
diff --git a/virtio-network.tex b/virtio-network.tex
index e7cdd6f..1b8fde9 100644
--- a/virtio-network.tex
+++ b/virtio-network.tex
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


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

