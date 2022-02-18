Return-Path: <virtio-dev-return-9314-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7E9509864C3
	for <virtio-dev@lists.oasis-open.org>; Fri, 18 Feb 2022 09:27:56 +0000 (UTC)
Date: Fri, 18 Feb 2022 04:27:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220218042604-mutt-send-email-mst@kernel.org>
References: <20220210090604.32603-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEsmhLVozpGpTBWv1WJ_RMq=ckajCK9ZLo5eWckxGpNdiA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsmhLVozpGpTBWv1WJ_RMq=ckajCK9ZLo5eWckxGpNdiA@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v1] virtio-net: support reset queue
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Feb 10, 2022 at 05:26:24PM +0800, Jason Wang wrote:
> On Thu, Feb 10, 2022 at 5:06 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > This patch defines some requirements for virtio-net to support reset
> > queues.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  conformance.tex |  1 +
> >  content.tex     | 12 ++++++++++++
> >  2 files changed, 13 insertions(+)
> >
> > diff --git a/conformance.tex b/conformance.tex
> > index 42f8537..3656da5 100644
> > --- a/conformance.tex
> > +++ b/conformance.tex
> > @@ -396,6 +396,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
> >  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Packet Transmission}
> >  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Setting Up Receive Buffers}
> >  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Processing of Incoming Packets}
> > +\item \ref{devicenormative:Device Types / Network Device / Device Operation / Reset Virtqueue}
> >  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Packet Receive Filtering}
> >  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Setting MAC Address Filtering}
> >  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Gratuitous Packet Sending}
> > diff --git a/content.tex b/content.tex
> > index c6f116c..af86689 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -4000,6 +4000,18 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
> >  #define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
> >  \end{lstlisting}
> >
> > +\subsubsection{Reset Virtqueue}\label{sec:Device Types / Network Device / Device Operation / Reset Virtqueue}
> > +
> > +The receive and transmission virtqueues and the control virtqueue can implement
> > +reset based on Virtqueue Reset (See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
> > +
> > +\devicenormative{\paragraph}{Gratuitous Packet Sending}{Device Types / Network Device / Device Operation / Reset Virtqueue}
> > +
> > +After automatic receive steering or RSS receive steering has completed the
> > +selection of the queue, if the destination receive queue is in reset state,
> > +the device SHOULD re-select a different random queue.
> 
> This seems break the semantics of the indirection table?

I don't really understand this random thing either. If we don't want to
drop then maybe use unclassified_queue?
And generally - is packet reordering better or worse than packet drops?

> For RSS, I
> think we probably need to drop.
> 
> Thanks
> 
> > If all receive queues are
> > +in reset state, the device can drop the packet.
> > +
> >  \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue}
> >
> >  The driver uses the control virtqueue (if VIRTIO_NET_F_CTRL_VQ is
> > --
> > 2.31.0
> >


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

