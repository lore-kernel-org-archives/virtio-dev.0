Return-Path: <virtio-comment-return-3683-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
MIME-Version: 1.0
References: <20221221101729.648097-1-alvaro.karsz@solid-run.com> <20230104095454-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230104095454-mutt-send-email-mst@kernel.org>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Wed, 4 Jan 2023 20:40:19 +0200
Message-ID: <CAJs=3_D9ZmUxCpjMfKNSYdE5k65yPRF2Oq7x77w8qM-h8KdZbw@mail.gmail.com>
Subject: [virtio-comment] Re: [PATCH] virtio_net: support low and high rate of notification
 coalescing sets
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

Thanks for your comments.

> On Wed, Dec 21, 2022 at 12:17:29PM +0200, Alvaro Karsz wrote:
> > This patch adds a new feature VIRTIO_NET_F_NOTF_COAL_LOW_HIGH,
> > and adds 2 new commands to VIRTIO_NET_CTRL_NOTF_COAL class:
> >       * VIRTIO_NET_CTRL_NOTF_COAL_LOW_SET - create a low-rate set of
> >         coalescing parameters. the device should switch to this set whe=
n
> >         the packet rate (packets per second) reaches the pkt_rate_low t=
hreshold.
> >
> >       * VIRTIO_NET_CTRL_NOTF_COAL_HIGH_SET - create a high-rate set of
> >           coalescing parameters. the device should switch to this set w=
hen
> >           the packet rate (packets per second) reaches the pkt_rate_hig=
h threshold.
> >
> > A device may have up to 3 sets, and should switch between them based on
> > the packet rate.
> >
> > Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
>
> there seems to be a concept of a "set of coalescing parameters".
> if we use it we'll have to define it, I don't think it's a standard
> thing. I personally don't think we should bother, we currently
> talk about "coalescing parameters".

ok, I'll replace the set concept with "coalescing parameters".

> I propose unifying virtio_net_ctrl_coal_rx and virtio_net_ctrl_coal_tx
> since they are the same anyway. Then reuse.

Sure, but since both structs are already defined in the spec,
shouldn't we fix it in a separate patch?
Do you want me to propose a new patch that unifies the structs?

> > ---
> >  content.tex | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 60 insertions(+), 1 deletion(-)
> >
> > diff --git a/content.tex b/content.tex
> > index 96f4723..969f945 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -3088,6 +3088,8 @@ \subsection{Feature bits}\label{sec:Device Types =
/ Network Device / Feature bits
> >  \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
> >      channel.
> >
> > +\item[VIRTIO_NET_F_NOTF_COAL_LOW_HIGH(50)] Device supports notificatio=
ns coalescing low rate and high rate sets.
> > +
> >  \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coales=
cing.
> >
> >  \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packets.
> > @@ -3142,6 +3144,7 @@ \subsubsection{Feature bit requirements}\label{se=
c:Device Types / Network Device
> >  \item[VIRTIO_NET_F_MQ] Requires VIRTIO_NET_F_CTRL_VQ.
> >  \item[VIRTIO_NET_F_CTRL_MAC_ADDR] Requires VIRTIO_NET_F_CTRL_VQ.
> >  \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
> > +\item[VIRTIO_NET_F_NOTF_COAL_LOW_HIGH] Requires VIRTIO_NET_F_NOTF_COAL=
.
> >  \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_=
NET_F_HOST_TSO6.
> >  \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
> >  \end{description}
> > @@ -4504,9 +4507,25 @@ \subsubsection{Control Virtqueue}\label{sec:Devi=
ce Types / Network Device / Devi
> >      le32 tx_usecs;
> >  };
> >
> > +//Only if VIRTIO_NET_F_NOTF_COAL_LOW_HIGH negotiated
>
> space after // pls. It's also unclear to put this comment
> before struct. a struct is just a struct, a comment such as this
> can only refer to fields in structs.

ok, I'll drop the comment from its current place

> > +struct virtio_net_ctrl_coal_low {
> > +        le32 pkt_rate_low;
> > +        struct virtio_net_ctrl_coal_tx tx;
> > +        struct virtio_net_ctrl_coal_rx rx;
> > +};
>
> is it really true we always want the same rate for tx and rx?
> why not separate commands for each? this is the way we went
> for general coalescing at least.

I actually had ethtool in mind while writing the patch.
AFAIK ethtool has a single rate for both rx and tx low/high, so using
ethtool to manage the parameters won't be possible.

I know that we should worry about that when trying to implement the
feature and not while proposing it to the spec, but I think that we
will benefit the most from this feature if it can be used with an
existing, well known tool such as ethtool.

What do you think?

> > +
> > +//Only if VIRTIO_NET_F_NOTF_COAL_LOW_HIGH negotiated
> > +struct virtio_net_ctrl_coal_high {
> > +        le32 pkt_rate_high;
> > +        struct virtio_net_ctrl_coal_tx tx;
> > +        struct virtio_net_ctrl_coal_rx rx;
> > +};
> > +
>
> given these are identical, do we want to unify these?
> maybe virtio_net_ctrl_coal_threshold ?

ok.

> >  #define VIRTIO_NET_CTRL_NOTF_COAL 6
> >   #define VIRTIO_NET_CTRL_NOTF_COAL_TX_SET  0
> >   #define VIRTIO_NET_CTRL_NOTF_COAL_RX_SET 1
> > + #define VIRTIO_NET_CTRL_NOTF_COAL_LOW_SET 2 //Only if VIRTIO_NET_F_NO=
TF_COAL_LOW_HIGH negotiated
> > + #define VIRTIO_NET_CTRL_NOTF_COAL_HIGH_SET 3 //Only if VIRTIO_NET_F_N=
OTF_COAL_LOW_HIGH negotiated
> >  \end{lstlisting}
> >
> >  Coalescing parameters:
> > @@ -4515,13 +4534,17 @@ \subsubsection{Control Virtqueue}\label{sec:Dev=
ice Types / Network Device / Devi
> >  \item \field{tx_usecs}: Maximum number of usecs to delay a TX notifica=
tion.
> >  \item \field{rx_max_packets}: Maximum number of packets to receive bef=
ore a RX notification.
> >  \item \field{tx_max_packets}: Maximum number of packets to send before=
 a TX notification.
> > +\item \field{pkt_rate_low}: Threshold for low packet rate set (packets=
 per second).
>
> what does "set" mean here?

I'll replace it with" coalescing parameters", as suggested in your
first comment.

> and I'd take (packets per second) out of ():
>         low packet rate, in units of packets per second.

ok.

> > +\item \field{pkt_rate_high}: Threshold for high packet rate set (packe=
ts per second).
> >  \end{itemize}
> >
> >
> > -The class VIRTIO_NET_CTRL_NOTF_COAL has 2 commands:
> > +The class VIRTIO_NET_CTRL_NOTF_COAL has 4 commands:
> >  \begin{enumerate}
> >  \item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{tx_usecs} and \=
field{tx_max_packets} parameters.
> >  \item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{rx_usecs} and \=
field{rx_max_packets} parameters.
> > +\item VIRTIO_NET_CTRL_NOTF_COAL_LOW_SET: set the \field{rx_usecs}, \fi=
eld{rx_max_packets}, \field{tx_usecs} and \field{tx_max_packets} set for a =
rate of \field{pkt_rate_low} or less packets per second.
>
> set repeated twice here. confusing to the point where I couldn't figure o=
ut the meaning exactly.
>  for a rate of \field{pkt_rate_low} or less packets per second
> do you mean
>  when packet rate is \field{pkt_rate_low} or less?

Yes, I'll fix the wording and replace the second "set" with
"coalescing parameters".

> > +\item VIRTIO_NET_CTRL_NOTF_COAL_HIGH_SET: set the \field{rx_usecs}, \f=
ield{rx_max_packets}, \field{tx_usecs} and \field{tx_max_packets} set for a=
 rate of \field{pkt_rate_high} or more packets per second.
> >  \end{enumerate}
> >
> >  \subparagraph{RX Notifications}\label{sec:Device Types / Network Devic=
e / Device Operation / Control Virtqueue / Notifications Coalescing / RX No=
tifications}
> > @@ -4554,18 +4577,54 @@ \subsubsection{Control Virtqueue}\label{sec:Dev=
ice Types / Network Device / Devi
> >  \item If the notifications are not suppressed by the driver, the devic=
e will send an used buffer notification, otherwise, the device will not sen=
d an used buffer notification as long as the notifications are suppressed.
> >  \end{itemize}
> >
> > +\subparagraph{Low/High Rate Notifications Sets}\label{sec:Device Types=
 / Network Device / Device Operation / Control Virtqueue / Notifications Co=
alescing / Low/High Rate Notifications Sets}
> > +
> > +If the VIRTIO_NET_F_NOTF_COAL_LOW_HIGH feature is negotiated, the driv=
er may send VIRTIO_NET_CTRL_NOTF_COAL_LOW_SET/VIRTIO_NET_CTRL_NOTF_COAL_HIG=
H_SET commands to the device.
> > +
> > +The virtio_net_ctrl_coal_low struct defines a set of coalescing parame=
ters (\field{rx_usecs}, \field{tx_usecs}, \field{rx_max_packets} and \field=
{tx_max_packets}) that should be used when the packets rate is equal or low=
er than \field{pkt_rate_low} packets per second.
>
> packets rate -> packet rate
> here and elsewhere

ok.

> > +
> > +The virtio_net_ctrl_coal_high struct defines a set of coalescing param=
eters (\field{rx_usecs}, \field{tx_usecs}, \field{rx_max_packets} and \fiel=
d{tx_max_packets}) that should be used when the packets rate is equal or hi=
gher than \field{pkt_rate_high} packets per second.
>
> equal to or higher than

ok.

> > +
> > +A device may have up to 3 sets of coalescing parameters, and should sw=
itch between the sets based on the packet rate.
>
> what are the 3 sets?

The high set, the low set and the normal set, I'll add it to the sentence.

> avoid "may" outside conformance sections please.

ok.

> > +A device may have only a low rate set, in this case, it should coalesc=
e notifications only when the packet rate crosses down the \field{pkt_rate_=
low} threshold.
> > +
> > +A device may have only a high rate set, in this case, it should coales=
ce notifications only when the packet rate crosses up the \field{pkt_rate_h=
igh} threshold.
> > +
> > +A device may have only a high rate set and a low rate set, in this cas=
e, it should coalesce notifications only when the packet rate crosses up th=
e \field{pkt_rate_high} threshold, or crosses down the \field{pkt_rate_low}=
 threshold.
>
> in this case it's not both.

Do you mean that I should replace "A device may have only a high rate
set and a low rate set" with "A device may have both a high rate set
and a low rate set"?
I wanted to emphasize that it may have a low set and a high set,
without a normal set, this is why I wrote "only", but I can fix the
wording.

> > +
> >  \drivernormative{\subparagraph}{Notifications Coalescing}{Device Types=
 / Network Device / Device Operation / Control Virtqueue / Notifications Co=
alescing}
> >
> >  If the VIRTIO_NET_F_NOTF_COAL feature has not been negotiated, the dri=
ver MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.
> >
> > +If the VIRTIO_NET_F_NOTF_COAL_LOW_HIGH feature has not been negotiated=
, the driver MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL_LOW_SET/VIRTIO_NET_CT=
RL_NOTF_COAL_HIGH_SET commands.
> > +
> > +The driver SHOULD issue a VIRTIO_NET_CTRL_NOTF_COAL_LOW_SET command wi=
th \field{pkt_rate_low} 0 in order to remove the low rate set.
> > +
> > +The driver SHOULD issue a VIRTIO_NET_CTRL_NOTF_COAL_HIGH_SET command w=
ith \field{pkt_rate_high} 0 in order to remove the high rate set.
> > +
> > +The driver MUST NOT issue a VIRTIO_NET_CTRL_NOTF_COAL_LOW_SET command =
with \field{pkt_rate_low} equal or higher than \field{pkt_rate_high}, if VI=
RTIO_NET_CTRL_NOTF_COAL_HIGH_SET was issued.
> > +
> > +The driver MUST NOT issue a VIRTIO_NET_CTRL_NOTF_COAL_HIGH_SET command=
 with \field{pkt_rate_high} equal or lower than \field{pkt_rate_low}, if VI=
RTIO_NET_CTRL_NOTF_COAL_LOW_SET was issued.
> > +
> >  \devicenormative{\subparagraph}{Notifications Coalescing}{Device Types=
 / Network Device / Device Operation / Control Virtqueue / Notifications Co=
alescing}
> >
> >  A device SHOULD respond to the VIRTIO_NET_CTRL_NOTF_COAL commands with=
 VIRTIO_NET_ERR if it was not able to change the parameters.
> >
> >  A device SHOULD NOT send used buffer notifications to the driver, if t=
he notifications are suppressed as explained in \ref{sec:Basic Facilities o=
f a Virtio Device / Virtqueues / Used Buffer Notification Suppression}, eve=
n if the coalescing counters expired.
> >
> > +The device MUST remove the low rate set if a VIRTIO_NET_CTRL_NOTF_COAL=
_LOW_SET command with \field{pkt_rate_low} 0 is received.
> > +
> > +The device MUST remove the high rate set if a VIRTIO_NET_CTRL_NOTF_COA=
L_HIGH_SET command with \field{pkt_rate_high} 0 is received.
> > +
> > +The device MUST respond with VIRTIO_NET_ERR to a VIRTIO_NET_CTRL_NOTF_=
COAL_LOW_SET command with \field{pkt_rate_low} equal or higher than \field{=
pkt_rate_high}, if a high rate set is being used.
> > +
> > +The device MUST respond with VIRTIO_NET_ERR to a VIRTIO_NET_CTRL_NOTF_=
COAL_HIGH_SET command with \field{pkt_rate_high} equal or lower than \field=
{pkt_rate_low}, if a low rate set is being used.
> > +
> >  Upon reset, a device MUST initialize all coalescing parameters to 0.
> >
> > +Upon reset, a device MUST not have a low rate and high rate sets.
> > +
>
>
> how about documenting how the coalescing is used.
> E.g. is it best effort or mandatory?

ok, I can add a line stating that this is a best effort feature.

> I also noticed that coalescing is currently under-specified with
> respect to delivering interrupts when config changes.
> For example, what happens if I get 1 packet then lower max packets to 1?
> Do I get an interrupt immediately or does the counter get reset?

I think that the device should check the counters when coalescing
parameters change, and should deliver an interrupt if needed.
But since this affects an existing feature, shouldn't it be fixed in a
separate patch?

> >  \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Devic=
e
> >  Types / Network Device / Legacy Interface: Framing Requirements}
> >
> > --
> > 2.32.0
>

Alvaro

This publicly archived list offers a means to provide input to the=0D
OASIS Virtual I/O Device (VIRTIO) TC.=0D
=0D
In order to verify user consent to the Feedback License terms and=0D
to minimize spam in the list archive, subscription is required=0D
before posting.=0D
=0D
Subscribe: virtio-comment-subscribe@lists.oasis-open.org=0D
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org=0D
List help: virtio-comment-help@lists.oasis-open.org=0D
List archive: https://lists.oasis-open.org/archives/virtio-comment/=0D
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf=
=0D
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts=0D
Committee: https://www.oasis-open.org/committees/virtio/=0D
Join OASIS: https://www.oasis-open.org/join/

