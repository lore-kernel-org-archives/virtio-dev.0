Return-Path: <virtio-comment-return-3115-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Sat, 11 Jun 2022 21:09:26 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <YqT2duGV3hIpytI3@stefanha-x1.localdomain>
References: <20220610004321.357087-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Z2nClcbGkQuQpiyE"
Content-Disposition: inline
In-Reply-To: <20220610004321.357087-1-dmitry.fomichev@wdc.com>
Subject: [virtio-comment] Re: [virtio-dev] [RFC PATCH v2] virtio-blk: add zoned block device
 specification
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, Damien Le Moal <damien.lemoal@opensource.wdc.com>, Matias Bjorling <matias.bjorling@wdc.com>, Niklas Cassel <niklas.cassel@wdc.com>, Hans Holmberg <Hans.Holmberg@wdc.com>, Stefan Hajnoczi <stefanha@gmail.com>, Hannes Reinecke <hare@suse.de>, Klaus Jensen <its@irrelevant.dk>, Sam Li <faithilikerun@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--Z2nClcbGkQuQpiyE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 09, 2022 at 08:43:21PM -0400, Dmitry Fomichev wrote:
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
> +value in the \field{model} field in \field{zoned}.

One of
"report the VIRTIO_BLK_Z_HM value in ..."
"report a VIRTIO_BLK_Z_HM value in ..."
"report VIRTIO_BLK_Z_HM in ..."
reads more naturally.

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
> +value in the \field{model} field in \field{zoned}.

Same as above.

> +
> +During device operation, SWR and SWP zones can be in one of the followin=
g states:
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
> @@ -4623,6 +4694,15 @@ \subsection{Device configuration layout}\label{sec=
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
> =20
> @@ -4686,6 +4766,10 @@ \subsection{Device Initialization}\label{sec:Devic=
e Types / Block Device / Devic
>      \field{secure_erase_sector_alignment} can be used by OS when splitti=
ng a
>      request based on alignment.
> =20
> +\item If the VIRTIO_BLK_F_ZONED feature is negotiated, the fields in
> +    \field{zoned} can be read by the driver to determine the zone
> +    characteristics of the device. All \field{zoned} fields are read-onl=
y.
> +
>  \end{enumerate}
> =20
>  \drivernormative{\subsubsection}{Device Initialization}{Device Types / B=
lock Device / Device Initialization}
> @@ -4701,6 +4785,33 @@ \subsection{Device Initialization}\label{sec:Devic=
e Types / Block Device / Devic
>  The driver MUST NOT read \field{writeback} before setting
>  the FEATURES_OK \field{device status} bit.
> =20
> +Drivers SHOULD NOT negotiate VIRTIO_BLK_F_ZONED feature if they are inca=
pable
> +of supporting devices with the VIRTIO_BLK_Z_HM or VIRTIO_BLK_Z_HA zoned =
model.
> +
> +Drivers MAY operate with VIRTIO_BLK_F_ZONED feature negotiated when the =
device
> +reports VIRTIO_BLK_Z_NONE zoned model for testing and development.

Specifying a particular use case ("testing and development") could be
interpreted to imply that other use cases MAY NOT operate with
VIRTIO_BLK_F_ZONED.

I suggest dropping the use case from the sentence or moving that sub-point
outside the normative section to where the text describes VIRTIO_BLK_Z_NONE.
Something like "Devices that offer VIRTIO_BLK_F_ZONED with VIRTIO_BLK_Z_NONE
commonly do so for testing and development purposes".

> +Each request is of form:
> +
> +\begin{lstlisting}
> +struct virtio_blk_zoned_req {
> +        le32 type;
> +        le32 reserved;
> +        le64 sector;
> +        struct {
> +                /* ALL zone operation flag */
> +                le32 mgmt_send_all:1;

Bit-fields cannot be used in external interfaces (like hardware
interfaces) because the C standard says (N1570 6.7.2.1 11):

  The order of allocation of bit-fields within a unit (high-order to
  low-order or low-order to high-order) is implementation-defined.

So this C syntax does not define a specific binary representation, it's
up to the compiler or system ABI.

Please use a le32 field and define a bit number:

  #define VIRTIO_BLK_ZONE_MGMT_F_SEND_ALL (1u << 0)
  le32 flags;

> +                le32 reserved:31;
> +        } zone;
> +        u8 data[];
> +        le64 append_sector;
> +        u8 reserved1[3];
> +        u8 status;
> +};
> +\end{lstlisting}

Now that the status field is at the end of the struct the zoned commands
can be treated like any other struct virtio_blk_req.

The contents of the data[] field for ZONE_OPEN, ZONE_CLOSE, ZONE_FINISH,
and ZONE_RESET requests is:

  #define VIRTIO_BLK_ZONE_MGMT_F_SEND_ALL (1u << 0)
  struct virtio_blk_zoned_mgmt_send {
      le32 flags;
  };

The contents of the data[] field for ZONE_APPEND is:

  u8 payload[];            /* driver -> device */

followed by:

  le64 append_sector;      /* device -> driver */

The contents of the data[] field for ZONE_REPORT is struct
virtio_blk_zone_report.

The reason I'm pushing for getting rid of struct virtio_blk_zoned_req is
that the zbd-specific fields are not common to all ZONE_* requests. I
don't see a reason to define a common request layout anymore.

Also, it would make the zoned command design similar to struct
virtio_blk_discard_write_zeroes where request metadata is a separate
struct that is located in struct virtio_blk_req's data[] field instead
of a new top-level struct virtio_blk_discard_write_zeroes_request that
duplicates struct virtio_blk_req fields.

Stefan

--Z2nClcbGkQuQpiyE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmKk9nYACgkQnKSrs4Gr
c8gtiAgAkL2r1dxpirfkRsobdJHPYH4pdi4kB0fzwIpAfYWZKLdNBzUpE2Gfhbuc
vjjsI3Qw8br5oCMILPvNyEasvmM4pfKcvi/YYNFsHTq5gi6tU8Hchj2Dj5v7HSzx
m3eK+CgCIqAkFt7QcMHB228v+Y/paS0t0d2ddfwgBE6aBy7wPO6Jha4+cFDoqkGG
A3IQA++n1TUkMsOtx5YPfln6hhQ9EHCosiyPWaIQgj/hpAB5zc6WIQe8/5vGC4EO
fpAatcb7AaV7saAkhwugdWkHuzVcUYmTGCAGTWG+VSkQl5fuUcJg+BiaJ7gZ1W5X
YO3yxfP7D6sxZtzVxp5KEoxhnrgeRQ==
=KsG0
-----END PGP SIGNATURE-----

--Z2nClcbGkQuQpiyE--

