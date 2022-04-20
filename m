Return-Path: <pasic@linux.ibm.com>
Date: Wed, 20 Apr 2022 13:57:01 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [virtio-dev] Re: [virtio-comment] [PATCH] packed-ring.tex: link
 conformance statements
Message-ID: <20220420135701.17063ac0.pasic@linux.ibm.com>
In-Reply-To: <878rs185vw.fsf@redhat.com>
References: <20220419143435.126705-1-mst@redhat.com>
	<878rs185vw.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, virtio@lists.oasis-open.org, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 19 Apr 2022 17:11:47 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Tue, Apr 19 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > Link conformance statements into conformance chapter.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  conformance.tex |  9 +++++++++
> >  packed-ring.tex | 16 +++++-----------
> >  2 files changed, 14 insertions(+), 11 deletions(-)
> >
> > diff --git a/conformance.tex b/conformance.tex
> > index 9807c30..663e7c3 100644
> > --- a/conformance.tex
> > +++ b/conformance.tex
> > @@ -85,6 +85,12 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
> >  \item \ref{drivernormative:Basic Facilities of a Virtio Device / Virtqueues / Available Buffer Notification Suppression}
> >  \item \ref{drivernormative:Basic Facilities of a Virtio Device / Virtqueues / Supplying Buffers to The Device / Updating idx}
> >  \item \ref{drivernormative:Basic Facilities of a Virtio Device / Virtqueues / Supplying Buffers to The Device / Notifying The Device}
> > +\item \ref{drivernormative:Basic Facilities of a Virtio Device / Packed Virtqueues}
> > +\item \ref{drivernormative:Basic Facilities of a Virtio Device / PAcked Virtqueues / The Virtqueue Descriptor Table}  
> 
> I wonder whether we could use the opportunity to fix that "PAcked" typo
> here as well.
> 
> > +\item \ref{drivernormative:Basic Facilities of a Virtio Device / Packed Virtqueues / Scatter-Gather Support}
> > +\item \ref{drivernormative:Basic Facilities of a Virtio Device / Packed Virtqueues / The Virtqueue Descriptor Table / Indirect Descriptors}
> > +\item \ref{drivernormative:Basic Facilities of a Virtio Device / Packed Virtqueues / Supplying Buffers to The Device / Updating flags}
> > +\item \ref{drivernormative:Basic Facilities of a Virtio Device / Packed Virtqueues / Supplying Buffers to The Device / Sending Available Buffer Notifications}
> >  \item \ref{drivernormative:General Initialization And Device Operation / Device Initialization}
> >  \item \ref{drivernormative:General Initialization And Device Operation / Device Cleanup}
> >  \item \ref{drivernormative:Reserved Feature Bits}
> > @@ -340,6 +346,9 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
> >  \item \ref{devicenormative:Basic Facilities of a Virtio Device / Virtqueues / Used Buffer Notification Suppression}
> >  \item \ref{devicenormative:Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Used Ring}
> >  \item \ref{devicenormative:Basic Facilities of a Virtio Device / Virtqueues / Available Buffer Notification Suppression}
> > +\item \ref{devicenormative:Basic Facilities of a Virtio Device / Packed Virtqueues}
> > +\item \ref{devicenormative:Basic Facilities of a Virtio Device / Packed Virtqueues / The Virtqueue Descriptor Table}
> > +\item \ref{devicenormative:Basic Facilities of a Virtio Device / Packed Virtqueues / Scatter-Gather Support}
> >  \item \ref{devicenormative:Basic Facilities of a Virtio Device / Shared Memory Regions}
> >  \item \ref{devicenormative:Reserved Feature Bits}
> >  \end{itemize}  
> 
> I guess it is ok to link this up as an editorial update; the statements
> are pre-existing, and an implementation that does not know the feature
> bit remains compliant.
> 

I tend to agree
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 

