Return-Path: <prvs=306b5f2bd=dmitry.fomichev@wdc.com>
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: [PATCH v9] virtio-blk: add zoned block device specification
Date: Wed,  9 Nov 2022 21:51:38 -0500
Message-Id: <20221110025138.3273022-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>, Stefan Hajnoczi <stefanha@gmail.com>, Hannes Reinecke <hare@suse.de>, Cornelia Huck <cohuck@redhat.com>, Matias Bjorling <matias.bjorling@wdc.com>, Niklas Cassel <niklas.cassel@wdc.com>, Hans Holmberg <Hans.Holmberg@wdc.com>, Klaus Jensen <its@irrelevant.dk>, Sam Li <faithilikerun@gmail.com>, Dmitry Fomichev <dmitry.fomichev@wdc.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Introduce support for Zoned Block Devices to virtio.

Zoned Block Devices (ZBDs) aim to achieve a better capacity, latency
and/or cost characteristics compared to commonly available block
devices by getting the entire LBA space of the device divided to block
regions that are much larger than the LBA size. These regions are
called zones and they can only be written sequentially. More details
about ZBDs can be found at

https://zonedstorage.io/docs/introduction/zoned-storage .

In its current form, the virtio protocol for block devices (virtio-blk)
is not aware of ZBDs but it allows the driver to successfully scan a
host-managed drive provided by the virtio block device. As the result,
the host-managed drive is recognized by virtio driver as a regular,
non-zoned drive that will operate erroneously under the most common
write workloads. Host-aware ZBDs are currently usable, but their
performance may not be optimal because the driver can only see them as
non-zoned block devices.

To fix this, the virtio-blk protocol needs to be extended to add the
capabilities to convey the zone characteristics of ZBDs at the device
side to the driver and to provide support for ZBD-specific commands -
Report Zones, four zone operations (Open, Close, Finish and Reset) and
(optionally) Zone Append. The proposed standard extension aims to
define this new functionality.

This patch extends the virtio-blk section of virtio specification with
the minimum set of requirements that are necessary to support ZBDs.
The resulting device model is a subset of the models defined in ZAC/ZBC
and ZNS standards documents. The included functionality mirrors
the existing Linux kernel block layer ZBD support and should be
sufficient to handle the host-managed and host-aware HDDs that are on
the market today as well as ZNS SSDs that are entering the market at
the time of submission of this patch.

I would like to thank the following people for their useful feedback
and suggestions while working on the initial iterations of this patch.

Damien Le Moal <damien.lemoal@opensource.wdc.com>
Matias Bjørling <Matias.Bjorling@wdc.com>
Niklas Cassel <Niklas.Cassel@wdc.com>
Hans Holmberg <Hans.Holmberg@wdc.com>

Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---

v8 -> v9:

 - add Reviewed-by tag by Damien

 - remove the unnecessary Fixes flag

 - resend with the version number in the title

This version is planned to be offered for a vote at the Oasis TC.

v7 -> v8:

Avoid normative language in a non-normative section (Stefan)

v6 -> v7:

Address review comments from Damien and Stefan:

 - change the request layout to make the status always be the last
   byte of the request. The request layout for all ZBD requests except
   Zone Append is now the same as for non-zoned devices. For Zone
   Append, the request layout adds one more field right before the
   status byte and that field is designed to carry over the zone append
   sector from the device to the driver

 - describe the operation with F_ZONED feature bit set and the zoned
   model None in terms of drive-managed devices

 - add the requirement that the maximum Zone Append data size may not
   be smaller than the write granularity configured for the device

 - fix typos and make minor editorial changes

The Linux kernel driver patchset that is developed to conform to this
specification version can be found at

https://www.spinics.net/lists/linux-block/msg91286.html

v5 -> v6:

Address review comments from Cornelia Huck:

 - add a clause to disallow VIRTIO_BLK_F_ZONED feature to be offered by
   legacy devices

 - clarify VIRTIO_BLK_F_DISCARD negotiation procedure for zoned devices

 - simplify definitions of constant values that are specific to zoned
   devices

 - editorial changes

v4 -> v5:

Add Fixes tag pointing to the corresponding GitHub issue.

Improve the patch changelog.

v3 -> v4:

Address additional feedback from Stefan:

 - align the append sector field to 8 bytes instead of 4

 - define "zone sector address" in the non-normative section and use
   this term in the text in a consistent way. Make sure it is clear
   that the value is in bytes.

 - move portions of VIRTIO_BLK_T_ZONE_REPORT description to the
   non-normative section

 - clarify the wording about reading of unwritten data

 - editorial changes

v2 -> v3:

A few changes made as the result of off-list discussions with Stefan,
Damien and Hannes:

 - drop virtblk_zoned_req for zoned devices and define a union for
   virtio request in header that is specific to ZONE APPEND request

 - drop support for ALL bit in all zone operations except for RESET
   ZONE. For this zone management operation, define a new request type,
   VIRTIO_BLK_T_ZONE_RESET_ALL. This way, the zone management out
   request header is no longer necessary

 - editorial changes

v1 -> v2:

Address Stefan's review comments:

 - move normative clauses to normative sections

 - remove the "partial" bit in zone report

 - change layout of virtio_blk_zoned_req. The "all" flag becomes a bit
   in "zone" bit field struct. This leaves 31 bits for potential future
   extensions. Move the status byte to be the last one in the struct

 - set ZBD-specific error codes in the status field, not in
   "zoned_result" field. The former "zoned_result" member now becomes
   "append_sector"

 - make a few editorial changes
---
 content.tex | 694 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 692 insertions(+), 2 deletions(-)

diff --git a/content.tex b/content.tex
index e863709..8330894 100644
--- a/content.tex
+++ b/content.tex
@@ -4655,6 +4655,13 @@ \subsection{Feature bits}\label{sec:Device Types / Block Device / Feature bits}
      maximum erase sectors count in \field{max_secure_erase_sectors} and
      maximum erase segment number in \field{max_secure_erase_seg}.
 
+\item[VIRTIO_BLK_F_ZONED(17)] Device is a Zoned Block Device, that is, a device
+	that follows the zoned storage device behavior that is also supported by
+	industry standards such as the T10 Zoned Block Command standard (ZBC r05) or
+	the NVMe(TM) NVM Express Zoned Namespace Command Set Specification 1.1b
+	(ZNS). For brevity, these standard documents are referred as "ZBD standards"
+	from this point on in the text.
+
 \end{description}
 
 \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Block Device / Feature bits / Legacy Interface: Feature bits}
@@ -4687,6 +4694,75 @@ \subsection{Device configuration layout}\label{sec:Device Types / Block Device /
 \field{max_secure_erase_sectors} \field{secure_erase_sector_alignment} are expressed
 in 512-byte units if the VIRTIO_BLK_F_SECURE_ERASE feature bit is negotiated.
 
+If the VIRTIO_BLK_F_ZONED feature is negotiated, then in
+\field{virtio_blk_zoned_characteristics},
+\begin{itemize}
+\item \field{zone_sectors} value is expressed in 512-byte sectors.
+\item \field{max_append_sectors} value is expressed in 512-byte sectors.
+\item \field{write_granularity} value is expressed in bytes.
+\end{itemize}
+
+The \field{model} field in \field{zoned} may have the following values:
+
+\begin{lstlisting}
+#define VIRTIO_BLK_Z_NONE      0
+#define VIRTIO_BLK_Z_HM        1
+#define VIRTIO_BLK_Z_HA        2
+\end{lstlisting}
+
+Depending on their design, zoned block devices may follow several possible
+models of operation. The three models that are standardized for ZBDs are
+drive-managed, host-managed and host-aware.
+
+While being zoned internally, drive-managed ZBDs behave exactly like regular,
+non-zoned block devices. For the purposes of virtio standardization,
+drive-managed ZBDs can always be treated as non-zoned devices. These devices
+have the VIRTIO_BLK_Z_NONE model value set in the \field{model} field in
+\field{zoned}.
+
+Devices that offer the VIRTIO_BLK_F_ZONED feature while reporting the
+VIRTIO_BLK_Z_NONE zoned model are drive-managed zoned block devices. In this
+case, the driver treats the device as a regular non-zoned block device.
+
+Host-managed zoned block devices have their LBA range divided into Sequential
+Write Required (SWR) zones that require some additional handling by the host
+for correct operation. All write requests to SWR zones are required be
+sequential and zones containing some written data need to be reset before that
+data can be rewritten. Host-managed devices support a set of ZBD-specific I/O
+requests that can be used by the host to manage device zones. Host-managed
+devices report VIRTIO_BLK_Z_HM in the \field{model} field in \field{zoned}.
+
+Host-aware zoned block devices have their LBA range divided to Sequential
+Write Preferred (SWP) zones that support random write access, similar to
+regular non-zoned devices. However, the device I/O performance might not be
+optimal if SWP zones are used in a random I/O pattern. SWP zones also support
+the same set of ZBD-specific I/O requests as host-managed devices that allow
+host-aware devices to be managed by any host that supports zoned block devices
+to achieve its optimum performance. Host-aware devices report VIRTIO_BLK_Z_HA
+in the \field{model} field in \field{zoned}.
+
+Both SWR zones and SWP zones are sometimes referred as sequential zones.
+
+During device operation, sequential zones can be in one of the following states:
+empty, implicitly-open, explicitly-open, closed and full. The state machine that
+governs the transitions between these states is described later in this document.
+
+SWR and SWP zones consume volatile device resources while being in certain
+states and the device may set limits on the number of zones that can be in these
+states simultaneously.
+
+Zoned block devices use two internal counters to account for the device
+resources in use, the number of currently open zones and the number of currently
+active zones.
+
+Any zone state transition from a state that doesn't consume a zone resource to a
+state that consumes the same resource increments the internal device counter for
+that resource. Any zone transition out of a state that consumes a zone resource
+to a state that doesn't consume the same resource decrements the counter. Any
+request that causes the device to exceed the reported zone resource limits is
+terminated by the device with a "zone resources exceeded" error as defined for
+specific commands later.
+
 \begin{lstlisting}
 struct virtio_blk_config {
         le64 capacity;
@@ -4721,6 +4797,15 @@ \subsection{Device configuration layout}\label{sec:Device Types / Block Device /
         le32 max_secure_erase_sectors;
         le32 max_secure_erase_seg;
         le32 secure_erase_sector_alignment;
+        struct virtio_blk_zoned_characteristics {
+                le32 zone_sectors;
+                le32 max_open_zones;
+                le32 max_active_zones;
+                le32 max_append_sectors;
+                le32 write_granularity;
+                u8 model;
+                u8 unused2[3];
+        } zoned;
 };
 \end{lstlisting}
 
@@ -4784,6 +4869,10 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
     \field{secure_erase_sector_alignment} can be used by OS when splitting a
     request based on alignment.
 
+\item If the VIRTIO_BLK_F_ZONED feature is negotiated, the fields in
+    \field{zoned} can be read by the driver to determine the zone
+    characteristics of the device. All \field{zoned} fields are read-only.
+
 \end{enumerate}
 
 \drivernormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
@@ -4799,6 +4888,30 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
 The driver MUST NOT read \field{writeback} before setting
 the FEATURES_OK \field{device status} bit.
 
+Drivers MUST NOT negotiate the VIRTIO_BLK_F_ZONED feature if they are incapable
+of supporting devices with the VIRTIO_BLK_Z_HM, VIRTIO_BLK_Z_HA or
+VIRTIO_BLK_Z_NONE zoned model.
+
+If the VIRTIO_BLK_F_ZONED feature is offered by the device with the
+VIRTIO_BLK_Z_HM zone model, then the VIRTIO_BLK_F_DISCARD feature MUST NOT be
+offered by the driver.
+
+If the VIRTIO_BLK_F_ZONED feature and VIRTIO_BLK_F_DISCARD feature are both
+offered by the device with the VIRTIO_BLK_Z_HA or VIRTIO_BLK_Z_NONE zone model,
+then the driver MAY negotiate these two bits independently.
+
+If the VIRTIO_BLK_F_ZONED feature is negotiated, then
+\begin{itemize}
+\item if the driver that can not support host-managed zoned devices
+    reads VIRTIO_BLK_Z_HM from the \field{model} field of \field{zoned}, the
+    driver MUST NOT set FEATURES_OK flag and instead set the FAILED bit.
+
+\item if the driver that can not support zoned devices reads VIRTIO_BLK_Z_HA
+    from the \field{model} field of \field{zoned}, the driver
+    MAY handle the device as a non-zoned device. In this case, the
+    driver SHOULD ignore all other fields in \field{zoned}.
+\end{itemize}
+
 \devicenormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
 
 Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it
@@ -4810,6 +4923,80 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
 The device MUST initialize padding bytes \field{unused0} and
 \field{unused1} to 0.
 
+If the device that is being initialized is a not a zoned device, the device
+SHOULD NOT offer the VIRTIO_BLK_F_ZONED feature.
+
+The VIRTIO_BLK_F_ZONED feature cannot be properly negotiated without
+FEATURES_OK bit. Legacy devices MUST NOT offer VIRTIO_BLK_F_ZONED feature bit.
+
+If the VIRTIO_BLK_F_ZONED feature is not accepted by the driver,
+\begin{itemize}
+\item the device with the VIRTIO_BLK_Z_HA or VIRTIO_BLK_Z_NONE zone model SHOULD
+    proceed with the initialization while setting all zoned characteristics
+    fields to zero.
+
+\item the device with the VIRTIO_BLK_Z_HM zone model MUST fail to set the
+    FEATURES_OK device status bit when the driver writes the Device Status
+    field.
+\end{itemize}
+
+If the VIRTIO_BLK_F_ZONED feature is negotiated, then the \field{model} field in
+\field{zoned} struct in the configuration space MUST be set by the device
+\begin{itemize}
+\item to the value of VIRTIO_BLK_Z_NONE if it operates as a drive-managed
+    zoned block device or a non-zoned block device.
+
+\item to the value of VIRTIO_BLK_Z_HM if it operates as a host-managed zoned
+    block device.
+
+\item to the value of VIRTIO_BLK_Z_HA if it operates as a host-aware zoned
+    block device.
+\end{itemize}
+
+If the VIRTIO_BLK_F_ZONED feature is negotiated and the device \field{model}
+field in \field{zoned} struct is VIRTIO_BLK_Z_HM or VIRTIO_BLK_Z_HA,
+
+\begin{itemize}
+\item the \field{zone_sectors} field of \field{zoned} MUST be set by the device
+    to the size of a single zone on the device. All zones of the device have the
+    same size indicated by \field{zone_sectors} except for the last zone that
+    MAY be smaller than all other zones. The driver can calculate the number of
+    zones on the device as
+    \begin{lstlisting}
+        nr_zones = (capacity + zone_sectors - 1) / zone_sectors;
+    \end{lstlisting}
+    and the size of the last zone as
+    \begin{lstlisting}
+        zs_last = capacity - (nr_zones - 1) * zone_sectors;
+    \end{lstlisting}
+
+\item The \field{max_open_zones} field of the \field{zoned} structure MUST be
+    set by the device to the maximum number of zones that can be open on the
+    device (zones in the implicit open or explicit open state). A value
+    of zero indicates that the device does not have any limit on the number of
+    open zones.
+
+\item The \field{max_active_zones} field of the \field{zoned} structure MUST
+    be set by the device to the maximum number zones that can be active on the
+    device (zones in the implicit open, explicit open or closed state). A value
+    of zero indicates that the device does not have any limit on the number of
+    active zones.
+
+\item the \field{max_append_sectors} field of \field{zoned} MUST be set by
+    the device to the maximum data size of a VIRTIO_BLK_T_ZONE_APPEND request
+    that can be successfully issued to the device. The value of this field MUST
+    NOT exceed the \field{seg_max} * \field{size_max} value. A device MAY set
+    the \field{max_append_sectors} to zero if it doesn't support
+    VIRTIO_BLK_T_ZONE_APPEND requests.
+
+\item the \field{write_granularity} field of \field{zoned} MUST be set by the
+    device to the offset and size alignment constraint for VIRTIO_BLK_T_OUT
+    and VIRTIO_BLK_T_ZONE_APPEND requests issued to a sequential zone of the
+    device.
+
+\item the device MUST initialize padding bytes \field{unused2} to 0.
+\end{itemize}
+
 \subsubsection{Legacy Interface: Device Initialization}\label{sec:Device Types / Block Device / Device Initialization / Legacy Interface: Device Initialization}
 
 Because legacy devices do not have FEATURES_OK, transitional devices
@@ -4836,7 +5023,8 @@ \subsubsection{Legacy Interface: Device Initialization}\label{sec:Device Types /
 \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Operation}
 
 The driver queues requests to the virtqueues, and they are used by
-the device (not necessarily in order). Each request is of form:
+the device (not necessarily in order). Each request except
+VIRTIO_BLK_T_ZONE_APPEND is of form:
 
 \begin{lstlisting}
 struct virtio_blk_req {
@@ -4868,7 +5056,7 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
 
 The \field{sector} number indicates the offset (multiplied by 512) where
 the read or write is to occur. This field is unused and set to 0 for
-commands other than read or write.
+commands other than read, write and some zone operations.
 
 VIRTIO_BLK_T_IN requests populate \field{data} with the contents of sectors
 read from the block device (in multiples of 512 bytes).  VIRTIO_BLK_T_OUT
@@ -4951,6 +5139,325 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
 command produces VIRTIO_BLK_S_IOERR.  A segment may have completed
 successfully, failed, or not been processed by the device.
 
+The following requirements only apply if the VIRTIO_BLK_F_ZONED feature is
+negotiated.
+
+In addition to the request types defined for non-zoned devices, the type of the
+request can be a zone report (VIRTIO_BLK_T_ZONE_REPORT), an explicit zone open
+(VIRTIO_BLK_T_ZONE_OPEN), a zone close (VIRTIO_BLK_T_ZONE_CLOSE), a zone finish
+(VIRTIO_BLK_T_ZONE_FINISH), a zone_append (VIRTIO_BLK_T_ZONE_APPEND), a zone
+reset (VIRTIO_BLK_T_ZONE_RESET) or a zone reset all
+(VIRTIO_BLK_T_ZONE_RESET_ALL).
+
+\begin{lstlisting}
+#define VIRTIO_BLK_T_ZONE_APPEND    15
+#define VIRTIO_BLK_T_ZONE_REPORT    16
+#define VIRTIO_BLK_T_ZONE_OPEN      18
+#define VIRTIO_BLK_T_ZONE_CLOSE     20
+#define VIRTIO_BLK_T_ZONE_FINISH    22
+#define VIRTIO_BLK_T_ZONE_RESET     24
+#define VIRTIO_BLK_T_ZONE_RESET_ALL 26
+\end{lstlisting}
+
+Requests of type VIRTIO_BLK_T_OUT, VIRTIO_BLK_T_ZONE_OPEN,
+VIRTIO_BLK_T_ZONE_CLOSE, VIRTIO_BLK_T_ZONE_FINISH, VIRTIO_BLK_T_ZONE_APPEND,
+VIRTIO_BLK_T_ZONE_RESET or VIRTIO_BLK_T_ZONE_RESET_ALL may be completed by the
+device with VIRTIO_BLK_S_OK, VIRTIO_BLK_S_IOERR or VIRTIO_BLK_S_UNSUPP
+\field{status}, or, additionally, with  VIRTIO_BLK_S_ZONE_INVALID_CMD,
+VIRTIO_BLK_S_ZONE_UNALIGNED_WP, VIRTIO_BLK_S_ZONE_OPEN_RESOURCE or
+VIRTIO_BLK_S_ZONE_ACTIVE_RESOURCE ZBD-specific status codes.
+
+Besides the request status, VIRTIO_BLK_T_ZONE_APPEND requests return the
+starting sector of the appended data back to the driver. For this reason,
+the VIRTIO_BLK_T_ZONE_APPEND request has the layout that is extended to have
+the \field{append_sector} field to carry this value:
+
+\begin{lstlisting}
+struct virtio_blk_req_za {
+        le32 type;
+        le32 reserved;
+        le64 sector;
+        u8 data[];
+        le64 append_sector;
+        u8 status;
+};
+\end{lstlisting}
+
+\begin{lstlisting}
+#define VIRTIO_BLK_S_ZONE_INVALID_CMD     3
+#define VIRTIO_BLK_S_ZONE_UNALIGNED_WP    4
+#define VIRTIO_BLK_S_ZONE_OPEN_RESOURCE   5
+#define VIRTIO_BLK_S_ZONE_ACTIVE_RESOURCE 6
+\end{lstlisting}
+
+Requests of the type VIRTIO_BLK_T_ZONE_REPORT are reads and requests of the type
+VIRTIO_BLK_T_ZONE_APPEND are writes. VIRTIO_BLK_T_ZONE_OPEN,
+VIRTIO_BLK_T_ZONE_CLOSE, VIRTIO_BLK_T_ZONE_FINISH, VIRTIO_BLK_T_ZONE_RESET and
+VIRTIO_BLK_T_ZONE_RESET_ALL are non-data requests.
+
+Zone sector address is a 64-bit address of the first 512-byte sector of the
+zone.
+
+VIRTIO_BLK_T_ZONE_OPEN, VIRTIO_BLK_T_ZONE_CLOSE, VIRTIO_BLK_T_ZONE_FINISH and
+VIRTIO_BLK_T_ZONE_RESET requests make the zone operation to act on a particular
+zone specified by the zone sector address in the \field{sector} of the request.
+
+VIRTIO_BLK_T_ZONE_RESET_ALL request acts upon all applicable zones of the
+device. The \field{sector} value is not used for this request.
+
+In ZBD standards, the VIRTIO_BLK_T_ZONE_REPORT request belongs to "Zone
+Management Receive" command category and VIRTIO_BLK_T_ZONE_OPEN,
+VIRTIO_BLK_T_ZONE_CLOSE, VIRTIO_BLK_T_ZONE_FINISH and
+VIRTIO_BLK_T_ZONE_RESET/VIRTIO_BLK_T_ZONE_RESET_ALL requests are categorized as
+"Zone Management Send" commands. VIRTIO_BLK_T_ZONE_APPEND is categorized
+separately from zone management commands and is the only request that uses
+the \field{append_secctor} field \field{virtio_blk_req_za} to return
+to the driver the sector at which the data has been appended to the zone.
+
+VIRTIO_BLK_T_ZONE_REPORT is a read request that returns the information about
+the current state of zones on the device starting from the zone containing the
+\field{sector} of the request. The report consists of a header followed by zero
+or more zone descriptors.
+
+A zone report reply has the following structure:
+
+\begin{lstlisting}
+struct virtio_blk_zone_report {
+        le64   nr_zones;
+        u8     reserved[56];
+        struct virtio_blk_zone_descriptor zones[];
+};
+\end{lstlisting}
+
+The device sets the \field{nr_zones} field in the report header to the number of
+fully transferred zone descriptors in the data buffer.
+
+A zone descriptor has the following structure:
+
+\begin{lstlisting}
+struct virtio_blk_zone_descriptor {
+        le64   z_cap;
+        le64   z_start;
+        le64   z_wp;
+        u8     z_type;
+        u8     z_state;
+        u8     reserved[38];
+};
+\end{lstlisting}
+
+The zone descriptor field \field{z_type} \field{virtio_blk_zone_descriptor}
+indicates the type of the zone.
+
+The following zone types are available:
+
+\begin{lstlisting}
+#define VIRTIO_BLK_ZT_CONV     1
+#define VIRTIO_BLK_ZT_SWR      2
+#define VIRTIO_BLK_ZT_SWP      3
+\end{lstlisting}
+
+Read and write operations into zones with the VIRTIO_BLK_ZT_CONV (Conventional)
+type have the same behavior as read and write operations on a regular block
+device. Any block in a conventional zone can be read or written at any time and
+in any order.
+
+Zones with VIRTIO_BLK_ZT_SWR can be read randomly, but must be written
+sequentially at a certain point in the zone called the Write Pointer (WP). With
+every write, the Write Pointer is incremented by the number of sectors written.
+
+Zones with VIRTIO_BLK_ZT_SWP can be read randomly and should be written
+sequentially, similarly to SWR zones. However, SWP zones can accept random write
+operations, that is, VIRTIO_BLK_T_OUT requests with a start sector different
+from the zone write pointer position.
+
+The field \field{z_state} of \field{virtio_blk_zone_descriptor} indicates the
+state of the device zone.
+
+The following zone states are available:
+
+\begin{lstlisting}
+#define VIRTIO_BLK_ZS_NOT_WP   0
+#define VIRTIO_BLK_ZS_EMPTY    1
+#define VIRTIO_BLK_ZS_IOPEN    2
+#define VIRTIO_BLK_ZS_EOPEN    3
+#define VIRTIO_BLK_ZS_CLOSED   4
+#define VIRTIO_BLK_ZS_RDONLY   13
+#define VIRTIO_BLK_ZS_FULL     14
+#define VIRTIO_BLK_ZS_OFFLINE  15
+\end{lstlisting}
+
+Zones of the type VIRTIO_BLK_ZT_CONV are always reported by the device to be in
+the VIRTIO_BLK_ZS_NOT_WP state. Zones of the types VIRTIO_BLK_ZT_SWR and
+VIRTIO_BLK_ZT_SWP can not transition to the VIRTIO_BLK_ZS_NOT_WP state.
+
+Zones in VIRTIO_BLK_ZS_EMPTY (Empty), VIRTIO_BLK_ZS_IOPEN (Implicitly Open),
+VIRTIO_BLK_ZS_EOPEN (Explicitly Open) and VIRTIO_BLK_ZS_CLOSED (Closed) state
+are writable, but zones in VIRTIO_BLK_ZS_RDONLY (Read-Only), VIRTIO_BLK_ZS_FULL
+(Full) and VIRTIO_BLK_ZS_OFFLINE (Offline) state are not. The write pointer
+value (\field{z_wp}) is not valid for Read-Only, Full and Offline zones.
+
+The zone descriptor field \field{z_cap} contains the maximum number of 512-byte
+sectors that are available to be written with user data when the zone is in the
+Empty state. This value shall be less than or equal to the \field{zone_sectors}
+value in \field{virtio_blk_zoned_characteristics} structure in the device
+configuration space.
+
+The zone descriptor field \field{z_start} contains the zone sector address.
+
+The zone descriptor field \field{z_wp} contains the sector address where the
+next write operation for this zone should be issued. This value is undefined
+for conventional zones and for zones in VIRTIO_BLK_ZS_RDONLY,
+VIRTIO_BLK_ZS_FULL and VIRTIO_BLK_ZS_OFFLINE state.
+
+Depending on their state, zones consume resources as follows:
+\begin{itemize}
+\item a zone in VIRTIO_BLK_ZS_IOPEN and VIRTIO_BLK_ZS_EOPEN state consumes one
+    open zone resource and, additionally,
+
+\item a zone in VIRTIO_BLK_ZS_IOPEN, VIRTIO_BLK_ZS_EOPEN and
+    VIRTIO_BLK_ZS_CLOSED state consumes one active resource.
+\end{itemize}
+
+Attempts for zone transitions that violate zone resource limits must fail with
+VIRTIO_BLK_S_ZONE_OPEN_RESOURCE or VIRTIO_BLK_S_ZONE_ACTIVE_RESOURCE
+\field{status}.
+
+Zones in the VIRTIO_BLK_ZS_EMPTY (Empty) state have the write pointer value
+equal to the sector address of the zone. In this state, the entire capacity of
+the zone is available for writing. A zone can transition from this state to
+\begin{itemize}
+\item VIRTIO_BLK_ZS_IOPEN when a successful VIRTIO_BLK_T_OUT request or
+    VIRTIO_BLK_T_ZONE_APPEND with a non-zero data size is received for the zone.
+
+\item VIRTIO_BLK_ZS_EOPEN when a successful VIRTIO_BLK_T_ZONE_OPEN request is
+    received for the zone
+\end{itemize}
+
+When a VIRTIO_BLK_T_ZONE_RESET request is issued to an Empty zone, the request
+is completed successfully and the zone stays in the VIRTIO_BLK_ZS_EMPTY state.
+
+Zones in the VIRTIO_BLK_ZS_IOPEN (Implicitly Open) state transition from
+this state to
+\begin{itemize}
+\item VIRTIO_BLK_ZS_EMPTY when a successful VIRTIO_BLK_T_ZONE_RESET request is
+    received for the zone,
+
+\item VIRTIO_BLK_ZS_EMPTY when a successful VIRTIO_BLK_T_ZONE_RESET_ALL request
+    is received by the device,
+
+\item VIRTIO_BLK_ZS_EOPEN when a successful VIRTIO_BLK_T_ZONE_OPEN request is
+    received for the zone,
+
+\item VIRTIO_BLK_ZS_CLOSED when a successful VIRTIO_BLK_T_ZONE_CLOSE request is
+    received for the zone,
+
+\item VIRTIO_BLK_ZS_CLOSED implicitly by the device when another zone is
+    entering the VIRTIO_BLK_ZS_IOPEN or VIRTIO_BLK_ZS_EOPEN state and the number
+    of currently open zones is at \field{max_open_zones} limit,
+
+\item VIRTIO_BLK_ZS_FULL when a successful VIRTIO_BLK_T_ZONE_FINISH request is
+    received for the zone.
+
+\item VIRTIO_BLK_ZS_FULL when a successful VIRTIO_BLK_T_OUT or
+    VIRTIO_BLK_T_ZONE_APPEND request that causes the zone to reach its writable
+    capacity is received for the zone.
+\end{itemize}
+
+Zones in the VIRTIO_BLK_ZS_EOPEN (Explicitly Open) state transition from
+this state to
+\begin{itemize}
+\item VIRTIO_BLK_ZS_EMPTY when a successful VIRTIO_BLK_T_ZONE_RESET request is
+    received for the zone,
+
+\item VIRTIO_BLK_ZS_EMPTY when a successful VIRTIO_BLK_T_ZONE_RESET_ALL request
+    is received by the device,
+
+\item VIRTIO_BLK_ZS_EMPTY when a successful VIRTIO_BLK_T_ZONE_CLOSE request is
+    received for the zone and the write pointer of the zone has the value equal
+    to the start sector of the zone,
+
+\item VIRTIO_BLK_ZS_CLOSED when a successful VIRTIO_BLK_T_ZONE_CLOSE request is
+    received for the zone and the zone write pointer is larger then the start
+    sector of the zone,
+
+\item VIRTIO_BLK_ZS_FULL when a successful VIRTIO_BLK_T_ZONE_FINISH request is
+    received for the zone,
+
+\item VIRTIO_BLK_ZS_FULL when a successful VIRTIO_BLK_T_OUT or
+    VIRTIO_BLK_T_ZONE_APPEND request that causes the zone to reach its writable
+    capacity is received for the zone.
+\end{itemize}
+
+When a VIRTIO_BLK_T_ZONE_EOPEN request is issued to an Explicitly Open zone, the
+request is completed successfully and the zone stays in the VIRTIO_BLK_ZS_EOPEN
+state.
+
+Zones in the VIRTIO_BLK_ZS_CLOSED (Closed) state transition from this state
+to
+\begin{itemize}
+\item VIRTIO_BLK_ZS_EMPTY when a successful VIRTIO_BLK_T_ZONE_RESET request is
+    received for the zone,
+
+\item VIRTIO_BLK_ZS_EMPTY when a successful VIRTIO_BLK_T_ZONE_RESET_ALL request
+    is received by the device,
+
+\item VIRTIO_BLK_ZS_IOPEN when a successful VIRTIO_BLK_T_OUT request or
+    VIRTIO_BLK_T_ZONE_APPEND with a non-zero data size is received for the zone.
+
+\item VIRTIO_BLK_ZS_EOPEN when a successful VIRTIO_BLK_T_ZONE_OPEN request is
+    received for the zone,
+\end{itemize}
+
+When a VIRTIO_BLK_T_ZONE_CLOSE request is issued to a Closed zone, the request
+is completed successfully and the zone stays in the VIRTIO_BLK_ZS_CLOSED state.
+
+Zones in the VIRTIO_BLK_ZS_FULL (Full) state transition from this state to
+VIRTIO_BLK_ZS_EMPTY when a successful VIRTIO_BLK_T_ZONE_RESET request is
+received for the zone or a successful VIRTIO_BLK_T_ZONE_RESET_ALL request is
+received by the device.
+
+When a VIRTIO_BLK_T_ZONE_FINISH request is issued to a Full zone, the request
+is completed successfully and the zone stays in the VIRTIO_BLK_ZS_FULL state.
+
+The device may automatically transition zones to VIRTIO_BLK_ZS_RDONLY
+(Read-Only) or VIRTIO_BLK_ZS_OFFLINE (Offline) state from any other state. The
+device may also automatically transition zones in the Read-Only state to the
+Offline state. Zones in the Offline state may not transition to any other state.
+Such automatic transitions usually indicate hardware failures. The previously
+written data may only be read from zones in the Read-Only state. Zones in the
+Offline state can not be read or written.
+
+VIRTIO_BLK_S_ZONE_UNALIGNED_WP is set by the device when the request received
+from the driver attempts to perform a write to an SWR zone and at least one of
+the following conditions is met:
+
+\begin{itemize}
+\item the starting sector of the request is not equal to the current value of
+    the zone write pointer.
+
+\item the ending sector of the request data multiplied by 512 is not a multiple
+    of the value reported by the device in the field \field{write_granularity}
+    in the device configuration space.
+\end{itemize}
+
+VIRTIO_BLK_S_ZONE_OPEN_RESOURCE is set by the device when a zone operation or
+write request received from the driver can not be handled without exceeding the
+\field{max_open_zones} limit value reported by the device in the configuration
+space.
+
+VIRTIO_BLK_S_ZONE_ACTIVE_RESOURCE is set by the device when a zone operation or
+write request received from the driver can not be handled without exceeding the
+\field{max_active_zones} limit value reported by the device in the configuration
+space.
+
+A zone transition request that leads to both the \field{max_open_zones} and the
+\field{max_active_zones} limits to be exceeded is terminated by the device with
+VIRTIO_BLK_S_ZONE_ACTIVE_RESOURCE \field{status} value.
+
+The device reports all other error conditions related to zoned block model
+operation by setting the VIRTIO_BLK_S_ZONE_INVALID_CMD value in
+\field{status} of \field{virtio_blk_req} structure.
+
 \drivernormative{\subsubsection}{Device Operation}{Device Types / Block Device / Device Operation}
 
 The driver SHOULD check if the content of the \field{capacity} field has
@@ -5000,6 +5507,50 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
 successfully, failed, or were processed by the device at all if the request
 failed with VIRTIO_BLK_S_IOERR.
 
+The following requirements only apply if the VIRTIO_BLK_F_ZONED feature is
+negotiated.
+
+A zone sector address provided by the driver MUST be a multiple of 512 bytes.
+
+When forming a VIRTIO_BLK_T_ZONE_REPORT request, the driver MUST set a sector
+within the sector range of the starting zone to report to \field{sector} field.
+It MAY be a sector that is different from the zone sector address.
+
+In VIRTIO_BLK_T_ZONE_OPEN, VIRTIO_BLK_T_ZONE_CLOSE, VIRTIO_BLK_T_ZONE_FINISH and
+VIRTIO_BLK_T_ZONE_RESET requests, the driver MUST set \field{sector} field to
+point at the first sector in the target zone.
+
+In VIRTIO_BLK_T_ZONE_RESET_ALL request, the driver MUST set the field
+\field{sector} to zero value.
+
+The \field{sector} field of the VIRTIO_BLK_T_ZONE_APPEND request MUST specify
+the zone sector address of the zone to which data is to be appended at the
+position of the write pointer. The size of the data that is appended MUST be a
+multiple of \field{write_granularity} bytes and MUST NOT exceed the
+\field{max_append_sectors} value provided by the device in
+\field{virtio_blk_zoned_characteristics} configuration space structure.
+
+Upon a successful completion of a VIRTIO_BLK_T_ZONE_APPEND request, the driver
+MAY read the starting sector location of the written data from the request
+field \field{append_sector}.
+
+All VIRTIO_BLK_T_OUT requests issued by the driver to sequential zones and
+VIRTIO_BLK_T_ZONE_APPEND requests MUST have:
+
+\begin{enumerate}
+\item the data size that is a multiple of the number of bytes reported
+    by the device in the field \field{write_granularity} in the
+    \field{virtio_blk_zoned_characteristics} configuration space structure.
+
+\item the value of the field \field{sector} that is a multiple of the number of
+    bytes reported by the device in the field \field{write_granularity} in the
+    \field{virtio_blk_zoned_characteristics} configuration space structure.
+
+\item the data size that will not exceed the writable zone capacity when its
+    value is added to the current value of the write pointer of the zone.
+
+\end{enumerate}
+
 \devicenormative{\subsubsection}{Device Operation}{Device Types / Block Device / Device Operation}
 
 The device MAY change the content of the \field{capacity} field during
@@ -5095,6 +5646,145 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
   simplfy passthrough implementations from eMMC devices.
 \end{note}
 
+If the VIRTIO_BLK_F_ZONED feature is not negotiated, the device MUST reject
+VIRTIO_BLK_T_ZONE_REPORT, VIRTIO_BLK_T_ZONE_OPEN, VIRTIO_BLK_T_ZONE_CLOSE,
+VIRTIO_BLK_T_ZONE_FINISH, VIRTIO_BLK_T_ZONE_APPEND, VIRTIO_BLK_T_ZONE_RESET and
+VIRTIO_BLK_T_ZONE_RESET_ALL requests with VIRTIO_BLK_S_UNSUPP status.
+
+The following device requirements only apply if the VIRTIO_BLK_F_ZONED feature
+is negotiated.
+
+If a request of type VIRTIO_BLK_T_ZONE_OPEN, VIRTIO_BLK_T_ZONE_CLOSE,
+VIRTIO_BLK_T_ZONE_FINISH or VIRTIO_BLK_T_ZONE_RESET is issued for a Conventional
+zone (type VIRTIO_BLK_ZT_CONV), the device MUST complete the request with
+VIRTIO_BLK_S_ZONE_INVALID_CMD \field{status}.
+
+If the zone specified by the VIRTIO_BLK_T_ZONE_APPEND request is not a SWR zone,
+then the request SHALL be completed with VIRTIO_BLK_S_ZONE_INVALID_CMD
+\field{status}.
+
+The device handles a VIRTIO_BLK_T_ZONE_OPEN request by attempting to change the
+state of the zone with the \field{sector} address to VIRTIO_BLK_ZS_EOPEN. If the
+transition to this state can not be performed, the request MUST be completed
+with VIRTIO_BLK_S_ZONE_INVALID_CMD \field{status}. If, while processing this
+request, the available zone resources are insufficient, then the zone state does
+not change and the request MUST be completed with
+VIRTIO_BLK_S_ZONE_OPEN_RESOURCE or VIRTIO_BLK_S_ZONE_ACTIVE_RESOURCE value in
+the field \field{status}.
+
+The device handles a VIRTIO_BLK_T_ZONE_CLOSE request by attempting to change the
+state of the zone with the \field{sector} address to VIRTIO_BLK_ZS_CLOSED. If
+the transition to this state can not be performed, the request MUST be completed
+with VIRTIO_BLK_S_ZONE_INVALID_CMD value in the field \field{status}.
+
+The device handles a VIRTIO_BLK_T_ZONE_FINISH request by attempting to change
+the state of the zone with the \field{sector} address to VIRTIO_BLK_ZS_FULL. If
+the transition to this state can not be performed, the zone state does not
+change and the request MUST be completed with VIRTIO_BLK_S_ZONE_INVALID_CMD
+value in the field \field{status}.
+
+The device handles a VIRTIO_BLK_T_ZONE_RESET request by attempting to change the
+state of the zone with the \field{sector} address to VIRTIO_BLK_ZS_EMPTY state.
+If the transition to this state can not be performed, the zone state does not
+change and the request MUST be completed with VIRTIO_BLK_S_ZONE_INVALID_CMD
+value in the field \field{status}.
+
+The device handles a VIRTIO_BLK_T_ZONE_RESET_ALL request by transitioning all
+sequential device zones in VIRTIO_BLK_ZS_IOPEN, VIRTIO_BLK_ZS_EOPEN,
+VIRTIO_BLK_ZS_CLOSED and VIRTIO_BLK_ZS_FULL state to VIRTIO_BLK_ZS_EMPTY state.
+
+Upon receiving a VIRTIO_BLK_T_ZONE_APPEND request or a VIRTIO_BLK_T_OUT
+request issued to a SWR zone in VIRTIO_BLK_ZS_EMPTY or VIRTIO_BLK_ZS_CLOSED
+state, the device attempts to perform the transition of the zone to
+VIRTIO_BLK_ZS_IOPEN state before writing data. This transition may fail due to
+insufficient open and/or active zone resources available on the device. In this
+case, the request MUST be completed with VIRTIO_BLK_S_ZONE_OPEN_RESOURCE or
+VIRTIO_BLK_S_ZONE_ACTIVE_RESOURCE value in the \field{status}.
+
+If the \field{sector} field in the VIRTIO_BLK_T_ZONE_APPEND request does not
+specify the lowest sector for a zone, then the request SHALL be completed with
+VIRTIO_BLK_S_ZONE_INVALID_CMD value in \field{status}.
+
+A VIRTIO_BLK_T_ZONE_APPEND request or a VIRTIO_BLK_T_OUT request that has the
+data range that exceeds the remaining writable capacity for the zone, then the
+request SHALL be completed with VIRTIO_BLK_S_ZONE_INVALID_CMD value in
+\field{status}.
+
+If a request of the type VIRTIO_BLK_T_ZONE_APPEND is completed with
+VIRTIO_BLK_S_OK status, the field \field{append_sector} in
+\field{virtio_blk_req_za} MUST be set by the device to contain the first sector
+of the data written to the zone.
+
+If a request of the type VIRTIO_BLK_T_ZONE_APPEND is completed with a status
+other than VIRTIO_BLK_S_OK, the value of \field{append_sector} field in
+\field{virtio_blk_req_za} is undefined.
+
+A VIRTIO_BLK_T_ZONE_APPEND request that has the data size that exceeds
+\field{max_append_sectors} configuration space value, then,
+\begin{itemize}
+\item if \field{max_append_sectors} configuration space value is reported as
+    zero by the device, the request SHALL be completed with VIRTIO_BLK_S_UNSUPP
+    \field{status}.
+
+\item if \field{max_append_sectors} configuration space value is reported as
+    a non-zero value by the device, the request SHALL be completed with
+    VIRTIO_BLK_S_ZONE_INVALID_CMD \field{status}.
+\end{itemize}
+
+If a VIRTIO_BLK_T_ZONE_APPEND request, a VIRTIO_BLK_T_IN request or a
+VIRTIO_BLK_T_OUT request issued to a SWR zone has the range that has sectors in
+more than one zone, then the request SHALL be completed with
+VIRTIO_BLK_S_ZONE_INVALID_CMD value in the field \field{status}.
+
+A VIRTIO_BLK_T_OUT request that has the \field{sector} value that is not aligned
+with the write pointer for the zone, then the request SHALL be completed with
+VIRTIO_BLK_S_ZONE_UNALIGNED_WP value in the field \field{status}.
+
+In order to avoid resource-related errors while opening zones implicitly, the
+device MAY automatically transition zones in VIRTIO_BLK_ZS_IOPEN state to
+VIRTIO_BLK_ZS_CLOSED state.
+
+All VIRTIO_BLK_T_OUT requests or VIRTIO_BLK_T_ZONE_APPEND requests issued
+to a zone in the VIRTIO_BLK_ZS_RDONLY state SHALL be completed with
+VIRTIO_BLK_S_ZONE_INVALID_CMD \field{status}.
+
+All requests issued to a zone in the VIRTIO_BLK_ZS_OFFLINE state SHALL be
+completed with VIRTIO_BLK_S_ZONE_INVALID_CMD value in the field \field{status}.
+
+The device MUST consider the sectors that are read between the write pointer
+position of a zone and the end of the last sector of the zone as unwritten data.
+The sectors between the write pointer position and the end of the last sector
+within the zone capacity during VIRTIO_BLK_T_ZONE_FINISH request processing are
+also considered unwritten data.
+
+When unwritten data is present in the sector range of a read request, the device
+MUST process this data in one of the following ways -
+
+\begin{enumerate}
+\item Fill the unwritten data with a device-specific byte pattern. The
+configuration, control and reporting of this byte pattern is beyond the scope
+of this standard. This is the preferred approach.
+
+\item Fail the request. Depending on the driver implementation, this may prevent
+the device from becoming operational.
+\end{enumerate}
+
+If both the VIRTIO_BLK_F_ZONED and VIRTIO_BLK_F_SECURE_ERASE features are
+negotiated, then
+
+\begin{enumerate}
+\item the field \field{secure_erase_sector_alignment} in the configuration space
+of the device MUST be a multiple of \field{zone_sectors} value reported in the
+device configuration space.
+
+\item the data size in VIRTIO_BLK_T_SECURE_ERASE requests MUST be a multiple of
+\field{zone_sectors} value in the device configuration space.
+\end{enumerate}
+
+The device MUST handle a VIRTIO_BLK_T_SECURE_ERASE request in the same way it
+handles VIRTIO_BLK_T_ZONE_RESET request for the zone range specified in the
+VIRTIO_BLK_T_SECURE_ERASE request.
+
 \subsubsection{Legacy Interface: Device Operation}\label{sec:Device Types / Block Device / Device Operation / Legacy Interface: Device Operation}
 When using the legacy interface, transitional devices and drivers
 MUST format the fields in struct virtio_blk_req
-- 
2.34.1

