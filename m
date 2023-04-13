Return-Path: <virtio-dev-return-12216-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA7AC77B6E
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Apr 2023 21:46:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 116D92B07E
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Apr 2023 21:46:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EE6D2986617
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Apr 2023 21:46:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D6D4F986600; Thu, 13 Apr 2023 21:46:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C5208986601
	for <virtio-dev@lists.oasis-open.org>; Thu, 13 Apr 2023 21:46:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: OOviB903PqO_z8QjL04n9g-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681422385; x=1684014385;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OTqphmYZkbT3QYsY/f5Uczx4let1/XUA/cgodrDsZhM=;
        b=UGKTnJPYCq96WRE0C0PGL2PyRl77+aivXNFJiGFGOe1ab+9j71IsCleZcZdE08NVxN
         KdikyORTj0jX9O/XvdAi89a5AgEkorMdVJb/NkAFaxFoNPqtJ/MeSilZxFaeJum1Oxkd
         xm+WjdctqclYjzZigkGf+xMnJOMhEtdVvZCReagORJXEqy9Bd/a3V1T77nosvCb6b0cO
         WXbt5W3aitMzJvh0jwl6dQbyL/eO4FpBynTG1KcVEXdwziY1rE74odNm4YhgOjamG6ux
         XUwat5zzYlaKpxPaQ73D6R6zgP00DYDpepVADqZZm/75aQ79vGius0aeoRCGYL4XoHaA
         Rj5Q==
X-Gm-Message-State: AAQBX9dj2+fW22u4V03vUGeMoy2T1RAqP/Jgbe8CX6XlyLXgqsxQeWLe
	UbMaeVdhYeFRIFPCtgdkGZOgzpXe4QO1nmUQecS6fDA8HizY/2EkvvLCqoUAbvzFIXo0duuuSZv
	4hoaGKhgEzOmznS7Rj1Gd8ZbntM7+
X-Received: by 2002:a5d:4d0a:0:b0:2ef:b596:3f71 with SMTP id z10-20020a5d4d0a000000b002efb5963f71mr2370321wrt.51.1681422385749;
        Thu, 13 Apr 2023 14:46:25 -0700 (PDT)
X-Google-Smtp-Source: AKy350aorGjWLV3hdeONyukJCosC5DQgyvAUf0hw7xHS5KFBsoX0SEtK/5zAnmkssF6l6vpAV3eejw==
X-Received: by 2002:a5d:4d0a:0:b0:2ef:b596:3f71 with SMTP id z10-20020a5d4d0a000000b002efb5963f71mr2370314wrt.51.1681422385432;
        Thu, 13 Apr 2023 14:46:25 -0700 (PDT)
Date: Thu, 13 Apr 2023 17:46:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, virtio-dev@lists.oasis-open.org,
	virtio-comment@lists.oasis-open.org,
	Parav Pandit <parav@nvidia.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230413174525-mutt-send-email-mst@kernel.org>
References: <20230403045833.21853-1-hengqi@linux.alibaba.com>
 <1d30d4a0-6bfc-3d58-17a4-645602d3792f@redhat.com>
 <a95ca379-0675-9b33-f649-bd2a19b56190@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <a95ca379-0675-9b33-f649-bd2a19b56190@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v12] virtio-net: support inner
 header hash

On Thu, Apr 13, 2023 at 07:03:26PM +0800, Heng Qi wrote:
> > >   For example, when the packets of certain
> > > +tunnels are spread across multiple receive queues, these receive
> > > queues may have an unbalanced
> > > +amount of packets. This can cause a specific receive queue to
> > > become full, resulting in packet loss.
> > 
> > 
> > We have many places that can lead to packet dropping. For example, the
> > automatic steering is best effort. I tend to avoid mentioning things
> > like this.
> 
> Ok. And Michael what do you think about this?


I think this text did not do a great job explaining the
security aspect. Here's a better, shorter explanation:

	It is often an expectation of users that a tunnel isolates the external
	network from the internal one. By completely ignoring entropy in the
	external header and replacing it with entropy from the internal header,
	for hash calculations, this expectation might be violated to a certain
	extent, depending on how the hash is used. When the hash use is limited
	to RSS queue selection, the effect will likely be limited to ability of
	users inside the tunnel to cause packet drops in multiple queues (as
	opposed to a single queue without the feature).

> > 
> > 
> > > +
> > > +Possible mitigations:
> > > +\begin{itemize}
> > > +\item Use a tool with good forwarding performance to keep the
> > > receive queue from filling up.
> > > +\item If the QoS is unavailable, the driver can set
> > > \field{hash_tunnel_types} to VIRTIO_NET_HASH_TUNNEL_TYPE_NONE
> > > +      to disable inner header hash for encapsulated packets.
> > > +\item Choose a hash key that can avoid queue collisions.
> > > +\item Perform appropriate QoS before packets consume the receive
> > > buffers of the receive queues.
> > > +\end{itemize}
> > > +
> > > +The limitations mentioned above exist with/without the inner header
> > > hash.
> > 
> > 
> > This conflicts with the tile "Tunnel QoS limitation" which readers may
> > think it happens only for tunnel.
> 
> Perhaps a "QoS Advices" is better?

Plural of "advice" is "advice" not "advices".

This advice is somewhat bogus though.

The point I keep trying to make is that this:

	Choose a hash key that can avoid queue collisions.

is impossible with the feature and possible without.
This was the whole reason I asked for a security
considerations sections.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

