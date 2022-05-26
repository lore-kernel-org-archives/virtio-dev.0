Return-Path: <virtio-dev-return-9561-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A9499986603
	for <virtio-dev@lists.oasis-open.org>; Thu, 26 May 2022 06:37:04 +0000 (UTC)
Message-ID: <1653546839.3385897-2-xuanzhuo@linux.alibaba.com>
Date: Thu, 26 May 2022 14:33:59 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20220424083131.72881-1-xuanzhuo@linux.alibaba.com>
 <2bde85b9-afda-a719-c9ca-360780748280@redhat.com>
In-Reply-To: <2bde85b9-afda-a719-c9ca-360780748280@redhat.com>
Subject: [virtio-dev] Re: [PATCH v5] virtio-net: support reset queue
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, cohuck@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, 29 Apr 2022 10:45:28 +0800, Jason Wang <jasowang@redhat.com> wrote:
>
> =E5=9C=A8 2022/4/24 16:31, Xuan Zhuo =E5=86=99=E9=81=93:
> > A separate reset queue function introduced by Virtqueue Reset.
> >
> > However, it is currently not defined what to do if the destination queu=
e is
> > being reset when virtio-net is steering in multi-queue mode.
> >
> > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/138
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>
>
> Reviewed-by: Jason Wang <jasowang@redhat.com>

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/138

If there are no other questions, I think we can vote for this.

Thanks.

>
>
> > ---
> >   content.tex | 5 +++++
> >   1 file changed, 5 insertions(+)
> >
> > diff --git a/content.tex b/content.tex
> > index 060bdab..61c36e8 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -4337,6 +4337,10 @@ \subsubsection{Control Virtqueue}\label{sec:Devi=
ce Types / Network Device / Devi
> >   \field{virtqueue_pairs} once it has placed the
> >   VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET command in a used buffer.
> >
> > +If the destination receive queue is being reset (See \ref{sec:Basic Fa=
cilities of a Virtio Device / Virtqueues / Virtqueue Reset}),
> > +the device SHOULD re-select another random queue. If all receive queue=
s are
> > +being reset, the device MUST drop the packet.
> > +
> >   \subparagraph{Legacy Interface: Automatic receive steering in multiqu=
eue mode}\label{sec:Device Types / Network Device / Device Operation / Cont=
rol Virtqueue / Automatic receive steering in multiqueue mode / Legacy Inte=
rface: Automatic receive steering in multiqueue mode}
> >   When using the legacy interface, transitional devices and drivers
> >   MUST format \field{virtqueue_pairs}
> > @@ -4425,6 +4429,7 @@ \subsubsection{Control Virtqueue}\label{sec:Devic=
e Types / Network Device / Devi
> >   \item Calculate the hash of the packet as defined in \ref{sec:Device =
Types / Network Device / Device Operation / Processing of Incoming Packets =
/ Hash calculation for incoming packets}.
> >   \item If the device did not calculate the hash for the specific packe=
t, the device directs the packet to the receiveq specified by \field{unclas=
sified_queue} of virtio_net_rss_config structure (value of 0 corresponds to=
 receiveq1).
> >   \item Apply \field{indirection_table_mask} to the calculated hash and=
 use the result as the index in the indirection table to get 0-based number=
 of destination receiveq (value of 0 corresponds to receiveq1).
> > +\item If the destination receive queue is being reset (See \ref{sec:Ba=
sic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}), the dev=
ice MUST drop the packet.
> >   \end{itemize}
> >
> >   \paragraph{Offloads State Configuration}\label{sec:Device Types / Net=
work Device / Device Operation / Control Virtqueue / Offloads State Configu=
ration}
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

