Return-Path: <virtio-dev-return-9581-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 542429865FD
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Jun 2022 07:23:48 +0000 (UTC)
Date: Thu, 2 Jun 2022 08:23:38 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <Yphlet2cKT9ySAay@stefanha-x1.localdomain>
References: <20220601235559.41091-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DSsJd/dJ0H8bn7z1"
Content-Disposition: inline
In-Reply-To: <20220601235559.41091-1-dmitry.fomichev@wdc.com>
Subject: Re: [virtio-dev] [RFC PATCH] virtio-blk: add zoned block device
 specification
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, Damien Le Moal <damien.lemoal@opensource.wdc.com>, Matias Bjorling <matias.bjorling@wdc.com>, Niklas Cassel <niklas.cassel@wdc.com>, Hans Holmberg <Hans.Holmberg@wdc.com>, Stefan Hajnoczi <stefanha@gmail.com>, Hannes Reinecke <hare@suse.de>, Sam Li <faithilikerun@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--DSsJd/dJ0H8bn7z1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

(Resending from my mailing list subscriber address so this makes it onto
the list.)

On Thu, 2 Jun 2022 at 00:56, Dmitry Fomichev <dmitry.fomichev@wdc.com> wrot=
e:
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
> extensions defined in the spec patch. I would like to receive the
> initial feedback on this specification patch before posting that series
> to the block LKML.
>
> I would like to thank the following people for their useful feedback
> and suggestions while working on the initial iterations of this patch.
>
> Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Matias Bj=F8rling <Matias.Bjorling@wdc.com>
> Niklas Cassel <Niklas.Cassel@wdc.com>
> Hans Holmberg <Hans.Holmberg@wdc.com>
>
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> ---
>  content.tex | 686 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 685 insertions(+), 1 deletion(-)
>
> diff --git a/content.tex b/content.tex
> index 7508dd1..8ae7578 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -4557,6 +4557,11 @@ \subsection{Feature bits}\label{sec:Device Types /=
 Block Device / Feature bits}
>       maximum erase sectors count in \field{max_secure_erase_sectors} and
>       maximum erase segment number in \field{max_secure_erase_seg}.
>
> +\item[VIRTIO_BLK_F_ZONED(17)] Device is a Zoned Block Device, that is, a=
 device
> +       that behaves as defined by the T10 Zoned Block Command standard (=
ZBC r05) or
> +       the NVMe(TM) NVM Express Zoned Namespace Command Set Specificatio=
n 1.1b
> +       (ZNS).

The rest of the spec doesn't mention ZBC/ZNS but at least the zone
state machine is likely to be derived from these standards. Have you
reviewed the license/IP terms of VIRTIO, ZBC, and ZNS to check that
it's okay to do this? It's probably okay but I wanted to mention it
because it would be a shame to discover an IP issue after the VIRTIO
spec has been released.

Also, the wording suggests to me that the spec will refer to ZBC/ZNS
instead of defining the behavior itself, but actually you've written a
full self-contained spec (which is great!). Maybe change "behaves as
defined by" to "follows the zoned storage device model that is also
supported by industry standards such as".


> +
>  \end{description}
>
>  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / =
Block Device / Feature bits / Legacy Interface: Feature bits}
> @@ -4589,6 +4594,31 @@ \subsection{Device configuration layout}\label{sec=
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
> +VIRTIO_BLK_Z_HM(1) and VIRTIO_BLK_Z_HA(2).
> +
> +\begin{lstlisting}
> +#define VIRTIO_BLK_Z_HM        1
> +#define VIRTIO_BLK_Z_HA        2
> +\end{lstlisting}
> +
> +If the VIRTIO_BLK_F_ZONED feature is negotiated, then
> +\begin{itemize}
> +\item The value of VIRTIO_BLK_Z_HM MUST be set by the device if it opera=
tes
> +    as a host-managed zoned block device.

The term host-managed is not defined. Please either define it or
include a reference to the zoned storage device model (maybe
zonedstorage.io?).

> +
> +\item The value of VIRTIO_BLK_Z_HA MUST be set by the device if it opera=
tes
> +    as a host-aware zoned block device.

The term host-aware is not defined.

> +\end{itemize}

The VIRTIO spec is organized into normative sections containing
MUST/MAY/SHOULD and descriptive sections. MUST/MAY/SHOULD need to go
in drivernormative or devicenormative sections and can't be used in
descriptive sections.

(I believe the reason for this is to give driver/device implementors a
definitive list of normative statements they can easily review without
re-reading the entire text of the specification.)
This raises the question whether devices can offer VIRTIO_BLK_F_ZONED
but fall back to regular block device operation if the driver does not
negotiate the bit?

This statement partially precludes that because it requires devices to
disable VIRTIO_BLK_F_DISCARD if they advertize VIRTIO_BLK_F_ZONED. I
think there is a way to allow VIRTIO_BLK_F_DISCARD in
!VIRTIO_BLK_F_ZONED mode while forbidding it in VIRTIO_BLK_F_ZONED
mode: the device can fail to set FEATURES_OK when the driver writes
the Device Status field with VIRTIO_BLK_F_DISCARD &&
VIRTIO_BLK_F_ZONED. That way a host-aware device in
!VIRTIO_BLK_F_ZONED mode could allow VIRTIO_BLK_F_DISCARD. Is this
useful?

> +
> +If the VIRTIO_BLK_F_ZONED feature is negotiated, then
> +\begin{itemize}
> +\item If the driver that can not support host-managed zoned devices
> +    reads VIRTIO_BLK_Z_HM from the \field{model} field of \field{zoned},=
 the
> +    driver MUST NOT set FEATURES_OK flag and instead set the FAILED bit.
> +
> +\item If the driver that can not support support zoned devices reads
> +    VIRTIO_BLK_Z_HA from the \field{model} field of \field{zoned}, the d=
river
> +    MAY present the device to the guest as a non-zoned device. In this c=
ase, the

Please avoid using the terms "guest" or "host" in the virtualization
sense and instead use "driver" and "device". VIRTIO can be used in
non-virtualization use cases and it's clearer to avoid virtualization
terminology.

> +    driver SHOULD ignore all other fields in \field{zoned}.

Why would the driver negotiate VIRTIO_BLK_F_ZONED if it doesn't
support zoned devices?

> +\end{itemize}
> +
>  \devicenormative{\subsubsection}{Device Initialization}{Device Types / B=
lock Device / Device Initialization}
>
>  Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it
> @@ -4712,6 +4773,77 @@ \subsection{Device Initialization}\label{sec:Devic=
e Types / Block Device / Devic
>  The device MUST initialize padding bytes \field{unused0} and
>  \field{unused1} to 0.
>
> +If the device that is being initialized is a not a zoned device, the dev=
ice MUST
> +NOT offer the VIRTIO_BLK_F_ZONED feature.
> +
> +If the VIRTIO_BLK_F_ZONED bit is not set by the driver,
> +\begin{itemize}
> +\item the device with the VIRTIO_BLK_Z_HA zone model SHOULD proceed with=
 the
> +    initialization while setting all zoned topology fields to zero.
> +
> +\item the device with the VIRTIO_BLK_Z_HM zone model MUST report the dev=
ice
> +    capacity in \field{capacity} in the configuration space as zero to p=
revent
> +    the use of the device that is incorrectly recognized by the driver as
> +    a non-zoned device.

I suggest changing this to "MUST fail to set the FEATURES_OK device
status bit when the driver writes the Device Status field". That way
the driver gets a clear error instead of seeing a virtio-blk device
with 0 capacity.


> +\end{itemize}
> +
> +If the VIRTIO_BLK_F_ZONED feature is negotiated,
> +\begin{itemize}
> +\item \field{zoned} can be read by the driver to discover the size of a =
single
> +    zone on the device. All zones of the device have the same size indic=
ated by
> +    the \field{zone_sectors} field of \field{zoned} except for the last =
zone
> +    that MAY be smaller than all other zones. The driver can calculate t=
he
> +    number of zones on the device as
> +    \begin{lstlisting}
> +        nr_zones =3D (capacity + zone_sectors - 1) / zone_sectors;
> +    \end{lstlisting}
> +    and the size of the last zone as
> +    \begin{lstlisting}
> +        zs_last =3D capacity - (nr_zones - 1) * zone_sectors;
> +    \end{lstlisting}
> +
> +\item Zones consume volatile device resources while being in certain sta=
tes and
> +    the device MAY set limits on the number of zones that can be in thes=
e states
> +    simultaneously.
> +
> +    Zoned block devices use two internal counters to account for the dev=
ice
> +    resources in use, the number of currently open zones and the number =
of
> +    currently active zones.
> +
> +    Any zone state transition from a state that doesn't consume a zone r=
esource
> +    to a state that consumes the same resource increments the internal d=
evice
> +    counter for that resource. Any zone transition out of a state that c=
onsumes
> +    a zone resource to a state that doesn't consume the same resource de=
crements
> +    the counter. Any request that causes the device to exceed the report=
ed zone
> +    resource limits is terminated by the device with an error.

"an error" is vague. I was wondering what the exact error should be.
Please either mention the error codes here or add "as defined for
specific commands later" so it's clear that the device doesn't get the
choose the error code but they are defined by the spec.

> +
> +\item The \field{max_open_zones} field of the \field{zoned} structure ca=
n be
> +    read by the driver to discover the maximum number of zones that can =
be open
> +    on the device (zones in the implicit open or explicit open state). A=
 value
> +    of zero indicates that the device does not have any limit on the num=
ber of
> +    open zones.
> +
> +\item The \field{max_active_zones} field of the \field{zoned} structure =
can be
> +    read by the driver to discover the maximum number zones that can be =
active
> +    on the device (zones in the implicit open, explicit open or closed s=
tate).
> +    A value of zero indicates that the device does not have any limit on=
 the
> +    number of active zones.
> +
> +\item the \field{max_append_sectors} field of \field{zoned} can be read =
by the
> +    driver to get the maximum data size of a VIRTIO_BLK_T_ZONE_APPEND re=
quest
> +    issued to the device. The value of this field MUST NOT exceed the
> +    \field{seg_max} * \field{size_max} value. A device MAY set the
> +    \field{max_append_sectors} to zero if it doesn't support
> +    VIRTIO_BLK_T_ZONE_APPEND requests.

The MUST NOT/MAY statements need to be in a drivernormative section.
There are more instances below.


> +
> +\item the \field{write_granularity} field of \field{zoned} can be read b=
y the
> +    driver to discover the offset and size alignment constraint for
> +    VIRTIO_BLK_T_OUT and VIRTIO_BLK_T_ZONE_APPEND requests issued to
> +    a sequential zone of the device.
> +
> +\item the device MUST initialize padding bytes \field{unused2} to 0.
> +\end{itemize}
> +
>  \subsubsection{Legacy Interface: Device Initialization}\label{sec:Device=
 Types / Block Device / Device Initialization / Legacy Interface: Device In=
itialization}
>
>  Because legacy devices do not have FEATURES_OK, transitional devices
> @@ -4738,7 +4870,8 @@ \subsubsection{Legacy Interface: Device Initializat=
ion}\label{sec:Device Types /
>  \subsection{Device Operation}\label{sec:Device Types / Block Device / De=
vice Operation}
>
>  The driver queues requests to the virtqueues, and they are used by
> -the device (not necessarily in order). Each request is of form:
> +the device (not necessarily in order). If the VIRTIO_BLK_F_ZONED feature
> +is not negotiated, then each request is of form:
>
>  \begin{lstlisting}
>  struct virtio_blk_req {
> @@ -4853,6 +4986,331 @@ \subsection{Device Operation}\label{sec:Device Ty=
pes / Block Device / Device Ope
>  command produces VIRTIO_BLK_S_IOERR.  A segment may have completed
>  successfully, failed, or not been processed by the device.
>
> +The following requirements only apply if the VIRTIO_BLK_F_ZONED feature =
is
> +negotiated.
> +
> +Each request is of form:
> +
> +\begin{lstlisting}
> +struct virtio_blk_zoned_req {
> +        le32 type;
> +        le32 reserved;
> +        le64 sector;
> +        union zoned_params {
> +                struct {
> +                        /* ALL zone operation flag */
> +                        __u8 all;
> +                        __u8 unused1[3];
> +                } mgmt_send;
> +                struct {
> +                        /* Partial zone report flag */
> +                        __u8 partial;
> +                        __u8 unused2[3];
> +                } mgmt_receive;
> +                struct {
> +                        __u8 unused3[4];
> +                } append;
> +        } zone;
> +        u8 data[];
> +        le64 zone_result;
> +        u8 status;
> +        u8 reserved1[3];

Please make status the last byte so device implementations can reuse
their existing request completion code to handle virtio_blk_zoned_req.
Either reserved1[] can be removed or it can be moved before status.

Here is the non-union representation of the structs. Note that this
means existing request processing code can handle IN/OUT/FLUSH even
when VIRTIO_BLK_F_ZONED is negotiated. We don't need two different
code paths for these common commands:

/* IN/OUT/FLUSH/DISCARD/WRITE_ZEROES */
struct virtio_blk_req {
        le32 type;
        le32 reserved;
        le64 sector;
        u8 data[];
        u8 status;
};

/* ZONE_APPEND */
struct virtio_blk_req_zone_append {
        le32 type;
        le32 reserved;
        le64 sector;
        u8 data[];
        le64 zone_result;
        u8 status;
};

/* ZONE_OPEN, ZONE_CLOSE, ZONE_FINISH, ZONE_RESET */
struct virtio_blk_req_zone_mgmt_send {
        le32 type;
        le32 reserved;
        le64 sector;
        /* ALL zone operation flag */
        __u8 all;
        __u8 unused1[3];
        u8 data[];
        u8 status;
};

/* ZONE_REPORT */
struct virtio_blk_req_zone_mgmt_receive {
        le32 type;
        le32 reserved;
        le64 sector;
        /* Partial zone report flag */
        __u8 partial;
        __u8 unused2[3];
        u8 data[];
        u8 status;
};

> +};
> +\end{lstlisting}
> +
> +In addition to the request types defined for non-zoned devices, the type=
 of the
> +request can be a zone report (VIRTIO_BLK_T_ZONE_REPORT), an explicit zon=
e open
> +(VIRTIO_BLK_T_ZONE_OPEN), an explicit zone close (VIRTIO_BLK_T_ZONE_CLOS=
E), a
> +zone finish (VIRTIO_BLK_T_ZONE_FINISH), a zone_append (VIRTIO_BLK_T_ZONE=
_APPEND)
> +or a zone reset (VIRTIO_BLK_T_ZONE_RESET).
> +
> +\begin{lstlisting}
> +#define VIRTIO_BLK_T_ZONE_APPEND    15
> +#define VIRTIO_BLK_T_ZONE_REPORT    16
> +#define VIRTIO_BLK_T_ZONE_OPEN      18
> +#define VIRTIO_BLK_T_ZONE_CLOSE     20
> +#define VIRTIO_BLK_T_ZONE_FINISH    22
> +#define VIRTIO_BLK_T_ZONE_RESET     24
> +\end{lstlisting}
> +
> +Requests of the type VIRTIO_BLK_T_ZONE_REPORT are reads and requests of =
the type

Here "reads" means data transfers from the device to the driver rather
than disk reads. I found that confusing. Maybe
"VIRTIO_BLK_T_ZONE_REPORT transfer data from the device"?

> +VIRTIO_BLK_T_ZONE_APPEND are writes. VIRTIO_BLK_T_ZONE_OPEN,
> +VIRTIO_BLK_T_ZONE_CLOSE, VIRTIO_BLK_T_ZONE_FINISH and VIRTIO_BLK_T_ZONE_=
RESET
> +are non-data requests.
> +
> +In ZBD standards, the VIRTIO_BLK_T_ZONE_REPORT request belongs to "Zone

"ZBD standards" is not defined. I think this refers to the zoned
storage device model and its embodiment in the ZBC/ZNS specs.
The configuration space fields already allow the driver to calculate
the total number of zones. What is the purpose of partial=3D0, it
doesn't seem to provide any new information?

When the device marks a virtqueue buffer used, it indicates the number
of bytes written (struct virtq_used_elem's len field). The driver can
use this field to determine the number of descriptors filled in by the
device. Is the nr_zones field really necessary?


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
> +Zones with VIRTIO_BLK_ZT_SWR (Sequential Write Required or SWR) can be r=
ead
> +randomly, but MUST be written sequentially at a certain point in the zon=
e called
> +the Write Pointer (WP). With every write, the Write Pointer is increment=
ed by
> +the number of sectors written.
> +
> +Zones with VIRTIO_BLK_ZT_SWP (Sequential Write Preferred or SWP) can be =
read
> +randomly and SHOULD be written sequentially, similarly to SWR zones. How=
ever,
> +SWP zones can accept random write operations, that is, VIRTIO_BLK_T_OUT =
requests
> +with a start sector different from the zone write pointer position.
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
> +Attempts for zone transitions that violate zone resource limits MUST fai=
l with
> +VIRTIO_BLK_S_ZONE_OPEN_RESOURCE or VIRTIO_BLK_S_ZONE_ACTIVE_RESOURCE
> +\field{zone_result}.

Why use zone_result instead of the status field? The _S_ naming
suggests this is a status field constant, not a zone_result constant.


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
> +Zones in the VIRTIO_BLK_ZS_IOPEN (Implicitly Open) state can transition =
=66rom
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
> +Zones in the VIRTIO_BLK_ZS_EOPEN (Explicitly Open) state can transition =
=66rom
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
> +Zones in the VIRTIO_BLK_ZS_CLOSED (Closed) state can transition from thi=
s state
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
> +The device MAY automatically transition zones to VIRTIO_BLK_ZS_RDONLY
> +(Read-Only) or VIRTIO_BLK_ZS_OFFLINE (Offline) state from any other stat=
e. The
> +device MAY also automatically transition zones in the Read-Only state to=
 the
> +Offline state. Zones in the Offline state MAY NOT transition to any othe=
r state.
> +Such automatic transitions usually indicate hardware failures. The previ=
ously
> +written data may only be read from zones in the Read-Only state. Zones i=
n the
> +Offline state can not be read or written.

What is the status code when this is attempted?

--DSsJd/dJ0H8bn7z1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmKYZXoACgkQnKSrs4Gr
c8gNLQf/YPXJDalQNB0732pC0S2TPOIqHmS55pijF6reFHakDf1LkLKtv3MLfXyz
/1fNnBdnsDpeVRoR5rldP8zmV4mnIGyN7Wf5AoFi0nYfe09GD/ll2I7wMH4M5ZXH
Q2/Hgi2NkqKwSdD22veMGqLJPdrgAxpy32VlaEMn8uq2S/b9DYYC4Yel+39WY5gX
28Q0fp3JE1H0IPWUJzbRZiBMy2GDVdibgezc6+tpgajhsl+iFt6O4En7LazDVYTm
YktMy7GvbGV0fZIJr9oEIP8mf+qX/5wKga6IsMw8oSG8FNosN8UI5MFSP2LbHfty
9QfnCQawqk+KS4URvOjbs9MQymgDqA==
=tfAS
-----END PGP SIGNATURE-----

--DSsJd/dJ0H8bn7z1--

