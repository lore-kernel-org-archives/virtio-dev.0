Return-Path: virtio-dev-return-2400-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id B7E4558182DF
	for <virtio-dev@lists.oasis-open.org>; Sat, 15 Jul 2017 23:00:50 -0700 (PDT)
From: Lior Narkis <liorn@mellanox.com>
Date: Sun, 16 Jul 2017 06:00:45 +0000
Message-ID: <DB5PR05MB176690DF180908ABCDDA0860D3A30@DB5PR05MB1766.eurprd05.prod.outlook.com>
References: <20160915223915.qjlnlvf2w7u37bu3@redhat.com>
In-Reply-To: <20160915223915.qjlnlvf2w7u37bu3@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: RE: [virtio-dev] packed ring layout proposal v2
To: "Michael S. Tsirkin" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-ID: <virtio-dev.lists.oasis-open.org>

> -----Original Message-----
> From: virtio-dev@lists.oasis-open.org [mailto:virtio-dev@lists.oasis-open=
.org]
> On Behalf Of Michael S. Tsirkin
> Sent: Wednesday, February 08, 2017 5:20 AM
> To: virtio-dev@lists.oasis-open.org
> Cc: virtualization@lists.linux-foundation.org
> Subject: [virtio-dev] packed ring layout proposal v2
>=20
> This is an update from v1 version.
> Changes:
> - update event suppression mechanism
> - separate options for indirect and direct s/g
> - lots of new features
>=20
> ---
>=20
> Performance analysis of this is in my kvm forum 2016 presentation.
> The idea is to have a r/w descriptor in a ring structure,
> replacing the used and available ring, index and descriptor
> buffer.
>=20
> * Descriptor ring:
>=20
> Guest adds descriptors with unique index values and DESC_HW set in flags.
> Host overwrites used descriptors with correct len, index, and DESC_HW
> clear.  Flags are always set/cleared last.
>=20
> #define DESC_HW 0x0080
>=20
> struct desc {
>         __le64 addr;
>         __le32 len;
>         __le16 index;
>         __le16 flags;
> };
>=20
> When DESC_HW is set, descriptor belongs to device. When it is clear,
> it belongs to the driver.
>=20
> We can use 1 bit to set direction
> /* This marks a buffer as write-only (otherwise read-only). */
> #define VRING_DESC_F_WRITE      2
>=20

A valid bit per descriptor does not let the device do an efficient prefetch=
.
An alternative is to use a producer index(PI).
Using the PI posted by the driver, and the Consumer Index(CI) maintained by=
 the device, the device knows how much work it has outstanding, so it can d=
o the prefetch accordingly.=20
There are few options for the device to acquire the PI.
Most efficient will be to write the PI in the doorbell together with the qu=
eue number.

I would like to raise the need for a Completion Queue(CQ).
Multiple Work Queues(hold the work descriptors, WQ in short) can be connect=
ed to a single CQ.
So when the device completes the work on the descriptor, it writes a Comple=
tion Queue Entry (CQE) to the CQ.
CQEs are continuous in memory so prefetching by the driver is efficient, al=
though the device might complete work descriptors out of order.
The interrupt handler is connected to the CQ, so an allocation of a single =
CQ per core, with a single interrupt handler is possible although this core=
 might be using multiple WQs.

One application for multiple WQs with a single CQ is Quality of Service(QoS=
).
A user can open a WQ per QoS value(pcp value for example), and the device w=
ill schedule the work accordingly.

> * Scatter/gather support
>=20
> We can use 1 bit to chain s/g entries in a request, same as virtio 1.0:
>=20
> /* This marks a buffer as continuing via the next field. */
> #define VRING_DESC_F_NEXT       1
>=20
> Unlike virtio 1.0, all descriptors must have distinct ID values.
>=20
> Also unlike virtio 1.0, use of this flag will be an optional feature
> (e.g. VIRTIO_F_DESC_NEXT) so both devices and drivers can opt out of it.
>=20
> * Indirect buffers
>=20
> Can be marked like in virtio 1.0:
>=20
> /* This means the buffer contains a table of buffer descriptors. */
> #define VRING_DESC_F_INDIRECT   4
>=20
> Unlike virtio 1.0, this is a table, not a list:
> struct indirect_descriptor_table {
>         /* The actual descriptors (16 bytes each) */
>         struct virtq_desc desc[len / 16];
> };
>=20
> The first descriptor is located at start of the indirect descriptor
> table, additional indirect descriptors come immediately afterwards.
> DESC_F_WRITE is the only valid flag for descriptors in the indirect
> table. Others should be set to 0 and are ignored.  id is also set to 0
> and should be ignored.
>=20
> virtio 1.0 seems to allow a s/g entry followed by
> an indirect descriptor. This does not seem useful,
> so we do not allow that anymore.
>=20
> This support would be an optional feature, same as in virtio 1.0
>=20
> * Batching descriptors:
>=20
> virtio 1.0 allows passing a batch of descriptors in both directions, by
> incrementing the used/avail index by values > 1.  We can support this by
> chaining a list of descriptors through a bit the flags field.
> To allow use together with s/g, a different bit will be used.
>=20
> #define VRING_DESC_F_BATCH_NEXT 0x0010
>=20
> Batching works for both driver and device descriptors.
>=20
>=20
>=20
> * Processing descriptors in and out of order
>=20
> Device processing all descriptors in order can simply flip
> the DESC_HW bit as it is done with descriptors.
>=20
> Device can write descriptors out in order as they are used, overwriting
> descriptors that are there.
>=20
> Device must not use a descriptor until DESC_HW is set.
> It is only required to look at the first descriptor
> submitted.
>=20
> Driver must not overwrite a descriptor until DESC_HW is clear.
> It is only required to look at the first descriptor
> submitted.
>=20
> * Device specific descriptor flags
> We have a lot of unused space in the descriptor.  This can be put to
> good use by reserving some flag bits for device use.
> For example, network device can set a bit to request
> that header in the descriptor is suppressed
> (in case it's all 0s anyway). This reduces cache utilization.
>=20
> Note: this feature can be supported in virtio 1.0 as well,
> as we have unused bits in both descriptor and used ring there.
>=20
> * Descriptor length in device descriptors
>=20
> virtio 1.0 places strict requirements on descriptor length. For example
> it must be 0 in used ring of TX VQ of a network device since nothing is
> written.  In practice guests do not seem to use this, so we can simplify
> devices a bit by removing this requirement - if length is unused it
> should be ignored by driver.
>=20
> Some devices use identically-sized buffers in all descriptors.
> Ignoring length for driver descriptors there could be an option too.
>=20
> * Writing at an offset
>=20
> Some devices might want to write into some descriptors
> at an offset, the offset would be in config space,
> and a descriptor flag could indicate this:
>=20
> #define VRING_DESC_F_OFFSET 0x0020
>=20
> How exactly to use the offset would be device specific,
> for example it can be used to align beginning of packet
> in the 1st buffer for mergeable buffers to cache line boundary
> while also aligning rest of buffers.
>=20
> * Non power-of-2 ring sizes
>=20
> As the ring simply wraps around, there's no reason to
> require ring size to be power of two.
> It can be made a separate feature though.
>=20
>=20
> * Interrupt/event suppression
>=20
> virtio 1.0 has two mechanisms for suppression but only
> one can be used at a time. we pack them together
> in a structure - one for interrupts, one for notifications:
>=20
> struct event {
> 	__le16 idx;
> 	__le16 flags;
> }
>=20
> Both fields would be optional, with a feature bit:
> VIRTIO_F_EVENT_IDX
> VIRTIO_F_EVENT_FLAGS
>=20
> * Flags can be used like in virtio 1.0, by storing a special
> value there:
>=20
> #define VRING_F_EVENT_ENABLE  0x0
>=20
> #define VRING_F_EVENT_DISABLE 0x1
>=20
> * Event index would be in the range 0 to 2 * Queue Size
> (to detect wrap arounds) and wrap to 0 after that.
>=20
> The assumption is that each side maintains an internal
> descriptor counter 0 to 2 * Queue Size that wraps to 0.
> In that case, interrupt triggers when counter reaches
> the given value.
>=20
> * If both features are negotiated, a special flags value
> can be used to switch to event idx:
>=20
> #define VRING_F_EVENT_IDX     0x2
>=20
>=20
> * Prototype
>=20
> A partial prototype can be found under
> tools/virtio/ringtest/ring.c
>=20
> Test run:
> [mst@tuck ringtest]$ time ./ring
> real    0m0.399s
> user    0m0.791s
> sys     0m0.000s
> [mst@tuck ringtest]$ time ./virtio_ring_0_9
> real    0m0.503s
> user    0m0.999s
> sys     0m0.000s
>=20
> It is planned to update it to this interface. Future changes and
> enhancements can (and should) be tested against this prototype.
>=20
> * Feature sets
> In particular are we going overboard with feature bits?  It becomes hard
> to support all combinations in drivers and devices.  Maybe we should
> document reasonable feature sets to be supported for each device.
>=20
> * Known issues/ideas
>=20
> This layout is optimized for host/guest communication,
> in a sense even more aggressively than virtio 1.0.
> It might be suboptimal for PCI hardware implementations.
> However, one notes that current virtio pci drivers are
> unlikely to work with PCI hardware implementations anyway
> (e.g. due to use of SMP barriers for ordering).
>=20
> Suggestions for improving this are welcome but need to be tested to make
> sure our main use case does not regress.  Of course some improvements
> might be made optional, but if we add too many of these driver becomes
> unmanageable.
>=20
> ---
>=20
> Note: should this proposal be accepted and approved, one or more
>       claims disclosed to the TC admin and listed on the Virtio TC
>       IPR page
> https://emea01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fww
> w.oasis-
> open.org%2Fcommittees%2Fvirtio%2Fipr.php&data=3D02%7C01%7Cliorn%40m
> ellanox.com%7Cf41239019c1441e73b0308d4c7b0a483%7Ca652971c7d2e4d9
> ba6a4d149256f461b%7C0%7C0%7C636353008872143792&sdata=3DL946V5o0P
> k8th%2B2IkHgvALmhnIEWD9hcMZvMxLetavc%3D&reserved=3D0
>       might become Essential Claims.
>=20
> --
> MST
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

