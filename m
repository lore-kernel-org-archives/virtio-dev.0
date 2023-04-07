Return-Path: <virtio-dev-return-12062-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F51C6FD1D
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 11:46:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3A31B33594
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 11:46:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2A8549865E1
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 11:46:00 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1F7409865D7; Fri,  7 Apr 2023 11:46:00 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0F160983F7B
	for <virtio-dev@lists.oasis-open.org>; Fri,  7 Apr 2023 11:45:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: d91mrmn0MOyaBqXxtpy61w-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680867952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oeo2GtxtJgQxsIkSJcGWiw/zyttifHUvTEbheDn1vvA=;
        b=t5T27pblC9I/71DfrJpLZ+N02w+svrOp+lTz65sb8wZUZhwKXmt3SGujjpzayJ6+sR
         g8IPtONDHnJt4MERQyOsCRs+SnPfCWB5sJX8LULNKwALoaTdY0i5uOKObSL+8VOngjWt
         ZJ11OwNF9Z7GU2qIexjZ4vCiuKVIyZYHBrjl50+k7HzpdZ7SwAORA8ue7VS+erDR9EaV
         umtlcoAR224EEblfQNcZNylcpF/Jn7yaZA3CQeKcuVt1jsijGKxZTDEV/txOyjqBS1Je
         XjIGzDBFzL1JIx3Hat7BuTk2jCAVO3cYrlpHFKvvEpy4g0Wo9mCNfs82RqLvqmiwyS5G
         8jGw==
X-Gm-Message-State: AAQBX9cGBIpwUv1MBsDHQah2om+Ie9siZxdjPXmI3V3KjmcDme+DluTQ
	lWP9esSZxVsawB9s1gqLiElqYJgvYGtZD/ur1MxBculOcUTgOuErlwkxgGb841HTgMRngRbPr3b
	zkxP43Bj834V0f2FMLOUyxDkIgDlP
X-Received: by 2002:a05:600c:2206:b0:3ee:7d95:a39f with SMTP id z6-20020a05600c220600b003ee7d95a39fmr1070662wml.33.1680867952067;
        Fri, 07 Apr 2023 04:45:52 -0700 (PDT)
X-Google-Smtp-Source: AKy350a6PA0T9TLTGUK42QRYd1qyKnBb6hHI+OosOEboHOBYQPplNz+K09w5Ac9NdBGDWSDwg6xPTA==
X-Received: by 2002:a05:600c:2206:b0:3ee:7d95:a39f with SMTP id z6-20020a05600c220600b003ee7d95a39fmr1070648wml.33.1680867951772;
        Fri, 07 Apr 2023 04:45:51 -0700 (PDT)
Date: Fri, 7 Apr 2023 07:45:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, virtio-dev@lists.oasis-open.org,
	virtio-comment@lists.oasis-open.org,
	Cornelia Huck <cohuck@redhat.com>, Parav Pandit <parav@nvidia.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	David Edmondson <david.edmondson@oracle.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230407074514-mutt-send-email-mst@kernel.org>
References: <20230323152422.113103-1-hengqi@linux.alibaba.com>
 <20230404182925.349d402e.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20230404182925.349d402e.pasic@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] [PATCH v14] virtio-net:
 support the virtqueue coalescing moderation

On Tue, Apr 04, 2023 at 06:29:25PM +0200, Halil Pasic wrote:
> On Thu, 23 Mar 2023 23:24:22 +0800
> Heng Qi <hengqi@linux.alibaba.com> wrote:
> 
> > +struct virtio_net_ctrl_coal_vq {
> > +    le16 vqn;
> > +    le16 reserved;
> > +    struct virtio_net_ctrl_coal coal;
> > +};
> > +
> >  #define VIRTIO_NET_CTRL_NOTF_COAL 6
> >   #define VIRTIO_NET_CTRL_NOTF_COAL_TX_SET  0
> >   #define VIRTIO_NET_CTRL_NOTF_COAL_RX_SET 1
> > + #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET 2
> > + #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET 3
> >  \end{lstlisting}
> >  
> >  Coalescing parameters:
> >  \begin{itemize}
> > +\item \field{vqn}: The virtqueue number of an enabled transmit or receive virtqueue.
> 
> Just to be on the safe side: VIRTIO_F_NOTIF_CONFIG_DATA has been
> negotiated, and queue_select != queue_notify_data, is vqn supposed
> to contain queue_notify_data or the number/index that is used for
> queue_select (I'm talking about the PCI transport case)?
> 
> Regards,
> Halil

I think it's the vq number as it says here, this is not transport specific.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

