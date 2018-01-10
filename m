Return-Path: virtio-return-2830-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 10 Jan 2018 17:37:05 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180110173540-mutt-send-email-mst@kernel.org>
References: <1515577653-9336-1-git-send-email-mst@redhat.com>
 <1515577653-9336-5-git-send-email-mst@redhat.com>
 <20180110151538.465bce97.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180110151538.465bce97.cohuck@redhat.com>
Subject: Re: [virtio] [PATCH v6 4/5] packed virtqueues: more efficient
 virtqueue layout
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 10, 2018 at 03:15:38PM +0100, Cornelia Huck wrote:
> On Wed, 10 Jan 2018 11:47:58 +0200
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > Performance analysis of this is in my kvm forum 2016 presentation.  The
> > idea is to have a r/w descriptor in a ring structure, replacing the used
> > and available ring, index and descriptor buffer.
> 
> Do we have a place to store pointers to such information?
> 
> > 
> > This is also easier for devices to implement than the 1.0 layout.
> > Several more enhancements will be necessary to actually make this
> > efficient for devices to use.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  content.tex     |  36 ++-
> >  packed-ring.tex | 668 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 701 insertions(+), 3 deletions(-)
> >  create mode 100644 packed-ring.tex
> > 
> > diff --git a/content.tex b/content.tex
> > index 3b4579e..3059bd3 100644
> > --- a/content.tex
> > +++ b/content.tex
> 
> (...)
> 
> > @@ -5199,10 +5215,19 @@ Currently these device-independent feature bits defined:
> >  \begin{description}
> >    \item[VIRTIO_F_RING_INDIRECT_DESC (28)] Negotiating this feature indicates
> >    that the driver can use descriptors with the VIRTQ_DESC_F_INDIRECT
> > -  flag set, as described in \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Descriptor Table / Indirect Descriptors}~\nameref{sec:Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Descriptor Table / Indirect Descriptors}.
> > +  flag set, as described in \ref{sec:Basic Facilities of a Virtio
> > +Device / Virtqueues / The Virtqueue Descriptor Table / Indirect
> > +Descriptors}~\nameref{sec:Basic Facilities of a Virtio Device /
> > +Virtqueues / The Virtqueue Descriptor Table / Indirect
> > +Descriptors} and
> > +  \ref{sec:Packed Virtqueues / Indirect Flag: Scatter-Gather Support}
> > +\ref{sec:Packed Virtqueues / Driver and Device Event Suppression}.
> 
> That one needs to go below (copy/paste error?).
> 
> >  
> >    \item[VIRTIO_F_RING_EVENT_IDX(29)] This feature enables the \field{used_event}
> > -  and the \field{avail_event} fields as described in \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Interrupt Suppression} and \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Used Ring}.
> > +  and the \field{avail_event} fields as described in
> > +\ref{sec:Basic Facilities of a Virtio Device / Virtqueues /
> > +Virtqueue Interrupt Suppression}, \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Used Ring}
> > +and .
> 
> Here's where the ref above needs to go.
> 
> >  
> >    \item[VIRTIO_F_VERSION_1(32)] This indicates compliance with this
> >      specification, giving a simple way to detect legacy devices or drivers.
> > @@ -5212,6 +5237,9 @@ Currently these device-independent feature bits defined:
> >    addresses in memory.  If this feature bit is set to 0, then the device emits
> >    physical addresses which are not translated further, even though an IOMMU
> >    may be present.
> > +  \item[VIRTIO_F_RING_PACKED(34)] This feature indicates
> > +  support for the packed virtqueue layout as described in
> > +\ref{sec:Basic Facilities of a Virtio Device / Packed Virtqueues}.
> >  \end{description}
> 
> I think the references should include a title as well (that makes the
> resulting document easier to read).

Want to add a macro including ref+nameref?
We'd use it for all sec: references then.

> >  
> >  \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

