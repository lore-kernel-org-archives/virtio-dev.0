Return-Path: virtio-dev-return-8148-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0A43B9864D6
	for <virtio-dev@lists.oasis-open.org>; Wed,  5 May 2021 10:34:53 +0000 (UTC)
Date: Wed, 5 May 2021 06:34:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20210505062458-mutt-send-email-mst@kernel.org>
References: <20210420162556.217350-1-egranata@google.com>
 <20210502045740-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20210502045740-mutt-send-email-mst@kernel.org>
Subject: [virtio-dev] Re: [PATCH] Provide detailed specification of virtio-blk lifetime
 metrics
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Enrico Granata <egranata@google.com>
Cc: virtio-dev@lists.oasis-open.org, hch@infradead.org, linux-block@vger.kernel.org, virtualization@lists.linux-foundation.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, May 02, 2021 at 05:12:14AM -0400, Michael S. Tsirkin wrote:
> On Tue, Apr 20, 2021 at 04:25:56PM +0000, Enrico Granata wrote:
> > In the course of review, some concerns were surfaced about the
> > original virtio-blk lifetime proposal, as it depends on the eMMC
> > spec which is not open
> > 
> > Add a more detailed description of the meaning of the fields
> > added by that proposal to the virtio-blk specification, as to
> > make it feasible to understand and implement the new lifetime
> > metrics feature without needing to refer to JEDEC's specification
> > 
> > This patch does not change the meaning of those fields nor add
> > any new fields, but it is intended to provide an open and more
> > clear description of the meaning associated with those fields.
> > 
> > Signed-off-by: Enrico Granata <egranata@google.com>
> 
> Enrico it's great that you are reaching out to the
> wider storage community before making spec changes.
> 
> Christoph could you please comment on whether this addresses
> your concerns with the lifetime feature.
> You wrote "it really needs to stand a lone and be properly documented"
> and this seems to be the direction this patch is going in.
> 
> 
> > ---
> >  content.tex | 34 +++++++++++++++++++++++++++-------
> >  1 file changed, 27 insertions(+), 7 deletions(-)
> > 
> > diff --git a/content.tex b/content.tex
> > index 9232d5c..7e14ccc 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -4669,13 +4669,32 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
> >  \end{lstlisting}
> >  
> >  The device lifetime metrics \field{pre_eol_info}, \field{device_lifetime_est_a}
> > -and \field{device_lifetime_est_b} have the semantics described by the JESD84-B50
> > -specification for the extended CSD register fields \field{PRE_EOL_INFO}
> > -\field{DEVICE_LIFETIME_EST_TYP_A} and \field{DEVICE_LIFETIME_EST_TYP_B}
> > -respectively.
> > +and \field{device_lifetime_est_b} are discussed in the JESD84-B50 specification.
> >  
> > -JESD84-B50 is available at the JEDEC website (https://www.jedec.org)
> > -pursuant to JEDEC's licensing terms and conditions.
> > +The complete JESD84-B50 is available at the JEDEC website (https://www.jedec.org)
> > +pursuant to JEDEC's licensing terms and conditions.
> 
> These links really belong in either normative or non-normative
> references section.
> 
> > For the purposes of this
> > +specification, these fields are defined as follows.
> 
> All this seems kind of vague. What does one need that spec for?
> Is it just a note for pass-through developers?
> 
> How about "to simplify pass-through
> from eMMC devices the format of fields 
>   pre_eol_info, device_lifetime_est_typ_a and device_lifetime_est_typ_b
> matches PRE_EOL_INFO, DEVICE_LIFETIME_EST_TYP_A and DEVICE_LIFETIME_EST_TYP_B
> in the 
> \hyperref[intro:PCI]{[PCI]}.
> 
> 
> 
> Also, now that I mention it, what about NVMe pass-through? Arguably
> nvme is getting more popular. Will we be able to support that use-case
> as well? Or is more data needed? What is the plan there?
> 
> > +
> > +The \field{pre_eol_info} will have one of these values:

Besides specifying the values what does it mean exactly?
E.g. what are blocks?

E.g. "pre_eol_info specifies the percentage of blocks consumed
on the device" and explain what blocks are here.

> > +
> > +\begin{lstlisting}
> > +// Value not available
> > +#define PRE_EOL_INFO_UNDEFINED    0
> > +// < 80% of blocks are consumed
> > +#define PRE_EOL_INFO_NORMAL       1
> > +// 80% of blocks are consumed
> > +#define PRE_EOL_INFO_WARNING      2
> > +// 90% of blocks are consumed
> > +#define PRE_EOL_INFO_URGENT       3
> > +// All others values are reserved


Also please prefix with VIRTIO_BLK_ for consistency.

> 
> 
> Block comments /* */ should be used as these are documented
> in the introduction.
> 
> > +\end{lstlisting}
> > +
> > +The \field{device_lifetime_est_typ_a} refers to wear of SLC cells and is provided in
> > +increments of 10%, with 0 meaning undefined, 1 meaning up-to 10% of lifetime used, and so on,
> > +thru to 11 meaning estimated lifetime exceeded. All values above 11 are reserved.
> > +
> > +The \field{device_lifetime_est_typ_b} refers to wear of MLC cells and is provided with
> > +the same semantics as \field{device_lifetime_est_typ_a}.
> >  
> >  The final \field{status} byte is written by the device: either
> >  VIRTIO_BLK_S_OK for success, VIRTIO_BLK_S_IOERR for device or driver
> > @@ -4812,7 +4831,8 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
> >  or UFS persistent storage), the device SHOULD offer the VIRTIO_BLK_F_LIFETIME
> >  flag. The flag MUST NOT be offered if the device is backed by storage for which
> >  the lifetime metrics described in this document cannot be obtained or for which
> > -such metrics have no useful meaning.
> > +such metrics have no useful meaning. If the metrics are offered, the device MUST NOT
> > +send any reserved values, as defined in this specification.
> >  
> >  \subsubsection{Legacy Interface: Device Operation}\label{sec:Device Types / Block Device / Device Operation / Legacy Interface: Device Operation}
> >  When using the legacy interface, transitional devices and drivers
> > -- 
> > 2.31.1.368.gbe11c130af-goog
> > 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

