Return-Path: <virtio-dev-return-9846-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8FAD39863A8
	for <virtio-dev@lists.oasis-open.org>; Mon, 29 Aug 2022 14:46:57 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20220829005818.12532-1-dmitry.fomichev@wdc.com>
References: <20220829005818.12532-1-dmitry.fomichev@wdc.com>
Date: Mon, 29 Aug 2022 16:46:50 +0200
Message-ID: <87v8qbds4l.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH v5] virtio-blk: add zoned block device
 specification
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>, virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>, Stefan Hajnoczi <stefanha@gmail.com>, Hannes Reinecke <hare@suse.de>, Matias Bjorling <matias.bjorling@wdc.com>, Niklas Cassel <niklas.cassel@wdc.com>, Hans Holmberg <Hans.Holmberg@wdc.com>, Klaus Jensen <its@irrelevant.dk>, Sam Li <faithilikerun@gmail.com>, Dmitry Fomichev <dmitry.fomichev@wdc.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, Aug 28 2022, Dmitry Fomichev <dmitry.fomichev@wdc.com> wrote:

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
> is not aware of ZBDs but it allows the driver to successfully scan a
> host-managed drive provided by the virtio block device. As the result,
> the host-managed drive is recognized by virtio driver as a regular,
> non-zoned drive that will operate erroneously under the most common
> write workloads. Host-aware ZBDs are currently usable, but their
> performance may not be optimal because the driver can only see them as
> non-zoned block devices.
>
> To fix this, the virtio-blk protocol needs to be extended to add the
> capabilities to convey the zone characteristics of ZBDs at the device
> side to the driver and to provide support for ZBD-specific commands -
> Report Zones, four zone operations (Open, Close, Finish and Reset) and
> (optionally) Zone Append. The proposed standard extension aims to
> define this new functionality.
>
> This patch extends the virtio-blk section of virtio specification with
> the minimum set of requirements that are necessary to support ZBDs.
> The resulting device model is a subset of the models defined in ZAC/ZBC
> and ZNS standards documents. The included functionality mirrors
> the existing Linux kernel block layer ZBD support and should be
> sufficient to handle the host-managed and host-aware HDDs that are on
> the market today as well as ZNS SSDs that are entering the market at
> the time of submission of this patch.
>
> I would like to thank the following people for their useful feedback
> and suggestions while working on the initial iterations of this patch.
>
> Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Matias Bj=C3=B8rling <Matias.Bjorling@wdc.com>
> Niklas Cassel <Niklas.Cassel@wdc.com>
> Hans Holmberg <Hans.Holmberg@wdc.com>
>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/143
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>

(...)

I'm commenting from a more-or-less pure spec point of view; I'll leave
any block-related details to others more familiar with the matter.

> @@ -4589,6 +4596,75 @@ \subsection{Device configuration layout}\label{sec=
:Device Types / Block Device /
>  \field{max_secure_erase_sectors} \field{secure_erase_sector_alignment} a=
re expressed
>  in 512-byte units if the VIRTIO_BLK_F_SECURE_ERASE feature bit is negoti=
ated.
> =20
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

I think you can drop that line, as you define the values below.

> +
> +\begin{lstlisting}
> +#define VIRTIO_BLK_Z_NONE      0
> +#define VIRTIO_BLK_Z_HM        1
> +#define VIRTIO_BLK_Z_HA        2
> +\end{lstlisting}
> +

(...)

> @@ -4701,6 +4790,30 @@ \subsection{Device Initialization}\label{sec:Devic=
e Types / Block Device / Devic
>  The driver MUST NOT read \field{writeback} before setting
>  the FEATURES_OK \field{device status} bit.
> =20
> +Drivers SHOULD NOT negotiate VIRTIO_BLK_F_ZONED feature if they are inca=
pable
> +of supporting devices with the VIRTIO_BLK_Z_HM or VIRTIO_BLK_Z_HA zoned =
model.
> +
> +If the VIRTIO_BLK_F_ZONED feature is offered by the device with the
> +VIRTIO_BLK_Z_HM zone model, then
> +\begin{itemize}
> +\item the VIRTIO_BLK_F_DISCARD feature must not be offered by the driver=
.

s/must not/MUST NOT/

Also, s/driver/device/, I guess? And it needs to go into the device
normative section?

> +
> +\item if the driver sets both VIRTIO_BLK_F_DISCARD and VIRTIO_BLK_F_ZONE=
D
> +    feature bits, the device must fail by not setting FEATURES_OK bit.

Hm, shouldn't the device fail already if the driver wants to negotiate a
feature that it had not offered in the first place? (Also, s/must/MUST/
if we decide to keep it, and needs to go into the device normative
section. The correct terminology would be "the device MUST fail setting
the FEATURES_OK bit.")

> +\end{itemize}

Is it ok for the device to offer both F_DISCARD and F_ZONED with Z_HA or
Z_NONE? In that case, is it ok for the driver to negotiate both
F_DISCARD and F_ZONED, or does it need to pick at most one of them?

> +
> +If the VIRTIO_BLK_F_ZONED feature is negotiated, then
> +\begin{itemize}
> +\item if the driver that can not support host-managed zoned devices
> +    reads VIRTIO_BLK_Z_HM from the \field{model} field of \field{zoned},=
 the
> +    driver MUST NOT set FEATURES_OK flag and instead set the FAILED bit.

[I'll skip commenting on "negotiated" vs "offered", as we need to clarify
that comprehensively in the whole document.]

Could the driver simply reject F_ZONED in that case? The device can
always fail setting FEATURES_OK if the driver does not accept a feature
that is needed. Maybe make this a "SHOULD NOT"?

> +
> +\item if the driver that can not support support zoned devices reads
> +    VIRTIO_BLK_Z_HA from the \field{model} field of \field{zoned}, the d=
river
> +    MAY handle the device as a non-zoned device. In this case, the
> +    driver SHOULD ignore all other fields in \field{zoned}.

I would expect a driver that does not support zoned devices at all to
always reject F_ZONED (including older drivers). Should we mandate that
the driver does not accept F_ZONED if it cannot handle it?

> +\end{itemize}
> +
>  \devicenormative{\subsubsection}{Device Initialization}{Device Types / B=
lock Device / Device Initialization}
> =20
>  Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it
> @@ -4712,6 +4825,74 @@ \subsection{Device Initialization}\label{sec:Devic=
e Types / Block Device / Devic
>  The device MUST initialize padding bytes \field{unused0} and
>  \field{unused1} to 0.
> =20
> +If the device that is being initialized is a not a zoned device, the dev=
ice
> +SHOULD NOT offer the VIRTIO_BLK_F_ZONED feature.
> +
> +If the VIRTIO_BLK_F_ZONED bit is not set by the driver,

If it is not accepted, I guess?

> +\begin{itemize}
> +\item the device with the VIRTIO_BLK_Z_HA zone model SHOULD proceed with=
 the
> +    initialization while setting all zoned characteristics fields to zer=
o.
> +
> +\item the device with the VIRTIO_BLK_Z_HM zone model MUST fail to set th=
e
> +    FEATURES_OK device status bit when the driver writes the Device Stat=
us
> +    field.
> +\end{itemize}
> +
> +If the VIRTIO_BLK_F_ZONED feature is negotiated, then the \field{model} =
field in
> +\field{zoned} struct in the configuration space MUST be set by the devic=
e
> +\begin{itemize}
> +\item to the value of VIRTIO_BLK_Z_NONE if it operates as a drive-manage=
d
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

As this depends on FEATURES_OK a lot, I guess that F_ZONED cannot be
implemented for legacy devices. Do we need to be explicit about that?

> +
>  \subsubsection{Legacy Interface: Device Initialization}\label{sec:Device=
 Types / Block Device / Device Initialization / Legacy Interface: Device In=
itialization}
> =20
>  Because legacy devices do not have FEATURES_OK, transitional devices

(...)

> +The zone descriptor field \field{z_type} \field{virtio_blk_zone_descript=
or}
> +indicates the type of the zone. The available types are VIRTIO_BLK_ZT_CO=
NV(1),
> +VIRTIO_BLK_ZT_SWR(2) or VIRTIO_BLK_ZT_SWP(3).

"The following types are available:" ?

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

"The following zone states are available:" ?

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

(...)

> +The device SHALL report all other error conditions related to zoned bloc=
k model

s/SHALL report/reports/ ? This is outside of a normative section if I'm
not confused.

> +operation by setting the VIRTIO_BLK_S_ZONE_INVALID_CMD value in
> +\field{status} of \field{virtio_blk_req} structure.
> +
>  \drivernormative{\subsubsection}{Device Operation}{Device Types / Block =
Device / Device Operation}
> =20
>  A driver MUST NOT submit a request which would cause a read or write


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

