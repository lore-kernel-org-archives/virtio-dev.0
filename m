Return-Path: <virtio-dev-return-10533-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Wed, 11 Jan 2023 01:09:45 +0200
Message-ID: <20230110230945.528293-1-parav@nvidia.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v9] virtio-network: Clarify VLAN filter table configuration
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: mst@redhat.com, virtio-dev@lists.oasis-open.org
Cc: virtio-comment@lists.oasis-open.org, si-wei.liu@oracle.com, Parav
 Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

The filtering behavior of the VLAN filter commands is not very clear as
discussed in thread [1].

Hence, add the command description and device requirements for it.

[1] https://lists.oasis-open.org/archives/virtio-dev/202301/msg00136.html

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/147
Suggested-by: Si-Wei Liu <si-wei.liu@oracle.com>
Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v8->v9:
- rebased on top of [1]
- updated commit message to newer link
v7->v8:
- Fixed grammar
v6->v7:
- Moved VLAN filter table description from requirements to device
  descrption section
- Added MUST and SHOULD to device requirements
v5->v6:
- removed unwanted article
v4->v5:
- reworded 'vlan filtering table' to 'vlan filter table' to match
  to the existing description about vlan filtering
- remove confusing text around VLAN_DEL command description
- added missing article
- reword device match configuration to device configuration
- changed 'found' to 'present' and 'not found' to 'absent' to
  consider vlan filter table as config table rather
  than search table
v3->v4:
- added description for accepting vlan tagged packets when vlan
  filter is not negotiated
v2->v3:
- corrected grammar
- simplified description for untagged packets
v1->v2:
- adapt to new file path
v0->v1:
- added missing conformance section link
---
 device-types/virtio-network/description.tex   | 22 ++++++++++++++++++-
 .../virtio-network/device-conformance.tex     |  1 +
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/device-types/virtio-network/description.tex b/device-types/vir=
tio-network/description.tex
index 7409f2a..970090c 100644
--- a/device-types/virtio-network/description.tex
+++ b/device-types/virtio-network/description.tex
@@ -1194,7 +1194,11 @@ \subsubsection{Control Virtqueue}\label{sec:Device T=
ypes / Network Device / Devi
 \paragraph{VLAN Filtering}\label{sec:Device Types / Network Device / Devic=
e Operation / Control Virtqueue / VLAN Filtering}
=20
 If the driver negotiates the VIRTIO_NET_F_CTRL_VLAN feature, it
-can control a VLAN filter table in the device.
+can control a VLAN filter table in the device. The VLAN filter
+table applies only to VLAN tagged packets.
+
+When VIRTIO_NET_F_CTRL_VLAN is negotiated, the device starts with
+an empty VLAN filter table.
=20
 \begin{note}
 Similar to the MAC address based filtering, the VLAN filtering
@@ -1210,6 +1214,22 @@ \subsubsection{Control Virtqueue}\label{sec:Device T=
ypes / Network Device / Devi
 Both the VIRTIO_NET_CTRL_VLAN_ADD and VIRTIO_NET_CTRL_VLAN_DEL
 command take a little-endian 16-bit VLAN id as the command-specific-data.
=20
+VIRTIO_NET_CTRL_VLAN_ADD command adds the specified VLAN to the
+VLAN filter table.
+
+VIRTIO_NET_CTRL_VLAN_DEL command removes the specified VLAN from
+the VLAN filter table.
+
+\devicenormative{\subparagraph}{VLAN Filtering}{Device Types / Network Dev=
ice / Device Operation / Control Virtqueue / VLAN Filtering}
+
+When VIRTIO_NET_F_CTRL_VLAN is not negotiated, the device MUST
+accept all VLAN tagged packets as per the device configuration.
+
+When VIRTIO_NET_F_CTRL_VLAN is negotiated, the device MUST
+accept all VLAN tagged packets whose VLAN tag is present in
+the VLAN filter table and SHOULD drop all VLAN tagged packets
+whose VLAN tag is absent in the VLAN filter table.
+
 \subparagraph{Legacy Interface: VLAN Filtering}\label{sec:Device Types / N=
etwork Device / Device Operation / Control Virtqueue / VLAN Filtering / Leg=
acy Interface: VLAN Filtering}
 When using the legacy interface, transitional devices and drivers
 MUST format the VLAN id
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
--=20
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

