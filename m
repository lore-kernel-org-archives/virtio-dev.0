Return-Path: <virtio-comment-return-3854-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
MIME-Version: 1.0
References: <20230111152123.148889-1-alvaro.karsz@solid-run.com> <20230116103009-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230116103009-mutt-send-email-mst@kernel.org>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Tue, 17 Jan 2023 14:42:00 +0200
Message-ID: <CAJs=3_D6T+Zkn3CrFPEYyR=pu3zmDAYnsgNrLYRRt9q0GjjjVQ@mail.gmail.com>
Subject: [virtio-comment] Re: [PATCH v2] virtio_net: support low and high rate of notification coalescing
Content-Type: text/plain; charset="UTF-8"
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

> >  #define VIRTIO_NET_CTRL_NOTF_COAL 6
> >   #define VIRTIO_NET_CTRL_NOTF_COAL_TX_SET  0
> >   #define VIRTIO_NET_CTRL_NOTF_COAL_RX_SET 1
> > + #define VIRTIO_NET_CTRL_NOTF_COAL_LOW_TX_SET 2 //Only if VIRTIO_NET_F_NOTF_COAL_LOW_HIGH negotiated
> > + #define VIRTIO_NET_CTRL_NOTF_COAL_LOW_RX_SET 3 //Only if VIRTIO_NET_F_NOTF_COAL_LOW_HIGH negotiated
> > + #define VIRTIO_NET_CTRL_NOTF_COAL_HIGH_TX_SET 4 //Only if VIRTIO_NET_F_NOTF_COAL_LOW_HIGH negotiated
> > + #define VIRTIO_NET_CTRL_NOTF_COAL_HIGH_RX_SET 5 //Only if VIRTIO_NET_F_NOTF_COAL_LOW_HIGH negotiated
>
> add conformance statements for this requirement of
> VIRTIO_NET_F_NOTF_COAL_LOW_HIGH too?

I did:
> +If the VIRTIO_NET_F_NOTF_COAL_LOW_HIGH feature has not been negotiated, the driver MUST NOT issue low/high rate coalescing commands.

> > -Coalescing parameters:
> > +TX Coalescing parameters:
> > +\begin{itemize}
> > +\item \field{usecs}: Maximum number of usecs to delay a TX notification.
> > +\item \field{max_packets}: Maximum number of packets to send before a TX notification.
> > +\end{itemize}
> > +
> > +RX Coalescing parameters:
> > +\begin{itemize}
> > +\item \field{usecs}: Maximum number of usecs to delay a RX notification.
> > +\item \field{max_packets}: Maximum number of packets to receive before a RX notification.
> > +\end{itemize}
>
> just unify these - TX/RX notification?

ok

> > +General Coalescing parameters:
> >  \begin{itemize}
> > -\item \field{rx_usecs}: Maximum number of usecs to delay a RX notification.
> > -\item \field{tx_usecs}: Maximum number of usecs to delay a TX notification.
> > -\item \field{rx_max_packets}: Maximum number of packets to receive before a RX notification.
> > -\item \field{tx_max_packets}: Maximum number of packets to send before a TX notification.
> > +\item \field{pkt_rate}: Threshold for low/high packet rate coalescing parameters, in units of packets per second.
>
> This isn't really clear. Besides it seems that with 100GB/s we can thinkably begin to
> overflow a 32 bit value pretty soon.

I'll clarify the sentence.
You're right about the 100Gb/s links, I can think of a few ways to address this:

1) We could increase the type to u64.
2) We could change the pkt_rate units to packets per 100 usecs or some
other arbitrary value.
3) The user could choose the packet rate units using new fields in
virtio_net_config.

I think that the third option is the better choice here.

> Also, how is this measured?
> Do you expect device to average the rate over a whole second to decide?
> Ethernet speeds start at 1MBit/sec right? I think these days if
> we ask for # of packets in the last N usecs we won't go far
> off the field. How much is N so as not to incur too much latency?
> 100?
>
> Or are we measuring X latest packets and testing how long it takes
> to get them?

Why do we want this to be part of the spec?
I think that we should leave this to the device to decide.


> > -The class VIRTIO_NET_CTRL_NOTF_COAL has 2 commands:
> > +The class VIRTIO_NET_CTRL_NOTF_COAL has 6 commands:
> >  \begin{enumerate}
> > -\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{tx_usecs} and \field{tx_max_packets} parameters.
> > -\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{rx_usecs} and \field{rx_max_packets} parameters.
> > +\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{usecs} and \field{max_packets} coalescing parameters for TX.
> > +\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{usecs} and \field{max_packets} coalescing parameters for RX.
> > +\item VIRTIO_NET_CTRL_NOTF_COAL_LOW_TX_SET: set the \field{usecs} and \field{max_packets} coalescing parameters for packet rate of \field{pkt_rate} or lower, for TX.
> > +\item VIRTIO_NET_CTRL_NOTF_COAL_LOW_RX_SET: set the \field{usecs} and \field{max_packets} coalescing parameters for packet rate of \field{pkt_rate} or lower, for RX.
> > +\item VIRTIO_NET_CTRL_NOTF_COAL_HIGH_TX_SET: set the \field{usecs} and \field{max_packets} coalescing parameters for packet rate of \field{pkt_rate} or higher, for TX.
> > +\item VIRTIO_NET_CTRL_NOTF_COAL_HIGH_RX_SET: set the \field{usecs} and \field{max_packets} coalescing parameters for packet rate of \field{pkt_rate} or higher, for RX.
>
>
> how is

I think that you missed a sentence here.

>
> What is missing here is the theory of operation.
>
> when are parameters set by VIRTIO_NET_CTRL_NOTF_COAL_RX_SET/VIRTIO_NET_CTRL_NOTF_COAL_TX_SET
> used?
>
> Am I guessing right that with VIRTIO_NET_F_NOTF_COAL_LOW_HIGH there
> are 3 sets of parameters high medium and low, for rx and tx?
>

Yes, we have the low and high sets, and the normal one
(VIRTIO_NET_CTRL_NOTF_COAL_RX_SET/VIRTIO_NET_CTRL_NOTF_COAL_TX_SET)
that should be used when the packet rate is not higher than the high
threshold (if any), and not lower than the low threshold (if any).

I'll explain it in the next version.

I removed the "set" concept after v1 following your suggestion.
Maybe we should define the concept and use it in the spec after all?

> > +For example, \field{max_packets} = 15 for TX.
> > +
>
> drop empty line here pls.

ok

> > +If the VIRTIO_NET_F_NOTF_COAL_LOW_HIGH feature is negotiated, the driver can send the following low/high rate coalescing commands to the device:
> > +
> > +\begin{itemize}
> > +\item VIRTIO_NET_CTRL_NOTF_COAL_LOW_TX_SET.
> > +\item VIRTIO_NET_CTRL_NOTF_COAL_LOW_RX_SET.
> > +\item VIRTIO_NET_CTRL_NOTF_COAL_HIGH_TX_SET.
> > +\item VIRTIO_NET_CTRL_NOTF_COAL_HIGH_RX_SET.
> > +\end{itemize}
> > +
>
> pls explain here how these commands all use
> virtio_net_ctrl_coal_threshold.
> and maybe rearrange so the explanation is closer to the definition.

This is explained in the following part:
-The class VIRTIO_NET_CTRL_NOTF_COAL has 2 commands:
+The class VIRTIO_NET_CTRL_NOTF_COAL has 6 commands:
 \begin{enumerate}
-\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{tx_usecs} and
\field{tx_max_packets} parameters.
-\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{rx_usecs} and
\field{rx_max_packets} parameters.
+\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{usecs} and
\field{max_packets} coalescing parameters for TX.
+\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{usecs} and
\field{max_packets} coalescing parameters for RX.
+\item VIRTIO_NET_CTRL_NOTF_COAL_LOW_TX_SET: set the \field{usecs} and
\field{max_packets} coalescing parameters for packet rate of
\field{pkt_rate} or lower, for TX.
+\item VIRTIO_NET_CTRL_NOTF_COAL_LOW_RX_SET: set the \field{usecs} and
\field{max_packets} coalescing parameters for packet rate of
\field{pkt_rate} or lower, for RX.
+\item VIRTIO_NET_CTRL_NOTF_COAL_HIGH_TX_SET: set the \field{usecs}
and \field{max_packets} coalescing parameters for packet rate of
\field{pkt_rate} or higher, for TX.
+\item VIRTIO_NET_CTRL_NOTF_COAL_HIGH_RX_SET: set the \field{usecs}
and \field{max_packets} coalescing parameters for packet rate of
\field{pkt_rate} or higher, for RX.

I'll move it closer to the definition.

> > +If the VIRTIO_NET_F_NOTF_COAL_LOW_HIGH feature has not been negotiated, the driver MUST NOT issue low/high rate coalescing commands.
> > +
> > +The driver SHOULD issue a low/high rate coalescing command with \field{pkt_rate} 0 in order to remove the low/high rate coalescing parameters.
>
> and presumably this 0 is an exception to the "packet rate for high
> threshold must not be lower than low threshold"?

Yes, I'll add the exception.

> > +The driver MUST NOT issue a VIRTIO_NET_CTRL_NOTF_COAL_LOW_TX_SET command with \field{pkt_rate} equal or higher than a \field{pkt_rate} previously sent with a VIRTIO_NET_CTRL_NOTF_COAL_HIGH_TX_SET command.
> > +
> > +The driver MUST NOT issue a VIRTIO_NET_CTRL_NOTF_COAL_LOW_RX_SET command with \field{pkt_rate} equal or higher than a \field{pkt_rate} previously sent with a VIRTIO_NET_CTRL_NOTF_COAL_HIGH_RX_SET command.
> > +
> > +The driver MUST NOT issue a VIRTIO_NET_CTRL_NOTF_COAL_HIGH_TX_SET command with \field{pkt_rate} equal or lower than a \field{pkt_rate} previously sent with a VIRTIO_NET_CTRL_NOTF_COAL_LOW_TX_SET command.
> > +
> > +The driver MUST NOT issue a VIRTIO_NET_CTRL_NOTF_COAL_HIGH_RX_SET command with \field{pkt_rate} equal or lower than a \field{pkt_rate} previously sent with a VIRTIO_NET_CTRL_NOTF_COAL_LOW_RX_SET command.
> > +
>
> actually these rules are annoying.
> if i want to lower packet rate for both high and low,
> and i happen to start with high, command may fail.
> possible to fix but really just introducing more code for
> now good reason.
> what is the problem? if the rules make more than one set apply
> let's allow device whatever set it wants?

You're right, I'll drop these rules.

Thanks,

Alvaro

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

