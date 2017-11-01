Return-Path: virtio-dev-return-2645-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Date: Wed, 1 Nov 2017 19:35:11 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171101190219-mutt-send-email-mst@kernel.org>
References: <20171029125225.lx4ezpkbvjjsjv3x@localhost.localdomain>
 <20171101162357-mutt-send-email-mst@kernel.org>
 <AM4PR0501MB2723D56ED113A7B98D3785F0D45F0@AM4PR0501MB2723.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM4PR0501MB2723D56ED113A7B98D3785F0D45F0@AM4PR0501MB2723.eurprd05.prod.outlook.com>
Subject: [virtio-dev] Re: Virtio BoF minutes from KVM Forum 2017
To: Ilya Lesokhin <ilyal@mellanox.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Jens Freimann <jfreimann@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Nov 01, 2017 at 03:52:12PM +0000, Ilya Lesokhin wrote:
> On Wednesday, November 01, 2017 4:59 PM, Michael S. Tsirkin wrote:
> 
> > On Sun, Oct 29, 2017 at 01:52:25PM +0100, Jens Freimann wrote:
> > > Ilya: - you might have more completions than descriptors available
> > > - partial descriptor chains are a problem for hardware because you
> > > might have  to read a bunch of conscriptors twice - how would you do
> > > deal with a big buffer that cointains a large number of  small packets
> > > with respect to completions?
> > > - is one bit for completion enough? right now it means descriptor was
> > > actually  used. how to we signal when it was completed?
> > 
> > I am not sure I understand the difference. Under virtio, driver makes a
> > descriptor available, then device reads/writes memory depending on descriptor
> > type, then marks it as used.
> > 
> > What does completed mean?
> > 
> 
> During the BOF, someone raised the point that there is no indication that the HW has
> Read the descriptor. I think after some discussion we've agreed that it's not a useful indication.
> 
> My issues with the current completion or used notifications are as follows:
> 1. There is no room for extra metadata such as checksum or flow tag.
> You could put that in the descriptor payload but it's somewhat inconvenient.
> You have to either use and additional descriptor for metadata per chain.
> Or putting it in one of the buffers and forcing the lifetime of the metadata and data to be the same.

That's true. It would be easy to make descriptors e.g. 32 bytes each, so
you can add extra data in there. Or if we can live with wasting some
bytes per descriptor, we could add a descriptor flag that marks the
address field as meta-data. You could then chain it with a regular
descriptor for data. However all in all the simplest option is probably
in the virtio header which can be linear with the packet.

> 2. Current format assumes 1-1 corresponds between descriptors and completions.
> You did offer a skipping optimization for many descriptors -> 1 completion.

Yes - that's because the claim was that if using descriptors in-order,
device is doing many unnecessary writes.

> But it is somewhat inefficient.

It seems to outperform other options on a micro-benchmark but sure,
what do you propose?

> And you didn't offer a solution for 1 descriptor -> multiple completions.
> Mellanox has a feature called striding RQ where you post a large buffer and
> The NIC fills it with multiple back to back packets with padding.
> Each packet generates its own completion.

I suspect a good way to do this would be to just pass offsets within the
buffer back and forth. I agree sticking such small messages in a
separate buffer is not ideal. How about an option of replacing PA
with this data?



> 3. There is a usage model where you have multiple produce rings
> And a single completion ring.

What good is it though? It seems to perform worse than combining
producer and consumer in my testing.


> You could implement the completion ring using an additional virtio ring,  but 
> The current model will require an extra indirection as it force you to write into 
> The buffers the descriptor in the completion ring point to. Rather than writing the
> Completion into the ring itself.
> Additionally the device is still required to write to the original producer ring 
> in addition to the completion ring.
> 
> I think the best and most flexible design is to have variable size descriptor that
> start with a dword header.
> The dword header will include - an ownership bit, an opcode and descriptor length.
> The opcode and the "length" dwords following the header will be device specific.

This means that device needs to do two reads just to decode the
descriptor fully. This conflicts with feedback Intel has been giving on
list which is to try and reduce number of reads. With header linear with
the packet, you need two reads to start transmitting the packet.


> The owner bit meaning changes on each ring wrap around so the device doesn't
> Need to update.

Seems to look like the avail bit in the kvm forum presentation.

> Each device (or device class) can choose whether completions are reported directly inside 
> the descriptors in that ring or in a separate completion ring. 
> 
> completions rings can be implemented in an efficient manner with this design.
> The driver will initialize a dedicated completion ring with empty completion sized descriptors.
> And the device will write the completions directly into the ring.

I assume when you say completion you mean used entries, if I'm wrong
please correct me.  In fact with the proposal in the kvm forum
presentation it is possible to write used entries in a separate address
as opposed to overlapping the available entries.  If you are going to
support skipping writing back some used descriptors then accounting
would have to change slightly since driver won't be able to reset used
flags then.  But in the past in all tests I've written this separate
ring underperforms a shared ring.


> 
> 
> 
> 
> 
> 
> 
> 
> 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

