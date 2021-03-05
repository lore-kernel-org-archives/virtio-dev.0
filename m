Return-Path: virtio-dev-return-8100-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CB3B09864E6
	for <virtio-dev@lists.oasis-open.org>; Fri,  5 Mar 2021 11:38:52 +0000 (UTC)
Date: Fri, 5 Mar 2021 12:38:44 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20210305123844.45f176d4.cohuck@redhat.com>
In-Reply-To: <CAPR809vK4XuhRGtf4=4bP+6XNpXTUND4mE0vKBE2f_1bUvv_DQ@mail.gmail.com>
References: <CAPR809to17OpKuAvoYvdjpZYmVxbTi5umTABc4UZf90iqC0UmA@mail.gmail.com>
	<20210303181807.756bb723.cohuck@redhat.com>
	<CAPR809vK4XuhRGtf4=4bP+6XNpXTUND4mE0vKBE2f_1bUvv_DQ@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH v3] Add lifetime metrics to virtio-blk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Enrico Granata <egranata@google.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 3 Mar 2021 11:01:50 -0700
Enrico Granata <egranata@google.com> wrote:

> On Wed, Mar 3, 2021 at 10:18 AM Cornelia Huck <cohuck@redhat.com> wrote:
> >
> > On Mon, 1 Mar 2021 10:51:03 -0700
> > Enrico Granata <egranata@google.com> wrote:
> >  
> > > In many embedded systems, virtio-blk implementations are
> > > backed by eMMC or UFS storage devices, which are subject to
> > > predictable and measurable wear over time due to repeated write
> > > cycles.
> > >
> > > For such systems, it can be important to be able to track
> > > accurately the amount of wear imposed on the storage over
> > > time and surface it to applications. In a native deployments
> > > this is generally handled by the physical block device driver
> > > but no such provision is made in virtio-blk to expose these
> > > metrics for devices where it makes sense to do so.
> > >
> > > This patch adds support to virtio-blk for lifetime and wear
> > > metrics to be exposed to the guest when a deployment of
> > > virtio-blk is done over compatible eMMC or UFS storage.
> > >
> > > Signed-off-by: Enrico Granata <egranata@google.com>
> > > ---
> > >  content.tex | 31 +++++++++++++++++++++++++++++--
> > >  1 file changed, 29 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/content.tex b/content.tex
> > > index 835f1ea..47e3566 100644
> > > --- a/content.tex
> > > +++ b/content.tex
> > > @@ -4418,6 +4418,9 @@ \subsection{Feature bits}\label{sec:Device Types
> > > / Block Device / Feature bits}  
> >
> > [something seems to have caused line wrapping in this patch]
> >  
> 
> Hmm... I can try applying again and sending out as a v4?

Please do, if we don't have any more changes on top.

> 
> > >  \item[VIRTIO_BLK_F_WRITE_ZEROES (14)] Device can support write zeroes command,
> > >       maximum write zeroes sectors size in \field{max_write_zeroes_sectors} and
> > >       maximum write zeroes segment number in \field{max_write_zeroes_seg}.
> > > +
> > > +\item[VIRTIO_BLK_F_LIFETIME (15)] Device supports providing storage lifetime
> > > +     information.
> > >  \end{description}
> > >
> > >  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types
> > > / Block Device / Feature bits / Legacy Interface: Feature bits}
> > > @@ -4601,14 +4604,16 @@ \subsection{Device Operation}\label{sec:Device
> > > Types / Block Device / Device Ope
> > >
> > >  The type of the request is either a read (VIRTIO_BLK_T_IN), a write
> > >  (VIRTIO_BLK_T_OUT), a discard (VIRTIO_BLK_T_DISCARD), a write zeroes
> > > -(VIRTIO_BLK_T_WRITE_ZEROES), a flush (VIRTIO_BLK_T_FLUSH), or a get device ID
> > > -string command (VIRTIO_BLK_T_GET_ID).
> > > +(VIRTIO_BLK_T_WRITE_ZEROES), a flush (VIRTIO_BLK_T_FLUSH), a get device ID
> > > +string command (VIRTIO_BLK_T_GET_ID), or a get device lifetime
> > > +command (VIRTIO_BLK_T_GET_LIFETIME).
> > >
> > >  \begin{lstlisting}
> > >  #define VIRTIO_BLK_T_IN           0
> > >  #define VIRTIO_BLK_T_OUT          1
> > >  #define VIRTIO_BLK_T_FLUSH        4
> > >  #define VIRTIO_BLK_T_GET_ID       8
> > > +#define VIRTIO_BLK_T_GET_LIFETIME 10
> > >  #define VIRTIO_BLK_T_DISCARD      11
> > >  #define VIRTIO_BLK_T_WRITE_ZEROES 13
> > >  \end{lstlisting}
> > > @@ -4648,6 +4653,23 @@ \subsection{Device Operation}\label{sec:Device
> > > Types / Block Device / Device Ope
> > >  \field{data}.  The device ID string is a NUL-padded ASCII string up to 20 bytes
> > >  long.  If the string is 20 bytes long then there is no NUL terminator.
> > >
> > > +The \field{data} used for VIRTIO_BLK_T_GET_LIFETIME requests is populated by
> > > +the device, and is of the form:
> > > +
> > > +\begin{lstlisting}
> > > +struct virtio_blk_lifetime {
> > > +    le16 pre_eol_info;
> > > +    le16 device_lifetime_est_a;
> > > +    le16 device_lifetime_est_b;
> > > +};
> > > +\end{lstlisting}
> > > +
> > > +The device lifetime metrics \field{pre_eol_info}, \field{device_lifetime_est_a}
> > > +and \field{device_lifetime_est_b} have the semantics described by the JEDEC
> > > +standard No.84-B50 for the extended CSD register fields \field{PRE_EOL_INFO}
> > > +\field{DEVICE_LIFETIME_EST_TYP_A} and \field{DEVICE_LIFETIME_EST_TYP_B}
> > > +respectively.  
> >
> > Do we have an explicit link to that JEDEC standard?
> >  
> 
> I believe the specification is under a JEDEC paywall. I have access to
> it by means of my employer, but it doesn't seem to be publicly
> available.

That's unfortunate... how much of the information in there is needed
for someone to come up with a compliant implementation? Can we condense
that to a sentence or two that would be unproblematic to put into the
standard?

If JEDEC is providing reasonable licensing terms, I guess it could also
be an option to just refer to their homepage and specifying that
standard (I think the full name is JESD84-B50 -- at least that's what
my searching pointed to.)

> 
> > > +
> > >  The final \field{status} byte is written by the device: either
> > >  VIRTIO_BLK_S_OK for success, VIRTIO_BLK_S_IOERR for device or driver
> > >  error or VIRTIO_BLK_S_UNSUPP for a request unsupported by device:
> > > @@ -4754,6 +4776,11 @@ \subsection{Device Operation}\label{sec:Device
> > > Types / Block Device / Device Ope
> > >  (case~\ref{item:flush3}).  Failure to do so can cause data loss
> > >  in case of a crash.
> > >
> > > +If the device is backed by eMMC or UFS persistent storage, the device SHOULD
> > > +offer the VIRTIO_BLK_F_LIFETIME flag. The flag MUST NOT be offered if
> > > the device
> > > +is backed by storage for which the lifetime metrics as described in
> > > this document
> > > +cannot be obtained or have no useful meaning.  
> >
> > Isn't that outside of the normative sections? If so, please make this a
> > description without SHOULD and MUST NOT, and add them to the normative
> > clauses.
> >  
> 
> Hmm.. when I look at my local copy, I see this section right below the clause:
> 
> "If the device is backed by persistent storage, the device MUST ensure that
> stable writes are committed to it, before reporting completion of the write
> (cases~\ref{item:flush1} and~\ref{item:flush2}) or the flush
> (case~\ref{item:flush3}).  Failure to do so can cause data loss
> in case of a crash."
> 
> It looked like the right place to add this kind of clause to me, but
> if I am wrong and you would like to see it moved, please do let me
> know.

Ah, sorry, my mistake; I must have slipped in the document, your
addition is fine.

> Maybe I really do just need to apply the patch again on a clean-slate
> repository, if what I see locally does not align?
> 
> > Also, are eMMC/UFS just examples (i.e. may other types of persistent
> > storage provide these metrics as well?)
> >  
> 
> I can't say I know of other hardware that provides identical metrics,
> but it could be possible and maybe could be done by software
> adaptation for other storage systems?

If we can get potentially get the same metrics from other hardware,
that sentence should probably be reworded a bit. What about:

"If the device is backed by storage providing life time metrics (such
as eMMC or UFS persistent storage), the device SHOULD offer the
VIRTIO_BLK_F_LIFETIME flag."

?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

