Return-Path: <virtio-dev-return-13441-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3BC4C00528
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 11:07:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0DB2268471
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 11:07:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EB4C49866C1
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 11:07:02 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DF2669866AE; Thu,  3 Aug 2023 11:07:02 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CE17F9866B1;
	Thu,  3 Aug 2023 11:07:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Voygi7S_1691060816;
Message-ID: <1691060755.2124963-3-xuanzhuo@linux.alibaba.com>
Date: Thu, 3 Aug 2023 19:05:55 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
References: <20230803083150.46745-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481B976E62998B8B61267C8DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481B976E62998B8B61267C8DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: [virtio-dev] Re: RE: [RFC] virtio-net: support access and control the member devices

On Thu, 3 Aug 2023 10:23:32 +0000, Parav Pandit <parav@nvidia.com> wrote:
>
> > From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Sent: Thursday, August 3, 2023 2:02 PM
> > To: virtio-dev@lists.oasis-open.org
> > Cc: jasowang@redhat.com; Michael S. Tsirkin <mst@redhat.com>; Parav Pandit
> > <parav@nvidia.com>; virtio-comment@lists.oasis-open.org
> > Subject: [RFC] virtio-net: support access and control the member devices
> >
> > Now we have the concept of the device group. This allows us to support sr-iov
> > and siov more conveniently.
> >
> > The following description uses pf, vf as an example. The scene with sf should be
> > similar.
> >
> > According to my understanding, the management at the level of virtqueue
> > should be handled by admin queue. And the net related management is still
> > managed by cvq of pf. So this patch works with the cvq of the pf.
> >
> Admin command is preferred
>
> > The problem I am trying to solve is when there are multiple vf virtio-net devices
> > under one pf.
> > It is necessary for administrators to query the status and information of each vf
> > and configure mac.
> This patch enables to configure also, please add it in the commit log.
>
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  device-types/net/description.tex        | 72 +++++++++++++++++++++++--
> >  device-types/net/device-conformance.tex |  1 +
> >  2 files changed, 70 insertions(+), 3 deletions(-)
> >
> > diff --git a/device-types/net/description.tex b/device-types/net/description.tex
> > index 76585b0..1494a18 100644
> > --- a/device-types/net/description.tex
> > +++ b/device-types/net/description.tex
> > @@ -88,6 +88,9 @@ \subsection{Feature bits}\label{sec:Device Types /
> > Network Device / Feature bits  \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set
> > MAC address through control
> >      channel.
> >
> > +\item[VIRTIO_NET_F_ACCESS_MEMBER_DEVICE(51)] Device can access and
> > control the
> > +    member devices.
> > +
> Once admin command is used, patch will be simpler without new feature bit.
>
> >  \item[VIRTIO_NET_F_HASH_TUNNEL(51)] Device supports inner header hash
> > for encapsulated packets.
> >
> >  \item[VIRTIO_NET_F_VQ_NOTF_COAL(52)] Device supports virtqueue
> > notification coalescing.
> > @@ -1156,6 +1159,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device
> > Types / Network Device / Devi
> >          u8 command;
> >          u8 command-specific-data[];
> >          u8 ack;
> > +        u8 command-specific-data-reply[];
> >  };
> >
> >  /* ack values */
> > @@ -1164,9 +1168,11 @@ \subsubsection{Control Virtqueue}\label{sec:Device
> > Types / Network Device / Devi  \end{lstlisting}
> >
> >  The \field{class}, \field{command} and command-specific-data are set by the -
> > driver, and the device sets the \field{ack} byte. There is little it can -do except
> > issue a diagnostic if \field{ack} is not -VIRTIO_NET_OK.
> > +driver, and the device sets the \field{ack} byte and optionally
> > +\field{command-specific-data-reply}. There is little the driver can do
> > +except issue a diagnostic if \field{ack} is not VIRTIO_NET_OK.
> > +
> > +The command VIRTIO_NET_CTRL_MEMBER_GET_INFO contains
> > \field{command-specific-data-reply}.
> >
> >  \paragraph{Packet Receive Filtering}\label{sec:Device Types / Network Device
> > / Device Operation / Control Virtqueue / Packet Receive Filtering}
> > \label{sec:Device Types / Network Device / Device Operation / Control
> > Virtqueue / Setting Promiscuous Mode}%old label for latexdiff @@ -1805,6
> > +1811,66 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types /
> > Network Device / Devi
> >
> >  Upon reset, a device MUST initialize all coalescing parameters to 0.
> >
> > +\paragraph{Member Device}\label{sec:Device Types / Network Device /
> > +Device Operation / Control Virtqueue / Member Info}
> > +
> > +If a deivce is the own deivce inside one device group and the feature
> > +VIRTIO_NET_F_ACCESS_MEMBER_DEVICE is negotiated, the own driver can
> > +obtain the info and change the configuration of the member devices of
> > +this device group.
> > +
> > +\begin{lstlisting}
> > +struct virtio_net_ctrl_member {
> > +        le64 group_member_id;
> > +};
> > +
> > +struct virtio_net_ctrl_member_info_reply {
> We need a bitmap to indicate which fields are valid.
> We did a nice work of it in vdpa tool to describe both, the fields and bitmap.
>
> Also, when you change to admin command, please change suffix to from _reply to _result to align to its terminology.


OK.


>
> > +        u8 mac[6];
> > +        le16 status;
> > +        le16 max_virtqueue_pairs;
> > +        le16 mtu;
> > +        le32 speed;
> > +        u8 duplex;
>
> We should above split constant config space fields and below run time fields meant for debug purpose.
> We are working on the member device migration proposal and below fields belong to "device context" should be available through such separate command.
> But if you do it before, please cover the whole device state and we will be able to reuse for multiple use-cases.


I am not sure I got fully.

I will try.

Thanks.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

