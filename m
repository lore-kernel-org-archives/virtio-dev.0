Return-Path: <virtio-dev-return-11982-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D897C761A6
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 17:44:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 89DAC2ACAD
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 17:44:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6BC70986593
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 17:44:15 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 56C40986524; Tue,  4 Apr 2023 17:44:15 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 43886986583
	for <virtio-dev@lists.oasis-open.org>; Tue,  4 Apr 2023 17:44:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: aTthMBVhOICnTuNrkyLbBA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680630252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3uM9p2xm7VYz2MAT8WoBk0TG8BbNy80LCEN/cIoegc=;
        b=VOIQZOy0QWVsY7gY3YlUbjBCNeFCk0wGc8D7BVklzYhIs+IJ5wj9Jhq65KaLF8wNn6
         mWviqfIhHtkAv602D6D3tuMFDZCe2UfEqt3u3+0omXx22AYX4GE1iVfARt8Aolg+a29S
         rBZm4jmDsRsZiWQ/NOgkOs1eepz1wMzzx3pW9Cbw23H9wk/ijmiEeGEw7HLPLnhrv/rL
         FG3Cx6J27fKHeJG7drhVU/viIuAoeGAkuV5WYOlEHajc8o954KO1hoV/QX5sQgxDeMxj
         d7KIo4UHZC22uZ6aWnoiTlRLapqFSHlXG/Id1ljAFKJAlKwQbxEBe2PtTHc5Lwq96oEn
         RZfA==
X-Gm-Message-State: AAQBX9d962fbyWQvYgkIMHda7sgoq2oqlucEqL76GGE6bkLyEA675SM5
	AHp+AnOI8xvmL/Q0+DqFQ3ASbIPmHUhuw84NlmUY7WF5pBt8qip1NcDczjLYjGRgRO5aEBNboPv
	8OwGj1syJz7/AlxKBAF8ls+vOsQGl
X-Received: by 2002:a17:906:95c1:b0:8f6:dc49:337f with SMTP id n1-20020a17090695c100b008f6dc49337fmr316676ejy.43.1680630252210;
        Tue, 04 Apr 2023 10:44:12 -0700 (PDT)
X-Google-Smtp-Source: AKy350aec3RiJATfXW3tZ2++sgLAWk8SF0PLNW2BfL64w9KuKfzfger5blsXbDo1LFvGVb49gtMzaA==
X-Received: by 2002:a17:906:95c1:b0:8f6:dc49:337f with SMTP id n1-20020a17090695c100b008f6dc49337fmr316659ejy.43.1680630251893;
        Tue, 04 Apr 2023 10:44:11 -0700 (PDT)
Date: Tue, 4 Apr 2023 13:44:07 -0400
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
Message-ID: <20230404134141-mutt-send-email-mst@kernel.org>
References: <20230323152422.113103-1-hengqi@linux.alibaba.com>
 <20230404182925.349d402e.pasic@linux.ibm.com>
 <PH0PR12MB5481969DB61A7CB30E89C3C4DC939@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481969DB61A7CB30E89C3C4DC939@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] [PATCH v14] virtio-net: support the virtqueue
 coalescing moderation

On Tue, Apr 04, 2023 at 04:32:07PM +0000, Parav Pandit wrote:
> 
> > From: Halil Pasic <pasic@linux.ibm.com>
> > Sent: Tuesday, April 4, 2023 12:29 PM
> > 
> > On Thu, 23 Mar 2023 23:24:22 +0800
> > Heng Qi <hengqi@linux.alibaba.com> wrote:
> > 
> > > +struct virtio_net_ctrl_coal_vq {
> > > +    le16 vqn;
> > > +    le16 reserved;
> > > +    struct virtio_net_ctrl_coal coal; };
> > > +
> > >  #define VIRTIO_NET_CTRL_NOTF_COAL 6
> > >   #define VIRTIO_NET_CTRL_NOTF_COAL_TX_SET  0
> > >   #define VIRTIO_NET_CTRL_NOTF_COAL_RX_SET 1
> > > + #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET 2 #define
> > > + VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET 3
> > >  \end{lstlisting}
> > >
> > >  Coalescing parameters:
> > >  \begin{itemize}
> > > +\item \field{vqn}: The virtqueue number of an enabled transmit or receive
> > virtqueue.
> > 
> > Just to be on the safe side: VIRTIO_F_NOTIF_CONFIG_DATA has been
> > negotiated, and queue_select != queue_notify_data, is vqn supposed to contain
> > queue_notify_data or the number/index that is used for queue_select (I'm
> > talking about the PCI transport case)?
> Vqn has zero relation to notification config data feature and featue bit.
> It is the real vqn enabled via queue_select.
> 
> Once the vqn is renamed to vq_notify_id, we won't have this confusion anymore.

vqn here is the index. queue_select is also the index.

Inside notifications-le.c we have:
le32 {
        vqn : 16;
        next_off : 15;
        next_wrap : 1;
};

vqn here is queue_notify_data.


-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

