Return-Path: <virtio-dev-return-13181-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 831E6EB64D7
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 05:59:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BE02F2ACFD
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 05:59:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B3C959866F7
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 05:59:58 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A65DB984214; Fri, 30 Jun 2023 05:59:58 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 946DB9866EA
	for <virtio-dev@lists.oasis-open.org>; Fri, 30 Jun 2023 05:59:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: UZDkOddKNgmAXy8vfuexvg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688104794; x=1690696794;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZB+x1W+U/NmCuxtEO5vuZN+b6wWkJw/B3Ky+iuOLlMc=;
        b=WZeOuRXlfjEcsAqJ84Fb1m2uhCTv0DkpB7C4fd0SAlIMehsRpTJlUNbDVkgfSEkZM6
         blXj8xiOP4jVaCRHbSpaJ83Q+IwOJ37b1362U/HSxIse5mK4nHvVHHWrkByMSrN4iymg
         YRdDGJBhgr/TbZPGweS4OpIDQJdo6d5YRXmZgVutAG8kgJNR8mUZhKQvfGmmC8BCqky1
         V0O0W+zB4WXZpeG11kaZaE6VffzzIqLzv+HHwhlcJbY8UOq7IH8r5KUrfHjASIVw+XG+
         A7V1nlXJtOnDJaXmHoxevVO9/EbAq7gQijsPxnfP9CW/xlgw0hxkijBKVsACWwjgY5+l
         P8Pw==
X-Gm-Message-State: ABy/qLZ+eFMoVP2AqXJ2oy1IWawmmS6u8ENAHJ+DmBe0rRNdhnKKfTul
	FoxNWBWqf00G+8ifWRDrkZKaub7io3Pwcqp2+9MofFKlAI1ZgkwtQJ2SxQouHwWA4I6ishpIb/3
	EiSne9Sfvy+RxDnHrzS0hqPr12ZDX
X-Received: by 2002:a5d:6acc:0:b0:313:e715:3260 with SMTP id u12-20020a5d6acc000000b00313e7153260mr1295319wrw.48.1688104794638;
        Thu, 29 Jun 2023 22:59:54 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG5amZriNOFHh8fIJWn8sZlOOR/Drz8uyNn6nMWSjOYbLEHF3I4JrsYKO59MgCbl7hZuSZJ1g==
X-Received: by 2002:a5d:6acc:0:b0:313:e715:3260 with SMTP id u12-20020a5d6acc000000b00313e7153260mr1295306wrw.48.1688104794216;
        Thu, 29 Jun 2023 22:59:54 -0700 (PDT)
Date: Fri, 30 Jun 2023 01:59:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>
Message-ID: <20230630014917-mutt-send-email-mst@kernel.org>
References: <20230628132122-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54814D42786A6981467D3FADDC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230628152125-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481EAD97F6163C52DF4FF53DC25A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <4132affe-9b97-a81f-ad57-50ed4341678b@linux.alibaba.com>
 <20230629074627-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548127F715FC8B9FB14B5614DC25A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230630005420.GC77232@h68b04307.sqa.eu95>
 <PH0PR12MB54816F7B067539DF4B09C2BFDC2AA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <b957023f-a015-1622-531b-50b6931d974e@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <b957023f-a015-1622-531b-50b6931d974e@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] RE: [virtio-comment] RE:
 [PATCH v19] virtio-net: support inner header hash

On Fri, Jun 30, 2023 at 09:55:41AM +0800, Heng Qi wrote:
> 
> 
> 在 2023/6/30 上午9:36, Parav Pandit 写道:
> > 
> > > From: Heng Qi <hengqi@linux.alibaba.com>
> > > Sent: Thursday, June 29, 2023 8:54 PM
> > > 
> > > On Thu, Jun 29, 2023 at 04:59:28PM +0000, Parav Pandit wrote:
> > > > 
> > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > Sent: Thursday, June 29, 2023 7:48 AM
> > > > 
> > > > > > > struct virtio_net_hash_config reserved is fine.
> > > > > > +1.
> > > > > > 
> > > > > > Inner header hash is orthogonal to RSS, and it's fine to have its
> > > > > > own structure and commands.
> > > > > > There is no need to send additional RSS fields when we configure
> > > > > > inner header hash.
> > > > > > 
> > > > > > Thanks.
> > > > > Not RSS, hash calculations. It's not critical, but I note that
> > > > > practically you said you will enable this with symmetric hash so it
> > > > > makes sense to me to send this in the same command with the key.
> > > > > 
> > > > In the v19, we have,
> > > > 
> > > > +\item[VIRTIO_NET_F_HASH_TUNNEL] Requires VIRTIO_NET_F_CTRL_VQ
> > > along with VIRTIO_NET_F_RSS or VIRTIO_NET_F_HASH_REPORT.
> > > > So it is done along with rss, so in same struct as rss config is fine.
> > > Do you mean having both virtio_net_rss_config and virtio_net_hash_config
> > > have enabled_hash_types?
> > > Like this:
> > > 
> > > struct virtio_net_rss_config {
> > >       le32 hash_types;
> > >       le16 indirection_table_mask;
> > >       struct rss_rq_id unclassified_queue;
> > >       struct rss_rq_id indirection_table[indirection_table_length];
> > >       le16 max_tx_vq;
> > >       u8 hash_key_length;
> > >       u8 hash_key_data[hash_key_length];
> > > +    le32 enabled_tunnel_types;
> > > };
> > > 
> > > struct virtio_net_hash_config {
> > >       le32 hash_types;
> > > -    le16 reserved[4];
> > > +    le32 enabled_tunnel_types;
> > > +    le16 reserved[2];
> > >       u8 hash_key_length;
> > >       u8 hash_key_data[hash_key_length];
> > > };

Oh, I forgot that rss and hash had identical structures.
And we want to keep that I think.

But now it's not clear to me: does the same enabled_tunnel_types
apply to both hash calculation and rss?
I note we normally have separate configs for hash and rss.
So to keep it consistent what should we do? two set commands?
Or does enabled_tunnel_types apply to both rss and hash?

We should have reserved more space. We can still do it if you like:

struct virtio_net_rss_tunnel_config {
      le32 enabled_tunnel_types;
      le16 reserved[6];
      struct virtio_net_rss_config hash;
};

struct virtio_net_hash_tunnel_config {
      le32 enabled_tunnel_types;
      le16 reserved[6];
      struct virtio_net_hash_config hash;
};

?





> > > 
> > > 
> > > If yes, this should have been discussed in v10 [1] before, enabled_tunnel_types
> > > in virtio_net_rss_config will follow the variable length field and cause
> > > misalignment.
> > > 
> > > If we let the inner header hash reuse the virtio_net_hash_config structure, it
> > > can work, but the only disadvantage is that the configuration of the inner
> > > header hash and *RSS*(not hash calculations) becomes somewhat coupled.
> > > Just imagine:
> > > If the driver and the device negotiated VIRTIO_NET_F_HASH_TUNNEL and
> > > VIRTIO_NET_F_RSS, but did not negotiate VIRTIO_NET_F_HASH_REPORT, 1.
> > > then if we only want to configure the inner header hash (such as
> > > enabled_tunnel_types), it is good for us to send virtio_net_hash_config alone;
> > > 2. but then if we want to configure the inner header hash and RSS (such as
> > > indirection table), we need to send all virtio_net_rss_config and
> > > virtio_net_hash_config once, because virtio_net_rss_config now does not carry
> > > enabled_tunnel_types due to misalignment.
> > > 
> > > So, I think the following structure will make it clearer to configure inner header
> > > hash and RSS/hash calculation.
> > > But in any case, if we still propose to reuse virtio_net_hash_config proposal, I
> > > am ok, no objection:
> > > 
> > > 1. The supported_tunnel_types are placed in the device config space;
> > > 
> > Yes. I forgot the variable length part.
> > The second disadvantage I remember now is one need to resupply all the rss hash config parameter and device needs to compare and modify for this one field.

Or it could be an advantage since one normally wants to configure a
symmetric key with this. Further device can just use the new config
with no need to check what the old one was. I'd call it a wash.

> > Given these two disadvantages, I also prefer independent SET command the way you have it.
> 
> OK, let's wait for Michael's input again.
> 
> Thanks.


This part is not critical to me, but now I understand we need two sets of SET commands.


> > > 2.
> > > Reserve the following structure:
> > > 
> > >        struct virtnet_hash_tunnel {
> > > le32 enabled_tunnel_types;
> > >        };
> > > 
> > > 3. Reserve the SET command for enabled_tunnel_types and remove the GET
> > > command for enabled_tunnel_types.
> > > 
> > > [1] https://lists.oasis-open.org/archives/virtio-dev/202303/msg00317.html
> > > 
> > > Thanks a lot!


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

