Return-Path: virtio-dev-return-6551-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B31D9985F55
	for <virtio-dev@lists.oasis-open.org>; Fri, 20 Dec 2019 07:45:46 +0000 (UTC)
From: Jing Liu <jing2.liu@linux.intel.com>
Date: Fri, 20 Dec 2019 23:25:03 +0800
Message-Id: <1576855504-34947-1-git-send-email-jing2.liu@linux.intel.com>
Subject: [virtio-dev][PATCH v1 1/2] virtio-mmio: Add MSI and different notification address support
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
Cc: slp@redhat.com, linux-kernel@vger.kernel.org, Jing Liu <jing2.liu@linux.intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, Zha Bin <zhabin@linux.alibaba.com>, Liu Jiang <gerry@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Upgrade virtio-mmio to version 3, with the abilities to support
MSI interrupt and notification features.

The details of version 2 will be appended as part of legacy interface
in next patch.

Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
---
 content.tex  | 191 ++++++++++++++++++++++++++++++++++++++++++++++++-------=
----
 msi-status.c |   5 ++
 2 files changed, 163 insertions(+), 33 deletions(-)
 create mode 100644 msi-status.c

diff --git a/content.tex b/content.tex
index d68cfaf..eaaffec 100644
--- a/content.tex
+++ b/content.tex
@@ -1597,9 +1597,9 @@ \subsection{MMIO Device Register Layout}\label{sec:Vi=
rtio Transport Options / Vi
   }=20
   \hline
   \mmioreg{Version}{Device version number}{0x004}{R}{%
-    0x2.
+    0x3.
     \begin{note}
-      Legacy devices (see \ref{sec:Virtio Transport Options / Virtio Over =
MMIO / Legacy interface}~\nameref{sec:Virtio Transport Options / Virtio Ove=
r MMIO / Legacy interface}) used 0x1.
+      Legacy devices (see \ref{sec:Virtio Transport Options / Virtio Over =
MMIO / Legacy interface}~\nameref{sec:Virtio Transport Options / Virtio Ove=
r MMIO / Legacy interface}) used 0x1 or 0x2.
     \end{note}
   }
   \hline=20
@@ -1671,25 +1671,23 @@ \subsection{MMIO Device Register Layout}\label{sec:=
Virtio Transport Options / Vi
     accesses apply to the queue selected by writing to \field{QueueSel}.
   }
   \hline=20
-  \mmioreg{QueueNotify}{Queue notifier}{0x050}{W}{%
-    Writing a value to this register notifies the device that
-    there are new buffers to process in a queue.
+  \mmioreg{QueueNotify}{Queue notifier}{0x050}{RW}{%
+    Reading from the register returns the virtqueue notification configura=
tion.
=20
-    When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
-    the value written is the queue index.
+    See \ref{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specif=
ic Initialization And Device Operation / Notification Address}
+    for the configuration format.
=20
-    When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
-    the \field{Notification data} value has the following format:
+    Writing when the notification address calculated by the notification c=
onfiguration
+    is just located at this register.
=20
-    \lstinputlisting{notifications-le.c}
-
-    See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec:Virtqueue=
s / Driver notifications}
-    for the definition of the components.
+    See \ref{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specif=
ic Initialization And Device Operation / Available Buffer Notifications}
+    to see the notification data format.
   }
   \hline=20
   \mmioreg{InterruptStatus}{Interrupt status}{0x60}{R}{%
     Reading from this register returns a bit mask of events that
-    caused the device interrupt to be asserted.
+    caused the device interrupt to be asserted. This is only used
+    when MSI is not enabled.
     The following events are possible:
     \begin{description}
       \item[Used Buffer Notification] - bit 0 - the interrupt was asserted
@@ -1703,7 +1701,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Vi=
rtio Transport Options / Vi
   \mmioreg{InterruptACK}{Interrupt acknowledge}{0x064}{W}{%
     Writing a value with bits set as defined in \field{InterruptStatus}
     to this register notifies the device that events causing
-    the interrupt have been handled.
+    the interrupt have been handled. This is only used when MSI is not ena=
bled.
   }
   \hline=20
   \mmioreg{Status}{Device status}{0x070}{RW}{%
@@ -1762,6 +1760,31 @@ \subsection{MMIO Device Register Layout}\label{sec:V=
irtio Transport Options / Vi
     \field{SHMSel} is unused) results in a base address of
     0xffffffffffffffff.
   }
+  \hline
+  \mmioreg{MsiStatus}{MSI status}{0x0c0}{R}{%
+    Reading from this register returns the global MSI enable/disable statu=
s and maximum
+    number of virtqueues that device supports.
+    \lstinputlisting{msi-status.c}
+  }
+  \hline
+  \mmioreg{MsiCmd}{MSI command}{0x0c2}{W}{%
+    The driver writes to this register with appropriate operators and argu=
ments to
+    execute MSI command to device.
+    Operators supported is setting global MSI enable/disable status
+    and updating MSI configuration to device.
+    See \ref{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specif=
ic Initialization And Device Operation / Device Initialization / MSI Vector=
 Configuration}
+    for how to use this register.
+  }
+  \hline
+  \mmiodreg{MsiAddrLow}{MsiAddrHigh}{MSI 64 bit address}{0x0c4}{0x0c8}{W}{=
%
+    Writing to these two registers (lower 32 bits of the address to \field=
{MsiAddrLow},
+    higher 32 bits to \field{MsiAddrHigh}) notifies the device about the
+    MSI address.
+  }
+  \hline
+  \mmioreg{MsiData}{MSI 32 bit data}{0x0cc}{W}{%
+    Writing to this register notifies the device about the MSI data.
+  }
   \hline=20
   \mmioreg{ConfigGeneration}{Configuration atomicity value}{0x0fc}{R}{
     Reading from this register returns a value describing a version of the=
 device-specific configuration space (see \field{Config}).
@@ -1783,12 +1806,18 @@ \subsection{MMIO Device Register Layout}\label{sec:=
Virtio Transport Options / Vi
=20
 The device MUST return 0x74726976 in \field{MagicValue}.
=20
-The device MUST return value 0x2 in \field{Version}.
+The device MUST return value 0x3 in \field{Version}.
=20
-The device MUST present each event by setting the corresponding bit in \fi=
eld{InterruptStatus} from the
+When MSI is disabled, the device MUST present each event by setting the
+corresponding bit in \field{InterruptStatus} from the
 moment it takes place, until the driver acknowledges the interrupt
-by writing a corresponding bit mask to the \field{InterruptACK} register. =
 Bits which
-do not represent events which took place MUST be zero.
+by writing a corresponding bit mask to the \field{InterruptACK} register.
+Bits which do not represent events which took place MUST be zero.
+
+When MSI is enabled, the device MUST NOT set \field{InterruptStatus} and M=
UST
+ignore \field{InterruptACK}.
+
+Upon reset, the device MUST clear \field{msi_enabled} bit in \field{MsiSta=
tus}.
=20
 Upon reset, the device MUST clear all bits in \field{InterruptStatus} and =
ready bits in the
 \field{QueueReady} register for all queues in the device.
@@ -1814,7 +1843,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Vi=
rtio Transport Options / Vi
 The driver MUST ignore a device with \field{MagicValue} which is not 0x747=
26976,
 although it MAY report an error.
=20
-The driver MUST ignore a device with \field{Version} which is not 0x2,
+The driver MUST ignore a device with \field{Version} which is not 0x3,
 although it MAY report an error.
=20
 The driver MUST ignore a device with \field{DeviceID} 0x0,
@@ -1837,7 +1866,12 @@ \subsection{MMIO Device Register Layout}\label{sec:V=
irtio Transport Options / Vi
=20
 The driver MUST ignore undefined bits in \field{InterruptStatus}.
=20
-The driver MUST write a value with a bit mask describing events it handled=
 into \field{InterruptACK} when
+The driver MUST ignore undefined bits in \field{MsiStatus}.
+
+When MSI is enabled, the driver MUST NOT access \field{InterruptStatus} an=
d MUST NOT write to \field{InterruptACK}.
+
+When MSI is disabled, the driver MUST write a value with a bit mask
+describing events it handled into \field{InterruptACK} when
 it finishes handling an interrupt and MUST NOT set any of the undefined bi=
ts in the value.
=20
 \subsection{MMIO-specific Initialization And Device Operation}\label{sec:V=
irtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization A=
nd Device Operation}
@@ -1858,6 +1892,65 @@ \subsubsection{Device Initialization}\label{sec:Virt=
io Transport Options / Virti
 Further initialization MUST follow the procedure described in
 \ref{sec:General Initialization And Device Operation / Device Initializati=
on}~\nameref{sec:General Initialization And Device Operation / Device Initi=
alization}.
=20
+\paragraph{MSI Vector Configuration}\label{sec:Virtio Transport Options / =
Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Devi=
ce Initialization / MSI Vector Configuration}
+The MSI vectors and interrupt events have fixed relationships.
+The first vector is for device configuraiton
+change event, the second vector is for virtqueue 1, the third vector
+is for virtqueue 2 and so on.
+
+The 16-bit \field{MsiCmd} register including command operator and command =
argument is used
+to configure MSI vectors and set global MSI enable/disable status.
+\begin{lstlisting}
+le16 {
+    cmd_arg : 12;
+    cmd_op : 4;
+};
+\end{lstlisting}
+
+The \field{cmd_op} specifies the detailed command operator defined as foll=
ows.
+\begin{lstlisting}
+#define  VIRTIO_MMIO_MSI_CMD_UPDATE           0x1
+#define  VIRTIO_MMIO_MSI_CMD_ENABLE           0x2
+\end{lstlisting}
+
+\drivernormative{\subparagraph}{MSI Vector Configuration}{Virtio Transport=
 Options / Virtio Over MMIO / MMIO-specific Initialization And Device Opera=
tion / MSI Vector Configuration}
+To configure MSI vector, driver SHOULD firstly notify the MSI address and =
data by
+writing to \field{MsiAddrLow}, \field{MsiAddrHigh},
+and \field{MsiData}, and immediately follow a \field{MsiCmd} write operati=
on
+using VIRTIO_MMIO_MSI_CMD_UPDATE with corresponding
+virtual queue index as \field{cmd_arg} to device for configuring an event =
to this MSI vector.
+
+After all MSI vectors are configured, driver SHOULD set global MSI enabled
+by writing to \field{MsiCmd} using VIRTIO_MMIO_MSI_CMD_ENABLE
+with one (0x1) as \field{cmd_arg} to device.
+
+Driver should use VIRTIO_MMIO_MSI_CMD_ENABLE with status zero (0x0) when d=
isabling MSI.
+
+If driver fails to setup any event with a vector,
+it MUST disable MSI by \field{MsiCmd} and use single interrupt for device.
+
+\subsubsection{Notification Address}\label{sec:Virtio Transport Options / =
Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Noti=
fication Address}
+
+The notification location is calculated by notification structure. Driver =
reads \field{QueueNotify} to get this structure formatted as follows.
+
+\begin{lstlisting}
+le32 {
+        notify_base : 16;
+        notify_multiplier : 16;
+};
+\end{lstlisting}
+
+\field{notify_multiplier} is combined with virtqueue index to derive the Q=
ueue Notify address
+within a memory mapped control registers for a virtqueue:
+
+\begin{lstlisting}
+        notify_base + queue_index * notify_multiplier
+\end{lstlisting}
+
+\begin{note}
+The nofication address may be just located at the \field{QueueNotify}.
+\end{note}
+
 \subsubsection{Virtqueue Configuration}\label{sec:Virtio Transport Options=
 / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / V=
irtqueue Configuration}
=20
 The driver will typically initialize the virtual queue in the following wa=
y:
@@ -1885,6 +1978,12 @@ \subsubsection{Virtqueue Configuration}\label{sec:Vi=
rtio Transport Options / Vir
    \field{QueueDriverLow}/\field{QueueDriverHigh} and
    \field{QueueDeviceLow}/\field{QueueDeviceHigh} register pairs.
=20
+\item Write MSI address \field{MsiAddrLow}/\field{MsiAddrHigh},
+MSI data \field{MsiData} and MSI update command \field{MsiCmd} with corres=
ponding
+virtqueue index to update
+MSI configuration for device requesting interrupts triggered by
+virtqueue events.
+
 \item Write 0x1 to \field{QueueReady}.
 \end{enumerate}
=20
@@ -1893,32 +1992,58 @@ \subsubsection{Available Buffer Notifications}\labe=
l{sec:Virtio Transport Option
 When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
 the driver sends an available buffer notification to the device by writing
 the 16-bit virtqueue index
-of the queue to be notified to \field{QueueNotify}.
+of the queue to be notified to Queue Notify address.
=20
 When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
 the driver sends an available buffer notification to the device by writing
-the following 32-bit value to \field{QueueNotify}:
+the following 32-bit value to Queue Notify address:
 \lstinputlisting{notifications-le.c}
=20
 See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec:Virtqueues / =
Driver notifications}
 for the definition of the components.
=20
+See \ref{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific I=
nitialization And Device Operation / Notification Address}
+for how to calculate the Queue Notify address.
+
 \subsubsection{Notifications From The Device}\label{sec:Virtio Transport O=
ptions / Virtio Over MMIO / MMIO-specific Initialization And Device Operati=
on / Notifications From The Device}
=20
-The memory mapped virtio device is using a single, dedicated
+If MSI is enabled, the memory mapped virtio
+device uses appropriate MSI interrupt message
+for configuration change notification and used buffer notification which a=
re
+configured by \field{MsiAddrLow}, \field{MsoAddrHigh} and \field{MsiData}.
+
+If MSI is not enabled, the memory mapped virtio device
+uses a single, dedicated
 interrupt signal, which is asserted when at least one of the
 bits described in the description of \field{InterruptStatus}
-is set. This is how the device sends a used buffer notification
-or a configuration change notification to the device.
+is set.
=20
 \drivernormative{\paragraph}{Notifications From The Device}{Virtio Transpo=
rt Options / Virtio Over MMIO / MMIO-specific Initialization And Device Ope=
ration / Notifications From The Device}
-After receiving an interrupt, the driver MUST read
-\field{InterruptStatus} to check what caused the interrupt (see the
-register description).  The used buffer notification bit being set
-SHOULD be interpreted as a used buffer notification for each active
-virtqueue.  After the interrupt is handled, the driver MUST acknowledge
-it by writing a bit mask corresponding to the handled events to the
-InterruptACK register.
+A driver MUST handle the case where MSI is disabled, which uses the same i=
nterrupt indicating both device configuration
+space change and one or more virtqueues being used.
+
+\subsubsection{Driver Handling Interrupts}\label{sec:Virtio Transport Opti=
ons / Virtio Over MMIO / MMIO-specific Initialization And Device Operation =
/ Driver Handling Interrupts}
+
+The driver interrupt handler would typically:
+
+\begin{itemize}
+  \item If MSI is enabled:
+    \begin{itemize}
+      \item
+        Figure out the virtqueue mapped to that MSI vector for the
+        device, to see if any progress has been made by the device
+        which requires servicing.
+      \item
+        If the interrupt belongs to configuration space changing signal,
+        re-examine the configuration space to see what changed.
+    \end{itemize}
+  \item If MSI is disabled:
+    \begin{itemize}
+      \item Read \field{InterruptStatus} to check what caused the interrup=
t.
+      \item Acknowledge the interrupt by writing a bit mask corresponding
+            to the handled events to the InterruptACK register.
+    \end{itemize}
+\end{itemize}
=20
 \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio =
Over MMIO / Legacy interface}
=20
diff --git a/msi-status.c b/msi-status.c
new file mode 100644
index 0000000..f3bd0ec
--- /dev/null
+++ b/msi-status.c
@@ -0,0 +1,5 @@
+le16 {
+    max_queue_num : 11;
+    reserved : 4;
+    msi_enabled: 1;
+};
--=20
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

