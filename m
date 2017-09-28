Return-Path: virtio-dev-return-2575-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 32AE658180F8
	for <virtio-dev@lists.oasis-open.org>; Thu, 28 Sep 2017 14:27:23 -0700 (PDT)
Date: Fri, 29 Sep 2017 00:27:18 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170929001047-mutt-send-email-mst@kernel.org>
References: <20160915223915.qjlnlvf2w7u37bu3@redhat.com>
 <D0158A423229094DA7ABF71CF2FA0DA34E1A62C8@SHSMSX152.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D0158A423229094DA7ABF71CF2FA0DA34E1A62C8@SHSMSX152.ccr.corp.intel.com>
Subject: Re: [virtio-dev] packed ring layout proposal v3
To: "Liang, Cunming" <cunming.liang@intel.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Sep 21, 2017 at 01:36:37PM +0000, Liang, Cunming wrote:
> Hi,
> 
> > -----Original Message-----
> > From: virtio-dev@lists.oasis-open.org [mailto:virtio-dev@lists.oasis-open.org] On
> > Behalf Of Michael S. Tsirkin
> > Sent: Sunday, September 10, 2017 1:06 PM
> > To: virtio-dev@lists.oasis-open.org
> > Cc: virtualization@lists.linux-foundation.org
> > Subject: [virtio-dev] packed ring layout proposal v3
> > 
> [...]
> > * Batching descriptors:
> > 
> > virtio 1.0 allows passing a batch of descriptors in both directions, by incrementing
> > the used/avail index by values > 1.
> > At the moment only batching of used descriptors is used.
> > 
> > We can support this by chaining a list of device descriptors through
> > VRING_DESC_F_MORE flag. Device sets this bit to signal driver that this is part of
> > a batch of used descriptors which are all part of a single transaction.
> 
> It supposes each s/g chain represents for a packet, while each descriptor among batching chain represents for a packet. There're a few thoughts of batching chain(by VRING_DESC_F_MORE) and s/g chain(by VRING_DESC_F_NEXT).
> 
> - batching chain: It's up to device to coalesce the write-out of a batched used descriptors. As the batching size is variable, driver has to detect validity of each descriptor unless the number of incoming valid descriptor is predictable, being curious on the benefits of driver from VRING_DESC_F_MORE to take  batching descriptors as a single transaction. On device perspective, it's great to write out one descriptor for the whole chain. However, it assumes no other useful fields in each descriptor of chain needs to write. TX buffer reclaiming can be the candidate, while RX side has to update 'len' at least. Even for this purpose, instead of writing out VRING_DESC_F_MORE on a few descriptors to suppress device writing back, it's cheaper to set flag (e.g. VRING_DESC_F_WB) on single descriptor of chain to hint the expected position for device to write back.

But driver does not really benefit from batching and does not know how
many to batch, this depends on device. E.g. a software device does not
need batching at all, a pci express device would want batches to be
multiples of what fits in a pci express transaction, etc.  We would have
to provide that info from device to driver.

> - s/g chain: It makes sense to indicate the packet boundary. Considering in-order descriptor ring without VRING_DESC_F_INDIRECT, the next descriptor always belongs to the same s/g chain until end of packet indicators occur. So one alternative approach is only to set a flag (e.g. VRING_DESC_F_EOP) on the last descriptor of the chain. 

EOP would be the reverse of NEXT then? I think it does not matter much,
but NEXT matches what is there in virtio 1.0 right now. It also means that
simple implementations with short buffers can have flags set to 0 which
seems cleaner.


> > 
> > Driver might detect a partial descriptor chain (VRING_DESC_F_MORE set but next
> > descriptor not valid). In that case it must not use any parts of the chain - it will
> > later be completed by device, but driver is allowed to store the valid parts of the
> > chain as device is not allowed to change them anymore.
> As each descriptor represent for a whole packet(otherwise it's s/g chain),

For RX mergeable buffers, a packet is composed of multiple s/g chains.

> wondering why it must not use any parts of the chain. 

This is to match what is there in virtio 1.0 right now: driver
does not touch any used descriptors until the used index is updated.




> > 
> > Descriptor should not have both VRING_DESC_F_MORE and
> > VRING_DESC_F_NEXT set.
> > 
> [...]
> > 
> > * Selective use of descriptors
> > 
> > As described above, descriptors with NEXT bit set are part of a scatter/gather
> > chain and so do not have to cause device to write a used descriptor out.
> > 
> > Similarly, driver can set a flag VRING_DESC_F_MORE in the descriptor to signal to
> > device that it does not have to write out the used descriptor as it is part of a batch
> > of descriptors. Device has two options (similar to VRING_DESC_F_NEXT):
> > 
> > Device can write out the same number of descriptors for the batch, setting
> > VRING_DESC_F_MORE for all but the last descriptor.
> > Driver will ignore all used descriptors with VRING_DESC_F_MORE bit set.
> It will write out last descriptor without VRING_DESC_F_MORE anyway, so the following statement seems not like another option.

I don't understand this statement. All I said is that it's up to device
whether to write out the descriptors with VRING_DESC_F_MORE, or to skip
the write out.

> > 
> > Device only writes out a single descriptor for the whole batch.
> > However, to keep device and driver in sync, it then skips a number of descriptors
> > corresponding to the length of the batch before writing out the next used
> > descriptor.
> > After detecting a used descriptor driver must find out the length of the batch that
> > it built in order to know where to look for the next device descriptor.
> It would be good to keep it simple on device side, and to have the driver control the expectation.

I'm not sure what above means either.
That is exactly what above proposal says: device simply writes out a single
descriptor. Driver has to keep track and know where the next one will be
written.

Example

Driver writes two pairs chained with MORE: 0 + 1, 2 + 3
Device writes: 0 and 3






> > 
> > 
> > TODO (blocker): skipping descriptors for selective and scatter/gather seem to be
> > only requested with in-order right now. Let's require in-order for this skipping?
> > This will simplify the accounting by driver.
> > 
> > 
> 
> Thanks,
> Steve

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

