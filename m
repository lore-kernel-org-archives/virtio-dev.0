Return-Path: <virtio-dev-return-10957-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5BF4B98635C
	for <virtio-dev@lists.oasis-open.org>; Mon, 13 Feb 2023 12:04:58 +0000 (UTC)
MIME-Version: 1.0
References: <20230213083019.826388-1-alvaro.karsz@solid-run.com> <20230213055946-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230213055946-mutt-send-email-mst@kernel.org>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Mon, 13 Feb 2023 14:04:19 +0200
Message-ID: <CAJs=3_AsGHMCvSQeP7pfrax1VAy4U+W0LmsaozGFuydqFUAiig@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v2] virtio-net: Fix and update VIRTIO_NET_F_NOTF_COAL feature
Content-Type: text/plain; charset="UTF-8"
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, hengqi@linux.alibaba.com, parav@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>

> > +Every transmit and receive virtqueue needs to count its own packets and should not be affected by notifications sent by other virtqueues.
>
> I find this slightly confusing in that it describes counting
> which we did not previously mention. and it is not virtqueue iself
> counting of course it is the device. We also need to
> rewrite to avoid "should" outside conformance sections.
> Also we do not have to count for each queue only
> where coalescing is enabled.
>
> I came up with
>
> Packets are counted separately for each transmit or receive virtqueue
> until max_packets is reached or until usecs elapsed since ....
>
>
> and here I am stuck. What does usecs mean exactly? since when?

I don't think we need the "until max_packets is reached or .." part.

"Packets are counted separately for each transmit or receive
virtqueue" seems good enough for me.
The "until max_packets is reached or until .." part is explained in
the TX/RX examples.

> we also have vring notication suppression we should
> explain it is kind of on top.

Mentioning in every example/explanation that we should send a
notification only if not suppressed by the driver may be too verbose
IMO.

The current approach ignores the notifications suppression, and adds
the following line in the conformance section:

A device SHOULD NOT send used buffer notifications to the driver, if
the notifications are suppressed as explained in \ref{sec:Basic
Facilities of a Virtio Device / Virtqueues / Used Buffer Notification
Suppression} ....

Don't you think that this covers all the scenarios in just one line?

But in order to be more consistent, I may need to remove the "if the
notifications are not suppressed by the driver" part from the
Notifications When Coalescing Parameters Change subparagraph.

> I also feel it would be helpful to say that e get 1 notification per
> max_packets or per usecs which ever is the smallest.

This is shown in the TX/RX examples, but maybe we can fix it as I'm
suggesting below.

>
>
> > +
> >  \subparagraph{RX Notifications}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing / RX Notifications}
> >
> >  If, for example:
> >  \begin{itemize}
> > -\item \field{rx_usecs} = 10.
> > -\item \field{rx_max_packets} = 15.
> > +\item \field{usecs} = 10.
> > +\item \field{max_packets} = 15.
> >  \end{itemize}
> >
> > -The device will operate as follows:
> > +A device with a single receive virtqueue will operate as follows:
> >
> >  \begin{itemize}
> >  \item The device will count received packets until it accumulates 15, or until 10 usecs elapsed since the first one was received.
> > @@ -1564,17 +1564,24 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
> >
> >  If, for example:
> >  \begin{itemize}
> > -\item \field{tx_usecs} = 10.
> > -\item \field{tx_max_packets} = 15.
> > +\item \field{usecs} = 10.
> > +\item \field{max_packets} = 15.
> >  \end{itemize}
> >
> > -The device will operate as follows:
> > +A device with a single transmit virtqueue will operate as follows:
> >
> >  \begin{itemize}
> >  \item The device will count sent packets until it accumulates 15, or until 10 usecs elapsed since the first one was sent.
> >  \item If the notifications are not suppressed by the driver, the device will send an used buffer notification, otherwise, the device will not send an used buffer notification as long as the notifications are suppressed.
> >  \end{itemize}
> >
> > +\subparagraph{Notifications When Coalescing Parameters Change}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing / Notifications When Coalescing Parameters Change}
> > +
> > +When a device changes the coalescing parameters, it needs to check if the new coalescing parameters are met and send a used buffer notification if so.
>
> I feel we still need to clarify "met" here please. Or add a conformance
> statement defining this more formally.
>

How about adding the following line in the main paragraph:

Coalescing parameters are met when the number of sent/received packets
reaches \field{tx_max_packets} since the last used buffer
notification, or when \field{usecs} elapses since the last used buffer
notification, whichever comes first.

And adding the following line in the conformance section:
A device SHOULD NOT send a used buffer notification if \field{usecs}
elapsed since the last used buffer notification and no packets have
been received.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

