Return-Path: <mst@redhat.com>
Date: Tue, 1 Feb 2022 13:34:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH v2 1/4] Add virtio Admin Virtqueue
Message-ID: <20220201132815-mutt-send-email-mst@kernel.org>
References: <da7444d6-f67d-3598-814d-a1b945c3542d@nvidia.com>
 <20220130102940-mutt-send-email-mst@kernel.org>
 <87ilu0z2mc.fsf@redhat.com>
 <20220131083927-mutt-send-email-mst@kernel.org>
 <87fsp4yo9v.fsf@redhat.com>
 <20220131094911-mutt-send-email-mst@kernel.org>
 <20220131171205.1317b936.pasic@linux.ibm.com>
 <877dafzv8w.fsf@redhat.com>
 <20220201125357.3ebc00bd.pasic@linux.ibm.com>
 <87ee4my101.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87ee4my101.fsf@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, Jason Wang <jasowang@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Parav Pandit <parav@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Feb 01, 2022 at 06:01:34PM +0100, Cornelia Huck wrote:
> On Tue, Feb 01 2022, Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > On Mon, 31 Jan 2022 18:10:39 +0100
> > Cornelia Huck <cohuck@redhat.com> wrote:
> >
> >> On Mon, Jan 31 2022, Halil Pasic <pasic@linux.ibm.com> wrote:
> >> 
> >> > On Mon, 31 Jan 2022 09:52:54 -0500
> >> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> >  
> >> >> On Mon, Jan 31, 2022 at 03:26:36PM +0100, Cornelia Huck wrote:  
> >> >> > On Mon, Jan 31 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> >> >     
> >> >> > > On Mon, Jan 31, 2022 at 10:16:43AM +0100, Cornelia Huck wrote:    
> >> >> > >> On Sun, Jan 30 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> >> > >>     
> >> >> > >> > On Sun, Jan 30, 2022 at 05:12:46PM +0200, Max Gurtovoy wrote:    
> >> >> > >> >> #define VIRTIO_PCI_CAP_MISC_CFG 10
> >> >> > >> >> 
> >> >> > >> >> and
> >> >> > >> >> 
> >> >> > >> >> struct virtio_pci_misc_cfg {
> >> >> > >> >>     le16 admin_queue_index; /* read-only for driver */
> >> >> > >> >> };
> >> >> > >> >> 
> >> >> > >> >> Is agreed by all for V3 ? instead of the net and blk AQ index definitions.    
> >> >> > >> >
> >> >> > >> > We need to add it to MMIO and CCW I guess too.    
> >> >> > >> 
> >> >> > >> That seems ok for pci.
> >> >> > >> 
> >> >> > >> For ccw, I'd do something like
> >> >> > >> 
> >> >> > >> #define CCW_CMD_READ_MISC_CONF 0x82
> >> >> > >> 
> >> >> > >> struct virtio_misc_conf {
> >> >> > >>        be16 admin_queue_index;
> >> >> > >> };
> >> >> > >> 
> >> >> > >> bound to revision 3, which gets a payload data containing the length of
> >> >> > >> this structure (for future expansions).
> >> >> > >> 
> >> >> > >> Halil, do you think that would work?
> >> >> > >> 
> >> >> > >> For mmio, I'd need to think a bit more. Any mmio experts around?    
> >> >> > >
> >> >> > > Not an expert but I think we can rely on a feature
> >> >> > > bit to be acked since admin vq is only needed
> >> >> > > after feature negotiation is complete.    
> >> >> > 
> >> >> > You mean a register that is valid conditionally? I don't see an easy way
> >> >> > to add some kind of "misc" interface for mmio, unlike for the other
> >> >> > transports.
> >> >> > 
> >> >> > So something like:
> >> >> > 
> >> >> > AdminQueueIndex/0x0c4/R
> >> >> > If VIRTIO_F_ADMIN_VQ has been negotiated, reading from this register
> >> >> > returns the queue index of the administration virtqueue.    
> >> >> 
> >> >> No, I mean a register that switches 100+ between device specific
> >> >> and misc space.
> >> >>   
> >> >
> >> > Maybe adding a register that tells us where does the "misc config
> >> > start" is another option. I don't think we need an open ended
> >> > device-config in practice. I have no idea if there are any upper limits
> >> > on MMIO address space though. If we are constrained there, the switching
> >> > is certainly more efficient. Otherwise, I think having the misc config
> >> > somewhere after device specific config is simpler.  
> >> 
> >> I think we first need to agree what the "misc" thing is actually
> >> supposed to be. My idea was that we don't have an unlimited supply of
> >> ccws to use for new features, so introducing one for reading "misc"
> >> configuration would be a way to keep things extensible (it also might
> >> make the config/register space for other transports less cluttered). The
> >> same idea (save on ccws) would apply to the multiplexing "action" ccw I
> >> mentioned in my other mail.
> >> 
> >
> > I agree with not wasting CCWs.
> >
> >> So, for the case here (simply relaying the location of the admin vq), we
> >> don't really need a "misc" mechanism for pci/mmio, but I'd like to
> >> introduce one for ccw. If we agree that it would be useful for pci/mmio
> >> as well, we should introduce it now.
> >
> > Please see Michael's response. My understanding was also that what we
> > want is something like config space for the virtio protocol stuff. The
> > current config space is entirely device specific, so if we would want a
> > common thing in _config space_, like _the index of the administration 
> > vq_ then each device would have to define it separately, in a device
> > specific location. Which is not nice.
> 
> Ok, so for ccw, it will be more of a secondary "config space", and we
> should reuse all the infrastructure that we already use for our normal
> "config space" (put into quotes because it isn't really a config space.)
> 
> Maybe we can call this "protocol config space"?

Well config is not an english word ;)

We don't have many mentions of config space, those that are there
should probably be converted to device configuration.

I am fine with protocol configuration if others like it, though
I'm not 100% sure which "protocol" does this refer to, but there
are instances in the spec where "protocol" means "virtio spec".


> >
> > AFAIU having a this protocol config could be sufficient in the sense
> > that we probably don't need another misc. My line of thinking is: with
> > this we basically get a read-write interface for exposing stuff. The
> > only other thing I can think of is _transport specific fields_. That
> > is if we needed something that ain't specific to the device, but ain't
> > common to all virtio (i.e. the virtio protocol). One idea, which would
> > allow us to remain flexible is to a make this new thing not
> > only this new _protocol config_ but state in some sort of a header
> > that _protocol config_ is a given range of addresses within the
> > space on which what you called MISC_CONF operates on.
> 
> Yeah, we can make transport config a subset of protocol
> config... possibly just a command + address setup, and the transport can
> multiplex on that?

OK but we need size too? I'd like to avoid a ton of exits if possible,
people already complain about pci discovery causing a ton of exits,
an exit per value is possible for pci after all.

> >
> > This multiplexing "action" ccw sounds like an interesting idea to
> > explore. Maybe we only need that, and can integrate misc config
> > or protocol config into that interface.
> 
> It would probably be better to try and integrate it into the protocol
> config, if that's going to be read/write anyway. We can introduce like
> queue reset we're still missing on ccw into the transport config and
> already test out whether that makes actual sense.

The annoying thing is we added queue reset to pci already, ugh.
There are two ways to do it for pci then? Oh well ...


> >
> > Do you have a proposal somewhere? I do remember the other email you
> > mentioned it in, but I don't remember seeing anything akin to an
> > interface specification.
> 
> No, nothing formal. I was thinking of a ccw with a command/length/data
> payload, with successful conclusion of the I/O signifying successful
> triggering of the action (or maybe conclusion, depending on the
> command.) That might be more effective than the "config space"
> read/write dance, but I'm not sure whether it's worth deviating from the
> other transports.

