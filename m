Return-Path: virtio-dev-return-6673-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2C08D985F09
	for <virtio-dev@lists.oasis-open.org>; Tue, 21 Jan 2020 06:19:54 +0000 (UTC)
From: Jing Liu <jing2.liu@linux.intel.com>
Date: Tue, 21 Jan 2020 21:54:32 +0800
Message-Id: <1579614873-21907-5-git-send-email-jing2.liu@linux.intel.com>
In-Reply-To: <1579614873-21907-1-git-send-email-jing2.liu@linux.intel.com>
References: <1579614873-21907-1-git-send-email-jing2.liu@linux.intel.com>
Subject: [virtio-dev] [PATCH v2 4/5] virtio-mmio: Introduce MSI details
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, Jing Liu <jing2.liu@linux.intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, Liu Jiang <gerry@linux.alibaba.com>, Zha Bin <zhabin@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

With VIRTIO_F_MMIO_MSI feature bit offered, the Message Signal
Interrupts (MSI) is supported as first priority. For any reason it
fails to use MSI, it need use the single dedicated interrupt as before.

For MSI vectors and events mapping relationship, introduce in next patch.

Co-developed-by: Chao Peng <chao.p.peng@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Co-developed-by: Liu Jiang <gerry@linux.alibaba.com>
Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
Co-developed-by: Zha Bin <zhabin@linux.alibaba.com>
Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
---
 content.tex | 171 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--=
----
 msi-state.c |   4 ++
 2 files changed, 159 insertions(+), 16 deletions(-)
 create mode 100644 msi-state.c

diff --git a/content.tex b/content.tex
index ff151ba..dcf6c71 100644
--- a/content.tex
+++ b/content.tex
@@ -1687,7 +1687,8 @@ \subsection{MMIO Device Register Layout}\label{sec:Vi=
rtio Transport Options / Vi
   \hline=20
   \mmioreg{InterruptStatus}{Interrupt status}{0x60}{R}{%
     Reading from this register returns a bit mask of events that
-    caused the device interrupt to be asserted.
+    caused the device interrupt to be asserted. This is only used
+    when MSI is not enabled.
     The following events are possible:
     \begin{description}
       \item[Used Buffer Notification] - bit 0 - the interrupt was asserted
@@ -1701,7 +1702,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Vi=
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
@@ -1760,6 +1761,47 @@ \subsection{MMIO Device Register Layout}\label{sec:V=
irtio Transport Options / Vi
     \field{SHMSel} is unused) results in a base address of
     0xffffffffffffffff.
   }
+  \hline
+  \mmioreg{MsiVecNum}{MSI max vector number}{0x0c0}{R}{%
+    When VIRTIO_F_MMIO_MSI has been negotiated, reading
+    from this register returns the maximum MSI vector number
+    that device supports.
+  }
+  \hline
+  \mmioreg{MsiState}{MSI state}{0x0c4}{R}{%
+    When VIRTIO_F_MMIO_MSI has been negotiated, reading
+    from this register returns the global MSI enable/disable status.
+    \lstinputlisting{msi-state.c}
+  }
+  \hline
+  \mmioreg{MsiCmd}{MSI command}{0x0c8}{W}{%
+    When VIRTIO_F_MMIO_MSI has been negotiated, writing
+    to this register executes the corresponding command to device.
+    Part of this applies to the MSI vector selected by writing to \field{M=
siVecSel}.
+    See \ref{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specif=
ic Initialization And Device Operation / Device Initialization / MSI Vector=
 Configuration}
+    for using details.
+  }
+  \hline
+  \mmioreg{MsiVecSel}{MSI vector index}{0x0d0}{W}{%
+    When VIRTIO_F_MMIO_MSI has been negotiated, writing
+    to this register selects the MSI vector index that the following opera=
tions
+    on \field{MsiAddrLow}, \field{MsiAddrHigh}, \field{MsiData} and part o=
f
+    \field{MsiCmd} commands specified in \ref{sec:Virtio Transport Options=
 / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / D=
evice Initialization / MSI Vector Configuration}
+    apply to. The index number of the first vector is zero (0x0).
+  }
+  \hline
+  \mmiodreg{MsiAddrLow}{MsiAddrHigh}{MSI 64 bit address}{0x0d4}{0x0d8}{W}{=
%
+    When VIRTIO_F_MMIO_MSI has been negotiated, writing
+    to these two registers (lower 32 bits of the address to \field{MsiAddr=
Low},
+    higher 32 bits to \field{MsiAddrHigh}) notifies the device about the
+    MSI address. This applies to the MSI vector selected by writing to \fi=
eld{MsiVecSel}.
+  }
+  \hline
+  \mmioreg{MsiData}{MSI 32 bit data}{0x0dc}{W}{%
+    When VIRTIO_F_MMIO_MSI has been negotiated, writing
+    to this register notifies the device about the MSI data.
+    This applies to the MSI vector selected by writing to \field{MsiVecSel=
}.
+  }
   \hline=20
   \mmioreg{ConfigGeneration}{Configuration atomicity value}{0x0fc}{R}{
     Reading from this register returns a value describing a version of the=
 device-specific configuration space (see \field{Config}).
@@ -1783,10 +1825,16 @@ \subsection{MMIO Device Register Layout}\label{sec:=
Virtio Transport Options / Vi
=20
 The device MUST return value 0x2 in \field{Version}.
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
te}.
=20
 Upon reset, the device MUST clear all bits in \field{InterruptStatus} and =
ready bits in the
 \field{QueueReady} register for all queues in the device.
@@ -1835,7 +1883,12 @@ \subsection{MMIO Device Register Layout}\label{sec:V=
irtio Transport Options / Vi
=20
 The driver MUST ignore undefined bits in \field{InterruptStatus}.
=20
-The driver MUST write a value with a bit mask describing events it handled=
 into \field{InterruptACK} when
+The driver MUST ignore undefined bits in the return value of reading \fiel=
d{MsiState}.
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
@@ -1856,6 +1909,63 @@ \subsubsection{Device Initialization}\label{sec:Virt=
io Transport Options / Virti
 Further initialization MUST follow the procedure described in
 \ref{sec:General Initialization And Device Operation / Device Initializati=
on}~\nameref{sec:General Initialization And Device Operation / Device Initi=
alization}.
=20
+\paragraph{MSI Vector Configuration}\label{sec:Virtio Transport Options / =
Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Devi=
ce Initialization / MSI Vector Configuration}
+The VIRTIO_F_MMIO_MSI feature bit offered by device shows the capability
+using MSI vectors for virtqueue and configuration events.
+
+When VIRTIO_F_MMIO_MSI has been negotiated,
+writing \field{MsiCmd} executes a corresponding command to the device:
+
+VIRTIO_MMIO_MSI_CMD_ENABLE and VIRTIO_MMIO_MSI_CMD_DISABLE commands set gl=
obal
+MSI enable and disable status.
+
+VIRTIO_MMIO_MSI_CMD_CONFIGURE is used to configure the MSI vector
+applying to the one selected by writing to \field{MsiVecSel}.
+
+VIRTIO_MMIO_MSI_CMD_MASK and VIRTIO_MMIO_MSI_CMD_UNMASK commands are used =
to
+mask and unmask the MSI vector applying to the one selected by writing
+to \field{MsiVecSel}.
+
+\begin{lstlisting}
+#define  VIRTIO_MMIO_MSI_CMD_ENABLE           0x1
+#define  VIRTIO_MMIO_MSI_CMD_DISABLE          0x2
+#define  VIRTIO_MMIO_MSI_CMD_CONFIGURE        0x3
+#define  VIRTIO_MMIO_MSI_CMD_MASK             0x4
+#define  VIRTIO_MMIO_MSI_CMD_UNMASK           0x5
+\end{lstlisting}
+
+Setting a special NO_VECTOR value means disabling an interrupt for an even=
t type.
+
+\begin{lstlisting}
+/* Vector value used to disable MSI for event */
+#define VIRTIO_MMIO_MSI_NO_VECTOR             0xffffffff
+\end{lstlisting}
+
+\drivernormative{\subparagraph}{MSI Vector Configuration}{Virtio Transport=
 Options / Virtio Over MMIO / MMIO-specific Initialization And Device Opera=
tion / MSI Vector Configuration}
+When VIRTIO_F_MMIO_MSI has been negotiated, driver should try to configure
+and enable MSI.
+
+To configure MSI vector, driver SHOULD firstly specify the MSI vector inde=
x by
+writing to \field{MsiVecSel}.
+Then notify the MSI address and data by writing to \field{MsiAddrLow}, \fi=
eld{MsiAddrHigh},
+and \field{MsiData}, and immediately follow a \field{MsiCmd} write operati=
on
+using VIRTIO_MMIO_MSI_CMD_CONFIGURE to device for configuring an event to
+this MSI vector.
+
+After all MSI vectors are configured, driver SHOULD set global MSI enabled
+by writing to \field{MsiCmd} using VIRTIO_MMIO_MSI_CMD_ENABLE.
+
+Driver should use VIRTIO_MMIO_MSI_CMD_DISABLE when disabling MSI.
+
+Driver should use VIRTIO_MMIO_MSI_CMD_MASK with an MSI index \field{MsiVec=
Sel}
+to prohibit the event from the corresponding interrupt source.
+
+Driver should use VIRTIO_MMIO_MSI_CMD_UNMASK with an MSI index \field{MsiV=
ecSel}
+to recover the event from the corresponding interrupt source.
+
+If driver fails to setup any event with a vector,
+it MUST disable MSI by \field{MsiCmd} and use the single dedicated interru=
pt for device.
+
 \subsubsection{Notification Structure Layout}\label{sec:Virtio Transport O=
ptions / Virtio Over MMIO / MMIO-specific Initialization And Device Operati=
on / Notification Structure Layout}
=20
 When VIRTIO_F_MMIO_NOTIFICATION has been negotiated, the notification loca=
tion is calculated
@@ -1908,6 +2018,12 @@ \subsubsection{Virtqueue Configuration}\label{sec:Vi=
rtio Transport Options / Vir
    \field{QueueDriverLow}/\field{QueueDriverHigh} and
    \field{QueueDeviceLow}/\field{QueueDeviceHigh} register pairs.
=20
+\item Write MSI address \field{MsiAddrLow}/\field{MsiAddrHigh},
+MSI data \field{MsiData} and MSI update command \field{MsiCtrlStat} with c=
orresponding
+virtqueue index to update
+MSI configuration for device requesting interrupts triggered by
+virtqueue events.
+
 \item Write 0x1 to \field{QueueReady}.
 \end{enumerate}
=20
@@ -1932,20 +2048,43 @@ \subsubsection{Available Buffer Notifications}\labe=
l{sec:Virtio Transport Option
=20
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
diff --git a/msi-state.c b/msi-state.c
new file mode 100644
index 0000000..b1fa0c1
--- /dev/null
+++ b/msi-state.c
@@ -0,0 +1,4 @@
+le32 {
+    msi_enabled : 1;
+    reserved : 31;
+};
--=20
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

