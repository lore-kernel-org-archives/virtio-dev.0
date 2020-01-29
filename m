Return-Path: virtio-dev-return-6689-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E6241985F8B
	for <virtio-dev@lists.oasis-open.org>; Wed, 29 Jan 2020 09:41:53 +0000 (UTC)
Date: Wed, 29 Jan 2020 09:41:44 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20200129094144.GA920247@stefanha-x1.localdomain>
References: <4f02aee295fd809c9e6deed1f353f619c469651a.camel@intel.com>
MIME-Version: 1.0
In-Reply-To: <4f02aee295fd809c9e6deed1f353f619c469651a.camel@intel.com>
Subject: Re: [virtio-dev] virtio packed ring concerns
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
To: "Walker, Benjamin" <benjamin.walker@intel.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2020 at 05:26:07PM +0000, Walker, Benjamin wrote:
> Hi all - I'm a core maintainer for the SPDK project, which includes a vho=
st-user=20
> target implementation that handles both virtio-blk and virtio-scsi. Recen=
tly we
> had some engineers go off and attempt to add support for packed virtqueue=
s, as
> defined here:=20
> https://github.com/oasis-tcs/virtio-spec/blob/master/packed-ring.tex
>=20
> While reviewing the patches they submitted I noticed two separate issues.=
 The
> first issue is that the ring cannot function correctly under certain
> circumstances by spec. The second issue is a performance issue. I'm going=
 to try
> to keep both of these entirely separate.
>=20
> Comments are very welcome here, and I'm hoping I'm just missing some crit=
ical
> piece of information that resolves the whole thing, but testing is so far
> showing that I'm finding a real problem.
>=20
> First, the functional issue. The problem scenario involves out of order
> completions during ring wrap around. Here are the most relevant sections =
of the
> specification:
>=20
> ~~~
> Note: after reading driver descriptors and starting their processing in o=
rder,
> the device might complete their processing out of order.  Used device
> descriptors are written in the order in which their processing is complet=
e.
>=20
> The counter maintained by the driver is called the Driver Ring Wrap Count=
er. The
> driver changes the value of this counter each time it makes available the=
 last
> descriptor in the ring (after making the last descriptor available).
>=20
> The counter maintained by the device is called the Device Ring Wrap
> Counter.  The device changes the value of this counter
> each time it uses the last descriptor in
> the ring (after marking the last descriptor used).
>=20
> To mark a descriptor as available, the driver sets the VIRTQ_DESC_F_AVAIL=
 bit in
> Flags to match the internal Driver Ring Wrap Counter.  It also sets the
> VIRTQ_DESC_F_USED bit to match the inverse value (i.e. to not match the i=
nternal
> Driver Ring Wrap Counter).
>=20
> To mark a descriptor as used, the device sets the VIRTQ_DESC_F_USED bit i=
n Flags
> to match the internal Device Ring Wrap Counter.  It also sets the
> VIRTQ_DESC_F_AVAIL bit to match the \emph{same} value.
> ~~~
>=20
> Imagine a packed ring with 4 descriptors. At some earlier time let's say =
the
> first 3 descriptors were submitted and completed, in order. Then, two mor=
e
> descriptors were submitted (so they went into slot 3 and then 0). Each ti=
me
> through the ring, the "ring wrap counter" toggles from 1 to 0 or vice ver=
sa. The
> avail and used flags are initialized to 1 at start up and the ring wrap c=
ounter
> is 0.

Both the Driver and Device Ring Wrap Counters are initialized to 1
according to the spec, not 0.  This doesn't matter for the rest of the
discussion though.  I just wanted to mention it in case your
implementation has the value inverted.

> So when submitting into slot 3, the driver flips the avail bit from 1 to =
0. When
> submitting into slot 0 after the ring-wrap, it flips the avail bit from 0=
 to 1.
> The spec says it also sets the used flag, but the used flag is already th=
e
> correct value. That's all solid so far.
>=20
> The device is then polling on slot 3 waiting for new descriptors to be
> submitted. Note here that the device must be maintaining its own copy of =
what it
> thinks is the driver's ring wrap counter value to detect descriptors bein=
g made
> available, which isn't called out in the specification at all but all act=
ual
> implementations do. Regardless, once it sees the avail flag in the descri=
ptor in
> slot 3 flip, it begins processing the descriptor. It then moves on to pol=
l slot
> 0 for incoming descriptors (and updates its expected avail ring wrap coun=
ter
> value internally). In this case, it sees the bit flip for slot 0 and begi=
ns
> processing the descriptor. Descriptor processing is asynchronous and may
> complete out of order, at least for storage devices.
>=20
> So let's say that the descriptors do, in fact, complete out of order, suc=
h that
> the descriptor in slot 0 completes first and then the descriptor in slot =
3
> completes second. The specification is very clear that this is allowed.
>=20
> When completing the descriptor in slot 0, the device has not yet complete=
d the
> last descriptor in the ring (they're out of order!). So the ring wrap cou=
nter is
> still 0. So it then proceeds to write both the avail flag and the used fl=
ag to
> 0. But the driver is expecting the used flag to get flipped to 1 to indic=
ate a
> completion. This is broken.

You're saying used descriptors overwrite the same descriptor slot where
they were made available by the driver.  This is not the case.  The
device overwrites the descriptor ring in completion order.  See my
response to your concern about performance for an illustration.

> I wrote a unit test for the SPDK implementation and it is indeed broken i=
n this
> scenario, causing the driver to hang. I've also at least looked through t=
he code
> in DPDK and in the Linux kernel implementations and they appear broken in
> various ways as well. It appears that DPDK may decide the ring is corrupt=
 and
> "drop the packet" in this scenario, which is data corruption for storage,=
 but I
> haven't yet run a test to confirm. The Linux kernel implementation looks =
to me
> like it will never consider the descriptor as complete and eventually han=
g.
>=20
> The device doesn't actually need to track a ring wrap counter for the use=
d flag
> at all. The device does need to track a ring wrap counter for the expecte=
d value
> of the avail bit, to mirror the driver side value while polling for incom=
ing
> descriptors. But to mark descriptors as used, it simply needs to set the =
used
> flag to the current value of the avail flag in that descriptor.
>=20
> ----------------------
>=20
> Moving on to my separate concerns about performance. Critically, it's imp=
ortant
> to note that storage devices these days are inherently parallel pieces of
> hardware. You can submit a large number of commands at once and the devic=
e
> actually does process some number of them simultaneously. That means thin=
gs
> complete out of order all the time. For example, imagine submitting two c=
ommands
> to a NAND flash storage device where one is a 1MB read and the second one=
 is a
> 4k read. Let's say that the data these are reading are on entirely separa=
te NAND
> chips internally. That 4k read will complete ahead of the 1MB read, and i=
t would
> be awful to force that small read to wait on the larger one.
>=20
> But with the packed ring design, there's only one ring for both submissio=
n and
> completion, so descriptor slots can only be re-used in order. Even if the=
 device
> implementation is able to complete the 4K read out of order ahead of time=
 and
> mark the descriptor as used, a driver that's polling for completions won'=
t see
> it until the earlier descriptor completes. A driver using interrupts may =
be able
> to see it if the interrupt tells it specifically which slot to look at, b=
ut it
> can't re-use the descriptor slot for a new command because submissions mu=
st go
> in order. While the bug I outlined in the first part of my email is fixab=
le,
> this design issue is not.

The spec says:

  When the device has finished processing the buffer, it writes a used
  device descriptor including the Buffer ID into the Descriptor Ring
  (overwriting a driver descriptor previously made available)

  ...

  Note: after reading driver descriptors and starting their processing
  in order, the device might complete their processing out of order.
  Used device descriptors are written in the order in which their
  processing is complete.

Say the write has the following requests:

  | 1M (Avail) | 4K (Avail) |

The device sees both requests and completes the 4K request.  The device
overwrites the oldest available descriptor:

  | 4K (Used)  | 4K (Avail/seen) |

The driver polls the first descriptor for completions.  Therefore, the
driver can process the 4K request completion while the 1M request is
still pending.  Now the driver can submit the next request while the 1M
request is in flight:

  | 8K (Avail) | 4K (Avail/seen) |

With this mental model of how the packed ring layout works I think
neither of the issues you've raised is a problem.  Have I missed
anything?

Stefan

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4xU1gACgkQnKSrs4Gr
c8jzqwgAhladWKjcaulBipuaejZuDyf0LmpVGa6pOJdXrAYtIEynaZVBNlJ6Ixb2
mot0XOOsJDyCv1N6rID4lEXOVQ36nJ6xpkKne7kDVopCUtzEOhMHp1KNLCXYfuzX
mN+jqACre6jaZl8aLWYLyKckct8ZS2SlsZXwV9eAiJsenxxPR0JnTj1cbnNpTjpD
xflgr6lV/3Q9bYrTCYsq5YHUPVclYtdy5ctIhSf0fH8AkPq57h+LqUjnvzx5NQfu
rWr0pcinwg9XzUpPbUJnD//5A24LCoGMrWBC2ysy+A5qXUAy7tM0AKhjq/JS0zYC
3CCUJL9wz7cKb28/0R2ja+aYhzJZ0A==
=TxXb
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--

