Return-Path: <virtio-dev-return-9996-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CE92098664A
	for <virtio-dev@lists.oasis-open.org>; Fri, 30 Sep 2022 09:45:23 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <dcd39b0062c4902c75da2456bfc122e87a865230.camel@wdc.com>
References: <20220904165601.170769-1-dmitry.fomichev@wdc.com>
 <dcd39b0062c4902c75da2456bfc122e87a865230.camel@wdc.com>
Date: Fri, 30 Sep 2022 11:45:13 +0200
Message-ID: <87bkqxryae.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v6] virtio-blk: add zoned block device specification
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
Cc: Niklas Cassel <Niklas.Cassel@wdc.com>, "hare@suse.de" <hare@suse.de>, "its@irrelevant.dk" <its@irrelevant.dk>, Matias =?utf-8?Q?Bj=C3=B8rling?= <Matias.Bjorling@wdc.com>, Hans Holmberg <Hans.Holmberg@wdc.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "faithilikerun@gmail.com" <faithilikerun@gmail.com>, "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>, "stefanha@gmail.com" <stefanha@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Sep 20 2022, Dmitry Fomichev <Dmitry.Fomichev@wdc.com> wrote:

> I would like to request the TC vote on the GitHub issue #143 that has bee=
n
> created to track adding zoned block device support to virtio.

Can I get someone more familiar with virtio-blk than me to do a review
for this?

>
> Thank you,
> Dmitry
>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/143
> =20
>
> On Sun, 2022-09-04 at 12:56 -0400, Dmitry Fomichev wrote:
>> Introduce support for Zoned Block Devices to virtio.
>>=20
>> Zoned Block Devices (ZBDs) aim to achieve a better capacity, latency
>> and/or cost characteristics compared to commonly available block
>> devices by getting the entire LBA space of the device divided to block
>> regions that are much larger than the LBA size. These regions are
>> called zones and they can only be written sequentially. More details
>> about ZBDs can be found at
>>=20
>> https://zonedstorage.io/docs/introduction/zoned-storage=C2=A0.
>>=20
>> In its current form, the virtio protocol for block devices (virtio-blk)
>> is not aware of ZBDs but it allows the driver to successfully scan a
>> host-managed drive provided by the virtio block device. As the result,
>> the host-managed drive is recognized by virtio driver as a regular,
>> non-zoned drive that will operate erroneously under the most common
>> write workloads. Host-aware ZBDs are currently usable, but their
>> performance may not be optimal because the driver can only see them as
>> non-zoned block devices.
>>=20
>> To fix this, the virtio-blk protocol needs to be extended to add the
>> capabilities to convey the zone characteristics of ZBDs at the device
>> side to the driver and to provide support for ZBD-specific commands -
>> Report Zones, four zone operations (Open, Close, Finish and Reset) and
>> (optionally) Zone Append. The proposed standard extension aims to
>> define this new functionality.
>>=20
>> This patch extends the virtio-blk section of virtio specification with
>> the minimum set of requirements that are necessary to support ZBDs.
>> The resulting device model is a subset of the models defined in ZAC/ZBC
>> and ZNS standards documents. The included functionality mirrors
>> the existing Linux kernel block layer ZBD support and should be
>> sufficient to handle the host-managed and host-aware HDDs that are on
>> the market today as well as ZNS SSDs that are entering the market at
>> the time of submission of this patch.
>>=20
>> I would like to thank the following people for their useful feedback
>> and suggestions while working on the initial iterations of this patch.
>>=20
>> Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> Matias Bj=C3=B8rling <Matias.Bjorling@wdc.com>
>> Niklas Cassel <Niklas.Cassel@wdc.com>
>> Hans Holmberg <Hans.Holmberg@wdc.com>
>>=20
>> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/143
>> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
>> ---
>>=20
>> v5 -> v6:
>>=20
>> Address review comments from Cornelia Huck:
>>=20
>> =C2=A0- add a clause to disallow VIRTIO_BLK_F_ZONED feature to be offere=
d by
>> =C2=A0=C2=A0 legacy devices
>>=20
>> =C2=A0- clarify VIRTIO_BLK_F_DISCARD negotiation procedure for zoned dev=
ices
>>=20
>> =C2=A0- simplify definitions of constant values that are specific to zon=
ed
>> =C2=A0=C2=A0 devices
>>=20
>> =C2=A0- editorial changes
>>=20
>> v4 -> v5:
>>=20
>> Add Fixes tag pointing to the corresponding GitHub issue.
>>=20
>> Improve the patch changelog.
>>=20
>> v3 -> v4:
>>=20
>> Address additional feedback from Stefan:
>>=20
>> =C2=A0- align the append sector field to 8 bytes instead of 4
>>=20
>> =C2=A0- define "zone sector address" in the non-normative section and us=
e
>> =C2=A0=C2=A0 this term in the text in a consistent way. Make sure it is =
clear
>> =C2=A0=C2=A0 that the value is in bytes.
>>=20
>> =C2=A0- move portions of VIRTIO_BLK_T_ZONE_REPORT description to the
>> =C2=A0=C2=A0 non-normative section
>>=20
>> =C2=A0- clarify the wording about reading of unwritten data
>>=20
>> =C2=A0- editorial changes
>>=20
>> v2 -> v3:
>>=20
>> A few changes made as the result of off-list discussions with Stefan,
>> Damien and Hannes:
>>=20
>> =C2=A0- drop virtblk_zoned_req for zoned devices and define a union for
>> =C2=A0=C2=A0 virtio request in header that is specific to ZONE APPEND re=
quest
>>=20
>> =C2=A0- drop support for ALL bit in all zone operations except for RESET
>> =C2=A0=C2=A0 ZONE. For this zone management operation, define a new requ=
est type,
>> =C2=A0=C2=A0 VIRTIO_BLK_T_ZONE_RESET_ALL. This way, the zone management =
out
>> =C2=A0=C2=A0 request header is no longer necessary
>>=20
>> =C2=A0- editorial changes
>>=20
>> v1 -> v2:
>>=20
>> Address Stefan's review comments:
>>=20
>> =C2=A0- move normative clauses to normative sections
>>=20
>> =C2=A0- remove the "partial" bit in zone report
>>=20
>> =C2=A0- change layout of virtio_blk_zoned_req. The "all" flag becomes a =
bit
>> =C2=A0=C2=A0 in "zone" bit field struct. This leaves 31 bits for potenti=
al future
>> =C2=A0=C2=A0 extensions. Move the status byte to be the last one in the =
struct
>>=20
>> =C2=A0- set ZBD-specific error codes in the status field, not in
>> =C2=A0=C2=A0 "zoned_result" field. The former "zoned_result" member now =
becomes
>> =C2=A0=C2=A0 "append_sector"
>>=20
>> =C2=A0- make a few editorial changes
>> ---
>> =C2=A0content.tex | 667 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
>> =C2=A01 file changed, 665 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/content.tex b/content.tex
>> index 7508dd1..bbc52ad 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -4557,6 +4557,13 @@ \subsection{Feature bits}\label{sec:Device Types =
/ Block
>> Device / Feature bits}
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maximum erase sectors count in \field{max=
_secure_erase_sectors} and
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maximum erase segment number in \field{ma=
x_secure_erase_seg}.
>> =C2=A0
>> +\item[VIRTIO_BLK_F_ZONED(17)] Device is a Zoned Block Device, that is, =
a
>> device
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0that follows the zoned storag=
e device behavior that is also supported
>> by
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0industry standards such as th=
e T10 Zoned Block Command standard (ZBC
>> r05) or
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0the NVMe(TM) NVM Express Zone=
d Namespace Command Set Specification 1.1b
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(ZNS). For brevity, these sta=
ndard documents are referred as "ZBD
>> standards"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from this point on in the tex=
t.
>> +
>> =C2=A0\end{description}
>> =C2=A0
>> =C2=A0\subsubsection{Legacy Interface: Feature bits}\label{sec:Device Ty=
pes / Block
>> Device / Feature bits / Legacy Interface: Feature bits}
>> @@ -4572,6 +4579,11 @@ \subsubsection{Legacy Interface: Feature
>> bits}\label{sec:Device Types / Block De
>> =C2=A0=C2=A0 called VIRTIO_BLK_F_WCE.
>> =C2=A0\end{note}
>> =C2=A0
>> +\begin{note}
>> +=C2=A0 VIRTIO_BLK_F_ZONED feature cannot be properly negotiated without=
 FEATURES_OK
>> +=C2=A0 bit. Legacy devices MUST NOT offer VIRTIO_BLK_F_ZONED feature bi=
t.
>> +\end{note}
>> +
>> =C2=A0\subsection{Device configuration layout}\label{sec:Device Types / =
Block Device
>> / Device configuration layout}
>> =C2=A0
>> =C2=A0The \field{capacity} of the device (expressed in 512-byte sectors)=
 is always
>> @@ -4589,6 +4601,74 @@ \subsection{Device configuration
>> layout}\label{sec:Device Types / Block Device /
>> =C2=A0\field{max_secure_erase_sectors} \field{secure_erase_sector_alignm=
ent} are
>> expressed
>> =C2=A0in 512-byte units if the VIRTIO_BLK_F_SECURE_ERASE feature bit is =
negotiated.
>> =C2=A0
>> +If the VIRTIO_BLK_F_ZONED feature is negotiated, then in
>> +\field{virtio_blk_zoned_characteristics},
>> +\begin{itemize}
>> +\item \field{zone_sectors} value is expressed in 512-byte sectors.
>> +\item \field{max_append_sectors} value is expressed in 512-byte sectors=
.
>> +\item \field{write_granularity} value is expressed in bytes.
>> +\end{itemize}
>> +
>> +The \field{model} field in \field{zoned} may have the following values:
>> +
>> +\begin{lstlisting}
>> +#define VIRTIO_BLK_Z_NONE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>> +#define VIRTIO_BLK_Z_HM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1
>> +#define VIRTIO_BLK_Z_HA=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2
>> +\end{lstlisting}
>> +
>> +Depending on their design, zoned block devices may follow several possi=
ble
>> +models of operation. The three models that are standardized for ZBDs ar=
e
>> +drive-managed, host-managed and host-aware.
>> +
>> +While being zoned internally, drive-managed ZBDs behave exactly like re=
gular,
>> +non-zoned block devices. For the purposes of virtio standardization,
>> +drive-managed ZBDs can always be treated as non-zoned devices. These de=
vices
>> +have the VIRTIO_BLK_Z_NONE model value set in the \field{model} field i=
n
>> +\field{zoned}.
>> +
>> +Devices that offer VIRTIO_BLK_F_ZONED feature while reporting
>> VIRTIO_BLK_Z_NONE
>> +zoned model commonly do so for testing and development purposes.
>> +
>> +Host-managed zoned block devices have their LBA range divided to Sequen=
tial
>> +Write Required (SWR) zones that require some additional handling from t=
he host
>> +for sustainable operation. All write requests to SWR zones must be sequ=
ential
>> +and the zones with some data need to be reset before that data can be
>> rewritten.
>> +Host-managed devices support a set of ZBD-specific I/O requests that ca=
n be
>> used
>> +by the host to manage device zones. Host-managed devices report
>> VIRTIO_BLK_Z_HM
>> +in the \field{model} field in \field{zoned}.
>> +
>> +Host-aware zoned block devices have their LBA range divided to Sequenti=
al
>> +Write Preferred (SWP) zones that support the random write access, simil=
ar to
>> +regular non-zoned devices. However, the device I/O performance might no=
t be
>> +optimal if SWP zones are used in a random I/O pattern. SWP zones also s=
upport
>> +the same set of ZBD-specific I/O requests as host-managed devices that =
allow
>> +host-aware devices to be managed by any host that supports zoned block =
devices
>> +to achieve its optimum performance. Host-aware devices report VIRTIO_BL=
K_Z_HA
>> +in the \field{model} field in \field{zoned}.
>> +
>> +Both SWR zones and SWP zones are sometimes referred as sequential zones=
.
>> +
>> +During device operation, sequential zones can be in one of the followin=
g
>> states:
>> +empty, implicitly-open, explicitly-open, closed and full. The state mac=
hine
>> that
>> +governs the transitions between these states is described later in this
>> document.
>> +
>> +SWR and SWP zones consume volatile device resources while being in cert=
ain
>> +states and the device may set limits on the number of zones that can be=
 in
>> these
>> +states simultaneously.
>> +
>> +Zoned block devices use two internal counters to account for the device
>> +resources in use, the number of currently open zones and the number of
>> currently
>> +active zones.
>> +
>> +Any zone state transition from a state that doesn't consume a zone reso=
urce to
>> a
>> +state that consumes the same resource increments the internal device co=
unter
>> for
>> +that resource. Any zone transition out of a state that consumes a zone
>> resource
>> +to a state that doesn't consume the same resource decrements the counte=
r. Any
>> +request that causes the device to exceed the reported zone resource lim=
its is
>> +terminated by the device with a "zone resources exceeded" error as defi=
ned for
>> +specific commands later.
>> +
>> =C2=A0\begin{lstlisting}
>> =C2=A0struct virtio_blk_config {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le64 capacity;
>> @@ -4623,6 +4703,15 @@ \subsection{Device configuration
>> layout}\label{sec:Device Types / Block Device /
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le32 max_secure_erase_s=
ectors;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le32 max_secure_erase_s=
eg;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le32 secure_erase_secto=
r_alignment;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct virtio_blk_zoned_char=
acteristics {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 le32 zone_sectors;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 le32 max_open_zones;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 le32 max_active_zones;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 le32 max_append_sectors;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 le32 write_granularity;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 u8 model;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 u8 unused2[3];
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } zoned;
>> =C2=A0};
>> =C2=A0\end{lstlisting}
>> =C2=A0
>> @@ -4686,6 +4775,10 @@ \subsection{Device Initialization}\label{sec:Devi=
ce
>> Types / Block Device / Devic
>> =C2=A0=C2=A0=C2=A0=C2=A0 \field{secure_erase_sector_alignment} can be us=
ed by OS when splitting a
>> =C2=A0=C2=A0=C2=A0=C2=A0 request based on alignment.
>> =C2=A0
>> +\item If the VIRTIO_BLK_F_ZONED feature is negotiated, the fields in
>> +=C2=A0=C2=A0=C2=A0 \field{zoned} can be read by the driver to determine=
 the zone
>> +=C2=A0=C2=A0=C2=A0 characteristics of the device. All \field{zoned} fie=
lds are read-only.
>> +
>> =C2=A0\end{enumerate}
>> =C2=A0
>> =C2=A0\drivernormative{\subsubsection}{Device Initialization}{Device Typ=
es / Block
>> Device / Device Initialization}
>> @@ -4701,6 +4794,29 @@ \subsection{Device Initialization}\label{sec:Devi=
ce
>> Types / Block Device / Devic
>> =C2=A0The driver MUST NOT read \field{writeback} before setting
>> =C2=A0the FEATURES_OK \field{device status} bit.
>> =C2=A0
>> +Drivers SHOULD NOT negotiate VIRTIO_BLK_F_ZONED feature if they are inc=
apable
>> +of supporting devices with the VIRTIO_BLK_Z_HM or VIRTIO_BLK_Z_HA zoned=
 model.
>> +
>> +If the VIRTIO_BLK_F_ZONED feature is offered by the device with the
>> +VIRTIO_BLK_Z_HM zone model, then the VIRTIO_BLK_F_DISCARD feature MUST =
NOT be
>> +offered by the driver.
>> +
>> +If the VIRTIO_BLK_F_ZONED feature and VIRTIO_BLK_F_DISCARD feature are =
both
>> +offered by the device with the VIRTIO_BLK_Z_HA or VIRTIO_BLK_Z_NONE zon=
e
>> model,
>> +then the driver MAY negotiate these two bits independently.
>> +
>> +If the VIRTIO_BLK_F_ZONED feature is negotiated, then
>> +\begin{itemize}
>> +\item if the driver that can not support host-managed zoned devices
>> +=C2=A0=C2=A0=C2=A0 reads VIRTIO_BLK_Z_HM from the \field{model} field o=
f \field{zoned}, the
>> +=C2=A0=C2=A0=C2=A0 driver MUST NOT set FEATURES_OK flag and instead set=
 the FAILED bit.
>> +
>> +\item if the driver that can not support zoned devices reads VIRTIO_BLK=
_Z_HA
>> +=C2=A0=C2=A0=C2=A0 from the \field{model} field of \field{zoned}, the d=
river
>> +=C2=A0=C2=A0=C2=A0 MAY handle the device as a non-zoned device. In this=
 case, the
>> +=C2=A0=C2=A0=C2=A0 driver SHOULD ignore all other fields in \field{zone=
d}.
>> +\end{itemize}
>> +
>> =C2=A0\devicenormative{\subsubsection}{Device Initialization}{Device Typ=
es / Block
>> Device / Device Initialization}
>> =C2=A0
>> =C2=A0Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it
>> @@ -4712,6 +4828,74 @@ \subsection{Device Initialization}\label{sec:Devi=
ce
>> Types / Block Device / Devic
>> =C2=A0The device MUST initialize padding bytes \field{unused0} and
>> =C2=A0\field{unused1} to 0.
>> =C2=A0
>> +If the device that is being initialized is a not a zoned device, the de=
vice
>> +SHOULD NOT offer the VIRTIO_BLK_F_ZONED feature.
>> +
>> +If the VIRTIO_BLK_F_ZONED feature is not accepted by the driver,
>> +\begin{itemize}
>> +\item the device with the VIRTIO_BLK_Z_HA zone model SHOULD proceed wit=
h the
>> +=C2=A0=C2=A0=C2=A0 initialization while setting all zoned characteristi=
cs fields to zero.
>> +
>> +\item the device with the VIRTIO_BLK_Z_HM zone model MUST fail to set t=
he
>> +=C2=A0=C2=A0=C2=A0 FEATURES_OK device status bit when the driver writes=
 the Device Status
>> +=C2=A0=C2=A0=C2=A0 field.
>> +\end{itemize}
>> +
>> +If the VIRTIO_BLK_F_ZONED feature is negotiated, then the \field{model}=
 field
>> in
>> +\field{zoned} struct in the configuration space MUST be set by the devi=
ce
>> +\begin{itemize}
>> +\item to the value of VIRTIO_BLK_Z_NONE if it operates as a drive-manag=
ed
>> +=C2=A0=C2=A0=C2=A0 zoned block device or a non-zoned block device.
>> +
>> +\item to the value of VIRTIO_BLK_Z_HM if it operates as a host-managed =
zoned
>> +=C2=A0=C2=A0=C2=A0 block device.
>> +
>> +\item to the value of VIRTIO_BLK_Z_HA if it operates as a host-aware zo=
ned
>> +=C2=A0=C2=A0=C2=A0 block device.
>> +\end{itemize}
>> +
>> +If the VIRTIO_BLK_F_ZONED feature is negotiated,
>> +\begin{itemize}
>> +\item the \field{zone_sectors} field of \field{zoned} MUST be set by th=
e
>> device
>> +=C2=A0=C2=A0=C2=A0 to the size of a single zone on the device. All zone=
s of the device have
>> the
>> +=C2=A0=C2=A0=C2=A0 same size indicated by \field{zone_sectors} except f=
or the last zone that
>> +=C2=A0=C2=A0=C2=A0 MAY be smaller than all other zones. The driver can =
calculate the number
>> of
>> +=C2=A0=C2=A0=C2=A0 zones on the device as
>> +=C2=A0=C2=A0=C2=A0 \begin{lstlisting}
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nr_zones =3D (capacity + zon=
e_sectors - 1) / zone_sectors;
>> +=C2=A0=C2=A0=C2=A0 \end{lstlisting}
>> +=C2=A0=C2=A0=C2=A0 and the size of the last zone as
>> +=C2=A0=C2=A0=C2=A0 \begin{lstlisting}
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zs_last =3D capacity - (nr_z=
ones - 1) * zone_sectors;
>> +=C2=A0=C2=A0=C2=A0 \end{lstlisting}
>> +
>> +\item The \field{max_open_zones} field of the \field{zoned} structure M=
UST be
>> +=C2=A0=C2=A0=C2=A0 set by the device to the maximum number of zones tha=
t can be open on the
>> +=C2=A0=C2=A0=C2=A0 device (zones in the implicit open or explicit open =
state). A value
>> +=C2=A0=C2=A0=C2=A0 of zero indicates that the device does not have any =
limit on the number of
>> +=C2=A0=C2=A0=C2=A0 open zones.
>> +
>> +\item The \field{max_active_zones} field of the \field{zoned} structure=
 MUST
>> +=C2=A0=C2=A0=C2=A0 be set by the device to the maximum number zones tha=
t can be active on the
>> +=C2=A0=C2=A0=C2=A0 device (zones in the implicit open, explicit open or=
 closed state). A
>> value
>> +=C2=A0=C2=A0=C2=A0 of zero indicates that the device does not have any =
limit on the number of
>> +=C2=A0=C2=A0=C2=A0 active zones.
>> +
>> +\item the \field{max_append_sectors} field of \field{zoned} MUST be set=
 by
>> +=C2=A0=C2=A0=C2=A0 the device to the maximum data size of a VIRTIO_BLK_=
T_ZONE_APPEND request
>> +=C2=A0=C2=A0=C2=A0 that can be successfully issued to the device. The v=
alue of this field
>> MUST
>> +=C2=A0=C2=A0=C2=A0 NOT exceed the \field{seg_max} * \field{size_max} va=
lue. A device MAY set
>> +=C2=A0=C2=A0=C2=A0 the \field{max_append_sectors} to zero if it doesn't=
 support
>> +=C2=A0=C2=A0=C2=A0 VIRTIO_BLK_T_ZONE_APPEND requests.
>> +
>> +\item the \field{write_granularity} field of \field{zoned} MUST be set =
by the
>> +=C2=A0=C2=A0=C2=A0 device to the offset and size alignment constraint f=
or VIRTIO_BLK_T_OUT
>> +=C2=A0=C2=A0=C2=A0 and VIRTIO_BLK_T_ZONE_APPEND requests issued to a se=
quential zone of the
>> +=C2=A0=C2=A0=C2=A0 device.
>> +
>> +\item the device MUST initialize padding bytes \field{unused2} to 0.
>> +\end{itemize}
>> +
>> =C2=A0\subsubsection{Legacy Interface: Device Initialization}\label{sec:=
Device Types
>> / Block Device / Device Initialization / Legacy Interface: Device
>> Initialization}
>> =C2=A0
>> =C2=A0Because legacy devices do not have FEATURES_OK, transitional devic=
es
>> @@ -4746,7 +4930,15 @@ \subsection{Device Operation}\label{sec:Device Ty=
pes /
>> Block Device / Device Ope
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le32 reserved;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le64 sector;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 data[];
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 status;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 union {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 u8 status;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 struct {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 st=
atus;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 re=
served[7];
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le64 =
append_sector;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 } zone_append_in_hdr;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>> =C2=A0};
>> =C2=A0\end{lstlisting}
>> =C2=A0
>> @@ -4770,7 +4962,7 @@ \subsection{Device Operation}\label{sec:Device Typ=
es /
>> Block Device / Device Ope
>> =C2=A0
>> =C2=A0The \field{sector} number indicates the offset (multiplied by 512)=
 where
>> =C2=A0the read or write is to occur. This field is unused and set to 0 f=
or
>> -commands other than read or write.
>> +commands other than read, write and some zone operations.
>> =C2=A0
>> =C2=A0VIRTIO_BLK_T_IN requests populate \field{data} with the contents o=
f sectors
>> =C2=A0read from the block device (in multiples of 512 bytes).=C2=A0 VIRT=
IO_BLK_T_OUT
>> @@ -4853,6 +5045,299 @@ \subsection{Device Operation}\label{sec:Device T=
ypes /
>> Block Device / Device Ope
>> =C2=A0command produces VIRTIO_BLK_S_IOERR.=C2=A0 A segment may have comp=
leted
>> =C2=A0successfully, failed, or not been processed by the device.
>> =C2=A0
>> +The following requirements only apply if the VIRTIO_BLK_F_ZONED feature=
 is
>> +negotiated.
>> +
>> +In addition to the request types defined for non-zoned devices, the typ=
e of
>> the
>> +request can be a zone report (VIRTIO_BLK_T_ZONE_REPORT), an explicit zo=
ne open
>> +(VIRTIO_BLK_T_ZONE_OPEN), an explicit zone close (VIRTIO_BLK_T_ZONE_CLO=
SE), a
>> +zone finish (VIRTIO_BLK_T_ZONE_FINISH), a zone_append
>> +(VIRTIO_BLK_T_ZONE_APPEND), a zone reset (VIRTIO_BLK_T_ZONE_RESET) or a=
 zone
>> +reset all (VIRTIO_BLK_T_ZONE_RESET_ALL).
>> +
>> +\begin{lstlisting}
>> +#define VIRTIO_BLK_T_ZONE_APPEND=C2=A0=C2=A0=C2=A0 15
>> +#define VIRTIO_BLK_T_ZONE_REPORT=C2=A0=C2=A0=C2=A0 16
>> +#define VIRTIO_BLK_T_ZONE_OPEN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 18
>> +#define VIRTIO_BLK_T_ZONE_CLOSE=C2=A0=C2=A0=C2=A0=C2=A0 20
>> +#define VIRTIO_BLK_T_ZONE_FINISH=C2=A0=C2=A0=C2=A0 22
>> +#define VIRTIO_BLK_T_ZONE_RESET=C2=A0=C2=A0=C2=A0=C2=A0 24
>> +#define VIRTIO_BLK_T_ZONE_RESET_ALL 26
>> +\end{lstlisting}
>> +
>> +Requests of type VIRTIO_BLK_T_OUT, VIRTIO_BLK_T_ZONE_OPEN,
>> +VIRTIO_BLK_T_ZONE_CLOSE, VIRTIO_BLK_T_ZONE_FINISH, VIRTIO_BLK_T_ZONE_AP=
PEND,
>> +VIRTIO_BLK_T_ZONE_RESET or VIRTIO_BLK_T_ZONE_RESET_ALL may be completed=
 by the
>> +device with VIRTIO_BLK_S_OK, VIRTIO_BLK_S_IOERR or VIRTIO_BLK_S_UNSUPP
>> +\field{status}, or, additionally, with=C2=A0 VIRTIO_BLK_S_ZONE_INVALID_=
CMD,
>> +VIRTIO_BLK_S_ZONE_UNALIGNED_WP, VIRTIO_BLK_S_ZONE_OPEN_RESOURCE or
>> +VIRTIO_BLK_S_ZONE_ACTIVE_RESOURCE ZBD-specific status codes.
>> +
>> +\begin{lstlisting}
>> +#define VIRTIO_BLK_S_ZONE_INVALID_CMD=C2=A0=C2=A0=C2=A0=C2=A0 3
>> +#define VIRTIO_BLK_S_ZONE_UNALIGNED_WP=C2=A0=C2=A0=C2=A0 4
>> +#define VIRTIO_BLK_S_ZONE_OPEN_RESOURCE=C2=A0=C2=A0 5
>> +#define VIRTIO_BLK_S_ZONE_ACTIVE_RESOURCE 6
>> +\end{lstlisting}
>> +
>> +Requests of the type VIRTIO_BLK_T_ZONE_REPORT are reads and requests of=
 the
>> type
>> +VIRTIO_BLK_T_ZONE_APPEND are writes. VIRTIO_BLK_T_ZONE_OPEN,
>> +VIRTIO_BLK_T_ZONE_CLOSE, VIRTIO_BLK_T_ZONE_FINISH, VIRTIO_BLK_T_ZONE_RE=
SET and
>> +VIRTIO_BLK_T_ZONE_RESET_ALL are non-data requests.
>> +
>> +Zone sector address is a 64-bit address of the first 512-byte sector of=
 the
>> +zone.
>> +
>> +VIRTIO_BLK_T_ZONE_OPEN, VIRTIO_BLK_T_ZONE_CLOSE, VIRTIO_BLK_T_ZONE_FINI=
SH and
>> +VIRTIO_BLK_T_ZONE_RESET requests make the zone operation to act on a
>> particular
>> +zone specified by the zone sector address in the \field{sector} of the
>> request.
>> +
>> +VIRTIO_BLK_T_ZONE_RESET_ALL request acts upon all applicable zones of t=
he
>> +device. The \field{sector} value is not used for this request.
>> +
>> +In ZBD standards, the VIRTIO_BLK_T_ZONE_REPORT request belongs to "Zone
>> +Management Receive" command category and VIRTIO_BLK_T_ZONE_OPEN,
>> +VIRTIO_BLK_T_ZONE_CLOSE, VIRTIO_BLK_T_ZONE_FINISH and
>> +VIRTIO_BLK_T_ZONE_RESET/VIRTIO_BLK_T_ZONE_RESET_ALL requests are catego=
rized
>> as
>> +"Zone Management Send" commands. VIRTIO_BLK_T_ZONE_APPEND is categorize=
d
>> +separately from the zone management commands and is the only request th=
at uses
>> +\field{zone_append_in_hdr} structure in \field{virtio_blk_req} to retur=
n
>> +to the driver the sector at which the data has been appended to the zon=
e.
>> +
>> +VIRTIO_BLK_T_ZONE_REPORT is a read request that returns the information=
 about
>> +the current state of zones on the device starting from the zone contain=
ing the
>> +\field{sector} of the request. The report consists of a header followed=
 by
>> zero
>> +or more zone descriptors.
>> +
>> +A zone report reply has the following structure:
>> +
>> +\begin{lstlisting}
>> +struct virtio_blk_zone_report {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le64=C2=A0=C2=A0 nr_zones;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0 r=
eserved[56];
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct virtio_blk_zone_descr=
iptor zones[];
>> +};
>> +\end{lstlisting}
>> +
>> +The device sets the \field{nr_zones} field in the report header to the =
number
>> of
>> +fully transferred zone descriptors in the data buffer.
>> +
>> +A zone descriptor has the following structure:
>> +
>> +\begin{lstlisting}
>> +struct virtio_blk_zone_descriptor {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le64=C2=A0=C2=A0 z_cap;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le64=C2=A0=C2=A0 z_start;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le64=C2=A0=C2=A0 z_wp;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0 z=
_type;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0 z=
_state;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0 r=
eserved[38];
>> +};
>> +\end{lstlisting}
>> +
>> +The zone descriptor field \field{z_type} \field{virtio_blk_zone_descrip=
tor}
>> +indicates the type of the zone.
>> +
>> +The following zone types are available:
>> +
>> +\begin{lstlisting}
>> +#define VIRTIO_BLK_ZT_CONV=C2=A0=C2=A0=C2=A0=C2=A0 1
>> +#define VIRTIO_BLK_ZT_SWR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2
>> +#define VIRTIO_BLK_ZT_SWP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3
>> +\end{lstlisting}
>> +
>> +Read and write operations into zones with the VIRTIO_BLK_ZT_CONV
>> (Conventional)
>> +type have the same behavior as read and write operations on a regular b=
lock
>> +device. Any block in a conventional zone can be read or written at any =
time
>> and
>> +in any order.
>> +
>> +Zones with VIRTIO_BLK_ZT_SWR can be read randomly, but must be written
>> +sequentially at a certain point in the zone called the Write Pointer (W=
P).
>> With
>> +every write, the Write Pointer is incremented by the number of sectors
>> written.
>> +
>> +Zones with VIRTIO_BLK_ZT_SWP can be read randomly and should be written
>> +sequentially, similarly to SWR zones. However, SWP zones can accept ran=
dom
>> write
>> +operations, that is, VIRTIO_BLK_T_OUT requests with a start sector diff=
erent
>> +from the zone write pointer position.
>> +
>> +The field \field{z_state} of \field{virtio_blk_zone_descriptor} indicat=
es the
>> +state of the device zone.
>> +
>> +The following zone states are available:
>> +
>> +\begin{lstlisting}
>> +#define VIRTIO_BLK_ZS_NOT_WP=C2=A0=C2=A0 0
>> +#define VIRTIO_BLK_ZS_EMPTY=C2=A0=C2=A0=C2=A0 1
>> +#define VIRTIO_BLK_ZS_IOPEN=C2=A0=C2=A0=C2=A0 2
>> +#define VIRTIO_BLK_ZS_EOPEN=C2=A0=C2=A0=C2=A0 3
>> +#define VIRTIO_BLK_ZS_CLOSED=C2=A0=C2=A0 4
>> +#define VIRTIO_BLK_ZS_RDONLY=C2=A0=C2=A0 13
>> +#define VIRTIO_BLK_ZS_FULL=C2=A0=C2=A0=C2=A0=C2=A0 14
>> +#define VIRTIO_BLK_ZS_OFFLINE=C2=A0 15
>> +\end{lstlisting}
>> +
>> +Zones of the type VIRTIO_BLK_ZT_CONV are always reported by the device =
to be
>> in
>> +the VIRTIO_BLK_ZS_NOT_WP state. Zones of the types VIRTIO_BLK_ZT_SWR an=
d
>> +VIRTIO_BLK_ZT_SWP can not transition to the VIRTIO_BLK_ZS_NOT_WP state.
>> +
>> +Zones in VIRTIO_BLK_ZS_EMPTY (Empty), VIRTIO_BLK_ZS_IOPEN (Implicitly O=
pen),
>> +VIRTIO_BLK_ZS_EOPEN (Explicitly Open) and VIRTIO_BLK_ZS_CLOSED (Closed)=
 state
>> +are writable, but zones in VIRTIO_BLK_ZS_RDONLY (Read-Only),
>> VIRTIO_BLK_ZS_FULL
>> +(Full) and VIRTIO_BLK_ZS_OFFLINE (Offline) state are not. The write poi=
nter
>> +value (\field{z_wp}) is not valid for Read-Only, Full and Offline zones=
.
>> +
>> +The zone descriptor field \field{z_cap} contains the maximum number of =
512-
>> byte
>> +sectors that are available to be written with user data when the zone i=
s in
>> the
>> +Empty state. This value shall be less than or equal to the
>> \field{zone_sectors}
>> +value in \field{virtio_blk_zoned_characteristics} structure in the devi=
ce
>> +configuration space.
>> +
>> +The zone descriptor field \field{z_start} contains the zone sector addr=
ess.
>> +
>> +The zone descriptor field \field{z_wp} contains the sector address wher=
e the
>> +next write operation for this zone should be issued. This value is unde=
fined
>> +for conventional zones and for zones in VIRTIO_BLK_ZS_RDONLY,
>> +VIRTIO_BLK_ZS_FULL and VIRTIO_BLK_ZS_OFFLINE state.
>> +
>> +Depending on their state, zones consume resources as follows:
>> +\begin{itemize}
>> +\item a zone in VIRTIO_BLK_ZS_IOPEN and VIRTIO_BLK_ZS_EOPEN state consu=
mes one
>> +=C2=A0=C2=A0=C2=A0 open zone resource and, additionally,
>> +
>> +\item a zone in VIRTIO_BLK_ZS_IOPEN, VIRTIO_BLK_ZS_EOPEN and
>> +=C2=A0=C2=A0=C2=A0 VIRTIO_BLK_ZS_CLOSED state consumes one active resou=
rce.
>> +\end{itemize}
>> +
>> +Attempts for zone transitions that violate zone resource limits must fa=
il with
>> +VIRTIO_BLK_S_ZONE_OPEN_RESOURCE or VIRTIO_BLK_S_ZONE_ACTIVE_RESOURCE
>> +\field{status}.
>> +
>> +Zones in the VIRTIO_BLK_ZS_EMPTY (Empty) state have the write pointer v=
alue
>> +equal to the sector address of the zone. In this state, the entire capa=
city of
>> +the zone is available for writing. A zone can transition from this stat=
e to
>> +\begin{itemize}
>> +\item VIRTIO_BLK_ZS_IOPEN when a successful VIRTIO_BLK_T_OUT request or
>> +=C2=A0=C2=A0=C2=A0 VIRTIO_BLK_T_ZONE_APPEND with a non-zero data size i=
s received for the
>> zone.
>> +
>> +\item VIRTIO_BLK_ZS_EOPEN when a successful VIRTIO_BLK_T_ZONE_OPEN requ=
est is
>> +=C2=A0=C2=A0=C2=A0 received for the zone
>> +\end{itemize}
>> +
>> +When a VIRTIO_BLK_T_ZONE_RESET request is issued to an Empty zone, the =
request
>> +is completed successfully and the zone stays in the VIRTIO_BLK_ZS_EMPTY=
 state.
>> +
>> +Zones in the VIRTIO_BLK_ZS_IOPEN (Implicitly Open) state transition fro=
m
>> +this state to
>> +\begin{itemize}
>> +\item VIRTIO_BLK_ZS_EMPTY when a successful VIRTIO_BLK_T_ZONE_RESET req=
uest is
>> +=C2=A0=C2=A0=C2=A0 received for the zone,
>> +
>> +\item VIRTIO_BLK_ZS_EOPEN when a successful VIRTIO_BLK_T_ZONE_OPEN requ=
est is
>> +=C2=A0=C2=A0=C2=A0 received for the zone,
>> +
>> +\item VIRTIO_BLK_ZS_CLOSED when a successful VIRTIO_BLK_T_ZONE_CLOSE re=
quest
>> is
>> +=C2=A0=C2=A0=C2=A0 received for the zone,
>> +
>> +\item VIRTIO_BLK_ZS_CLOSED implicitly by the device when another zone i=
s
>> +=C2=A0=C2=A0=C2=A0 entering the VIRTIO_BLK_ZS_IOPEN or VIRTIO_BLK_ZS_EO=
PEN state and the
>> number
>> +=C2=A0=C2=A0=C2=A0 of currently open zones is at \field{max_open_zones}=
 limit,
>> +
>> +\item VIRTIO_BLK_ZS_FULL when a successful VIRTIO_BLK_T_ZONE_FINISH req=
uest is
>> +=C2=A0=C2=A0=C2=A0 received for the zone.
>> +
>> +\item VIRTIO_BLK_ZS_FULL when a successful VIRTIO_BLK_T_OUT or
>> +=C2=A0=C2=A0=C2=A0 VIRTIO_BLK_T_ZONE_APPEND request that causes the zon=
e to reach its
>> writable
>> +=C2=A0=C2=A0=C2=A0 capacity is received for the zone.
>> +\end{itemize}
>> +
>> +Zones in the VIRTIO_BLK_ZS_EOPEN (Explicitly Open) state transition fro=
m
>> +this state to
>> +\begin{itemize}
>> +\item VIRTIO_BLK_ZS_EMPTY when a successful VIRTIO_BLK_T_ZONE_RESET req=
uest is
>> +=C2=A0=C2=A0=C2=A0 received for the zone,
>> +
>> +\item VIRTIO_BLK_ZS_EMPTY when a successful VIRTIO_BLK_T_ZONE_CLOSE req=
uest is
>> +=C2=A0=C2=A0=C2=A0 received for the zone and the write pointer of the z=
one has the value
>> equal
>> +=C2=A0=C2=A0=C2=A0 to the start sector of the zone,
>> +
>> +\item VIRTIO_BLK_ZS_CLOSED when a successful VIRTIO_BLK_T_ZONE_CLOSE re=
quest
>> is
>> +=C2=A0=C2=A0=C2=A0 received for the zone and the zone write pointer is =
larger then the start
>> +=C2=A0=C2=A0=C2=A0 sector of the zone,
>> +
>> +\item VIRTIO_BLK_ZS_FULL when a successful VIRTIO_BLK_T_ZONE_FINISH req=
uest is
>> +=C2=A0=C2=A0=C2=A0 received for the zone,
>> +
>> +\item VIRTIO_BLK_ZS_FULL when a successful VIRTIO_BLK_T_OUT or
>> +=C2=A0=C2=A0=C2=A0 VIRTIO_BLK_T_ZONE_APPEND request that causes the zon=
e to reach its
>> writable
>> +=C2=A0=C2=A0=C2=A0 capacity is received for the zone.
>> +\end{itemize}
>> +
>> +When a VIRTIO_BLK_T_ZONE_EOPEN request is issued to an Explicitly Open =
zone,
>> the
>> +request is completed successfully and the zone stays in the
>> VIRTIO_BLK_ZS_EOPEN
>> +state.
>> +
>> +Zones in the VIRTIO_BLK_ZS_CLOSED (Closed) state transition from this s=
tate
>> +to
>> +\begin{itemize}
>> +\item VIRTIO_BLK_ZS_EMPTY when a successful VIRTIO_BLK_T_ZONE_RESET req=
uest is
>> +=C2=A0=C2=A0=C2=A0 received for the zone,
>> +
>> +\item VIRTIO_BLK_ZS_IOPEN when a successful VIRTIO_BLK_T_OUT request or
>> +=C2=A0=C2=A0=C2=A0 VIRTIO_BLK_T_ZONE_APPEND with a non-zero data size i=
s received for the
>> zone.
>> +
>> +\item VIRTIO_BLK_ZS_EOPEN when a successful VIRTIO_BLK_T_ZONE_OPEN requ=
est is
>> +=C2=A0=C2=A0=C2=A0 received for the zone,
>> +\end{itemize}
>> +
>> +When a VIRTIO_BLK_T_ZONE_CLOSE request is issued to a Closed zone, the =
request
>> +is completed successfully and the zone stays in the VIRTIO_BLK_ZS_CLOSE=
D
>> state.
>> +
>> +Zones in the VIRTIO_BLK_ZS_FULL (Full) state can transition from this s=
tate to
>> +VIRTIO_BLK_ZS_EMPTY when a successful VIRTIO_BLK_T_ZONE_RESET request i=
s
>> +received for the zone
>> +
>> +When a VIRTIO_BLK_T_ZONE_FINISH request is issued to a Full zone, the r=
equest
>> +is completed successfully and the zone stays in the VIRTIO_BLK_ZS_FULL =
state.
>> +
>> +The device may automatically transition zones to VIRTIO_BLK_ZS_RDONLY
>> +(Read-Only) or VIRTIO_BLK_ZS_OFFLINE (Offline) state from any other sta=
te. The
>> +device may also automatically transition zones in the Read-Only state t=
o the
>> +Offline state. Zones in the Offline state may not transition to any oth=
er
>> state.
>> +Such automatic transitions usually indicate hardware failures. The prev=
iously
>> +written data may only be read from zones in the Read-Only state. Zones =
in the
>> +Offline state can not be read or written.
>> +
>> +VIRTIO_BLK_S_ZONE_UNALIGNED_WP is set by the device when the request re=
ceived
>> +from the driver attempts to perform a write to an SWR zone and at least=
 one of
>> +the following conditions is met:
>> +
>> +\begin{itemize}
>> +\item the starting sector of the request is not equal to the current va=
lue of
>> +=C2=A0=C2=A0=C2=A0 the zone write pointer.
>> +
>> +\item the ending sector of the request data multiplied by 512 is not a
>> multiple
>> +=C2=A0=C2=A0=C2=A0 of the value reported by the device in the field \fi=
eld{write_granularity}
>> +=C2=A0=C2=A0=C2=A0 in the device configuration space.
>> +\end{itemize}
>> +
>> +VIRTIO_BLK_S_ZONE_OPEN_RESOURCE is set by the device when a zone operat=
ion or
>> +write request received from the driver can not be handled without excee=
ding
>> the
>> +\field{max_open_zones} limit value reported by the device in the config=
uration
>> +space.
>> +
>> +VIRTIO_BLK_S_ZONE_ACTIVE_RESOURCE is set by the device when a zone oper=
ation
>> or
>> +write request received from the driver can not be handled without excee=
ding
>> the
>> +\field{max_active_zones} limit value reported by the device in the
>> configuration
>> +space.
>> +
>> +A zone transition request that leads to both the \field{max_open_zones}=
 and
>> the
>> +\field{max_active_zones} limits to be exceeded is terminated by the dev=
ice
>> with
>> +VIRTIO_BLK_S_ZONE_ACTIVE_RESOURCE \field{status} value.
>> +
>> +The device reports all other error conditions related to zoned block mo=
del
>> +operation by setting the VIRTIO_BLK_S_ZONE_INVALID_CMD value in
>> +\field{status} of \field{virtio_blk_req} structure.
>> +
>> =C2=A0\drivernormative{\subsubsection}{Device Operation}{Device Types / =
Block Device
>> / Device Operation}
>> =C2=A0
>> =C2=A0A driver MUST NOT submit a request which would cause a read or wri=
te
>> @@ -4899,6 +5384,50 @@ \subsection{Device Operation}\label{sec:Device Ty=
pes /
>> Block Device / Device Ope
>> =C2=A0successfully, failed, or were processed by the device at all if th=
e request
>> =C2=A0failed with VIRTIO_BLK_S_IOERR.
>> =C2=A0
>> +The following requirements only apply if the VIRTIO_BLK_F_ZONED feature=
 is
>> +negotiated.
>> +
>> +A zone sector address provided by the driver MUST be a multiple of 512 =
bytes.
>> +
>> +When forming a VIRTIO_BLK_T_ZONE_REPORT request, the driver MUST set a =
sector
>> +within the sector range of the starting zone to report to \field{sector=
}
>> field.
>> +It MAY be a sector that is different from the zone sector address.
>> +
>> +In VIRTIO_BLK_T_ZONE_OPEN, VIRTIO_BLK_T_ZONE_CLOSE, VIRTIO_BLK_T_ZONE_F=
INISH
>> and
>> +VIRTIO_BLK_T_ZONE_RESET requests, the driver MUST set \field{sector} fi=
eld to
>> +point at the first sector in the target zone.
>> +
>> +In VIRTIO_BLK_T_ZONE_RESET_ALL request, the driver MUST set the field
>> +\field{sector} to zero value.
>> +
>> +The \field{sector} field of the VIRTIO_BLK_T_ZONE_APPEND request MUST s=
pecify
>> +the zone sector address of the zone to which data is to be appended at =
the
>> +position of the write pointer. The size of the data that is appended MU=
ST be a
>> +multiple of 512 bytes and MUST NOT exceed the \field{max_append_sectors=
} value
>> +provided by the device in \field{virtio_blk_zoned_characteristics}
>> configuration
>> +space structure.
>> +
>> +Upon a successful completion of a VIRTIO_BLK_T_ZONE_APPEND request, the=
 driver
>> +MAY read the starting sector location of the written data from the requ=
est
>> +field \field{append_sector}.
>> +
>> +All VIRTIO_BLK_T_OUT requests issued by the driver to sequential zones =
and
>> +VIRTIO_BLK_T_ZONE_APPEND requests MUST have:
>> +
>> +\begin{enumerate}
>> +\item the data size that is a multiple of the number of bytes reported
>> +=C2=A0=C2=A0=C2=A0 by the device in the field \field{write_granularity}=
 in the
>> +=C2=A0=C2=A0=C2=A0 \field{virtio_blk_zoned_characteristics} configurati=
on space structure.
>> +
>> +\item the value of the field \field{sector} that is a multiple of the n=
umber
>> of
>> +=C2=A0=C2=A0=C2=A0 bytes reported by the device in the field \field{wri=
te_granularity} in the
>> +=C2=A0=C2=A0=C2=A0 \field{virtio_blk_zoned_characteristics} configurati=
on space structure.
>> +
>> +\item the data size that will not exceed the writable zone capacity whe=
n its
>> +=C2=A0=C2=A0=C2=A0 value is added to the current value of the write poi=
nter of the zone.
>> +
>> +\end{enumerate}
>> +
>> =C2=A0\devicenormative{\subsubsection}{Device Operation}{Device Types / =
Block Device
>> / Device Operation}
>> =C2=A0
>> =C2=A0A device MUST set the \field{status} byte to VIRTIO_BLK_S_IOERR
>> @@ -4990,6 +5519,140 @@ \subsection{Device Operation}\label{sec:Device T=
ypes /
>> Block Device / Device Ope
>> =C2=A0=C2=A0 simplfy passthrough implementations from eMMC devices.
>> =C2=A0\end{note}
>> =C2=A0
>> +If the VIRTIO_BLK_F_ZONED feature is not negotiated, the device MUST re=
ject
>> +VIRTIO_BLK_T_ZONE_REPORT, VIRTIO_BLK_T_ZONE_OPEN, VIRTIO_BLK_T_ZONE_CLO=
SE,
>> +VIRTIO_BLK_T_ZONE_FINISH, VIRTIO_BLK_T_ZONE_APPEND, VIRTIO_BLK_T_ZONE_R=
ESET
>> and
>> +VIRTIO_BLK_T_ZONE_RESET_ALL requests with VIRTIO_BLK_S_UNSUPP status.
>> +
>> +The following device requirements only apply if the VIRTIO_BLK_F_ZONED =
feature
>> +is negotiated.
>> +
>> +If a request of type VIRTIO_BLK_T_ZONE_OPEN, VIRTIO_BLK_T_ZONE_CLOSE,
>> +VIRTIO_BLK_T_ZONE_FINISH or VIRTIO_BLK_T_ZONE_RESET is issued for a
>> Conventional
>> +zone (type VIRTIO_BLK_ZT_CONV), the device MUST complete the request wi=
th
>> +VIRTIO_BLK_S_ZONE_INVALID_CMD \field{status}.
>> +
>> +If the zone specified by the VIRTIO_BLK_T_ZONE_APPEND request is not a =
SWR
>> zone,
>> +then the request SHALL be completed with VIRTIO_BLK_S_ZONE_INVALID_CMD
>> +\field{status}.
>> +
>> +The device handles a VIRTIO_BLK_T_ZONE_OPEN request with the by attempt=
ing to
>> +change the state of the zone with the \field{sector} address to
>> +VIRTIO_BLK_ZS_EOPEN. If the transition to this state can not be perform=
ed, the
>> +request MUST be completed with VIRTIO_BLK_S_ZONE_INVALID_CMD \field{sta=
tus}.
>> If,
>> +while processing this request, the available zone resources are insuffi=
cient,
>> +then the zone state does not change and the request MUST be completed w=
ith
>> +VIRTIO_BLK_S_ZONE_OPEN_RESOURCE or VIRTIO_BLK_S_ZONE_ACTIVE_RESOURCE va=
lue in
>> +the field \field{status}.
>> +
>> +The device handles a VIRTIO_BLK_T_ZONE_CLOSE request by attempting to c=
hange
>> the
>> +state of the zone with the \field{sector} address to VIRTIO_BLK_ZS_CLOS=
ED. If
>> +the transition to this state can not be performed, the request MUST be
>> completed
>> +with VIRTIO_BLK_S_ZONE_INVALID_CMD value in the field \field{status}.
>> +
>> +The device handles a VIRTIO_BLK_T_ZONE_FINISH request by attempting to =
change
>> +the state of the zone with the \field{sector} address to VIRTIO_BLK_ZS_=
FULL.
>> If
>> +the transition to this state can not be performed, the zone state does =
not
>> +change and the request MUST be completed with VIRTIO_BLK_S_ZONE_INVALID=
_CMD
>> +value in the field \field{status}.
>> +
>> +The device handles a VIRTIO_BLK_T_ZONE_RESET request by attempting to c=
hange
>> the
>> +state of the zone with the \field{sector} address to VIRTIO_BLK_ZS_EMPT=
Y
>> state.
>> +If the transition to this state can not be performed, the zone state do=
es not
>> +change and the request MUST be completed with VIRTIO_BLK_S_ZONE_INVALID=
_CMD
>> +value in the field \field{status}.
>> +
>> +The device handles a VIRTIO_BLK_T_ZONE_RESET_ALL request by transitioni=
ng all
>> +sequential device zones in VIRTIO_BLK_ZS_IOPEN, VIRTIO_BLK_ZS_EOPEN,
>> +VIRTIO_BLK_ZS_CLOSED and VIRTIO_BLK_ZS_FULL state to VIRTIO_BLK_ZS_EMPT=
Y
>> state.
>> +
>> +Upon receiving a VIRTIO_BLK_T_ZONE_APPEND request or a VIRTIO_BLK_T_OUT
>> +request issued to a SWR zone in VIRTIO_BLK_ZS_EMPTY or VIRTIO_BLK_ZS_CL=
OSED
>> +state, the device attempts to perform the transition of the zone to
>> +VIRTIO_BLK_ZS_IOPEN state before writing data. This transition may fail=
 due to
>> +insufficient open and/or active zone resources available on the device.=
 In
>> this
>> +case, the request MUST be completed with VIRTIO_BLK_S_ZONE_OPEN_RESOURC=
E or
>> +VIRTIO_BLK_S_ZONE_ACTIVE_RESOURCE value in the \field{status}.
>> +
>> +If the \field{sector} field in the VIRTIO_BLK_T_ZONE_APPEND request doe=
s not
>> +specify the lowest sector for a zone, then the request SHALL be complet=
ed with
>> +VIRTIO_BLK_S_ZONE_INVALID_CMD value in \field{status}.
>> +
>> +A VIRTIO_BLK_T_ZONE_APPEND request or a VIRTIO_BLK_T_OUT request that h=
as the
>> +data range that that exceeds the remaining writable capacity for the zo=
ne,
>> then
>> +the request SHALL be completed with VIRTIO_BLK_S_ZONE_INVALID_CMD value=
 in
>> +\field{status}.
>> +
>> +If a request of the type VIRTIO_BLK_T_ZONE_APPEND is completed with
>> +VIRTIO_BLK_S_OK status, the field \field{append_sector} in
>> +\field{zone_append_in_hdr} field in \field{virtio_blk_req} MUST be set =
by
>> +the device to contain the start sector of the data written to the zone.
>> +
>> +A VIRTIO_BLK_T_ZONE_APPEND request that has the data size that exceeds
>> +\field{max_append_sectors} configuration space value, then,
>> +\begin{itemize}
>> +\item if \field{max_append_sectors} configuration space value is report=
ed as
>> +=C2=A0=C2=A0=C2=A0 zero by the device, the request SHALL be completed w=
ith
>> VIRTIO_BLK_S_UNSUPP
>> +=C2=A0=C2=A0=C2=A0 \field{status}.
>> +
>> +\item if \field{max_append_sectors} configuration space value is report=
ed as
>> +=C2=A0=C2=A0=C2=A0 a non-zero value by the device, the request SHALL be=
 completed with
>> +=C2=A0=C2=A0=C2=A0 VIRTIO_BLK_S_ZONE_INVALID_CMD \field{status}.
>> +\end{itemize}
>> +
>> +If a VIRTIO_BLK_T_ZONE_APPEND request, a VIRTIO_BLK_T_IN request or a
>> +VIRTIO_BLK_T_OUT request issued to a SWR zone has the range that has se=
ctors
>> in
>> +more than one zone, then the request SHALL completed with
>> +VIRTIO_BLK_S_ZONE_INVALID_CMD value in the field \field{status}.
>> +
>> +A VIRTIO_BLK_T_OUT request that has the \field{sector} value that is no=
t
>> aligned
>> +with the write pointer for the zone, then the request SHALL completed w=
ith
>> +VIRTIO_BLK_S_ZONE_UNALIGNED_WP value in the field \field{status}.
>> +
>> +In order to avoid resource-related errors while opening zones implicitl=
y, the
>> +device MAY automatically transition zones in VIRTIO_BLK_ZS_IOPEN state =
to
>> +VIRTIO_BLK_ZS_CLOSED state.
>> +
>> +All VIRTIO_BLK_T_OUT requests or VIRTIO_BLK_T_ZONE_APPEND requests issu=
ed
>> +to a zone in the VIRTIO_BLK_ZS_RDONLY state SHALL be completed with
>> +VIRTIO_BLK_S_ZONE_INVALID_CMD \field{status}.
>> +
>> +All requests issued to a zone in the VIRTIO_BLK_ZS_OFFLINE state SHALL =
be
>> +completed with VIRTIO_BLK_S_ZONE_INVALID_CMD value in the field
>> \field{status}.
>> +
>> +The device MUST consider the data that is read above the write pointer =
of a
>> zone
>> +as unwritten data. The sectors between the write pointer position and t=
he
>> upper
>> +write boundary of the zone during VIRTIO_BLK_T_ZONE_FINISH request proc=
essing
>> +are also considered unwritten data.
>> +
>> +When unwritten data is present in the sector range of a read request, t=
he
>> device
>> +MUST process this data in one of the following ways -
>> +
>> +\begin{enumerate}
>> +\item Fill the unwritten data with a device-specific byte pattern. The
>> +configuration, control and reporting of this byte pattern is beyond the=
 scope
>> +of this standard. This is the preferred approach.
>> +
>> +\item Fail the request. Depending on the driver implementation, this ma=
y
>> prevent
>> +the device from becoming operational.
>> +\end{enumerate}
>> +
>> +If the both VIRTIO_BLK_F_ZONED and VIRTIO_BLK_F_SECURE_ERASE features a=
re
>> +negotiated, then
>> +
>> +\begin{enumerate}
>> +\item the field \field{secure_erase_sector_alignment} in the configurat=
ion
>> space
>> +of the device MUST be a multiple of \field{zone_sectors} value reported=
 in the
>> +device configuration space.
>> +
>> +\item the data size in VIRTIO_BLK_T_SECURE_ERASE requests MUST be a mul=
tiple
>> of
>> +\field{zone_sectors} value in the device configuration space.
>> +\end{enumerate}
>> +
>> +The device MUST handle a VIRTIO_BLK_T_SECURE_ERASE request in the same =
way it
>> +handles VIRTIO_BLK_T_ZONE_RESET request for the zone range specified in=
 the
>> +VIRTIO_BLK_T_SECURE_ERASE request.
>> +
>> =C2=A0\subsubsection{Legacy Interface: Device Operation}\label{sec:Devic=
e Types /
>> Block Device / Device Operation / Legacy Interface: Device Operation}
>> =C2=A0When using the legacy interface, transitional devices and drivers
>> =C2=A0MUST format the fields in struct virtio_blk_req



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

