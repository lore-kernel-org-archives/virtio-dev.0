Return-Path: <jean-philippe@linaro.org>
Date: Wed, 6 Oct 2021 12:24:28 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH] content: Remove duplicate paragraph
Message-ID: <YV2HbMevuA+KBWE+@myrica>
References: <20210930125847.28823-1-jean-philippe@linaro.org>
 <87k0it2h3j.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87k0it2h3j.fsf@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, mst@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Oct 04, 2021 at 12:56:48PM +0200, Cornelia Huck wrote:
> On Thu, Sep 30 2021, Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:
> 
> > It looks like commit 356aeeb40d7a ("content: add vendor specific cfg
> > type") had a merge issue. It includes the device normative paragraph for
> > Shared memory capability, which was already added right above it by
> > commit 855ad7af2bd6 ("shared memory: Define PCI capability"). Remove the
> > duplicate paragraph.
> >
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> > This applies onto "Fix copy/paste bug in PCI transport paragraph", that
> > fixes both paragraph titles.
> > https://lists.oasis-open.org/archives/virtio-comment/202108/msg00097.html
> > ---
> >  content.tex | 8 --------
> >  1 file changed, 8 deletions(-)
> >
> > diff --git a/content.tex b/content.tex
> > index 4418ac8..54f7441 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -1149,14 +1149,6 @@ \subsubsection{Shared memory capability}\label{sec:Virtio Transport Options / Vi
> >  
> >  The \field{cap.id} MUST be unique for any one device instance.
> >  
> > -\devicenormative{\paragraph}{Shared memory capability}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Shared memory capability}
> > -
> > -The region defined by the combination of the \field {cap.offset},
> > -\field {cap.offset_hi}, and \field {cap.length}, \field
> > -{cap.length_hi} fields MUST be contained within the declared bar.
> > -
> > -The \field{cap.id} MUST be unique for any one device instance.
> > -
> >  \subsubsection{Vendor data capability}\label{sec:Virtio
> >  Transport Options / Virtio Over PCI Bus / PCI Device Layout /
> >  Vendor data capability}
> 
> Hm. This statement is indeed included twice, but the two are not exactly
> the same. For the first paragraph, do we want to use a combination of
> the two? IOW, something like
> 
> "The region defined by the combination of the \field {cap.offset},
> \field {cap.offset_hi}, and \field {cap.length}, \field
> {cap.length_hi} fields MUST be contained within the BAR specified by
> \field{cap.bar}."
> 

Makes sense, although thinking more about this it was the first paragraph
that was correct, because it refers to:

  struct virtio_pci_cap64 {
    struct virtio_pci_cap {
      ...
      le32 offset;
      le32 length;
    } cap;
    u32 offset_hi;
    u32 length_hi;
  }

So it would be \field{cap.offset} and \field{offset_hi}.
I'll send a v2

Thanks,
Jean

