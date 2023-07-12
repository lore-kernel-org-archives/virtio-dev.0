Return-Path: <virtio-dev-return-13349-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F937EB64D9
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 12:25:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 909237C6AD
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 12:25:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 85D299867B1
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 12:25:42 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7A592986682; Wed, 12 Jul 2023 12:25:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 69137986686
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Jul 2023 12:25:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: l0uM8722P4uAZIPPR5UOXg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689164739; x=1691756739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkO9MbztExOJAQwIj2RSXmPy7Fb2HxuZOYnIqrmXZq8=;
        b=OOylVBqsm/BYQcuNplKmfLM2VkZmtt0mVpW/9fC6IXoLE6RgZJdJ+y4n30n55jQ7HX
         Gp6xRIgATBLQE99EV6uyQKdki/ZyEYuoI+pGnRQ1fiWeEq/3IjCCku5Srykot/+gk8ha
         jyCRTSJALpQpva2YQybvXFj+ntVBX0nfKhe8v2zbtUOX8Ck3mihpHkbJjv9h8myclLc6
         LN3V5TmaIO6RZx3aj2nx9fxMUrIUFQBTau5MckOEgwSDeQORGd1pT+lTDGxlFOFIMUwQ
         bbLJJdnlZmJacbsN3A+v+aU5BCeKjSnSVsaoF1S6Of5gFWDGdQ2PBD57oXsp7GY1Bbka
         vdZw==
X-Gm-Message-State: ABy/qLY9cJqBRHhtpRM62UJYwEPQpTDM37iHQbQa08hb17IVjPJKptNO
	lhw7cStm2cM3poi8bxvSvwUj7m+G2M3P4PL9qLdBO4vWbiEq1rCyKHtPpYRJg82pnuk2voWzwgU
	U3C1kSgVbMtBIIQDBaKtPnfPpmqCw
X-Received: by 2002:adf:f2ce:0:b0:314:544d:199b with SMTP id d14-20020adff2ce000000b00314544d199bmr2945913wrp.6.1689164739327;
        Wed, 12 Jul 2023 05:25:39 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE/KsjF6DkPLYkap3y8UZs7Z95kHkCDl/kXo0i8w2JG9e03aed51WkciRxbKkyfho12EQiAUw==
X-Received: by 2002:adf:f2ce:0:b0:314:544d:199b with SMTP id d14-20020adff2ce000000b00314544d199bmr2945889wrp.6.1689164738865;
        Wed, 12 Jul 2023 05:25:38 -0700 (PDT)
Date: Wed, 12 Jul 2023 08:25:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>,
	Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230712082508-mutt-send-email-mst@kernel.org>
References: <20230703152711.106008-1-hengqi@linux.alibaba.com>
 <87pm4xjp4t.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87pm4xjp4t.fsf@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v21] virtio-net: support inner header hash

On Wed, Jul 12, 2023 at 02:22:26PM +0200, Cornelia Huck wrote:
> On Mon, Jul 03 2023, Heng Qi <hengqi@linux.alibaba.com> wrote:
> 
> (...)
> 
> > +\paragraph{Inner Header Hash}
> > +\label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Inner Header Hash}
> > +
> > +If VIRTIO_NET_F_HASH_TUNNEL has been negotiated, the driver can send the command
> > +VIRTIO_NET_CTRL_HASH_TUNNEL_SET to configure the calculation of the inner header hash.
> > +
> > +struct virtnet_hash_tunnel {
> > +    le32 enabled_tunnel_types;
> > +};
> > +
> > +#define VIRTIO_NET_CTRL_HASH_TUNNEL 7
> > + #define VIRTIO_NET_CTRL_HASH_TUNNEL_SET 0
> 
> This needs to be wrapped in \begin{lstlisting}..\end{lstlisting}, can do
> so when applying.
> 
> (...)
> 
> > +Encapsulation types applicable for inner header hash:
> > +\begin{lstlisting}
> > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_2784    (1 << 0) /* \hyperref[intro:gre_rfc2784]{[GRE_rfc2784]} */
> > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_2890    (1 << 1) /* \hyperref[intro:gre_rfc2890]{[GRE_rfc2890]} */
> > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_7676    (1 << 2) /* \hyperref[intro:gre_rfc7676]{[GRE_rfc7676]} */
> > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_UDP     (1 << 3) /* \hyperref[intro:gre_in_udp_rfc8086]{[GRE-in-UDP]} */
> > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_VXLAN       (1 << 4) /* \hyperref[intro:vxlan]{[VXLAN]} */
> > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_VXLAN_GPE   (1 << 5) /* \hyperref[intro:vxlan_gpe]{[VXLAN-GPE]} */
> > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GENEVE      (1 << 6) /* \hyperref[intro:geneve]{[GENEVE]} */
> > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_IPIP        (1 << 7) /* \hyperref[intro:ipip]{[IPIP]} */
> > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_NVGRE       (1 << 8) /* \hyperref[intro:nvgre]{[NVGRE]} */
> > +\end{lstlisting}
> 
> I'm afraid this one doesn't come out quite as intended, we'll end up
> with verbatim "\hyperref" text instead of a link. Anyone have a good
> idea on how to fix that?
> 
> I'd prefer to push this now with the first issue addressed and to do an
> (editorial) patch on top to deal with the second issue (unless someone
> can come up with a really trivial fix for it, then I can apply that
> straightaway.)

Someone suggested using escapechar:
https://tex.stackexchange.com/questions/314903/inline-links-in-code-listings

Didn't try.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

