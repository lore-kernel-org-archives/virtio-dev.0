Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH] virtio-net: Avoid confusing device configuration text
Date: Thu, 26 Jan 2023 02:31:39 +0200
Message-ID: <20230126003139.1185666-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
To: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

The added text in commit of Fixes tag was redundant and
confusing in context of VLAN filtering description.

Hence remove it as discussed in [1] and [2].

[1] https://lists.oasis-open.org/archives/virtio-dev/202301/msg00282.html
[2] https://lists.oasis-open.org/archives/virtio-dev/202301/msg00286.html

Fixes: 296303444f6b ("virtio-net: Clarify VLAN filter table configuration")
Suggested-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
This change is on top of [3].

[3] https://lists.oasis-open.org/archives/virtio-dev/202301/msg00231.html
---
 device-types/net/description.tex | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/device-types/net/description.tex b/device-types/net/descriptio=
n.tex
index e32780b..bd81731 100644
--- a/device-types/net/description.tex
+++ b/device-types/net/description.tex
@@ -1223,7 +1223,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Ty=
pes / Network Device / Devi
 \devicenormative{\subparagraph}{VLAN Filtering}{Device Types / Network Dev=
ice / Device Operation / Control Virtqueue / VLAN Filtering}
=20
 When VIRTIO_NET_F_CTRL_VLAN is not negotiated, the device MUST
-accept all VLAN tagged packets as per the device configuration.
+accept all VLAN tagged packets.
=20
 When VIRTIO_NET_F_CTRL_VLAN is negotiated, the device MUST
 accept all VLAN tagged packets whose VLAN tag is present in
--=20
2.26.2

