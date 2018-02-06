Return-Path: virtio-return-2877-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 7 Feb 2018 00:58:56 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180207005229-mutt-send-email-mst@kernel.org>
References: <1515577653-9336-1-git-send-email-mst@redhat.com>
 <1516665617-30748-1-git-send-email-mst@redhat.com>
 <db5515bb-5995-011a-6e84-c2194dedf2aa@linux.vnet.ibm.com>
 <20180206020102-mutt-send-email-mst@kernel.org>
 <ffb4c3fc-9f72-3b58-9d17-fcef906d3805@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffb4c3fc-9f72-3b58-9d17-fcef906d3805@linux.vnet.ibm.com>
Subject: [virtio] Re: [virtio-dev] Re: [virtio] [PATCH v7 01/11] content: move 1.0
 queue format out to a separate section
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Feb 06, 2018 at 12:10:20PM +0100, Halil Pasic wrote:
> I agree with what Connie proposed (drop 'used by legacy virtio devices').
> My point is that this legacy can lead to confusion.

It's a good point.
I guess it's better to just go the regular route and add a
separate section
explaining that legacy devices always use a split ring.

> Regarding no versioning in virtio: I agree only partially. We have
> the VIRTIO_F_VERSION_1 feature bit and we have a version number in
> the title. But I think, I understand what you mean. This non-egsistence
> of versioning in virtio is probably trivial for anybody working on
> virtio for years. But is it for a new hire who just got trough the spec?

It's not easy to write a spec that is both formally correct and
easy to read. It might be a good idea to extend the introduction
some more and explain how does virtio handle compatibility
without versioning.

> In the CIO transport we have an explicit mention of virtio 1.0 (explains
> revision 1). I wonder if that is still appropriate. Shouldn't that just
> be virtio 1?

Some transports chose to have their own transport versioning.

> >>>  The split virtqueue format separates the
> >>> +virtqueue into several parts, where each part is write-able by
> >>> +either the driver or the device, but not both. Multiple
> >>> +locations need to be updated when making a buffer available
> >>> +and when marking it as used.
> >>> +
> >>
> >> If we assume 3 parts (available ring, used ring and descriptor table),
> >> then the two last sentences are contradictory: as one of three would have
> >> to be updated by both the device and the driver. Or did I misunderstand
> >> something?
> > 
> > I don't see a contradiction.
> > Split rings only have RO and WO parts. There are 
> > 
> 
> This sentence seems unfinished. I was probably wrong. I assumed 'location'
> means 'area' in this context. What does location mean in this context
> (e.g. same location is equivalent to same byte)?

Yes, that's what I meant. Maybe "Multiple parts and/or locations within
a part"?


> >> I think, the purpose of this paragraph is to distinguish the split
> >> form the packed. We probably don't need these additions to understand
> >> 'split'. I would rather see a discussion on the two formats in the
> >> common (2.4) virtqueue section.
> >>
> >> [..]
> >>
> >> Regards,
> >> Halil
> > 
> > This doesn't really scale - if we have a 3rd format we do not
> > want to mix them all in a common section.
> > So description of split format goes into split section, and so on.
> > I'd be fine to add a format comparison section if that will
> > make things easier.
> 
> OK. I need to think about the structure a bit more myself. Let's
> just go with what we have.
> 
> Thanks for your answers!
> 
> Regards,
> Halil

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

