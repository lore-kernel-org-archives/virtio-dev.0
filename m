Return-Path: virtio-return-3433-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Tue, 11 Aug 2020 04:23:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200811042047-mutt-send-email-mst@kernel.org>
References: <20200810161501.1572834-1-mst@redhat.com>
 <20200810185928.2e722231.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200810185928.2e722231.cohuck@redhat.com>
Subject: Re: [virtio] [PATCH RFC] VIRTIO_F_PARTIAL_ORDER for page fault
 handling
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Aug 10, 2020 at 06:59:28PM +0200, Cornelia Huck wrote:
> On Mon, 10 Aug 2020 12:15:15 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > Devices that normally use buffers in order can
> > benefit from ability to temporarily switch to handle
> > some buffers out of order.
> > 
> > As a case in point, a networking device might handle
> > RX buffers in order normally. However, should
> > an access to an RX buffer cause a page fault
> > (e.g. when using PRI), the device could benefit from
> > ability to temporarily keep using following
> > buffers in the ring (possibly with higher overhead)
> > until the fault has been resolved.
> > 
> > Page faults allow more features such as THP, auto-NUMA,
> > live migration.
> > 
> > Out of order is of course already possible, however,
> > IN_ORDER is currently required for descriptor batching where
> > device marks a whole batch of buffers used in one go.
> > 
> > The idea behind this proposal is to relax that requirement,
> > allowing batching without asking device to be in orde rat all times,
> > as follows:
> > 
> > Device uses buffers in any order. Eventually when device detects that it
> > has used all previously outstanding buffers, it sets a FLUSH flag on the
> > last buffer used. If it set this flag on the last buffer used
> > previously, and now uses a batch of descriptors in-order, it can now
> > signal the last buffer used again setting the FLUSH flag.
> > 
> > Driver can detect in-order when it sees two FLUSH flags one after
> > another. In other respects the feature is similar to IN_ORDER
> > from the driver implementation POV.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  content.tex     |  9 ++++++++-
> >  packed-ring.tex | 23 +++++++++++++++++++++++
> >  split-ring.tex  | 26 ++++++++++++++++++++++++--
> >  3 files changed, 55 insertions(+), 3 deletions(-)
> > 
> > diff --git a/content.tex b/content.tex
> > index 91735e3..8494eb6 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -296,7 +296,11 @@ \section{Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Virtqueues}
> >  
> >  Some devices always use descriptors in the same order in which
> >  they have been made available. These devices can offer the
> > -VIRTIO_F_IN_ORDER feature. If negotiated, this knowledge
> > +VIRTIO_F_IN_ORDER feature.  Other devices sometimes use
> > +descriptors in the same order in which they have been made
> > +available. These devices can offer the VIRTIO_F_PARTIAL_ORDER
> > +feature. If one of the features VIRTIO_F_IN_ORDER or
> > +VIRTIO_F_PARTIAL_ORDER is negotiated, this knowledge
> 
> Do these two features conflict with each other? I.e., at most one of
> them may be negotiated (or offered?) at a time?

Good point. I think so, yes. Will document.

> >  might allow optimizations or simplify driver and/or device code.
> >  
> >  Each virtqueue can consist of up to 3 parts:
> > @@ -6132,6 +6136,9 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
> >    that the driver passes extra data (besides identifying the virtqueue)
> >    in its device notifications.
> >    See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec:Virtqueues / Driver notifications}.
> > +  \item[VIRTIO_F_PARTIAL_ORDER(39)] This feature indicates
> > +  that device has ability to indicate use of (some of) buffers by the device in the same
> 
> "use of a subset of buffers" ?


That sounds better, thanks!

> > +  order in which they have been made available.
> >  \end{description}
> >  
> >  \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
> > diff --git a/packed-ring.tex b/packed-ring.tex
> > index ea92543..a120a19 100644
> > --- a/packed-ring.tex
> > +++ b/packed-ring.tex
> > @@ -284,6 +284,29 @@ \subsection{In-order use of descriptors}
> >  only writing out a single used descriptor with the Buffer ID
> >  corresponding to the last descriptor in the batch.
> >  
> > +Other devices sometimes use
> > +descriptors in the same order in which they have been made
> > +available. These devices can offer the VIRTIO_F_PARTIAL_ORDER
> > +feature. If negotiated, whenever device has used all buffers
> 
> s/device/the device/
> 
> > +since the previous used buffer in the same order
> > +in which they have been made available, device can set the
> 
> s/device/the device/
> 
> > +VIRTQ_DESC_F_FLUSH flag in the used descriptor.
> > +\begin{lstlisting}
> > +#define VIRTQ_DESC_F_FLUSH      8
> > +\end{lstlisting}
> > +
> > +This knowledge allows
> > +devices to notify the use of a batch of buffers to the driver by
> > +only writing out a single used descriptor with the Buffer ID
> > +corresponding to the last descriptor in the batch,
> > +and VIRTQ_DESC_F_FLUSH set.
> > +
> > +Note that device is only allowed to batch buffers in this way
> 
> s/device/the device/
> 
> > +if the previous used descriptor also has the VIRTQ_DESC_F_FLUSH
> > +flag set, as a result, considering the group of buffers
> 
> s/set, as/set. As/
> 
> > +used between two buffers with VIRTQ_DESC_F_FLUSH set,
> > +either all of them constitute a batch, or none at all.
> > +
> >  The device then skips forward in the ring according to the size of
> >  the batch. The driver needs to look up the used Buffer ID and
> >  calculate the batch size to be able to advance to where the next
> > diff --git a/split-ring.tex b/split-ring.tex
> > index 123ac9f..cf197f8 100644
> > --- a/split-ring.tex
> > +++ b/split-ring.tex
> > @@ -398,10 +398,11 @@ \subsection{The Virtqueue Used Ring}\label{sec:Basic Facilities of a Virtio Devi
> >          le16 avail_event; /* Only if VIRTIO_F_EVENT_IDX */
> >  };
> >  
> > -/* le32 is used here for ids for padding reasons. */
> >  struct virtq_used_elem {
> >          /* Index of start of used descriptor chain. */
> > -        le32 id;
> > +        le16 id;
> > +#define VIRTQ_USED_ELEM_F_FLUSH  0x8000
> > +        le16 flags;
> 
> This is a bit confusing for legacy, as this will only work for
> little-endian. The flags field will only be used for non-legacy, but I
> think the id field should still be treated as 32 bit for legacy.
> (We have a wholesale "it's guest endian when legacy" further up.)

True. How do you suggest handling this? Just say that id is
OR with VIRTQ_USED_ELEM_F_FLUSH ? Or maybe just add
struct virtq_used_elem_legacy?


> >          /* Total length of the descriptor chain which was used (written to) */
> >          le32 len;
> >  };
> > @@ -481,6 +482,27 @@ \subsection{In-order use of descriptors}
> >  corresponding to the head entry of the
> >  descriptor chain describing the last buffer in the batch.
> >  
> > +Other devices sometimes use
> > +descriptors in the same order in which they have been made
> > +available. These devices can offer the VIRTIO_F_PARTIAL_ORDER
> > +feature. If negotiated, whenever device has used all buffers
> 
> s/device/the device/
> 
> > +since the previous used buffer in the same order
> > +in which they have been made available, device can set the
> 
> s/device/the device/
> 
> > +VIRTQ_USED_ELEM_F_FLUSH flag in the used ring entry.
> > +
> > +This knowledge allows
> > +devices to notify the use of a batch of buffers to the driver by
> > +only writing out single used ring entry with the \field{id}
> 
> s/single/a single/
> 
> > +corresponding to the head entry of the
> > +descriptor chain describing the last buffer in the batch,
> > +and VIRTQ_USED_ELEM_F_FLUSH set.
> > +
> > +Note that device is only allowed to batch buffers in this way
> 
> s/device/the device/
> 
> > +if the previous used ring entry also has the VIRTQ_USED_ELEM_F_FLUSH
> > +flag set, as a result, considering the group of buffers
> 
> s/set, as/set. As/
> 
> > +used between two buffers with VIRTQ_USED_ELEM_F_FLUSH set,
> > +either all of them constitute a batch, or none at all.
> > +
> >  The device then skips forward in the ring according to the size of
> >  the batch. Accordingly, it increments the used \field{idx} by the
> >  size of the batch.


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

