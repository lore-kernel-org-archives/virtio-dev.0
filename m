Return-Path: virtio-comment-return-822-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Mon, 29 Jul 2019 16:48:41 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190729154841.GH2756@work-vm>
References: <20190712122002.10793-1-dgilbert@redhat.com>
 <20190712122002.10793-4-dgilbert@redhat.com>
 <8f717089-43d6-e989-3e54-82be5b546185@arrikto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f717089-43d6-e989-3e54-82be5b546185@arrikto.com>
Subject: [virtio-comment] Re: [virtio-dev] [PATCH v7 3/5] pci: Define virtio_pci_cap64
To: Nikos Dragazis <ndragazis@arrikto.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, stefanha@redhat.com, cohuck@redhat.com, vgoyal@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

* Nikos Dragazis (ndragazis@arrikto.com) wrote:
> On 12/7/19 3:20 μ.μ., Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > Define 'virtio_pci_cap64' to allow capabilities to describe
> > memory regions larger than, or with an offset larger than 4GiB.
> >
> > This will be used by the shared memory region capability.
> >
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >  content.tex | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/content.tex b/content.tex
> > index fafa532..d481359 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -746,6 +746,23 @@ \subsection{Virtio Structure PCI Capabilities}\label{sec:Virtio Transport Option
> >          \end{note}
> >  \end{description}
> >  
> > +A variant of this type, struct virtio_pci_cap64, is defined for
> > +those capaibilites that require offsets or lengths larger than
> 
> David,
> 
> I have seen that your patchset has been approved, but I just noticed
> that there is a typo here (capaibilites -> capabilities).

oops! Please just post a fix patch.

Dave

> --
> Nikos
> 
> > +4GiB:
> > +
> > +\begin{lstlisting}
> > +struct virtio_pci_cap64 {
> > +        struct virtio_pci_cap cap;
> > +        u32 offset_hi;
> > +        u32 length_hi;
> > +};
> > +\end{lstlisting}
> > +
> > +Given that the \field{cap.length} and \field{cap.offset} fields
> > +are only 32 bit, the additional \field{offset_hi} and \field {length_hi}
> > +fields provide the most significant 32 bits of a total 64 bit offset and
> > +length within the bar specified by \field{cap.bar}.
> > +
> >  \drivernormative{\subsubsection}{Virtio Structure PCI Capabilities}{Virtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities}
> >  
> >  The driver MUST ignore any vendor-specific capability structure which has
> 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

