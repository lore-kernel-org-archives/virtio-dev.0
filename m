Return-Path: <pankaj.gupta.linux@gmail.com>
MIME-Version: 1.0
References: <20211006103244.32388-1-pankaj.gupta.linux@gmail.com> <87fst3vaqm.fsf@redhat.com>
In-Reply-To: <87fst3vaqm.fsf@redhat.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Fri, 15 Oct 2021 05:32:31 +0200
Message-ID: <CAM9Jb+isBoXr2TNb9zswOeALcS4h9E-pAesD2amUdiHUibOqNg@mail.gmail.com>
Subject: Re: [PATCH v6] virtio-pmem: PMEM device spec
Content-Type: text/plain; charset="UTF-8"
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Stefan Hajnoczi <stefanha@redhat.com>, Dan Williams <dan.j.williams@intel.com>, David Hildenbrand <david@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Taylor Stark <tstark@linux.microsoft.com>, Pankaj Gupta <pankaj.gupta@ionos.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hello Cornelia,

> > Posting virtio specification for virtio pmem device. Virtio pmem is a
> > paravirtualized device which allows the guest to bypass page cache.
> > Virtio pmem kernel driver is merged in Upstream Kernel 5.3. Also, Qemu
> > device is merged in Qemu 4.1.
> >
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Signed-off-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> > ---
> > v5 -> v6
> >  Text change in security implication section - Cornelia
> >  Added r-o-b from Stefan
> >
> >  conformance.tex |  16 +++++-
> >  content.tex     |   1 +
> >  virtio-pmem.tex | 129 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 144 insertions(+), 2 deletions(-)
> >  create mode 100644 virtio-pmem.tex
> >
> > diff --git a/conformance.tex b/conformance.tex
> > index 94d7a06..7331003 100644
> > --- a/conformance.tex
> > +++ b/conformance.tex
> > @@ -31,7 +31,8 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
> >  \ref{sec:Conformance / Driver Conformance / Sound Driver Conformance},
> >  \ref{sec:Conformance / Driver Conformance / Memory Driver Conformance},
> >  \ref{sec:Conformance / Driver Conformance / I2C Adapter Driver Conformance} or
> > -\ref{sec:Conformance / Driver Conformance / SCMI Driver Conformance}.
> > +\ref{sec:Conformance / Driver Conformance / SCMI Driver Conformance},
> > +\ref{sec:Conformance / Driver Conformance / PMEM Driver Conformance}.
> >
> >      \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
> >    \end{itemize}
> > @@ -55,7 +56,8 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
> >  \ref{sec:Conformance / Device Conformance / Sound Device Conformance},
> >  \ref{sec:Conformance / Device Conformance / Memory Device Conformance},
> >  \ref{sec:Conformance / Device Conformance / I2C Adapter Device Conformance} or
> > -\ref{sec:Conformance / Device Conformance / SCMI Device Conformance}.
> > +\ref{sec:Conformance / Device Conformance / SCMI Device Conformance},
> > +\ref{sec:Conformance / Device Conformance / PMEM Driver Conformance}.
> >
> >      \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
> >    \end{itemize}
> > @@ -301,6 +303,16 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
> >  \item \ref{drivernormative:Device Types / SCMI Device / Device Operation / Setting Up eventq Buffers}
> >  \end{itemize}
> >
> > +\conformance{\subsection}{PMEM Driver Conformance}\label{sec:Conformance / Driver Conformance / PMEM Driver Conformance}
> > +
> > +A PMEM driver MUST conform to the following normative statements:
> > +
> > +\begin{itemize}
> > +\item \ref{devicenormative:Device Types / PMEM Device / Device Initialization}
> > +\item \ref{devicenormative:Device Types / PMEM Device / Device Operation / Virtqueue flush}
> > +\item \ref{devicenormative:Device Types / PMEM Device / Device Operation / Virtqueue return}
> > +\end{itemize}
> > +
> >  \conformance{\section}{Device Conformance}\label{sec:Conformance / Device Conformance}
> >
> >  A device MUST conform to the following normative statements:
>
> So, I ran into some problems while trying to apply this.
>
> First, this is against an older version of the tree, so it did not apply
> cleanly.

Sorry! somehow i missed this.
>
> Second, the conformance section looks off: we don't have a driver
> conformance section, and the device conformance section ends up being
> called a driver conformance section. Unfortunately, I had neglected to
> review that properly :(
>
> I think the following would be correct; I'm inclined to apply this spec
> with it as an editorial edit. Any comments/objections?

my bad :(

Thank you for your help!
Hope this makes into master now.

Best regards,
Pankaj
>
> diff --git a/conformance.tex b/conformance.tex
> index c52f1a40be2d..c2d79596f515 100644
> --- a/conformance.tex
> +++ b/conformance.tex
> @@ -56,8 +56,9 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>  \ref{sec:Conformance / Device Conformance / Sound Device Conformance},
>  \ref{sec:Conformance / Device Conformance / Memory Device Conformance},
>  \ref{sec:Conformance / Device Conformance / I2C Adapter Device Conformance},
> -\ref{sec:Conformance / Device Conformance / SCMI Device Conformance} or
> -\ref{sec:Conformance / Device Conformance / GPIO Device Conformance}.
> +\ref{sec:Conformance / Device Conformance / SCMI Device Conformance},
> +\ref{sec:Conformance / Device Conformance / GPIO Device Conformance} or
> +\ref{sec:Conformance / Device Conformance / PMEM Device Conformance}.
>
>      \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
>    \end{itemize}
> @@ -570,6 +571,15 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>  \item \ref{devicenormative:Device Types / GPIO Device / requestq Operation}
>  \end{itemize}
>
> +\conformance{\subsection}{PMEM Device Conformance}\label{sec:Conformance / Device Conformance / PMEM Device Conformance}
> +
> +A PMEM device MUST conform to the following normative statements:
> +
> +\begin{itemize}
> +\item \ref{devicenormative:Device Types / PMEM Device / Device Operation / Virtqueue flush}
> +\item \ref{devicenormative:Device Types / PMEM Device / Device Operation / Virtqueue return}
> +\end{itemize}
> +
>  \conformance{\section}{Legacy Interface: Transitional Device and Transitional Driver Conformance}\label{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}
>  A conformant implementation MUST be either transitional or
>  non-transitional, see \ref{intro:Legacy
>

