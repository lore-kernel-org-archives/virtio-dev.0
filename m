Return-Path: <virtio-dev-return-12238-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45FA6C77B6E
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 07:20:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 99D4D419A8
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 07:20:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1916F986631
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 07:20:20 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7CC62986602; Fri, 14 Apr 2023 07:20:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 62191986601
	for <virtio-dev@lists.oasis-open.org>; Fri, 14 Apr 2023 07:18:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: hwqtQX63P2Sy7Slbwekc1A-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681456728; x=1684048728;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3E0172sgMYDcbN5+/tQI1eA6idbzOpckIVYvBklwGHI=;
        b=ULXQSW/L66i7wuWXbS4UU9vtNRtyi6XzdsyhlQVksdw/yB1p5OjKAkXDTTp06rrgUT
         CjThZRjlifvoUdR8I+MTG2syED6TP3RaGJIN3p2yVvy3yLl/P9piB7DOD9hDPqUkP0Cg
         E3GRw1hLo561/+CsXvMaTJHFpu/w9ZBexCoHH8JPHtkobD/LlmondDeT7Hj4zFIOLMat
         MGnd5FLrmlZut2AfqjO8aLldpnyK59I6qswoyYZ1xHZKWzn36UmtEYUCQ5QHGM4Van3I
         Jcf9uDB89FIvXKb5RUZv/sAs9B3oiNXHDu1PQx1iGsIZfU2QSnQ8systC0J/eZmWh+xe
         7U5Q==
X-Gm-Message-State: AAQBX9fY+8i14Th1ZSrLsQZBIS/DS4FdFAdPjvb2VJtNv0ytrwMcEh6C
	VG4ESzbvrbY2HIF9em7BhpiHkqxM2noNqA1fIkUoO9/HX5NGmfEfnbRlWsJUcxDTNiLKFi7DoJo
	jaObhqCd/Xy9LS5jdvE8mLhdDsiu+tgEyv/uI
X-Received: by 2002:a5d:4f02:0:b0:2d0:bba8:3901 with SMTP id c2-20020a5d4f02000000b002d0bba83901mr3225699wru.62.1681456728808;
        Fri, 14 Apr 2023 00:18:48 -0700 (PDT)
X-Google-Smtp-Source: AKy350YatC+YcucblNepXgJUfn36gDI/9JDrD43orWXVvJt8mlHDjBjRLuKMM/ZJfuCT+n8Wn6o2YQ==
X-Received: by 2002:a5d:4f02:0:b0:2d0:bba8:3901 with SMTP id c2-20020a5d4f02000000b002d0bba83901mr3225681wru.62.1681456728498;
        Fri, 14 Apr 2023 00:18:48 -0700 (PDT)
Date: Fri, 14 Apr 2023 03:18:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, virtio-dev@lists.oasis-open.org,
	virtio-comment@lists.oasis-open.org,
	Parav Pandit <parav@nvidia.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230414031531-mutt-send-email-mst@kernel.org>
References: <20230403045833.21853-1-hengqi@linux.alibaba.com>
 <1d30d4a0-6bfc-3d58-17a4-645602d3792f@redhat.com>
 <a95ca379-0675-9b33-f649-bd2a19b56190@linux.alibaba.com>
 <20230413174525-mutt-send-email-mst@kernel.org>
 <CACGkMEttCB7J4bd8HoB4z7zQrhZArBHCECWcuuHy2eJVoV7tew@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEttCB7J4bd8HoB4z7zQrhZArBHCECWcuuHy2eJVoV7tew@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v12] virtio-net: support inner
 header hash

On Fri, Apr 14, 2023 at 11:10:36AM +0800, Jason Wang wrote:
> On Fri, Apr 14, 2023 at 5:46 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Apr 13, 2023 at 07:03:26PM +0800, Heng Qi wrote:
> > > > >   For example, when the packets of certain
> > > > > +tunnels are spread across multiple receive queues, these receive
> > > > > queues may have an unbalanced
> > > > > +amount of packets. This can cause a specific receive queue to
> > > > > become full, resulting in packet loss.
> > > >
> > > >
> > > > We have many places that can lead to packet dropping. For example, the
> > > > automatic steering is best effort. I tend to avoid mentioning things
> > > > like this.
> > >
> > > Ok. And Michael what do you think about this?
> >
> >
> > I think this text did not do a great job explaining the
> > security aspect. Here's a better, shorter explanation:
> >
> >         It is often an expectation of users that a tunnel isolates the external
> >         network from the internal one. By completely ignoring entropy in the
> >         external header and replacing it with entropy from the internal header,
> >         for hash calculations, this expectation might be violated to a certain
> >         extent, depending on how the hash is used. When the hash use is limited
> >         to RSS queue selection, the effect will likely be limited to ability of
> >         users inside the tunnel to cause packet drops in multiple queues (as
> >         opposed to a single queue without the feature).
> 
> And this is only for GRE-in-UDP?


This is whenever we discard outer header entropy.

> This makes me think if we should add
> GRE support for the outer header like:
> 
> https://docs.napatech.com/r/Feature-Set-N-ANL9/Hash-Key-Type-10-3-Tuple-GREv0
> 
> Thanks

I think this feature is only useful when entropy from inner header
is not exported to outer header, e.g. for legacy GRE
https://datatracker.ietf.org/doc/rfc2784/
When there's entropy in outer header, it's best to just use that.
This will mean that we do not need to keep adding stuff to
spec as more tunneling protocols appear.


> 
> >
> > > >
> > > >
> > > > > +
> > > > > +Possible mitigations:
> > > > > +\begin{itemize}
> > > > > +\item Use a tool with good forwarding performance to keep the
> > > > > receive queue from filling up.
> > > > > +\item If the QoS is unavailable, the driver can set
> > > > > \field{hash_tunnel_types} to VIRTIO_NET_HASH_TUNNEL_TYPE_NONE
> > > > > +      to disable inner header hash for encapsulated packets.
> > > > > +\item Choose a hash key that can avoid queue collisions.
> > > > > +\item Perform appropriate QoS before packets consume the receive
> > > > > buffers of the receive queues.
> > > > > +\end{itemize}
> > > > > +
> > > > > +The limitations mentioned above exist with/without the inner header
> > > > > hash.
> > > >
> > > >
> > > > This conflicts with the tile "Tunnel QoS limitation" which readers may
> > > > think it happens only for tunnel.
> > >
> > > Perhaps a "QoS Advices" is better?
> >
> > Plural of "advice" is "advice" not "advices".
> >
> > This advice is somewhat bogus though.
> >
> > The point I keep trying to make is that this:
> >
> >         Choose a hash key that can avoid queue collisions.
> >
> > is impossible with the feature and possible without.
> > This was the whole reason I asked for a security
> > considerations sections.
> >
> > --
> > MST
> >


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

