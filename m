Return-Path: <virtio-dev-return-11952-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AAE7C6FD1D
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 06:35:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 57E8F2AC9D
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 06:35:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3D159986400
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 06:35:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 27EB29863E4; Tue,  4 Apr 2023 06:35:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 71B5E9863E5
	for <virtio-dev@lists.oasis-open.org>; Tue,  4 Apr 2023 06:35:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 30vgmyD3PSKf4mcqV4sGPA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680590100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=teeyyh88qs0OBOxku3WhOOqNN/Ql3FGS6DfMKEgucUE=;
        b=mWWOkKfZ84dNxyszH+ioF/wZ7swo6VwBC/uh9XZKu75mMDtEQKBC9J+fYyrhOeBafU
         RkiFgzildvgoRPutzEzqJrO9GfpNWLC5YH8RZMoYsYE4+KImAQg2QHAyMrBU5t9gAQwo
         bvwjijb+QOly4gwc2kx1hgH+gmuBeUoBmsIPLetNf/jcYHHm573lfZiPmWYev3zKk+Bi
         DKUDOvYIqmL5bWkWaWxZdaHE0oLpxhWupQjltoNrmt8Wwu2VrC4zf29IYZkyLvLnA2Lq
         Z3niMAe3k6w26iPJWeQnx9F+jK3EcefBTZGrua5FYfCBDbFc7DzQ0Zxl4XgHfoJ7L9dQ
         /Ixw==
X-Gm-Message-State: AAQBX9eWjE2HxdGgqAMw6wliV//G/LDu/zK7FfZl7OwLxozqlOvAymEJ
	Xuvpeu+PRwN4itfIuauhFvpx9D4aMvHE33/rVLQqXGFvOubUu2oD2rJyMWfu0N3nxQQli6e3+jr
	U/O1UAWvf/qVnS3lextaBNDP7Upuv
X-Received: by 2002:aa7:cf8d:0:b0:4bc:f925:5dbe with SMTP id z13-20020aa7cf8d000000b004bcf9255dbemr1328068edx.42.1680590100341;
        Mon, 03 Apr 2023 23:35:00 -0700 (PDT)
X-Google-Smtp-Source: AKy350YTV01zSr1Qu9rYam3tnZzaSpnnTxAH+LRp3Mk8JPEb480bt/vC7ma+zc7wmXxN6/zhTgRJvw==
X-Received: by 2002:aa7:cf8d:0:b0:4bc:f925:5dbe with SMTP id z13-20020aa7cf8d000000b004bcf9255dbemr1328049edx.42.1680590099993;
        Mon, 03 Apr 2023 23:34:59 -0700 (PDT)
Date: Tue, 4 Apr 2023 02:34:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Parav Pandit <parav@nvidia.com>,
	virtio-dev@lists.oasis-open.org, sgarzare@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
Message-ID: <20230404023334-mutt-send-email-mst@kernel.org>
References: <20230329212341.465843-1-parav@nvidia.com>
 <20230330191114.77acd860.pasic@linux.ibm.com>
 <87jzyxcp8g.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87jzyxcp8g.fsf@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] [PATCH v10 0/8] Rename queue index to queue number

On Fri, Mar 31, 2023 at 10:13:51AM +0200, Cornelia Huck wrote:
> On Thu, Mar 30 2023, Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > On Thu, 30 Mar 2023 00:23:33 +0300
> > Parav Pandit <parav@nvidia.com> wrote:
> >
> >> 1. Currently, virtqueue is identified between driver and device
> >> interchangeably using either number or index terminology.
> >> 
> >> 2. Between PCI and MMIO transport the queue size (depth) is
> >> defined as queue_size and QueueNum respectively.
> >> 
> >> To avoid confusion and to have consistency, unify them to use Number.
> >> 
> >> Solution:
> >> a. Use virtqueue number description, and rename MMIO register as QueueSize.
> >
> > I'm in favor of replacing number with size where appropriate.
> >
> >> b. Replace virtqueue index with virtqueue number
> >
> > I don't see the benefit of replacing virtqueue index with virtqueue
> > number.
> >
> > Currently virtqueue number is only used in the parts that describe
> > notifications (Guest->Host), the rest of the spec uses virtqueue index.
> >
> > I argue that using a different term in that context than in the rest
> > of the specification makes sense, because in the context of notifications
> > the virtqueue isn't always identified by its index.
> >
> > More precisely: if VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated in the
> > context of notifications the virtqueue is identified by the
> > so called "queue_notify_data"; if VIRTIO_F_NOTIF_CONFIG_DATA has been
> > negotiated in the context of notifications the virtqueue is identified by
> > the virtqueue index (as usual, for example in queue_select, or in
> > the ccws).
> >
> > As I've pointed out in my comment to patch 2, I believe replacing
> > virtqueue index with virtqueue number is detrimental to clarity.
> >
> > Thus please find a counter-proposal below. If there is interest
> > I can make a series out of it, and prettify it. If I can't convince
> > you guys, then I will have to get used to vqn and virtqueue number.
> 
> I would generally prefer "index" as well, but there seemed to be a
> strong sentiment that we should go with "number"... so, what *is* the
> actual general sentiment? It's hard to say, but maybe most people are
> fine with either?

If we really can't decide one way or another then I can run a ballot,
it's not hard.


> >
> > AFAIR the other problem with index was the RSS for virtio-net. But there
> > we are currently heading down a direction of introducing a new
> > abstraction. This approach avoids confusion around the term 'virtqueue
> > index' as much as it avoids confusion around the term 'virtqueue nuber'.
> >
> >
> >> c. RSS area of virtio net has inherited some logic, describe it
> >> using abstract rss_rq_id.
> >
> > -------------------------8<--------------------------------------
> > From: Halil Pasic <pasic@linux.ibm.com>
> > Date: Thu, 30 Mar 2023 17:57:53 +0200
> > Subject: [PATCH 1/1] content: clarify how virtques are identified
> >
> > Clarify how virtqueues are identified in the context of
> > available notifications and in the context of RSS for
> > virtio-net .
> >
> > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > ---
> >  content.tex                      | 15 ++++++++++-----
> >  device-types/net/description.tex | 30 ++++++++++++++++++++++--------
> >  transport-ccw.tex                |  2 +-
> >  transport-pci.tex                |  7 ++++---
> >  4 files changed, 37 insertions(+), 17 deletions(-)
> 
> (...)
> 
> > +struct rss_rq_id {
> > +   le16 value; /* virtqueue index divided by two */
> > +};
> > +
> >  struct virtio_net_rss_config {
> >      le32 hash_types;
> >      le16 indirection_table_mask;
> > -    le16 unclassified_queue;
> > -    le16 indirection_table[indirection_table_length];
> > +    struct rss_rq_id unclassified_queue;
> > +    struct rss_rq_id indirection_table[indirection_table_length];
> >      le16 max_tx_vq;
> >      u8 hash_key_length;
> >      u8 hash_key_data[hash_key_length];
> >  };
> >  \end{lstlisting}
> > +
> > +The type struct rss\_rq\_id is introduced to better distinguish receive queue
> > +ids form other integral fields.
> > +
> > +A receive queue id is only defined for receive queues, as the virtqueue index
> > +of the receive virtqueue divided by two (the virtqueue index of a receive
> > +queue is always even). For example receiveq4 is identified by the virtqueue
> > +index 6 and the receive queue id 3.
> 
> FWIW, I think this is much easier to understand.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

