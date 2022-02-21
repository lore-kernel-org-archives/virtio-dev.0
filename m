Return-Path: <virtio-dev-return-9318-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 16BA498634A
	for <virtio-dev@lists.oasis-open.org>; Mon, 21 Feb 2022 06:06:13 +0000 (UTC)
Message-ID: <1645423525.2784774-3-xuanzhuo@linux.alibaba.com>
Date: Mon, 21 Feb 2022 14:05:25 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20220210110343.24848-1-xuanzhuo@linux.alibaba.com>
 <ca643724-2d75-a796-2eb7-a2b397e82071@redhat.com>
In-Reply-To: <ca643724-2d75-a796-2eb7-a2b397e82071@redhat.com>
Subject: [virtio-dev] Re: [PATCH v2] virtio-net: support reset queue
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 21 Feb 2022 12:27:20 +0800, Jason Wang <jasowang@redhat.com> wrote:
>
> =E5=9C=A8 2022/2/10 =E4=B8=8B=E5=8D=887:03, Xuan Zhuo =E5=86=99=E9=81=93:
> > This patch defines some requirements for virtio-net to support reset
> > queues.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >   conformance.tex |  1 +
> >   content.tex     | 16 ++++++++++++++++
> >   2 files changed, 17 insertions(+)
> >
> > diff --git a/conformance.tex b/conformance.tex
> > index 42f8537..3656da5 100644
> > --- a/conformance.tex
> > +++ b/conformance.tex
> > @@ -396,6 +396,7 @@ \section{Conformance Targets}\label{sec:Conformance=
 / Conformance Targets}
> >   \item \ref{devicenormative:Device Types / Network Device / Device Ope=
ration / Packet Transmission}
> >   \item \ref{devicenormative:Device Types / Network Device / Device Ope=
ration / Setting Up Receive Buffers}
> >   \item \ref{devicenormative:Device Types / Network Device / Device Ope=
ration / Processing of Incoming Packets}
> > +\item \ref{devicenormative:Device Types / Network Device / Device Oper=
ation / Reset Virtqueue}
> >   \item \ref{devicenormative:Device Types / Network Device / Device Ope=
ration / Control Virtqueue / Packet Receive Filtering}
> >   \item \ref{devicenormative:Device Types / Network Device / Device Ope=
ration / Control Virtqueue / Setting MAC Address Filtering}
> >   \item \ref{devicenormative:Device Types / Network Device / Device Ope=
ration / Control Virtqueue / Gratuitous Packet Sending}
> > diff --git a/content.tex b/content.tex
> > index c6f116c..63dacb0 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -4000,6 +4000,22 @@ \subsubsection{Processing of Incoming Packets}\l=
abel{sec:Device Types / Network
> >   #define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
> >   \end{lstlisting}
> >
> > +\subsubsection{Reset Virtqueue}\label{sec:Device Types / Network Devic=
e / Device Operation / Reset Virtqueue}
> > +
> > +The receive and transmission virtqueues and the control virtqueue can =
implement
> > +reset based on Virtqueue Reset (See \ref{sec:Basic Facilities of a Vir=
tio Device / Virtqueues / Virtqueue Reset}).
> > +
> > +\devicenormative{\paragraph}{Gratuitous Packet Sending}{Device Types /=
 Network Device / Device Operation / Reset Virtqueue}
>
>
> s/"Gratuitous Packet Sending"/"Reset Virtqueue"/ ?
>
>
> > +
> > +After automatic receive steering or RSS receive steering has completed=
 the
> > +selection of the queue, if the destination receive queue is in reset s=
tate,
> > +the device SHOULD re-select a different random queue.
> > +
> > +After RSS receive steering has completed the selection of the queue, i=
f the
> > +destination receive queue is in reset state, the device can drop the p=
acket.
>
>
> I guess what we really mean is to use "MUST" here? And this paragraph
> (can drop) seems conflict with previous one (SHOULD re-select)?
>
> I wonder if it's better to add stuffs simply in the device normative in
> automatic steering and RSS instead of using a dedicated subsection here.
>

OK.

Thanks.

> Thanks
>
>
> > +
> > +If all receive queues are in reset state, the device can drop the pack=
et.
> > +
> >   \subsubsection{Control Virtqueue}\label{sec:Device Types / Network De=
vice / Device Operation / Control Virtqueue}
> >
> >   The driver uses the control virtqueue (if VIRTIO_NET_F_CTRL_VQ is
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

