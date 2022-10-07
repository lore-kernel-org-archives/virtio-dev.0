Return-Path: <virtio-dev-return-10002-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7E2F39864BD
	for <virtio-dev@lists.oasis-open.org>; Fri,  7 Oct 2022 16:57:00 +0000 (UTC)
From: Usama Arif <usama.arif@bytedance.com>
Date: Fri,  7 Oct 2022 17:56:41 +0100
Message-Id: <20221007165643.3920613-3-usama.arif@bytedance.com>
In-Reply-To: <20221007165643.3920613-1-usama.arif@bytedance.com>
References: <20221007165643.3920613-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v3 2/4] content: Introduce driver/device aux. notification cfg type for PCI
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: virtio-dev@lists.oasis-open.org
Cc: mst@redhat.com, stefanha@redhat.com, ndragazis@arrikto.com, fam.zheng@bytedance.com, liangma@liangbit.com, Usama Arif <usama.arif@bytedance.com>
List-ID: <virtio-dev.lists.oasis-open.org>

This includes the PCI device conformances for these notification
capabilities.

Signed-off-by: Usama Arif <usama.arif@bytedance.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
---
 conformance.tex |   2 +
 content.tex     | 191 ++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 171 insertions(+), 22 deletions(-)

diff --git a/conformance.tex b/conformance.tex
index c3c1d3e..f6914b0 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -370,6 +370,8 @@ \section{Conformance Targets}\label{sec:Conformance / C=
onformance Targets}
 \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus =
/ PCI Device Layout / Notification capability}
 \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus =
/ PCI Device Layout / ISR status capability}
 \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus =
/ PCI Device Layout / Device-specific configuration}
+\item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus =
/ PCI Device Layout / Device auxiliary notification capability}
+\item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus =
/ PCI Device Layout / Driver auxiliary notification capability}
 \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus =
/ PCI Device Layout / Shared memory capability}
 \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus =
/ PCI Device Layout / PCI configuration access capability}
 \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus =
/ PCI-specific Initialization And Device Operation / Device Initialization =
/ Non-transitional Device With Legacy Driver}
diff --git a/content.tex b/content.tex
index 49f9f2a..33362b7 100644
--- a/content.tex
+++ b/content.tex
@@ -719,6 +719,8 @@ \subsection{Virtio Structure PCI Capabilities}\label{se=
c:Virtio Transport Option
 \item ISR Status
 \item Device-specific configuration (optional)
 \item PCI configuration access
+\item Driver auxiliary notifications (optional)
+\item Device auxiliary notifications (optional)
 \end{itemize}
=20
 Each structure can be mapped by a Base Address register (BAR) belonging to
@@ -765,19 +767,23 @@ \subsection{Virtio Structure PCI Capabilities}\label{=
sec:Virtio Transport Option
=20
 \begin{lstlisting}
 /* Common configuration */
-#define VIRTIO_PCI_CAP_COMMON_CFG        1
+#define VIRTIO_PCI_CAP_COMMON_CFG             1
 /* Notifications */
-#define VIRTIO_PCI_CAP_NOTIFY_CFG        2
+#define VIRTIO_PCI_CAP_NOTIFY_CFG             2
 /* ISR Status */
-#define VIRTIO_PCI_CAP_ISR_CFG           3
+#define VIRTIO_PCI_CAP_ISR_CFG                3
 /* Device specific configuration */
-#define VIRTIO_PCI_CAP_DEVICE_CFG        4
+#define VIRTIO_PCI_CAP_DEVICE_CFG             4
 /* PCI configuration access */
-#define VIRTIO_PCI_CAP_PCI_CFG           5
+#define VIRTIO_PCI_CAP_PCI_CFG                5
+/* Device auxiliary notification */
+#define VIRTIO_PCI_CAP_DEVICE_AUX_NOTIFY_CFG  6
+/* Driver auxiliary notification */
+#define VIRTIO_PCI_CAP_DRIVER_AUX_NOTIFY_CFG  7
 /* Shared memory region */
-#define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
+#define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG      8
 /* Vendor-specific data */
-#define VIRTIO_PCI_CAP_VENDOR_CFG        9
+#define VIRTIO_PCI_CAP_VENDOR_CFG             9
 \end{lstlisting}
=20
         Any other value is reserved for future use.
@@ -1158,11 +1164,11 @@ \subsubsection{ISR status capability}\label{sec:Vir=
tio Transport Options / Virti
 The ISR bits allow the driver to distinguish between device-specific confi=
guration
 change interrupts and normal virtqueue interrupts:
=20
-\begin{tabular}{ |l||l|l|l| }
+\begin{tabular}{ |l||l|l|l|l| }
 \hline
-Bits       & 0                               & 1               &  2 to 31 =
\\
+Bits       & 0                               & 1                          =
      & 2                      & 3 to 31 \\
 \hline
-Purpose    & Queue Interrupt  & Device Configuration Interrupt & Reserved =
\\
+Purpose    & Queue Interrupt  & Device Configuration Interrupt & Driver Au=
xiliary Notification Interrupt & Reserved \\
 \hline
 \end{tabular}
=20
@@ -1208,6 +1214,135 @@ \subsubsection{Device-specific configuration}\label=
{sec:Virtio Transport Options
=20
 The \field{offset} for the device-specific configuration MUST be 4-byte al=
igned.
=20
+\subsubsection{Device auxiliary notification capability}\label{sec:Virtio =
Transport Options / Virtio Over PCI Bus / PCI Device Layout / Device auxili=
ary notification capability}
+
+The device auxiliary notification \ref{sec:Basic Facilities of a Virtio De=
vice / Notifications}
+location is found using the VIRTIO_PCI_CAP_DEVICE_AUX_NOTIFY_CFG capabilit=
y. This
+capability is immediately followed by an additional field, like so:
+
+\begin{lstlisting}
+struct virtio_pci_dev_aux_notification_cap {
+        struct virtio_pci_cap cap;
+        le32 dev_aux_notification_off_multiplier;
+};
+\end{lstlisting}
+
+The device auxiliary notification address within a BAR is calculated as fo=
llows:
+
+\begin{lstlisting}
+cap.offset + dev_aux_notification_idx * dev_aux_notification_off_multiplie=
r
+\end{lstlisting}
+
+The \field{cap.offset} and \field{dev_aux_notification_off_multiplier} are=
 taken
+from the device auxiliary notification capability structure above, and the
+\field{dev_aux_notification_idx} is the device auxiliary notification inde=
x.
+There is no restriction for the mapping between device auxiliary notificat=
ions
+and dev_aux_notification_idx. The number of device auxiliary notifications=
 and
+their purpose is device-specific.
+
+\devicenormative{\paragraph}{Device auxiliary notification capability}{Vir=
tio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Device au=
xiliary notification capability}
+
+The data width of the device auxiliary notifications is device specific.
+
+For devices that provide a data width of 1 byte:
+
+The \field{cap.offset} MUST be byte aligned.
+
+The value \field{cap.length} presented by the device MUST be at least 1
+and MUST be large enough to support device auxiliary notification offsets =
for all supported
+device auxiliary notifications in all possible configurations.
+
+The value \field{cap.length} presented by the device MUST satisfy:
+
+\begin{lstlisting}
+cap.length >=3D max_dev_aux_notification_idx * dev_aux_notification_off_mu=
ltiplier + 1
+\end{lstlisting}
+
+where \field{max_dev_aux_notification_idx} is the maximum device auxiliary
+notification index and is dependent on the device.
+
+For devices that provide a data width of 2 bytes:
+
+The \field{cap.offset} MUST be 2-byte aligned.
+
+The device MUST either present \field{dev_aux_notification_off_multiplier}=
 as an
+even power of 2, or present \field{dev_aux_notification_off_multiplier} as=
 0.
+
+The value \field{cap.length} presented by the device MUST be at least 2
+and MUST be large enough to support device auxiliary notification offsets =
for
+all supported device auxiliary notifications in all possible configuration=
s.
+
+The value \field{cap.length} presented by the device MUST satisfy:
+
+\begin{lstlisting}
+cap.length >=3D max_dev_aux_notification_idx * dev_aux_notification_off_mu=
ltiplier + 2
+\end{lstlisting}
+
+where \field{max_dev_aux_notification_idx} is the maximum device auxiliary
+notification index and is dependent on the device.
+
+For devices that provide a data width of 4 bytes:
+
+The \field{cap.offset} MUST be 4-byte aligned.
+
+The device MUST either present \field{dev_aux_notification_off_multiplier}=
 as a
+number that is a power of 2 that is also a multiple 4, or present
+\field{dev_aux_notification_off_multiplier} as 0.
+
+The value \field{cap.length} presented by the device MUST be at least 4
+and MUST be large enough to support device auxiliary notification offsets =
for all supported
+device auxiliary notifications in all possible configurations.
+
+The value \field{cap.length} presented by the device MUST satisfy:
+
+\begin{lstlisting}
+cap.length >=3D max_dev_aux_notification_idx * dev_aux_notification_off_mu=
ltiplier + 4
+\end{lstlisting}
+
+where \field{max_dev_aux_notification_idx} is the maximum device auxiliary
+notification index and is dependent on the device.
+
+\subsubsection{Driver auxiliary notification capability}\label{sec:Virtio =
Transport Options / Virtio Over PCI Bus / PCI Device Layout / Driver auxili=
ary notification capability}
+
+The Driver auxiliary notification
+\ref{sec:Basic Facilities of a Virtio Device / Notifications} location
+is found using the VIRTIO_PCI_CAP_DRIVER_AUX_NOTIFY_CFG capability. The
+driver auxiliary notification structure allows MSI-X vectors to be
+configured for notification interrupts. If MSI-X is not available, bit 2
+of the ISR status \ref{sec:Virtio Transport Options / Virtio Over PCI
+Bus / PCI Device Layout / ISR status capability} indicates that a
+driver auxiliary notification occurred. If MSI-X is not available,
+it is not possible to determine which driver auxiliary notification occure=
d,
+hence only a single notification is supported.
+
+The driver auxiliary notification structure is the following:
+
+\begin{lstlisting}
+struct virtio_pci_driver_aux_notification_cfg {
+=09le16 driver_aux_notification_select;              /* read-write */
+=09le16 driver_aux_notification_msix_vector;         /* read-write */
+};
+\end{lstlisting}
+
+The driver indicates which notification is of interest by writing the
+\field{driver_aux_notification_select} field. The driver then writes the M=
SI-X
+vector or VIRTIO_MSI_NO_VECTOR to \field{driver_aux_notification_msix_vect=
or} to
+change the MSI-X vector for that notification.
+
+The mapping between notifications and notification indices is
+device-specific. The total number of notifications is also
+device-specific.
+
+\devicenormative{\paragraph}{Driver auxiliary notification capability}{Vir=
tio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Driver au=
xiliary notification capability}
+
+Device MUST ignore writes to \field{driver_aux_notification_msix_vector} i=
f the
+value written to \field{driver_aux_notification_select} is not a valid not=
ification
+index.
+
+Device MUST return VIRTIO_MSI_NO_VECTOR for reads from
+\field{driver_aux_notification_msix_vector} if the value written to
+\field{driver_aux_notification_select} is not a valid notification index.
+
 \subsubsection{Shared memory capability}\label{sec:Virtio Transport Option=
s / Virtio Over PCI Bus / PCI Device Layout / Shared memory capability}
=20
 Shared memory regions \ref{sec:Basic Facilities of a Virtio
@@ -1519,15 +1654,17 @@ \subsubsection{Device Initialization}\label{sec:Vir=
tio Transport Options / Virti
 \paragraph{MSI-X Vector Configuration}\label{sec:Virtio Transport Options =
/ Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / =
Device Initialization / MSI-X Vector Configuration}
=20
 When MSI-X capability is present and enabled in the device
-(through standard PCI configuration space) \field{config_msix_vector} and =
\field{queue_msix_vector} are used to map configuration change and queue
-interrupts to MSI-X vectors. In this case, the ISR Status is unused.
+(through standard PCI configuration space) \field{config_msix_vector},
+\field{queue_msix_vector} and \field{driver_aux_notification_msix_vector} =
are used
+to map configuration change, queue and device-specific interrupts to
+MSI-X vectors respectively. In this case, the ISR Status is unused.
=20
 Writing a valid MSI-X Table entry number, 0 to 0x7FF, to
-\field{config_msix_vector}/\field{queue_msix_vector} maps interrupts trigg=
ered
-by the configuration change/selected queue events respectively to
-the corresponding MSI-X vector. To disable interrupts for an
-event type, the driver unmaps this event by writing a special NO_VECTOR
-value:
+\field{config_msix_vector}/\field{queue_msix_vector}/\field{driver_aux_not=
ification_msix_vector}
+maps interrupts triggered by the configuration change/selected
+queue/device-specific events respectively to the corresponding MSI-X
+vector. To disable interrupts for an event type, the driver unmaps this
+event by writing a special NO_VECTOR value:
=20
 \begin{lstlisting}
 /* Vector value used to disable MSI for queue */
@@ -1541,6 +1678,14 @@ \subsubsection{Device Initialization}\label{sec:Virt=
io Transport Options / Virti
=20
 A device that has an MSI-X capability SHOULD support at least 2
 and at most 0x800 MSI-X vectors.
+
+A device that has an MSI-X capability MUST support atleast:
+\begin{lstlisting}
+num_msix_vectors >=3D 1 /* config_msix_vector */ + num_vqs /* queue_msix_v=
ectors */ + num_driver_aux_notifications
+\end{lstlisting}
+where num_vqs is the number of virtqueues and num_driver_aux_notifications=
 is
+the number of driver auxiliary notifications.
+
 Device MUST report the number of vectors supported in
 \field{Table Size} in the MSI-X Capability as specified in
 \hyperref[intro:PCI]{[PCI]}.
@@ -1554,16 +1699,18 @@ \subsubsection{Device Initialization}\label{sec:Vir=
tio Transport Options / Virti
 vector 0 to MSI-X \field{Table Size}.
 Device MUST support unmapping any event type.
=20
-The device MUST return vector mapped to a given event,
-(NO_VECTOR if unmapped) on read of \field{config_msix_vector}/\field{queue=
_msix_vector}.
-The device MUST have all queue and configuration change
-events are unmapped upon reset.
+The device MUST return the vector mapped to a given event,
+(NO_VECTOR if unmapped) on read of
+\field{config_msix_vector}/\field{queue_msix_vector}/\field{driver_aux_not=
ification_msix_vector}.
+The device MUST have all queue/configuration change/device-specific
+events unmapped upon reset.
=20
 Devices SHOULD NOT cause mapping an event to vector to fail
 unless it is impossible for the device to satisfy the mapping
 request.  Devices MUST report mapping
 failures by returning the NO_VECTOR value when the relevant
-\field{config_msix_vector}/\field{queue_msix_vector} field is read.=20
+\field{config_msix_vector}/\field{queue_msix_vector}/\field{driver_aux_not=
ification_msix_vector}
+field is read.
=20
 \drivernormative{\subparagraph}{MSI-X Vector Configuration}{Virtio Transpo=
rt Options / Virtio Over PCI Bus / PCI-specific Initialization And Device O=
peration / Device Initialization / MSI-X Vector Configuration}
=20
--=20
2.25.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

