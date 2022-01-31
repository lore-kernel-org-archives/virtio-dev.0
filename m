Return-Path: <virtio-dev-return-9238-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3C81B9865D1
	for <virtio-dev@lists.oasis-open.org>; Mon, 31 Jan 2022 17:10:55 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20220131171205.1317b936.pasic@linux.ibm.com>
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
Date: Mon, 31 Jan 2022 18:10:39 +0100
Message-ID: <877dafzv8w.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v2 1/4] Add virtio Admin Virtqueue
Content-Type: text/plain
To: Halil Pasic <pasic@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, Jason Wang <jasowang@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Parav Pandit <parav@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, Stefan Hajnoczi <stefanha@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jan 31 2022, Halil Pasic <pasic@linux.ibm.com> wrote:

> On Mon, 31 Jan 2022 09:52:54 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>
>> On Mon, Jan 31, 2022 at 03:26:36PM +0100, Cornelia Huck wrote:
>> > On Mon, Jan 31 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> >   
>> > > On Mon, Jan 31, 2022 at 10:16:43AM +0100, Cornelia Huck wrote:  
>> > >> On Sun, Jan 30 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> > >>   
>> > >> > On Sun, Jan 30, 2022 at 05:12:46PM +0200, Max Gurtovoy wrote:  
>> > >> >> #define VIRTIO_PCI_CAP_MISC_CFG 10
>> > >> >> 
>> > >> >> and
>> > >> >> 
>> > >> >> struct virtio_pci_misc_cfg {
>> > >> >>     le16 admin_queue_index; /* read-only for driver */
>> > >> >> };
>> > >> >> 
>> > >> >> Is agreed by all for V3 ? instead of the net and blk AQ index definitions.  
>> > >> >
>> > >> > We need to add it to MMIO and CCW I guess too.  
>> > >> 
>> > >> That seems ok for pci.
>> > >> 
>> > >> For ccw, I'd do something like
>> > >> 
>> > >> #define CCW_CMD_READ_MISC_CONF 0x82
>> > >> 
>> > >> struct virtio_misc_conf {
>> > >>        be16 admin_queue_index;
>> > >> };
>> > >> 
>> > >> bound to revision 3, which gets a payload data containing the length of
>> > >> this structure (for future expansions).
>> > >> 
>> > >> Halil, do you think that would work?
>> > >> 
>> > >> For mmio, I'd need to think a bit more. Any mmio experts around?  
>> > >
>> > > Not an expert but I think we can rely on a feature
>> > > bit to be acked since admin vq is only needed
>> > > after feature negotiation is complete.  
>> > 
>> > You mean a register that is valid conditionally? I don't see an easy way
>> > to add some kind of "misc" interface for mmio, unlike for the other
>> > transports.
>> > 
>> > So something like:
>> > 
>> > AdminQueueIndex/0x0c4/R
>> > If VIRTIO_F_ADMIN_VQ has been negotiated, reading from this register
>> > returns the queue index of the administration virtqueue.  
>> 
>> No, I mean a register that switches 100+ between device specific
>> and misc space.
>> 
>
> Maybe adding a register that tells us where does the "misc config
> start" is another option. I don't think we need an open ended
> device-config in practice. I have no idea if there are any upper limits
> on MMIO address space though. If we are constrained there, the switching
> is certainly more efficient. Otherwise, I think having the misc config
> somewhere after device specific config is simpler.

I think we first need to agree what the "misc" thing is actually
supposed to be. My idea was that we don't have an unlimited supply of
ccws to use for new features, so introducing one for reading "misc"
configuration would be a way to keep things extensible (it also might
make the config/register space for other transports less cluttered). The
same idea (save on ccws) would apply to the multiplexing "action" ccw I
mentioned in my other mail.

So, for the case here (simply relaying the location of the admin vq), we
don't really need a "misc" mechanism for pci/mmio, but I'd like to
introduce one for ccw. If we agree that it would be useful for pci/mmio
as well, we should introduce it now.

>
> BTW I don't really like this "misc" as the name. FWIW it is less
> miscellaneous that the device specific config, since it is common
> for all devices. I don't have a good name for it, but I would prefer
> "common" over "misc"

I'm not sure whether "common" would be more confusing, as pci already
has a "common" config (with things that are covered in the mmio
registers, and via various ccw commands.) Does anyone have a better idea
for a bikeshed colour?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

