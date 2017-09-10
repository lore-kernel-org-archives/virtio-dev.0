Return-Path: virtio-dev-return-2519-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 8822D5819014
	for <virtio-dev@lists.oasis-open.org>; Sat,  9 Sep 2017 22:06:18 -0700 (PDT)
Date: Sun, 10 Sep 2017 08:06:15 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20160915223915.qjlnlvf2w7u37bu3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] packed ring layout proposal v3
To: virtio-dev@lists.oasis-open.org
Cc: virtualization@lists.linux-foundation.org
List-ID: <virtio-dev.lists.oasis-open.org>

This is an update from v2 version.
Changes:
- update event suppression mechanism
- add wrap counter: DESC_WRAP flag in addition to
  DESC_DRIVER flag used for validity so device does not have to
  write out all used descriptors.
- more options especially helpful for hardware implementations
- in-order processing option due to popular demand
- list of TODO items to consider as a follow-up, only two are
  open questions we need to descide now, marked as blocker,
  others are future enhancement ideas.

---

Performance analysis of this is in my kvm forum 2016 presentation.
The idea is to have a r/w descriptor in a ring structure,
replacing the used and available ring, index and descriptor
buffer.

Note: the following mode of operation will actually work
without changes when descriptor rings do not overlap, with driver
writing out available entries in a read-only driver descriptor ring,
device writing used entries in a write-only device descriptor ring.

TODO: does this have any value for some? E.g. as a security feature?


* Descriptor ring:

Driver writes descriptors with unique index values and DESC_DRIVER set in flags.
Descriptors are written in a ring order: from start to end of ring,
wrapping around to the beginning.
Device writes used descriptors with correct len, index, and DESC_HW clear.
Again descriptors are written in ring order. This might not be the same
order of driver descriptors, and not all descriptors have to be written out.

Driver and device are expected to maintain (internally) a wrap-around
bit, starting at 0 and changing value each time they start writing out
descriptors at the beginning of the ring. This bit is passed as
DESC_WRAP bit in the flags field.

Flags are always set/cleared last.

Note that driver can write descriptors out in any order, but device
will not execute descriptor X+1 until descriptor X has been
read as valid.

Driver operation:

Driver makes descriptors available to device by writing out descriptors
in the descriptor ring. Once ring is full, driver waits for device to
use some descriptors before making more available.

Descriptors can be used by device in any order, but must be read from
ring in-order, and must be read completely before starting use.  Thus,
once a descriptor is used, driver can over-write both this descriptor
and any descriptors which preceded it in the ring.

Driver can detect use of descriptor either by device specific means
(e.g. detect a buffer data change by device) or in a generic way
by detecting that a used buffer has been written out by device.


Driver writes out available scatter/gather descriptor entries in guest
descriptor format:


#define DESC_WRAP 0x0040
#define DESC_DRIVER 0x0080

struct desc {
        __le64 addr;
        __le32 len;
        __le16 index;
        __le16 flags;
};

Fields:

addr - physical address of a s/g entry
len - length of an entry
index - unique index.  The low $\lceil log(N) \rceil - 1$
      bits of the index is a driver-supplied value which can have any value
      (under driver control).  The high bits are reserved and should be
      set to 0.

flags - descriptor flags.

Descriptors written by driver have DESC_DRIVER set.

Writing out this field makes the descriptor available for the device to use,
so all other fields must be valid when it is written.

DESC_WRAP - device uses this field to detect descriptor change by driver.

Driver can use 1 bit to set direction
/* This marks a descriptor as write-only (otherwise read-only). */
#define VRING_DESC_F_WRITE      2


Device operation (using descriptors):

Device is looking for descriptors in ring order. After detecting that
the flags value has changed with DESC_DRIVER set and DESC_WRAP matching
the wrap-around counter, it can start using the descriptors.
Descriptors can be used in any order, but must be read from ring
in-order.  In other words device must not read descriptor X after it
started using descriptor X+1.  Further, all buffer descriptors must be
read completely before device starts using the buffer.

This because once a descriptor is used, driver can over-write both this
descriptor and any preceeding descriptors in ring.

To help driver detect use of descriptors and to pass extra meta-data
to driver, device writes out used entries in device descriptor format:


#define DESC_WRAP 0x0040
#define DESC_DRIVER 0x0080

struct desc {
        __le64 reserved;
        __le32 len;
        __le16 index;
        __le16 flags;
};

Fields:

reserved - can be any value, ignored by driver
len - length written by device. only valid if VRING_DESC_F_WRITE is set
      len bytes of data from beginning of buffer are assumed to have been updated
index - unique index copied from the driver descriptor that has been used.
flags - descriptor flags.

Descriptors written by device have DESC_DRIVER clear.

Writing out this field notifies the driver that it can re-use the
descriptor id. It is also a signal that driver can over-write the
relevant descriptor (with the supplied id), and any other

DESC_WRAP - driver uses this field to detect descriptor change by device.

If device has used a buffer containing a write descriptor, it sets this bit:
#define VRING_DESC_F_WRITE      2

* Driver scatter/gather support

Driver can use 1 bit to chain s/g entries in a request, similar to virtio 1.0:

/* This marks a buffer as continuing in the next ring entry. */
#define VRING_DESC_F_NEXT       1

When driver descriptors are chained in this way, multiple
descriptors are treated as a part of a single transaction
containing an optional write buffer followed by an optional read buffer.
All descriptors in the chain must have the same ID.

Unlike virtio 1.0, use of this flag will be an optional feature
so both devices and drivers can opt out of it.
If they do, they can either negotiate indirect descriptors or use
single-descriptor entries exclusively for buffers.

Device might detect a partial descriptor chain (VRING_DESC_F_NEXT
set but next descriptor not valid). In that case it must not
use any parts of the chain - it will later be completed by driver,
but device is allowed to store the valid parts of the chain as
driver is not allowed to change them anymore.

Two options are available:

Device can write out the same number of descriptors for the chain,
setting VRING_DESC_F_NEXT for all but the last descriptor.
Driver will ignore all used descriptors with VRING_DESC_F_NEXT bit set.

Device only writes out a single descriptor for the whole chain.
However, to keep device and driver in sync, it then skips a number of
descriptors corresponding to the length of the chain before writing out
the next used descriptor.
After detecting a used descriptor driver must find out the length of the
chain that it built in order to know where to look for the next
device descriptor.

* Indirect buffers

Indirect buffer descriptors is an optional feature.
These are always written by driver, not the device.
Indirect buffers have a special flag bit set - like in virtio 1.0:

/* This means the buffer contains a table of buffer descriptors. */
#define VRING_DESC_F_INDIRECT   4

VRING_DESC_F_WRITE and VRING_DESC_F_NEXT are always clear.

len specifies the length of the indirect descriptor buffer in bytes
and must be a multiple of 16.

Unlike virtio 1.0, the buffer pointed to is a table, not a list:
struct indirect_descriptor_table {
        /* The actual descriptors (16 bytes each) */
        struct indirect_desc desc[len / 16];
};

The first descriptor is located at start of the indirect descriptor
table, additional indirect descriptors come immediately afterwards.

struct indirect_desc {
        __le64 addr;
        __le32 len;
        __le16 reserved;
        __le16 flags;
};


DESC_F_WRITE is the only valid flag for descriptors in the indirect
table. Others should be set to 0 and are ignored.  reserved field is
also set to 0 and should be ignored.

TODO (blocker): virtio 1.0 allows a s/g entry followed by
      an indirect descriptor. Is this useful?

This support would be an optional feature, same as in virtio 1.0

* Batching descriptors:

virtio 1.0 allows passing a batch of descriptors in both directions, by
incrementing the used/avail index by values > 1.
At the moment only batching of used descriptors is used.

We can support this by chaining a list of device descriptors through
VRING_DESC_F_MORE flag. Device sets this bit to signal
driver that this is part of a batch of used descriptors
which are all part of a single transaction.

Driver might detect a partial descriptor chain (VRING_DESC_F_MORE
set but next descriptor not valid). In that case it must not
use any parts of the chain - it will later be completed by device,
but driver is allowed to store the valid parts of the chain as
device is not allowed to change them anymore.

Descriptor should not have both VRING_DESC_F_MORE and
VRING_DESC_F_NEXT set.

* Using descriptors in order

Some devices can guarantee that descriptors are used in
the order in which they were made available.
This allows driver optimizations and can be negotiated through
a feature bit.

* Per ring flags

It is useful to support features for some rings but not others.
E.g. it's reasonable to use single buffers for RX rings but
sg or indirect for TX rings of the network device.
Generic configuration space will be extended so features can
be negotiated per ring.

* Selective use of descriptors

As described above, descriptors with NEXT bit set are part of a
scatter/gather chain and so do not have to cause device to write a used
descriptor out.

Similarly, driver can set a flag VRING_DESC_F_MORE in the descriptor to
signal to device that it does not have to write out the used descriptor
as it is part of a batch of descriptors. Device has two options (similar
to VRING_DESC_F_NEXT):

Device can write out the same number of descriptors for the batch,
setting VRING_DESC_F_MORE for all but the last descriptor.
Driver will ignore all used descriptors with VRING_DESC_F_MORE bit set.

Device only writes out a single descriptor for the whole batch.
However, to keep device and driver in sync, it then skips a number of
descriptors corresponding to the length of the batch before writing out
the next used descriptor.
After detecting a used descriptor driver must find out the length of the
batch that it built in order to know where to look for the next
device descriptor.


TODO (blocker): skipping descriptors for selective and
scatter/gather seem to be only requested with in-order right now. Let's
require in-order for this skipping?  This will simplify the accounting
by driver.


* Interrupt/event suppression

virtio 1.0 has two mechanisms for suppression but only
one can be used at a time. we pack them together
in a structure - one for interrupts, one for notifications:

struct event {
	__le16 idx;
	__le16 flags;
}

Both fields would be optional, with a feature bit:
VIRTIO_F_EVENT_IDX
VIRTIO_F_EVENT_FLAGS

Flags can be used like in virtio 1.0, by storing a special
value there:

#define VRING_F_EVENT_ENABLE  0x0

#define VRING_F_EVENT_DISABLE 0x1

Event index includes the index of the descriptor
which should trigger the event, and the wrap counter
in the high bit.

In that case, interrupt triggers when descriptor is written at a given
location in the ring (or skipped in case of NEXT/MORE).

If both features are negotiated, a special flags value
can be used to switch to event idx:

#define VRING_F_EVENT_IDX     0x2

* Available notification

Driver currently writes out the queue number to device to
kick off ring processing.

As queue number is currently 16 bit, we can extend that
to additionally include the offset within ring of the descriptor
which triggered the kick event in bits 16 to 30,
and the wrap counter in the high bit (31).

Device is allowed to pre-fetch descriptors beyond the specified
offset but is not required to do so.



* TODO: interrupt coalescing

Does it make sense just for networking or for all devices?
If later should we make it a per ring or a global feature?


* TODO: event index/flags in device memory?

Should we move the event index/flags to device memory?
Might be helpful for hardware configuration so they do not
need to do DMA reads to check whether interrupt is needed.
OTOH maybe interrupt coalescing is sufficient for this.


* TODO: Device specific descriptor flags

We have a lot of unused space in the descriptor.  This can be put to
good use by reserving some flag bits for device use.
For example, network device can set a bit to request
that header in the descriptor is suppressed
(in case it's all 0s anyway). This reduces cache utilization.

Note: this feature can be supported in virtio 1.0 as well,
as we have unused bits in both descriptor and used ring there.

* TODO: Descriptor length in device descriptors

Some devices use identically-sized buffers in all descriptors.
Ignoring length for driver descriptors there could be an option too.

* TODO: Writing at an offset

Some devices might want to write into some descriptors
at an offset, the offset would be in reserved field in the descriptor,
possibly a descriptor flag could indicate this:

#define VRING_DESC_F_OFFSET 0x0020

How exactly to use the offset would be device specific,
for example it can be used to align beginning of packet
in the 1st buffer for mergeable buffers to cache line boundary
while also aligning rest of buffers.

* TODO: Non power-of-2 ring sizes

As the ring simply wraps around, there's no reason to
require ring size to be power of two.
It can be made a separate feature though.


TODO: limits on buffer alignment/size

Seems to be useful for RX for networking.
Is there a need to negotiate above in a generic way
or is this a networking specific optimization?

TODO: expose wrap counters to device for debugging

TODO: expose last avail/used offsets to device/driver for debugging

TODO: ability to reset individual rings

---

Note: should this proposal be accepted and approved, one or more
      claims disclosed to the TC admin and listed on the Virtio TC
      IPR page https://www.oasis-open.org/committees/virtio/ipr.php
      might become Essential Claims.
Note: the page above is unfortunately out of date and out of
      my hands. I'm in the process of updating ipr disclosures
      in github instead.  Will make sure all is in place before
      this proposal is put to vote. As usual this TC operates under the
      Non-Assertion Mode of the OASIS IPR Policy, which protects
      anyone implementing the virtio spec.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

