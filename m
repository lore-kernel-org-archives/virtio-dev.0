Return-Path: virtio-return-3397-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Tue, 19 Nov 2019 19:28:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20191120002740.69399-1-mst@redhat.com>
MIME-Version: 1.0
Subject: [virtio] [PATCH v2] content: document speed, duplex
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: jbaron@akamai.com
List-ID: <virtio-dev.lists.oasis-open.org>

Document as used by Linux.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/59
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 content.tex | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/content.tex b/content.tex
index bff80d0..f6e09bd 100644
--- a/content.tex
+++ b/content.tex
@@ -2892,6 +2892,7 @@ \subsection{Feature bits}\label{sec:Device Types / Ne=
twork Device / Feature bits
=20
 \item[VIRTIO_NET_F_STANDBY(62)] Device may act as a standby for a primary
     device with the same MAC address.
+\item[VIRTIO_NET_F_SPEED_DUPLEX(63)] Device reports speed and duplex.
 \end{description}
=20
 \subsubsection{Feature bit requirements}\label{sec:Device Types / Network =
Device / Feature bits / Feature bit requirements}
@@ -2951,12 +2952,29 @@ \subsection{Device configuration layout}\label{sec:=
Device Types / Network Device
 VIRTIO_NET_F_MTU is set. This field specifies the maximum MTU for the driv=
er to
 use.
=20
+The following two fields, \field{speed} and \field{duplex} only
+exist if VIRTIO_NET_F_SPEED_DUPLEX is set.
+
+\field{speed} is the device speed, in units of 1MByte, 0 to
+0x7FFFF. Driver MUST also treat any
+other value as representing an unknown duplex state.
+
+\field{duplex} has the values of 0x00 for full duplex, 0x01 for
+half duplex and 0xff for unknown. Driver MUST also treat any
+other value as representing an unknown duplex state.
+
+Neither \field{speed} not \field{duplex} changes as long as
+VIRTIO_NET_S_LINK_UP is set.
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
@@ -2985,6 +3003,10 @@ \subsection{Device configuration layout}\label{sec:D=
evice Types / Network Device
 If the driver negotiates the VIRTIO_NET_F_STANDBY feature, the device MAY =
act
 as a standby device for a primary device with the same MAC address.
=20
+Device MUST NOT change the \field{speed} and \field{duplex}
+fields as long as VIRTIO_NET_S_LINK_UP is set in the
+\field{status}.
+
 \drivernormative{\subsubsection}{Device configuration layout}{Device Types=
 / Network Device / Device configuration layout}
=20
 A driver SHOULD negotiate VIRTIO_NET_F_MAC if the device offers it.
@@ -3009,6 +3031,10 @@ \subsection{Device configuration layout}\label{sec:D=
evice Types / Network Device
=20
 A driver SHOULD negotiate the VIRTIO_NET_F_STANDBY feature if the device o=
ffers it.
=20
+A driver MUST treat a value of \field{speed} above
+0x000000007fffffff as well as a value of \field{duplex} not
+matching 0x0 or 0x1 as an unknown value.
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

