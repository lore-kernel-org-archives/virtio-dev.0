Return-Path: virtio-dev-return-6552-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4B275985F55
	for <virtio-dev@lists.oasis-open.org>; Fri, 20 Dec 2019 07:45:59 +0000 (UTC)
From: Jing Liu <jing2.liu@linux.intel.com>
Date: Fri, 20 Dec 2019 23:25:04 +0800
Message-Id: <1576855504-34947-2-git-send-email-jing2.liu@linux.intel.com>
In-Reply-To: <1576855504-34947-1-git-send-email-jing2.liu@linux.intel.com>
References: <1576855504-34947-1-git-send-email-jing2.liu@linux.intel.com>
Subject: [virtio-dev][PATCH v1 2/2] virtio-mmio: Append version 2 interface
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
Cc: slp@redhat.com, linux-kernel@vger.kernel.org, Jing Liu <jing2.liu@linux.intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, Zha Bin <zhabin@linux.alibaba.com>, Liu Jiang <gerry@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Version 2 needs to be appended together with version 1 as legacy
interface since we introduce the latest version.

Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
---
 content.tex | 123 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+---
 1 file changed, 117 insertions(+), 6 deletions(-)

diff --git a/content.tex b/content.tex
index eaaffec..faf74de 100644
--- a/content.tex
+++ b/content.tex
@@ -2047,18 +2047,129 @@ \subsubsection{Driver Handling Interrupts}\label{s=
ec:Virtio Transport Options /
=20
 \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio =
Over MMIO / Legacy interface}
=20
-The legacy MMIO transport used page-based addressing, resulting
+\subsubsection{Version 2}\label{sec:Virtio Transport Options / Virtio Over=
 MMIO / MMIO-specific Initialization And Device Operation / Version 2}
+
+The version 2 MMIO transport used single interrupt number and signel notif=
ication address,
+resulting in a slightly different control register layout, the device init=
ialization and
+interrupt event configuration procedure from later version.
+
+Table \ref{tab:Virtio Trasport Options / Virtio Over MMIO / Version 2 MMIO=
 Device Register Layout}
+presents control registers layout, omitting
+descriptions of registers which did not change their function
+nor behaviour:
+
+\begin{longtable}{p{0.2\textwidth}p{0.7\textwidth}}
+  \caption {Version 2 MMIO Device Register Layout}
+  \label{tab:Virtio Trasport Options / Virtio Over MMIO / Version 2 MMIO D=
evice Register Layout} \\
+  \hline
+  \mmioreg{Name}{Function}{Offset from base}{Direction}{Description}
+  \hline
+  \hline
+  \endfirsthead
+  \hline
+  \mmioreg{Name}{Function}{Offset from the base}{Direction}{Description}
+  \hline
+  \hline
+  \endhead
+  \endfoot
+  \endlastfoot
+  \mmioreg{MagicValue}{Magic value}{0x000}{R}{}
+  \hline
+  \mmioreg{Version}{Device version number}{0x004}{R}{Device returns value =
0x2.}
+  \hline
+  \mmioreg{DeviceID}{Virtio Subsystem Device ID}{0x008}{R}{}
+  \hline
+  \mmioreg{VendorID}{Virtio Subsystem Vendor ID}{0x00c}{R}{}
+  \hline
+  \mmioreg{DeviceFeatures}{Flags representing features the device supports=
}{0x010}{R}{}
+  \hline
+  \mmioreg{DeviceFeaturesSel}{Device (host) features word selection.}{0x01=
4}{W}{}
+  \hline
+  \mmioreg{DriverFeatures}{Flags representing device features understood a=
nd activated by the driver}{0x020}{W}{}
+  \hline
+  \mmioreg{DriverFeaturesSel}{Activated (guest) features word selection}{0=
x024}{W}{}
+  \hline
+  \mmioreg{QueueSel}{Virtual queue index}{0x030}{W}{}
+  \hline
+  \mmioreg{QueueNumMax}{Maximum virtual queue size}{0x034}{R}{}
+  \hline
+  \mmioreg{QueueNum}{Virtual queue size}{0x038}{W}{}
+  \hline
+  \mmioreg{QueueReady}{Virtual queue ready bit}{0x044}{RW}{}
+  \hline
+  \mmioreg{QueueNotify}{Queue notifier}{0x050}{RW}{%
+    Writing a value to this register notifies the device that
+    there are new buffers to process in a queue.
+
+    When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
+    the value written is the queue index.
+
+    When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
+    the \field{Notification data} value has the following format:
+
+    \lstinputlisting{notifications-le.c}
+
+    See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec:Virtqueue=
s / Driver notifications}
+    for the definition of the components.
+  }
+  \hline
+  \mmioreg{InterruptStatus}{Interrupt status}{0x60}{R}{%
+    Reading from this register returns a bit mask of events that
+    caused the device interrupt to be asserted.
+    The following events are possible:
+    \begin{description}
+      \item[Used Buffer Notification] - bit 0 - the interrupt was asserted
+        because the device has used a buffer
+        in at least one of the active virtual queues.
+      \item [Configuration Change Notification] - bit 1 - the interrupt wa=
s
+        asserted because the configuration of the device has changed.
+    \end{description}
+  }
+  \hline
+  \mmioreg{InterruptACK}{Interrupt acknowledge}{0x064}{W}{%
+    Writing a value with bits set as defined in \field{InterruptStatus}
+    to this register notifies the device that events causing
+    the interrupt have been handled.
+  }
+  \hline
+  \mmioreg{Status}{Device status}{0x070}{RW}{}
+  \hline
+  \mmiodreg{QueueDescLow}{QueueDescHigh}{Virtual queue's Descriptor Area 6=
4 bit long physical address}{0x080}{0x084}{W}{}
+  \hline
+  \mmiodreg{QueueDriverLow}{QueueDriverHigh}{Virtual queue's Driver Area 6=
4 bit long physical address}{0x090}{0x094}{W}{}
+  \hline
+  \mmiodreg{QueueDeviceLow}{QueueDeviceHigh}{Virtual queue's Device Area 6=
4 bit long physical address}{0x0a0}{0x0a4}{W}{}
+  \hline
+  \mmioreg{SHMSel}{Shared memory id}{0x0ac}{W}{}
+  \hline
+  \mmiodreg{SHMLenLow}{SHMLenHigh}{Shared memory region 64 bit long length=
}{0x0b0}{0x0b4}{R}{}
+  \hline
+  \mmiodreg{SHMBaseLow}{SHMBaseHigh}{Shared memory region 64 bit long phys=
ical address}{0x0b8}{0x0bc}{R}{}
+  \hline
+  \mmioreg{ConfigGeneration}{Configuration atomicity value}{0x0fc}{R}{}
+  \hline
+  \mmioreg{Config}{Configuration space}{0x100+}{RW}{}
+  \hline
+\end{longtable}
+
+The device sends a used buffer notification or a configuration change noti=
fication
+by a single, deditcated interrupt, which is differed by the bit described =
in the description of InterruptStatus. That is, after receiving an interrup=
t, driver uses InterruptStatus to differ the event source and uses Interrup=
tACK register to acknowledge after handling.
+
+The notification mechanism is described in the QueueNotify register.
+
+\subsubsection{Version 1}\label{sec:Virtio Transport Options / Virtio Over=
 MMIO / MMIO-specific Initialization And Device Operation / Version 1}
+The MMIO transport of version 1 used page-based addressing, resulting
 in a slightly different control register layout, the device
-initialization and the virtual queue configuration procedure.
+initialization and the virtual queue configuration procedure from later ve=
rsions.
=20
-Table \ref{tab:Virtio Trasport Options / Virtio Over MMIO / MMIO Device Le=
gacy Register Layout}=20
+Table \ref{tab:Virtio Trasport Options / Virtio Over MMIO / Version 1 MMIO=
 Device Register Layout}
 presents control registers layout, omitting
 descriptions of registers which did not change their function
 nor behaviour:
=20
 \begin{longtable}{p{0.2\textwidth}p{0.7\textwidth}}
-  \caption {MMIO Device Legacy Register Layout}
-  \label{tab:Virtio Trasport Options / Virtio Over MMIO / MMIO Device Lega=
cy Register Layout} \\
+  \caption {Version 1 MMIO Device Register Layout}
+  \label{tab:Virtio Trasport Options / Virtio Over MMIO / Version 1 MMIO D=
evice Register Layout} \\
   \hline
   \mmioreg{Name}{Function}{Offset from base}{Direction}{Description}=20
   \hline=20
@@ -2193,7 +2304,7 @@ \subsection{Legacy interface}\label{sec:Virtio Transp=
ort Options / Virtio Over M
    the \field{QueuePFN} register.
 \end{enumerate}
=20
-Notification mechanisms did not change.
+Notification mechanisms are the same as version 2.
=20
 \section{Virtio Over Channel I/O}\label{sec:Virtio Transport Options / Vir=
tio Over Channel I/O}
=20
--=20
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

