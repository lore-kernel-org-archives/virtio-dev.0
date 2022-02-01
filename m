Return-Path: <pasic@linux.ibm.com>
Date: Tue, 1 Feb 2022 12:53:57 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [virtio-dev] Re: [PATCH v2 1/4] Add virtio Admin Virtqueue
Message-ID: <20220201125357.3ebc00bd.pasic@linux.ibm.com>
In-Reply-To: <877dafzv8w.fsf@redhat.com>
References: <CACGkMEsXhKDGqpK=umdFkKubqm09Z45YgnNSYH-xwwJQEd9PEA@mail.gmail.com>
	<e80bdf0d-4b52-03ca-6378-cf9e2a062b34@nvidia.com>
	<20220130043917-mutt-send-email-mst@kernel.org>
	<f3644061-70b6-892d-a2e0-1e710bf58609@nvidia.com>
	<20220130093740-mutt-send-email-mst@kernel.org>
	<da7444d6-f67d-3598-814d-a1b945c3542d@nvidia.com>
	<20220130102940-mutt-send-email-mst@kernel.org>
	<87ilu0z2mc.fsf@redhat.com>
	<20220131083927-mutt-send-email-mst@kernel.org>
	<87fsp4yo9v.fsf@redhat.com>
	<20220131094911-mutt-send-email-mst@kernel.org>
	<20220131171205.1317b936.pasic@linux.ibm.com>
	<877dafzv8w.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, Jason Wang <jasowang@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Parav Pandit <parav@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, Stefan Hajnoczi <stefanha@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 31 Jan 2022 18:10:39 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Mon, Jan 31 2022, Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > On Mon, 31 Jan 2022 09:52:54 -0500
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >  
> >> On Mon, Jan 31, 2022 at 03:26:36PM +0100, Cornelia Huck wrote:  
> >> > On Mon, Jan 31 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> >     
> >> > > On Mon, Jan 31, 2022 at 10:16:43AM +0100, Cornelia Huck wrote:    
> >> > >> On Sun, Jan 30 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> > >>     
> >> > >> > On Sun, Jan 30, 2022 at 05:12:46PM +0200, Max Gurtovoy wrote:    
> >> > >> >> #define VIRTIO_PCI_CAP_MISC_CFG 10
> >> > >> >> 
> >> > >> >> and
> >> > >> >> 
> >> > >> >> struct virtio_pci_misc_cfg {
> >> > >> >>     le16 admin_queue_index; /* read-only for driver */
> >> > >> >> };
> >> > >> >> 
> >> > >> >> Is agreed by all for V3 ? instead of the net and blk AQ index definitions.    
> >> > >> >
> >> > >> > We need to add it to MMIO and CCW I guess too.    
> >> > >> 
> >> > >> That seems ok for pci.
> >> > >> 
> >> > >> For ccw, I'd do something like
> >> > >> 
> >> > >> #define CCW_CMD_READ_MISC_CONF 0x82
> >> > >> 
> >> > >> struct virtio_misc_conf {
> >> > >>        be16 admin_queue_index;
> >> > >> };
> >> > >> 
> >> > >> bound to revision 3, which gets a payload data containing the length of
> >> > >> this structure (for future expansions).
> >> > >> 
> >> > >> Halil, do you think that would work?
> >> > >> 
> >> > >> For mmio, I'd need to think a bit more. Any mmio experts around?    
> >> > >
> >> > > Not an expert but I think we can rely on a feature
> >> > > bit to be acked since admin vq is only needed
> >> > > after feature negotiation is complete.    
> >> > 
> >> > You mean a register that is valid conditionally? I don't see an easy way
> >> > to add some kind of "misc" interface for mmio, unlike for the other
> >> > transports.
> >> > 
> >> > So something like:
> >> > 
> >> > AdminQueueIndex/0x0c4/R
> >> > If VIRTIO_F_ADMIN_VQ has been negotiated, reading from this register
> >> > returns the queue index of the administration virtqueue.    
> >> 
> >> No, I mean a register that switches 100+ between device specific
> >> and misc space.
> >>   
> >
> > Maybe adding a register that tells us where does the "misc config
> > start" is another option. I don't think we need an open ended
> > device-config in practice. I have no idea if there are any upper limits
> > on MMIO address space though. If we are constrained there, the switching
> > is certainly more efficient. Otherwise, I think having the misc config
> > somewhere after device specific config is simpler.  
> 
> I think we first need to agree what the "misc" thing is actually
> supposed to be. My idea was that we don't have an unlimited supply of
> ccws to use for new features, so introducing one for reading "misc"
> configuration would be a way to keep things extensible (it also might
> make the config/register space for other transports less cluttered). The
> same idea (save on ccws) would apply to the multiplexing "action" ccw I
> mentioned in my other mail.
> 

I agree with not wasting CCWs.

> So, for the case here (simply relaying the location of the admin vq), we
> don't really need a "misc" mechanism for pci/mmio, but I'd like to
> introduce one for ccw. If we agree that it would be useful for pci/mmio
> as well, we should introduce it now.

Please see Michael's response. My understanding was also that what we
want is something like config space for the virtio protocol stuff. The
current config space is entirely device specific, so if we would want a
common thing in _config space_, like _the index of the administration 
vq_ then each device would have to define it separately, in a device
specific location. Which is not nice.

AFAIU having a this protocol config could be sufficient in the sense
that we probably don't need another misc. My line of thinking is: with
this we basically get a read-write interface for exposing stuff. The
only other thing I can think of is _transport specific fields_. That
is if we needed something that ain't specific to the device, but ain't
common to all virtio (i.e. the virtio protocol). One idea, which would
allow us to remain flexible is to a make this new thing not
only this new _protocol config_ but state in some sort of a header
that _protocol config_ is a given range of addresses within the
space on which what you called MISC_CONF operates on.

This multiplexing "action" ccw sounds like an interesting idea to
explore. Maybe we only need that, and can integrate misc config
or protocol config into that interface.

Do you have a proposal somewhere? I do remember the other email you
mentioned it in, but I don't remember seeing anything akin to an
interface specification.

Regards,
Halil

