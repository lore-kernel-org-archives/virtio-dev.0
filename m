Return-Path: virtio-dev-return-2647-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 7A9565819000
	for <virtio-dev@lists.oasis-open.org>; Wed,  1 Nov 2017 20:40:18 -0700 (PDT)
Date: Thu, 2 Nov 2017 05:40:12 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171101214417-mutt-send-email-mst@kernel.org>
References: <20171029125225.lx4ezpkbvjjsjv3x@localhost.localdomain>
 <20171101162357-mutt-send-email-mst@kernel.org>
 <AM4PR0501MB2723D56ED113A7B98D3785F0D45F0@AM4PR0501MB2723.eurprd05.prod.outlook.com>
 <20171101190219-mutt-send-email-mst@kernel.org>
 <AM4PR0501MB2723A2C058045E70A66959B3D45F0@AM4PR0501MB2723.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM4PR0501MB2723A2C058045E70A66959B3D45F0@AM4PR0501MB2723.eurprd05.prod.outlook.com>
Subject: [virtio-dev] Re: Virtio BoF minutes from KVM Forum 2017
To: Ilya Lesokhin <ilyal@mellanox.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Jens Freimann <jfreimann@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Nov 01, 2017 at 06:12:09PM +0000, Ilya Lesokhin wrote:
> On Wednesday, November 1, 2017 7:35 PM, Michael S. Tsirkin wrote:
> > > You have to either use and additional descriptor for metadata per chain.
> > > Or putting it in one of the buffers and forcing the lifetime of the metadata
> > and data to be the same.
> > 
> > That's true. It would be easy to make descriptors e.g. 32 bytes each, so
> > you can add extra data in there. Or if we can live with wasting some
> > bytes per descriptor, we could add a descriptor flag that marks the
> > address field as meta-data. You could then chain it with a regular
> > descriptor for data. However all in all the simplest option is probably
> > in the virtio header which can be linear with the packet.
> [I.L] In the current proposal descriptor size == SGE (scatter gather entry) size.
> I'm not sure that's a good idea.
> For example we are considering having an RX ring were you just post a list
> of PFN's so a sge is only 8 bytes.

You mean without length, flags etc?  So when you are concerned about
memory usage because you have many users for buffers (like e.g. with
Linux networking), then sizing buffers dynamically helps a lot. Single
user cases like DPDK or more recently XDP are different and they
can afford making all buffers same size.

For sure 8 byte entries would reduce cache pressure.  Question is
how to we handle so much variety in the ring layouts. Thoughts?

> I might be wrong here, so please correct me if that's the not the case.
> but I've gotten the impression that due to DPDK limitations you've focused 
> on the use case where you have 1 SGE.
> I'm not sure that a representative workload for network devices,
> As LSO is an important offload.

I don't think we focused on DPDK limitations.  For sure, lots of people
use LSO or other buffers with many s/g entries. But it also works pretty
well more or less whatever you do as you are able to pass a single large
packet then - so the per-packet overhead is generally amortized.

So if you are doing LSO, I'd say just use indirect.

> And the storage guys also complained about this issue.

Interesting. What was the complaint exactly.

> 
> > I suspect a good way to do this would be to just pass offsets within the
> > buffer back and forth. I agree sticking such small messages in a
> > separate buffer is not ideal. How about an option of replacing PA
> > with this data?
> [I.L] PA?

Sorry, I really meant the addr field in the descriptor.

> > 
> > 
> > 
> > > 3. There is a usage model where you have multiple produce rings
> > > And a single completion ring.
> > 
> > What good is it though? It seems to perform worse than combining
> > producer and consumer in my testing.
> > 
> [I.L] It might be that for virtio-net a single ring is better
> But are you really going to argue that its better in all possible use cases?
> 
> > 
> > > You could implement the completion ring using an additional virtio ring,
> > but
> > > The current model will require an extra indirection as it force you to write
> > into
> > > The buffers the descriptor in the completion ring point to. Rather than
> > writing the
> > > Completion into the ring itself.
> > > Additionally the device is still required to write to the original producer ring
> > > in addition to the completion ring.
> > >
> > > I think the best and most flexible design is to have variable size descriptor
> > that
> > > start with a dword header.
> > > The dword header will include - an ownership bit, an opcode and
> > descriptor length.
> > > The opcode and the "length" dwords following the header will be device
> > specific.
> > 
> > This means that device needs to do two reads just to decode the
> > descriptor fully. This conflicts with feedback Intel has been giving on
> > list which is to try and reduce number of reads. With header linear with
> > the packet, you need two reads to start transmitting the packet.
> > 
> [I.L] The device can do a single large read and do the parsing afterword's.

For sure but that wastes some pcie bandwidth.

> You could also use the doorbell to tell the device how much to read.

We currently use that to pass address of last descriptor.


> 
> > Seems to look like the avail bit in the kvm forum presentation.
> > 	
> [I.L] I don't want to argue over the name. The main difference in my 
> proposal is that the device doesn't need to write to the descriptor.
> If it wants to you can define a separate bit for that.

A theoretical analysis shows less cache line bounces
if device writes and driver writes go to same location.
A micro-benchmark and dpdk tests seem to match that.

If you want to split them, how about a test showing
either a benefit for software or an explanation about why it's
significantly different for hardware than software?


> > > Each device (or device class) can choose whether completions are reported
> > directly inside
> > > the descriptors in that ring or in a separate completion ring.
> > >
> > > completions rings can be implemented in an efficient manner with this
> > design.
> > > The driver will initialize a dedicated completion ring with empty completion
> > sized descriptors.
> > > And the device will write the completions directly into the ring.
> > 
> > I assume when you say completion you mean used entries, if I'm wrong
> > please correct me.  In fact with the proposal in the kvm forum
> > presentation it is possible to write used entries in a separate address
> > as opposed to overlapping the available entries.  If you are going to
> > support skipping writing back some used descriptors then accounting
> > would have to change slightly since driver won't be able to reset used
> > flags then.  But in the past in all tests I've written this separate
> > ring underperforms a shared ring.
> > 
> [I.L] A completion is a used entry + device specific metadata.
> I don't remember seeing an option to write used entries in a separate address,
> I'll appreciate it if you can point me to the right direction.

It wasn't described in the talk.

But it's simply this: driver detects used entry by detecting a used bit
flip.  If device does not use the option to skip writing back some used
entries then there's no need for used entries written by device and by
driver to overlap. If device does skip then we need them to overlap as
driver also needs to reset the used flag so used != avail.

> Regarding the shared ring vs separate ring, I can't really argue with you
> as I haven't done the relevant measurement.
> I'm just saying it might not always be optimal in all use case,
> So you should consider leaving both options open.
> 
> Its entirely possible that for virtio-net you want a single ring,
> Where for PV-RDMA you want separate rings. 

Well RDMA consortium decided a low-level API for cards will help
application portability, and that spec has a concept of completion
queues which are shared between request queues.  So the combined ring
optimization kind of goes out the window for that kind of device :) I'm
not sure just splitting out used rings will be enough though.

It's not a great fit for virtio right now, if someone's interested
in changing rings to match that use-case I'm all ears.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

