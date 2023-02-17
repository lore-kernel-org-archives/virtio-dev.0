Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH v2 5/6] transport-mmio: Correct spelling errors
Date: Fri, 17 Feb 2023 17:49:04 +0200
Message-ID: <20230217154905.33619-6-parav@nvidia.com>
In-Reply-To: <20230217154905.33619-1-parav@nvidia.com>
References: <20230217154905.33619-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
To: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Now that we have individual files, fix reported spelling errors.

While at it, remove trailing white spaces.

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v0->v1:
- removed many trailing white spaces
---
 transport-mmio.tex | 90 +++++++++++++++++++++++-----------------------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/transport-mmio.tex b/transport-mmio.tex
index 7f2e0c3..65bae54 100644
--- a/transport-mmio.tex
+++ b/transport-mmio.tex
@@ -18,7 +18,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio=
 Transport Options / Vi
=20
 MMIO virtio devices provide a set of memory mapped control
 registers followed by a device-specific configuration space,
-described in the table~\ref{tab:Virtio Trasport Options / Virtio Over MMIO=
 / MMIO Device Register Layout}.
+described in the table~\ref{tab:Virtio Transport Options / Virtio Over MMI=
O / MMIO Device Register Layout}.
=20
 All register values are organized as Little Endian.
=20
@@ -32,23 +32,23 @@ \subsection{MMIO Device Register Layout}\label{sec:Virt=
io Transport Options / Vi
=20
 \begin{longtable}{p{0.2\textwidth}p{0.7\textwidth}}
   \caption {MMIO Device Register Layout}
-  \label{tab:Virtio Trasport Options / Virtio Over MMIO / MMIO Device Regi=
ster Layout} \\
+  \label{tab:Virtio Transport Options / Virtio Over MMIO / MMIO Device Reg=
ister Layout} \\
+  \hline
+  \mmioreg{Name}{Function}{Offset from base}{Direction}{Description}
+  \hline
   \hline
-  \mmioreg{Name}{Function}{Offset from base}{Direction}{Description}=20
-  \hline=20
-  \hline=20
   \endfirsthead
   \hline
-  \mmioreg{Name}{Function}{Offset from the base}{Direction}{Description}=
=20
-  \hline=20
-  \hline=20
+  \mmioreg{Name}{Function}{Offset from the base}{Direction}{Description}
+  \hline
+  \hline
   \endhead
   \endfoot
   \endlastfoot
   \mmioreg{MagicValue}{Magic value}{0x000}{R}{%
     0x74726976
     (a Little Endian equivalent of the ``virt'' string).
-  }=20
+  }
   \hline
   \mmioreg{Version}{Device version number}{0x004}{R}{%
     0x2.
@@ -56,7 +56,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio=
 Transport Options / Vi
       Legacy devices (see \ref{sec:Virtio Transport Options / Virtio Over =
MMIO / Legacy interface}~\nameref{sec:Virtio Transport Options / Virtio Ove=
r MMIO / Legacy interface}) used 0x1.
     \end{note}
   }
-  \hline=20
+  \hline
   \mmioreg{DeviceID}{Virtio Subsystem Device ID}{0x008}{R}{%
     See \ref{sec:Device Types}~\nameref{sec:Device Types} for possible val=
ues.
     Value zero (0x0) is used to
@@ -64,9 +64,9 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio=
 Transport Options / Vi
     well known addresses, assigning functions to them depending
     on user's needs.
   }
-  \hline=20
+  \hline
   \mmioreg{VendorID}{Virtio Subsystem Vendor ID}{0x00c}{R}{}
-  \hline=20
+  \hline
   \mmioreg{DeviceFeatures}{Flags representing features the device supports=
}{0x010}{R}{%
     Reading from this register returns 32 consecutive flag bits,
     the least significant bit depending on the last value written to
@@ -76,12 +76,12 @@ \subsection{MMIO Device Register Layout}\label{sec:Virt=
io Transport Options / Vi
     features bits 32 to 63 if \field{DeviceFeaturesSel} is set to 1.
     Also see \ref{sec:Basic Facilities of a Virtio Device / Feature Bits}~=
\nameref{sec:Basic Facilities of a Virtio Device / Feature Bits}.
   }
-  \hline=20
+  \hline
   \mmioreg{DeviceFeaturesSel}{Device (host) features word selection.}{0x01=
4}{W}{%
     Writing to this register selects a set of 32 device feature bits
     accessible by reading from \field{DeviceFeatures}.
   }
-  \hline=20
+  \hline
   \mmioreg{DriverFeatures}{Flags representing device features understood a=
nd activated by the driver}{0x020}{W}{%
     Writing to this register sets 32 consecutive flag bits, the least sign=
ificant
     bit depending on the last value written to \field{DriverFeaturesSel}.
@@ -90,41 +90,41 @@ \subsection{MMIO Device Register Layout}\label{sec:Virt=
io Transport Options / Vi
     \field{DriverFeaturesSel} is set to 0 and features bits 32 to 63 if
     \field{DriverFeaturesSel} is set to 1. Also see \ref{sec:Basic Facilit=
ies of a Virtio Device / Feature Bits}~\nameref{sec:Basic Facilities of a V=
irtio Device / Feature Bits}.
   }
-  \hline=20
+  \hline
   \mmioreg{DriverFeaturesSel}{Activated (guest) features word selection}{0=
x024}{W}{%
     Writing to this register selects a set of 32 activated feature
     bits accessible by writing to \field{DriverFeatures}.
   }
-  \hline=20
+  \hline
   \mmioreg{QueueSel}{Virtual queue index}{0x030}{W}{%
     Writing to this register selects the virtual queue that the
     following operations on \field{QueueNumMax}, \field{QueueNum}, \field{=
QueueReady},
     \field{QueueDescLow}, \field{QueueDescHigh}, \field{QueueDriverlLow}, =
\field{QueueDriverHigh},
     \field{QueueDeviceLow}, \field{QueueDeviceHigh} and \field{QueueReset}=
 apply to. The index
-    number of the first queue is zero (0x0).=20
+    number of the first queue is zero (0x0).
   }
-  \hline=20
+  \hline
   \mmioreg{QueueNumMax}{Maximum virtual queue size}{0x034}{R}{%
     Reading from the register returns the maximum size (number of
     elements) of the queue the device is ready to process or
     zero (0x0) if the queue is not available. This applies to the
     queue selected by writing to \field{QueueSel}.
   }
-  \hline=20
+  \hline
   \mmioreg{QueueNum}{Virtual queue size}{0x038}{W}{%
     Queue size is the number of elements in the queue.
     Writing to this register notifies the device what size of the
     queue the driver will use. This applies to the queue selected by
     writing to \field{QueueSel}.
   }
-  \hline=20
+  \hline
   \mmioreg{QueueReady}{Virtual queue ready bit}{0x044}{RW}{%
     Writing one (0x1) to this register notifies the device that it can
     execute requests from this virtual queue. Reading from this register
     returns the last value written to it. Both read and write
     accesses apply to the queue selected by writing to \field{QueueSel}.
   }
-  \hline=20
+  \hline
   \mmioreg{QueueNotify}{Queue notifier}{0x050}{W}{%
     Writing a value to this register notifies the device that
     there are new buffers to process in a queue.
@@ -140,7 +140,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virt=
io Transport Options / Vi
     See \ref{sec:Basic Facilities of a Virtio Device / Driver notification=
s}~\nameref{sec:Basic Facilities of a Virtio Device / Driver notifications}
     for the definition of the components.
   }
-  \hline=20
+  \hline
   \mmioreg{InterruptStatus}{Interrupt status}{0x60}{R}{%
     Reading from this register returns a bit mask of events that
     caused the device interrupt to be asserted.
@@ -153,49 +153,49 @@ \subsection{MMIO Device Register Layout}\label{sec:Vi=
rtio Transport Options / Vi
         asserted because the configuration of the device has changed.
     \end{description}
   }
-  \hline=20
+  \hline
   \mmioreg{InterruptACK}{Interrupt acknowledge}{0x064}{W}{%
     Writing a value with bits set as defined in \field{InterruptStatus}
     to this register notifies the device that events causing
     the interrupt have been handled.
   }
-  \hline=20
+  \hline
   \mmioreg{Status}{Device status}{0x070}{RW}{%
     Reading from this register returns the current device status
     flags.
     Writing non-zero values to this register sets the status flags,
     indicating the driver progress. Writing zero (0x0) to this
-    register triggers a device reset.=20
+    register triggers a device reset.
     See also p. \ref{sec:Virtio Transport Options / Virtio Over MMIO / MMI=
O-specific Initialization And Device Operation / Device Initialization}~\na=
meref{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initi=
alization And Device Operation / Device Initialization}.
   }
-  \hline=20
+  \hline
   \mmiodreg{QueueDescLow}{QueueDescHigh}{Virtual queue's Descriptor Area 6=
4 bit long physical address}{0x080}{0x084}{W}{%
     Writing to these two registers (lower 32 bits of the address
     to \field{QueueDescLow}, higher 32 bits to \field{QueueDescHigh}) noti=
fies
     the device about location of the Descriptor Area of the queue
     selected by writing to \field{QueueSel} register.
   }
-  \hline=20
+  \hline
   \mmiodreg{QueueDriverLow}{QueueDriverHigh}{Virtual queue's Driver Area 6=
4 bit long physical address}{0x090}{0x094}{W}{%
     Writing to these two registers (lower 32 bits of the address
     to \field{QueueDriverLow}, higher 32 bits to \field{QueueDriverHigh}) =
notifies
     the device about location of the Driver Area of the queue
     selected by writing to \field{QueueSel}.
   }
-  \hline=20
+  \hline
   \mmiodreg{QueueDeviceLow}{QueueDeviceHigh}{Virtual queue's Device Area 6=
4 bit long physical address}{0x0a0}{0x0a4}{W}{%
     Writing to these two registers (lower 32 bits of the address
     to \field{QueueDeviceLow}, higher 32 bits to \field{QueueDeviceHigh}) =
notifies
     the device about location of the Device Area of the queue
     selected by writing to \field{QueueSel}.
   }
-  \hline=20
+  \hline
   \mmioreg{SHMSel}{Shared memory id}{0x0ac}{W}{%
     Writing to this register selects the shared memory region \ref{sec:Bas=
ic Facilities of a Virtio Device / Shared Memory Regions}
     following operations on \field{SHMLenLow}, \field{SHMLenHigh},
     \field{SHMBaseLow} and \field{SHMBaseHigh} apply to.
   }
-  \hline=20
+  \hline
   \mmiodreg{SHMLenLow}{SHMLenHigh}{Shared memory region 64 bit long length=
}{0x0b0}{0x0b4}{R}{%
     These registers return the length of the shared memory
     region in bytes, as defined by the device for the region selected by
@@ -205,7 +205,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virt=
io Transport Options / Vi
     region (i.e. where the ID written to \field{SHMSel} is unused)
     results in a length of -1.
   }
-  \hline=20
+  \hline
   \mmiodreg{SHMBaseLow}{SHMBaseHigh}{Shared memory region 64 bit long phys=
ical address}{0x0b8}{0x0bc}{R}{%
     The driver reads these registers to discover the base address
     of the region in physical address space.  This address is
@@ -216,7 +216,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virt=
io Transport Options / Vi
     \field{SHMSel} is unused) results in a base address of
     0xffffffffffffffff.
   }
-  \hline=20
+  \hline
   \mmioreg{QueueReset}{Virtual queue reset bit}{0x0c0}{RW}{%
     If VIRTIO_F_RING_RESET has been negotiated, writing one (0x1) to this
     register selectively resets the queue. Both read and write accesses
@@ -230,7 +230,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virt=
io Transport Options / Vi
     If the values are different, the configuration space accesses were not=
 atomic and the driver has to perform the operations again.
     See also \ref {sec:Basic Facilities of a Virtio Device / Device Config=
uration Space}.
   }
-  \hline=20
+  \hline
   \mmioreg{Config}{Configuration space}{0x100+}{RW}{
     Device-specific configuration space starts at the offset 0x100
     and is accessed with byte alignment. Its meaning and size
@@ -272,13 +272,13 @@ \subsection{MMIO Device Register Layout}\label{sec:Vi=
rtio Transport Options / Vi
=20
 \drivernormative{\subsubsection}{MMIO Device Register Layout}{Virtio Trans=
port Options / Virtio Over MMIO / MMIO Device Register Layout}
 The driver MUST NOT access memory locations not described in the
-table \ref{tab:Virtio Trasport Options / Virtio Over MMIO / MMIO Device Re=
gister Layout}
+table \ref{tab:Virtio Transport Options / Virtio Over MMIO / MMIO Device R=
egister Layout}
 (or, in case of the configuration space, described in the device specifica=
tion),
 MUST NOT write to the read-only registers (direction R) and
 MUST NOT read from the write-only registers (direction W).
=20
 The driver MUST only use 32 bit wide and aligned reads and writes to acces=
s the control registers
-described in table \ref{tab:Virtio Trasport Options / Virtio Over MMIO / M=
MIO Device Register Layout}.
+described in table \ref{tab:Virtio Transport Options / Virtio Over MMIO / =
MMIO Device Register Layout}.
 For the device-specific configuration space, the driver MUST use 8 bit wid=
e accesses for
 8 bit wide fields, 16 bit wide and aligned accesses for 16 bit wide fields=
 and 32 bit wide and
 aligned accesses for 32 and 64 bit wide fields.
@@ -407,23 +407,23 @@ \subsection{Legacy interface}\label{sec:Virtio Transp=
ort Options / Virtio Over M
 in a slightly different control register layout, the device
 initialization and the virtual queue configuration procedure.
=20
-Table \ref{tab:Virtio Trasport Options / Virtio Over MMIO / MMIO Device Le=
gacy Register Layout}=20
+Table \ref{tab:Virtio Transport Options / Virtio Over MMIO / MMIO Device L=
egacy Register Layout}
 presents control registers layout, omitting
 descriptions of registers which did not change their function
 nor behaviour:
=20
 \begin{longtable}{p{0.2\textwidth}p{0.7\textwidth}}
   \caption {MMIO Device Legacy Register Layout}
-  \label{tab:Virtio Trasport Options / Virtio Over MMIO / MMIO Device Lega=
cy Register Layout} \\
+  \label{tab:Virtio Transport Options / Virtio Over MMIO / MMIO Device Leg=
acy Register Layout} \\
+  \hline
+  \mmioreg{Name}{Function}{Offset from base}{Direction}{Description}
+  \hline
   \hline
-  \mmioreg{Name}{Function}{Offset from base}{Direction}{Description}=20
-  \hline=20
-  \hline=20
   \endfirsthead
   \hline
-  \mmioreg{Name}{Function}{Offset from the base}{Direction}{Description}=
=20
-  \hline=20
-  \hline=20
+  \mmioreg{Name}{Function}{Offset from the base}{Direction}{Description}
+  \hline
+  \hline
   \endhead
   \endfoot
   \endlastfoot
@@ -442,7 +442,7 @@ \subsection{Legacy interface}\label{sec:Virtio Transpor=
t Options / Virtio Over M
   \mmioreg{GuestFeatures}{Flags representing device features understood an=
d activated by the driver}{0x020}{W}{}
   \hline
   \mmioreg{GuestFeaturesSel}{Activated (guest) features word selection}{0x=
024}{W}{}
-  \hline=20
+  \hline
   \mmioreg{GuestPageSize}{Guest page size}{0x028}{W}{%
     The driver writes the guest page size in bytes to the
     register during initialization, before any queues are used.
@@ -455,7 +455,7 @@ \subsection{Legacy interface}\label{sec:Virtio Transpor=
t Options / Virtio Over M
     Writing to this register selects the virtual queue that the
     following operations on the \field{QueueNumMax}, \field{QueueNum}, \fi=
eld{QueueAlign}
     and \field{QueuePFN} registers apply to. The index
-    number of the first queue is zero (0x0).=20
+    number of the first queue is zero (0x0).
 .
   }
   \hline
--=20
2.26.2

