Return-Path: virtio-return-3043-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Tue, 3 Apr 2018 14:47:57 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180403143743-mutt-send-email-mst@kernel.org>
References: <1520629942-36324-1-git-send-email-mst@redhat.com>
 <1520629942-36324-14-git-send-email-mst@redhat.com>
 <ee81d80dd7d4497a97f924be66e17227@napatech.com>
 <20180328173142-mutt-send-email-mst@kernel.org>
 <a3ab2d6229cb49b09d27d067ca74b9a9@napatech.com>
 <20180329173105-mutt-send-email-mst@kernel.org>
 <2552bfc5d77e4b789d08d3479c3baf01@napatech.com>
 <20180329215452-mutt-send-email-mst@kernel.org>
 <0314ad39fb614c4d836fc77a6b42fc4c@napatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0314ad39fb614c4d836fc77a6b42fc4c@napatech.com>
Subject: [virtio] Re: [virtio-dev] [PATCH v10 13/13] split-ring: in order feature
To: Lars Ganrot <lga@napatech.com>
Cc: "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Apr 03, 2018 at 07:19:47AM +0000, Lars Ganrot wrote:
> > From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org> On
> > Behalf Of Michael S. Tsirkin
> > Sent: 29. marts 2018 21:13
> >
> > On Thu, Mar 29, 2018 at 06:23:28PM +0000, Lars Ganrot wrote:
> > >
> > >
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: 29. marts 2018 16:42
> > > >
> > > > On Wed, Mar 28, 2018 at 04:12:10PM +0000, Lars Ganrot wrote:
> > > > > Missed replying to the lists. Sorry.
> > > > >
> > > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > > Sent: 28. marts 2018 16:39
> > > > > >
> > > > > > On Wed, Mar 28, 2018 at 08:23:38AM +0000, Lars Ganrot wrote:
> > > > > > > Hi Michael et al
> > > > > > >
> > > > > > > > Behalf Of Michael S. Tsirkin
> > > > > > > > Sent: 9. marts 2018 22:24
> > > > > > > >
> > > > > > > > For a split ring, require that drivers use descriptors in order too.
> > > > > > > > This allows devices to skip reading the available ring.
> > > > > > > >
> > > > > > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > > > > > Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> > > > > > > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > > > > > ---
> > > > > > > [snip]
> > > > > > > >
> > > > > > > > +If VIRTIO_F_IN_ORDER has been negotiated, and when making a
> > > > > > > > +descriptor with VRING_DESC_F_NEXT set in \field{flags} at
> > > > > > > > +offset $x$ in the table available to the device, driver
> > > > > > > > +MUST set \field{next} to $0$ for the last descriptor in the
> > > > > > > > +table (where $x = queue\_size - 1$) and to $x + 1$ for the
> > > > > > > > +rest of the
> > > > descriptors.
> > > > > > > > +
> > > > > > > >  \subsubsection{Indirect Descriptors}\label{sec:Basic
> > > > > > > > Facilities of a Virtio Device / Virtqueues / The Virtqueue
> > > > > > > > Descriptor Table / Indirect Descriptors}
> > > > > > > >
> > > > > > > >  Some devices benefit by concurrently dispatching a large
> > > > > > > > number @@
> > > > > > > > -247,6
> > > > > > > > +257,10 @@ chained by \field{next}. An indirect descriptor
> > > > > > > > +without a valid
> > > > > > > > \field{next}  A single indirect descriptor  table can
> > > > > > > > include both
> > > > > > > > device- readable and device-writable descriptors.
> > > > > > > >
> > > > > > > > +If VIRTIO_F_IN_ORDER has been negotiated, indirect
> > > > > > > > +descriptors use sequential indices, in-order: index 0
> > > > > > > > +followed by index 1 followed by index 2, etc.
> > > > > > > > +
> > > > > > > >  \drivernormative{\paragraph}{Indirect Descriptors}{Basic
> > > > > > > > Facilities of a Virtio Device / Virtqueues / The Virtqueue
> > > > > > > > Descriptor Table / Indirect Descriptors} The driver MUST NOT
> > > > > > > > set the
> > > > > > VIRTQ_DESC_F_INDIRECT flag unless the
> > > > > > > >  VIRTIO_F_INDIRECT_DESC feature was negotiated.   The driver
> > MUST
> > > > > > NOT
> > > > > > > > @@ -259,6 +273,10 @@ the device.
> > > > > > > >  A driver MUST NOT set both VIRTQ_DESC_F_INDIRECT and
> > > > > > > > VIRTQ_DESC_F_NEXT  in \field{flags}.
> > > > > > > >
> > > > > > > > +If VIRTIO_F_IN_ORDER has been negotiated, indirect
> > > > > > > > +descriptors MUST appear sequentially, with \field{next}
> > > > > > > > +taking the value of
> > > > > > > > +1 for the 1st descriptor, 2 for the 2nd one, etc.
> > > > > > > > +
> > > > > > > >  \devicenormative{\paragraph}{Indirect Descriptors}{Basic
> > > > > > > > Facilities of a Virtio Device / Virtqueues / The Virtqueue
> > > > > > > > Descriptor Table / Indirect Descriptors} The device MUST
> > > > > > > > ignore the write-only flag
> > > > > > > > (\field{flags}\&VIRTQ_DESC_F_WRITE) in the descriptor that
> > > > > > > > refers to an indirect table.
> > > > > > > >
> > > > > > >
> > > > > > > The use of VIRTIO_F_IN_ORDER for split-ring can eliminate some
> > > > > > > accesses
> > > > > > to the virtq_avail.ring and virtq_used.ring. However I'm
> > > > > > wondering if the proposed descriptor ordering for multi-element
> > > > > > buffers couldn't be tweaked to be more HW friendly.  Currently
> > > > > > even with the VIRTIO_F_IN_ORDER negotiated, there is no way of
> > > > > > knowing if, or how many chained descriptors follow the
> > > > > > descriptor pointed to by the virtq_avail.idx. A chain has to be
> > > > > > inspected one descriptor at a time until
> > > > > > virtq_desc.flags[VIRTQ_DESC_F_NEXT]=0. This is awkward for HW
> > > > > > offload, where you want to DMA all available descriptors in one
> > > > > > shot, instead of iterating based on the contents of received DMA
> > > > > > data. As currently defined, HW would have to find a compromise
> > between likely chain length, and cost of additional DMA transfers.
> > > > > > This leads to a performance penalty for all chained descriptors,
> > > > > > and in case the length assumption is wrong the impact can be
> > significant.
> > > > > > >
> > > > > > > Now, what if the VIRTIO_F_IN_ORDER instead required chained
> > > > > > > buffers to
> > > > > > place the last element at the lowest index, and the head-element
> > > > > > (to which virtq_avail.idx points) at the highest index? Then all
> > > > > > the chained element descriptors would be included in a DMA of
> > > > > > the descriptor table from the previous virtq_avail.idx+1 to the
> > > > > > current
> > > > virtq_avail.idx. The "backward"
> > > > > > order of the chained descriptors shouldn't pose an issue as such
> > > > > > (at least not in HW).
> > > > > > >
> > > > > > > Best Regards,
> > > > > > >
> > > > > > > -Lars
> > > > > >
> > > > > > virtq_avail.idx is still an index into the available ring.
> > > > > >
> > > > > > I don't really see how you can use virtq_avail.idx to guess the
> > > > > > placement of a descriptor.
> > > > > >
> > > > > > I suspect the best way to optimize this is to include the
> > > > > > relevant data with the VIRTIO_F_NOTIFICATION_DATA feature.
> > > > > >
> > > > >
> > > > > Argh, naturally.
> > > >
> > > > BTW, for split rings VIRTIO_F_NOTIFICATION_DATA just copies the
> > > > index right now.
> > > >
> > > > Do you have an opinion on whether we should change that for in-order?
> > > >
> > >
> > > Maybe I should think more about this, however adding the last element
> > descriptor index, would be useful to accelerate interfaces that frequently
> > use chaining (from a HW DMA perspective at least).
> > >
> > > > > For HW offload I'd want to avoid notifications for buffer transfer
> > > > > from host
> > > > to device, and hoped to just poll virtq_avail.idx directly.
> > > > >
> > > > > A split virtqueue with VITRIO_F_IN_ORDER will maintain
> > > > virtq_avail.idx==virtq_avail.ring[idx] as long as there is no
> > > > chaining. It would be nice to allow negotiating away chaining, i.e
> > > > add a VIRTIO_F_NO_CHAIN. If negotiated, the driver agrees not to use
> > > > chaining, and as a result (of IN_ORDER and NO_CHAIN) both device and
> > > > driver can ignore the virtq_avail.ring[].
> > > >
> > > > My point was that device can just assume no chains, and then fall
> > > > back on doing extra reads upon encountering a chain.
> > > >
> > >
> > > Yes, you are correct that the HW can speculatively use virtq_avail.idx as the
> > >direct index to the descriptor table, and if it encounters a chain, revert to
> > >using the virtq_avail.ring[] in the traditional way, and this would work
> > >without the feature-bit.
> >
> > Sorry that was not my idea.
> >
> > Device should not need to read the ring at all.
> > It reads the descriptor table and counts the descriptors without the next bit.
> > Once the count reaches the available index, it stops.
> >
> 
> Agreed, that would work as well, with the benefit of keeping the ring out of
> the loop.
> 
> >
> > > However the driver would not be able to optimize away the writing of
> > > the virtq_avail.ring[] (=cache miss)
> >
> >
> > BTW writing is a separate question (there is no provision in the spec to skip
> > writes) but device does not have to read the ring.
> >
> 
> Yes, I understand the spec currently does not allow writes to be skipped, but
> I'm wondering if that ought to be reconsidered for optimization features such
> as IN_ORDER and NO_CHAIN?

Why not just use the packed ring then?

> By opting for such features, both driver and
> device acknowledge their willingness to accept reduced flexibility for
> improved performance. Why not then make sure they get the biggest bang for
> their buck? I would expect up to 20% improvement over PCIe (virtio-net,
> single 64B packet), if the device does not have to write to virtq_used.ring[] on
> transmit, and bandwidth over PCI is a very precious resource in e.g. virtual
> switch offload with east-west acceleration (for a discussion see Intel's white-
> paper 335625-001).

Haven't looked at it yet but we also need to consider the complexity,
see below.

> > Without device accesses ring will not be invaliated in cache so no misses
> > hopefully.
> >
> > > unless a NO_CHAIN feature has
> > > been negotiated.
> > > The IN_ORDER by itself has already eliminated the need to maintain the
> > > TX virtq_used.ring[], since the buffer order is always known by the
> > > driver.
> > > With a NO_CHAIN feature-bit both RX and TX virtq_avail.ring[] related
> > > cache-misses could be eliminated. I.e.
> > > looping a packet over a split virtqueue would just experience 7 driver
> > > cache misses, down from 10 in Virtio v1.0. Multi-element buffers would
> > > still be possible provided INDIRECT is negotiated.
> >
> >
> > NO_CHAIN might be a valid optimization, it is just unfortunately somewhat
> > narrow in that devices that need to mix write and read descriptors in the
> > same ring (e.g. storage) can not use this feature.
> >
> 
> Yes, if there was a way of making indirect buffers support it, that would be
> ideal. However I don't see how that can be done without inline headers in
> elements to hold their written length.

Kind of like it's done with with packed ring?

> At the same time storage would not be hurt by it even if they are unable to
> benefit from this particular optimization,

It will be hurt if it uses shared code paths which potentially
take up more cache, or if bugs are introduced.

> and as long as there is a substantial
> use case/space that benefit from an optimization, it ought to be considered.
> I believe virtual switching offload with virtio-net devices over PCIe is such a
> key use-case.

It looks like the packed ring addresses the need nicely,
while being device-independent.


> >
> > > >
> > > >
> > > > > >
> > > > > > > --------------------------------------------------------------
> > > > > > > ----
> > > > > > > --- To unsubscribe, e-mail:
> > > > > > > virtio-dev-unsubscribe@lists.oasis-open.org
> > > > > > > For additional commands, e-mail:
> > > > > > > virtio-dev-help@lists.oasis-open.org
> > > > >
> > > > > ------------------------------------------------------------------
> > > > > --- To unsubscribe, e-mail:
> > > > > virtio-dev-unsubscribe@lists.oasis-open.org
> > > > > For additional commands, e-mail:
> > > > > virtio-dev-help@lists.oasis-open.org
> > > Disclaimer: This email and any files transmitted with it may contain
> > confidential information intended for the addressee(s) only. The information
> > is not to be surrendered or copied to unauthorized persons. If you have
> > received this communication in error, please notify the sender immediately
> > and delete this e-mail from your system.
> >
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 
> Disclaimer: This email and any files transmitted with it may contain confidential information intended for the addressee(s) only. The information is not to be surrendered or copied to unauthorized persons. If you have received this communication in error, please notify the sender immediately and delete this e-mail from your system.

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

