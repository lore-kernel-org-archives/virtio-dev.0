Return-Path: virtio-return-3425-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Tue, 3 Dec 2019 05:39:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20191203103646.490868-1-mst@redhat.com>
MIME-Version: 1.0
Subject: [virtio] [PATCH v3] content: document speed, duplex
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: virtio@lists.oasis-open.org, Cornelia Huck <cohuck@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Document as used by Linux.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/59
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---

changes from v2:
=09fix up units
=09actually there's no way for driver to know that link up
=09changed: it might have changed back.
=09make the device requirement a weaker "SHOULD" and instead
=09ask that driver re-read on each config change notification

 content.tex | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/content.tex b/content.tex
index d68cfaf..f7a6971 100644
--- a/content.tex
+++ b/content.tex
@@ -2823,6 +2823,7 @@ \subsection{Feature bits}\label{sec:Device Types / Ne=
twork Device / Feature bits
=20
 \item[VIRTIO_NET_F_STANDBY(62)] Device may act as a standby for a primary
     device with the same MAC address.
+\item[VIRTIO_NET_F_SPEED_DUPLEX(63)] Device reports speed and duplex.
 \end{description}
=20
 \subsubsection{Feature bit requirements}\label{sec:Device Types / Network =
Device / Feature bits / Feature bit requirements}
@@ -2882,12 +2883,28 @@ \subsection{Device configuration layout}\label{sec:=
Device Types / Network Device
 VIRTIO_NET_F_MTU is set. This field specifies the maximum MTU for the driv=
er to
 use.
=20
+The following two fields, \field{speed} and \field{duplex}, only
+exist if VIRTIO_NET_F_SPEED_DUPLEX is set.
+
+\field{speed} contains the device speed, in units of 1 MBit per
+second, 0 to 0x7ffffffff, or 0xfffffffff for unknown speed.
+
+\field{duplex} has the values of 0x00 for full duplex, 0x01 for
+half duplex and 0xff for unknown duplex state.
+
+Both \field{speed} and \field{duplex} can change, thus the driver
+is expected to re-read these values after receiving a
+configuration change notification.
+
 \begin{lstlisting}
 struct virtio_net_config {
         u8 mac[6];
         le16 status;
         le16 max_virtqueue_pairs;
         le16 mtu;
+        le32 speed;
+        u8 duplex;
+
 };
 \end{lstlisting}
=20
@@ -2916,6 +2933,19 @@ \subsection{Device configuration layout}\label{sec:D=
evice Types / Network Device
 If the driver negotiates the VIRTIO_NET_F_STANDBY feature, the device MAY =
act
 as a standby device for a primary device with the same MAC address.
=20
+If VIRTIO_NET_F_SPEED_DUPLEX has been negotiated, \field{speed}
+MUST contain the device speed, in units of 1 MBit per second, 0 to
+0x7ffffffff, or 0xfffffffff for unknown.
+
+If VIRTIO_NET_F_SPEED_DUPLEX has been negotiated, \field{duplex}
+MUST have the values of 0x00 for full duplex, 0x01 for half
+duplex, or 0xff for unknown.
+
+If VIRTIO_NET_F_SPEED_DUPLEX and VIRTIO_NET_F_STATUS have both
+been negotiated, the device SHOULD NOT change the \field{speed} and
+\field{duplex} fields as long as VIRTIO_NET_S_LINK_UP is set in
+the \field{status}.
+
 \drivernormative{\subsubsection}{Device configuration layout}{Device Types=
 / Network Device / Device configuration layout}
=20
 A driver SHOULD negotiate VIRTIO_NET_F_MAC if the device offers it.
@@ -2940,6 +2970,15 @@ \subsection{Device configuration layout}\label{sec:D=
evice Types / Network Device
=20
 A driver SHOULD negotiate the VIRTIO_NET_F_STANDBY feature if the device o=
ffers it.
=20
+If VIRTIO_NET_F_SPEED_DUPLEX has been negotiated,
+the driver MUST treat any value of \field{speed} above
+0x7fffffff as well as any value of \field{duplex} not
+matching 0x00 or 0x01 as an unknown value.
+
+If VIRTIO_NET_F_SPEED_DUPLEX has been negotiated, the driver
+SHOULD re-read \field{speed} and \field{duplex} after a
+configuration change notification.
+
 \subsubsection{Legacy Interface: Device configuration layout}\label{sec:De=
vice Types / Network Device / Device configuration layout / Legacy Interfac=
e: Device configuration layout}
 \label{sec:Device Types / Block Device / Feature bits / Device configurati=
on layout / Legacy Interface: Device configuration layout}
 When using the legacy interface, transitional devices and drivers
--=20
MST


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that=20
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php=20

