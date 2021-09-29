Return-Path: <virtio-dev-return-8742-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2F3C298648E
	for <virtio-dev@lists.oasis-open.org>; Wed, 29 Sep 2021 03:25:06 +0000 (UTC)
MIME-Version: 1.0
References: <CACGkMEsYmkA5-HuquoL0=Av7=SWyBaLj226sLE5dtYcpL1Vf-w@mail.gmail.com>
 <1632885123.262246-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1632885123.262246-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 29 Sep 2021 11:24:50 +0800
Message-ID: <CACGkMEsS4Mjm8F53Esx4Fw1-moL-h-kFPW+TU=VNrGRONJdL4Q@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v3] virtio-net: support device stats
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Sep 29, 2021 at 11:14 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wro=
te:
>
> On Wed, 29 Sep 2021 11:07:21 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Wed, Sep 29, 2021 at 10:34 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com>=
 wrote:
> > >
> > > On Wed, 29 Sep 2021 10:07:52 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Tue, Sep 28, 2021 at 11:48 AM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
> > > > >
> > > > > On Tue, 28 Sep 2021 11:25:40 +0800, Jason Wang <jasowang@redhat.c=
om> wrote:
> > > > > > On Mon, Sep 27, 2021 at 2:54 PM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > > > > > >
> > > > > > > On Mon, 27 Sep 2021 11:50:35 +0800, Jason Wang <jasowang@redh=
at.com> wrote:
> > > > > > > > On Thu, Sep 16, 2021 at 5:33 PM Xuan Zhuo <xuanzhuo@linux.a=
libaba.com> wrote:
> > > > > > > > >
> > > > > > > > > This patch allows the driver to obtain some statistics fr=
om the device.
> > > > > > > > >
> > > > > > > > > In the back-end implementation, we can count a lot of suc=
h information,
> > > > > > > > > which can be used for debugging and judging the running s=
tatus of the
> > > > > > > > > back-end. We hope to directly display it to the user thro=
ugh ethtool.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > > > ---
> > > > > > > > >
> > > > > > > > > v3 changes:
> > > > > > > > > 1. add dev_version
> > > > > > > > > 2. use queue_pair_index replace rx_num, tx_num
> > > > > > > > > 3. Explain the processing when the device and driver supp=
ort different numbers
> > > > > > > > > of stats
> > > > > > > > >
> > > > > > > > >  content.tex | 115 ++++++++++++++++++++++++++++++++++++++=
++++++++++++++
> > > > > > > > >  1 file changed, 115 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/content.tex b/content.tex
> > > > > > > > > index 7cec1c3..2e45a55 100644
> > > > > > > > > --- a/content.tex
> > > > > > > > > +++ b/content.tex
> > > > > > > > > @@ -2972,6 +2972,9 @@ \subsection{Feature bits}\label{sec=
:Device Types / Network Device / Feature bits
> > > > > > > > >  \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address th=
rough control
> > > > > > > > >      channel.
> > > > > > > > >
> > > > > > > > > +\item[VIRTIO_NET_F_CTRL_STATS(55)] Device can provide de=
vice-level statistics
> > > > > > > > > +    to the driver through the control channel.
> > > > > > > > > +
> > > > > > > > >  \item[VIRTIO_NET_F_HOST_USO (56)] Device can receive USO=
 packets. Unlike UFO
> > > > > > > > >   (fragmenting the packet) the USO splits large UDP packe=
t
> > > > > > > > >   to several segments when each of these smaller packets =
has UDP header.
> > > > > > > > > @@ -3017,6 +3020,7 @@ \subsubsection{Feature bit requirem=
ents}\label{sec:Device Types / Network Device
> > > > > > > > >  \item[VIRTIO_NET_F_GUEST_ANNOUNCE] Requires VIRTIO_NET_F=
_CTRL_VQ.
> > > > > > > > >  \item[VIRTIO_NET_F_MQ] Requires VIRTIO_NET_F_CTRL_VQ.
> > > > > > > > >  \item[VIRTIO_NET_F_CTRL_MAC_ADDR] Requires VIRTIO_NET_F_=
CTRL_VQ.
> > > > > > > > > +\item[VIRTIO_NET_F_CTRL_STATS] Requires VIRTIO_NET_F_CTR=
L_VQ.
> > > > > > > > >  \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_T=
SO4 or VIRTIO_NET_F_HOST_TSO6.
> > > > > > > > >  \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
> > > > > > > > >  \end{description}
> > > > > > > > > @@ -3895,6 +3899,7 @@ \subsubsection{Control Virtqueue}\l=
abel{sec:Device Types / Network Device / Devi
> > > > > > > > >          u8 command;
> > > > > > > > >          u8 command-specific-data[];
> > > > > > > > >          u8 ack;
> > > > > > > > > +        u8 command-specific-data-reply[];
> > > > > > > > >  };
> > > > > > > > >
> > > > > > > > >  /* ack values */
> > > > > > > > > @@ -3906,6 +3911,9 @@ \subsubsection{Control Virtqueue}\l=
abel{sec:Device Types / Network Device / Devi
> > > > > > > > >  driver, and the device sets the \field{ack} byte. There =
is little it can
> > > > > > > > >  do except issue a diagnostic if \field{ack} is not
> > > > > > > > >  VIRTIO_NET_OK.
> > > > > > > > > +\field{command-specific-data-reply} is alloced by driver=
, then pass to device.
> > > > > > > > > +It is filled by the device. It is optional. Some command=
s need to get some
> > > > > > > > > +information from the device.
> > > > > > > >
> > > > > > > > Let's just reuse the "sets" as above.
> > > > > > > >
> > > > > > > > E.g "and the device set the \field{ack} and optionally
> > > > > > > > \field{command-specific-data-reply}"
> > > > > > >
> > > > > > > OK.
> > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > >  \paragraph{Packet Receive Filtering}\label{sec:Device Ty=
pes / Network Device / Device Operation / Control Virtqueue / Packet Receiv=
e Filtering}
> > > > > > > > >  \label{sec:Device Types / Network Device / Device Operat=
ion / Control Virtqueue / Setting Promiscuous Mode}%old label for latexdiff
> > > > > > > > > @@ -4384,6 +4392,113 @@ \subsubsection{Legacy Interface: =
Framing Requirements}\label{sec:Device
> > > > > > > > >  See \ref{sec:Basic
> > > > > > > > >  Facilities of a Virtio Device / Virtqueues / Message Fra=
ming}.
> > > > > > > > >
> > > > > > > > > +\paragraph{Device stats}\label{sec:Device Types / Networ=
k Device / Device Operation / Control Virtqueue / Device stats}
> > > > > > > > > +
> > > > > > > > > +If the VIRTIO_NET_F_CTRL_STATS feature is negotiated, th=
e driver can
> > > > > > > > > +get device stats from the device by \field{command-speci=
fic-data-reply}.
> > > > > > > > > +
> > > > > > > > > +\subparagraph{Device stats keys}\label{sec:Device Types =
/ Network Device / Device Operation / Control Virtqueue / Device stats keys=
 / Device stats keys}
> > > > > > > > > +
> > > > > > > > > +The keys of the device stats are defined as follows. Whe=
n the device fills in
> > > > > > > > > +\field{command-specific-data-reply}, it MUST be written =
in the following order.
> > > > > > > > > +Subsequent newly added keys MUST be added at the end of =
each category.
> > > > > > > > > +These keys will eventually be shown to the user.
> > > > > > > > > +
> > > > > > > > > +All stats are divided into three categories:
> > > > > > > > > +
> > > > > > > > > +\begin{itemize}
> > > > > > > > > +    \item dev stats: the stats of the device
> > > > > > > > > +        \begin{itemize}
> > > > > > > > > +            \item dev_version: The number of device vers=
ion.
> > > > > > > > > +            \item dev_reset: The number of device reset.
> > > > > > > > > +        \end{itemize}
> > > > > > > > > +
> > > > > > > > > +    \item rx stats: the stats of the rx queue
> > > > > > > > > +        \begin{itemize}
> > > > > > > > > +            \item rx[N]_inter: The number of interrupts =
sent by the rx queue.
> > > > > > > > > +            \item rx[N]_drop: The number of packets drop=
ped by the rx queue. Contains all kinds of packet loss.
> > > > > > > > > +            \item rx[N]_drop_overruns: The number of pac=
kets dropped by the rx queue when no more avail desc.
> > > > > > > > > +            \item rx[N]_csum_bad: The number of packets =
with abnormal csum in the rx queue.
> > > > > > > > > +            \item rx[N]_gso_packets: The number of gso p=
ackets received by rx.
> > > > > > > > > +            \item rx[N]_gso_bytes: The number of gso byt=
es received by rx.
> > > > > > > > > +            \item rx[N]_oversize_pkts: The number of ove=
rsized packets received by the rx queue.
> > > > > > > > > +        \end{itemize}
> > > > > > > > > +
> > > > > > > > > +    \item tx stats: the stats of the tx queue
> > > > > > > > > +        \begin{itemize}
> > > > > > > > > +            \item tx[N]_inter: The number of interrupts =
sent by the tx queue.
> > > > > > > > > +            \item tx[N]_drop: The number of packets drop=
ped by the tx queue. Contains all kinds of packet loss.
> > > > > > > > > +            \item tx[N]_csum: The number of packets that=
 completes csum by the device.
> > > > > > > > > +            \item tx[N]_gso_packets: The number of gso p=
ackets transmitted.
> > > > > > > > > +            \item tx[N]_gso_bytes: The number of gso byt=
es transmitted.
> > > > > > > > > +        \end{itemize}
> > > > > > > > > +\end{itemize}
> > > > > > > >
> > > > > > > > Let's use C stcture for this.
> > > > > > >
> > > > > > > The main purpose here is to define the order of these keys.
> > > > > > >
> > > > > > > This issue will be discussed below.
> > > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > > +
> > > > > > > > > +\subparagraph{Device stats get}\label{sec:Device Types /=
 Network Device / Device Operation / Control Virtqueue / Device stats keys =
/ Device stats get}
> > > > > > > > > +
> > > > > > > > > +To get the stats, the following definitions are used:
> > > > > > > > > +\begin{lstlisting}
> > > > > > > > > +#define VIRTIO_NET_CTRL_STATS        6
> > > > > > > > > +#define VIRTIO_NET_CTRL_STATS_GET    0
> > > > > > > > > +\end{lstlisting}
> > > > > > > > > +
> > > > > > > > > +The following layout structure are used:
> > > > > > > > > +
> > > > > > > > > +\field{command-specific-data}
> > > > > > > > > +\begin{lstlisting}
> > > > > > > > > +le64 queue_pair_index
> > > > > > > > > +le64 dev_stats_num;
> > > > > > > > > +le64 rx_stats_num;
> > > > > > > > > +le64 tx_stats_num;
> > > > > > > > > +\end{lstlisting}
> > > > > > > > > +
> > > > > > > > > +\field{command-specific-data-reply}
> > > > > > > > > +\begin{lstlisting}
> > > > > > > > > +le64 queue_pair_index
> > > > > > > > > +le64 dev_stats_num;
> > > > > > > > > +le64 rx_stats_num;
> > > > > > > > > +le64 tx_stats_num;
> > > > > > > > > +le64 dev_stats[dev_stats_num];
> > > > > > > > > +le64 rx_stats[rx_stats_num];
> > > > > > > > > +le64 tx_stats[tx_stats_num];
> > > > > > > > > +\end{lstlisting}
> > > > > > > > > +
> > > > > > > > > +The command VIRTIO_NET_CTRL_STATS_GET is used to obtain =
this information.
> > > > > > > > > +
> > > > > > > > > +Regarding the variables in \field{command-specific-data}=
:
> > > > > > > > > +\begin{itemize}
> > > > > > > > > +    \item \field{queue_pair_index}: Specify the queue pa=
ir index of the queue that the driver wants to get stats.
> > > > > > > > > +    \item \field{dev_stats_num}: Indicates the number of=
 dev stats supported by the driver.
> > > > > > > > > +    \item \field{rx_stats_num}: Indicates the number of =
stats information the driver wants for rx queue.
> > > > > > > > > +    \item \field{tx_stats_num}: Indicates the number of =
stats information the driver wants for tx queue.
> > > > > > > >
> > > > > > > > We have feature negotiation mechanism, so I think we don't =
need
> > > > > > > > dev_stats_num, {rx|tx}_stats_num here. Instead, all of thos=
e should be
> > > > > > > > inferred from the features.
> > > > > > >
> > > > > > > The feature just indicates that the driver can obtain status =
information from
> > > > > > > the device. But with the development, it is difficult for the=
 device and the
> > > > > > > driver to support the new key synchronously. The feature is a=
lso difficult to
> > > > > > > sense how many new keys the driver and the device support res=
pectively.
> > > > > >
> > > > > > So I think the feature works fine for this.
> > > > > >
> > > > > > VIRTIO_NET_F_CTRL_STATS -> stats set A
> > > > > > VIRTIO_NET_F_CTRL_STATS_X -> stats set A + stats set X
> > > > > > ...
> > > > > >
> > > > > > The point is to unbreak the migration. We don't want to surpris=
e the
> > > > > > user if some of the keys were added or deleted after migration.
> > > > >
> > > > > Your ideas inspired me, but I think adding features is not a good=
 way. Because I
> > > > > feel that after the dev is initialized, we can negotiate with the=
 device based
> > > > > on CTRL_VQ.
> > > > >
> > > > > For example, the driver supports two versions of stats
> > > > >
> > > > > A: two keys
> > > > > B: three keys
> > > > >
> > > > > And the device just supports version A.
> > > > >
> > > > > The driver can pass the two information of A and B to the device =
based on
> > > > > CTRL_VQ, and the device returns a supported version name.
> > > >
> > > > I'm not sure I can get you here. Does this mean it supports migrati=
on
> > > > A from B? If yes, it breaks userspace. If not, how do we know we ca=
n't
> > > > do the migration?
> > >
> > > NO
> > >
> > > >
> > > > As mentioned, the better way is to increase the sets and make e.g
> > > > CTRL_STATS_X depend on CTRL_STATS which depend on CTRL_VQ.
> > >
> > > My idea is similar to yours, but I think adding a new VIRTIO_NET_F_CT=
RL_STATS_X
> > > is a bit too wasteful.
> > >
> > > Assuming that these sets have been defined in the spec
> > >
> > > A -> stats set A
> > > B -> stats set A + stats set B
> > > C -> stats set A + stats set B + stats set C
> > > ....
> > >
> > > We only need to tell the device based on CTRL_VQ which set we support=
, such as
> > > B. The device returns which set it supports. This will complete the n=
egotiation.
> > >
> > > driver   device
> > > A         C           =3D> A
> > > C         C           =3D> C

[1]

> > > C         B           =3D> B

[2]

> >
> > So how do we know we can't migrate device(B) to device(C)?
>
> Aren=E2=80=99t we discussing the driver and the device to negotiate which=
 set of stats
> everyone will ultimately use? What do you mean by migration?

Feature bit is a facility for preserving migration compatibility.
Consider if we want to migrate from device[1] to device[2]. Drivers
may see different stats sets which breaks userspace application and
migration.

Thanks

>
> Thanks.
>
> >
> > Thanks
> >
> > >
> > > My idea is to no longer waste a feature bit, but to complete the nego=
tiation
> > > based on CTRL_VQ.
> > >
> > > Hope I made it clear. ^_^.
> > >
> > > Thanks.
> > >
> > >
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > > In addition, do you think we need to define this content now, or =
should we
> > > > > define this one when there is a new version of stats in the futur=
e?
> > > > >
> > > > > >
> > > > > > >
> > > > > > > For example, there are currently only two dev_stats, and both=
 the device and the
> > > > > > > driver only support two keys. If the virtio spec adds a new d=
ev stats, the
> > > > > > > driver may first support three keys, but the device still sup=
ports only two. The
> > > > > > > number of keys supported by both parties is needed to negotia=
te.
> > > > > >
> > > > > > So let's say VIRTIO_NET_F_CTRL_STATS (two keys) but
> > > > > > VIRTIO_NET_F_CTRL_STATS_X has three keys.
> > > > > > In this case if VIRTIO_NET_F_CTRL_STATS_X is not supported by t=
he
> > > > > > device (only two keys), it won't be negotiated and the driver k=
nows
> > > > > > the device will only return 2 keys.
> > > > > >
> > > > > > >
> > > > > > > dev_stats_num, (rx|tx)_stats_num exists for this purpose.
> > > > > > >
> > > > > > > I think the increase of these keys is a relatively frequent t=
hing.
> > > > > >
> > > > > > Probably not, looking at other NIC drivers the "keys" are prett=
y
> > > > > > stable. We can start from a large set anyhow.
> > > > >
> > > > > OK.
> > > > >
> > > > > Thanks.
> > > > >
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > > > It is also
> > > > > > > difficult to synchronize the support for new keys between dri=
vers and devices.
> > > > > > >
> > > > > > > Thanks.
> > > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > Thanks
> > > > > > > >
> > > > > > > > > +\end{itemize}
> > > > > > > > > +
> > > > > > > > > +Regarding the variables in \field{command-specific-data-=
reply}:
> > > > > > > > > +\begin{itemize}
> > > > > > > > > +    \item All variables of \field{command-specific-data-=
reply} are set by the device.
> > > > > > > > > +    \item \field{queue_pair_index} MUST be equal to the =
variable with the same name in \field{command-specific-data}.
> > > > > > > > > +    \item These variables(\field{dev_stats_num}, \field{=
rx_stats_num}, \field{tx_stats_num}) MUST be
> > > > > > > > > +            less than or equal to the variables with the=
 same name in \field{command-specific-data}.
> > > > > > > > > +            These values indicate the amount of stats ac=
tually filled in.
> > > > > > > > > +    \item \field{command-specific-data-reply} is meaning=
ful only when \field{ack} is equal to VIRTIO_NET_OK.
> > > > > > > > > +\end{itemize}
> > > > > > > > > +
> > > > > > > > > +The variables \field{dev_stats_num}, \field{rx_stats_num=
}, \field{tx_stats_num} in \field{command-specific-data}
> > > > > > > > > +specify which stats the driver wants to get, but in fact=
 the device may support
> > > > > > > > > +more or fewer stats.
> > > > > > > > > +
> > > > > > > > > +If the actual number of stats supported by the device is=
 equal to or less than
> > > > > > > > > +the number that the driver wants to obtain, then the dev=
ice MUST write all the
> > > > > > > > > +stats to the corresponding position of \field{command-sp=
ecific-data-reply}.
> > > > > > > > > +
> > > > > > > > > +And if the number of stats actually supported by the dev=
ice is more than the
> > > > > > > > > +driver requires, then the device MUST only write the num=
ber supported by the
> > > > > > > > > +driver.
> > > > > > > > > +
> > > > > > > > > +If the some of the variables \field{dev_stats_num}, \fie=
ld{rx_stats_num}, \field{tx_stats_num} in \field{command-specific-data} are=
 0,
> > > > > > > > > +that means that the driver does not want to obtain this =
type of stats,
> > > > > > > > > +then the device MUST set the same name field in \field{c=
ommand-specific-data-reply} to 0, and skip this type of stats.
> > > > > > > > > +
> > > > > > > > >  \section{Block Device}\label{sec:Device Types / Block De=
vice}
> > > > > > > > >
> > > > > > > > >  The virtio block device is a simple virtual block device=
 (ie.
> > > > > > > > > --
> > > > > > > > > 2.31.0
> > > > > > > > >
> > > > > > > >
> > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> >
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

