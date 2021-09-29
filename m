Return-Path: <virtio-dev-return-8743-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7E92098648E
	for <virtio-dev@lists.oasis-open.org>; Wed, 29 Sep 2021 03:36:36 +0000 (UTC)
MIME-Version: 1.0
message-id: <1632886530.1828358-1-xuanzhuo@linux.alibaba.com>
date: Wed, 29 Sep 2021 11:35:30 +0800
from: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
in-reply-to: <CACGkMEsS4Mjm8F53Esx4Fw1-moL-h-kFPW+TU=VNrGRONJdL4Q@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v3] virtio-net: support device stats
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Jason Wang <jasowang@redhat.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 29 Sep 2021 11:24:50 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Wed, Sep 29, 2021 at 11:14 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> w=
rote:
> >
> > On Wed, 29 Sep 2021 11:07:21 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Wed, Sep 29, 2021 at 10:34 AM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
> > > >
> > > > On Wed, 29 Sep 2021 10:07:52 +0800, Jason Wang <jasowang@redhat.com=
> wrote:
> > > > > On Tue, Sep 28, 2021 at 11:48 AM Xuan Zhuo <xuanzhuo@linux.alibab=
a.com> wrote:
> > > > > >
> > > > > > On Tue, 28 Sep 2021 11:25:40 +0800, Jason Wang <jasowang@redhat=
.com> wrote:
> > > > > > > On Mon, Sep 27, 2021 at 2:54 PM Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, 27 Sep 2021 11:50:35 +0800, Jason Wang <jasowang@re=
dhat.com> wrote:
> > > > > > > > > On Thu, Sep 16, 2021 at 5:33 PM Xuan Zhuo <xuanzhuo@linux=
.alibaba.com> wrote:
> > > > > > > > > >
> > > > > > > > > > This patch allows the driver to obtain some statistics =
from the device.
> > > > > > > > > >
> > > > > > > > > > In the back-end implementation, we can count a lot of s=
uch information,
> > > > > > > > > > which can be used for debugging and judging the running=
 status of the
> > > > > > > > > > back-end. We hope to directly display it to the user th=
rough ethtool.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > > > > ---
> > > > > > > > > >
> > > > > > > > > > v3 changes:
> > > > > > > > > > 1. add dev_version
> > > > > > > > > > 2. use queue_pair_index replace rx_num, tx_num
> > > > > > > > > > 3. Explain the processing when the device and driver su=
pport different numbers
> > > > > > > > > > of stats
> > > > > > > > > >
> > > > > > > > > >  content.tex | 115 ++++++++++++++++++++++++++++++++++++=
++++++++++++++++
> > > > > > > > > >  1 file changed, 115 insertions(+)
> > > > > > > > > >
> > > > > > > > > > diff --git a/content.tex b/content.tex
> > > > > > > > > > index 7cec1c3..2e45a55 100644
> > > > > > > > > > --- a/content.tex
> > > > > > > > > > +++ b/content.tex
> > > > > > > > > > @@ -2972,6 +2972,9 @@ \subsection{Feature bits}\label{s=
ec:Device Types / Network Device / Feature bits
> > > > > > > > > >  \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address =
through control
> > > > > > > > > >      channel.
> > > > > > > > > >
> > > > > > > > > > +\item[VIRTIO_NET_F_CTRL_STATS(55)] Device can provide =
device-level statistics
> > > > > > > > > > +    to the driver through the control channel.
> > > > > > > > > > +
> > > > > > > > > >  \item[VIRTIO_NET_F_HOST_USO (56)] Device can receive U=
SO packets. Unlike UFO
> > > > > > > > > >   (fragmenting the packet) the USO splits large UDP pac=
ket
> > > > > > > > > >   to several segments when each of these smaller packet=
s has UDP header.
> > > > > > > > > > @@ -3017,6 +3020,7 @@ \subsubsection{Feature bit requir=
ements}\label{sec:Device Types / Network Device
> > > > > > > > > >  \item[VIRTIO_NET_F_GUEST_ANNOUNCE] Requires VIRTIO_NET=
_F_CTRL_VQ.
> > > > > > > > > >  \item[VIRTIO_NET_F_MQ] Requires VIRTIO_NET_F_CTRL_VQ.
> > > > > > > > > >  \item[VIRTIO_NET_F_CTRL_MAC_ADDR] Requires VIRTIO_NET_=
F_CTRL_VQ.
> > > > > > > > > > +\item[VIRTIO_NET_F_CTRL_STATS] Requires VIRTIO_NET_F_C=
TRL_VQ.
> > > > > > > > > >  \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST=
_TSO4 or VIRTIO_NET_F_HOST_TSO6.
> > > > > > > > > >  \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
> > > > > > > > > >  \end{description}
> > > > > > > > > > @@ -3895,6 +3899,7 @@ \subsubsection{Control Virtqueue}=
\label{sec:Device Types / Network Device / Devi
> > > > > > > > > >          u8 command;
> > > > > > > > > >          u8 command-specific-data[];
> > > > > > > > > >          u8 ack;
> > > > > > > > > > +        u8 command-specific-data-reply[];
> > > > > > > > > >  };
> > > > > > > > > >
> > > > > > > > > >  /* ack values */
> > > > > > > > > > @@ -3906,6 +3911,9 @@ \subsubsection{Control Virtqueue}=
\label{sec:Device Types / Network Device / Devi
> > > > > > > > > >  driver, and the device sets the \field{ack} byte. Ther=
e is little it can
> > > > > > > > > >  do except issue a diagnostic if \field{ack} is not
> > > > > > > > > >  VIRTIO_NET_OK.
> > > > > > > > > > +\field{command-specific-data-reply} is alloced by driv=
er, then pass to device.
> > > > > > > > > > +It is filled by the device. It is optional. Some comma=
nds need to get some
> > > > > > > > > > +information from the device.
> > > > > > > > >
> > > > > > > > > Let's just reuse the "sets" as above.
> > > > > > > > >
> > > > > > > > > E.g "and the device set the \field{ack} and optionally
> > > > > > > > > \field{command-specific-data-reply}"
> > > > > > > >
> > > > > > > > OK.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > >  \paragraph{Packet Receive Filtering}\label{sec:Device =
Types / Network Device / Device Operation / Control Virtqueue / Packet Rece=
ive Filtering}
> > > > > > > > > >  \label{sec:Device Types / Network Device / Device Oper=
ation / Control Virtqueue / Setting Promiscuous Mode}%old label for latexdi=
ff
> > > > > > > > > > @@ -4384,6 +4392,113 @@ \subsubsection{Legacy Interface=
: Framing Requirements}\label{sec:Device
> > > > > > > > > >  See \ref{sec:Basic
> > > > > > > > > >  Facilities of a Virtio Device / Virtqueues / Message F=
raming}.
> > > > > > > > > >
> > > > > > > > > > +\paragraph{Device stats}\label{sec:Device Types / Netw=
ork Device / Device Operation / Control Virtqueue / Device stats}
> > > > > > > > > > +
> > > > > > > > > > +If the VIRTIO_NET_F_CTRL_STATS feature is negotiated, =
the driver can
> > > > > > > > > > +get device stats from the device by \field{command-spe=
cific-data-reply}.
> > > > > > > > > > +
> > > > > > > > > > +\subparagraph{Device stats keys}\label{sec:Device Type=
s / Network Device / Device Operation / Control Virtqueue / Device stats ke=
ys / Device stats keys}
> > > > > > > > > > +
> > > > > > > > > > +The keys of the device stats are defined as follows. W=
hen the device fills in
> > > > > > > > > > +\field{command-specific-data-reply}, it MUST be writte=
n in the following order.
> > > > > > > > > > +Subsequent newly added keys MUST be added at the end o=
f each category.
> > > > > > > > > > +These keys will eventually be shown to the user.
> > > > > > > > > > +
> > > > > > > > > > +All stats are divided into three categories:
> > > > > > > > > > +
> > > > > > > > > > +\begin{itemize}
> > > > > > > > > > +    \item dev stats: the stats of the device
> > > > > > > > > > +        \begin{itemize}
> > > > > > > > > > +            \item dev_version: The number of device ve=
rsion.
> > > > > > > > > > +            \item dev_reset: The number of device rese=
t.
> > > > > > > > > > +        \end{itemize}
> > > > > > > > > > +
> > > > > > > > > > +    \item rx stats: the stats of the rx queue
> > > > > > > > > > +        \begin{itemize}
> > > > > > > > > > +            \item rx[N]_inter: The number of interrupt=
s sent by the rx queue.
> > > > > > > > > > +            \item rx[N]_drop: The number of packets dr=
opped by the rx queue. Contains all kinds of packet loss.
> > > > > > > > > > +            \item rx[N]_drop_overruns: The number of p=
ackets dropped by the rx queue when no more avail desc.
> > > > > > > > > > +            \item rx[N]_csum_bad: The number of packet=
s with abnormal csum in the rx queue.
> > > > > > > > > > +            \item rx[N]_gso_packets: The number of gso=
 packets received by rx.
> > > > > > > > > > +            \item rx[N]_gso_bytes: The number of gso b=
ytes received by rx.
> > > > > > > > > > +            \item rx[N]_oversize_pkts: The number of o=
versized packets received by the rx queue.
> > > > > > > > > > +        \end{itemize}
> > > > > > > > > > +
> > > > > > > > > > +    \item tx stats: the stats of the tx queue
> > > > > > > > > > +        \begin{itemize}
> > > > > > > > > > +            \item tx[N]_inter: The number of interrupt=
s sent by the tx queue.
> > > > > > > > > > +            \item tx[N]_drop: The number of packets dr=
opped by the tx queue. Contains all kinds of packet loss.
> > > > > > > > > > +            \item tx[N]_csum: The number of packets th=
at completes csum by the device.
> > > > > > > > > > +            \item tx[N]_gso_packets: The number of gso=
 packets transmitted.
> > > > > > > > > > +            \item tx[N]_gso_bytes: The number of gso b=
ytes transmitted.
> > > > > > > > > > +        \end{itemize}
> > > > > > > > > > +\end{itemize}
> > > > > > > > >
> > > > > > > > > Let's use C stcture for this.
> > > > > > > >
> > > > > > > > The main purpose here is to define the order of these keys.
> > > > > > > >
> > > > > > > > This issue will be discussed below.
> > > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > +
> > > > > > > > > > +\subparagraph{Device stats get}\label{sec:Device Types=
 / Network Device / Device Operation / Control Virtqueue / Device stats key=
s / Device stats get}
> > > > > > > > > > +
> > > > > > > > > > +To get the stats, the following definitions are used:
> > > > > > > > > > +\begin{lstlisting}
> > > > > > > > > > +#define VIRTIO_NET_CTRL_STATS        6
> > > > > > > > > > +#define VIRTIO_NET_CTRL_STATS_GET    0
> > > > > > > > > > +\end{lstlisting}
> > > > > > > > > > +
> > > > > > > > > > +The following layout structure are used:
> > > > > > > > > > +
> > > > > > > > > > +\field{command-specific-data}
> > > > > > > > > > +\begin{lstlisting}
> > > > > > > > > > +le64 queue_pair_index
> > > > > > > > > > +le64 dev_stats_num;
> > > > > > > > > > +le64 rx_stats_num;
> > > > > > > > > > +le64 tx_stats_num;
> > > > > > > > > > +\end{lstlisting}
> > > > > > > > > > +
> > > > > > > > > > +\field{command-specific-data-reply}
> > > > > > > > > > +\begin{lstlisting}
> > > > > > > > > > +le64 queue_pair_index
> > > > > > > > > > +le64 dev_stats_num;
> > > > > > > > > > +le64 rx_stats_num;
> > > > > > > > > > +le64 tx_stats_num;
> > > > > > > > > > +le64 dev_stats[dev_stats_num];
> > > > > > > > > > +le64 rx_stats[rx_stats_num];
> > > > > > > > > > +le64 tx_stats[tx_stats_num];
> > > > > > > > > > +\end{lstlisting}
> > > > > > > > > > +
> > > > > > > > > > +The command VIRTIO_NET_CTRL_STATS_GET is used to obtai=
n this information.
> > > > > > > > > > +
> > > > > > > > > > +Regarding the variables in \field{command-specific-dat=
a}:
> > > > > > > > > > +\begin{itemize}
> > > > > > > > > > +    \item \field{queue_pair_index}: Specify the queue =
pair index of the queue that the driver wants to get stats.
> > > > > > > > > > +    \item \field{dev_stats_num}: Indicates the number =
of dev stats supported by the driver.
> > > > > > > > > > +    \item \field{rx_stats_num}: Indicates the number o=
f stats information the driver wants for rx queue.
> > > > > > > > > > +    \item \field{tx_stats_num}: Indicates the number o=
f stats information the driver wants for tx queue.
> > > > > > > > >
> > > > > > > > > We have feature negotiation mechanism, so I think we don'=
t need
> > > > > > > > > dev_stats_num, {rx|tx}_stats_num here. Instead, all of th=
ose should be
> > > > > > > > > inferred from the features.
> > > > > > > >
> > > > > > > > The feature just indicates that the driver can obtain statu=
s information from
> > > > > > > > the device. But with the development, it is difficult for t=
he device and the
> > > > > > > > driver to support the new key synchronously. The feature is=
 also difficult to
> > > > > > > > sense how many new keys the driver and the device support r=
espectively.
> > > > > > >
> > > > > > > So I think the feature works fine for this.
> > > > > > >
> > > > > > > VIRTIO_NET_F_CTRL_STATS -> stats set A
> > > > > > > VIRTIO_NET_F_CTRL_STATS_X -> stats set A + stats set X
> > > > > > > ...
> > > > > > >
> > > > > > > The point is to unbreak the migration. We don't want to surpr=
ise the
> > > > > > > user if some of the keys were added or deleted after migratio=
n.
> > > > > >
> > > > > > Your ideas inspired me, but I think adding features is not a go=
od way. Because I
> > > > > > feel that after the dev is initialized, we can negotiate with t=
he device based
> > > > > > on CTRL_VQ.
> > > > > >
> > > > > > For example, the driver supports two versions of stats
> > > > > >
> > > > > > A: two keys
> > > > > > B: three keys
> > > > > >
> > > > > > And the device just supports version A.
> > > > > >
> > > > > > The driver can pass the two information of A and B to the devic=
e based on
> > > > > > CTRL_VQ, and the device returns a supported version name.
> > > > >
> > > > > I'm not sure I can get you here. Does this mean it supports migra=
tion
> > > > > A from B? If yes, it breaks userspace. If not, how do we know we =
can't
> > > > > do the migration?
> > > >
> > > > NO
> > > >
> > > > >
> > > > > As mentioned, the better way is to increase the sets and make e.g
> > > > > CTRL_STATS_X depend on CTRL_STATS which depend on CTRL_VQ.
> > > >
> > > > My idea is similar to yours, but I think adding a new VIRTIO_NET_F_=
CTRL_STATS_X
> > > > is a bit too wasteful.
> > > >
> > > > Assuming that these sets have been defined in the spec
> > > >
> > > > A -> stats set A
> > > > B -> stats set A + stats set B
> > > > C -> stats set A + stats set B + stats set C
> > > > ....
> > > >
> > > > We only need to tell the device based on CTRL_VQ which set we suppo=
rt, such as
> > > > B. The device returns which set it supports. This will complete the=
 negotiation.
> > > >
> > > > driver   device
> > > > A         C           =3D> A
> > > > C         C           =3D> C
>
> [1]
>
> > > > C         B           =3D> B
>
> [2]
>
> > >
> > > So how do we know we can't migrate device(B) to device(C)?
> >
> > Aren=E2=80=99t we discussing the driver and the device to negotiate whi=
ch set of stats
> > everyone will ultimately use? What do you mean by migration?
>
> Feature bit is a facility for preserving migration compatibility.
> Consider if we want to migrate from device[1] to device[2]. Drivers
> may see different stats sets which breaks userspace application and
> migration.

Okay, thanks for your explanation and patience.

>
> Thanks
>
> >
> > Thanks.
> >
> > >
> > > Thanks
> > >
> > > >
> > > > My idea is to no longer waste a feature bit, but to complete the ne=
gotiation
> > > > based on CTRL_VQ.
> > > >
> > > > Hope I made it clear. ^_^.
> > > >
> > > > Thanks.
> > > >
> > > >
> > > > >
> > > > > Thanks
> > > > >
> > > > > >
> > > > > > In addition, do you think we need to define this content now, o=
r should we
> > > > > > define this one when there is a new version of stats in the fut=
ure?
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > For example, there are currently only two dev_stats, and bo=
th the device and the
> > > > > > > > driver only support two keys. If the virtio spec adds a new=
 dev stats, the
> > > > > > > > driver may first support three keys, but the device still s=
upports only two. The
> > > > > > > > number of keys supported by both parties is needed to negot=
iate.
> > > > > > >
> > > > > > > So let's say VIRTIO_NET_F_CTRL_STATS (two keys) but
> > > > > > > VIRTIO_NET_F_CTRL_STATS_X has three keys.
> > > > > > > In this case if VIRTIO_NET_F_CTRL_STATS_X is not supported by=
 the
> > > > > > > device (only two keys), it won't be negotiated and the driver=
 knows
> > > > > > > the device will only return 2 keys.
> > > > > > >
> > > > > > > >
> > > > > > > > dev_stats_num, (rx|tx)_stats_num exists for this purpose.
> > > > > > > >
> > > > > > > > I think the increase of these keys is a relatively frequent=
 thing.
> > > > > > >
> > > > > > > Probably not, looking at other NIC drivers the "keys" are pre=
tty
> > > > > > > stable. We can start from a large set anyhow.
> > > > > >
> > > > > > OK.
> > > > > >
> > > > > > Thanks.
> > > > > >
> > > > > > >
> > > > > > > Thanks
> > > > > > >
> > > > > > > > It is also
> > > > > > > > difficult to synchronize the support for new keys between d=
rivers and devices.
> > > > > > > >
> > > > > > > > Thanks.
> > > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Thanks
> > > > > > > > >
> > > > > > > > > > +\end{itemize}
> > > > > > > > > > +
> > > > > > > > > > +Regarding the variables in \field{command-specific-dat=
a-reply}:
> > > > > > > > > > +\begin{itemize}
> > > > > > > > > > +    \item All variables of \field{command-specific-dat=
a-reply} are set by the device.
> > > > > > > > > > +    \item \field{queue_pair_index} MUST be equal to th=
e variable with the same name in \field{command-specific-data}.
> > > > > > > > > > +    \item These variables(\field{dev_stats_num}, \fiel=
d{rx_stats_num}, \field{tx_stats_num}) MUST be
> > > > > > > > > > +            less than or equal to the variables with t=
he same name in \field{command-specific-data}.
> > > > > > > > > > +            These values indicate the amount of stats =
actually filled in.
> > > > > > > > > > +    \item \field{command-specific-data-reply} is meani=
ngful only when \field{ack} is equal to VIRTIO_NET_OK.
> > > > > > > > > > +\end{itemize}
> > > > > > > > > > +
> > > > > > > > > > +The variables \field{dev_stats_num}, \field{rx_stats_n=
um}, \field{tx_stats_num} in \field{command-specific-data}
> > > > > > > > > > +specify which stats the driver wants to get, but in fa=
ct the device may support
> > > > > > > > > > +more or fewer stats.
> > > > > > > > > > +
> > > > > > > > > > +If the actual number of stats supported by the device =
is equal to or less than
> > > > > > > > > > +the number that the driver wants to obtain, then the d=
evice MUST write all the
> > > > > > > > > > +stats to the corresponding position of \field{command-=
specific-data-reply}.
> > > > > > > > > > +
> > > > > > > > > > +And if the number of stats actually supported by the d=
evice is more than the
> > > > > > > > > > +driver requires, then the device MUST only write the n=
umber supported by the
> > > > > > > > > > +driver.
> > > > > > > > > > +
> > > > > > > > > > +If the some of the variables \field{dev_stats_num}, \f=
ield{rx_stats_num}, \field{tx_stats_num} in \field{command-specific-data} a=
re 0,
> > > > > > > > > > +that means that the driver does not want to obtain thi=
s type of stats,
> > > > > > > > > > +then the device MUST set the same name field in \field=
{command-specific-data-reply} to 0, and skip this type of stats.
> > > > > > > > > > +
> > > > > > > > > >  \section{Block Device}\label{sec:Device Types / Block =
Device}
> > > > > > > > > >
> > > > > > > > > >  The virtio block device is a simple virtual block devi=
ce (ie.
> > > > > > > > > > --
> > > > > > > > > > 2.31.0
> > > > > > > > > >
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

