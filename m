Return-Path: <virtio-dev-return-12237-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21BB3C77B6E
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 07:06:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 86F532B019
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 07:06:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8147E986617
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 07:06:46 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 75B89984140; Fri, 14 Apr 2023 07:06:46 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 658FF986601
	for <virtio-dev@lists.oasis-open.org>; Fri, 14 Apr 2023 07:06:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: QrxzpxKwNkW3msannq48ng-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681456003; x=1684048003;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TWTDgauIYxQjd9FUlUVndNskB4LL37y+t36KDZoM9IQ=;
        b=Ke+o70KAy4f+f8DGx7NtEH5tFhh5Ts8TbMy0OBjjTKbJ4k0OiiqOYzbRDY/NIOqFl1
         PtHMUf0e9gaZTgsHYuriS0HtE3wDtlrcPIuxnOIWN4gYk55iqkLwZw8jW3tqmIzklRV6
         2Eg7EKDfwBFztDxlvkc5YEJ7Sxarrwixj1mZGz66mR1ViOd4eTu5ezH/R2H4N4me3V6U
         7nh85Y1WDg78Bd0fp+RMySF3sIxrVtW/PlKui37Am083DXioHX+e0PlD3GJdyAf1+QRN
         3PRGWwLof84L4sWmAM0XciFVGMQ+tlhUKz5m/Mcy/zGlGgSmJR0p6e97L5tnB8kSWRF0
         c/Bw==
X-Gm-Message-State: AAQBX9eoHL3upOJnbLFt3FCRQA/hWAQDhf04yHsf3sdxbX392X9WBFcO
	4phjdij2FC5ahm2UcP2g39D1GUhOZGFI457THQDg/mg+blGNuxcLXyxtNqBdoOCmxjdQKI3YM4h
	RwPJaqWPYTCU7umd+P4Bl2qSogBqF
X-Received: by 2002:a05:6000:503:b0:2f2:7a7e:6ba with SMTP id a3-20020a056000050300b002f27a7e06bamr3423454wrf.15.1681456003214;
        Fri, 14 Apr 2023 00:06:43 -0700 (PDT)
X-Google-Smtp-Source: AKy350b328EAkpfzL/Zw36kuDPsDp+n700cteAFCMN/xxLMjRU3B/NgPCTCoqV3d92YvI/gklhcrsg==
X-Received: by 2002:a05:6000:503:b0:2f2:7a7e:6ba with SMTP id a3-20020a056000050300b002f27a7e06bamr3423432wrf.15.1681456002866;
        Fri, 14 Apr 2023 00:06:42 -0700 (PDT)
Date: Fri, 14 Apr 2023 03:06:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, virtio-dev@lists.oasis-open.org,
	virtio-comment@lists.oasis-open.org,
	Parav Pandit <parav@nvidia.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230414030616-mutt-send-email-mst@kernel.org>
References: <20230403045833.21853-1-hengqi@linux.alibaba.com>
 <1d30d4a0-6bfc-3d58-17a4-645602d3792f@redhat.com>
 <a95ca379-0675-9b33-f649-bd2a19b56190@linux.alibaba.com>
 <20230413173127-mutt-send-email-mst@kernel.org>
 <8681049d-57ef-ebd6-cf14-5b8ecbf44fc5@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <8681049d-57ef-ebd6-cf14-5b8ecbf44fc5@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] Re: [virtio-comment] Re: [PATCH v12] virtio-net:
 support inner header hash

On Fri, Apr 14, 2023 at 11:56:05AM +0800, Heng Qi wrote:
> 
> 
> 在 2023/4/14 上午5:43, Michael S. Tsirkin 写道:
> > On Thu, Apr 13, 2023 at 07:03:26PM +0800, Heng Qi wrote:
> > > > >    For example, when the packets of certain
> > > > > +tunnels are spread across multiple receive queues, these receive
> > > > > queues may have an unbalanced
> > > > > +amount of packets. This can cause a specific receive queue to
> > > > > become full, resulting in packet loss.
> > > > 
> > > > We have many places that can lead to packet dropping. For example, the
> > > > automatic steering is best effort. I tend to avoid mentioning things
> > > > like this.
> > > Ok. And Michael what do you think about this?
> > 
> > I think this text did not do a great job explaining the
> > security aspect. Here's a better, shorter explanation:
> > 
> > 	It is often an expectation of users that a tunnel isolates the external
> > 	network from the internal one. By completely ignoring entropy in the
> > 	external header and replacing it with entropy from the internal header,
> > 	for hash calculations, this expectation might be violated to a certain
> > 	extent, depending on how the hash is used. When the hash use is limited
> > 	to RSS queue selection, the effect will likely be limited to ability of
> > 	users inside the tunnel to cause packet drops in multiple queues (as
> > 	opposed to a single queue without the feature).
> 
> Sure. Will do  in the v13.
> 
> > 
> > > > 
> > > > > +
> > > > > +Possible mitigations:
> > > > > +\begin{itemize}
> > > > > +\item Use a tool with good forwarding performance to keep the
> > > > > receive queue from filling up.
> > > > > +\item If the QoS is unavailable, the driver can set
> > > > > \field{hash_tunnel_types} to VIRTIO_NET_HASH_TUNNEL_TYPE_NONE
> > > > > +      to disable inner header hash for encapsulated packets.
> > > > > +\item Choose a hash key that can avoid queue collisions.
> > > > > +\item Perform appropriate QoS before packets consume the receive
> > > > > buffers of the receive queues.
> > > > > +\end{itemize}
> > > > > +
> > > > > +The limitations mentioned above exist with/without the inner header
> > > > > hash.
> > > > 
> > > > This conflicts with the tile "Tunnel QoS limitation" which readers may
> > > > think it happens only for tunnel.
> > > Perhaps a "QoS Advices" is better?
> > Plural of "advice" is "advice" not "advices".
> 
> My fault.😅
> 
> > 
> > This advice is somewhat bogus though.
> > 
> > The point I keep trying to make is that this:
> > 
> > 	Choose a hash key that can avoid queue collisions.
> > 
> > is impossible with the feature and possible without.
> 
> I don't think so, the outer headers also has corresponding entropy for
> different streams.

But the feature when enabled ignores this entropy.

> Thanks.
> 
> > This was the whole reason I asked for a security
> > considerations sections.
> > 
> > 
> > > Thanks!
> > > 
> > > > Thanks
> > > > 
> > > > 
> > > > This publicly archived list offers a means to provide input to the
> > > > OASIS Virtual I/O Device (VIRTIO) TC.
> > > > 
> > > > In order to verify user consent to the Feedback License terms and
> > > > to minimize spam in the list archive, subscription is required
> > > > before posting.
> > > > 
> > > > Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> > > > Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> > > > List help: virtio-comment-help@lists.oasis-open.org
> > > > List archive: https://lists.oasis-open.org/archives/virtio-comment/
> > > > Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> > > > List Guidelines:
> > > > https://www.oasis-open.org/policies-guidelines/mailing-lists
> > > > Committee: https://www.oasis-open.org/committees/virtio/
> > > > Join OASIS: https://www.oasis-open.org/join/
> > 
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

