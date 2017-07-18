Return-Path: virtio-dev-return-2405-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id C2B585818041
	for <virtio-dev@lists.oasis-open.org>; Tue, 18 Jul 2017 09:23:15 -0700 (PDT)
Date: Tue, 18 Jul 2017 19:23:11 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170718172312-mutt-send-email-mst@kernel.org>
References: <20160915223915.qjlnlvf2w7u37bu3@redhat.com>
 <DB5PR05MB176690DF180908ABCDDA0860D3A30@DB5PR05MB1766.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB5PR05MB176690DF180908ABCDDA0860D3A30@DB5PR05MB1766.eurprd05.prod.outlook.com>
Subject: Re: [virtio-dev] packed ring layout proposal v2
To: Lior Narkis <liorn@mellanox.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, Jul 16, 2017 at 06:00:45AM +0000, Lior Narkis wrote:
> > -----Original Message-----
> > From: virtio-dev@lists.oasis-open.org [mailto:virtio-dev@lists.oasis-open.org]
> > On Behalf Of Michael S. Tsirkin
> > Sent: Wednesday, February 08, 2017 5:20 AM
> > To: virtio-dev@lists.oasis-open.org
> > Cc: virtualization@lists.linux-foundation.org
> > Subject: [virtio-dev] packed ring layout proposal v2
> > 
> > This is an update from v1 version.
> > Changes:
> > - update event suppression mechanism
> > - separate options for indirect and direct s/g
> > - lots of new features
> > 
> > ---
> > 
> > Performance analysis of this is in my kvm forum 2016 presentation.
> > The idea is to have a r/w descriptor in a ring structure,
> > replacing the used and available ring, index and descriptor
> > buffer.
> > 
> > * Descriptor ring:
> > 
> > Guest adds descriptors with unique index values and DESC_HW set in flags.
> > Host overwrites used descriptors with correct len, index, and DESC_HW
> > clear.  Flags are always set/cleared last.
> > 
> > #define DESC_HW 0x0080
> > 
> > struct desc {
> >         __le64 addr;
> >         __le32 len;
> >         __le16 index;
> >         __le16 flags;
> > };
> > 
> > When DESC_HW is set, descriptor belongs to device. When it is clear,
> > it belongs to the driver.
> > 
> > We can use 1 bit to set direction
> > /* This marks a buffer as write-only (otherwise read-only). */
> > #define VRING_DESC_F_WRITE      2
> > 
> 
> A valid bit per descriptor does not let the device do an efficient prefetch.
> An alternative is to use a producer index(PI).
> Using the PI posted by the driver, and the Consumer Index(CI) maintained by the device, the device knows how much work it has outstanding, so it can do the prefetch accordingly. 
> There are few options for the device to acquire the PI.
> Most efficient will be to write the PI in the doorbell together with the queue number.

Right. This was suggested in "Fwd: Virtio-1.1 Ring Layout".
Or just the PI if we don't need the queue number.

> I would like to raise the need for a Completion Queue(CQ).
> Multiple Work Queues(hold the work descriptors, WQ in short) can be connected to a single CQ.
> So when the device completes the work on the descriptor, it writes a Completion Queue Entry (CQE) to the CQ.

This seems similar to the design we currently have with a separate used
ring. It seems to underperform writing into the available ring
at least on a microbenchmark. The reason seems to be that
more cache lines need to get invalidated and re-fetched.

> CQEs are continuous in memory so prefetching by the driver is efficient, although the device might complete work descriptors out of order.

That's not different from proposal you are replying to - descriptors
can be used and written out in any order, they are contigious
so driver can prefetch. I'd like to add that attempts to
add prefetch e.g. for the virtio used ring never showed any
conclusive gains - some workloads would get minor a speedup, others
lose a bit of performance. I do not think anyone looked
deeply into why that was the case. It would be easy for you to add this
code to current virtio drivers and/or devices and try it out.

> The interrupt handler is connected to the CQ, so an allocation of a single CQ per core, with a single interrupt handler is possible although this core might be using multiple WQs.

Sending a single interrupt from multiple rings might save some
cycles. event index/interrupt disable are currently in
RAM so access is very cheap for the guest.
If you are going to share, just disable all interrupts
when you start processing.

I was wondering how do people want to do this in hardware
in fact. Are you going to read event index after each descriptor?

It might make sense to move event index/flags into device memory. And
once you do this, writing these out might become slower, and then some
kind of sharing of the event index might help.

No one suggested anything like this so far - maybe it's less of an issue
than I think, e.g. because of interrupt coalescing (which virtio also
does not have, but could be added if there is interest) or maybe people
just mostly care about polling performance.

> One application for multiple WQs with a single CQ is Quality of Service(QoS).
> A user can open a WQ per QoS value(pcp value for example), and the device will schedule the work accordingly.

A ring per QOS level might make sense e.g. in a network device. I don't
see why it's helpful to write out completed entries into a separate
ring for that though.

As we don't have QOS support in virtio net at all right now,
would that be best discussed once we have a working prototype
and everyone can see what the problem is?


> > * Scatter/gather support
> > 
> > We can use 1 bit to chain s/g entries in a request, same as virtio 1.0:
> > 
> > /* This marks a buffer as continuing via the next field. */
> > #define VRING_DESC_F_NEXT       1
> > 
> > Unlike virtio 1.0, all descriptors must have distinct ID values.
> > 
> > Also unlike virtio 1.0, use of this flag will be an optional feature
> > (e.g. VIRTIO_F_DESC_NEXT) so both devices and drivers can opt out of it.
> > 
> > * Indirect buffers
> > 
> > Can be marked like in virtio 1.0:
> > 
> > /* This means the buffer contains a table of buffer descriptors. */
> > #define VRING_DESC_F_INDIRECT   4
> > 
> > Unlike virtio 1.0, this is a table, not a list:
> > struct indirect_descriptor_table {
> >         /* The actual descriptors (16 bytes each) */
> >         struct virtq_desc desc[len / 16];
> > };
> > 
> > The first descriptor is located at start of the indirect descriptor
> > table, additional indirect descriptors come immediately afterwards.
> > DESC_F_WRITE is the only valid flag for descriptors in the indirect
> > table. Others should be set to 0 and are ignored.  id is also set to 0
> > and should be ignored.
> > 
> > virtio 1.0 seems to allow a s/g entry followed by
> > an indirect descriptor. This does not seem useful,
> > so we do not allow that anymore.
> > 
> > This support would be an optional feature, same as in virtio 1.0
> > 
> > * Batching descriptors:
> > 
> > virtio 1.0 allows passing a batch of descriptors in both directions, by
> > incrementing the used/avail index by values > 1.  We can support this by
> > chaining a list of descriptors through a bit the flags field.
> > To allow use together with s/g, a different bit will be used.
> > 
> > #define VRING_DESC_F_BATCH_NEXT 0x0010
> > 
> > Batching works for both driver and device descriptors.
> > 
> > 
> > 
> > * Processing descriptors in and out of order
> > 
> > Device processing all descriptors in order can simply flip
> > the DESC_HW bit as it is done with descriptors.
> > 
> > Device can write descriptors out in order as they are used, overwriting
> > descriptors that are there.
> > 
> > Device must not use a descriptor until DESC_HW is set.
> > It is only required to look at the first descriptor
> > submitted.
> > 
> > Driver must not overwrite a descriptor until DESC_HW is clear.
> > It is only required to look at the first descriptor
> > submitted.
> > 
> > * Device specific descriptor flags
> > We have a lot of unused space in the descriptor.  This can be put to
> > good use by reserving some flag bits for device use.
> > For example, network device can set a bit to request
> > that header in the descriptor is suppressed
> > (in case it's all 0s anyway). This reduces cache utilization.
> > 
> > Note: this feature can be supported in virtio 1.0 as well,
> > as we have unused bits in both descriptor and used ring there.
> > 
> > * Descriptor length in device descriptors
> > 
> > virtio 1.0 places strict requirements on descriptor length. For example
> > it must be 0 in used ring of TX VQ of a network device since nothing is
> > written.  In practice guests do not seem to use this, so we can simplify
> > devices a bit by removing this requirement - if length is unused it
> > should be ignored by driver.
> > 
> > Some devices use identically-sized buffers in all descriptors.
> > Ignoring length for driver descriptors there could be an option too.
> > 
> > * Writing at an offset
> > 
> > Some devices might want to write into some descriptors
> > at an offset, the offset would be in config space,
> > and a descriptor flag could indicate this:
> > 
> > #define VRING_DESC_F_OFFSET 0x0020
> > 
> > How exactly to use the offset would be device specific,
> > for example it can be used to align beginning of packet
> > in the 1st buffer for mergeable buffers to cache line boundary
> > while also aligning rest of buffers.
> > 
> > * Non power-of-2 ring sizes
> > 
> > As the ring simply wraps around, there's no reason to
> > require ring size to be power of two.
> > It can be made a separate feature though.
> > 
> > 
> > * Interrupt/event suppression
> > 
> > virtio 1.0 has two mechanisms for suppression but only
> > one can be used at a time. we pack them together
> > in a structure - one for interrupts, one for notifications:
> > 
> > struct event {
> > 	__le16 idx;
> > 	__le16 flags;
> > }
> > 
> > Both fields would be optional, with a feature bit:
> > VIRTIO_F_EVENT_IDX
> > VIRTIO_F_EVENT_FLAGS
> > 
> > * Flags can be used like in virtio 1.0, by storing a special
> > value there:
> > 
> > #define VRING_F_EVENT_ENABLE  0x0
> > 
> > #define VRING_F_EVENT_DISABLE 0x1
> > 
> > * Event index would be in the range 0 to 2 * Queue Size
> > (to detect wrap arounds) and wrap to 0 after that.
> > 
> > The assumption is that each side maintains an internal
> > descriptor counter 0 to 2 * Queue Size that wraps to 0.
> > In that case, interrupt triggers when counter reaches
> > the given value.
> > 
> > * If both features are negotiated, a special flags value
> > can be used to switch to event idx:
> > 
> > #define VRING_F_EVENT_IDX     0x2
> > 
> > 
> > * Prototype
> > 
> > A partial prototype can be found under
> > tools/virtio/ringtest/ring.c
> > 
> > Test run:
> > [mst@tuck ringtest]$ time ./ring
> > real    0m0.399s
> > user    0m0.791s
> > sys     0m0.000s
> > [mst@tuck ringtest]$ time ./virtio_ring_0_9
> > real    0m0.503s
> > user    0m0.999s
> > sys     0m0.000s
> > 
> > It is planned to update it to this interface. Future changes and
> > enhancements can (and should) be tested against this prototype.
> > 
> > * Feature sets
> > In particular are we going overboard with feature bits?  It becomes hard
> > to support all combinations in drivers and devices.  Maybe we should
> > document reasonable feature sets to be supported for each device.
> > 
> > * Known issues/ideas
> > 
> > This layout is optimized for host/guest communication,
> > in a sense even more aggressively than virtio 1.0.
> > It might be suboptimal for PCI hardware implementations.
> > However, one notes that current virtio pci drivers are
> > unlikely to work with PCI hardware implementations anyway
> > (e.g. due to use of SMP barriers for ordering).
> > 
> > Suggestions for improving this are welcome but need to be tested to make
> > sure our main use case does not regress.  Of course some improvements
> > might be made optional, but if we add too many of these driver becomes
> > unmanageable.
> > 
> > ---
> > 
> > Note: should this proposal be accepted and approved, one or more
> >       claims disclosed to the TC admin and listed on the Virtio TC
> >       IPR page
> > https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fww
> > w.oasis-
> > open.org%2Fcommittees%2Fvirtio%2Fipr.php&data=02%7C01%7Cliorn%40m
> > ellanox.com%7Cf41239019c1441e73b0308d4c7b0a483%7Ca652971c7d2e4d9
> > ba6a4d149256f461b%7C0%7C0%7C636353008872143792&sdata=L946V5o0P
> > k8th%2B2IkHgvALmhnIEWD9hcMZvMxLetavc%3D&reserved=0
> >       might become Essential Claims.
> > 
> > --
> > MST
> > 
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

