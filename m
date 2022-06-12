Return-Path: <virtio-comment-return-3116-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Sun, 12 Jun 2022 06:45:54 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <YqV9ktkSi9huhIoH@stefanha-x1.localdomain>
References: <20220610004321.357087-1-dmitry.fomichev@wdc.com>
 <YqT2duGV3hIpytI3@stefanha-x1.localdomain>
 <8ef5d3d6790bb8d82c999863324dedac97104c8c.camel@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SmaL+OsFg3K7Yr4K"
Content-Disposition: inline
In-Reply-To: <8ef5d3d6790bb8d82c999863324dedac97104c8c.camel@wdc.com>
Subject: [virtio-comment] Re: [virtio-dev] [RFC PATCH v2] virtio-blk: add zoned block device
 specification
To: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
Cc: Niklas Cassel <Niklas.Cassel@wdc.com>, "hare@suse.de" <hare@suse.de>, "its@irrelevant.dk" <its@irrelevant.dk>, Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Hans Holmberg <Hans.Holmberg@wdc.com>, "faithilikerun@gmail.com" <faithilikerun@gmail.com>, "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>, "stefanha@gmail.com" <stefanha@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--SmaL+OsFg3K7Yr4K
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 12, 2022 at 01:58:36AM +0000, Dmitry Fomichev wrote:
> On Sat, 2022-06-11 at 21:09 +0100, Stefan Hajnoczi wrote:
> > On Thu, Jun 09, 2022 at 08:43:21PM -0400, Dmitry Fomichev wrote:
> > > +Host-managed zoned block devices have their LBA range divided to Seq=
uential
> > > +Write Required (SWR) zones that require some additional handling fro=
m the
> > > host
> > > +for sustainable operation. All write requests to SWR zones must be
> > > sequential
> > > +and the zones with some data need to be reset before that data can be
> > > rewritten.
> > > +Host-managed devices support a set of ZBD-specific I/O requests that=
 can be
> > > used
> > > +by the host to manage device zones. Host-managed devices report
> > > VIRTIO_BLK_Z_HM
> > > +value in the \field{model} field in \field{zoned}.
> >=20
> > One of
> > "report the VIRTIO_BLK_Z_HM value in ..."
> > "report a VIRTIO_BLK_Z_HM value in ..."
> > "report VIRTIO_BLK_Z_HM in ..."
> > reads more naturally.
>=20
> OK.
>=20
> >=20
> > > +
> > > +Host-aware zoned block devices have their LBA range divided to Seque=
ntial
> > > +Write Preferred (SWP) zones that support the random write access, si=
milar to
> > > +regular non-zoned devices. However, the device I/O performance might=
 not be
> > > +optimal if SWP zones are used in a random I/O pattern. SWP zones also
> > > support
> > > +the same set of ZBD-specific I/O requests as host-managed devices th=
at allow
> > > +host-aware devices to be managed by any host that supports zoned blo=
ck
> > > devices
> > > +to achieve its optimum performance. Host-aware devices report
> > > VIRTIO_BLK_Z_HA
> > > +value in the \field{model} field in \field{zoned}.
> >=20
> > Same as above.
>=20
> Sure.
>=20
> >=20
> > > +
> > > +During device operation, SWR and SWP zones can be in one of the foll=
owing
> > > states:
> > > +empty, implicitly-open, explicitly-open, closed and full. The state =
machine
> > > that
> > > +governs the transitions between these states is described later in t=
his
> > > document.
> > > +
> > > +SWR and SWP zones consume volatile device resources while being in c=
ertain
> > > +states and the device may set limits on the number of zones that can=
 be in
> > > these
> > > +states simultaneously.
> > > +
> > > +Zoned block devices use two internal counters to account for the dev=
ice
> > > +resources in use, the number of currently open zones and the number =
of
> > > currently
> > > +active zones.
> > > +
> > > +Any zone state transition from a state that doesn't consume a zone r=
esource
> > > to a
> > > +state that consumes the same resource increments the internal device=
 counter
> > > for
> > > +that resource. Any zone transition out of a state that consumes a zo=
ne
> > > resource
> > > +to a state that doesn't consume the same resource decrements the cou=
nter.
> > > Any
> > > +request that causes the device to exceed the reported zone resource =
limits
> > > is
> > > +terminated by the device with a "zone resources exceeded" error as d=
efined
> > > for
> > > +specific commands later.
> > > +
> > > =A0\begin{lstlisting}
> > > =A0struct virtio_blk_config {
> > > =A0=A0=A0=A0=A0=A0=A0=A0 le64 capacity;
> > > @@ -4623,6 +4694,15 @@ \subsection{Device configuration
> > > layout}\label{sec:Device Types / Block Device /
> > > =A0=A0=A0=A0=A0=A0=A0=A0 le32 max_secure_erase_sectors;
> > > =A0=A0=A0=A0=A0=A0=A0=A0 le32 max_secure_erase_seg;
> > > =A0=A0=A0=A0=A0=A0=A0=A0 le32 secure_erase_sector_alignment;
> > > +=A0=A0=A0=A0=A0=A0=A0 struct virtio_blk_zoned_characteristics {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 le32 zone_sectors;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 le32 max_open_zones;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 le32 max_active_zones;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 le32 max_append_sector=
s;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 le32 write_granularity;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 u8 model;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 u8 unused2[3];
> > > +=A0=A0=A0=A0=A0=A0=A0 } zoned;
> > > =A0};
> > > =A0\end{lstlisting}
> > > =A0
> > > @@ -4686,6 +4766,10 @@ \subsection{Device Initialization}\label{sec:D=
evice
> > > Types / Block Device / Devic
> > > =A0=A0=A0=A0 \field{secure_erase_sector_alignment} can be used by OS =
when splitting a
> > > =A0=A0=A0=A0 request based on alignment.
> > > =A0
> > > +\item If the VIRTIO_BLK_F_ZONED feature is negotiated, the fields in
> > > +=A0=A0=A0 \field{zoned} can be read by the driver to determine the z=
one
> > > +=A0=A0=A0 characteristics of the device. All \field{zoned} fields ar=
e read-only.
> > > +
> > > =A0\end{enumerate}
> > > =A0
> > > =A0\drivernormative{\subsubsection}{Device Initialization}{Device Typ=
es / Block
> > > Device / Device Initialization}
> > > @@ -4701,6 +4785,33 @@ \subsection{Device Initialization}\label{sec:D=
evice
> > > Types / Block Device / Devic
> > > =A0The driver MUST NOT read \field{writeback} before setting
> > > =A0the FEATURES_OK \field{device status} bit.
> > > =A0
> > > +Drivers SHOULD NOT negotiate VIRTIO_BLK_F_ZONED feature if they are
> > > incapable
> > > +of supporting devices with the VIRTIO_BLK_Z_HM or VIRTIO_BLK_Z_HA zo=
ned
> > > model.
> > > +
> > > +Drivers MAY operate with VIRTIO_BLK_F_ZONED feature negotiated when =
the
> > > device
> > > +reports VIRTIO_BLK_Z_NONE zoned model for testing and development.
> >=20
> > Specifying a particular use case ("testing and development") could be
> > interpreted to imply that other use cases MAY NOT operate with
> > VIRTIO_BLK_F_ZONED.
> >=20
> > I suggest dropping the use case from the sentence or moving that sub-po=
int
> > outside the normative section to where the text describes VIRTIO_BLK_Z_=
NONE.
> > Something like "Devices that offer VIRTIO_BLK_F_ZONED with VIRTIO_BLK_Z=
_NONE
> > commonly do so for testing and development purposes".
>=20
> Good point, will do.
>=20
> >=20
> > > +Each request is of form:
> > > +
> > > +\begin{lstlisting}
> > > +struct virtio_blk_zoned_req {
> > > +=A0=A0=A0=A0=A0=A0=A0 le32 type;
> > > +=A0=A0=A0=A0=A0=A0=A0 le32 reserved;
> > > +=A0=A0=A0=A0=A0=A0=A0 le64 sector;
> > > +=A0=A0=A0=A0=A0=A0=A0 struct {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* ALL zone operation =
flag */
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 le32 mgmt_send_all:1;
> >=20
> > Bit-fields cannot be used in external interfaces (like hardware
> > interfaces) because the C standard says (N1570 6.7.2.1 11):
> >=20
> > =A0 The order of allocation of bit-fields within a unit (high-order to
> > =A0 low-order or low-order to high-order) is implementation-defined.
> >=20
> > So this C syntax does not define a specific binary representation, it's
> > up to the compiler or system ABI.
> >=20
>=20
> Right... I was confused by the fact that virtio_blk_discard_write_zeroes =
struct
> in the same spec happily uses bit-fields for the unmap flag. Perhaps, that
> flag could be also defined using a bit mask... :)

Ah, good point. I was wrong. See 1.4 Structure Specifications in the
VIRTIO spec:

  Bit-fields within integer fields are always listed in order, from the
  least significant to the most significant bit. The bit-fields are
  considered unsigned integers of the specified width with the next in
  significance relationship of the bits preserved.

So it is okay to use bit-fields in the spec.

It pushes the problem onto implementors of the spec. They cannot
bit-fields in implementations where the C compiler uses a representation
that differs from the VIRTIO spec :).

>=20
> > Please use a le32 field and define a bit number:
> >=20
> > =A0 #define VIRTIO_BLK_ZONE_MGMT_F_SEND_ALL (1u << 0)
> > =A0 le32 flags;
> >=20
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 le32 reserved:31;
> > > +=A0=A0=A0=A0=A0=A0=A0 } zone;
> > > +=A0=A0=A0=A0=A0=A0=A0 u8 data[];
> > > +=A0=A0=A0=A0=A0=A0=A0 le64 append_sector;
> > > +=A0=A0=A0=A0=A0=A0=A0 u8 reserved1[3];
> > > +=A0=A0=A0=A0=A0=A0=A0 u8 status;
> > > +};
> > > +\end{lstlisting}
> >=20
>=20
> Yep, the ends up to be pretty simple. Using a le32 should be sufficient f=
or
> future command flag additions like the partial flag, etc.
>=20
> > Now that the status field is at the end of the struct the zoned commands
> > can be treated like any other struct virtio_blk_req.
> >=20
> > The contents of the data[] field for ZONE_OPEN, ZONE_CLOSE, ZONE_FINISH,
> > and ZONE_RESET requests is:
> >=20
> > =A0 #define VIRTIO_BLK_ZONE_MGMT_F_SEND_ALL (1u << 0)
> > =A0 struct virtio_blk_zoned_mgmt_send {
> > =A0=A0=A0=A0=A0 le32 flags;
> > =A0 };
> >=20
> > The contents of the data[] field for ZONE_APPEND is:
> >=20
> > =A0 u8 payload[];=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* driver -> device =
*/
> >=20
> > followed by:
> >=20
> > =A0 le64 append_sector;=A0=A0=A0=A0=A0 /* device -> driver */
> >=20
> > The contents of the data[] field for ZONE_REPORT is struct
> > virtio_blk_zone_report.
> >=20
> > The reason I'm pushing for getting rid of struct virtio_blk_zoned_req is
> > that the zbd-specific fields are not common to all ZONE_* requests. I
> > don't see a reason to define a common request layout anymore.
> >=20
> > Also, it would make the zoned command design similar to struct
> > virtio_blk_discard_write_zeroes where request metadata is a separate
> > struct that is located in struct virtio_blk_req's data[] field instead
> > of a new top-level struct virtio_blk_discard_write_zeroes_request that
> > duplicates struct virtio_blk_req fields.
>=20
> My concern is that this approach requires quite a few of runtime checks t=
o be
> added in the hot path - if (alba), if (flags), request opcode checks... M=
y PoC
> code that uses virtio_blk_zoned_req adds zero checks, both for zoned and =
non-
> zoned operation.
>=20
> With discard, there is no other way to handle it except to introduce
> virtio_blk_discard_write_zeroes because the number of incoming discard se=
gments
> is variable, but for zoned operation it should be sufficient to use a sim=
pler
> solution with the virtio_blk_zoned_req which seems to be less fragile in =
terms of
> implementation.

Can you describe where new runtime checks are required?

The content of data[] is specific to each request type. Driver and
device implementations already have conditional branches for handling
different request types. The data[] layout code goes into those branches
and it should therefore not require new runtime checks. In other words,
the ZONE_APPEND code knows statically at compile-time that the
append_sectors field is needed.

So I think any runtime checks that may exist in driver code right now
are accidental and can be avoided.

Stefan

--SmaL+OsFg3K7Yr4K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmKlfZIACgkQnKSrs4Gr
c8hL3wf/aFnSx8rkyT+uXiLzYjqTN72LTvY7munxemCmumWZRpNbMycNyxyP6mZd
SKVBjCotJtaQWlpH1ANNZ2uXwNewDzPxDznYTeBm3XkVFoxPMltXS/K8+91k0KU2
VzY9i5Y9jf2SUeEa1znrSWxMLSIBcAXa7lEvyQ7K3envEopC5cWTRrr9MK9aX/kA
XvnYzDjbgWy4AuUnQ/mQe8P7Gi2+51DVXGUUQeBpLGP68wA7Nay2KQE9jRcCXV9K
ONNey9em5hoAq48SnJ0xthEZfVR3MiKGB5hdFmwstIOjLzYHbgyhb0HBB0U+J47I
LTmow9XHUlNDx90Yjv7BetF+F9KJSA==
=GBmR
-----END PGP SIGNATURE-----

--SmaL+OsFg3K7Yr4K--

