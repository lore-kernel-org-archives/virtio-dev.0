Return-Path: <virtio-dev-return-13584-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131E5C83F12
	for <virtio-dev@archiver.kernel.org>; Tue, 29 Aug 2023 07:20:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8E4E67A1AF
	for <virtio-dev@archiver.kernel.org>; Tue, 29 Aug 2023 07:20:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0B25098665E
	for <virtio-dev@archiver.kernel.org>; Tue, 29 Aug 2023 07:20:30 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 61AF79863BE; Tue, 29 Aug 2023 07:20:29 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8D4389863BD;
	Tue, 29 Aug 2023 07:19:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VqqNGEf_1693293547;
Message-ID: <1693293460.1621294-1-xuanzhuo@linux.alibaba.com>
Date: Tue, 29 Aug 2023 15:17:40 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Edmondson <david.edmondson@oracle.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
References: <20230821064258.20608-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB54814174FC713CF5640B7B10DC1DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1693279777.37882-2-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB548154BAE90B3F4A24175060DCE7A@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB548154BAE90B3F4A24175060DCE7A@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: [virtio-dev] Re: [virtio-comment] RE: RE: [PATCH v15] virtio-net: support device stats

On Tue, 29 Aug 2023 06:51:20 +0000, Parav Pandit <parav@nvidia.com> wrote:
>
>
> > From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Sent: Tuesday, August 29, 2023 9:00 AM
>
> > > Its over cvq, so lets do,
> > >
> > > s/channel/virtqueue
> > >
> > > Please rename
> > > s/command-specific-data-reply/command_specific_result
> >
> >
> > I agree.
> >
> > But it will be "command-specific-result" for alignment with 'command-specific-
> > data'.
> >
> Right.
>
> > > > There is little the driver can do
> > > > +except issue a diagnostic if \field{ack} is not VIRTIO_NET_OK.
> > > > +
> > > May be driver can retry the command, put to error state, issue diagnostics,
> > ignore the error.
> > > So There is no need to mention what driver can/cannot do, so please just
> > drop the last line.
> >
> > This is not new. It turns out that there is this line.
> >
> :(
> I see it now.
>
> > I think, if you want to remove this, you should post a new patch.
> >
> It will be separate patch.
>
> > >
> > > > +The command VIRTIO_NET_CTRL_STATS_GET contains \field{command-
> > > > specific-data-reply}.
> > > >
> > > >  \paragraph{Packet Receive Filtering}\label{sec:Device Types /
> > > > Network Device / Device Operation / Control Virtqueue / Packet
> > > > Receive Filtering} \label{sec:Device Types / Network Device / Device
> > > > Operation / Control Virtqueue / Setting Promiscuous Mode}%old label
> > > > for latexdiff @@ -1805,6
> > > > +1811,424 @@ \subsubsection{Control Virtqueue}\label{sec:Device
> > > > +Types /
> > > > Network Device / Devi
> > > >
> > > >  Upon reset, a device MUST initialize all coalescing parameters to 0.
> > > >
> > > > +\paragraph{Device Statistic}\label{sec:Device Types / Network
> > > > +Device / Device Operation / Control Virtqueue / Device Statistic}
> > > > +
> > > > +If the VIRTIO_NET_F_DEVICE_STATS feature is negotiated, the driver
> > > > +can obtain device stats from the device by using the following command.
> > > > +
> > > s/device stats/device statistics at above and throughout many places below.
> > > in the spec wording, better to not shorten them.
> > >
>
> > > > +Different types of virtqueues have different stats. The stats of
> > > > +the receiveq are different from those of the transmitq.
> > > > +
> > > > +The stats of a certain type of virtqueue are also divided into
> > > > +multiple types because different types require different features.
> > > > +This enables the expansion of new stats.
> > > > +
> > > > +At one time, the driver can obtain the stats of one or multiple virtqueues.
> > > May be
> > > s/At one time/In one command
> > > This is to be more accurate, otherwise in one time we miss the notion of
> > command.
>
> > >
> > > > +Additionally, the driver can obtain multiple type stats of each virtqueue.
> > > > +
> > > > +\begin{lstlisting}
> > > > +#define VIRTIO_NET_CTRL_STATS         7
> > > > +#define VIRTIO_NET_CTRL_STATS_QUERY   0
> > > > +#define VIRTIO_NET_CTRL_STATS_GET     1
> > > > +\end{lstlisting}
> > > > +
> > > > +To obtain device stats, use the VIRTIO_NET_CTRL_STATS_GET command
> > > > +with the \field{command-specific-data} containing the
> > > > +virtio_net_ctrl_queue_stats structure. The result is returned in
> > > > +the
> > > > \field{command-specific-data-reply}.
> > > > +
> > > We opted for slightly different wording for describing command specific data
> > and results in aq.
> > > So lets align it here.
> > > Please reword above as,
> > > The \field{command-specific-data} is in the format of \field{ struct
> > virtio_net_ctrl_queue_stats}.
> > >
> > > When the command completes successfully, \field{command_specific_result}
> > is in the format of \field{struct virtio_net_stats_capabilites}.
> > >
> > > > +The following structure is used in \field{command-specific-data}:
> > > > +\begin{lstlisting}
> > > > +struct virtio_net_ctrl_queue_stats {
> > > > +       struct {
> > > > +           le16 vq_index;
> > > > +           le16 padding[3];
> > > > +           le64 types[1];
> > > > +       } stats[];
> > > > +};
> > > > +\end{lstlisting}
> > > > +
> > > > +The following structures are used in \field{command-specific-data-reply}:
> > > > +\begin{lstlisting}
> > > > +struct virtio_net_stats_capabilites {
> > > > +
> > > > +#define VIRTIO_NET_STATS_TYPE_CVQ       (1 << 0)
> > > > +#define VIRTIO_NET_STATS_TYPE_RX_BASIC  (1 << 1)
> > > > +#define VIRTIO_NET_STATS_TYPE_RX_CSUM   (1 << 2)
> > > > +#define VIRTIO_NET_STATS_TYPE_RX_GSO    (1 << 3)
> > > > +#define VIRTIO_NET_STATS_TYPE_TX_BASIC  (1 << 4)
> > > > +#define VIRTIO_NET_STATS_TYPE_TX_CSUM   (1 << 5)
> > > > +#define VIRTIO_NET_STATS_TYPE_TX_GSO    (1 << 6)
> > > > +    le64 supported_stats_types[1];
> > > > +}
> > > > +
> > > It would be best to split the command and description into two. One for the
> > capabilities bit map.
> > > And second for the actual stats header.
> > > This avoids the mix up between the two.
> > >
> > > > +struct virtio_net_stats_reply_hdr {
> > > > +    le16 size;
> > > > +    le16 vq_index;
> > > > +
> > > > +#define VIRTIO_NET_STATS_TYPE_REPLY_CVQ       0
> > > > +#define VIRTIO_NET_STATS_TYPE_REPLY_RX_BASIC  1
> > > > +#define VIRTIO_NET_STATS_TYPE_REPLY_RX_CSUM   2
> > > > +#define VIRTIO_NET_STATS_TYPE_REPLY_RX_GSO    3
> > > > +#define VIRTIO_NET_STATS_TYPE_REPLY_TX_BASIC  4
> > > > +#define VIRTIO_NET_STATS_TYPE_REPLY_TX_CSUM   5
> > > > +#define VIRTIO_NET_STATS_TYPE_REPLY_TX_GSO    6
> > > > +    u8 type;
> > > If the query command input has it, we likely don't need it in the response.
> >
> > YES.
> >
> > But the driver may need to handle multiple reply stats. I think that will be easy
> > for the driver to handle so many stats with the vq_index and type.
> >
> Do you mean one command result returns multiple stats in one response?
> And if so, and the types in the _data is bitmap, better to rename it as types_bmap or types_bitmap.

OK.

>
> > > > +    \item [rx_drop_busy]
> > > > +        This is the number of packets dropped by the device when the device
> > is
> > > > +        busy.
> > > > +
> > > I feel this is bit abstract counter and qualify the device as busy is tricky. Lets
> > move it out of the basic counter.
> >
> > I will rethink about this.
> >
> Ok.
>
> > > We need to add the capabilities and query them from the AQ too.
> > > If the reply header structure and actual stats are split properly, it will be easy
> > to add the query by the owner device.
> >
> > YES. I agree.
> >
> > But I would to know is there some specific requirements?
> >
> Not sure I understand the question.
> We have this requirement in the requirements document of 1.4 at [1].
>
> [1] https://lists.oasis-open.org/archives/virtio-comment/202308/msg00260.html

For this line:
 "If the reply header structure and actual stats are split properly, it will be easy
  to add the query by the owner device."

So for the header structure, is there some specific requirements?

Thanks.


>
>
>
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
>
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
>
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

