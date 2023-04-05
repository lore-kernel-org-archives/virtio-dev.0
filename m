Return-Path: <virtio-dev-return-12006-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B45C7619A
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 09:12:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 28D612B04E
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 09:12:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 119899865B7
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 09:12:21 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E334B983DE1; Wed,  5 Apr 2023 09:12:20 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D0AA59865A8
	for <virtio-dev@lists.oasis-open.org>; Wed,  5 Apr 2023 09:12:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: XUgScrA0PnqmJxTkxjzt-g-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680685937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ov4y2CGhg7FRlDNu/AjMGZ/vcwiIgcygtfixPLxm3I4=;
        b=4ZKx8bN0B4UTTeS5NcXS9aRly88naTaWR11R/7f+vLwKuwpG76/6hJ7yCdQqwJzILY
         jpAMRn+H2daZxHacA0XDecizWeG/fw24mCiO5at//CwrqkxrUm9l/pjrtUVITxhhoyCF
         PvHNerY8ugayppfF7QcQQrWZKlRtmTuqb4Re+G5e1UM1+6ytnjBB8OdqpRfe3P1Fgv44
         2ywV06kg+/msk8qlcNZIweu3MajE5m7IcUcVTCXhN3IhBMpxZo/idE6SFfA8kx8Gex07
         kdwPA8Mvy2CVk31l4uo2rNl/f8eNstBzF95W04ALbmxDlXxxwKx0WHRm5n3GiJVM2uGh
         UWsA==
X-Gm-Message-State: AAQBX9eIkqtMr+cedR7Yl1hobXfA3TYv3DRhcf7uhNb1KK97zi5fEtA/
	WIZXgUi3ZBKiPcU4nZz2hpLGKVdbL+woui8vsJWDr5nfJ/mRkZXy8h1kcm4srA3SCrN2aVM0/sA
	0FiiX9+2hCXkRuFtxcYiAK7ao7oM0
X-Received: by 2002:a17:907:77d0:b0:8b2:7564:dfd5 with SMTP id kz16-20020a17090777d000b008b27564dfd5mr2143348ejc.60.1680685937614;
        Wed, 05 Apr 2023 02:12:17 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZrKzLZ48ZVBKIHl4/Dfl6JtIzv+dtybC3TM0k1FztIsHqjLdGTenaOTkggjImMcNJH2XUYiA==
X-Received: by 2002:a17:907:77d0:b0:8b2:7564:dfd5 with SMTP id kz16-20020a17090777d000b008b27564dfd5mr2143337ejc.60.1680685937330;
        Wed, 05 Apr 2023 02:12:17 -0700 (PDT)
Date: Wed, 5 Apr 2023 05:12:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Cornelia Huck <cohuck@redhat.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	David Edmondson <david.edmondson@oracle.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230405050718-mutt-send-email-mst@kernel.org>
References: <20230323152422.113103-1-hengqi@linux.alibaba.com>
 <20230404182925.349d402e.pasic@linux.ibm.com>
 <PH0PR12MB5481969DB61A7CB30E89C3C4DC939@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230404134141-mutt-send-email-mst@kernel.org>
 <c2239805-3f62-ee76-d422-2f6c247b7747@nvidia.com>
 <20230404161213-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D95889A86A9BF9889C5CDC939@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481D95889A86A9BF9889C5CDC939@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] [PATCH v14] virtio-net: support the virtqueue
 coalescing moderation

On Tue, Apr 04, 2023 at 08:50:43PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, April 4, 2023 4:14 PM
> > 
> > On Tue, Apr 04, 2023 at 03:39:21PM -0400, Parav Pandit wrote:
> > >
> > >
> > > On 4/4/2023 1:44 PM, Michael S. Tsirkin wrote:
> > > > On Tue, Apr 04, 2023 at 04:32:07PM +0000, Parav Pandit wrote:
> > > > >
> > > > > > From: Halil Pasic <pasic@linux.ibm.com>
> > > > > > Sent: Tuesday, April 4, 2023 12:29 PM
> > > > > >
> > > > > > On Thu, 23 Mar 2023 23:24:22 +0800 Heng Qi
> > > > > > <hengqi@linux.alibaba.com> wrote:
> > > > > >
> > > > > > > +struct virtio_net_ctrl_coal_vq {
> > > > > > > +    le16 vqn;
> > > > > > > +    le16 reserved;
> > > > > > > +    struct virtio_net_ctrl_coal coal; };
> > > > > > > +
> > > > > > >   #define VIRTIO_NET_CTRL_NOTF_COAL 6
> > > > > > >    #define VIRTIO_NET_CTRL_NOTF_COAL_TX_SET  0
> > > > > > >    #define VIRTIO_NET_CTRL_NOTF_COAL_RX_SET 1
> > > > > > > + #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET 2 #define
> > > > > > > + VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET 3
> > > > > > >   \end{lstlisting}
> > > > > > >
> > > > > > >   Coalescing parameters:
> > > > > > >   \begin{itemize}
> > > > > > > +\item \field{vqn}: The virtqueue number of an enabled
> > > > > > > +transmit or receive
> > > > > > virtqueue.
> > > > > >
> > > > > > Just to be on the safe side: VIRTIO_F_NOTIF_CONFIG_DATA has been
> > > > > > negotiated, and queue_select != queue_notify_data, is vqn
> > > > > > supposed to contain queue_notify_data or the number/index that
> > > > > > is used for queue_select (I'm talking about the PCI transport case)?
> > > > > Vqn has zero relation to notification config data feature and featue bit.
> > > > > It is the real vqn enabled via queue_select.
> > > > >
> > > > > Once the vqn is renamed to vq_notify_id, we won't have this confusion
> > anymore.
> > > >
> > > > vqn here is the index. queue_select is also the index.
> > > >
> > > Yes to both. No plan to rename them.
> > >
> > > > Inside notifications-le.c we have:
> > > > le32 {
> > > >          vqn : 16;
> > > >          next_off : 15;
> > > >          next_wrap : 1;
> > > > };
> > > >
> > > > vqn here is queue_notify_data.
> > > >
> > > vqn in above unnamed structure is contain a. either vq index if
> > > CONFIG_DATA is not negotiated or b. it contains queue_notifiy_data if
> > > CONFIG_DATA is negotiated
> > >
> > > Therefore, instead of naming it as vqn, renaming it to vq_notify_id
> > > crisply describe what it is for.
> > >
> > > And not some vqn n stands for notification, but "d" of data is dropped
> > > somehow.
> > 
> > vqnd then? for virt queue notification data?
> > 
> "id" identifies the queue as opposed to "data" identifying a queue.
> > 
> > > A notification identifier contains depending on negotiated feature bit.
> > 
> > it's not necessarily an identifier. can be e.g. just 0 for all vqs.
> > whatever the device needs.
> For driver its just an id, content doesn't matter.

No, this value might or might not be somehow related to the vq but it
does not have to identify it. So it's some data, not an id.  Let's try
to use words for what they mean in english not try to come up with our
own language.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

