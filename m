Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH v5 1/6] transport-pci: Split PCI transport to its own file
Date: Sat, 25 Feb 2023 00:22:10 +0200
Message-ID: <20230224222215.339715-2-parav@nvidia.com>
In-Reply-To: <20230224222215.339715-1-parav@nvidia.com>
References: <20230224222215.339715-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
To: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Place PCI transport specification in its own file to better maintain it.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/157
Signed-off-by: Parav Pandit <parav@nvidia.com>

---
changelog:
v4->v5:
- removed incorrect mmio hunk out of pci file
---
 content.tex       | 1149 +--------------------------------------------
 transport-pci.tex | 1149 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 1150 insertions(+), 1148 deletions(-)
 create mode 100644 transport-pci.tex

diff --git a/content.tex b/content.tex
index 0c7cdf8..a88e3f6 100644
--- a/content.tex
+++ b/content.tex
@@ -579,1154 +579,7 @@ \chapter{Virtio Transport Options}\label{sec:Virtio =
Transport Options}
 Virtio can use various different buses, thus the standard is split
 into virtio general and bus-specific sections.
=20
-\section{Virtio Over PCI Bus}\label{sec:Virtio Transport Options / Virtio =
Over PCI Bus}
-
-Virtio devices are commonly implemented as PCI devices.
-
-A Virtio device can be implemented as any kind of PCI device:
-a Conventional PCI device or a PCI Express
-device.  To assure designs meet the latest level
-requirements, see=20
-the PCI-SIG home page at \url{http://www.pcisig.com} for any
-approved changes.
-
-\devicenormative{\subsection}{Virtio Over PCI Bus}{Virtio Transport Option=
s / Virtio Over PCI Bus}
-A Virtio device using Virtio Over PCI Bus MUST expose to
-guest an interface that meets the specification requirements of
-the appropriate PCI specification: \hyperref[intro:PCI]{[PCI]}
-and \hyperref[intro:PCIe]{[PCIe]}
-respectively.=20
-
-\subsection{PCI Device Discovery}\label{sec:Virtio Transport Options / Vir=
tio Over PCI Bus / PCI Device Discovery}
-
-Any PCI device with PCI Vendor ID 0x1AF4, and PCI Device ID 0x1000 through
-0x107F inclusive is a virtio device. The actual value within this range
-indicates which virtio device is supported by the device.
-The PCI Device ID is calculated by adding 0x1040 to the Virtio Device ID,
-as indicated in section \ref{sec:Device Types}.
-Additionally, devices MAY utilize a Transitional PCI Device ID range,
-0x1000 to 0x103F depending on the device type.
-
-\devicenormative{\subsubsection}{PCI Device Discovery}{Virtio Transport Op=
tions / Virtio Over PCI Bus / PCI Device Discovery}
-
-Devices MUST have the PCI Vendor ID 0x1AF4.
-Devices MUST either have the PCI Device ID calculated by adding 0x1040
-to the Virtio Device ID, as indicated in section \ref{sec:Device
-Types} or have the Transitional PCI Device ID depending on the device type=
,
-as follows:
-
-\begin{tabular}{|l|c|}
-\hline
-Transitional PCI Device ID  &  Virtio Device    \\
-\hline \hline
-0x1000      &   network device     \\
-\hline
-0x1001     &   block device     \\
-\hline
-0x1002     & memory ballooning (traditional)  \\
-\hline
-0x1003     &      console       \\
-\hline
-0x1004     &     SCSI host      \\
-\hline
-0x1005     &  entropy source    \\
-\hline
-0x1009     &   9P transport     \\
-\hline
-\end{tabular}
-
-For example, the network device with the Virtio Device ID 1
-has the PCI Device ID 0x1041 or the Transitional PCI Device ID 0x1000.
-
-The PCI Subsystem Vendor ID and the PCI Subsystem Device ID MAY reflect
-the PCI Vendor and Device ID of the environment (for informational purpose=
s by the driver).
-
-Non-transitional devices SHOULD have a PCI Device ID in the range
-0x1040 to 0x107f.
-Non-transitional devices SHOULD have a PCI Revision ID of 1 or higher.
-Non-transitional devices SHOULD have a PCI Subsystem Device ID of 0x40 or =
higher.
-
-This is to reduce the chance of a legacy driver attempting
-to drive the device.
-
-\drivernormative{\subsubsection}{PCI Device Discovery}{Virtio Transport Op=
tions / Virtio Over PCI Bus / PCI Device Discovery}
-Drivers MUST match devices with the PCI Vendor ID 0x1AF4 and
-the PCI Device ID in the range 0x1040 to 0x107f,
-calculated by adding 0x1040 to the Virtio Device ID,
-as indicated in section \ref{sec:Device Types}.
-Drivers for device types listed in section \ref{sec:Virtio
-Transport Options / Virtio Over PCI Bus / PCI Device Discovery}
-MUST match devices with the PCI Vendor ID 0x1AF4 and
-the Transitional PCI Device ID indicated in section
- \ref{sec:Virtio
-Transport Options / Virtio Over PCI Bus / PCI Device Discovery}.
-
-Drivers MUST match any PCI Revision ID value.
-Drivers MAY match any PCI Subsystem Vendor ID and any
-PCI Subsystem Device ID value.
-
-\subsubsection{Legacy Interfaces: A Note on PCI Device Discovery}\label{se=
c:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery / L=
egacy Interfaces: A Note on PCI Device Discovery}
-Transitional devices MUST have a PCI Revision ID of 0.
-Transitional devices MUST have the PCI Subsystem Device ID
-matching the Virtio Device ID, as indicated in section \ref{sec:Device Typ=
es}.
-Transitional devices MUST have the Transitional PCI Device ID in
-the range 0x1000 to 0x103f.
-
-This is to match legacy drivers.
-
-\subsection{PCI Device Layout}\label{sec:Virtio Transport Options / Virtio=
 Over PCI Bus / PCI Device Layout}
-
-The device is configured via I/O and/or memory regions (though see
-\ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layou=
t / PCI configuration access capability}
-for access via the PCI configuration space), as specified by Virtio
-Structure PCI Capabilities.
-
-Fields of different sizes are present in the device
-configuration regions.
-All 64-bit, 32-bit and 16-bit fields are little-endian.
-64-bit fields are to be treated as two 32-bit fields,
-with low 32 bit part followed by the high 32 bit part.
-
-\drivernormative{\subsubsection}{PCI Device Layout}{Virtio Transport Optio=
ns / Virtio Over PCI Bus / PCI Device Layout}
-
-For device configuration access, the driver MUST use 8-bit wide
-accesses for 8-bit wide fields, 16-bit wide and aligned accesses
-for 16-bit wide fields and 32-bit wide and aligned accesses for
-32-bit and 64-bit wide fields. For 64-bit fields, the driver MAY
-access each of the high and low 32-bit parts of the field
-independently.
-
-\devicenormative{\subsubsection}{PCI Device Layout}{Virtio Transport Optio=
ns / Virtio Over PCI Bus / PCI Device Layout}
-
-For 64-bit device configuration fields, the device MUST allow driver
-independent access to high and low 32-bit parts of the field.
-
-\subsection{Virtio Structure PCI Capabilities}\label{sec:Virtio Transport =
Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities}
-
-The virtio device configuration layout includes several structures:
-\begin{itemize}
-\item Common configuration
-\item Notifications
-\item ISR Status
-\item Device-specific configuration (optional)
-\item PCI configuration access
-\end{itemize}
-
-Each structure can be mapped by a Base Address register (BAR) belonging to
-the function, or accessed via the special VIRTIO_PCI_CAP_PCI_CFG field in =
the PCI configuration space.
-
-The location of each structure is specified using a vendor-specific PCI ca=
pability located
-on the capability list in PCI configuration space of the device.
-This virtio structure capability uses little-endian format; all fields are
-read-only for the driver unless stated otherwise:
-
-\begin{lstlisting}
-struct virtio_pci_cap {
-        u8 cap_vndr;    /* Generic PCI field: PCI_CAP_ID_VNDR */
-        u8 cap_next;    /* Generic PCI field: next ptr. */
-        u8 cap_len;     /* Generic PCI field: capability length */
-        u8 cfg_type;    /* Identifies the structure. */
-        u8 bar;         /* Where to find it. */
-        u8 id;          /* Multiple capabilities of the same type */
-        u8 padding[2];  /* Pad to full dword. */
-        le32 offset;    /* Offset within bar. */
-        le32 length;    /* Length of the structure, in bytes. */
-};
-\end{lstlisting}
-
-This structure can be followed by extra data, depending on
-\field{cfg_type}, as documented below.
-
-The fields are interpreted as follows:
-
-\begin{description}
-\item[\field{cap_vndr}]
-        0x09; Identifies a vendor-specific capability.
-
-\item[\field{cap_next}]
-        Link to next capability in the capability list in the PCI configur=
ation space.
-
-\item[\field{cap_len}]
-        Length of this capability structure, including the whole of
-        struct virtio_pci_cap, and extra data if any.
-        This length MAY include padding, or fields unused by the driver.
-
-\item[\field{cfg_type}]
-        identifies the structure, according to the following table:
-
-\begin{lstlisting}
-/* Common configuration */
-#define VIRTIO_PCI_CAP_COMMON_CFG        1
-/* Notifications */
-#define VIRTIO_PCI_CAP_NOTIFY_CFG        2
-/* ISR Status */
-#define VIRTIO_PCI_CAP_ISR_CFG           3
-/* Device specific configuration */
-#define VIRTIO_PCI_CAP_DEVICE_CFG        4
-/* PCI configuration access */
-#define VIRTIO_PCI_CAP_PCI_CFG           5
-/* Shared memory region */
-#define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
-/* Vendor-specific data */
-#define VIRTIO_PCI_CAP_VENDOR_CFG        9
-\end{lstlisting}
-
-        Any other value is reserved for future use.
-
-        Each structure is detailed individually below.
-
-        The device MAY offer more than one structure of any type - this ma=
kes it
-        possible for the device to expose multiple interfaces to drivers. =
 The order of
-        the capabilities in the capability list specifies the order of pre=
ference
-        suggested by the device.  A device may specify that this ordering =
mechanism be
-        overridden by the use of the \field{id} field.
-        \begin{note}
-          For example, on some hypervisors, notifications using IO accesse=
s are
-        faster than memory accesses. In this case, the device would expose=
 two
-        capabilities with \field{cfg_type} set to VIRTIO_PCI_CAP_NOTIFY_CF=
G:
-        the first one addressing an I/O BAR, the second one addressing a m=
emory BAR.
-        In this example, the driver would use the I/O BAR if I/O resources=
 are available, and fall back on
-        memory BAR when I/O resources are unavailable.
-        \end{note}
-
-\item[\field{bar}]
-        values 0x0 to 0x5 specify a Base Address register (BAR) belonging =
to
-        the function located beginning at 10h in PCI Configuration Space
-        and used to map the structure into Memory or I/O Space.
-        The BAR is permitted to be either 32-bit or 64-bit, it can map Mem=
ory Space
-        or I/O Space.
-
-        Any other value is reserved for future use.
-
-\item[\field{id}]
-        Used by some device types to uniquely identify multiple capabiliti=
es
-        of a certain type. If the device type does not specify the meaning=
 of
-        this field, its contents are undefined.
-
-
-\item[\field{offset}]
-        indicates where the structure begins relative to the base address =
associated
-        with the BAR.  The alignment requirements of \field{offset} are in=
dicated
-        in each structure-specific section below.
-
-\item[\field{length}]
-        indicates the length of the structure.
-
-        \field{length} MAY include padding, or fields unused by the driver=
, or
-        future extensions.
-
-        \begin{note}
-        For example, a future device might present a large structure size =
of several
-        MBytes.
-        As current devices never utilize structures larger than 4KBytes in=
 size,
-        driver MAY limit the mapped structure size to e.g.
-        4KBytes (thus ignoring parts of structure after the first
-        4KBytes) to allow forward compatibility with such devices without =
loss of
-        functionality and without wasting resources.
-        \end{note}
-\end{description}
-
-A variant of this type, struct virtio_pci_cap64, is defined for
-those capabilities that require offsets or lengths larger than
-4GiB:
-
-\begin{lstlisting}
-struct virtio_pci_cap64 {
-        struct virtio_pci_cap cap;
-        u32 offset_hi;
-        u32 length_hi;
-};
-\end{lstlisting}
-
-Given that the \field{cap.length} and \field{cap.offset} fields
-are only 32 bit, the additional \field{offset_hi} and \field{length_hi}
-fields provide the most significant 32 bits of a total 64 bit offset and
-length within the BAR specified by \field{cap.bar}.
-
-\drivernormative{\subsubsection}{Virtio Structure PCI Capabilities}{Virtio=
 Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilitie=
s}
-
-The driver MUST ignore any vendor-specific capability structure which has
-a reserved \field{cfg_type} value.
-
-The driver SHOULD use the first instance of each virtio structure type the=
y can
-support.
-
-The driver MUST accept a \field{cap_len} value which is larger than specif=
ied here.
-
-The driver MUST ignore any vendor-specific capability structure which has
-a reserved \field{bar} value.
-
-        The drivers SHOULD only map part of configuration structure
-        large enough for device operation.  The drivers MUST handle
-        an unexpectedly large \field{length}, but MAY check that \field{le=
ngth}
-        is large enough for device operation.
-
-The driver MUST NOT write into any field of the capability structure,
-with the exception of those with \field{cap_type} VIRTIO_PCI_CAP_PCI_CFG a=
s
-detailed in \ref{drivernormative:Virtio Transport Options / Virtio Over PC=
I Bus / PCI Device Layout / PCI configuration access capability}.
-
-\devicenormative{\subsubsection}{Virtio Structure PCI Capabilities}{Virtio=
 Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilitie=
s}
-
-The device MUST include any extra data (from the beginning of the \field{c=
ap_vndr} field
-through end of the extra data fields if any) in \field{cap_len}.
-The device MAY append extra data
-or padding to any structure beyond that.
-
-If the device presents multiple structures of the same type, it SHOULD ord=
er
-them from optimal (first) to least-optimal (last).
-
-\subsubsection{Common configuration structure layout}\label{sec:Virtio Tra=
nsport Options / Virtio Over PCI Bus / PCI Device Layout / Common configura=
tion structure layout}
-
-The common configuration structure is found at the \field{bar} and \field{=
offset} within the VIRTIO_PCI_CAP_COMMON_CFG capability; its layout is belo=
w.
-
-\begin{lstlisting}
-struct virtio_pci_common_cfg {
-        /* About the whole device. */
-        le32 device_feature_select;     /* read-write */
-        le32 device_feature;            /* read-only for driver */
-        le32 driver_feature_select;     /* read-write */
-        le32 driver_feature;            /* read-write */
-        le16 config_msix_vector;        /* read-write */
-        le16 num_queues;                /* read-only for driver */
-        u8 device_status;               /* read-write */
-        u8 config_generation;           /* read-only for driver */
-
-        /* About a specific virtqueue. */
-        le16 queue_select;              /* read-write */
-        le16 queue_size;                /* read-write */
-        le16 queue_msix_vector;         /* read-write */
-        le16 queue_enable;              /* read-write */
-        le16 queue_notify_off;          /* read-only for driver */
-        le64 queue_desc;                /* read-write */
-        le64 queue_driver;              /* read-write */
-        le64 queue_device;              /* read-write */
-        le16 queue_notify_data;         /* read-only for driver */
-        le16 queue_reset;               /* read-write */
-};
-\end{lstlisting}
-
-\begin{description}
-\item[\field{device_feature_select}]
-        The driver uses this to select which feature bits \field{device_fe=
ature} shows.
-        Value 0x0 selects Feature Bits 0 to 31, 0x1 selects Feature Bits 3=
2 to 63, etc.
-
-\item[\field{device_feature}]
-        The device uses this to report which feature bits it is
-        offering to the driver: the driver writes to
-        \field{device_feature_select} to select which feature bits are pre=
sented.
-
-\item[\field{driver_feature_select}]
-        The driver uses this to select which feature bits \field{driver_fe=
ature} shows.
-        Value 0x0 selects Feature Bits 0 to 31, 0x1 selects Feature Bits 3=
2 to 63, etc.
-
-\item[\field{driver_feature}]
-        The driver writes this to accept feature bits offered by the devic=
e.
-        Driver Feature Bits selected by \field{driver_feature_select}.
-
-\item[\field{config_msix_vector}]
-        The driver sets the Configuration Vector for MSI-X.
-
-\item[\field{num_queues}]
-        The device specifies the maximum number of virtqueues supported he=
re.
-
-\item[\field{device_status}]
-        The driver writes the device status here (see \ref{sec:Basic Facil=
ities of a Virtio Device / Device Status Field}). Writing 0 into this
-        field resets the device.
-
-\item[\field{config_generation}]
-        Configuration atomicity value.  The device changes this every time=
 the
-        configuration noticeably changes.
-
-\item[\field{queue_select}]
-        Queue Select. The driver selects which virtqueue the following
-        fields refer to.
-
-\item[\field{queue_size}]
-        Queue Size.  On reset, specifies the maximum queue size supported =
by
-        the device. This can be modified by the driver to reduce memory re=
quirements.
-        A 0 means the queue is unavailable.
-
-\item[\field{queue_msix_vector}]
-        The driver uses this to specify the queue vector for MSI-X.
-
-\item[\field{queue_enable}]
-        The driver uses this to selectively prevent the device from execut=
ing requests from this virtqueue.
-        1 - enabled; 0 - disabled.
-
-\item[\field{queue_notify_off}]
-        The driver reads this to calculate the offset from start of Notifi=
cation structure at
-        which this virtqueue is located.
-        \begin{note} this is \em{not} an offset in bytes.
-        See \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI =
Device Layout / Notification capability} below.
-        \end{note}
-
-\item[\field{queue_desc}]
-        The driver writes the physical address of Descriptor Area here.  S=
ee section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}.
-
-\item[\field{queue_driver}]
-        The driver writes the physical address of Driver Area here.  See s=
ection \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}.
-
-\item[\field{queue_device}]
-        The driver writes the physical address of Device Area here.  See s=
ection \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}.
-
-\item[\field{queue_notify_data}]
-        This field exists only if VIRTIO_F_NOTIF_CONFIG_DATA has been nego=
tiated.
-        The driver will use this value to put it in the 'virtqueue number'=
 field
-        in the available buffer notification structure.
-        See section \ref{sec:Virtio Transport Options / Virtio Over PCI Bu=
s / PCI-specific Initialization And Device Operation / Available Buffer Not=
ifications}.
-        \begin{note}
-        This field provides the device with flexibility to determine how v=
irtqueues
-        will be referred to in available buffer notifications.
-        In a trivial case the device can set \field{queue_notify_data}=3Dv=
qn. Some devices
-        may benefit from providing another value, for example an internal =
virtqueue
-        identifier, or an internal offset related to the virtqueue number.
-        \end{note}
-
-\item[\field{queue_reset}]
-        The driver uses this to selectively reset the queue.
-        This field exists only if VIRTIO_F_RING_RESET has been
-        negotiated. (see \ref{sec:Basic Facilities of a Virtio Device / Vi=
rtqueues / Virtqueue Reset}).
-
-\end{description}
-
-\devicenormative{\paragraph}{Common configuration structure layout}{Virtio=
 Transport Options / Virtio Over PCI Bus / PCI Device Layout / Common confi=
guration structure layout}
-\field{offset} MUST be 4-byte aligned.
-
-The device MUST present at least one common configuration capability.
-
-The device MUST present the feature bits it is offering in \field{device_f=
eature}, starting at bit \field{device_feature_select} $*$ 32 for any \fiel=
d{device_feature_select} written by the driver.
-\begin{note}
-  This means that it will present 0 for any \field{device_feature_select} =
other than 0 or 1, since no feature defined here exceeds 63.
-\end{note}
-
-The device MUST present any valid feature bits the driver has written in \=
field{driver_feature}, starting at bit \field{driver_feature_select} $*$ 32=
 for any \field{driver_feature_select} written by the driver.  Valid featur=
e bits are those which are subset of the corresponding \field{device_featur=
e} bits.  The device MAY present invalid bits written by the driver.
-
-\begin{note}
-  This means that a device can ignore writes for feature bits it never
-  offers, and simply present 0 on reads.  Or it can just mirror what the d=
river wrote
-  (but it will still have to check them when the driver sets FEATURES_OK).
-\end{note}
-
-\begin{note}
-  A driver shouldn't write invalid bits anyway, as per \ref{drivernormativ=
e:General Initialization And Device Operation / Device Initialization}, but=
 this attempts to handle it.
-\end{note}
-
-The device MUST present a changed \field{config_generation} after the
-driver has read a device-specific configuration value which has
-changed since any part of the device-specific configuration was last
-read.
-\begin{note}
-As \field{config_generation} is an 8-bit value, simply incrementing it
-on every configuration change could violate this requirement due to wrap.
-Better would be to set an internal flag when it has changed,
-and if that flag is set when the driver reads from the device-specific
-configuration, increment \field{config_generation} and clear the flag.
-\end{note}
-
-The device MUST reset when 0 is written to \field{device_status}, and
-present a 0 in \field{device_status} once that is done.
-
-The device MUST present a 0 in \field{queue_enable} on reset.
-
-If VIRTIO_F_RING_RESET has been negotiated, the device MUST present a 0 in
-\field{queue_reset} on reset.
-
-If VIRTIO_F_RING_RESET has been negotiated, the device MUST present a 0 in
-\field{queue_reset} after the virtqueue is enabled with \field{queue_enabl=
e}.
-
-The device MUST reset the queue when 1 is written to \field{queue_reset}. =
The
-device MUST continue to present 1 in \field{queue_reset} as long as the qu=
eue reset
-is ongoing. The device MUST present 0 in both \field{queue_reset} and \fie=
ld{queue_enable}
-when queue reset has completed.
-(see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue=
 Reset}).
-
-The device MUST present a 0 in \field{queue_size} if the virtqueue
-corresponding to the current \field{queue_select} is unavailable.
-
-If VIRTIO_F_RING_PACKED has not been negotiated, the device MUST
-present either a value of 0 or a power of 2 in
-\field{queue_size}.
-
-\drivernormative{\paragraph}{Common configuration structure layout}{Virtio=
 Transport Options / Virtio Over PCI Bus / PCI Device Layout / Common confi=
guration structure layout}
-
-The driver MUST NOT write to \field{device_feature}, \field{num_queues}, \=
field{config_generation}, \field{queue_notify_off} or \field{queue_notify_d=
ata}.
-
-If VIRTIO_F_RING_PACKED has been negotiated,
-the driver MUST NOT write the value 0 to \field{queue_size}.
-If VIRTIO_F_RING_PACKED has not been negotiated,
-the driver MUST NOT write a value which is not a power of 2 to \field{queu=
e_size}.
-
-The driver MUST configure the other virtqueue fields before enabling the v=
irtqueue
-with \field{queue_enable}.
-
-After writing 0 to \field{device_status}, the driver MUST wait for a read =
of
-\field{device_status} to return 0 before reinitializing the device.
-
-The driver MUST NOT write a 0 to \field{queue_enable}.
-
-If VIRTIO_F_RING_RESET has been negotiated, after the driver writes 1 to
-\field{queue_reset} to reset the queue, the driver MUST NOT consider queue
-reset to be complete until it reads back 0 in \field{queue_reset}. The dri=
ver
-MAY re-enable the queue by writing 1 to \field{queue_enable} after ensurin=
g
-that other virtqueue fields have been set up correctly. The driver MAY set
-driver-writeable queue configuration values to different values than those=
 that
-were used before the queue reset.
-(see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue=
 Reset}).
-
-\subsubsection{Notification structure layout}\label{sec:Virtio Transport O=
ptions / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
-
-The notification location is found using the VIRTIO_PCI_CAP_NOTIFY_CFG
-capability.  This capability is immediately followed by an additional
-field, like so:
-
-\begin{lstlisting}
-struct virtio_pci_notify_cap {
-        struct virtio_pci_cap cap;
-        le32 notify_off_multiplier; /* Multiplier for queue_notify_off. */
-};
-\end{lstlisting}
-
-\field{notify_off_multiplier} is combined with the \field{queue_notify_off=
} to
-derive the Queue Notify address within a BAR for a virtqueue:
-
-\begin{lstlisting}
-        cap.offset + queue_notify_off * notify_off_multiplier
-\end{lstlisting}
-
-The \field{cap.offset} and \field{notify_off_multiplier} are taken from th=
e
-notification capability structure above, and the \field{queue_notify_off} =
is
-taken from the common configuration structure.
-
-\begin{note}
-For example, if \field{notifier_off_multiplier} is 0, the device uses
-the same Queue Notify address for all queues.
-\end{note}
-
-\devicenormative{\paragraph}{Notification capability}{Virtio Transport Opt=
ions / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
-The device MUST present at least one notification capability.
-
-For devices not offering VIRTIO_F_NOTIFICATION_DATA:
-
-The \field{cap.offset} MUST be 2-byte aligned.
-
-The device MUST either present \field{notify_off_multiplier} as an even po=
wer of 2,
-or present \field{notify_off_multiplier} as 0.
-
-The value \field{cap.length} presented by the device MUST be at least 2
-and MUST be large enough to support queue notification offsets
-for all supported queues in all possible configurations.
-
-For all queues, the value \field{cap.length} presented by the device MUST =
satisfy:
-\begin{lstlisting}
-cap.length >=3D queue_notify_off * notify_off_multiplier + 2
-\end{lstlisting}
-
-For devices offering VIRTIO_F_NOTIFICATION_DATA:
-
-The device MUST either present \field{notify_off_multiplier} as a
-number that is a power of 2 that is also a multiple 4,
-or present \field{notify_off_multiplier} as 0.
-
-The \field{cap.offset} MUST be 4-byte aligned.
-
-The value \field{cap.length} presented by the device MUST be at least 4
-and MUST be large enough to support queue notification offsets
-for all supported queues in all possible configurations.
-
-For all queues, the value \field{cap.length} presented by the device MUST =
satisfy:
-\begin{lstlisting}
-cap.length >=3D queue_notify_off * notify_off_multiplier + 4
-\end{lstlisting}
-
-\subsubsection{ISR status capability}\label{sec:Virtio Transport Options /=
 Virtio Over PCI Bus / PCI Device Layout / ISR status capability}
-
-The VIRTIO_PCI_CAP_ISR_CFG capability
-refers to at least a single byte, which contains the 8-bit ISR status fiel=
d
-to be used for INT\#x interrupt handling.
-
-The \field{offset} for the \field{ISR status} has no alignment requirement=
s.
-
-The ISR bits allow the driver to distinguish between device-specific confi=
guration
-change interrupts and normal virtqueue interrupts:
-
-\begin{tabular}{ |l||l|l|l| }
-\hline
-Bits       & 0                               & 1               &  2 to 31 =
\\
-\hline
-Purpose    & Queue Interrupt  & Device Configuration Interrupt & Reserved =
\\
-\hline
-\end{tabular}
-
-To avoid an extra access, simply reading this register resets it to 0 and
-causes the device to de-assert the interrupt.
-
-In this way, driver read of ISR status causes the device to de-assert
-an interrupt.
-
-See sections \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI=
-specific Initialization And Device Operation / Used Buffer Notifications} =
and \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific =
Initialization And Device Operation / Notification of Device Configuration =
Changes} for how this is used.
-
-\devicenormative{\paragraph}{ISR status capability}{Virtio Transport Optio=
ns / Virtio Over PCI Bus / PCI Device Layout / ISR status capability}
-
-The device MUST present at least one VIRTIO_PCI_CAP_ISR_CFG capability. =
=20
-
-The device MUST set the Device Configuration Interrupt bit
-in \field{ISR status} before sending a device configuration
-change notification to the driver.
-
-If MSI-X capability is disabled, the device MUST set the Queue
-Interrupt bit in \field{ISR status} before sending a virtqueue
-notification to the driver.
-
-If MSI-X capability is disabled, the device MUST set the Interrupt Status
-bit in the PCI Status register in the PCI Configuration Header of
-the device to the logical OR of all bits in \field{ISR status} of
-the device.  The device then asserts/deasserts INT\#x interrupts unless ma=
sked
-according to standard PCI rules \hyperref[intro:PCI]{[PCI]}.
-
-The device MUST reset \field{ISR status} to 0 on driver read.
-
-\drivernormative{\paragraph}{ISR status capability}{Virtio Transport Optio=
ns / Virtio Over PCI Bus / PCI Device Layout / ISR status capability}
-
-If MSI-X capability is enabled, the driver SHOULD NOT access
-\field{ISR status} upon detecting a Queue Interrupt.
-
-\subsubsection{Device-specific configuration}\label{sec:Virtio Transport O=
ptions / Virtio Over PCI Bus / PCI Device Layout / Device-specific configur=
ation}
-
-The device MUST present at least one VIRTIO_PCI_CAP_DEVICE_CFG capability =
for
-any device type which has a device-specific configuration.
-
-\devicenormative{\paragraph}{Device-specific configuration}{Virtio Transpo=
rt Options / Virtio Over PCI Bus / PCI Device Layout / Device-specific conf=
iguration}
-
-The \field{offset} for the device-specific configuration MUST be 4-byte al=
igned.
-
-\subsubsection{Shared memory capability}\label{sec:Virtio Transport Option=
s / Virtio Over PCI Bus / PCI Device Layout / Shared memory capability}
-
-Shared memory regions \ref{sec:Basic Facilities of a Virtio
-Device / Shared Memory Regions} are enumerated on the PCI transport
-as a sequence of VIRTIO_PCI_CAP_SHARED_MEMORY_CFG capabilities, one per re=
gion.
-
-The capability is defined by a struct virtio_pci_cap64 and
-utilises the \field{cap.id} to allow multiple shared memory
-regions per device.
-The identifier in \field{cap.id} does not denote a certain order of
-preference; it is only used to uniquely identify a region.
-
-\devicenormative{\paragraph}{Shared memory capability}{Virtio Transport Op=
tions / Virtio Over PCI Bus / PCI Device Layout / Shared memory capability}
-
-The region defined by the combination of the \field{cap.offset},
-\field{offset_hi}, and \field{cap.length}, \field{length_hi}
-fields MUST be contained within the BAR specified by
-\field{cap.bar}.
-
-The \field{cap.id} MUST be unique for any one device instance.
-
-\subsubsection{Vendor data capability}\label{sec:Virtio
-Transport Options / Virtio Over PCI Bus / PCI Device Layout /
-Vendor data capability}
-
-The optional Vendor data capability allows the device to present
-vendor-specific data to the driver, without
-conflicts, for debugging and/or reporting purposes,
-and without conflicting with standard functionality.
-
-This capability augments but does not replace the standard
-subsystem ID and subsystem vendor ID fields
-(offsets 0x2C and 0x2E in the PCI configuration space header)
-as specified by \hyperref[intro:PCI]{[PCI]}.
-
-Vendor data capability is enumerated on the PCI transport
-as a VIRTIO_PCI_CAP_VENDOR_CFG capability.
-
-The capability has the following structure:
-\begin{lstlisting}
-struct virtio_pci_vndr_data {
-        u8 cap_vndr;    /* Generic PCI field: PCI_CAP_ID_VNDR */
-        u8 cap_next;    /* Generic PCI field: next ptr. */
-        u8 cap_len;     /* Generic PCI field: capability length */
-        u8 cfg_type;    /* Identifies the structure. */
-        u16 vendor_id;  /* Identifies the vendor-specific format. */
-=09/* For Vendor Definition */
-=09/* Pads structure to a multiple of 4 bytes */
-=09/* Reads must not have side effects */
-};
-\end{lstlisting}
-
-Where \field{vendor_id} identifies the PCI-SIG assigned Vendor ID
-as specified by \hyperref[intro:PCI]{[PCI]}.
-
-Note that the capability size is required to be a multiple of 4.
-
-To make it safe for a generic driver to access the capability,
-reads from this capability MUST NOT have any side effects.
-
-\devicenormative{\paragraph}{Vendor data capability}{Virtio
-Transport Options / Virtio Over PCI Bus / PCI Device Layout /
-Vendor data capability}
-
-Devices CAN present \field{vendor_id} that does not match
-either the PCI Vendor ID or the PCI Subsystem Vendor ID.
-
-Devices CAN present multiple Vendor data capabilities with
-either different or identical \field{vendor_id} values.
-
-The value \field{vendor_id} MUST NOT equal 0x1AF4.
-
-The size of the Vendor data capability MUST be a multiple of 4 bytes.
-
-Reads of the Vendor data capability by the driver MUST NOT have any
-side effects.
-
-\drivernormative{\paragraph}{Vendor data capability}{Virtio
-Transport Options / Virtio Over PCI Bus / PCI Device Layout /
-Vendor data capability}
-
-The driver SHOULD NOT use the Vendor data capability except
-for debugging and reporting purposes.
-
-The driver MUST qualify the \field{vendor_id} before
-interpreting or writing into the Vendor data capability.
-
-\subsubsection{PCI configuration access capability}\label{sec:Virtio Trans=
port Options / Virtio Over PCI Bus / PCI Device Layout / PCI configuration =
access capability}
-
-The VIRTIO_PCI_CAP_PCI_CFG capability
-creates an alternative (and likely suboptimal) access method to the
-common configuration, notification, ISR and device-specific configuration =
regions.
-
-The capability is immediately followed by an additional field like so:
-
-\begin{lstlisting}
-struct virtio_pci_cfg_cap {
-        struct virtio_pci_cap cap;
-        u8 pci_cfg_data[4]; /* Data for BAR access. */
-};
-\end{lstlisting}
-
-The fields \field{cap.bar}, \field{cap.length}, \field{cap.offset} and
-\field{pci_cfg_data} are read-write (RW) for the driver.
-
-To access a device region, the driver writes into the capability
-structure (ie. within the PCI configuration space) as follows:
-
-\begin{itemize}
-\item The driver sets the BAR to access by writing to \field{cap.bar}.
-
-\item The driver sets the size of the access by writing 1, 2 or 4 to
-  \field{cap.length}.
-
-\item The driver sets the offset within the BAR by writing to
-  \field{cap.offset}.
-\end{itemize}
-
-At that point, \field{pci_cfg_data} will provide a window of size
-\field{cap.length} into the given \field{cap.bar} at offset \field{cap.off=
set}.
-
-\devicenormative{\paragraph}{PCI configuration access capability}{Virtio T=
ransport Options / Virtio Over PCI Bus / PCI Device Layout / PCI configurat=
ion access capability}
-
-The device MUST present at least one VIRTIO_PCI_CAP_PCI_CFG capability.
-
-Upon detecting driver write access
-to \field{pci_cfg_data}, the device MUST execute a write access
-at offset \field{cap.offset} at BAR selected by \field{cap.bar} using the =
first \field{cap.length}
-bytes from \field{pci_cfg_data}.
-
-Upon detecting driver read access
-to \field{pci_cfg_data}, the device MUST
-execute a read access of length cap.length at offset \field{cap.offset}
-at BAR selected by \field{cap.bar} and store the first \field{cap.length} =
bytes in
-\field{pci_cfg_data}.
-
-\drivernormative{\paragraph}{PCI configuration access capability}{Virtio T=
ransport Options / Virtio Over PCI Bus / PCI Device Layout / PCI configurat=
ion access capability}
-
-The driver MUST NOT write a \field{cap.offset} which is not
-a multiple of \field{cap.length} (ie. all accesses MUST be aligned).
-
-The driver MUST NOT read or write \field{pci_cfg_data}
-unless \field{cap.bar}, \field{cap.length} and \field{cap.offset}
-address \field{cap.length} bytes within a BAR range
-specified by some other Virtio Structure PCI Capability
-of type other than \field{VIRTIO_PCI_CAP_PCI_CFG}.
-
-\subsubsection{Legacy Interfaces: A Note on PCI Device Layout}\label{sec:V=
irtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy =
Interfaces: A Note on PCI Device Layout}
-
-Transitional devices MUST present part of configuration
-registers in a legacy configuration structure in BAR0 in the first I/O
-region of the PCI device, as documented below.
-When using the legacy interface, transitional drivers
-MUST use the legacy configuration structure in BAR0 in the first
-I/O region of the PCI device, as documented below.
-
-When using the legacy interface the driver MAY access
-the device-specific configuration region using any width accesses, and
-a transitional device MUST present driver with the same results as
-when accessed using the ``natural'' access method (i.e.
-32-bit accesses for 32-bit fields, etc).
-
-Note that this is possible because while the virtio common configuration s=
tructure is PCI
-(i.e. little) endian, when using the legacy interface the device-specific
-configuration region is encoded in the native endian of the guest (where s=
uch distinction is
-applicable).
-
-When used through the legacy interface, the virtio common configuration st=
ructure looks as follows:
-
-\begin{tabularx}{\textwidth}{ |X||X|X|X|X|X|X|X|X| }
-\hline
- Bits & 32 & 32 & 32 & 16 & 16 & 16 & 8 & 8 \\
-\hline
- Read / Write & R & R+W & R+W & R & R+W & R+W & R+W & R \\
-\hline
- Purpose & Device Features bits 0:31 & Driver Features bits 0:31 &
-  Queue Address & \field{queue_size} & \field{queue_select} & Queue Notify=
 &
-  Device Status & ISR \newline Status \\
-\hline
-\end{tabularx}
-
-If MSI-X is enabled for the device, two additional fields
-immediately follow this header:
-
-\begin{tabular}{ |l||l|l| }
-\hline
-Bits       & 16             & 16     \\
-\hline
-Read/Write & R+W            & R+W    \\
-\hline
-Purpose (MSI-X) & \field{config_msix_vector}  & \field{queue_msix_vector} =
\\
-\hline
-\end{tabular}
-
-Note: When MSI-X capability is enabled, device-specific configuration star=
ts at
-byte offset 24 in virtio common configuration structure structure. When MS=
I-X capability is not
-enabled, device-specific configuration starts at byte offset 20 in virtio
-header.  ie. once you enable MSI-X on the device, the other fields move.
-If you turn it off again, they move back!
-
-Any device-specific configuration space immediately follows
-these general headers:
-
-\begin{tabular}{|l||l|l|}
-\hline
-Bits & Device Specific & \multirow{3}{*}{\ldots} \\
-\cline{1-2}
-Read / Write & Device Specific & \\
-\cline{1-2}
-Purpose & Device Specific & \\
-\hline
-\end{tabular}
-
-When accessing the device-specific configuration space
-using the legacy interface, transitional
-drivers MUST access the device-specific configuration space
-at an offset immediately following the general headers.
-
-When using the legacy interface, transitional
-devices MUST present the device-specific configuration space
-if any at an offset immediately following the general headers.
-
-Note that only Feature Bits 0 to 31 are accessible through the
-Legacy Interface. When used through the Legacy Interface,
-Transitional Devices MUST assume that Feature Bits 32 to 63
-are not acknowledged by Driver.
-
-As legacy devices had no \field{config_generation} field,
-see \ref{sec:Basic Facilities of a Virtio Device / Device
-Configuration Space / Legacy Interface: Device Configuration
-Space}~\nameref{sec:Basic Facilities of a Virtio Device / Device Configura=
tion Space / Legacy Interface: Device Configuration Space} for workarounds.
-
-\subsubsection{Non-transitional Device With Legacy Driver: A Note
-on PCI Device Layout}\label{sec:Virtio Transport Options / Virtio
-Over PCI Bus / PCI Device Layout / Non-transitional Device With
-Legacy Driver: A Note on PCI Device Layout}
-
-All known legacy drivers check either the PCI Revision or the
-Device and Vendor IDs, and thus won't attempt to drive a
-non-transitional device.
-
-A buggy legacy driver might mistakenly attempt to drive a
-non-transitional device. If support for such drivers is required
-(as opposed to fixing the bug), the following would be the
-recommended way to detect and handle them.
-\begin{note}
-Such buggy drivers are not currently known to be used in
-production.
-\end{note}
-
-\subparagraph{Device Requirements: Non-transitional Device With Legacy Dri=
ver}
-\label{drivernormative:Virtio Transport Options / Virtio Over PCI
-Bus / PCI-specific Initialization And Device Operation /
-Device Initialization / Non-transitional Device With Legacy
-Driver}
-\label{devicenormative:Virtio Transport Options / Virtio Over PCI
-Bus / PCI-specific Initialization And Device Operation /
-Device Initialization / Non-transitional Device With Legacy
-Driver}
-
-Non-transitional devices, on a platform where a legacy driver for
-a legacy device with the same ID (including PCI Revision, Device
-and Vendor IDs) is known to have previously existed,
-SHOULD take the following steps to cause the legacy driver to
-fail gracefully when it attempts to drive them:
-
-\begin{enumerate}
-\item Present an I/O BAR in BAR0, and
-\item Respond to a single-byte zero write to offset 18
-   (corresponding to Device Status register in the legacy layout)
-   of BAR0 by presenting zeroes on every BAR and ignoring writes.
-\end{enumerate}
-
-\subsection{PCI-specific Initialization And Device Operation}\label{sec:Vi=
rtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization =
And Device Operation}
-
-\subsubsection{Device Initialization}\label{sec:Virtio Transport Options /=
 Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / D=
evice Initialization}
-
-This documents PCI-specific steps executed during Device Initialization.
-
-\paragraph{Virtio Device Configuration Layout Detection}\label{sec:Virtio =
Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And D=
evice Operation / Device Initialization / Virtio Device Configuration Layou=
t Detection}
-
-As a prerequisite to device initialization, the driver scans the
-PCI capability list, detecting virtio configuration layout using Virtio
-Structure PCI capabilities as detailed in \ref{sec:Virtio Transport Option=
s / Virtio Over PCI Bus / Virtio Structure PCI Capabilities}
-
-\subparagraph{Legacy Interface: A Note on Device Layout Detection}\label{s=
ec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initializa=
tion And Device Operation / Device Initialization / Virtio Device Configura=
tion Layout Detection / Legacy Interface: A Note on Device Layout Detection=
}
-
-Legacy drivers skipped the Device Layout Detection step, assuming legacy
-device configuration space in BAR0 in I/O space unconditionally.
-
-Legacy devices did not have the Virtio PCI Capability in their
-capability list.
-
-Therefore:
-
-Transitional devices MUST expose the Legacy Interface in I/O
-space in BAR0.
-
-Transitional drivers MUST look for the Virtio PCI
-Capabilities on the capability list.
-If these are not present, driver MUST assume a legacy device,
-and use it through the legacy interface.
-
-Non-transitional drivers MUST look for the Virtio PCI
-Capabilities on the capability list.
-If these are not present, driver MUST assume a legacy device,
-and fail gracefully.
-
-\paragraph{MSI-X Vector Configuration}\label{sec:Virtio Transport Options =
/ Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / =
Device Initialization / MSI-X Vector Configuration}
-
-When MSI-X capability is present and enabled in the device
-(through standard PCI configuration space) \field{config_msix_vector} and =
\field{queue_msix_vector} are used to map configuration change and queue
-interrupts to MSI-X vectors. In this case, the ISR Status is unused.
-
-Writing a valid MSI-X Table entry number, 0 to 0x7FF, to
-\field{config_msix_vector}/\field{queue_msix_vector} maps interrupts trigg=
ered
-by the configuration change/selected queue events respectively to
-the corresponding MSI-X vector. To disable interrupts for an
-event type, the driver unmaps this event by writing a special NO_VECTOR
-value:
-
-\begin{lstlisting}
-/* Vector value used to disable MSI for queue */
-#define VIRTIO_MSI_NO_VECTOR            0xffff
-\end{lstlisting}
-
-Note that mapping an event to vector might require device to
-allocate internal device resources, and thus could fail.=20
-
-\devicenormative{\subparagraph}{MSI-X Vector Configuration}{Virtio Transpo=
rt Options / Virtio Over PCI Bus / PCI-specific Initialization And Device O=
peration / Device Initialization / MSI-X Vector Configuration}
-
-A device that has an MSI-X capability SHOULD support at least 2
-and at most 0x800 MSI-X vectors.
-Device MUST report the number of vectors supported in
-\field{Table Size} in the MSI-X Capability as specified in
-\hyperref[intro:PCI]{[PCI]}.
-The device SHOULD restrict the reported MSI-X Table Size field
-to a value that might benefit system performance.
-\begin{note}
-For example, a device which does not expect to send
-interrupts at a high rate might only specify 2 MSI-X vectors.
-\end{note}
-Device MUST support mapping any event type to any valid
-vector 0 to MSI-X \field{Table Size}.
-Device MUST support unmapping any event type.
-
-The device MUST return vector mapped to a given event,
-(NO_VECTOR if unmapped) on read of \field{config_msix_vector}/\field{queue=
_msix_vector}.
-The device MUST have all queue and configuration change
-events are unmapped upon reset.
-
-Devices SHOULD NOT cause mapping an event to vector to fail
-unless it is impossible for the device to satisfy the mapping
-request.  Devices MUST report mapping
-failures by returning the NO_VECTOR value when the relevant
-\field{config_msix_vector}/\field{queue_msix_vector} field is read.=20
-
-\drivernormative{\subparagraph}{MSI-X Vector Configuration}{Virtio Transpo=
rt Options / Virtio Over PCI Bus / PCI-specific Initialization And Device O=
peration / Device Initialization / MSI-X Vector Configuration}
-
-Driver MUST support device with any MSI-X Table Size 0 to 0x7FF.
-Driver MAY fall back on using INT\#x interrupts for a device
-which only supports one MSI-X vector (MSI-X Table Size =3D 0).
-
-Driver MAY intepret the Table Size as a hint from the device
-for the suggested number of MSI-X vectors to use.
-
-Driver MUST NOT attempt to map an event to a vector
-outside the MSI-X Table supported by the device,
-as reported by \field{Table Size} in the MSI-X Capability.
-
-After mapping an event to vector, the
-driver MUST verify success by reading the Vector field value: on
-success, the previously written value is returned, and on
-failure, NO_VECTOR is returned. If a mapping failure is detected,
-the driver MAY retry mapping with fewer vectors, disable MSI-X
-or report device failure.
-
-\paragraph{Virtqueue Configuration}\label{sec:Virtio Transport Options / V=
irtio Over PCI Bus / PCI-specific Initialization And Device Operation / Dev=
ice Initialization / Virtqueue Configuration}
-
-As a device can have zero or more virtqueues for bulk data
-transport\footnote{For example, the simplest network device has two virtqu=
eues.}, the driver
-needs to configure them as part of the device-specific
-configuration.
-
-The driver typically does this as follows, for each virtqueue a device has=
:
-
-\begin{enumerate}
-\item Write the virtqueue index (first queue is 0) to \field{queue_select}=
.
-
-\item Read the virtqueue size from \field{queue_size}. This controls how b=
ig the virtqueue is
-  (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}~\nameref=
{sec:Basic Facilities of a Virtio Device / Virtqueues}). If this field is 0=
, the virtqueue does not exist.
-
-\item Optionally, select a smaller virtqueue size and write it to \field{q=
ueue_size}.
-
-\item Allocate and zero Descriptor Table, Available and Used rings for the
-   virtqueue in contiguous physical memory.
-
-\item Optionally, if MSI-X capability is present and enabled on the
-  device, select a vector to use to request interrupts triggered
-  by virtqueue events. Write the MSI-X Table entry number
-  corresponding to this vector into \field{queue_msix_vector}. Read
-  \field{queue_msix_vector}: on success, previously written value is
-  returned; on failure, NO_VECTOR value is returned.
-\end{enumerate}
-
-\subparagraph{Legacy Interface: A Note on Virtqueue Configuration}\label{s=
ec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initializa=
tion And Device Operation / Device Initialization / Virtqueue Configuration=
 / Legacy Interface: A Note on Virtqueue Configuration}
-When using the legacy interface, the queue layout follows \ref{sec:Basic F=
acilities of a Virtio Device / Virtqueues / Legacy Interfaces: A Note on Vi=
rtqueue Layout}~\nameref{sec:Basic Facilities of a Virtio Device / Virtqueu=
es / Legacy Interfaces: A Note on Virtqueue Layout} with an alignment of 40=
96.
-Driver writes the physical address, divided
-by 4096 to the Queue Address field\footnote{The 4096 is based on the x86 p=
age size, but it's also large
-enough to ensure that the separate parts of the virtqueue are on
-separate cache lines.
-}.  There was no mechanism to negotiate the queue size.
-
-\subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport =
Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Oper=
ation / Available Buffer Notifications}
-
-When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
-the driver sends an available buffer notification to the device by writing
-the 16-bit virtqueue index
-of this virtqueue to the Queue Notify address.
-
-When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
-the driver sends an available buffer notification to the device by writing
-the following 32-bit value to the Queue Notify address:
-\lstinputlisting{notifications-le.c}
-
-See \ref{sec:Basic Facilities of a Virtio Device / Driver notifications}~\=
nameref{sec:Basic Facilities of a Virtio Device / Driver notifications}
-for the definition of the components.
-
-See \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device L=
ayout / Notification capability}
-for how to calculate the Queue Notify address.
-
-\drivernormative{\paragraph}{Available Buffer Notifications}{Virtio Transp=
ort Options / Virtio Over PCI Bus / PCI-specific Initialization And Device =
Operation / Available Buffer Notifications}
-If VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated:
-\begin{itemize}
-\item If VIRTIO_F_NOTIFICATION_DATA has not been negotiated, the driver MU=
ST use the
-\field{queue_notify_data} value instead of the virtqueue index.
-\item If VIRTIO_F_NOTIFICATION_DATA has been negotiated, the driver MUST s=
et the
-\field{vqn} field to the \field{queue_notify_data} value.
-\end{itemize}
-
-\subsubsection{Used Buffer Notifications}\label{sec:Virtio Transport Optio=
ns / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation=
 / Used Buffer Notifications}
-
-If a used buffer notification is necessary for a virtqueue, the device wou=
ld typically act as follows:
-
-\begin{itemize}
-  \item If MSI-X capability is disabled:
-    \begin{enumerate}
-    \item Set the lower bit of the ISR Status field for the device.
-
-    \item Send the appropriate PCI interrupt for the device.
-    \end{enumerate}
-
-  \item If MSI-X capability is enabled:
-    \begin{enumerate}
-    \item If \field{queue_msix_vector} is not NO_VECTOR,
-      request the appropriate MSI-X interrupt message for the
-      device, \field{queue_msix_vector} sets the MSI-X Table entry
-      number.
-    \end{enumerate}
-\end{itemize}
-
-\devicenormative{\paragraph}{Used Buffer Notifications}{Virtio Transport O=
ptions / Virtio Over PCI Bus / PCI-specific Initialization And Device Opera=
tion / Used Buffer Notifications}
-
-If MSI-X capability is enabled and \field{queue_msix_vector} is
-NO_VECTOR for a virtqueue, the device MUST NOT deliver an interrupt
-for that virtqueue.
-
-\subsubsection{Notification of Device Configuration Changes}\label{sec:Vir=
tio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization A=
nd Device Operation / Notification of Device Configuration Changes}
-
-Some virtio PCI devices can change the device configuration
-state, as reflected in the device-specific configuration region of the dev=
ice. In this case:
-
-\begin{itemize}
-  \item If MSI-X capability is disabled:
-    \begin{enumerate}
-    \item Set the second lower bit of the ISR Status field for the device.
-
-    \item Send the appropriate PCI interrupt for the device.
-    \end{enumerate}
-
-  \item If MSI-X capability is enabled:
-    \begin{enumerate}
-    \item If \field{config_msix_vector} is not NO_VECTOR,
-      request the appropriate MSI-X interrupt message for the
-      device, \field{config_msix_vector} sets the MSI-X Table entry
-      number.
-    \end{enumerate}
-\end{itemize}
-
-A single interrupt MAY indicate both that one or more virtqueue has
-been used and that the configuration space has changed.
-
-\devicenormative{\paragraph}{Notification of Device Configuration Changes}=
{Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initializati=
on And Device Operation / Notification of Device Configuration Changes}
-
-If MSI-X capability is enabled and \field{config_msix_vector} is
-NO_VECTOR, the device MUST NOT deliver an interrupt
-for device configuration space changes.
-
-\drivernormative{\paragraph}{Notification of Device Configuration Changes}=
{Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initializati=
on And Device Operation / Notification of Device Configuration Changes}
-
-A driver MUST handle the case where the same interrupt is used to indicate
-both device configuration space change and one or more virtqueues being us=
ed.
-
-\subsubsection{Driver Handling Interrupts}\label{sec:Virtio Transport Opti=
ons / Virtio Over PCI Bus / PCI-specific Initialization And Device Operatio=
n / Driver Handling Interrupts}
-The driver interrupt handler would typically:
-
-\begin{itemize}
-  \item If MSI-X capability is disabled:
-    \begin{itemize}
-      \item Read the ISR Status field, which will reset it to zero.
-      \item If the lower bit is set:
-        look through all virtqueues for the
-        device, to see if any progress has been made by the device
-        which requires servicing.
-      \item If the second lower bit is set:
-        re-examine the configuration space to see what changed.
-    \end{itemize}
-  \item If MSI-X capability is enabled:
-    \begin{itemize}
-      \item
-        Look through all virtqueues mapped to that MSI-X vector for the
-        device, to see if any progress has been made by the device
-        which requires servicing.
-      \item
-        If the MSI-X vector is equal to \field{config_msix_vector},
-        re-examine the configuration space to see what changed.
-    \end{itemize}
-\end{itemize}
+\input{transport-pci.tex}
=20
 \section{Virtio Over MMIO}\label{sec:Virtio Transport Options / Virtio Ove=
r MMIO}
=20
diff --git a/transport-pci.tex b/transport-pci.tex
new file mode 100644
index 0000000..9c820f9
--- /dev/null
+++ b/transport-pci.tex
@@ -0,0 +1,1149 @@
+\section{Virtio Over PCI Bus}\label{sec:Virtio Transport Options / Virtio =
Over PCI Bus}
+
+Virtio devices are commonly implemented as PCI devices.
+
+A Virtio device can be implemented as any kind of PCI device:
+a Conventional PCI device or a PCI Express
+device.  To assure designs meet the latest level
+requirements, see=20
+the PCI-SIG home page at \url{http://www.pcisig.com} for any
+approved changes.
+
+\devicenormative{\subsection}{Virtio Over PCI Bus}{Virtio Transport Option=
s / Virtio Over PCI Bus}
+A Virtio device using Virtio Over PCI Bus MUST expose to
+guest an interface that meets the specification requirements of
+the appropriate PCI specification: \hyperref[intro:PCI]{[PCI]}
+and \hyperref[intro:PCIe]{[PCIe]}
+respectively.=20
+
+\subsection{PCI Device Discovery}\label{sec:Virtio Transport Options / Vir=
tio Over PCI Bus / PCI Device Discovery}
+
+Any PCI device with PCI Vendor ID 0x1AF4, and PCI Device ID 0x1000 through
+0x107F inclusive is a virtio device. The actual value within this range
+indicates which virtio device is supported by the device.
+The PCI Device ID is calculated by adding 0x1040 to the Virtio Device ID,
+as indicated in section \ref{sec:Device Types}.
+Additionally, devices MAY utilize a Transitional PCI Device ID range,
+0x1000 to 0x103F depending on the device type.
+
+\devicenormative{\subsubsection}{PCI Device Discovery}{Virtio Transport Op=
tions / Virtio Over PCI Bus / PCI Device Discovery}
+
+Devices MUST have the PCI Vendor ID 0x1AF4.
+Devices MUST either have the PCI Device ID calculated by adding 0x1040
+to the Virtio Device ID, as indicated in section \ref{sec:Device
+Types} or have the Transitional PCI Device ID depending on the device type=
,
+as follows:
+
+\begin{tabular}{|l|c|}
+\hline
+Transitional PCI Device ID  &  Virtio Device    \\
+\hline \hline
+0x1000      &   network device     \\
+\hline
+0x1001     &   block device     \\
+\hline
+0x1002     & memory ballooning (traditional)  \\
+\hline
+0x1003     &      console       \\
+\hline
+0x1004     &     SCSI host      \\
+\hline
+0x1005     &  entropy source    \\
+\hline
+0x1009     &   9P transport     \\
+\hline
+\end{tabular}
+
+For example, the network device with the Virtio Device ID 1
+has the PCI Device ID 0x1041 or the Transitional PCI Device ID 0x1000.
+
+The PCI Subsystem Vendor ID and the PCI Subsystem Device ID MAY reflect
+the PCI Vendor and Device ID of the environment (for informational purpose=
s by the driver).
+
+Non-transitional devices SHOULD have a PCI Device ID in the range
+0x1040 to 0x107f.
+Non-transitional devices SHOULD have a PCI Revision ID of 1 or higher.
+Non-transitional devices SHOULD have a PCI Subsystem Device ID of 0x40 or =
higher.
+
+This is to reduce the chance of a legacy driver attempting
+to drive the device.
+
+\drivernormative{\subsubsection}{PCI Device Discovery}{Virtio Transport Op=
tions / Virtio Over PCI Bus / PCI Device Discovery}
+Drivers MUST match devices with the PCI Vendor ID 0x1AF4 and
+the PCI Device ID in the range 0x1040 to 0x107f,
+calculated by adding 0x1040 to the Virtio Device ID,
+as indicated in section \ref{sec:Device Types}.
+Drivers for device types listed in section \ref{sec:Virtio
+Transport Options / Virtio Over PCI Bus / PCI Device Discovery}
+MUST match devices with the PCI Vendor ID 0x1AF4 and
+the Transitional PCI Device ID indicated in section
+ \ref{sec:Virtio
+Transport Options / Virtio Over PCI Bus / PCI Device Discovery}.
+
+Drivers MUST match any PCI Revision ID value.
+Drivers MAY match any PCI Subsystem Vendor ID and any
+PCI Subsystem Device ID value.
+
+\subsubsection{Legacy Interfaces: A Note on PCI Device Discovery}\label{se=
c:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery / L=
egacy Interfaces: A Note on PCI Device Discovery}
+Transitional devices MUST have a PCI Revision ID of 0.
+Transitional devices MUST have the PCI Subsystem Device ID
+matching the Virtio Device ID, as indicated in section \ref{sec:Device Typ=
es}.
+Transitional devices MUST have the Transitional PCI Device ID in
+the range 0x1000 to 0x103f.
+
+This is to match legacy drivers.
+
+\subsection{PCI Device Layout}\label{sec:Virtio Transport Options / Virtio=
 Over PCI Bus / PCI Device Layout}
+
+The device is configured via I/O and/or memory regions (though see
+\ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layou=
t / PCI configuration access capability}
+for access via the PCI configuration space), as specified by Virtio
+Structure PCI Capabilities.
+
+Fields of different sizes are present in the device
+configuration regions.
+All 64-bit, 32-bit and 16-bit fields are little-endian.
+64-bit fields are to be treated as two 32-bit fields,
+with low 32 bit part followed by the high 32 bit part.
+
+\drivernormative{\subsubsection}{PCI Device Layout}{Virtio Transport Optio=
ns / Virtio Over PCI Bus / PCI Device Layout}
+
+For device configuration access, the driver MUST use 8-bit wide
+accesses for 8-bit wide fields, 16-bit wide and aligned accesses
+for 16-bit wide fields and 32-bit wide and aligned accesses for
+32-bit and 64-bit wide fields. For 64-bit fields, the driver MAY
+access each of the high and low 32-bit parts of the field
+independently.
+
+\devicenormative{\subsubsection}{PCI Device Layout}{Virtio Transport Optio=
ns / Virtio Over PCI Bus / PCI Device Layout}
+
+For 64-bit device configuration fields, the device MUST allow driver
+independent access to high and low 32-bit parts of the field.
+
+\subsection{Virtio Structure PCI Capabilities}\label{sec:Virtio Transport =
Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities}
+
+The virtio device configuration layout includes several structures:
+\begin{itemize}
+\item Common configuration
+\item Notifications
+\item ISR Status
+\item Device-specific configuration (optional)
+\item PCI configuration access
+\end{itemize}
+
+Each structure can be mapped by a Base Address register (BAR) belonging to
+the function, or accessed via the special VIRTIO_PCI_CAP_PCI_CFG field in =
the PCI configuration space.
+
+The location of each structure is specified using a vendor-specific PCI ca=
pability located
+on the capability list in PCI configuration space of the device.
+This virtio structure capability uses little-endian format; all fields are
+read-only for the driver unless stated otherwise:
+
+\begin{lstlisting}
+struct virtio_pci_cap {
+        u8 cap_vndr;    /* Generic PCI field: PCI_CAP_ID_VNDR */
+        u8 cap_next;    /* Generic PCI field: next ptr. */
+        u8 cap_len;     /* Generic PCI field: capability length */
+        u8 cfg_type;    /* Identifies the structure. */
+        u8 bar;         /* Where to find it. */
+        u8 id;          /* Multiple capabilities of the same type */
+        u8 padding[2];  /* Pad to full dword. */
+        le32 offset;    /* Offset within bar. */
+        le32 length;    /* Length of the structure, in bytes. */
+};
+\end{lstlisting}
+
+This structure can be followed by extra data, depending on
+\field{cfg_type}, as documented below.
+
+The fields are interpreted as follows:
+
+\begin{description}
+\item[\field{cap_vndr}]
+        0x09; Identifies a vendor-specific capability.
+
+\item[\field{cap_next}]
+        Link to next capability in the capability list in the PCI configur=
ation space.
+
+\item[\field{cap_len}]
+        Length of this capability structure, including the whole of
+        struct virtio_pci_cap, and extra data if any.
+        This length MAY include padding, or fields unused by the driver.
+
+\item[\field{cfg_type}]
+        identifies the structure, according to the following table:
+
+\begin{lstlisting}
+/* Common configuration */
+#define VIRTIO_PCI_CAP_COMMON_CFG        1
+/* Notifications */
+#define VIRTIO_PCI_CAP_NOTIFY_CFG        2
+/* ISR Status */
+#define VIRTIO_PCI_CAP_ISR_CFG           3
+/* Device specific configuration */
+#define VIRTIO_PCI_CAP_DEVICE_CFG        4
+/* PCI configuration access */
+#define VIRTIO_PCI_CAP_PCI_CFG           5
+/* Shared memory region */
+#define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
+/* Vendor-specific data */
+#define VIRTIO_PCI_CAP_VENDOR_CFG        9
+\end{lstlisting}
+
+        Any other value is reserved for future use.
+
+        Each structure is detailed individually below.
+
+        The device MAY offer more than one structure of any type - this ma=
kes it
+        possible for the device to expose multiple interfaces to drivers. =
 The order of
+        the capabilities in the capability list specifies the order of pre=
ference
+        suggested by the device.  A device may specify that this ordering =
mechanism be
+        overridden by the use of the \field{id} field.
+        \begin{note}
+          For example, on some hypervisors, notifications using IO accesse=
s are
+        faster than memory accesses. In this case, the device would expose=
 two
+        capabilities with \field{cfg_type} set to VIRTIO_PCI_CAP_NOTIFY_CF=
G:
+        the first one addressing an I/O BAR, the second one addressing a m=
emory BAR.
+        In this example, the driver would use the I/O BAR if I/O resources=
 are available, and fall back on
+        memory BAR when I/O resources are unavailable.
+        \end{note}
+
+\item[\field{bar}]
+        values 0x0 to 0x5 specify a Base Address register (BAR) belonging =
to
+        the function located beginning at 10h in PCI Configuration Space
+        and used to map the structure into Memory or I/O Space.
+        The BAR is permitted to be either 32-bit or 64-bit, it can map Mem=
ory Space
+        or I/O Space.
+
+        Any other value is reserved for future use.
+
+\item[\field{id}]
+        Used by some device types to uniquely identify multiple capabiliti=
es
+        of a certain type. If the device type does not specify the meaning=
 of
+        this field, its contents are undefined.
+
+
+\item[\field{offset}]
+        indicates where the structure begins relative to the base address =
associated
+        with the BAR.  The alignment requirements of \field{offset} are in=
dicated
+        in each structure-specific section below.
+
+\item[\field{length}]
+        indicates the length of the structure.
+
+        \field{length} MAY include padding, or fields unused by the driver=
, or
+        future extensions.
+
+        \begin{note}
+        For example, a future device might present a large structure size =
of several
+        MBytes.
+        As current devices never utilize structures larger than 4KBytes in=
 size,
+        driver MAY limit the mapped structure size to e.g.
+        4KBytes (thus ignoring parts of structure after the first
+        4KBytes) to allow forward compatibility with such devices without =
loss of
+        functionality and without wasting resources.
+        \end{note}
+\end{description}
+
+A variant of this type, struct virtio_pci_cap64, is defined for
+those capabilities that require offsets or lengths larger than
+4GiB:
+
+\begin{lstlisting}
+struct virtio_pci_cap64 {
+        struct virtio_pci_cap cap;
+        u32 offset_hi;
+        u32 length_hi;
+};
+\end{lstlisting}
+
+Given that the \field{cap.length} and \field{cap.offset} fields
+are only 32 bit, the additional \field{offset_hi} and \field{length_hi}
+fields provide the most significant 32 bits of a total 64 bit offset and
+length within the BAR specified by \field{cap.bar}.
+
+\drivernormative{\subsubsection}{Virtio Structure PCI Capabilities}{Virtio=
 Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilitie=
s}
+
+The driver MUST ignore any vendor-specific capability structure which has
+a reserved \field{cfg_type} value.
+
+The driver SHOULD use the first instance of each virtio structure type the=
y can
+support.
+
+The driver MUST accept a \field{cap_len} value which is larger than specif=
ied here.
+
+The driver MUST ignore any vendor-specific capability structure which has
+a reserved \field{bar} value.
+
+        The drivers SHOULD only map part of configuration structure
+        large enough for device operation.  The drivers MUST handle
+        an unexpectedly large \field{length}, but MAY check that \field{le=
ngth}
+        is large enough for device operation.
+
+The driver MUST NOT write into any field of the capability structure,
+with the exception of those with \field{cap_type} VIRTIO_PCI_CAP_PCI_CFG a=
s
+detailed in \ref{drivernormative:Virtio Transport Options / Virtio Over PC=
I Bus / PCI Device Layout / PCI configuration access capability}.
+
+\devicenormative{\subsubsection}{Virtio Structure PCI Capabilities}{Virtio=
 Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilitie=
s}
+
+The device MUST include any extra data (from the beginning of the \field{c=
ap_vndr} field
+through end of the extra data fields if any) in \field{cap_len}.
+The device MAY append extra data
+or padding to any structure beyond that.
+
+If the device presents multiple structures of the same type, it SHOULD ord=
er
+them from optimal (first) to least-optimal (last).
+
+\subsubsection{Common configuration structure layout}\label{sec:Virtio Tra=
nsport Options / Virtio Over PCI Bus / PCI Device Layout / Common configura=
tion structure layout}
+
+The common configuration structure is found at the \field{bar} and \field{=
offset} within the VIRTIO_PCI_CAP_COMMON_CFG capability; its layout is belo=
w.
+
+\begin{lstlisting}
+struct virtio_pci_common_cfg {
+        /* About the whole device. */
+        le32 device_feature_select;     /* read-write */
+        le32 device_feature;            /* read-only for driver */
+        le32 driver_feature_select;     /* read-write */
+        le32 driver_feature;            /* read-write */
+        le16 config_msix_vector;        /* read-write */
+        le16 num_queues;                /* read-only for driver */
+        u8 device_status;               /* read-write */
+        u8 config_generation;           /* read-only for driver */
+
+        /* About a specific virtqueue. */
+        le16 queue_select;              /* read-write */
+        le16 queue_size;                /* read-write */
+        le16 queue_msix_vector;         /* read-write */
+        le16 queue_enable;              /* read-write */
+        le16 queue_notify_off;          /* read-only for driver */
+        le64 queue_desc;                /* read-write */
+        le64 queue_driver;              /* read-write */
+        le64 queue_device;              /* read-write */
+        le16 queue_notify_data;         /* read-only for driver */
+        le16 queue_reset;               /* read-write */
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{device_feature_select}]
+        The driver uses this to select which feature bits \field{device_fe=
ature} shows.
+        Value 0x0 selects Feature Bits 0 to 31, 0x1 selects Feature Bits 3=
2 to 63, etc.
+
+\item[\field{device_feature}]
+        The device uses this to report which feature bits it is
+        offering to the driver: the driver writes to
+        \field{device_feature_select} to select which feature bits are pre=
sented.
+
+\item[\field{driver_feature_select}]
+        The driver uses this to select which feature bits \field{driver_fe=
ature} shows.
+        Value 0x0 selects Feature Bits 0 to 31, 0x1 selects Feature Bits 3=
2 to 63, etc.
+
+\item[\field{driver_feature}]
+        The driver writes this to accept feature bits offered by the devic=
e.
+        Driver Feature Bits selected by \field{driver_feature_select}.
+
+\item[\field{config_msix_vector}]
+        The driver sets the Configuration Vector for MSI-X.
+
+\item[\field{num_queues}]
+        The device specifies the maximum number of virtqueues supported he=
re.
+
+\item[\field{device_status}]
+        The driver writes the device status here (see \ref{sec:Basic Facil=
ities of a Virtio Device / Device Status Field}). Writing 0 into this
+        field resets the device.
+
+\item[\field{config_generation}]
+        Configuration atomicity value.  The device changes this every time=
 the
+        configuration noticeably changes.
+
+\item[\field{queue_select}]
+        Queue Select. The driver selects which virtqueue the following
+        fields refer to.
+
+\item[\field{queue_size}]
+        Queue Size.  On reset, specifies the maximum queue size supported =
by
+        the device. This can be modified by the driver to reduce memory re=
quirements.
+        A 0 means the queue is unavailable.
+
+\item[\field{queue_msix_vector}]
+        The driver uses this to specify the queue vector for MSI-X.
+
+\item[\field{queue_enable}]
+        The driver uses this to selectively prevent the device from execut=
ing requests from this virtqueue.
+        1 - enabled; 0 - disabled.
+
+\item[\field{queue_notify_off}]
+        The driver reads this to calculate the offset from start of Notifi=
cation structure at
+        which this virtqueue is located.
+        \begin{note} this is \em{not} an offset in bytes.
+        See \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI =
Device Layout / Notification capability} below.
+        \end{note}
+
+\item[\field{queue_desc}]
+        The driver writes the physical address of Descriptor Area here.  S=
ee section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}.
+
+\item[\field{queue_driver}]
+        The driver writes the physical address of Driver Area here.  See s=
ection \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}.
+
+\item[\field{queue_device}]
+        The driver writes the physical address of Device Area here.  See s=
ection \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}.
+
+\item[\field{queue_notify_data}]
+        This field exists only if VIRTIO_F_NOTIF_CONFIG_DATA has been nego=
tiated.
+        The driver will use this value to put it in the 'virtqueue number'=
 field
+        in the available buffer notification structure.
+        See section \ref{sec:Virtio Transport Options / Virtio Over PCI Bu=
s / PCI-specific Initialization And Device Operation / Available Buffer Not=
ifications}.
+        \begin{note}
+        This field provides the device with flexibility to determine how v=
irtqueues
+        will be referred to in available buffer notifications.
+        In a trivial case the device can set \field{queue_notify_data}=3Dv=
qn. Some devices
+        may benefit from providing another value, for example an internal =
virtqueue
+        identifier, or an internal offset related to the virtqueue number.
+        \end{note}
+
+\item[\field{queue_reset}]
+        The driver uses this to selectively reset the queue.
+        This field exists only if VIRTIO_F_RING_RESET has been
+        negotiated. (see \ref{sec:Basic Facilities of a Virtio Device / Vi=
rtqueues / Virtqueue Reset}).
+
+\end{description}
+
+\devicenormative{\paragraph}{Common configuration structure layout}{Virtio=
 Transport Options / Virtio Over PCI Bus / PCI Device Layout / Common confi=
guration structure layout}
+\field{offset} MUST be 4-byte aligned.
+
+The device MUST present at least one common configuration capability.
+
+The device MUST present the feature bits it is offering in \field{device_f=
eature}, starting at bit \field{device_feature_select} $*$ 32 for any \fiel=
d{device_feature_select} written by the driver.
+\begin{note}
+  This means that it will present 0 for any \field{device_feature_select} =
other than 0 or 1, since no feature defined here exceeds 63.
+\end{note}
+
+The device MUST present any valid feature bits the driver has written in \=
field{driver_feature}, starting at bit \field{driver_feature_select} $*$ 32=
 for any \field{driver_feature_select} written by the driver.  Valid featur=
e bits are those which are subset of the corresponding \field{device_featur=
e} bits.  The device MAY present invalid bits written by the driver.
+
+\begin{note}
+  This means that a device can ignore writes for feature bits it never
+  offers, and simply present 0 on reads.  Or it can just mirror what the d=
river wrote
+  (but it will still have to check them when the driver sets FEATURES_OK).
+\end{note}
+
+\begin{note}
+  A driver shouldn't write invalid bits anyway, as per \ref{drivernormativ=
e:General Initialization And Device Operation / Device Initialization}, but=
 this attempts to handle it.
+\end{note}
+
+The device MUST present a changed \field{config_generation} after the
+driver has read a device-specific configuration value which has
+changed since any part of the device-specific configuration was last
+read.
+\begin{note}
+As \field{config_generation} is an 8-bit value, simply incrementing it
+on every configuration change could violate this requirement due to wrap.
+Better would be to set an internal flag when it has changed,
+and if that flag is set when the driver reads from the device-specific
+configuration, increment \field{config_generation} and clear the flag.
+\end{note}
+
+The device MUST reset when 0 is written to \field{device_status}, and
+present a 0 in \field{device_status} once that is done.
+
+The device MUST present a 0 in \field{queue_enable} on reset.
+
+If VIRTIO_F_RING_RESET has been negotiated, the device MUST present a 0 in
+\field{queue_reset} on reset.
+
+If VIRTIO_F_RING_RESET has been negotiated, the device MUST present a 0 in
+\field{queue_reset} after the virtqueue is enabled with \field{queue_enabl=
e}.
+
+The device MUST reset the queue when 1 is written to \field{queue_reset}. =
The
+device MUST continue to present 1 in \field{queue_reset} as long as the qu=
eue reset
+is ongoing. The device MUST present 0 in both \field{queue_reset} and \fie=
ld{queue_enable}
+when queue reset has completed.
+(see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue=
 Reset}).
+
+The device MUST present a 0 in \field{queue_size} if the virtqueue
+corresponding to the current \field{queue_select} is unavailable.
+
+If VIRTIO_F_RING_PACKED has not been negotiated, the device MUST
+present either a value of 0 or a power of 2 in
+\field{queue_size}.
+
+\drivernormative{\paragraph}{Common configuration structure layout}{Virtio=
 Transport Options / Virtio Over PCI Bus / PCI Device Layout / Common confi=
guration structure layout}
+
+The driver MUST NOT write to \field{device_feature}, \field{num_queues}, \=
field{config_generation}, \field{queue_notify_off} or \field{queue_notify_d=
ata}.
+
+If VIRTIO_F_RING_PACKED has been negotiated,
+the driver MUST NOT write the value 0 to \field{queue_size}.
+If VIRTIO_F_RING_PACKED has not been negotiated,
+the driver MUST NOT write a value which is not a power of 2 to \field{queu=
e_size}.
+
+The driver MUST configure the other virtqueue fields before enabling the v=
irtqueue
+with \field{queue_enable}.
+
+After writing 0 to \field{device_status}, the driver MUST wait for a read =
of
+\field{device_status} to return 0 before reinitializing the device.
+
+The driver MUST NOT write a 0 to \field{queue_enable}.
+
+If VIRTIO_F_RING_RESET has been negotiated, after the driver writes 1 to
+\field{queue_reset} to reset the queue, the driver MUST NOT consider queue
+reset to be complete until it reads back 0 in \field{queue_reset}. The dri=
ver
+MAY re-enable the queue by writing 1 to \field{queue_enable} after ensurin=
g
+that other virtqueue fields have been set up correctly. The driver MAY set
+driver-writeable queue configuration values to different values than those=
 that
+were used before the queue reset.
+(see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue=
 Reset}).
+
+\subsubsection{Notification structure layout}\label{sec:Virtio Transport O=
ptions / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
+
+The notification location is found using the VIRTIO_PCI_CAP_NOTIFY_CFG
+capability.  This capability is immediately followed by an additional
+field, like so:
+
+\begin{lstlisting}
+struct virtio_pci_notify_cap {
+        struct virtio_pci_cap cap;
+        le32 notify_off_multiplier; /* Multiplier for queue_notify_off. */
+};
+\end{lstlisting}
+
+\field{notify_off_multiplier} is combined with the \field{queue_notify_off=
} to
+derive the Queue Notify address within a BAR for a virtqueue:
+
+\begin{lstlisting}
+        cap.offset + queue_notify_off * notify_off_multiplier
+\end{lstlisting}
+
+The \field{cap.offset} and \field{notify_off_multiplier} are taken from th=
e
+notification capability structure above, and the \field{queue_notify_off} =
is
+taken from the common configuration structure.
+
+\begin{note}
+For example, if \field{notifier_off_multiplier} is 0, the device uses
+the same Queue Notify address for all queues.
+\end{note}
+
+\devicenormative{\paragraph}{Notification capability}{Virtio Transport Opt=
ions / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
+The device MUST present at least one notification capability.
+
+For devices not offering VIRTIO_F_NOTIFICATION_DATA:
+
+The \field{cap.offset} MUST be 2-byte aligned.
+
+The device MUST either present \field{notify_off_multiplier} as an even po=
wer of 2,
+or present \field{notify_off_multiplier} as 0.
+
+The value \field{cap.length} presented by the device MUST be at least 2
+and MUST be large enough to support queue notification offsets
+for all supported queues in all possible configurations.
+
+For all queues, the value \field{cap.length} presented by the device MUST =
satisfy:
+\begin{lstlisting}
+cap.length >=3D queue_notify_off * notify_off_multiplier + 2
+\end{lstlisting}
+
+For devices offering VIRTIO_F_NOTIFICATION_DATA:
+
+The device MUST either present \field{notify_off_multiplier} as a
+number that is a power of 2 that is also a multiple 4,
+or present \field{notify_off_multiplier} as 0.
+
+The \field{cap.offset} MUST be 4-byte aligned.
+
+The value \field{cap.length} presented by the device MUST be at least 4
+and MUST be large enough to support queue notification offsets
+for all supported queues in all possible configurations.
+
+For all queues, the value \field{cap.length} presented by the device MUST =
satisfy:
+\begin{lstlisting}
+cap.length >=3D queue_notify_off * notify_off_multiplier + 4
+\end{lstlisting}
+
+\subsubsection{ISR status capability}\label{sec:Virtio Transport Options /=
 Virtio Over PCI Bus / PCI Device Layout / ISR status capability}
+
+The VIRTIO_PCI_CAP_ISR_CFG capability
+refers to at least a single byte, which contains the 8-bit ISR status fiel=
d
+to be used for INT\#x interrupt handling.
+
+The \field{offset} for the \field{ISR status} has no alignment requirement=
s.
+
+The ISR bits allow the driver to distinguish between device-specific confi=
guration
+change interrupts and normal virtqueue interrupts:
+
+\begin{tabular}{ |l||l|l|l| }
+\hline
+Bits       & 0                               & 1               &  2 to 31 =
\\
+\hline
+Purpose    & Queue Interrupt  & Device Configuration Interrupt & Reserved =
\\
+\hline
+\end{tabular}
+
+To avoid an extra access, simply reading this register resets it to 0 and
+causes the device to de-assert the interrupt.
+
+In this way, driver read of ISR status causes the device to de-assert
+an interrupt.
+
+See sections \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI=
-specific Initialization And Device Operation / Used Buffer Notifications} =
and \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific =
Initialization And Device Operation / Notification of Device Configuration =
Changes} for how this is used.
+
+\devicenormative{\paragraph}{ISR status capability}{Virtio Transport Optio=
ns / Virtio Over PCI Bus / PCI Device Layout / ISR status capability}
+
+The device MUST present at least one VIRTIO_PCI_CAP_ISR_CFG capability. =
=20
+
+The device MUST set the Device Configuration Interrupt bit
+in \field{ISR status} before sending a device configuration
+change notification to the driver.
+
+If MSI-X capability is disabled, the device MUST set the Queue
+Interrupt bit in \field{ISR status} before sending a virtqueue
+notification to the driver.
+
+If MSI-X capability is disabled, the device MUST set the Interrupt Status
+bit in the PCI Status register in the PCI Configuration Header of
+the device to the logical OR of all bits in \field{ISR status} of
+the device.  The device then asserts/deasserts INT\#x interrupts unless ma=
sked
+according to standard PCI rules \hyperref[intro:PCI]{[PCI]}.
+
+The device MUST reset \field{ISR status} to 0 on driver read.
+
+\drivernormative{\paragraph}{ISR status capability}{Virtio Transport Optio=
ns / Virtio Over PCI Bus / PCI Device Layout / ISR status capability}
+
+If MSI-X capability is enabled, the driver SHOULD NOT access
+\field{ISR status} upon detecting a Queue Interrupt.
+
+\subsubsection{Device-specific configuration}\label{sec:Virtio Transport O=
ptions / Virtio Over PCI Bus / PCI Device Layout / Device-specific configur=
ation}
+
+The device MUST present at least one VIRTIO_PCI_CAP_DEVICE_CFG capability =
for
+any device type which has a device-specific configuration.
+
+\devicenormative{\paragraph}{Device-specific configuration}{Virtio Transpo=
rt Options / Virtio Over PCI Bus / PCI Device Layout / Device-specific conf=
iguration}
+
+The \field{offset} for the device-specific configuration MUST be 4-byte al=
igned.
+
+\subsubsection{Shared memory capability}\label{sec:Virtio Transport Option=
s / Virtio Over PCI Bus / PCI Device Layout / Shared memory capability}
+
+Shared memory regions \ref{sec:Basic Facilities of a Virtio
+Device / Shared Memory Regions} are enumerated on the PCI transport
+as a sequence of VIRTIO_PCI_CAP_SHARED_MEMORY_CFG capabilities, one per re=
gion.
+
+The capability is defined by a struct virtio_pci_cap64 and
+utilises the \field{cap.id} to allow multiple shared memory
+regions per device.
+The identifier in \field{cap.id} does not denote a certain order of
+preference; it is only used to uniquely identify a region.
+
+\devicenormative{\paragraph}{Shared memory capability}{Virtio Transport Op=
tions / Virtio Over PCI Bus / PCI Device Layout / Shared memory capability}
+
+The region defined by the combination of the \field{cap.offset},
+\field{offset_hi}, and \field{cap.length}, \field{length_hi}
+fields MUST be contained within the BAR specified by
+\field{cap.bar}.
+
+The \field{cap.id} MUST be unique for any one device instance.
+
+\subsubsection{Vendor data capability}\label{sec:Virtio
+Transport Options / Virtio Over PCI Bus / PCI Device Layout /
+Vendor data capability}
+
+The optional Vendor data capability allows the device to present
+vendor-specific data to the driver, without
+conflicts, for debugging and/or reporting purposes,
+and without conflicting with standard functionality.
+
+This capability augments but does not replace the standard
+subsystem ID and subsystem vendor ID fields
+(offsets 0x2C and 0x2E in the PCI configuration space header)
+as specified by \hyperref[intro:PCI]{[PCI]}.
+
+Vendor data capability is enumerated on the PCI transport
+as a VIRTIO_PCI_CAP_VENDOR_CFG capability.
+
+The capability has the following structure:
+\begin{lstlisting}
+struct virtio_pci_vndr_data {
+        u8 cap_vndr;    /* Generic PCI field: PCI_CAP_ID_VNDR */
+        u8 cap_next;    /* Generic PCI field: next ptr. */
+        u8 cap_len;     /* Generic PCI field: capability length */
+        u8 cfg_type;    /* Identifies the structure. */
+        u16 vendor_id;  /* Identifies the vendor-specific format. */
+=09/* For Vendor Definition */
+=09/* Pads structure to a multiple of 4 bytes */
+=09/* Reads must not have side effects */
+};
+\end{lstlisting}
+
+Where \field{vendor_id} identifies the PCI-SIG assigned Vendor ID
+as specified by \hyperref[intro:PCI]{[PCI]}.
+
+Note that the capability size is required to be a multiple of 4.
+
+To make it safe for a generic driver to access the capability,
+reads from this capability MUST NOT have any side effects.
+
+\devicenormative{\paragraph}{Vendor data capability}{Virtio
+Transport Options / Virtio Over PCI Bus / PCI Device Layout /
+Vendor data capability}
+
+Devices CAN present \field{vendor_id} that does not match
+either the PCI Vendor ID or the PCI Subsystem Vendor ID.
+
+Devices CAN present multiple Vendor data capabilities with
+either different or identical \field{vendor_id} values.
+
+The value \field{vendor_id} MUST NOT equal 0x1AF4.
+
+The size of the Vendor data capability MUST be a multiple of 4 bytes.
+
+Reads of the Vendor data capability by the driver MUST NOT have any
+side effects.
+
+\drivernormative{\paragraph}{Vendor data capability}{Virtio
+Transport Options / Virtio Over PCI Bus / PCI Device Layout /
+Vendor data capability}
+
+The driver SHOULD NOT use the Vendor data capability except
+for debugging and reporting purposes.
+
+The driver MUST qualify the \field{vendor_id} before
+interpreting or writing into the Vendor data capability.
+
+\subsubsection{PCI configuration access capability}\label{sec:Virtio Trans=
port Options / Virtio Over PCI Bus / PCI Device Layout / PCI configuration =
access capability}
+
+The VIRTIO_PCI_CAP_PCI_CFG capability
+creates an alternative (and likely suboptimal) access method to the
+common configuration, notification, ISR and device-specific configuration =
regions.
+
+The capability is immediately followed by an additional field like so:
+
+\begin{lstlisting}
+struct virtio_pci_cfg_cap {
+        struct virtio_pci_cap cap;
+        u8 pci_cfg_data[4]; /* Data for BAR access. */
+};
+\end{lstlisting}
+
+The fields \field{cap.bar}, \field{cap.length}, \field{cap.offset} and
+\field{pci_cfg_data} are read-write (RW) for the driver.
+
+To access a device region, the driver writes into the capability
+structure (ie. within the PCI configuration space) as follows:
+
+\begin{itemize}
+\item The driver sets the BAR to access by writing to \field{cap.bar}.
+
+\item The driver sets the size of the access by writing 1, 2 or 4 to
+  \field{cap.length}.
+
+\item The driver sets the offset within the BAR by writing to
+  \field{cap.offset}.
+\end{itemize}
+
+At that point, \field{pci_cfg_data} will provide a window of size
+\field{cap.length} into the given \field{cap.bar} at offset \field{cap.off=
set}.
+
+\devicenormative{\paragraph}{PCI configuration access capability}{Virtio T=
ransport Options / Virtio Over PCI Bus / PCI Device Layout / PCI configurat=
ion access capability}
+
+The device MUST present at least one VIRTIO_PCI_CAP_PCI_CFG capability.
+
+Upon detecting driver write access
+to \field{pci_cfg_data}, the device MUST execute a write access
+at offset \field{cap.offset} at BAR selected by \field{cap.bar} using the =
first \field{cap.length}
+bytes from \field{pci_cfg_data}.
+
+Upon detecting driver read access
+to \field{pci_cfg_data}, the device MUST
+execute a read access of length cap.length at offset \field{cap.offset}
+at BAR selected by \field{cap.bar} and store the first \field{cap.length} =
bytes in
+\field{pci_cfg_data}.
+
+\drivernormative{\paragraph}{PCI configuration access capability}{Virtio T=
ransport Options / Virtio Over PCI Bus / PCI Device Layout / PCI configurat=
ion access capability}
+
+The driver MUST NOT write a \field{cap.offset} which is not
+a multiple of \field{cap.length} (ie. all accesses MUST be aligned).
+
+The driver MUST NOT read or write \field{pci_cfg_data}
+unless \field{cap.bar}, \field{cap.length} and \field{cap.offset}
+address \field{cap.length} bytes within a BAR range
+specified by some other Virtio Structure PCI Capability
+of type other than \field{VIRTIO_PCI_CAP_PCI_CFG}.
+
+\subsubsection{Legacy Interfaces: A Note on PCI Device Layout}\label{sec:V=
irtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy =
Interfaces: A Note on PCI Device Layout}
+
+Transitional devices MUST present part of configuration
+registers in a legacy configuration structure in BAR0 in the first I/O
+region of the PCI device, as documented below.
+When using the legacy interface, transitional drivers
+MUST use the legacy configuration structure in BAR0 in the first
+I/O region of the PCI device, as documented below.
+
+When using the legacy interface the driver MAY access
+the device-specific configuration region using any width accesses, and
+a transitional device MUST present driver with the same results as
+when accessed using the ``natural'' access method (i.e.
+32-bit accesses for 32-bit fields, etc).
+
+Note that this is possible because while the virtio common configuration s=
tructure is PCI
+(i.e. little) endian, when using the legacy interface the device-specific
+configuration region is encoded in the native endian of the guest (where s=
uch distinction is
+applicable).
+
+When used through the legacy interface, the virtio common configuration st=
ructure looks as follows:
+
+\begin{tabularx}{\textwidth}{ |X||X|X|X|X|X|X|X|X| }
+\hline
+ Bits & 32 & 32 & 32 & 16 & 16 & 16 & 8 & 8 \\
+\hline
+ Read / Write & R & R+W & R+W & R & R+W & R+W & R+W & R \\
+\hline
+ Purpose & Device Features bits 0:31 & Driver Features bits 0:31 &
+  Queue Address & \field{queue_size} & \field{queue_select} & Queue Notify=
 &
+  Device Status & ISR \newline Status \\
+\hline
+\end{tabularx}
+
+If MSI-X is enabled for the device, two additional fields
+immediately follow this header:
+
+\begin{tabular}{ |l||l|l| }
+\hline
+Bits       & 16             & 16     \\
+\hline
+Read/Write & R+W            & R+W    \\
+\hline
+Purpose (MSI-X) & \field{config_msix_vector}  & \field{queue_msix_vector} =
\\
+\hline
+\end{tabular}
+
+Note: When MSI-X capability is enabled, device-specific configuration star=
ts at
+byte offset 24 in virtio common configuration structure structure. When MS=
I-X capability is not
+enabled, device-specific configuration starts at byte offset 20 in virtio
+header.  ie. once you enable MSI-X on the device, the other fields move.
+If you turn it off again, they move back!
+
+Any device-specific configuration space immediately follows
+these general headers:
+
+\begin{tabular}{|l||l|l|}
+\hline
+Bits & Device Specific & \multirow{3}{*}{\ldots} \\
+\cline{1-2}
+Read / Write & Device Specific & \\
+\cline{1-2}
+Purpose & Device Specific & \\
+\hline
+\end{tabular}
+
+When accessing the device-specific configuration space
+using the legacy interface, transitional
+drivers MUST access the device-specific configuration space
+at an offset immediately following the general headers.
+
+When using the legacy interface, transitional
+devices MUST present the device-specific configuration space
+if any at an offset immediately following the general headers.
+
+Note that only Feature Bits 0 to 31 are accessible through the
+Legacy Interface. When used through the Legacy Interface,
+Transitional Devices MUST assume that Feature Bits 32 to 63
+are not acknowledged by Driver.
+
+As legacy devices had no \field{config_generation} field,
+see \ref{sec:Basic Facilities of a Virtio Device / Device
+Configuration Space / Legacy Interface: Device Configuration
+Space}~\nameref{sec:Basic Facilities of a Virtio Device / Device Configura=
tion Space / Legacy Interface: Device Configuration Space} for workarounds.
+
+\subsubsection{Non-transitional Device With Legacy Driver: A Note
+on PCI Device Layout}\label{sec:Virtio Transport Options / Virtio
+Over PCI Bus / PCI Device Layout / Non-transitional Device With
+Legacy Driver: A Note on PCI Device Layout}
+
+All known legacy drivers check either the PCI Revision or the
+Device and Vendor IDs, and thus won't attempt to drive a
+non-transitional device.
+
+A buggy legacy driver might mistakenly attempt to drive a
+non-transitional device. If support for such drivers is required
+(as opposed to fixing the bug), the following would be the
+recommended way to detect and handle them.
+\begin{note}
+Such buggy drivers are not currently known to be used in
+production.
+\end{note}
+
+\subparagraph{Device Requirements: Non-transitional Device With Legacy Dri=
ver}
+\label{drivernormative:Virtio Transport Options / Virtio Over PCI
+Bus / PCI-specific Initialization And Device Operation /
+Device Initialization / Non-transitional Device With Legacy
+Driver}
+\label{devicenormative:Virtio Transport Options / Virtio Over PCI
+Bus / PCI-specific Initialization And Device Operation /
+Device Initialization / Non-transitional Device With Legacy
+Driver}
+
+Non-transitional devices, on a platform where a legacy driver for
+a legacy device with the same ID (including PCI Revision, Device
+and Vendor IDs) is known to have previously existed,
+SHOULD take the following steps to cause the legacy driver to
+fail gracefully when it attempts to drive them:
+
+\begin{enumerate}
+\item Present an I/O BAR in BAR0, and
+\item Respond to a single-byte zero write to offset 18
+   (corresponding to Device Status register in the legacy layout)
+   of BAR0 by presenting zeroes on every BAR and ignoring writes.
+\end{enumerate}
+
+\subsection{PCI-specific Initialization And Device Operation}\label{sec:Vi=
rtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization =
And Device Operation}
+
+\subsubsection{Device Initialization}\label{sec:Virtio Transport Options /=
 Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / D=
evice Initialization}
+
+This documents PCI-specific steps executed during Device Initialization.
+
+\paragraph{Virtio Device Configuration Layout Detection}\label{sec:Virtio =
Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And D=
evice Operation / Device Initialization / Virtio Device Configuration Layou=
t Detection}
+
+As a prerequisite to device initialization, the driver scans the
+PCI capability list, detecting virtio configuration layout using Virtio
+Structure PCI capabilities as detailed in \ref{sec:Virtio Transport Option=
s / Virtio Over PCI Bus / Virtio Structure PCI Capabilities}
+
+\subparagraph{Legacy Interface: A Note on Device Layout Detection}\label{s=
ec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initializa=
tion And Device Operation / Device Initialization / Virtio Device Configura=
tion Layout Detection / Legacy Interface: A Note on Device Layout Detection=
}
+
+Legacy drivers skipped the Device Layout Detection step, assuming legacy
+device configuration space in BAR0 in I/O space unconditionally.
+
+Legacy devices did not have the Virtio PCI Capability in their
+capability list.
+
+Therefore:
+
+Transitional devices MUST expose the Legacy Interface in I/O
+space in BAR0.
+
+Transitional drivers MUST look for the Virtio PCI
+Capabilities on the capability list.
+If these are not present, driver MUST assume a legacy device,
+and use it through the legacy interface.
+
+Non-transitional drivers MUST look for the Virtio PCI
+Capabilities on the capability list.
+If these are not present, driver MUST assume a legacy device,
+and fail gracefully.
+
+\paragraph{MSI-X Vector Configuration}\label{sec:Virtio Transport Options =
/ Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / =
Device Initialization / MSI-X Vector Configuration}
+
+When MSI-X capability is present and enabled in the device
+(through standard PCI configuration space) \field{config_msix_vector} and =
\field{queue_msix_vector} are used to map configuration change and queue
+interrupts to MSI-X vectors. In this case, the ISR Status is unused.
+
+Writing a valid MSI-X Table entry number, 0 to 0x7FF, to
+\field{config_msix_vector}/\field{queue_msix_vector} maps interrupts trigg=
ered
+by the configuration change/selected queue events respectively to
+the corresponding MSI-X vector. To disable interrupts for an
+event type, the driver unmaps this event by writing a special NO_VECTOR
+value:
+
+\begin{lstlisting}
+/* Vector value used to disable MSI for queue */
+#define VIRTIO_MSI_NO_VECTOR            0xffff
+\end{lstlisting}
+
+Note that mapping an event to vector might require device to
+allocate internal device resources, and thus could fail.=20
+
+\devicenormative{\subparagraph}{MSI-X Vector Configuration}{Virtio Transpo=
rt Options / Virtio Over PCI Bus / PCI-specific Initialization And Device O=
peration / Device Initialization / MSI-X Vector Configuration}
+
+A device that has an MSI-X capability SHOULD support at least 2
+and at most 0x800 MSI-X vectors.
+Device MUST report the number of vectors supported in
+\field{Table Size} in the MSI-X Capability as specified in
+\hyperref[intro:PCI]{[PCI]}.
+The device SHOULD restrict the reported MSI-X Table Size field
+to a value that might benefit system performance.
+\begin{note}
+For example, a device which does not expect to send
+interrupts at a high rate might only specify 2 MSI-X vectors.
+\end{note}
+Device MUST support mapping any event type to any valid
+vector 0 to MSI-X \field{Table Size}.
+Device MUST support unmapping any event type.
+
+The device MUST return vector mapped to a given event,
+(NO_VECTOR if unmapped) on read of \field{config_msix_vector}/\field{queue=
_msix_vector}.
+The device MUST have all queue and configuration change
+events are unmapped upon reset.
+
+Devices SHOULD NOT cause mapping an event to vector to fail
+unless it is impossible for the device to satisfy the mapping
+request.  Devices MUST report mapping
+failures by returning the NO_VECTOR value when the relevant
+\field{config_msix_vector}/\field{queue_msix_vector} field is read.=20
+
+\drivernormative{\subparagraph}{MSI-X Vector Configuration}{Virtio Transpo=
rt Options / Virtio Over PCI Bus / PCI-specific Initialization And Device O=
peration / Device Initialization / MSI-X Vector Configuration}
+
+Driver MUST support device with any MSI-X Table Size 0 to 0x7FF.
+Driver MAY fall back on using INT\#x interrupts for a device
+which only supports one MSI-X vector (MSI-X Table Size =3D 0).
+
+Driver MAY intepret the Table Size as a hint from the device
+for the suggested number of MSI-X vectors to use.
+
+Driver MUST NOT attempt to map an event to a vector
+outside the MSI-X Table supported by the device,
+as reported by \field{Table Size} in the MSI-X Capability.
+
+After mapping an event to vector, the
+driver MUST verify success by reading the Vector field value: on
+success, the previously written value is returned, and on
+failure, NO_VECTOR is returned. If a mapping failure is detected,
+the driver MAY retry mapping with fewer vectors, disable MSI-X
+or report device failure.
+
+\paragraph{Virtqueue Configuration}\label{sec:Virtio Transport Options / V=
irtio Over PCI Bus / PCI-specific Initialization And Device Operation / Dev=
ice Initialization / Virtqueue Configuration}
+
+As a device can have zero or more virtqueues for bulk data
+transport\footnote{For example, the simplest network device has two virtqu=
eues.}, the driver
+needs to configure them as part of the device-specific
+configuration.
+
+The driver typically does this as follows, for each virtqueue a device has=
:
+
+\begin{enumerate}
+\item Write the virtqueue index (first queue is 0) to \field{queue_select}=
.
+
+\item Read the virtqueue size from \field{queue_size}. This controls how b=
ig the virtqueue is
+  (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}~\nameref=
{sec:Basic Facilities of a Virtio Device / Virtqueues}). If this field is 0=
, the virtqueue does not exist.
+
+\item Optionally, select a smaller virtqueue size and write it to \field{q=
ueue_size}.
+
+\item Allocate and zero Descriptor Table, Available and Used rings for the
+   virtqueue in contiguous physical memory.
+
+\item Optionally, if MSI-X capability is present and enabled on the
+  device, select a vector to use to request interrupts triggered
+  by virtqueue events. Write the MSI-X Table entry number
+  corresponding to this vector into \field{queue_msix_vector}. Read
+  \field{queue_msix_vector}: on success, previously written value is
+  returned; on failure, NO_VECTOR value is returned.
+\end{enumerate}
+
+\subparagraph{Legacy Interface: A Note on Virtqueue Configuration}\label{s=
ec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initializa=
tion And Device Operation / Device Initialization / Virtqueue Configuration=
 / Legacy Interface: A Note on Virtqueue Configuration}
+When using the legacy interface, the queue layout follows \ref{sec:Basic F=
acilities of a Virtio Device / Virtqueues / Legacy Interfaces: A Note on Vi=
rtqueue Layout}~\nameref{sec:Basic Facilities of a Virtio Device / Virtqueu=
es / Legacy Interfaces: A Note on Virtqueue Layout} with an alignment of 40=
96.
+Driver writes the physical address, divided
+by 4096 to the Queue Address field\footnote{The 4096 is based on the x86 p=
age size, but it's also large
+enough to ensure that the separate parts of the virtqueue are on
+separate cache lines.
+}.  There was no mechanism to negotiate the queue size.
+
+\subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport =
Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Oper=
ation / Available Buffer Notifications}
+
+When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
+the driver sends an available buffer notification to the device by writing
+the 16-bit virtqueue index
+of this virtqueue to the Queue Notify address.
+
+When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
+the driver sends an available buffer notification to the device by writing
+the following 32-bit value to the Queue Notify address:
+\lstinputlisting{notifications-le.c}
+
+See \ref{sec:Basic Facilities of a Virtio Device / Driver notifications}~\=
nameref{sec:Basic Facilities of a Virtio Device / Driver notifications}
+for the definition of the components.
+
+See \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device L=
ayout / Notification capability}
+for how to calculate the Queue Notify address.
+
+\drivernormative{\paragraph}{Available Buffer Notifications}{Virtio Transp=
ort Options / Virtio Over PCI Bus / PCI-specific Initialization And Device =
Operation / Available Buffer Notifications}
+If VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated:
+\begin{itemize}
+\item If VIRTIO_F_NOTIFICATION_DATA has not been negotiated, the driver MU=
ST use the
+\field{queue_notify_data} value instead of the virtqueue index.
+\item If VIRTIO_F_NOTIFICATION_DATA has been negotiated, the driver MUST s=
et the
+\field{vqn} field to the \field{queue_notify_data} value.
+\end{itemize}
+
+\subsubsection{Used Buffer Notifications}\label{sec:Virtio Transport Optio=
ns / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation=
 / Used Buffer Notifications}
+
+If a used buffer notification is necessary for a virtqueue, the device wou=
ld typically act as follows:
+
+\begin{itemize}
+  \item If MSI-X capability is disabled:
+    \begin{enumerate}
+    \item Set the lower bit of the ISR Status field for the device.
+
+    \item Send the appropriate PCI interrupt for the device.
+    \end{enumerate}
+
+  \item If MSI-X capability is enabled:
+    \begin{enumerate}
+    \item If \field{queue_msix_vector} is not NO_VECTOR,
+      request the appropriate MSI-X interrupt message for the
+      device, \field{queue_msix_vector} sets the MSI-X Table entry
+      number.
+    \end{enumerate}
+\end{itemize}
+
+\devicenormative{\paragraph}{Used Buffer Notifications}{Virtio Transport O=
ptions / Virtio Over PCI Bus / PCI-specific Initialization And Device Opera=
tion / Used Buffer Notifications}
+
+If MSI-X capability is enabled and \field{queue_msix_vector} is
+NO_VECTOR for a virtqueue, the device MUST NOT deliver an interrupt
+for that virtqueue.
+
+\subsubsection{Notification of Device Configuration Changes}\label{sec:Vir=
tio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization A=
nd Device Operation / Notification of Device Configuration Changes}
+
+Some virtio PCI devices can change the device configuration
+state, as reflected in the device-specific configuration region of the dev=
ice. In this case:
+
+\begin{itemize}
+  \item If MSI-X capability is disabled:
+    \begin{enumerate}
+    \item Set the second lower bit of the ISR Status field for the device.
+
+    \item Send the appropriate PCI interrupt for the device.
+    \end{enumerate}
+
+  \item If MSI-X capability is enabled:
+    \begin{enumerate}
+    \item If \field{config_msix_vector} is not NO_VECTOR,
+      request the appropriate MSI-X interrupt message for the
+      device, \field{config_msix_vector} sets the MSI-X Table entry
+      number.
+    \end{enumerate}
+\end{itemize}
+
+A single interrupt MAY indicate both that one or more virtqueue has
+been used and that the configuration space has changed.
+
+\devicenormative{\paragraph}{Notification of Device Configuration Changes}=
{Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initializati=
on And Device Operation / Notification of Device Configuration Changes}
+
+If MSI-X capability is enabled and \field{config_msix_vector} is
+NO_VECTOR, the device MUST NOT deliver an interrupt
+for device configuration space changes.
+
+\drivernormative{\paragraph}{Notification of Device Configuration Changes}=
{Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initializati=
on And Device Operation / Notification of Device Configuration Changes}
+
+A driver MUST handle the case where the same interrupt is used to indicate
+both device configuration space change and one or more virtqueues being us=
ed.
+
+\subsubsection{Driver Handling Interrupts}\label{sec:Virtio Transport Opti=
ons / Virtio Over PCI Bus / PCI-specific Initialization And Device Operatio=
n / Driver Handling Interrupts}
+The driver interrupt handler would typically:
+
+\begin{itemize}
+  \item If MSI-X capability is disabled:
+    \begin{itemize}
+      \item Read the ISR Status field, which will reset it to zero.
+      \item If the lower bit is set:
+        look through all virtqueues for the
+        device, to see if any progress has been made by the device
+        which requires servicing.
+      \item If the second lower bit is set:
+        re-examine the configuration space to see what changed.
+    \end{itemize}
+  \item If MSI-X capability is enabled:
+    \begin{itemize}
+      \item
+        Look through all virtqueues mapped to that MSI-X vector for the
+        device, to see if any progress has been made by the device
+        which requires servicing.
+      \item
+        If the MSI-X vector is equal to \field{config_msix_vector},
+        re-examine the configuration space to see what changed.
+    \end{itemize}
+\end{itemize}
+
--=20
2.26.2

