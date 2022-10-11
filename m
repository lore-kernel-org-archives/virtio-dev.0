Return-Path: <virtio-dev-return-10009-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0CF369863C6
	for <virtio-dev@lists.oasis-open.org>; Tue, 11 Oct 2022 11:38:08 +0000 (UTC)
From: Igor Skalkin <Igor.Skalkin@opensynergy.com>
Date: Tue, 11 Oct 2022 13:37:27 +0200
Message-Id: <20221011113727.13714-1-Igor.Skalkin@opensynergy.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH] virtio-mmio: Introduce virtio_mmio hotplug
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
To: virtio-dev@lists.oasis-open.org
Cc: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, Igor Skalkin <Igor.Skalkin@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

As long as the virtual device is not yet running, virtual machine
manager presents the device with DeviceID set to 0.
If the driver reads zero from the DeviceID field, it should defer
the rest of the initialization process and wait for an interrupt.

As soon as the device starts, the virtual machine manager sets the
correct device ID and sends an interrupt.
The driver, when it receives an interrupt, must reread the DeviceID
and continue initialization if it is non-zero.
---
In our setup, we have a type 1 hypervisor, a Linux host with virtio
devices, and virtualised Linux/Android guests with virtio drivers.
Both the driver VM and the guest VM start at the same time, so the
"guest OS initializes virtio driver, but the virtio device is not
yet running in the host OS" situation happens all the time.
We also need the ability to start some devices manually after the
system starts.

Linux kernel patch with the implementation example:
https://lists.oasis-open.org/archives/virtio-dev/202208/msg00075.html

Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
---
 content.tex | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/content.tex b/content.tex
index e863709..b9cef85 100644
--- a/content.tex
+++ b/content.tex
@@ -1804,7 +1804,8 @@ \subsection{MMIO Device Register Layout}\label{sec:Vi=
rtio Transport Options / Vi
     Value zero (0x0) is used to
     define a system memory map with placeholder devices at static,
     well known addresses, assigning functions to them depending
-    on user's needs.
+    on user's needs (one of the option - placeholder for the hot-plugged
+    device).
   }
   \hline
   \mmioreg{VendorID}{Virtio Subsystem Vendor ID}{0x00c}{R}{}
@@ -2031,7 +2032,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Vi=
rtio Transport Options / Vi
 The driver MUST ignore a device with \field{Version} which is not 0x2,
 although it MAY report an error.

-The driver MUST ignore a device with \field{DeviceID} 0x0,
+The driver MUST ignore a device, as long as reading from \field{DeviceID} =
returns 0x0,
 but MUST NOT report any error.

 Before reading from \field{DeviceFeatures}, the driver MUST write a value =
to \field{DeviceFeaturesSel}.
@@ -2071,9 +2072,23 @@ \subsubsection{Device Initialization}\label{sec:Virt=
io Transport Options / Virti

 The driver MUST start the device initialization by reading and
 checking values from \field{MagicValue} and \field{Version}.
-If both values are valid, it MUST read \field{DeviceID}
-and if its value is zero (0x0) MUST abort initialization and
-MUST NOT access any other register.
+If both values are valid, it MUST read \field{DeviceID}.
+
+If the value of \field{DeviceID} is zero (0x0):
+\begin{itemize}
+\item The driver MUST postpone initialisation until an interrupt arrives,
+and MUST NOT access any other register.
+
+\item When an interrupt occurs, the driver should reread \field{DeviceID},=
 and
+if it is non-zero, continue with further initialization.
+\begin{note}
+At this stage, (the device has not even been reset yet) driver MUST NOT ac=
cess
+any other registers, including \field{InterruptStatus} and \field{Interrup=
tACK},
+so it can not proceed with the interrupt status check and acknowledgement =
as described in
+\ref{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initi=
alization And Device Operation / Notifications From The Device}~\nameref{se=
c:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initializatio=
n And Device Operation / Notifications From The Device},
+it can only check if a hotplug device has already started by reading \fiel=
d{DeviceID}.
+\end{note}
+\end{itemize}

 Drivers not expecting shared memory MUST NOT use the shared
 memory registers.
--
2.37.2


Please mind our privacy notice<https://www.opensynergy.com/datenschutzerkla=
erung/privacy-notice-for-business-partners-pursuant-to-article-13-of-the-ge=
neral-data-protection-regulation-gdpr/> pursuant to Art. 13 GDPR. // Unsere=
 Hinweise zum Datenschutz gem. Art. 13 DSGVO finden Sie hier.<https://www.o=
pensynergy.com/de/datenschutzerklaerung/datenschutzhinweise-fuer-geschaefts=
partner-gem-art-13-dsgvo/>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

