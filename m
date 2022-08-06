Return-Path: <virtio-dev-return-9708-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F11219861EB
	for <virtio-dev@lists.oasis-open.org>; Mon,  8 Aug 2022 13:53:00 +0000 (UTC)
Date: Sat, 6 Aug 2022 17:20:20 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <Yu7bFA630o4KxUtt@fedora>
References: <20220804224057.169856-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gDOXJcgjU4Mi3fkm"
Content-Disposition: inline
In-Reply-To: <20220804224057.169856-1-dmitry.fomichev@wdc.com>
Subject: Re: [virtio-dev] [RFC PATCH v3] virtio-blk: add zoned block device
 specification
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, Damien Le Moal <damien.lemoal@opensource.wdc.com>, Stefan Hajnoczi <stefanha@gmail.com>, Hannes Reinecke <hare@suse.de>, Matias Bjorling <matias.bjorling@wdc.com>, Niklas Cassel <niklas.cassel@wdc.com>, Hans Holmberg <Hans.Holmberg@wdc.com>, Klaus Jensen <its@irrelevant.dk>, Sam Li <faithilikerun@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--gDOXJcgjU4Mi3fkm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 4 Aug 2022 at 18:41, Dmitry Fomichev <dmitry.fomichev@wdc.com> wrot=
e:

Hi Dmitry,
I think RFC can be removed from the Subject line for the next revision
of this patch.

For instructions on how to bring this to a Technical Committee vote, see:
https://github.com/oasis-tcs/virtio-spec#use-of-github-issues

>
> Introduce support for Zoned Block Devices to virtio.
>
> Zoned Block Devices (ZBDs) aim to achieve a better capacity, latency
> and/or cost characteristics compared to commonly available block
> devices by getting the entire LBA space of the device divided to block
> regions that are much larger than the LBA size. These regions are
> called zones and they can only be written sequentially. More details
> about ZBDs can be found at
>
> https://zonedstorage.io/docs/introduction/zoned-storage .
>
> In its current form, the virtio protocol for block devices (virtio-blk)
> is not aware of ZBDs but it allows the guest to successfully scan a
> host-managed drive provided by the host. As the result, the
> host-managed drive appears at the guest as a regular drive that will
> operate erroneously under the most common write workloads.
>
> To fix this, the virtio-blk protocol needs to be extended to add the
> capabilities to convey the zone characteristics of host ZBDs to the
> guest and to provide the support for ZBD-specific commands - Report
> Zones, four zone operations and (optionally) Zone Append. The proposed
> standard extension aims to provide this functionality.
>
> This patch extends the virtio-blk section of virtio specification with
> the minimum set of requirements that are necessary to support ZBDs.
> The resulting device model is a subset of the models defined in ZAC/ZBC
> and ZNS standards documents. The included functionality mirrors
> the existing Linux kernel block layer ZBD support and should be
> sufficient to handle the host-managed and host-aware HDDs that are on
> the market today as well as ZNS SSDs that are entering the market at
> the moment of this patch submission.
>
> I have developed a proof of concept patch series that adds ZBD support
> to virtio-blk Linux kernel driver by implementing the protocol
> extensions defined in the spec patch. I would like to receive feedback
> on this specification patch before posting that series to the block
> LKML.
>
> I would like to thank the following people for their useful feedback
> and suggestions while working on the initial iterations of this patch.
>
> Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Matias Bj=F8rling <Matias.Bjorling@wdc.com>
> Niklas Cassel <Niklas.Cassel@wdc.com>
> Hans Holmberg <Hans.Holmberg@wdc.com>
>
> v1 -> v2:
>
> Address Stefan's review comments:
>
>  - move normative clauses to normative sections
>
>  - remove the "partial" bit in zone report
>
>  - change layout of virtio_blk_zoned_req. The "all" flag becomes a bit
>    in "zone" bit field struct. This leaves 31 bits for potential future
>    extensions. Move the status byte to be the last one in the struct
>
>  - set ZBD-specific error codes in the status field, not in
>    "zoned_result" field. The former "zoned_result" member now becomes
>    "append_sector"
>
>  - make a few editorial changes
>
> v2 -> v3:
>
> A few changes made as the result of off-list discussions with Stefan,
> Damien and Hannes:
>
>  - drop virtblk_zoned_req for zoned devices and define a union for
>    virtio request in header that is specific to ZONE APPEND request
>
>  - drop support for ALL bit in all zone operations except for RESET
>    ZONE. For this zone management operation, define a new request type,
>    VIRTIO_BLK_T_ZONE_RESET_ALL. This way, the zone management out
>    request header is no longer necessary
>
>  - editorial changes
>
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> ---
>  content.tex | 660 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 658 insertions(+), 2 deletions(-)
>
> diff --git a/content.tex b/content.tex
> index 7508dd1..cfb8727 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -4557,6 +4557,13 @@ \subsection{Feature bits}\label{sec:Device Types /=
 Block Device / Feature bits}
>       maximum erase sectors count in \field{max_secure_erase_sectors} and
>       maximum erase segment number in \field{max_secure_erase_seg}.
>
> +\item[VIRTIO_BLK_F_ZONED(17)] Device is a Zoned Block Device, that is, a=
 device
> +       that follows the zoned storage device behavior that is also suppo=
rted by
> +       industry standards such as the T10 Zoned Block Command standard (=
ZBC r05) or
> +       the NVMe(TM) NVM Express Zoned Namespace Command Set Specificatio=
n 1.1b
> +       (ZNS). For brevity, these standard documents are referred as "ZBD=
 standards"
> +       from this point on in the text.
> +
>  \end{description}
>
>  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / =
Block Device / Feature bits / Legacy Interface: Feature bits}
> @@ -4589,6 +4596,75 @@ \subsection{Device configuration layout}\label{sec=
:Device Types / Block Device /
>  \field{max_secure_erase_sectors} \field{secure_erase_sector_alignment} a=
re expressed
>  in 512-byte units if the VIRTIO_BLK_F_SECURE_ERASE feature bit is negoti=
ated.
>
> +If the VIRTIO_BLK_F_ZONED feature is negotiated, then in
> +\field{virtio_blk_zoned_characteristics},
> +\begin{itemize}
> +\item \field{zone_sectors} value is expressed in 512-byte sectors.
> +\item \field{max_append_sectors} value is expressed in 512-byte sectors.
> +\item \field{write_granularity} value is expressed in bytes.
> +\end{itemize}
> +
> +The \field{model} field in \field{zoned} may have the following values:
> +VIRTIO_BLK_Z_NONE(0), VIRTIO_BLK_Z_HM(1) and VIRTIO_BLK_Z_HA(2).
> +
> +\begin{lstlisting}
> +#define VIRTIO_BLK_Z_NONE      0
> +#define VIRTIO_BLK_Z_HM        1
> +#define VIRTIO_BLK_Z_HA        2
> +\end{lstlisting}
> +
> +Depending on their design, zoned block devices may follow several possib=
le
> +models of operation. The three models that are standardized for ZBDs are
> +drive-managed, host-managed and host-aware.
> +
> +While being zoned internally, drive-managed ZBDs behave exactly like reg=
ular,
> +non-zoned block devices. For the purposes of virtio standardization,
> +drive-managed ZBDs can always be treated as non-zoned devices. These dev=
ices
> +have the VIRTIO_BLK_Z_NONE model value set in the \field{model} field in
> +\field{zoned}.
> +
> +Devices that offer VIRTIO_BLK_F_ZONED feature while reporting VIRTIO_BLK=
_Z_NONE
> +zoned model commonly do so for testing and development purposes.
> +
> +Host-managed zoned block devices have their LBA range divided to Sequent=
ial
> +Write Required (SWR) zones that require some additional handling from th=
e host
> +for sustainable operation. All write requests to SWR zones must be seque=
ntial
> +and the zones with some data need to be reset before that data can be re=
written.
> +Host-managed devices support a set of ZBD-specific I/O requests that can=
 be used
> +by the host to manage device zones. Host-managed devices report VIRTIO_B=
LK_Z_HM
> +in the \field{model} field in \field{zoned}.
> +
> +Host-aware zoned block devices have their LBA range divided to Sequential
> +Write Preferred (SWP) zones that support the random write access, simila=
r to
> +regular non-zoned devices. However, the device I/O performance might not=
 be
> +optimal if SWP zones are used in a random I/O pattern. SWP zones also su=
pport
> +the same set of ZBD-specific I/O requests as host-managed devices that a=
llow
> +host-aware devices to be managed by any host that supports zoned block d=
evices
> +to achieve its optimum performance. Host-aware devices report VIRTIO_BLK=
_Z_HA
> +in the \field{model} field in \field{zoned}.
> +
> +Both SWR zones and SWP zones are sometimes referred as sequential zones.
> +
> +During device operation, sequential zones can be in one of the following=
 states:
> +empty, implicitly-open, explicitly-open, closed and full. The state mach=
ine that
> +governs the transitions between these states is described later in this =
document.
> +
> +SWR and SWP zones consume volatile device resources while being in certa=
in
> +states and the device may set limits on the number of zones that can be =
in these
> +states simultaneously.
> +
> +Zoned block devices use two internal counters to account for the device
> +resources in use, the number of currently open zones and the number of c=
urrently
> +active zones.
> +
> +Any zone state transition from a state that doesn't consume a zone resou=
rce to a
> +state that consumes the same resource increments the internal device cou=
nter for
> +that resource. Any zone transition out of a state that consumes a zone r=
esource
> +to a state that doesn't consume the same resource decrements the counter=
=2E Any
> +request that causes the device to exceed the reported zone resource limi=
ts is
> +terminated by the device with a "zone resources exceeded" error as defin=
ed for
> +specific commands later.
> +
>  \begin{lstlisting}
>  struct virtio_blk_config {
>          le64 capacity;
> @@ -4623,6 +4699,15 @@ \subsection{Device configuration layout}\label{sec=
:Device Types / Block Device /
>          le32 max_secure_erase_sectors;
>          le32 max_secure_erase_seg;
>          le32 secure_erase_sector_alignment;
> +        struct virtio_blk_zoned_characteristics {
> +                le32 zone_sectors;
> +                le32 max_open_zones;
> +                le32 max_active_zones;
> +                le32 max_append_sectors;
> +                le32 write_granularity;
> +                u8 model;
> +                u8 unused2[3];
> +        } zoned;
>  };
>  \end{lstlisting}
>
> @@ -4686,6 +4771,10 @@ \subsection{Device Initialization}\label{sec:Devic=
e Types / Block Device / Devic
>      \field{secure_erase_sector_alignment} can be used by OS when splitti=
ng a
>      request based on alignment.
>
> +\item If the VIRTIO_BLK_F_ZONED feature is negotiated, the fields in
> +    \field{zoned} can be read by the driver to determine the zone
> +    characteristics of the device. All \field{zoned} fields are read-onl=
y.
> +
>  \end{enumerate}
>
>  \drivernormative{\subsubsection}{Device Initialization}{Device Types / B=
lock Device / Device Initialization}
> @@ -4701,6 +4790,30 @@ \subsection{Device Initialization}\label{sec:Devic=
e Types / Block Device / Devic
>  The driver MUST NOT read \field{writeback} before setting
>  the FEATURES_OK \field{device status} bit.
>
> +Drivers SHOULD NOT negotiate VIRTIO_BLK_F_ZONED feature if they are inca=
pable
> +of supporting devices with the VIRTIO_BLK_Z_HM or VIRTIO_BLK_Z_HA zoned =
model.
> +
> +If the VIRTIO_BLK_F_ZONED feature is offered by the device with the
> +VIRTIO_BLK_Z_HM zone model, then
> +\begin{itemize}
> +\item the VIRTIO_BLK_F_DISCARD feature must not be offered by the driver.
> +
> +\item if the driver sets both VIRTIO_BLK_F_DISCARD and VIRTIO_BLK_F_ZONED
> +    feature bits, the device must fail by not setting FEATURES_OK bit.
> +\end{itemize}
> +
> +If the VIRTIO_BLK_F_ZONED feature is negotiated, then
> +\begin{itemize}
> +\item if the driver that can not support host-managed zoned devices
> +    reads VIRTIO_BLK_Z_HM from the \field{model} field of \field{zoned},=
 the
> +    driver MUST NOT set FEATURES_OK flag and instead set the FAILED bit.
> +
> +\item if the driver that can not support support zoned devices reads
> +    VIRTIO_BLK_Z_HA from the \field{model} field of \field{zoned}, the d=
river
> +    MAY handle the device as a non-zoned device. In this case, the
> +    driver SHOULD ignore all other fields in \field{zoned}.
> +\end{itemize}
> +
>  \devicenormative{\subsubsection}{Device Initialization}{Device Types / B=
lock Device / Device Initialization}
>
>  Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it
> @@ -4712,6 +4825,74 @@ \subsection{Device Initialization}\label{sec:Devic=
e Types / Block Device / Devic
>  The device MUST initialize padding bytes \field{unused0} and
>  \field{unused1} to 0.
>
> +If the device that is being initialized is a not a zoned device, the dev=
ice
> +SHOULD NOT offer the VIRTIO_BLK_F_ZONED feature.
> +
> +If the VIRTIO_BLK_F_ZONED bit is not set by the driver,
> +\begin{itemize}
> +\item the device with the VIRTIO_BLK_Z_HA zone model SHOULD proceed with=
 the
> +    initialization while setting all zoned characteristics fields to zer=
o.
> +
> +\item the device with the VIRTIO_BLK_Z_HM zone model MUST fail to set the
> +    FEATURES_OK device status bit when the driver writes the Device Stat=
us
> +    field.
> +\end{itemize}
> +
> +If the VIRTIO_BLK_F_ZONED feature is negotiated, then the \field{model} =
field in
> +\field{zoned} struct in the configuration space MUST be set by the device
> +\begin{itemize}
> +\item to the value of VIRTIO_BLK_Z_NONE if it operates as a drive-managed
> +    zoned block device or a non-zoned block device.
> +
> +\item to the value of VIRTIO_BLK_Z_HM if it operates as a host-managed z=
oned
> +    block device.
> +
> +\item to the value of VIRTIO_BLK_Z_HA if it operates as a host-aware zon=
ed
> +    block device.
> +\end{itemize}
> +
> +If the VIRTIO_BLK_F_ZONED feature is negotiated,
> +\begin{itemize}
> +\item the \field{zone_sectors} field of \field{zoned} MUST be set by the=
 device
> +    to the size of a single zone on the device. All zones of the device =
have the
> +    same size indicated by \field{zone_sectors} except for the last zone=
 that
> +    MAY be smaller than all other zones. The driver can calculate the nu=
mber of
> +    zones on the device as
> +    \begin{lstlisting}
> +        nr_zones =3D (capacity + zone_sectors - 1) / zone_sectors;
> +    \end{lstlisting}
> +    and the size of the last zone as
> +    \begin{lstlisting}
> +        zs_last =3D capacity - (nr_zones - 1) * zone_sectors;
> +    \end{lstlisting}
> +
> +\item The \field{max_open_zones} field of the \field{zoned} structure MU=
ST be
> +    set by the device to the maximum number of zones that can be open on=
 the
> +    device (zones in the implicit open or explicit open state). A value
> +    of zero indicates that the device does not have any limit on the num=
ber of
> +    open zones.
> +
> +\item The \field{max_active_zones} field of the \field{zoned} structure =
MUST
> +    be set by the device to the maximum number zones that can be active =
on the
> +    device (zones in the implicit open, explicit open or closed state). =
A value
> +    of zero indicates that the device does not have any limit on the num=
ber of
> +    active zones.
> +
> +\item the \field{max_append_sectors} field of \field{zoned} MUST be set =
by
> +    the device to the maximum data size of a VIRTIO_BLK_T_ZONE_APPEND re=
quest
> +    that can be successfully issued to the device. The value of this fie=
ld MUST
> +    NOT exceed the \field{seg_max} * \field{size_max} value. A device MA=
Y set
> +    the \field{max_append_sectors} to zero if it doesn't support
> +    VIRTIO_BLK_T_ZONE_APPEND requests.
> +
> +\item the \field{write_granularity} field of \field{zoned} MUST be set b=
y the
> +    device to the offset and size alignment constraint for VIRTIO_BLK_T_=
OUT
> +    and VIRTIO_BLK_T_ZONE_APPEND requests issued to a sequential zone of=
 the
> +    device.
> +
> +\item the device MUST initialize padding bytes \field{unused2} to 0.
> +\end{itemize}
> +
>  \subsubsection{Legacy Interface: Device Initialization}\label{sec:Device=
 Types / Block Device / Device Initialization / Legacy Interface: Device In=
itialization}
>
>  Because legacy devices do not have FEATURES_OK, transitional devices
> @@ -4738,7 +4919,8 @@ \subsubsection{Legacy Interface: Device Initializat=
ion}\label{sec:Device Types /
>  \subsection{Device Operation}\label{sec:Device Types / Block Device / De=
vice Operation}
>
>  The driver queues requests to the virtqueues, and they are used by
> -the device (not necessarily in order). Each request is of form:
> +the device (not necessarily in order). If the VIRTIO_BLK_F_ZONED feature
> +is not negotiated, then each request is of form:

Is this sentence still needed? This revision of the spec seems to use
struct virtio_blk_req for both zoned and non-zoned devices, so I think
this sentence can be dropped.

>
>  \begin{lstlisting}
>  struct virtio_blk_req {
> @@ -4746,7 +4928,15 @@ \subsection{Device Operation}\label{sec:Device Typ=
es / Block Device / Device Ope
>          le32 reserved;
>          le64 sector;
>          u8 data[];
> -        u8 status;
> +        union {
> +                u8 status;
> +
> +                struct {
> +                        u8 status;
> +                        u8 reserved[3];
> +                        le64 append_sector;

Align to 8 bytes instead of 4 bytes so that append_sector has natural align=
ment?

> +                } zone_append_in_hdr;
> +        };
>  };
>  \end{lstlisting}
>
> @@ -4853,6 +5043,290 @@ \subsection{Device Operation}\label{sec:Device Ty=
pes / Block Device / Device Ope
>  command produces VIRTIO_BLK_S_IOERR.  A segment may have completed
>  successfully, failed, or not been processed by the device.
>
> +The following requirements only apply if the VIRTIO_BLK_F_ZONED feature =
is
> +negotiated.
> +
> +In addition to the request types defined for non-zoned devices, the type=
 of the
> +request can be a zone report (VIRTIO_BLK_T_ZONE_REPORT), an explicit zon=
e open
> +(VIRTIO_BLK_T_ZONE_OPEN), an explicit zone close (VIRTIO_BLK_T_ZONE_CLOS=
E), a
> +zone finish (VIRTIO_BLK_T_ZONE_FINISH), a zone_append
> +(VIRTIO_BLK_T_ZONE_APPEND), a zone reset (VIRTIO_BLK_T_ZONE_RESET) or a =
zone
> +reset all (VIRTIO_BLK_T_ZONE_RESET_ALL).
> +
> +\begin{lstlisting}
> +#define VIRTIO_BLK_T_ZONE_APPEND    15
> +#define VIRTIO_BLK_T_ZONE_REPORT    16
> +#define VIRTIO_BLK_T_ZONE_OPEN      18
> +#define VIRTIO_BLK_T_ZONE_CLOSE     20
> +#define VIRTIO_BLK_T_ZONE_FINISH    22
> +#define VIRTIO_BLK_T_ZONE_RESET     24
> +#define VIRTIO_BLK_T_ZONE_RESET_ALL 26
> +\end{lstlisting}
> +
> +Requests of type VIRTIO_BLK_T_OUT, VIRTIO_BLK_T_ZONE_OPEN,
> +VIRTIO_BLK_T_ZONE_CLOSE, VIRTIO_BLK_T_ZONE_FINISH, VIRTIO_BLK_T_ZONE_APP=
END,
> +VIRTIO_BLK_T_ZONE_RESET or VIRTIO_BLK_T_ZONE_RESET_ALL may be completed =
by the
> +device with VIRTIO_BLK_S_OK, VIRTIO_BLK_S_IOERR or VIRTIO_BLK_S_UNSUPP
> +\field{status}, or, additionally, with  VIRTIO_BLK_S_ZONE_INVALID_CMD,
> +VIRTIO_BLK_S_ZONE_UNALIGNED_WP, VIRTIO_BLK_S_ZONE_OPEN_RESOURCE or
> +VIRTIO_BLK_S_ZONE_ACTIVE_RESOURCE ZBD-specific status codes.
> +
> +\begin{lstlisting}
> +#define VIRTIO_BLK_S_ZONE_INVALID_CMD     3
> +#define VIRTIO_BLK_S_ZONE_UNALIGNED_WP    4
> +#define VIRTIO_BLK_S_ZONE_OPEN_RESOURCE   5
> +#define VIRTIO_BLK_S_ZONE_ACTIVE_RESOURCE 6
> +\end{lstlisting}
> +
> +Requests of the type VIRTIO_BLK_T_ZONE_REPORT are reads and requests of =
the type
> +VIRTIO_BLK_T_ZONE_APPEND transfer data from the device. VIRTIO_BLK_T_ZON=
E_OPEN,
> +VIRTIO_BLK_T_ZONE_CLOSE, VIRTIO_BLK_T_ZONE_FINISH, VIRTIO_BLK_T_ZONE_RES=
ET and
> +VIRTIO_BLK_T_ZONE_RESET_ALL are non-data requests.
> +
> +In ZBD standards, the VIRTIO_BLK_T_ZONE_REPORT request belongs to "Zone
> +Management Receive" command category and VIRTIO_BLK_T_ZONE_OPEN,
> +VIRTIO_BLK_T_ZONE_CLOSE, VIRTIO_BLK_T_ZONE_FINISH and
> +VIRTIO_BLK_T_ZONE_RESET/VIRTIO_BLK_T_ZONE_RESET_ALL requests are categor=
ized as
> +"Zone Management Send" commands. VIRTIO_BLK_T_ZONE_APPEND is categorized
> +separately from the zone management commands and is the only request tha=
t uses
> +\field{zone_append_in_hdr} structure in \field{virtio_blk_req} to return
> +to the driver the sector at which the data has been appended to the zone.
> +
> +VIRTIO_BLK_T_ZONE_REPORT is a read request that returns the information =
about
> +the current state of zones on the device starting from the zone containi=
ng the
> +\field{sector} of the request. The report consists of a header followed =
by zero
> +or more zone descriptors.
> +
> +A zone report reply has the following structure:
> +
> +\begin{lstlisting}
> +struct virtio_blk_zone_report {
> +        le64   nr_zones;
> +        u8     reserved[56];
> +        struct virtio_blk_zone_descriptor zones[];
> +};
> +\end{lstlisting}
> +
> +The device sets the \field{nr_zones} field in the report header to the n=
umber of
> +fully transferred zone descriptors in the data buffer.
> +
> +A zone descriptor has the following structure:
> +
> +\begin{lstlisting}
> +struct virtio_blk_zone_descriptor {
> +        le64   z_cap;
> +        le64   z_start;
> +        le64   z_wp;
> +        u8     z_type;
> +        u8     z_state;
> +        u8     reserved[38];
> +};
> +\end{lstlisting}
> +
> +The zone descriptor field \field{z_type} \field{virtio_blk_zone_descript=
or}
> +indicates the type of the zone. The available types are VIRTIO_BLK_ZT_CO=
NV(1),
> +VIRTIO_BLK_ZT_SWR(2) or VIRTIO_BLK_ZT_SWP(3).
> +
> +\begin{lstlisting}
> +#define VIRTIO_BLK_ZT_CONV     1
> +#define VIRTIO_BLK_ZT_SWR      2
> +#define VIRTIO_BLK_ZT_SWP      3
> +\end{lstlisting}
> +
> +Read and write operations into zones with the VIRTIO_BLK_ZT_CONV (Conven=
tional)
> +type have the same behavior as read and write operations on a regular bl=
ock
> +device. Any block in a conventional zone can be read or written at any t=
ime and
> +in any order.
> +
> +Zones with VIRTIO_BLK_ZT_SWR can be read randomly, but must be written
> +sequentially at a certain point in the zone called the Write Pointer (WP=
). With
> +every write, the Write Pointer is incremented by the number of sectors w=
ritten.
> +
> +Zones with VIRTIO_BLK_ZT_SWP can be read randomly and should be written
> +sequentially, similarly to SWR zones. However, SWP zones can accept rand=
om write
> +operations, that is, VIRTIO_BLK_T_OUT requests with a start sector diffe=
rent
> +from the zone write pointer position.
> +
> +The field \field{z_state} of \field{virtio_blk_zone_descriptor} indicate=
s the
> +state of the device zone. The available zone states are VIRTIO_BLK_ZS_NO=
T_WP(0),
> +VIRTIO_BLK_ZS_EMPTY(1), VIRTIO_BLK_ZS_IOPEN(2), VIRTIO_BLK_ZS_EOPEN(3),
> +VIRTIO_BLK_ZS_CLOSED(4), VIRTIO_BLK_ZS_RDONLY(13), VIRTIO_BLK_ZS_FULL(14=
) and
> +VIRTIO_BLK_ZS_OFFLINE(15).
> +
> +\begin{lstlisting}
> +#define VIRTIO_BLK_ZS_NOT_WP   0
> +#define VIRTIO_BLK_ZS_EMPTY    1
> +#define VIRTIO_BLK_ZS_IOPEN    2
> +#define VIRTIO_BLK_ZS_EOPEN    3
> +#define VIRTIO_BLK_ZS_CLOSED   4
> +#define VIRTIO_BLK_ZS_RDONLY   13
> +#define VIRTIO_BLK_ZS_FULL     14
> +#define VIRTIO_BLK_ZS_OFFLINE  15
> +\end{lstlisting}
> +
> +Zones of the type VIRTIO_BLK_ZT_CONV are always reported by the device t=
o be in
> +the VIRTIO_BLK_ZS_NOT_WP state. Zones of the types VIRTIO_BLK_ZT_SWR and
> +VIRTIO_BLK_ZT_SWP can not transition to the VIRTIO_BLK_ZS_NOT_WP state.
> +
> +Zones in VIRTIO_BLK_ZS_EMPTY (Empty), VIRTIO_BLK_ZS_IOPEN (Implicitly Op=
en),
> +VIRTIO_BLK_ZS_EOPEN (Explicitly Open) and VIRTIO_BLK_ZS_CLOSED (Closed) =
state
> +are writable, but zones in VIRTIO_BLK_ZS_RDONLY (Read-Only), VIRTIO_BLK_=
ZS_FULL
> +(Full) and VIRTIO_BLK_ZS_OFFLINE (Offline) state are not. The write poin=
ter
> +value (\field{z_wp}) is not valid for Read-Only, Full and Offline zones.
> +
> +The zone descriptor field \field{z_cap} contains the maximum number of 5=
12-byte
> +sectors that are available to be written with user data when the zone is=
 in the
> +Empty state. This value shall be less than or equal to the \field{zone_s=
ectors}
> +value in \field{virtio_blk_zoned_characteristics} structure in the device
> +configuration space.
> +
> +The zone descriptor field \field{z_start} contains the 64-bit address of=
 the
> +first 512-byte sector of the zone.
> +
> +The zone descriptor field \field{z_wp} contains the 64-bit sector addres=
s where
> +the next write operation for this zone should be issued. This value is u=
ndefined
> +for conventional zones and for zones in VIRTIO_BLK_ZS_RDONLY, VIRTIO_BLK=
_ZS_FULL
> +and VIRTIO_BLK_ZS_OFFLINE state.
> +
> +Depending on their state, zones consume resources as follows:
> +\begin{itemize}
> +\item a zone in VIRTIO_BLK_ZS_IOPEN and VIRTIO_BLK_ZS_EOPEN state consum=
es one
> +    open zone resource and, additionally,
> +
> +\item a zone in VIRTIO_BLK_ZS_IOPEN, VIRTIO_BLK_ZS_EOPEN and
> +    VIRTIO_BLK_ZS_CLOSED state consumes one active resource.
> +\end{itemize}
> +
> +Attempts for zone transitions that violate zone resource limits must fai=
l with
> +VIRTIO_BLK_S_ZONE_OPEN_RESOURCE or VIRTIO_BLK_S_ZONE_ACTIVE_RESOURCE
> +\field{status}.
> +
> +Zones in the VIRTIO_BLK_ZS_EMPTY (Empty) state have the write pointer va=
lue
> +equal to the start sector of the zone. In this state, the entire capacit=
y of the
> +zone is available for writing. A zone can transition from this state to
> +\begin{itemize}
> +\item VIRTIO_BLK_ZS_IOPEN when a successful VIRTIO_BLK_T_OUT request or
> +    VIRTIO_BLK_T_ZONE_APPEND with a non-zero data size is received for t=
he zone.
> +
> +\item VIRTIO_BLK_ZS_EOPEN when a successful VIRTIO_BLK_T_ZONE_OPEN reque=
st is
> +    received for the zone
> +\end{itemize}
> +
> +When a VIRTIO_BLK_T_ZONE_RESET request is issued to an Empty zone, the r=
equest
> +is completed successfully and the zone stays in the VIRTIO_BLK_ZS_EMPTY =
state.
> +
> +Zones in the VIRTIO_BLK_ZS_IOPEN (Implicitly Open) state transition from
> +this state to
> +\begin{itemize}
> +\item VIRTIO_BLK_ZS_EMPTY when a successful VIRTIO_BLK_T_ZONE_RESET requ=
est is
> +    received for the zone,
> +
> +\item VIRTIO_BLK_ZS_EOPEN when a successful VIRTIO_BLK_T_ZONE_OPEN reque=
st is
> +    received for the zone,
> +
> +\item VIRTIO_BLK_ZS_CLOSED when a successful VIRTIO_BLK_T_ZONE_CLOSE req=
uest is
> +    received for the zone,
> +
> +\item VIRTIO_BLK_ZS_CLOSED implicitly by the device when another zone is
> +    entering the VIRTIO_BLK_ZS_IOPEN or VIRTIO_BLK_ZS_EOPEN state and th=
e number
> +    of currently open zones is at \field{max_open_zones} limit,
> +
> +\item VIRTIO_BLK_ZS_FULL when a successful VIRTIO_BLK_T_ZONE_FINISH requ=
est is
> +    received for the zone.
> +
> +\item VIRTIO_BLK_ZS_FULL when a successful VIRTIO_BLK_T_OUT or
> +    VIRTIO_BLK_T_ZONE_APPEND request that causes the zone to reach its w=
ritable
> +    capacity is received for the zone.
> +\end{itemize}
> +
> +Zones in the VIRTIO_BLK_ZS_EOPEN (Explicitly Open) state transition from
> +this state to
> +\begin{itemize}
> +\item VIRTIO_BLK_ZS_EMPTY when a successful VIRTIO_BLK_T_ZONE_RESET requ=
est is
> +    received for the zone,
> +
> +\item VIRTIO_BLK_ZS_EMPTY when a successful VIRTIO_BLK_T_ZONE_CLOSE requ=
est is
> +    received for the zone and the write pointer of the zone has the valu=
e equal
> +    to the start sector of the zone,
> +
> +\item VIRTIO_BLK_ZS_CLOSED when a successful VIRTIO_BLK_T_ZONE_CLOSE req=
uest is
> +    received for the zone and the zone write pointer is larger then the =
start
> +    sector of the zone,
> +
> +\item VIRTIO_BLK_ZS_FULL when a successful VIRTIO_BLK_T_ZONE_FINISH requ=
est is
> +    received for the zone,
> +
> +\item VIRTIO_BLK_ZS_FULL when a successful VIRTIO_BLK_T_OUT or
> +    VIRTIO_BLK_T_ZONE_APPEND request that causes the zone to reach its w=
ritable
> +    capacity is received for the zone.
> +\end{itemize}
> +
> +When a VIRTIO_BLK_T_ZONE_EOPEN request is issued to an Explicitly Open z=
one, the
> +request is completed successfully and the zone stays in the VIRTIO_BLK_Z=
S_EOPEN
> +state.
> +
> +Zones in the VIRTIO_BLK_ZS_CLOSED (Closed) state transition from this st=
ate
> +to
> +\begin{itemize}
> +\item VIRTIO_BLK_ZS_EMPTY when a successful VIRTIO_BLK_T_ZONE_RESET requ=
est is
> +    received for the zone,
> +
> +\item VIRTIO_BLK_ZS_IOPEN when a successful VIRTIO_BLK_T_OUT request or
> +    VIRTIO_BLK_T_ZONE_APPEND with a non-zero data size is received for t=
he zone.
> +
> +\item VIRTIO_BLK_ZS_EOPEN when a successful VIRTIO_BLK_T_ZONE_OPEN reque=
st is
> +    received for the zone,
> +\end{itemize}
> +
> +When a VIRTIO_BLK_T_ZONE_CLOSE request is issued to a Closed zone, the r=
equest
> +is completed successfully and the zone stays in the VIRTIO_BLK_ZS_CLOSED=
 state.
> +
> +Zones in the VIRTIO_BLK_ZS_FULL (Full) state can transition from this st=
ate to
> +VIRTIO_BLK_ZS_EMPTY when a successful VIRTIO_BLK_T_ZONE_RESET request is
> +received for the zone
> +
> +When a VIRTIO_BLK_T_ZONE_FINISH request is issued to a Full zone, the re=
quest
> +is completed successfully and the zone stays in the VIRTIO_BLK_ZS_FULL s=
tate.
> +
> +The device may automatically transition zones to VIRTIO_BLK_ZS_RDONLY
> +(Read-Only) or VIRTIO_BLK_ZS_OFFLINE (Offline) state from any other stat=
e. The
> +device may also automatically transition zones in the Read-Only state to=
 the
> +Offline state. Zones in the Offline state may not transition to any othe=
r state.
> +Such automatic transitions usually indicate hardware failures. The previ=
ously
> +written data may only be read from zones in the Read-Only state. Zones i=
n the
> +Offline state can not be read or written.
> +
> +VIRTIO_BLK_S_ZONE_UNALIGNED_WP is set by the device when the request rec=
eived
> +from the driver attempts to perform a write to an SWR zone and at least =
one of
> +the following conditions is met:
> +
> +\begin{itemize}
> +\item the starting sector of the request is not equal to the current val=
ue of
> +    the zone write pointer.
> +
> +\item the ending sector of the request data multiplied by 512 is not a m=
ultiple
> +    of the value reported by the device in the field \field{write_granul=
arity}
> +    in the device configuration space.
> +\end{itemize}
> +
> +VIRTIO_BLK_S_ZONE_OPEN_RESOURCE is set by the device when a zone operati=
on or
> +write request received from the driver can not be handled without exceed=
ing the
> +\field{max_open_zones} limit value reported by the device in the configu=
ration
> +space.
> +
> +VIRTIO_BLK_S_ZONE_ACTIVE_RESOURCE is set by the device when a zone opera=
tion or
> +write request received from the driver can not be handled without exceed=
ing the
> +\field{max_active_zones} limit value reported by the device in the confi=
guration
> +space.
> +
> +A zone transition request that leads to both the \field{max_open_zones} =
and the
> +\field{max_active_zones} limits to be exceeded is terminated by the devi=
ce with
> +VIRTIO_BLK_S_ZONE_ACTIVE_RESOURCE \field{status} value.
> +
> +The device SHALL report all other error conditions related to zoned bloc=
k model
> +operation by setting the VIRTIO_BLK_S_ZONE_INVALID_CMD value in
> +\field{status} of \field{virtio_blk_req} structure.
> +
>  \drivernormative{\subsubsection}{Device Operation}{Device Types / Block =
Device / Device Operation}
>
>  A driver MUST NOT submit a request which would cause a read or write
> @@ -4899,6 +5373,51 @@ \subsection{Device Operation}\label{sec:Device Typ=
es / Block Device / Device Ope
>  successfully, failed, or were processed by the device at all if the requ=
est
>  failed with VIRTIO_BLK_S_IOERR.
>
> +The following requirements only apply if the VIRTIO_BLK_F_ZONED feature =
is
> +negotiated.
> +
> +When forming a VIRTIO_BLK_T_ZONE_REPORT request, the driver sets the sec=
tor
> +address of the starting zone to report to \field{sector}.

This is not a MUST/SHOULD/MAY statements. This is a clue that some of
these paragraphs should be moved to the non-normative section that
describes how things work. The normative sections only have
requirements for device and driver implementors, they don't explain
how the device works.

> +
> +VIRTIO_BLK_T_ZONE_OPEN, VIRTIO_BLK_T_ZONE_CLOSE, VIRTIO_BLK_T_ZONE_FINIS=
H and
> +VIRTIO_BLK_T_ZONE_RESET requests make the zone operation to act on a par=
ticular
> +zone specified by the zone sector address in the \field{sector} of the r=
equest.
> +The zone sector address is a 64-bit value expressed in 512-byte units th=
at
> +points at the first sector in the target zone.

Normally the struct virtio_blk_req sector field is expressed in bytes.
If I'm interpreting this text correctly the zone management commands
change the field's meaning to sector units?

> +
> +VIRTIO_BLK_T_ZONE_RESET_ALL request acts upon all applicable zones of the
> +device. For this request, the driver MUST set the field \field{sector} t=
o zero
> +value.
> +
> +The \field{sector} field of the VIRTIO_BLK_T_ZONE_APPEND request MUST sp=
ecify
> +the first sector of the zone to which data is to be appended at the posi=
tion of
> +the write pointer. The zone sector address is a 64-bit value expressed in
> +512-byte units that points anywhere in the target zone. The size of the =
data

This "512-byte units" wording confuses me. I think the units should be
bytes and the text should say "in multiples of 512 bytes".

> +that is appended MUST NOT exceed the \field{max_append_sectors} value pr=
ovided
> +by the device in \field{virtio_blk_zoned_characteristics} configuration =
space
> +structure.
> +
> +Upon a successful completion of a VIRTIO_BLK_T_ZONE_APPEND request, the =
driver
> +SHOULD read the starting sector location of the written data from the re=
quest field
> +\field{append_sector}.

Maybe that depends on the application? If the application blindly
appends and doesn't use the write pointer then there's no need to read
append_sector. I think this statement can be removed and instead the
non-normative section can describe the purpose of the append_sector
field so that driver authors know the new write pointer value is
available if they require it.

> +
> +All VIRTIO_BLK_T_OUT requests issued by the driver to sequential zones a=
nd
> +VIRTIO_BLK_T_ZONE_APPEND requests MUST have:
> +
> +\begin{enumerate}
> +\item the data size that is a multiple of the number of bytes reported
> +    by the device in the field \field{write_granularity} in the
> +    \field{virtio_blk_zoned_characteristics} configuration space structu=
re.
> +
> +\item the value of the field \field{sector} that is a multiple of the nu=
mber of
> +    bytes reported by the device in the field \field{write_granularity} =
in the
> +    \field{virtio_blk_zoned_characteristics} configuration space structu=
re.
> +
> +\item the data size that will not exceed the writable zone capacity when=
 its
> +    value is added to the current value of the write pointer of the zone.
> +
> +\end{enumerate}
> +
>  \devicenormative{\subsubsection}{Device Operation}{Device Types / Block =
Device / Device Operation}
>
>  A device MUST set the \field{status} byte to VIRTIO_BLK_S_IOERR
> @@ -4990,6 +5509,143 @@ \subsection{Device Operation}\label{sec:Device Ty=
pes / Block Device / Device Ope
>    simplfy passthrough implementations from eMMC devices.
>  \end{note}
>
> +If the VIRTIO_BLK_F_ZONED feature is not negotiated, the device MUST rej=
ect
> +VIRTIO_BLK_T_ZONE_REPORT, VIRTIO_BLK_T_ZONE_OPEN, VIRTIO_BLK_T_ZONE_CLOS=
E,
> +VIRTIO_BLK_T_ZONE_FINISH, VIRTIO_BLK_T_ZONE_APPEND, VIRTIO_BLK_T_ZONE_RE=
SET and
> +VIRTIO_BLK_T_ZONE_RESET_ALL requests with VIRTIO_BLK_S_UNSUPP status.
> +
> +The following device requirements only apply if the VIRTIO_BLK_F_ZONED f=
eature
> +is negotiated.
> +
> +If a request of type VIRTIO_BLK_T_ZONE_OPEN, VIRTIO_BLK_T_ZONE_CLOSE,
> +VIRTIO_BLK_T_ZONE_FINISH or VIRTIO_BLK_T_ZONE_RESET is issued for a Conv=
entional
> +zone (type VIRTIO_BLK_ZT_CONV), the device MUST complete the request with
> +VIRTIO_BLK_S_ZONE_INVALID_CMD \field{status}.
> +
> +If the zone specified by the VIRTIO_BLK_T_ZONE_APPEND request is not a S=
WR zone,
> +then the request SHALL be completed with VIRTIO_BLK_S_ZONE_INVALID_CMD
> +\field{status}.
> +
> +The device handles a VIRTIO_BLK_T_ZONE_OPEN request with the by attempti=
ng to
> +change the state of the zone with the \field{sector} address to
> +VIRTIO_BLK_ZS_EOPEN. If the transition to this state can not be performe=
d, the
> +request MUST be completed with VIRTIO_BLK_S_ZONE_INVALID_CMD \field{stat=
us}. If,
> +while processing this request, the available zone resources are insuffic=
ient,
> +then the zone state does not change and the request MUST be completed wi=
th
> +VIRTIO_BLK_S_ZONE_OPEN_RESOURCE or VIRTIO_BLK_S_ZONE_ACTIVE_RESOURCE val=
ue in
> +the field \field{status}.
> +
> +The device handles a VIRTIO_BLK_T_ZONE_CLOSE request by attempting to ch=
ange the
> +state of the zone with the \field{sector} address to VIRTIO_BLK_ZS_CLOSE=
D. If
> +the transition to this state can not be performed, the request MUST be c=
ompleted
> +with VIRTIO_BLK_S_ZONE_INVALID_CMD value in the field \field{status}.
> +
> +The device handles a VIRTIO_BLK_T_ZONE_FINISH request by attempting to c=
hange
> +the state of the zone with the \field{sector} address to VIRTIO_BLK_ZS_F=
ULL. If
> +the transition to this state can not be performed, the zone state does n=
ot
> +change and the request MUST be completed with VIRTIO_BLK_S_ZONE_INVALID_=
CMD
> +value in the field \field{status}.
> +
> +The device handles a VIRTIO_BLK_T_ZONE_RESET request by attempting to ch=
ange the
> +state of the zone with the \field{sector} address to VIRTIO_BLK_ZS_EMPTY=
 state.
> +If the transition to this state can not be performed, the zone state doe=
s not
> +change and the request MUST be completed with VIRTIO_BLK_S_ZONE_INVALID_=
CMD
> +value in the field \field{status}.
> +
> +The device handles a VIRTIO_BLK_T_ZONE_RESET_ALL request by transitionin=
g all
> +sequential device zones in VIRTIO_BLK_ZS_IOPEN, VIRTIO_BLK_ZS_EOPEN,
> +VIRTIO_BLK_ZS_CLOSED and VIRTIO_BLK_ZS_FULL state to VIRTIO_BLK_ZS_EMPTY=
 state.
> +
> +Upon receiving a VIRTIO_BLK_T_ZONE_APPEND request or a VIRTIO_BLK_T_OUT
> +request issued to a SWR zone in VIRTIO_BLK_ZS_EMPTY or VIRTIO_BLK_ZS_CLO=
SED
> +state, the device attempts to perform the transition of the zone to
> +VIRTIO_BLK_ZS_IOPEN state before writing data. This transition may fail =
due to
> +insufficient open and/or active zone resources available on the device. =
In this
> +case, the request MUST be completed with VIRTIO_BLK_S_ZONE_OPEN_RESOURCE=
 or
> +VIRTIO_BLK_S_ZONE_ACTIVE_RESOURCE value in the \field{status}.
> +
> +If the \field{sector} field in the VIRTIO_BLK_T_ZONE_APPEND request does=
 not
> +specify the lowest sector for a zone, then the request SHALL be complete=
d with
> +VIRTIO_BLK_S_ZONE_INVALID_CMD value in \field{status}.
> +
> +A VIRTIO_BLK_T_ZONE_APPEND request or a VIRTIO_BLK_T_OUT request that ha=
s the
> +data range that that exceeds the remaining writable capacity for the zon=
e, then
> +the request SHALL be completed with VIRTIO_BLK_S_ZONE_INVALID_CMD value =
in
> +\field{status}.
> +
> +If a request of the type VIRTIO_BLK_T_ZONE_APPEND is completed with
> +VIRTIO_BLK_S_OK status, the field \field{append_sector} in
> +\field{zone_append_in_hdr} field in \field{virtio_blk_req} MUST be set by
> +the device to contain the start sector of the data written to the zone.
> +
> +A VIRTIO_BLK_T_ZONE_APPEND request that has the data size that exceeds
> +\field{max_append_sectors} configuration space value, then,
> +\begin{itemize}
> +\item if \field{max_append_sectors} configuration space value is reporte=
d as
> +    zero by the device, the request SHALL be completed with VIRTIO_BLK_S=
_UNSUPP
> +    \field{status}.
> +
> +\item if \field{max_append_sectors} configuration space value is reporte=
d as
> +    a non-zero value by the device, the request SHALL be completed with
> +    VIRTIO_BLK_S_ZONE_INVALID_CMD \field{status}.
> +\end{itemize}
> +
> +If a VIRTIO_BLK_T_ZONE_APPEND request, a VIRTIO_BLK_T_IN request or a
> +VIRTIO_BLK_T_OUT request issued to a SWR zone has the range that has sec=
tors in
> +more than one zone, then the request SHALL completed with
> +VIRTIO_BLK_S_ZONE_INVALID_CMD value in the field \field{status}.
> +
> +A VIRTIO_BLK_T_OUT request that has the \field{sector} value that is not=
 aligned
> +with the write pointer for the zone, then the request SHALL completed wi=
th
> +VIRTIO_BLK_S_ZONE_UNALIGNED_WP value in the field \field{status}.
> +
> +In order to avoid resource-related errors while opening zones implicitly=
, the
> +device MAY automatically transition zones in VIRTIO_BLK_ZS_IOPEN state to
> +VIRTIO_BLK_ZS_CLOSED state.
> +
> +All VIRTIO_BLK_T_OUT requests or VIRTIO_BLK_T_ZONE_APPEND requests issued
> +to a zone in the VIRTIO_BLK_ZS_RDONLY state SHALL be completed with
> +VIRTIO_BLK_S_ZONE_INVALID_CMD \field{status}.
> +
> +All requests issued to a zone in the VIRTIO_BLK_ZS_OFFLINE state SHALL be
> +completed with VIRTIO_BLK_S_ZONE_INVALID_CMD value in the field \field{s=
tatus}.
> +
> +The device MUST consider the data that is read above the write pointer o=
f a zone
> +as unwritten data. The sectors between the write pointer position and th=
e upper
> +write boundary of the zone during VIRTIO_BLK_T_ZONE_FINISH request proce=
ssing
> +are also considered unwritten data.
> +
> +When unwritten data is present in the sector range of a read request, th=
e device
> +MUST process this data in one of the following ways -
> +
> +\begin{enumerate}
> +\item Fill the unwritten data with a device-specific byte pattern. The
> +configuration, control and reporting of this byte pattern is beyond the =
scope
> +of this standard. This is the preferred approach.
> +
> +\item Fail the request. Depending on the driver implementation, this may=
 prevent
> +the device from becoming operational.
> +
> +\item Return stale, previously written data to the driver. This approach=
 is the
> +least preferred for its obvious negative security implications.
> +\end{enumerate}

Do these semantics come from the ZBD model? They seem kind of
undesirable to me (filling with zeroes seems most sensible), but
virtio-blk devices must be able to pass through real ZBD devices, so
it makes sense to support same semantics as the ZBD model.

> +
> +If the both VIRTIO_BLK_F_ZONED and VIRTIO_BLK_F_SECURE_ERASE features are
> +negotiated, then
> +
> +\begin{enumerate}
> +\item the field \field{secure_erase_sector_alignment} in the configurati=
on space
> +of the device MUST be a multiple of \field{zone_sectors} value reported =
in the
> +device configuration space.
> +
> +\item the data size in VIRTIO_BLK_T_SECURE_ERASE requests MUST be a mult=
iple of
> +\field{zone_sectors} value in the device configuration space.
> +\end{enumerate}
> +
> +The device MUST handle a VIRTIO_BLK_T_SECURE_ERASE request in the same w=
ay it
> +handles VIRTIO_BLK_T_ZONE_RESET request for the zone range specified in =
the
> +VIRTIO_BLK_T_SECURE_ERASE request.
> +
>  \subsubsection{Legacy Interface: Device Operation}\label{sec:Device Type=
s / Block Device / Device Operation / Legacy Interface: Device Operation}
>  When using the legacy interface, transitional devices and drivers
>  MUST format the fields in struct virtio_blk_req
> --
> 2.34.1
>

--gDOXJcgjU4Mi3fkm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmLu2xQACgkQnKSrs4Gr
c8j7hAf9GS8sphm5nMy4PxK5xStj+Crp86LxgZIJikcKbxvhLXy/HQQVMtN76kxV
E6PaEjx4wjree14yoOqUswTjKT00fg3/ZkxfH8RRlYfW4dQcBgnrZz15t95nPt8i
EWdcJl9lXemQokBRG5mh7Q3NKYfXpyZT33xaBQtc82iTkmulQEmP6gDhkC9VmsQY
y7pyHIy/qsT9UxtsD+mRqHV+bbJZryTxl2JVxcGorjZlUjsuSc3Aqd/Ck0/xC81T
n9mgLTD4xZNIefVtIsV1oDacwc9LSVIQFvRAMuGF6ybpO1dV5bRo0TU0Gr5LsKWI
P9E062irOOQcRnbX48O1pbDYt6Bd+w==
=c4C2
-----END PGP SIGNATURE-----

--gDOXJcgjU4Mi3fkm--


