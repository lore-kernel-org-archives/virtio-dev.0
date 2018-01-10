Return-Path: virtio-return-2822-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 10 Jan 2018 13:16:11 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180110131508-mutt-send-email-mst@kernel.org>
References: <1515577653-9336-1-git-send-email-mst@redhat.com>
 <20180110113315.6d04a931.cohuck@redhat.com>
 <20180110130703-mutt-send-email-mst@kernel.org>
 <20180110121403.0d17fa38.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180110121403.0d17fa38.cohuck@redhat.com>
Subject: Re: [virtio] [PATCH v6 0/5] packed ring layout spec
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 10, 2018 at 12:14:03PM +0100, Cornelia Huck wrote:
> On Wed, 10 Jan 2018 13:10:49 +0200
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Wed, Jan 10, 2018 at 11:33:15AM +0100, Cornelia Huck wrote:
> > > On Wed, 10 Jan 2018 11:47:53 +0200
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >   
> > > > OK, this is in a shape where we could include it in the spec.
> > > > Changes from v5:
> > > > - scope reductions (see below). We can add more
> > > >   features down the road, hopefully reduced scope will be enough
> > > >   to finalize spec soon.
> > > > - cleanup and integrate in the spec
> > > > - pseudo-code
> > > > 
> > > > Deferred features:
> > > > - dropped _F_DESC_LIST, 1.0 includes this unconditionally, we
> > > >   can do same
> > > > - dropped event structure change notifications - needed for
> > > >   efficient hardware implementations but let's add this on top
> > > > 
> > > > 3 1st patches just move text around so all virtio 1.0
> > > > things are in the same place. 2 last ones add the new layout
> > > > 
> > > > Option to mark descriptors as not generating events isn't
> > > > yet implemented. Again, let's add this on top.
> > > > 
> > > > I also note that for hardware implementations, a different
> > > > set of memory barriers is needed. Again, let's add this on top
> > > > 
> > > > not linking into conformance sections, will add after spec
> > > > itself is approved.
> > > > 
> > > > Michael S. Tsirkin (5):
> > > >   content: move 1.0 queue format out to a separate section
> > > >   content: move ring text out to a separate file
> > > >   content: move virtqueue operation description
> > > >   packed virtqueues: more efficient virtqueue layout
> > > >   packed-ring: add in order request support
> > > > 
> > > >  conformance.tex |   4 +-
> > > >  content.tex     | 718 +++++---------------------------------------------------
> > > >  packed-ring.tex | 692 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > > >  split-ring.tex  | 666 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> > > >  4 files changed, 1423 insertions(+), 657 deletions(-)
> > > >  create mode 100644 packed-ring.tex
> > > >  create mode 100644 split-ring.tex
> > > >   
> > > 
> > > One thing I just noticed: This does not seem to contain any changes for
> > > transports. For ccw, we use different payloads in the SET_VQ command
> > > for legacy (pre-virtio-1) and virtio-1 split layout. I think we would
> > > need a new SET_VQ payload for the packed ring guarded by a new
> > > revision, but I have not investigated it yet. I have not yet thought
> > > through how this interacts with feature negotiation, either.  
> > 
> > Good point.
> > There's exactly same number of chunks (descriptor, device and driver
> > event suppression).
> > 
> > So the idea is to substitute descriptor for descriptor, device event
> > suppression for available ring and driver event suppression for
> > used ring.
> > 
> > That's why we don't need to change transports.
> > 
> > I will add text to clarify that.
> 
> I think we also need to update the text for the transports, as they
> explicitly refer to avail/used.

Exactly.

> > 
> > > Otherwise, I don't see any reason why the packed ring would not work
> > > fine for ccw as well.  

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

