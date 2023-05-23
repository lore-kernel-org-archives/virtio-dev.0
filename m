Return-Path: <virtio-dev-return-12787-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5975C7EE26
	for <virtio-dev@archiver.kernel.org>; Tue, 23 May 2023 09:18:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1A483330A6
	for <virtio-dev@archiver.kernel.org>; Tue, 23 May 2023 09:18:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 100DE9863FC
	for <virtio-dev@archiver.kernel.org>; Tue, 23 May 2023 09:18:30 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 032069863BA; Tue, 23 May 2023 09:18:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E2EBB9863B3;
	Tue, 23 May 2023 09:18:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VjJYylt_1684833500;
Date: Tue, 23 May 2023 17:18:20 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org,
	Jason Wang <jasowang@redhat.com>, Parav Pandit <parav@nvidia.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230523091820.GC23504@h68b04307.sqa.eu95>
References: <20230522121200.40939-1-hengqi@linux.alibaba.com>
 <20230522150743-mutt-send-email-mst@kernel.org>
 <20230523024118.GA23504@h68b04307.sqa.eu95>
 <20230523024057-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523024057-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Subject: Re: [virtio-dev] Re: [Proposal] Relationship between XDP and rx-csum
 in virtio-net

On Tue, May 23, 2023 at 03:15:37AM -0400, Michael S. Tsirkin wrote:
> On Tue, May 23, 2023 at 10:41:18AM +0800, Heng Qi wrote:
> > On Mon, May 22, 2023 at 03:10:05PM -0400, Michael S. Tsirkin wrote:
> > > On Mon, May 22, 2023 at 08:12:00PM +0800, Heng Qi wrote:
> > > > 1) Add a feature bit to the virtio specification to tell the sender that a fully
> > > > csumed packet must be sent.
> > > 
> > > Who is the sender in this picture? The driver?
> > 
> > The device or the driver.
> > 
> > When the device is hw, the sender is more likely to be a device.
> > When the device is sw, the sender can be a device or a driver.
> >
> > But in general, this feature is inclined to constrain the behavior of the device and
> > the driver from the receiving side.
> 
> Based on above I am guessing you are talking about driver getting
> packets from device, I wish you used terms from virtio spec.

Yes, I'm going to use the terminology of the virtio spec.

> 
> > For example: 
> > VIRTIO_NET_F_UNNECESSARY_CSUM : The driver tells the device that you must send me a fully csumed packet.
> > 
> > Then the specific implementation can be
> > 
> > (1) the sender sends a fully csumed packet;
> > (2) the receiver receives a CHECKSUM_PARTIAL packet, and the device helps calculate the fully csum
> >     (because the two parties in the communication are located on the same host, the packet is trusted.).
> > 
> > In summary, if VIRTIO_NET_F_UNNECESSARY_CSUM is negotiated, the driver will no longer receive any packets marked CHECKSUM_PARTIAL.
> > 
> > Thanks.
> 
> This is what clearing VIRTIO_NET_F_GUEST_CSUM does.

Yes, but with VIRTIO_NET_F_GUEST_CSUM cleared, although the device can
receive a fully checksummed packet, we can no longer enjoy
the device's ability to validate the packet checksum. That is, the value
of \field{flags} in the virtio_net_hdr structure is set to 0, which means
that the packet received by the driver will not be marked as
VIRTIO_NET_HDR_F_DATA_VALID.

So, we need a feature bit (let's say VIRTIO_NET_F_UNNECESSARY_CSUM).
If VIRTIO_NET_F_UNNECESSARY_CSUM is negotiated, the device must give the
driver a fully checksummed packet, and the packet is validated by the
device with \field{flags} set to VIRTIO_NET_HDR_F_DATA_VALID.

> 
> I feel you are trying to say that clearing VIRTIO_NET_F_GUEST_CSUM
> disables all offloads but you want to keep some of them?
> 

No, what I mean is that a feature VIRTIO_NET_F_UNNECESSARY_CSUM is needed
in addition to VIRTIO_NET_F_GUEST_CSUM, if both features are negotiated,
then the driver may always receive packets marked as
VIRTIO_NET_HDR_F_DATA_VALID, which means that we can now load XDP at the
same time.

> Again please use virtio terminology not Linux. to help you out,
> in current linux, VIRTIO_NET_HDR_F_NEEDS_CSUM and VIRTIO_NET_HDR_F_DATA_VALID
> will set CHECKSUM_PARTIAL and CHECKSUM_UNNECESSARY respectively.
> 

Sure. Will do as you suggested.

Thanks.

> 
> -- 
> MST
> 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

