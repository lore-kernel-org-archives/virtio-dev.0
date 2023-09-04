Return-Path: <virtio-dev-return-13614-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E82C83F2C
	for <virtio-dev@archiver.kernel.org>; Mon,  4 Sep 2023 13:28:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B2FD87B169
	for <virtio-dev@archiver.kernel.org>; Mon,  4 Sep 2023 13:28:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 99366986495
	for <virtio-dev@archiver.kernel.org>; Mon,  4 Sep 2023 13:28:30 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7FCEC9863B7; Mon,  4 Sep 2023 13:28:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 707669863BC
	for <virtio-dev@lists.oasis-open.org>; Mon,  4 Sep 2023 13:28:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: SzvhZ_TgMoWg3gis8MiKjg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693834107; x=1694438907;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fUkf4fGAnKTqeglOoSwXJeky/KI8L0jiWHNoQIXwHTo=;
        b=MpKvDKWTRhN4qEN/K577ECTJwcmpgPF1/fWOcV5SWIgLuTSOgP86CkAN9FUejF5vw4
         EiOwAN62U84yF5BZCRUdYjqEYgTA036GGwo213DK5YZGdckwG5Z/dVfxQRrHymNbS4lq
         cy/vGQfZ4TB0nFoLo8bFU7Q9nFGBotRidV7CyzNGcEy+LoJzoIwt7cqx1Tj9Mz4zpYzv
         a0lwzV6RtQNY6bt+OAl7vMsHuPbD3T7oh/eFHJaz8ZoR8N4X8y5U78utix9wQNb5oisy
         V2YyISBR3G4xVmg5fowA2kJE0GwminVxsZ/q4Fc22IYfTW9c4Fn8vJi6MLjkeQEWr+Dr
         +0jA==
X-Gm-Message-State: AOJu0YxMufntCrfL6JMsagLS3KlGdTjyHK/YljID6tp5IHUG9fCVZP2D
	AvCQkATaR1lXctPLGu0LwLg11CAMgM3ahz5MjhvsiIJ8hpAUVM+v7fO5E6f80g+bonyR/ucN104
	RjxVkHS+/E0ipy8mS5keZmJeRqZanY6mhuI8N
X-Received: by 2002:a17:906:5346:b0:9a1:d67c:b4f2 with SMTP id j6-20020a170906534600b009a1d67cb4f2mr6416428ejo.77.1693834107202;
        Mon, 04 Sep 2023 06:28:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbftJ0XCz+7p5sTjwo1rCmr4ScJQWf7xrgzTRxq3eF5Ad+ORrrpPKcbtuHn9SrP/SdQGnyhQ==
X-Received: by 2002:a17:906:5346:b0:9a1:d67c:b4f2 with SMTP id j6-20020a170906534600b009a1d67cb4f2mr6416414ejo.77.1693834106852;
        Mon, 04 Sep 2023 06:28:26 -0700 (PDT)
Date: Mon, 4 Sep 2023 09:28:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	David Edmondson <david.edmondson@oracle.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230904092711-mutt-send-email-mst@kernel.org>
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
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54813CB40389462B1667184ADCE9A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] RE: RE: RE: RE: [PATCH v16] virtio-net: support
 device stats

On Mon, Sep 04, 2023 at 12:21:48PM +0000, Parav Pandit wrote:
> > From: Heng Qi <hengqi@linux.alibaba.com>
> > Sent: Monday, September 4, 2023 4:41 PM
> > 
> > 在 2023/9/4 下午6:26, Parav Pandit 写道:
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
> > "The converse features are also available: a driver can save the virtual device
> > some work by negotiating these features. Note: For example, a network packet
> > transported between two guests on the same system might not need
> > checksumming at all, nor segmentation, if both guests are amenable."
> > 
> Sure, it can avoid segmentation, but not at the cost of skipping mtu check.
> For example, sender sends skb with gso with each segment of 9K, and
> receiver has mtu of 1500, same skb without segmentation is not good.
> Because gso_size should be same as 1500 to match the mtu.  One can say
> with violation of line " The device MUST NOT pass received packets..."
> things still work fine because guest is amenable. :)
> 
> So counter looks ok to me when VIRTIO_NET_F_MTU is not negotiated or
> when mtu matches.

If someone misconfigures the LAN with different devices using
different MTU values .... all bets are off. OK we can put something
in spec e.g. for debugging but really just don't do this.

> > >
> > > Each packet must be 1500 for the mtu normative above.
> > > gso_size to <= mtu (ingoring the hdr math for simplicity for now).
> > > whole GSO completion can be for 64K to be reported in used_elem.len.
> > >
> > > ---------------------------------------------------------------------
> > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

