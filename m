Return-Path: virtio-dev-return-4096-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 89C0A58191C7
	for <virtio-dev@lists.oasis-open.org>; Fri, 18 May 2018 02:06:39 -0700 (PDT)
Date: Fri, 18 May 2018 17:06:53 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180518090653.GA9178@debian>
References: <20180518073855.21070-1-tiwei.bie@intel.com>
 <20180518101438.6748a49d.cohuck@redhat.com>
 <20180518084309.GA3839@debian>
 <20180518110101.2588147f.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180518110101.2588147f.cohuck@redhat.com>
Subject: Re: [virtio-dev] [RFC] content: support SR-IOV
To: Cornelia Huck <cohuck@redhat.com>
Cc: mst@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, dan.daly@intel.com, alexander.h.duyck@intel.com, mark.d.rustad@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, May 18, 2018 at 11:01:01AM +0200, Cornelia Huck wrote:
> On Fri, 18 May 2018 16:43:09 +0800
> Tiwei Bie <tiwei.bie@intel.com> wrote:
> 
> > On Fri, May 18, 2018 at 10:14:38AM +0200, Cornelia Huck wrote:
> > > On Fri, 18 May 2018 15:38:55 +0800
> > > Tiwei Bie <tiwei.bie@intel.com> wrote:
> > >   
> > > > Reserve a feature bit for virtio devices which support SR-IOV.  
> > > 
> > > Reserving a feature bit for this makes sense, but...
> > >   
> > > > 
> > > > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > > > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > > > ---
> > > > More details can be found from this thread:
> > > > https://patchwork.kernel.org/patch/10285541/
> > > > 
> > > >  content.tex | 14 ++++++++++++--
> > > >  1 file changed, 12 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/content.tex b/content.tex
> > > > index 7a92cb1..62214fa 100644
> > > > --- a/content.tex
> > > > +++ b/content.tex
> > > > @@ -95,10 +95,10 @@ Feature bits are allocated as follows:
> > > >  \begin{description}
> > > >  \item[0 to 23] Feature bits for the specific device type
> > > >  
> > > > -\item[24 to 33] Feature bits reserved for extensions to the queue and
> > > > +\item[24 to 36] Feature bits reserved for extensions to the queue and
> > > >    feature negotiation mechanisms
> > > >  
> > > > -\item[34 and above] Feature bits reserved for future extensions.
> > > > +\item[37 and above] Feature bits reserved for future extensions.
> > > >  \end{description}
> > > >  
> > > >  \begin{note}
> > > > @@ -5348,6 +5348,8 @@ Descriptors} and \ref{sec:Packed Virtqueues / Indirect Flag: Scatter-Gather Supp
> > > >    \item[VIRTIO_F_IN_ORDER(35)] This feature indicates
> > > >    that all buffers are used by the device in the same
> > > >    order in which they have been made available.
> > > > +  \item[VIRTIO_F_SR_IOV(36)] This feature indicates that
> > > > +  the device supports Single Root I/O Virtualization.  
> > > 
> > > ...shouldn't this mention 'PCI' somewhere? This feature does not make
> > > sense on any transport but PCI.  
> > 
> > Yeah. When Michael suggested this feature, he also said:
> > 
> > https://patchwork.kernel.org/patch/10285541/
> > """
> > It seems PCI specific so non pci transports would disable the feature
> > for now.
> > """
> > 
> > Based on the current description, transports other than
> > PCI would have this feature bit disabled.
> > 
> > Do you think there is any possibility that other transports
> > may reuse this feature bit to do something similar?
> 
> I don't know about mmio (and I'm not sure how actively it is
> developed), but ccw is so different that I don't see how it could match
> to anything there.

Got it. Thanks!

> 
> > 
> > Or do you think we should make this feature bit PCI specific
> > and don't leave any chance for other transports to reuse
> > it, e.g. by naming it as VIRTIO_F_PCI_SR_IOV?
> > 
> > Or do you think it's OK to still name it as VIRTIO_F_SR_IOV,
> > but add the word 'PCI' when talking about the capability,
> > e.g.:
> > 
> > A device SHOULD offer VIRTIO_F_SR_IOV if it presents a PCI
> > SR-IOV capability structure.  A device MAY fail to operate
> > further if VIRTIO_F_SR_IOV is not accepted.
> 
> Adding 'PCI' to the description is probably best, I think.

Got it. I'll do it in the next version. Thanks!

Best regards,
Tiwei Bie

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

