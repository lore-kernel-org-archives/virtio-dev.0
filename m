Return-Path: <virtio-dev-return-13616-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E3D1C71153
	for <virtio-dev@archiver.kernel.org>; Tue,  5 Sep 2023 03:16:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D21937E90C
	for <virtio-dev@archiver.kernel.org>; Tue,  5 Sep 2023 03:16:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CA4A19864F2
	for <virtio-dev@archiver.kernel.org>; Tue,  5 Sep 2023 03:16:57 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B7589986478; Tue,  5 Sep 2023 03:16:57 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9FF83986410;
	Tue,  5 Sep 2023 03:16:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VrNygx._1693883808;
Message-ID: <1693882549.2640717-1-xuanzhuo@linux.alibaba.com>
Date: Tue, 5 Sep 2023 10:55:49 +0800
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
In-Reply-To: <PH0PR12MB54813CB40389462B1667184ADCE9A@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: RE: [virtio-dev] RE: RE: RE: RE: [PATCH v16] virtio-net: support device stats

On Mon, 4 Sep 2023 12:21:48 +0000, Parav Pandit <parav@nvidia.com> wrote:
> > From: Heng Qi <hengqi@linux.alibaba.com>
> > Sent: Monday, September 4, 2023 4:41 PM
> >
> > =E5=9C=A8 2023/9/4 =E4=B8=8B=E5=8D=886:26, Parav Pandit =E5=86=99=E9=81=
=93:
> > >> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > >> Sent: Monday, September 4, 2023 2:23 PM
> > >
> > >>> "The device MUST NOT pass received packets that exceed mtu (plus low
> > >>> level ethernet header length) size with gso_type NONE or ECN after
> > >> VIRTIO_NET_F_MTU has been successfully negotiated."
> > >>
> > >> NO.
> > >>
> > >> If the mtu is 1500, we can pass 64k packets to the driver with
> > >> gso_type (not NONE).
> > > Any supporting citation to spec for above comment?
> >
> > I think it can be referred here:
> > "The converse features are also available: a driver can save the virtua=
l device
> > some work by negotiating these features. Note: For example, a network p=
acket
> > transported between two guests on the same system might not need
> > checksumming at all, nor segmentation, if both guests are amenable."
> >
> Sure, it can avoid segmentation, but not at the cost of skipping mtu chec=
k.
> For example, sender sends skb with gso with each segment of 9K, and recei=
ver has mtu of 1500, same skb without segmentation is not good.
> Because gso_size should be same as 1500 to match the mtu.

First, for me, I think the size of the each buffer specified by the desc is
irrelated to the gso_size.

And the receiver can set the gso_size to match the MTU.

So the sender can send a gso packet with any segments, any gso_size.
For the receiver, it receives a big packet, it copys to the driver with mul=
tple
buffers, and sets the right gso_size.

Is that right?

Thanks.


> One can say with violation of line " The device MUST NOT pass received pa=
ckets..." things still work fine because guest is amenable. :)
>
> So counter looks ok to me when VIRTIO_NET_F_MTU is not negotiated or when=
 mtu matches.
>
> > >
> > > Each packet must be 1500 for the mtu normative above.
> > > gso_size to <=3D mtu (ingoring the hdr math for simplicity for now).
> > > whole GSO completion can be for 64K to be reported in used_elem.len.
> > >
> > > ---------------------------------------------------------------------
> > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

