Return-Path: <virtio-dev-return-13606-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C50C71153
	for <virtio-dev@archiver.kernel.org>; Mon,  4 Sep 2023 07:50:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2B2BD2A8E8
	for <virtio-dev@archiver.kernel.org>; Mon,  4 Sep 2023 07:50:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A0EE798669B
	for <virtio-dev@archiver.kernel.org>; Mon,  4 Sep 2023 07:50:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 30AA19863BC; Mon,  4 Sep 2023 07:50:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E76F79863B7;
	Mon,  4 Sep 2023 07:48:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VrGsz5n_1693813734;
Message-ID: <1693813589.9653811-2-xuanzhuo@linux.alibaba.com>
Date: Mon, 4 Sep 2023 15:46:29 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 David Edmondson <david.edmondson@oracle.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 Parav Pandit <parav@nvidia.com>
References: <20230830055239.10680-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB54819EB466305284A8C9F649DCE4A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230901103735-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230901103735-mutt-send-email-mst@kernel.org>
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v16] virtio-net: support device stats

On Fri, 1 Sep 2023 10:45:24 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Fri, Sep 01, 2023 at 01:58:32PM +0000, Parav Pandit wrote:
> >
> >
> > > From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > Sent: Wednesday, August 30, 2023 11:23 AM
> > > To: virtio-dev@lists.oasis-open.org
> > > Cc: jasowang@redhat.com; Michael S. Tsirkin <mst@redhat.com>; Parav Pandit
> > > <parav@nvidia.com>; David Edmondson <david.edmondson@oracle.com>;
> > > virtio-comment@lists.oasis-open.org
> >
> > We should be following [1].
> > Virtio list for conducting technical committee work, which is this patch.
> > And to get feedback from community virtio-comment list, which you already CCed.
> >
> > So virtio-dev should be replaced with virtio list because this patch is about developing the virtio spec itself, (not implementing the spec in device/driver etc).
> >
> > [1] https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=virtio#feedback
>
>
> No, virtio-comment was already CC'd, and I think it's the best list for
> comments (this is how we classify patches, technically) since anyone can subscribe
> to that one.
>
> We use virtio mostly for discussion about release schedules, voting,
> bylaws and other issues not of interest to TC non members.
>
>
> Removing virtio-dev is a good idea, copying both is really not necessary.
>
> ...
>
> > > +    \item [rx_drop_busy]
> > > +        This is the number of packets dropped by the device when the device is
> > > +        busy.
> > > +
> > I think the busy counter does not belong to busy category as it is slightly difficult to define.
> > Lets please move to different category.
>
> Or better define it better. What does "busy" mean? I suspect basically
> our of internal resources?
> > > +    \item [rx_csum_bad]
> > > +        The number of packets with abnormal csum.
> > s/abnormal/wrong
> >
> > no strong opinion though.
>
> checsum mismatch.
> avoid abbreviation
>
>
> > > +
> > > +\end{description}
> > > +
> > > +\subparagraph{Transmitq CSUM Statistic}\label{sec:Device Types /
> > > +Network Device / Device Operation / Control Virtqueue / Device
> > > +Statistic / Transmitq CSUM Statistic}
> > > +
> > > +The structure corresponding to the transmitq csum statistics is
> > > virtio_net_stats_tx_csum.
> > > +The corresponding type is VIRTIO_NET_STATS_TYPE_TX_CSUM. This is for the
> > > transmitq.
> > > +
> > > +Only after the VIRTIO_NET_F_CSUM is negotiated, the transmitq csum
> > > +statistics can be obtained.
> > > +
> > > +The following are the transmitq csum statistics:
> > > +
> > > +\begin{lstlisting}
> > > +struct virtio_net_stats_tx_csum {
> > > +    struct virtio_net_stats_reply_hdr hdr;
> > > +
> > > +    le64 tx_csum_none;
> > > +    le64 tx_needs_csum;
> > > +};
> > > +\end{lstlisting}
> > > +
> > > +The packets described below are all from a specific virtqueue.
> > > +\begin{description}
> > > +    \item [tx_csum_none]
> > > +        The number of packets which didn't require hardware csum.
> > > +
> > The number of packets which requires checksum calculation by the device.
>
> which require - it's not the number that requires checksum it's the
> packets that require it.
>
> ...
>
> > > +The device has the allowance for the speed. If
> > > +VIRTIO_NET_F_SPEED_DUPLEX has been negotiated, the driver can get this by
> > > \field{speed}.
> > > +When the real speed exceeds the speed allowance, some packets will be
> > > +dropped by the device.
> > > +
> > Above description regarding "real speed" is confusing.
> > I think you wanted to say,
> >
> > When the received packets rate exceeds the negotiated speed, some packets may be dropped by the device.
>
> negotiated how?
>
> yes, I don't understand what this does, either.

Sorry, please ignore the "negotiated".

I want to express the speed transmitted through "speed".

If the speed exceeds this value, there may be some drops in the device. Either
tx or rx. This is used to count these drops.


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

