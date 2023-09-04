Return-Path: <virtio-dev-return-13608-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69971C83F2C
	for <virtio-dev@archiver.kernel.org>; Mon,  4 Sep 2023 08:03:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 361F070FED
	for <virtio-dev@archiver.kernel.org>; Mon,  4 Sep 2023 08:03:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2F5CA98649D
	for <virtio-dev@archiver.kernel.org>; Mon,  4 Sep 2023 08:03:47 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 242AB983E4F; Mon,  4 Sep 2023 08:03:47 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 11E999863B7;
	Mon,  4 Sep 2023 08:03:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VrGxDjI_1693814618;
Message-ID: <1693814534.4663684-3-xuanzhuo@linux.alibaba.com>
Date: Mon, 4 Sep 2023 16:02:14 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Edmondson <david.edmondson@oracle.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
References: <20230830055239.10680-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB54819EB466305284A8C9F649DCE4A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1693812824.959417-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481859AEB22FDDFCDA9D57FDCE9A@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481859AEB22FDDFCDA9D57FDCE9A@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: [virtio-dev] Re: RE: RE: [PATCH v16] virtio-net: support device stats

On Mon, 4 Sep 2023 08:00:36 +0000, Parav Pandit <parav@nvidia.com> wrote:
>
> > From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Sent: Monday, September 4, 2023 1:04 PM
>
> > > > +If one or more of the VIRTIO_NET_F_GUEST_TSO4,
> > > > VIRTIO_NET_F_GUEST_TSO6,
> > > > +or VIRTIO_NET_F_GUEST_UFO have been negotiated, the receiveq GSO
> > > > +statistics can be obtained.
> > > > +
> > > UFO is deprecated feature in the OS that supported it.
> > > And unlikely to be used in any new OS.
> > > So I think one should drop the UFO for now from above.
> >
> > But, the virtio spec supports it. So I think we should include it here.
> >
> UFO and receive GSO is bit different.
> And UFO has near to zero use.
> So if this is really needed, one can implement such counter later when UFO is actually implemented and used.


I agree.


>
> > > > +\begin{description}
> > > > +    \item [tx_gso_packets]
> > > > +        The number of the GSO packets sent by device that are not cut to
> > small
> > > > +        packets.
> > > > +
> > > Above is a strange counter.
> > > Do you have an example of it along with _split counter below?
> > > I am probably misunderstanding it.
> >
> > On one host, a vm can send a gso packet without cutting to other vm.
> >
> Do you mean some sw entity has sent the GSO packet directly such as 64KB SKB without creating segments?

YES.


> If so, how will the receive device can receive such large packet when the posted buffer is not worth the 64KB size?

The virtio-net merge mode.

>
> > >
> > > > +    \item [tx_gso_bytes]
> > > > +        The bytes of the GSO packets sent by device that are not cut to small
> > > > +        packets.
> > > > +
> > > > +    \item [tx_gso_packets_split]
> > > > +        The number of the GSO packets that been cut into small packets.
> > > > +
> > > Which has been cut into small packets.
> > >
> > > > +    \item [tx_gso_bytes_split]
> > > > +        The bytes of the GSO packets that been cut into small packets.
> > > > +
> > > > +    \item [tx_gso_segments]
> > > > +        The number of segments separated from the GSO packets.
> > > > +
> > > > +    \item [tx_gso_segments_bytes]
> > > > +        The bytes of segments separated from the GSO packets.
> > > > +\end{description}
> > > > +
> > > > +\subparagraph{Receiveq Speed Statistic}\label{sec:Device Types /
> > > > +Network Device / Device Operation / Control Virtqueue / Device
> > > > +Statistic / Receiveq Speed Statistic}
> > > > +
> > > > +The structure corresponding to the receiveq speed statistics is
> > > > virtio_net_stats_rx_speed.
> > > > +The corresponding type is VIRTIO_NET_STATS_TYPE_RX_SPEED. This is
> > > > +for the receiveq.
> > > > +
> > > > +The device has the allowance for the speed. If
> > > > +VIRTIO_NET_F_SPEED_DUPLEX has been negotiated, the driver can get
> > > > +this by
> > > > \field{speed}.
> > > > +When the real speed exceeds the speed allowance, some packets will
> > > > +be dropped by the device.
> > > > +
> > > Above description regarding "real speed" is confusing.
> > > I think you wanted to say,
> > >
> > > When the received packets rate exceeds the negotiated speed, some packets
> > may be dropped by the device.
> > >
> > > > +\begin{lstlisting}
> > > > +struct virtio_net_stats_rx_speed {
> > > > +    struct virtio_net_stats_reply_hdr hdr;
> > > > +
> > > > +    le64 rx_packets_allowance_exceeded;
> > > > +    le64 rx_bytes_allowance_exceeded; }; \end{lstlisting}
> > > > +
> > > > +The packets described below were all presented on the specified virtqueue.
> > > > +\begin{description}
> > > > +    \item [rx_packets_allowance_exceeded]
> > > > +        The number of the packets dropped by device due to the real speed
> > > > +        exceeding the speed allowance.
> > > > +
> > > Similar rewording like above to drop "real".
> > >
> > > > +    \item [rx_bytes_allowance_exceeded]
> > > > +        The bytes of the packets dropped by device due to the real speed
> > > > +        exceeding the speed allowance.
> > > > +
> > > > +\end{description}
> > > > +
> > > > +\subparagraph{Transmitq Speed Statistic}\label{sec:Device Types /
> > > > +Network Device / Device Operation / Control Virtqueue / Device
> > > > +Statistic / Transmitq Speed Statistic}
> > > > +
> > > > +The structure corresponding to the transmitq speed statistics is
> > > > +virtio_net_stats_tx_speed. The corresponding type is
> > > > +VIRTIO_NET_STATS_TYPE_TX_SPEED. This is for the transmitq.
> > > > +
> > > > +The device has the allowance for the speed. If
> > > > +VIRTIO_NET_F_SPEED_DUPLEX has been negotiated, the driver can get
> > > > +this by
> > > > \field{speed}.
> > > > +When the real speed exceeds the speed allowance, some packets will
> > > > +be dropped by the device.
> > > > +
> > > > +\begin{lstlisting}
> > > > +struct virtio_net_stats_tx_speed {
> > > > +    struct virtio_net_stats_reply_hdr hdr;
> > > > +
> > > > +    le64 tx_packets_allowance_exceeded;
> > > > +    le64 tx_bytes_allowance_exceeded; }; \end{lstlisting}
> > > > +
> > > > +The packets described below were all presented on the specified virtqueue.
> > > > +\begin{description}
> > > > +    \item [tx_packets_allowance_exceeded]
> > > > +        The number of the packets dropped by device due to the real speed
> > > > +        exceeding the speed allowance.
> > > > +
> > > > +    \item [tx_bytes_allowance_exceeded]
> > > > +        The bytes of the packets dropped by device due to the real speed
> > > > +        exceeding the speed allowance.
> > > > +
> > > > +\end{description}
> > > > +
> > > > +\devicenormative{\subparagraph}{Device Statistic}{Device Types /
> > > > +Network Device / Device Operation / Control Virtqueue / Device
> > > > +Statistic} The device MUST replies to the command
> > > > +VIRTIO_NET_CTRL_STATS_QUERY with the struct
> > virtio_net_stats_capabilities.
> > > > \field{supported_stats_types} includes all the statistic types
> > > > supported by the device.
> > > > +
> > > > +If virtio_net_ctrl_queue_stats is incorrect (such as the
> > > > +following), the device MUST set \field{ack} to VIRTIO_NET_ERR. Even
> > > > +if there is only one error, the device MUST fail the entire command.
> > > > +\begin{itemize}
> > > > +    \item \field{vq_index} exceeds the queue range.
> > > > +    \item \field{types_bitmap} contains unknown types.
> > > > +    \item One or more of the bits present in \field{types_bitmap} is not valid
> > > > +        for the specified virtqueue.
> > > > +    \item The feature corresponding to the specified \field{types_bitmap}
> > was
> > > > +        not negotiated.
> > > > +    \item The size of the buffer allocated by the driver for
> > > > +\field{command-
> > > > specific-result}
> > > > +        is less than the total size of the statistics specialed by
> > > > +        \field{virtio_net_ctrl_queue_stats}.
> > > > +\end{itemize}
> > > > +
> > > > +The device MUST write the requested statistic structures in
> > > s/statistic/statistics
> > >
> > > > +\field{command-specific-result} in the order specified by the
> > > > +structure virtio_net_ctrl_queue_stats. If the \field{types_bitmap}
> > > > +indicates
> > > Use \field{..}
> > >
> > > > +multiple statistics, the replies order by the type value from small to large.
> > > > +
> > > These replies are ordered by the type value from small to large.
> > > I am not sure device needs to order them.
> >
> > Now, the hdr of statistics has the type field.
> >
> > We can remove this.
> >
> We still need the type field, just need to remove the ordering need.


Yes. I think so.

Thanks.



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

