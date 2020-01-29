Return-Path: virtio-dev-return-6691-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A0D75985F8B
	for <virtio-dev@lists.oasis-open.org>; Wed, 29 Jan 2020 09:53:35 +0000 (UTC)
Date: Wed, 29 Jan 2020 04:53:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200129042738-mutt-send-email-mst@kernel.org>
References: <4f02aee295fd809c9e6deed1f353f619c469651a.camel@intel.com>
MIME-Version: 1.0
In-Reply-To: <4f02aee295fd809c9e6deed1f353f619c469651a.camel@intel.com>
Subject: Re: [virtio-dev] virtio packed ring concerns
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: "Walker, Benjamin" <benjamin.walker@intel.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

I second Stefan's comments. To add to that, I think the spec
could be improved to avoid this kind of misunderstanding.
See comments below:

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
> descriptors were submitted (so they went into slot 3 and then 0).

And let's assume they have IDs 3 and 0, respectively.

> Each time
> through the ring, the "ring wrap counter" toggles from 1 to 0 or vice ver=
sa. The
> avail and used flags are initialized to 1 at start up and the ring wrap c=
ounter
> is 0.
>=20
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

Right but the spec says
=09 Used device
=09 descriptors are written in the order in which their processing is compl=
ete.

so what should happen, is this:
=09 descriptor with ID 0 is written into slot 3.
=09 descriptor with ID 3 is written into slot 0.


The following might be helpful to describe this better:

the spec already says:

=09The Descriptor Ring is used in a circular manner: the driver writes desc=
riptors into the ring in order. After
=09reaching the end of the ring, the next descriptor is placed at the head =
of the ring. Once the ring is full of driver
=09descriptors, the driver stops sending new requests and waits for the dev=
ice to start processing descriptors
=09and to write out some used descriptors before making new driver descript=
ors available.

and maybe we should add:

=09Similarly, device writes out used descriptors in a circular manner:
=09starting at the head of the ring, and until it reaches the end of the
=09ring. After reaching the end of the ring, the next used descriptor is
=09again placed at the head of the ring.


Also spec currently says:

=09The counter maintained by the device is called the Device Ring Wrap Coun=
ter. The device changes the
=09value of this counter each time it uses the last descriptor in the ring =
(after marking the last descriptor used).

in fact this part may be confusing: it is not clear what does "uses the las=
t descriptor"
mean - you took it to mean "writes out descriptor with ID from the last
descriptor", what spec means is "writes out a used descriptor over the
last descriptor location".  The text also does not properly account for ski=
pping descriptors.

What it should say is:

=09The counter maintained by the device is called the Device Ring Wrap Coun=
ter. The device changes the
=09value of this counter each time it reaches the last descriptor
=09in the ring when writing used descriptors
        (after writing out or skipping over the last used descriptor).

Please let me know whether the changes suggested above would clarify
things for you, or whether you have other suggestions. Thanks!

--=20
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

