Return-Path: <virtio-dev-return-13367-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF502EB64DD
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Jul 2023 02:21:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 066831318CE
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Jul 2023 02:21:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E277E9867CC
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Jul 2023 02:21:39 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C3F7B9867C0; Thu, 13 Jul 2023 02:21:39 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A9D709867C2
	for <virtio-dev@lists.oasis-open.org>; Thu, 13 Jul 2023 02:21:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 7U9QZFGQNAeAFklgP-I96w-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689214896; x=1691806896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Geo174U6wVU2lKJy1UN8xK9XhyxqyiZrYb5/nzhqKZ0=;
        b=URfUKKH6ttUv3EN8rcxgCfnn/Y7UuHUgZrDMfrUb900yB/YVIaRq2yTEO5g8Ihfh7e
         AAAa6J2E/zTk9f6hnEIvR3slPULOXX7D8vrcsL1dH/hp0vC20PgudXUCAo+XLsFkvlS0
         zyh25tbnDE/U9CoIolpvcb6tdMfqU/DqQIdkBUGtAGTCY/2j47GJSm5IP+PUbHNeME1i
         eXWQe6vqFY90+z4W7ouzXKOWTixAjjriB9zEyKXLst7m/ReRYZp6whQkfdsOvIcKUMmb
         4Dc4KkhWANRunUoRf1+jyn9iUIEkNrfJ7WhbKjkiSqper1w2bjZi5IH7nhj0J1LBAcN/
         46Rw==
X-Gm-Message-State: ABy/qLZMaf9CFEh8jJaS2TpePOogx7QcwMasWqVbvNgFIj3i4U2EzSh0
	xTm6Se63Dcl3o6AizJvthIre+srLWdhjw08kO5QpigIRtjORdGLtnc9JH6axSPTrktlP0eEfQu3
	ieVdjluvvDCnoLVhNAdyaJS7BH3NMKDXLExIZROxPTH3a
X-Received: by 2002:a0c:f0d2:0:b0:636:2fa5:fd78 with SMTP id d18-20020a0cf0d2000000b006362fa5fd78mr243044qvl.30.1689214895882;
        Wed, 12 Jul 2023 19:21:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF/dirTM3ceogVvUGhx5sRsq3ZPwf16hv6TUpIG4yqnkfYx29zvJYKw0gS6RhFc5xWCC7j6Z8cEJ9fV7Z2vz7A=
X-Received: by 2002:a0c:f0d2:0:b0:636:2fa5:fd78 with SMTP id
 d18-20020a0cf0d2000000b006362fa5fd78mr243030qvl.30.1689214895371; Wed, 12 Jul
 2023 19:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220315032402.6088-1-xuanzhuo@linux.alibaba.com>
 <1688974120.7019765-1-xuanzhuo@linux.alibaba.com> <CACGkMEshsX6qFk6ZaeugcBarPm5Xi7P71Xri+mKd+R2MgXt74w@mail.gmail.com>
 <1689153095.6696565-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1689153095.6696565-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 13 Jul 2023 10:21:23 +0800
Message-ID: <CACGkMEvkVHwQ3PiFgS9zpkoCWt1nv8v1_5bGbPTmkaaCJHF12g@mail.gmail.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, 
	Parav Pandit <parav@nvidia.com>, virtio-comment@lists.oasis-open.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] [PATCH v12] virtio-net: support device stats

On Wed, Jul 12, 2023 at 5:19=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Wed, 12 Jul 2023 16:08:48 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Mon, Jul 10, 2023 at 3:32=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com>
> > wrote:
> >
> > > hi, guys
> > >
> > > After a lot of internal discussions, I removed some unimportant count=
ers.
> > > Based
> > > on this v12 patch I am repling to, most of the requirements have been=
 met.
> > >
> > > The patch link
> > > https://lore.kernel.org/all/20220315032402.6088-1-xuanzhuo@linux.alib=
aba.com/
> > >
> > > We still have these counters, let's see if they can be standardized.
> > >
> > > ## limit
> > >
> > > * tx_bps_limit_drops
> > > * tx_pps_limit_drops
> > > * rx_bps_limit_drops
> > > * rx_pps_limit_drops
> > >
> > > In a cloud scenario, multiple users purchase different VMs, and these=
 VMs
> > > share
> > > the capabilities of the same host. In order to ensure that each VM wi=
ll not
> > > affect others, the network card(virtio-net) capability of each VM is
> > > limited.
> > > These users purchase VMs, this limit has already been determined.
> > >
> >
> > This seems a feature beyond the counters but QOS. I think we virtio spe=
c
> > need to support QOS before we can discuss any QOS related counters.
> >
> >
> > >
> > > So if the network card traffic of a vm exceeds the upper limit, packe=
t
> > > loss will
> > > occur. It is necessary for us to count these packet losses. And the d=
evice
> > > should expose to the user.
> > >
> > > ## session
> > >
> > > * tx_session_full_drops The number of packet drops in the sending
> > > direction when
> > >                         the session is full
> > > * rx_session_full_drops The number of packets lost when the session i=
s
> > > full in the receiving direction
> > >
> > > Our dpu supports tcp connection tracking, but there is an upper limit=
 to
> > > the
> > > number of connections, and if it exceeds, packet loss will also occur=
.
> > >
> >
> > Similarly, if connect tracking offload is supported, it needs to be
> > implemented in the spec first then we can have related counters.
> >
> >
> > >
> > > ## ACL
> > >
> > > * tx_acl_drops ACL packet loss in the sending direction
> > > * rx_acl_drops The number of ACL packets lost in the receiving direct=
ion
> > >
> > > In our cloud service, for network cards, users are allowed to configu=
re
> > > security
> > > rules,such as which IPs can access which ports of this machine.
> > >
> >
> > Same as above, ACL should be supported by the spec first then the count=
ers.
> >
> > In conclusion, the features must be self contained. Otherwise you are d=
oing
> > vDPA actually and those counters need to be accessed in a vendor specif=
ic
> > way.
>
> Yes that's the point, as we've discussed here.
>
> http://lore.kernel.org/all/1686550355.2503424-1-xuanzhuo@linux.alibaba.co=
m
>
> There are many similar counters. There may not be many usage scenarios, s=
o I
> didn't list them here.
>
> Our acl, seesion, and limit are not configured by the user at the driver =
layer,
> and I don't think these should be configured at the driver.

Sounds like something related to OPI. But if the features were not
configured by driver, any reason to let it be noticeable by it?

Exposing things like tx_acl_drops may have security implications,
enabling software to probe the ACL rules?

Thanks

> So at least as
> far as our usage scenarios are concerned, these are some functions that h=
ave
> nothing to do with virtio spec.
>
> So what I want most is that the virto spec supports a vendor channel.
>
> Of course, I am ok with Parav's abstraction of "limit".
>
>         Some implementations of txq are lossy and some are not creating b=
ackpressure/flow control to driver so driver can rate limit it naturally.
>         So a tx packet drop counter is needed to cover the lossy implemen=
tations which is abstract enough regardless of reason on why device dropped=
 it.
>         A more granular counter becomes vendor specific that we can possi=
bly avoid or place under different command.
>
> But acl and session may not be very good to abstract.
>
> Thanks.
>
>
> >
> > Thanks
> >
> >
> > >
> > >
> > > Thanks
> > >
> > >
> > > On Tue, 15 Mar 2022 11:24:02 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba=
.com>
> > > wrote:
> > > > This patch allows the driver to obtain some statistics from the dev=
ice.
> > > >
> > > > In the back-end implementation, we can count a lot of such informat=
ion,
> > > > which can be used for debugging and judging the running status of t=
he
> > > > back-end. We hope to directly display it to the user through ethtoo=
l.
> > > >
> > > > To get stats atomically, try to get stats for all queue pairs in on=
e
> > > > command.
> > > >
> > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > > > ---
> > > >  conformance.tex |   2 +
> > > >  content.tex     | 406 ++++++++++++++++++++++++++++++++++++++++++++=
+++-
> > > >  2 files changed, 405 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/conformance.tex b/conformance.tex
> > > > index 42f8537..c67f877 100644
> > > > --- a/conformance.tex
> > > > +++ b/conformance.tex
> > > > @@ -142,6 +142,7 @@ \section{Conformance Targets}\label{sec:Conform=
ance
> > > / Conformance Targets}
> > > >  \item \ref{drivernormative:Device Types / Network Device / Device
> > > Operation / Control Virtqueue / Automatic receive steering in multiqu=
eue
> > > mode}
> > > >  \item \ref{drivernormative:Device Types / Network Device / Device
> > > Operation / Control Virtqueue / Offloads State Configuration / Settin=
g
> > > Offloads State}
> > > >  \item \ref{drivernormative:Device Types / Network Device / Device
> > > Operation / Control Virtqueue / Receive-side scaling (RSS) }
> > > > +\item \ref{drivernormative:Device Types / Network Device / Device
> > > Operation / Control Virtqueue / Device Stats}
> > > >  \end{itemize}
> > > >
> > > >  \conformance{\subsection}{Block Driver
> > > Conformance}\label{sec:Conformance / Driver Conformance / Block Drive=
r
> > > Conformance}
> > > > @@ -401,6 +402,7 @@ \section{Conformance Targets}\label{sec:Conform=
ance
> > > / Conformance Targets}
> > > >  \item \ref{devicenormative:Device Types / Network Device / Device
> > > Operation / Control Virtqueue / Gratuitous Packet Sending}
> > > >  \item \ref{devicenormative:Device Types / Network Device / Device
> > > Operation / Control Virtqueue / Automatic receive steering in multiqu=
eue
> > > mode}
> > > >  \item \ref{devicenormative:Device Types / Network Device / Device
> > > Operation / Control Virtqueue / Receive-side scaling (RSS) / RSS proc=
essing}
> > > > +\item \ref{devicenormative:Device Types / Network Device / Device
> > > Operation / Control Virtqueue / Device Stats}
> > > >  \end{itemize}
> > > >
> > > >  \conformance{\subsection}{Block Device
> > > Conformance}\label{sec:Conformance / Device Conformance / Block Devic=
e
> > > Conformance}
> > > > diff --git a/content.tex b/content.tex
> > > > index c6f116c..81f325d 100644
> > > > --- a/content.tex
> > > > +++ b/content.tex
> > > > @@ -3092,6 +3092,9 @@ \subsection{Feature bits}\label{sec:Device Ty=
pes /
> > > Network Device / Feature bits
> > > >  \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through cont=
rol
> > > >      channel.
> > > >
> > > > +\item[VIRTIO_NET_F_CTRL_STATS(55)] Device can provide device-level
> > > statistics
> > > > +    to the driver through the control channel.
> > > > +
> > > >  \item[VIRTIO_NET_F_HOST_USO (56)] Device can receive USO packets.
> > > Unlike UFO
> > > >   (fragmenting the packet) the USO splits large UDP packet
> > > >   to several segments when each of these smaller packets has UDP he=
ader.
> > > > @@ -3137,6 +3140,7 @@ \subsubsection{Feature bit
> > > requirements}\label{sec:Device Types / Network Device
> > > >  \item[VIRTIO_NET_F_GUEST_ANNOUNCE] Requires VIRTIO_NET_F_CTRL_VQ.
> > > >  \item[VIRTIO_NET_F_MQ] Requires VIRTIO_NET_F_CTRL_VQ.
> > > >  \item[VIRTIO_NET_F_CTRL_MAC_ADDR] Requires VIRTIO_NET_F_CTRL_VQ.
> > > > +\item[VIRTIO_NET_F_CTRL_STATS] Requires VIRTIO_NET_F_CTRL_VQ.
> > > >  \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or
> > > VIRTIO_NET_F_HOST_TSO6.
> > > >  \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
> > > >  \end{description}
> > > > @@ -4015,6 +4019,7 @@ \subsubsection{Control Virtqueue}\label{sec:D=
evice
> > > Types / Network Device / Devi
> > > >          u8 command;
> > > >          u8 command-specific-data[];
> > > >          u8 ack;
> > > > +        u8 command-specific-data-reply[];
> > > >  };
> > > >
> > > >  /* ack values */
> > > > @@ -4023,9 +4028,11 @@ \subsubsection{Control
> > > Virtqueue}\label{sec:Device Types / Network Device / Devi
> > > >  \end{lstlisting}
> > > >
> > > >  The \field{class}, \field{command} and command-specific-data are s=
et by
> > > the
> > > > -driver, and the device sets the \field{ack} byte. There is little =
it can
> > > > -do except issue a diagnostic if \field{ack} is not
> > > > -VIRTIO_NET_OK.
> > > > +driver, and the device sets the \field{ack} byte and optionally
> > > > +\field{command-specific-data-reply}. There is little the driver ca=
n
> > > > +do except issue a diagnostic if \field{ack} is not VIRTIO_NET_OK.
> > > > +
> > > > +The command VIRTIO_NET_CTRL_STATS_GET contains
> > > \field{command-specific-data-reply}.
> > > >
> > > >  \paragraph{Packet Receive Filtering}\label{sec:Device Types / Netw=
ork
> > > Device / Device Operation / Control Virtqueue / Packet Receive Filter=
ing}
> > > >  \label{sec:Device Types / Network Device / Device Operation / Cont=
rol
> > > Virtqueue / Setting Promiscuous Mode}%old label for latexdiff
> > > > @@ -4471,6 +4478,399 @@ \subsubsection{Control
> > > Virtqueue}\label{sec:Device Types / Network Device / Devi
> > > >  according to the native endian of the guest rather than
> > > >  (necessarily when not using the legacy interface) little-endian.
> > > >
> > > > +\paragraph{Device Stats}\label{sec:Device Types / Network Device /
> > > Device Operation / Control Virtqueue / Device Stats}
> > > > +
> > > > +If the VIRTIO_NET_F_CTRL_STATS feature is negotiated, the driver c=
an
> > > > +get the device stats from the device in
> > > \field{command-specific-data-reply}.
> > > > +
> > > > +To get the stats, the following definitions are used:
> > > > +\begin{lstlisting}
> > > > +#define VIRTIO_NET_CTRL_STATS         6
> > > > +#define VIRTIO_NET_CTRL_STATS_GET     0
> > > > +
> > > > +#define VIRTIO_NET_STATS_TYPE_CVQ      0
> > > > +#define VIRTIO_NET_STATS_TYPE_RX_BASIC 1
> > > > +#define VIRTIO_NET_STATS_TYPE_RX_CSUM  2
> > > > +#define VIRTIO_NET_STATS_TYPE_RX_GSO   3
> > > > +#define VIRTIO_NET_STATS_TYPE_RX_RESET 4
> > > > +#define VIRTIO_NET_STATS_TYPE_TX_BASIC 5
> > > > +#define VIRTIO_NET_STATS_TYPE_TX_CSUM  6
> > > > +#define VIRTIO_NET_STATS_TYPE_TX_GSO   7
> > > > +#define VIRTIO_NET_STATS_TYPE_TX_RESET 8
> > > > +
> > > > +\end{lstlisting}
> > > > +
> > > > +Use the command VIRTIO_NET_CTRL_STATS_GET and
> > > \field{command-specific-data}
> > > > +containing struct virtio_net_ctrl_queue_stats to get the device st=
ats.
> > > > +The result is returned by \field{command-specific-data-reply}.
> > > > +The stats ware returned in the order of the type specified in the
> > > > +\field{virtio_net_ctrl_queue_stats}.
> > > > +
> > > > +The following layout structures are used:
> > > > +
> > > > +\field{command-specific-data}
> > > > +\begin{lstlisting}
> > > > +struct virtio_net_ctrl_queue_stats {
> > > > +     u16 nstats;
> > > > +     struct {
> > > > +         u16 queue_num;
> > > > +         u16 type;
> > > > +     } stats[];
> > > > +};
> > > > +\end{lstlisting}
> > > > +
> > > > +\field{command-specific-data-reply}
> > > > +\begin{lstlisting}
> > > > +struct virtio_net_stats_cvq {
> > > > +    le64 command_num;
> > > > +    le64 ok_num;
> > > > +};
> > > > +
> > > > +struct virtio_net_stats_rx_basic {
> > > > +    le64 rx_packets;
> > > > +    le64 rx_bytes;
> > > > +
> > > > +    le64 rx_notification;
> > > > +    le64 rx_interrupt;
> > > > +
> > > > +    le64 rx_drop;
> > > > +    le64 rx_drop_overruns;
> > > > +};
> > > > +
> > > > +struct virtio_net_stats_rx_csum {
> > > > +    le64 rx_csum_valid;
> > > > +    le64 rx_needs_csum;
> > > > +    le64 rx_csum_bad;
> > > > +    le64 rx_csum_none;
> > > > +};
> > > > +
> > > > +struct virtio_net_stats_rx_gso {
> > > > +    le64 rx_gso_packets;
> > > > +    le64 rx_gso_bytes;
> > > > +    le64 rx_gso_packets_coalesced;
> > > > +    le64 rx_gso_bytes_coalesced;
> > > > +    le64 rx_gso_segments;
> > > > +    le64 rx_gso_segments_bytes;
> > > > +};
> > > > +
> > > > +struct virtio_net_stats_rx_reset {
> > > > +    le64 rx_reset;
> > > > +};
> > > > +
> > > > +struct virtio_net_stats_tx_basic {
> > > > +    le64 tx_packets;
> > > > +    le64 tx_bytes;
> > > > +
> > > > +    le64 tx_notification;
> > > > +    le64 tx_interrupt;
> > > > +
> > > > +    le64 tx_drop;
> > > > +    le64 tx_drop_malformed;
> > > > +};
> > > > +
> > > > +struct virtio_net_stats_tx_csum {
> > > > +    le64 tx_csum_none;
> > > > +    le64 tx_needs_csum;
> > > > +};
> > > > +
> > > > +struct virtio_net_stats_tx_gso {
> > > > +    le64 tx_gso_packets;
> > > > +    le64 tx_gso_bytes;
> > > > +    le64 tx_gso_packets_split;
> > > > +    le64 tx_gso_bytes_split;
> > > > +    le64 tx_gso_segments;
> > > > +    le64 tx_gso_segments_bytes;
> > > > +};
> > > > +
> > > > +struct virtio_net_stats_tx_reset {
> > > > +    le64 tx_reset;
> > > > +};
> > > > +
> > > > +\end{lstlisting}
> > > > +
> > > > +\begin{description}
> > > > +    \item [nstats]
> > > > +        The number of \field{stats}.
> > > > +
> > > > +    \item [queue_num]
> > > > +        The number of the virtqueue to obtain the statistics.
> > > > +
> > > > +    \item [type]
> > > > +        The type of the stats to be obtained.
> > > > +
> > > > +\end{description}
> > > > +
> > > > +Correspondence between the vq type, the stats type, the stats stru=
cture
> > > and the
> > > > +required features.
> > > > +\begin{tabular}{ |l|l|l|l| }
> > > > +    \hline
> > > > +    VQ Type                  & Stats Type                     & St=
ats
> > > Structure           & Features \\ \hline
> > > > +
> > > > +    controlq                 & VIRTIO_NET_STATS_TYPE_CVQ      &
> > > virtio_net_stats_cvq      & \\ \hline
> > > > +
> > > > +    \multirow{4}*{receiveq}  & VIRTIO_NET_STATS_TYPE_RX_BASIC &
> > > virtio_net_stats_rx_basic & \\ \cline{2-4}
> > > > +                             & VIRTIO_NET_STATS_TYPE_RX_CSUM  &
> > > virtio_net_stats_rx_csum  & VIRTIO_NET_F_GUEST_CSUM \\ \cline{2-4}
> > > > +                             & VIRTIO_NET_STATS_TYPE_RX_GSO   &
> > > virtio_net_stats_rx_gso   & VIRTIO_NET_F_GUEST_TSO4 or\newline
> > > > +
> > >                     VIRTIO_NET_F_GUEST_TSO6 or\newline
> > > > +
> > >                     VIRTIO_NET_F_GUEST_UFO    \\ \cline{2-4}
> > > > +                             & VIRTIO_NET_STATS_TYPE_RX_RESET &
> > > virtio_net_stats_rx_reset & VIRTIO_F_RING_RESET \\ \hline
> > > > +
> > > > +    \multirow{4}*{transmitq} & VIRTIO_NET_STATS_TYPE_TX_BASIC &
> > > virtio_net_stats_tx_basic & \\ \cline{2-4}
> > > > +                             & VIRTIO_NET_STATS_TYPE_TX_CSUM  &
> > > virtio_net_stats_tx_csum  & VIRTIO_NET_F_CSUM \\ \cline{2-4}
> > > > +                             & VIRTIO_NET_STATS_TYPE_TX_GSO   &
> > > virtio_net_stats_tx_gso   & VIRTIO_NET_F_HOST_TSO4 or\newline
> > > > +
> > >                     VIRTIO_NET_F_HOST_TSO6 or\newline
> > > > +
> > >                     VIRTIO_NET_F_HOST_USO  or\newline
> > > > +
> > >                     VIRTIO_NET_F_HOST_UFO  \\ \cline{2-4}
> > > > +                             & VIRTIO_NET_STATS_TYPE_TX_RESET &
> > > virtio_net_stats_tx_reset & VIRTIO_F_RING_RESET \\
> > > > +    \hline
> > > > +\end{tabular}
> > > > +
> > > > +
> > > > +\subparagraph{Controlq Stats}\label{sec:Device Types / Network Dev=
ice /
> > > Device Operation / Control Virtqueue / Device Stats / Controlq Stats}
> > > > +
> > > > +The structure corresponding to the controlq stats is
> > > virtio_net_stats_cvq.
> > > > +
> > > > +\begin{description}
> > > > +    \item [command_num]
> > > > +        The number of commands, including the current command.
> > > > +
> > > > +    \item [ok_num]
> > > > +        The number of commands (including the current command) whe=
re
> > > the ack was VIRTIO_NET_OK.
> > > > +\end{description}
> > > > +
> > > > +
> > > > +\subparagraph{Receiveq Basic Stats}\label{sec:Device Types / Netwo=
rk
> > > Device / Device Operation / Control Virtqueue / Device Stats / Receiv=
eq
> > > Basic Stats}
> > > > +
> > > > +The structure corresponding to the receiveq basic stats is
> > > virtio_net_stats_rx_basic.
> > > > +
> > > > +Receiveq basic stats doesn't need any features, as long as the dev=
ice
> > > supports
> > > > +VIRTIO_NET_F_CTRL_STATS. The following are the receiveq basic stat=
s.
> > > > +
> > > > +\begin{description}
> > > > +    \item [rx_packets]
> > > > +        The number of packets received by device (not the packets
> > > passed to the
> > > > +        guest), including the dropped packets by device.
> > > > +
> > > > +    \item [rx_bytes]
> > > > +        The number of bytes received by device (not the packets pa=
ssed
> > > to the
> > > > +        guest), including the dropped packets by device.
> > > > +
> > > > +    \item [rx_notification]
> > > > +        The number of driver notifications.
> > > > +
> > > > +    \item [rx_interrupt]
> > > > +        The number of device interrupts.
> > > > +
> > > > +    \item [rx_drop]
> > > > +        The number of packets dropped by the receiveq. Contains al=
l
> > > kinds of
> > > > +        packet drop.
> > > > +
> > > > +    \item [rx_drop_overruns]
> > > > +        The number of packets dropped by the receiveq when no more
> > > descriptors
> > > > +        were available.
> > > > +
> > > > +\end{description}
> > > > +
> > > > +\subparagraph{Transmitq Basic Stats}\label{sec:Device Types / Netw=
ork
> > > Device / Device Operation / Control Virtqueue / Device Stats / Transm=
itq
> > > Basic Stats}
> > > > +
> > > > +The structure corresponding to the transmitq basic stats is
> > > virtio_net_stats_tx_basic.
> > > > +
> > > > +Transmitq basic stats doesn't need any features, as long as the de=
vice
> > > supports
> > > > +VIRTIO_NET_F_CTRL_STATS. The following are the transmitq basic sta=
ts.
> > > > +
> > > > +\begin{description}
> > > > +    \item [tx_packets]
> > > > +        The number of packets sent by device (not the packets got =
from
> > > the
> > > > +        guest), excluding the dropped packets by device.
> > > > +
> > > > +    \item [tx_bytes]
> > > > +        The number of bytes sent by device (not the packets got fr=
om the
> > > > +        guest), excluding the dropped packets by device.
> > > > +
> > > > +    \item [tx_notification]
> > > > +        The number of driver notifications.
> > > > +
> > > > +    \item [tx_interrupt]
> > > > +        The number of device interrupts.
> > > > +
> > > > +    \item [tx_drop]
> > > > +        The number of packets dropped by the transmitq. Contains a=
ll
> > > kinds of
> > > > +        packet drop.
> > > > +
> > > > +    \item [tx_drop_malformed]
> > > > +        The number of packets dropped when the descriptor is in an
> > > error state.
> > > > +        For example, the buffer is too short.
> > > > +
> > > > +\end{description}
> > > > +
> > > > +\subparagraph{Receiveq CSUM Stats}\label{sec:Device Types / Networ=
k
> > > Device / Device Operation / Control Virtqueue / Device Stats / Receiv=
eq
> > > CSUM Stats}
> > > > +
> > > > +The structure corresponding to the receiveq csum stats is
> > > virtio_net_stats_rx_csum.
> > > > +
> > > > +Only after the VIRTIO_NET_F_GUEST_CSUM negotiation is successful, =
the
> > > receiveq
> > > > +csum stats can be obtained.
> > > > +
> > > > +The following are the receiveq csum stats:
> > > > +
> > > > +\begin{description}
> > > > +    \item [rx_csum_valid]
> > > > +        The number of packets with VIRTIO_NET_HDR_F_DATA_VALID.
> > > > +
> > > > +    \item [rx_needs_csum]
> > > > +        The number of packets with VIRTIO_NET_HDR_F_NEEDS_CSUM.
> > > > +
> > > > +    \item [rx_csum_bad]
> > > > +        The number of packets with abnormal csum.
> > > > +
> > > > +    \item [rx_csum_none]
> > > > +        The number of packets without hardware csum. The packet he=
re
> > > refers to
> > > > +        the non-TCP/UDP packet that the backend cannot recognize.
> > > > +
> > > > +\end{description}
> > > > +
> > > > +\subparagraph{Transmitq CSUM Stats}\label{sec:Device Types / Netwo=
rk
> > > Device / Device Operation / Control Virtqueue / Device Stats / Transm=
itq
> > > CSUM Stats}
> > > > +
> > > > +The structure corresponding to the transmitq csum stats is
> > > virtio_net_stats_tx_csum.
> > > > +
> > > > +Only after the VIRTIO_NET_F_CSUM negotiation is successful, the
> > > transmitq csum
> > > > +stats can be obtained.
> > > > +
> > > > +The following are the transmitq csum stats:
> > > > +
> > > > +\begin{description}
> > > > +    \item [tx_csum_none]
> > > > +        The number of packets that didn't require hardware csum.
> > > > +
> > > > +    \item [tx_needs_csum]
> > > > +        The number of packets that required hardware csum.
> > > > +
> > > > +\end{description}
> > > > +
> > > > +\subparagraph{Receiveq GSO Stats}\label{sec:Device Types / Network
> > > Device / Device Operation / Control Virtqueue / Device Stats / Receiv=
eq GSO
> > > Stats}
> > > > +
> > > > +The structure corresponding to the receiveq gso stats is
> > > virtio_net_stats_rx_gso.
> > > > +
> > > > +If one of the VIRTIO_NET_F_GUEST_TSO4, TSO6, or UFO options have
> > > > +been negotiated, the receiveq gso stats can be obtained.
> > > > +
> > > > +Rx gso packets refer to packets passed by the device to the driver=
 where
> > > > +\field{gso_type} is not VIRTIO_NET_HDR_GSO_NONE.
> > > > +
> > > > +\begin{description}
> > > > +    \item [rx_gso_packets]
> > > > +        The number of the rx gso packets.
> > > > +
> > > > +    \item [rx_gso_bytes]
> > > > +        The number of bytes(excluding the virtio net header) of th=
e rx
> > > gso packets.
> > > > +
> > > > +    \item [rx_gso_packets_coalesced]
> > > > +        The number of the rx gso packages generated by coalescing.
> > > > +
> > > > +    \item [rx_gso_bytes_coalesced]
> > > > +        The number of bytes(excluding the virtio net header) of th=
e rx
> > > gso packets generated by coalescing.
> > > > +
> > > > +    \item [rx_gso_segments]
> > > > +        The number of coalesced segments.
> > > > +
> > > > +    \item [rx_gso_segments_bytes]
> > > > +        The number of bytes of coalesced segments.
> > > > +
> > > > +\end{description}
> > > > +
> > > > +\subparagraph{Transmitq GSO Stats}\label{sec:Device Types / Networ=
k
> > > Device / Device Operation / Control Virtqueue / Device Stats / Transm=
itq
> > > GSO Stats}
> > > > +
> > > > +The structure corresponding to the transmitq gso stats is
> > > virtio_net_stats_tx_gso.
> > > > +
> > > > +If one of the VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO options hav=
e
> > > > +been negotiated, the transmitq gso stats can be obtained.
> > > > +
> > > > +Tx gso packets refer to packets passed by the driver to the device=
 where
> > > > +\field{gso_type} is not VIRTIO_NET_HDR_GSO_NONE.
> > > > +
> > > > +\begin{description}
> > > > +    \item [tx_gso_packets]
> > > > +        The number of the tx gso packets.
> > > > +
> > > > +    \item [tx_gso_bytes]
> > > > +        The number of bytes(excluding the virtio net header) of th=
e tx
> > > gso packets.
> > > > +
> > > > +    \item [tx_gso_packets_split]
> > > > +        The number of the tx gso packets that been split.
> > > > +
> > > > +    \item [tx_gso_bytes_split]
> > > > +        The number of bytes(excluding the virtio net header) of th=
e tx
> > > gso packets that been split.
> > > > +
> > > > +    \item [tx_gso_segments]
> > > > +        The number of segments split from the gso package.
> > > > +
> > > > +    \item [tx_gso_segments_bytes]
> > > > +        The number of bytes(excluding the virtio net header) of
> > > segments split from the gso package.
> > > > +\end{description}
> > > > +
> > > > +\subparagraph{Receiveq Reset Stats}\label{sec:Device Types / Netwo=
rk
> > > Device / Device Operation / Control Virtqueue / Device Stats / Receiv=
eq
> > > Reset Stats}
> > > > +
> > > > +The structure corresponding to the receiveq reset stats is
> > > virtio_net_stats_rx_reset.
> > > > +
> > > > +Only when VIRTIO_F_RING_RESET is successfully negotiated, the rece=
iveq
> > > reset stats
> > > > +can be obtained.
> > > > +
> > > > +See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues /
> > > Virtqueue Reset}
> > > > +for more about \field{rx_reset}.
> > > > +
> > > > +\begin{description}
> > > > +    \item [rx_reset]
> > > > +        The number of receiveq resets.
> > > > +\end{description}
> > > > +
> > > > +\subparagraph{Transmitq Reset Stats}\label{sec:Device Types / Netw=
ork
> > > Device / Device Operation / Control Virtqueue / Device Stats / Transm=
itq
> > > Reset Stats}
> > > > +
> > > > +The structure corresponding to the transmitq reset stats is
> > > virtio_net_stats_tx_reset.
> > > > +
> > > > +Only when VIRTIO_F_RING_RESET is successfully negotiated, the tran=
smitq
> > > reset stats
> > > > +can be obtained.
> > > > +
> > > > +See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues /
> > > Virtqueue Reset}
> > > > +for more about \field{tx_reset}.
> > > > +
> > > > +\begin{description}
> > > > +    \item [tx_reset]
> > > > +        The number of transmitq resets.
> > > > +\end{description}
> > > > +
> > > > +\devicenormative{\subparagraph}{Device Stats}{Device Types / Netwo=
rk
> > > Device / Device Operation / Control Virtqueue / Device Stats}
> > > > +
> > > > +If virtio_net_ctrl_queue_stats is incorrect (such as the following=
),
> > > the device
> > > > +MUST set \field{ack} to VIRTIO_NET_ERR. Even if there is only one =
error,
> > > > +the device MUST abort the entire command.
> > > > +\begin{itemize}
> > > > +    \item \field{queue_num} exceeds the queue range.
> > > > +    \item \field{type} is not a known value.
> > > > +    \item The type of vq does not match \field{type}. E.g. the dri=
ver
> > > tries to query
> > > > +        RX stats through a TX index.
> > > > +    \item The feature corresponding to the specified \field{type} =
was
> > > not successfully
> > > > +        negotiated.
> > > > +    \item The size of the buffer allocated by the driver for
> > > \field{command-specific-data-reply}
> > > > +        is less than the total size of the stats specialed by
> > > > +        \field{virtio_net_ctrl_queue_stats}.
> > > > +\end{itemize}
> > > > +
> > > > +The device MUST write the requested stats structures in
> > > > +\field{command-specific-data-reply} in the order specified by the
> > > structure
> > > > +virtio_net_ctrl_queue_stats.
> > > > +
> > > > +\drivernormative{\subparagraph}{Device Stats}{Device Types / Netwo=
rk
> > > Device / Device Operation / Control Virtqueue / Device Stats}
> > > > +
> > > > +When a driver tries to obtain a certain stats, it MUST confirm tha=
t the
> > > relevant
> > > > +feature negotiation is successful.
> > > > +
> > > > +\field{type} in struct virtio_net_ctrl_queue_stats MUST correspond=
 to
> > > the vq
> > > > +specified by \field{queue_num}.
> > > > +
> > > > +The \field{command-specific-data-reply} buffer allocated by the dr=
iver
> > > MUST be
> > > > +able to hold all the stats specified by virtio_net_ctrl_queue_stat=
s.
> > > > +
> > > > +When the driver reads the response, it MUST read
> > > > +\field{command-specific-data-reply} one by one based on the
> > > \field{type}.
> > > >
> > > >  \subsubsection{Legacy Interface: Framing Requirements}\label{sec:D=
evice
> > > >  Types / Network Device / Legacy Interface: Framing Requirements}
> > > > --
> > > > 2.31.0
> > > >
> > > >
> > > > -------------------------------------------------------------------=
--
> > > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > > > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.o=
rg
> > > >
> > >
> > >
> >
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

