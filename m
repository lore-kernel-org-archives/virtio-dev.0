Return-Path: <virtio-dev-return-13618-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ECDDC83F3E
	for <virtio-dev@archiver.kernel.org>; Tue,  5 Sep 2023 06:48:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 396DB21686
	for <virtio-dev@archiver.kernel.org>; Tue,  5 Sep 2023 06:48:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1F8DA9864B8
	for <virtio-dev@archiver.kernel.org>; Tue,  5 Sep 2023 06:48:43 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0F804983E51; Tue,  5 Sep 2023 06:48:43 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F034F986410;
	Tue,  5 Sep 2023 06:48:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VrOus4A_1693896516;
Message-ID: <1693896141.8898118-1-xuanzhuo@linux.alibaba.com>
Date: Tue, 5 Sep 2023 14:42:21 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Edmondson <david.edmondson@oracle.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 Heng Qi <hengqi@linux.alibaba.com>
References: <20230830055239.10680-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB54819EB466305284A8C9F649DCE4A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1693812824.959417-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481859AEB22FDDFCDA9D57FDCE9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1693814534.4663684-3-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB548167EDE78C3B7C00014D2CDCE9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1693817561.0941262-4-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB54812E119F4F042F78B95150DCE9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <526c4582-3521-45ad-afae-8d7e281b5f38@linux.alibaba.com>
 <PH0PR12MB54813CB40389462B1667184ADCE9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1693882549.2640717-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB548108B8FB8E60E9A9502C5BDCE8A@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB548108B8FB8E60E9A9502C5BDCE8A@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: Re: RE: RE: [virtio-dev] RE: RE: RE: RE: [PATCH v16] virtio-net: support device stats

On Tue, 5 Sep 2023 03:31:41 +0000, Parav Pandit <parav@nvidia.com> wrote:
>
>
> > From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Sent: Tuesday, September 5, 2023 8:26 AM
>
> > > Sure, it can avoid segmentation, but not at the cost of skipping mtu check.
> > > For example, sender sends skb with gso with each segment of 9K, and receiver
> > has mtu of 1500, same skb without segmentation is not good.
> > > Because gso_size should be same as 1500 to match the mtu.
> >
> > First, for me, I think the size of the each buffer specified by the desc is irrelated
> > to the gso_size.
> >
> > And the receiver can set the gso_size to match the MTU.
> >
> > So the sender can send a gso packet with any segments, any gso_size.
> > For the receiver, it receives a big packet, it copys to the driver with multple
> > buffers, and sets the right gso_size.
> >
> > Is that right?
>
> Right.
> By definition of GSO it is segmented.
> Soi counters should be for the segmented.
> And for special case of "Note", there should be separate counter to indicate GSO was requested_but_not_done.


I agree. So the new version should be:

+\begin{description}
+    \item [tx_gso_packets]
+        The number of the GSO packets sent by the device.
+
+    \item [tx_gso_bytes]
+        The bytes of the GSO packets sent by the device.
+
+    \item [tx_gso_segments]
+        The number of segments cutted from GSO packets.
+
+    \item [tx_gso_segments_bytes]
+        The bytes of segments cutted from GSO packets.

+    \item [tx_gso_packets_nocut]
+        The number of the GSO packets which are not cut into segments.
+
+    \item [tx_gso_bytes_nocut]
+        The bytes of the GSO packets which are not cut into segments.
+
+\end{description}


Thanks.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

