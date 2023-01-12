Return-Path: <virtio-comment-return-3826-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Thu, 12 Jan 2023 23:26:32 +0200
Message-ID: <20230112212632.763955-1-parav@nvidia.com>
MIME-Version: 1.0
Subject: [virtio-comment] [PATCH v4] virtio-net: Avoid confusion between a card and a device
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: mst@redhat.com, virtio-dev@lists.oasis-open.org
Cc: virtio-comment@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Ethernet card is a relatively vague term in context of virtio network
device specification. A Ethernet card in the industry has one to
multiple ports, one to multiple PCI functions.

Historically virtio network device is documented as a Ethernet card.
However it is usually just a single virtual Ethernet device.

Hence, avoid this confusing term 'card' and align the specification
to adhere to widely used specification term as 'device' used for all
virtio device types.

This patch is on top of change [1].

[1] https://lists.oasis-open.org/archives/virtio-dev/202301/msg00210.html

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/154
Reviewed-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v3->v4:
- rebased to new directory name
v2->v3:
- rebased to new file name
v1->v2:
- adapt to new file path
v0->v1:
- removed device word twice
- corrected grammar for changing from card to device
---
 content.tex                      | 6 +++---
 device-types/net/description.tex | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/content.tex b/content.tex
index 0118b8a..df5ce16 100644
--- a/content.tex
+++ b/content.tex
@@ -619,7 +619,7 @@ \subsection{PCI Device Discovery}\label{sec:Virtio Tran=
sport Options / Virtio Ov
 \hline
 Transitional PCI Device ID  &  Virtio Device    \\
 \hline \hline
-0x1000      &   network card     \\
+0x1000      &   network device     \\
 \hline
 0x1001     &   block device     \\
 \hline
@@ -635,7 +635,7 @@ \subsection{PCI Device Discovery}\label{sec:Virtio Tran=
sport Options / Virtio Ov
 \hline
 \end{tabular}
=20
-For example, the network card device with the Virtio Device ID 1
+For example, the network device with the Virtio Device ID 1
 has the PCI Device ID 0x1041 or the Transitional PCI Device ID 0x1000.
=20
 The PCI Subsystem Vendor ID and the PCI Subsystem Device ID MAY reflect
@@ -2912,7 +2912,7 @@ \chapter{Device Types}\label{sec:Device Types}
 \hline \hline
 0          & reserved (invalid) \\
 \hline
-1          &   network card     \\
+1          &   network device     \\
 \hline
 2          &   block device     \\
 \hline
diff --git a/device-types/net/description.tex b/device-types/net/descriptio=
n.tex
index 2bd82ee..7409f2a 100644
--- a/device-types/net/description.tex
+++ b/device-types/net/description.tex
@@ -1,6 +1,6 @@
 \section{Network Device}\label{sec:Device Types / Network Device}
=20
-The virtio network device is a virtual ethernet card, and is the
+The virtio network device is a virtual ethernet device, and is the
 most complex of the devices supported so far by virtio. It has
 enhanced rapidly and demonstrates clearly how support for new
 features are added to an existing device. Empty buffers are
@@ -33,7 +33,7 @@ \subsection{Feature bits}\label{sec:Device Types / Networ=
k Device / Feature bits
=20
 \begin{description}
 \item[VIRTIO_NET_F_CSUM (0)] Device handles packets with partial checksum.=
   This
-  ``checksum offload'' is a common feature on modern network cards.
+  ``checksum offload'' is a common feature of a modern network device.
=20
 \item[VIRTIO_NET_F_GUEST_CSUM (1)] Driver handles packets with partial che=
cksum.
=20
@@ -323,7 +323,7 @@ \subsection{Device Initialization}\label{sec:Device Typ=
es / Network Device / Dev
=20
 \item If the VIRTIO_NET_F_MAC feature bit is set, the configuration
   space \field{mac} entry indicates the ``physical'' address of the
-  network card, otherwise the driver would typically generate a random
+  network device, otherwise the driver would typically generate a random
   local MAC address.
=20
 \item If the VIRTIO_NET_F_STATUS feature bit is negotiated, the link
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

