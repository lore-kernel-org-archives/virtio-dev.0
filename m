Return-Path: virtio-dev-return-3664-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
From: Lars Ganrot <lga@napatech.com>
Date: Wed, 28 Mar 2018 16:12:10 +0000
Message-ID: <a3ab2d6229cb49b09d27d067ca74b9a9@napatech.com>
References: <1520629942-36324-1-git-send-email-mst@redhat.com>
 <1520629942-36324-14-git-send-email-mst@redhat.com>
 <ee81d80dd7d4497a97f924be66e17227@napatech.com>
 <20180328173142-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180328173142-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: RE: [virtio-dev] [PATCH v10 13/13] split-ring: in order feature
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Missed replying to the lists. Sorry.

> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: 28. marts 2018 16:39
>=20
> On Wed, Mar 28, 2018 at 08:23:38AM +0000, Lars Ganrot wrote:
> > Hi Michael et al
> >
> > > Behalf Of Michael S. Tsirkin
> > > Sent: 9. marts 2018 22:24
> > >
> > > For a split ring, require that drivers use descriptors in order too.
> > > This allows devices to skip reading the available ring.
> > >
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > ---
> > [snip]
> > >
> > > +If VIRTIO_F_IN_ORDER has been negotiated, and when making a
> > > +descriptor with VRING_DESC_F_NEXT set in \field{flags} at offset
> > > +$x$ in the table available to the device, driver MUST set
> > > +\field{next} to $0$ for the last descriptor in the table (where $x
> > > +=3D queue\_size - 1$) and to $x + 1$ for the rest of the descriptors=
.
> > > +
> > >  \subsubsection{Indirect Descriptors}\label{sec:Basic Facilities of
> > > a Virtio Device / Virtqueues / The Virtqueue Descriptor Table /
> > > Indirect Descriptors}
> > >
> > >  Some devices benefit by concurrently dispatching a large number @@
> > > -247,6
> > > +257,10 @@ chained by \field{next}. An indirect descriptor without a
> > > +valid
> > > \field{next}  A single indirect descriptor  table can include both
> > > device- readable and device-writable descriptors.
> > >
> > > +If VIRTIO_F_IN_ORDER has been negotiated, indirect descriptors use
> > > +sequential indices, in-order: index 0 followed by index 1 followed
> > > +by index 2, etc.
> > > +
> > >  \drivernormative{\paragraph}{Indirect Descriptors}{Basic Facilities
> > > of a Virtio Device / Virtqueues / The Virtqueue Descriptor Table /
> > > Indirect Descriptors} The driver MUST NOT set the
> VIRTQ_DESC_F_INDIRECT flag unless the
> > >  VIRTIO_F_INDIRECT_DESC feature was negotiated.   The driver MUST
> NOT
> > > @@ -259,6 +273,10 @@ the device.
> > >  A driver MUST NOT set both VIRTQ_DESC_F_INDIRECT and
> > > VIRTQ_DESC_F_NEXT  in \field{flags}.
> > >
> > > +If VIRTIO_F_IN_ORDER has been negotiated, indirect descriptors MUST
> > > +appear sequentially, with \field{next} taking the value of 1 for
> > > +the 1st descriptor, 2 for the 2nd one, etc.
> > > +
> > >  \devicenormative{\paragraph}{Indirect Descriptors}{Basic Facilities
> > > of a Virtio Device / Virtqueues / The Virtqueue Descriptor Table /
> > > Indirect Descriptors} The device MUST ignore the write-only flag
> > > (\field{flags}\&VIRTQ_DESC_F_WRITE) in the descriptor that refers to
> > > an indirect table.
> > >
> >
> > The use of VIRTIO_F_IN_ORDER for split-ring can eliminate some accesses
> to the virtq_avail.ring and virtq_used.ring. However I'm wondering if the
> proposed descriptor ordering for multi-element buffers couldn't be tweake=
d
> to be more HW friendly.  Currently even with the VIRTIO_F_IN_ORDER
> negotiated, there is no way of knowing if, or how many chained descriptor=
s
> follow the descriptor pointed to by the virtq_avail.idx. A chain has to b=
e
> inspected one descriptor at a time until
> virtq_desc.flags[VIRTQ_DESC_F_NEXT]=3D0. This is awkward for HW offload,
> where you want to DMA all available descriptors in one shot, instead of
> iterating based on the contents of received DMA data. As currently define=
d,
> HW would have to find a compromise between likely chain length, and cost
> of additional DMA transfers. This leads to a performance penalty for all
> chained descriptors, and in case the length assumption is wrong the impac=
t
> can be significant.
> >
> > Now, what if the VIRTIO_F_IN_ORDER instead required chained buffers to
> place the last element at the lowest index, and the head-element (to whic=
h
> virtq_avail.idx points) at the highest index? Then all the chained elemen=
t
> descriptors would be included in a DMA of the descriptor table from the
> previous virtq_avail.idx+1 to the current virtq_avail.idx. The "backward"
> order of the chained descriptors shouldn't pose an issue as such (at leas=
t not
> in HW).
> >
> > Best Regards,
> >
> > -Lars
>=20
> virtq_avail.idx is still an index into the available ring.
>=20
> I don't really see how you can use virtq_avail.idx to guess the placement=
 of a
> descriptor.
>=20
> I suspect the best way to optimize this is to include the relevant data w=
ith the
> VIRTIO_F_NOTIFICATION_DATA feature.
>=20

Argh, naturally.=20

For HW offload I'd want to avoid notifications for buffer transfer from hos=
t to device, and hoped to just poll virtq_avail.idx directly.

A split virtqueue with VITRIO_F_IN_ORDER will maintain virtq_avail.idx=3D=
=3Dvirtq_avail.ring[idx] as long as there is no chaining. It would be nice =
to allow negotiating away chaining, i.e add a VIRTIO_F_NO_CHAIN. If negotia=
ted, the driver agrees not to use chaining, and as a result (of IN_ORDER an=
d NO_CHAIN) both device and driver can ignore the virtq_avail.ring[].

>=20
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

