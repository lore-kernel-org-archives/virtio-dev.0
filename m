Return-Path: <virtio-dev-return-13192-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7561DEB64DD
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 14:52:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8FE812B04C
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 14:52:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 725519866F2
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 14:52:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5D4D29866EC; Fri, 30 Jun 2023 14:52:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4A3E09866ED
	for <virtio-dev@lists.oasis-open.org>; Fri, 30 Jun 2023 14:52:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: RQ8ZiI7pNM6Q2gXa87XTBQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688136749; x=1690728749;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fxmgSQKJ5OADn8eH0eeafFT5ooouhLwaX8h/byTGsFo=;
        b=kI6ULYECj5T/YAcvSIEM/VW/ERhJYeFKAWQcscht/2JoUL6u7Vwzei5SN0XR6F5wJq
         Ozspv7rRS/GzEZ20hRDD9zB4vmqQAdopUs91Irph1b8TChVqgRko54NDvaamhiUpYGhv
         kUZHW3aIl09ILCcub/JZu49nPSDd5QFv4Bq6+V2/YAjEuoyZ1Q9jV/yy4C6A2tiRT3Zf
         /Cin5Vszmejpp9DROtZ5l5DTPQrIUOBaTUhbgf0+rRKGCogqW+4OhBBuIy2M6iUFSu4C
         OwU7slUjm8mpFQEo7TQTE5rMO3IhjrVV1Vhko90Rjvq5PPioFfIHJihXiKEP053a3ZiS
         mZCw==
X-Gm-Message-State: ABy/qLYAOFqcAl5vHVuafdZCS5i7Ud3R6SpnqReFSUassVLTnTNvInNp
	Ah9fvl//SXY6SFTKdhJzdaFn4Ob5KzAuDR479WQVflY84JNMPG9+4U/yD/a17CLb5NSgXfQbQtx
	Isej9qqd2UsRCL5pB165wmRjLpb7T
X-Received: by 2002:adf:cd87:0:b0:313:edaa:24fd with SMTP id q7-20020adfcd87000000b00313edaa24fdmr2301190wrj.21.1688136749633;
        Fri, 30 Jun 2023 07:52:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG+MaMJM/6uqV3DNlkho304Cdpyv0PHahlPpPpDCj1qObn3umX1QkFwRQtuqMZRofbL2q6gWQ==
X-Received: by 2002:adf:cd87:0:b0:313:edaa:24fd with SMTP id q7-20020adfcd87000000b00313edaa24fdmr2301173wrj.21.1688136749266;
        Fri, 30 Jun 2023 07:52:29 -0700 (PDT)
Date: Fri, 30 Jun 2023 10:52:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>
Message-ID: <20230630102758-mutt-send-email-mst@kernel.org>
References: <4132affe-9b97-a81f-ad57-50ed4341678b@linux.alibaba.com>
 <20230629074627-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548127F715FC8B9FB14B5614DC25A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230630005420.GC77232@h68b04307.sqa.eu95>
 <PH0PR12MB54816F7B067539DF4B09C2BFDC2AA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <b957023f-a015-1622-531b-50b6931d974e@linux.alibaba.com>
 <20230630014917-mutt-send-email-mst@kernel.org>
 <bd010577-9a85-72f9-9af6-4289a482b991@linux.alibaba.com>
 <20230630041337-mutt-send-email-mst@kernel.org>
 <38fe3702-ea32-0d4a-fe23-cc7dbc823415@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <38fe3702-ea32-0d4a-fe23-cc7dbc823415@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] Re:
 [virtio-dev] RE: [virtio-comment] RE: [PATCH v19] virtio-net: support inner
 header hash

On Fri, Jun 30, 2023 at 10:04:08PM +0800, Heng Qi wrote:
> 
> 
> 在 2023/6/30 下午4:17, Michael S. Tsirkin 写道:
> > On Fri, Jun 30, 2023 at 02:15:13PM +0800, Heng Qi wrote:
> > > 
> > > 在 2023/6/30 下午1:59, Michael S. Tsirkin 写道:
> > > > On Fri, Jun 30, 2023 at 09:55:41AM +0800, Heng Qi wrote:
> > > > > 在 2023/6/30 上午9:36, Parav Pandit 写道:
> > > > > > > From: Heng Qi <hengqi@linux.alibaba.com>
> > > > > > > Sent: Thursday, June 29, 2023 8:54 PM
> > > > > > > 
> > > > > > > On Thu, Jun 29, 2023 at 04:59:28PM +0000, Parav Pandit wrote:
> > > > > > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > > > > > Sent: Thursday, June 29, 2023 7:48 AM
> > > > > > > > > > > struct virtio_net_hash_config reserved is fine.
> > > > > > > > > > +1.
> > > > > > > > > > 
> > > > > > > > > > Inner header hash is orthogonal to RSS, and it's fine to have its
> > > > > > > > > > own structure and commands.
> > > > > > > > > > There is no need to send additional RSS fields when we configure
> > > > > > > > > > inner header hash.
> > > > > > > > > > 
> > > > > > > > > > Thanks.
> > > > > > > > > Not RSS, hash calculations. It's not critical, but I note that
> > > > > > > > > practically you said you will enable this with symmetric hash so it
> > > > > > > > > makes sense to me to send this in the same command with the key.
> > > > > > > > > 
> > > > > > > > In the v19, we have,
> > > > > > > > 
> > > > > > > > +\item[VIRTIO_NET_F_HASH_TUNNEL] Requires VIRTIO_NET_F_CTRL_VQ
> > > > > > > along with VIRTIO_NET_F_RSS or VIRTIO_NET_F_HASH_REPORT.
> > > > > > > > So it is done along with rss, so in same struct as rss config is fine.
> > > > > > > Do you mean having both virtio_net_rss_config and virtio_net_hash_config
> > > > > > > have enabled_hash_types?
> > > > > > > Like this:
> > > > > > > 
> > > > > > > struct virtio_net_rss_config {
> > > > > > >         le32 hash_types;
> > > > > > >         le16 indirection_table_mask;
> > > > > > >         struct rss_rq_id unclassified_queue;
> > > > > > >         struct rss_rq_id indirection_table[indirection_table_length];
> > > > > > >         le16 max_tx_vq;
> > > > > > >         u8 hash_key_length;
> > > > > > >         u8 hash_key_data[hash_key_length];
> > > > > > > +    le32 enabled_tunnel_types;
> > > > > > > };
> > > > > > > 
> > > > > > > struct virtio_net_hash_config {
> > > > > > >         le32 hash_types;
> > > > > > > -    le16 reserved[4];
> > > > > > > +    le32 enabled_tunnel_types;
> > > > > > > +    le16 reserved[2];
> > > > > > >         u8 hash_key_length;
> > > > > > >         u8 hash_key_data[hash_key_length];
> > > > > > > };
> > > > Oh, I forgot that rss and hash had identical structures.
> > > > And we want to keep that I think.
> > > > 
> > > > But now it's not clear to me: does the same enabled_tunnel_types
> > > > apply to both hash calculation and rss?
> > > Yes. What I'm trying to say is that making the inner header hash and
> > > RSS/hash calculation clear delimitation will make everything easier.
> > > The inner header hash just configures enabled_tunnel_types.
> > > The RSS/hash calculation is configured as before without modification.
> > > 
> > > > I note we normally have separate configs for hash and rss.
> > > > So to keep it consistent what should we do? two set commands?
> > > As I explained above, like outer udp port hash/symmetric toeplitz hash,
> > > these fall under the umbrella of RSS/hash calculation.
> > Yes but note that symmetric toeplitz hash has to be configured
> > separately for RSS and for hashing.
> 
> Yes, this requires a field like \field{mode}, with different values
> corresponding to different hashing algorithms, such as toeplitz or symmetric
> toeplitz.
> The outer port hash belongs to RSS/hash calculation.

So there will be need for more fields.
To me this implies extending with struct virtio_net_rss_tunnel_config
is a better idea since we then have some reserved space to
put "mode" down the road (in the reserved[6] space below).

No?

> > 
> > > Let's keep the inner header hash simple.
> > > 
> > > > Or does enabled_tunnel_types apply to both rss and hash?
> > > Certainly. See:
> > > 
> > >      +\item[VIRTIO_NET_F_HASH_TUNNEL] Requires VIRTIO_NET_F_CTRL_VQ along
> > > with VIRTIO_NET_F_RSS or VIRTIO_NET_F_HASH_REPORT.
> > 
> > It does not really say that.
> Oh! I understand now. I think a VIRTIO_NET_CTRL_HASH_TUNNEL_SET command is
> applied to hash and RSS. Yes.
> When one wants to configure inner header hash separately, use
> VIRTIO_NET_CTRL_HASH_TUNNEL_SET command to send enabled_tunnel_types
> separately.
> When one wants to configure both inner header hash and RSS/hash, use
> VIRTIO_NET_CTRL_HASH_TUNNEL_SET together with
> VIRTIO_NET_CTRL_MQ_RSS_CONFIG/VIRTIO_NET_CTRL_MQ_HASH_CONFIG.
> The inner header hash is decoupled from RSS/hash, and no extra fields will
> be sent every configuration.

But why is tunnel so different? Rest of things can be configured
for hash and for rss separately.


For example I can configure hash for IPv4 and IPv6 but RSS only for
IPv6. But for some reason, if I configure tunnel for GRE it will
affect both hash and RSS. Why? It seems quite possible to me that I
was offload for hash for GRE but don't want to use it
for RSS to avoid RX underrun issues we discussed.


> > 
> > 
> > 
> > > > We should have reserved more space. We can still do it if you like:
> > > > 
> > > > struct virtio_net_rss_tunnel_config {
> > > >         le32 enabled_tunnel_types;
> > > >         le16 reserved[6];
> > > >         struct virtio_net_rss_config hash;
> > > > };
> > > > 
> > > > struct virtio_net_hash_tunnel_config {
> > > >         le32 enabled_tunnel_types;
> > > >         le16 reserved[6];
> > > >         struct virtio_net_hash_config hash;
> > > > };
> > > > 
> > > > ?
> > > > 
> > > > 
> > > > 
> > > > 
> > > > 
> > > > > > > If yes, this should have been discussed in v10 [1] before, enabled_tunnel_types
> > > > > > > in virtio_net_rss_config will follow the variable length field and cause
> > > > > > > misalignment.
> > > > > > > 
> > > > > > > If we let the inner header hash reuse the virtio_net_hash_config structure, it
> > > > > > > can work, but the only disadvantage is that the configuration of the inner
> > > > > > > header hash and *RSS*(not hash calculations) becomes somewhat coupled.
> > > > > > > Just imagine:
> > > > > > > If the driver and the device negotiated VIRTIO_NET_F_HASH_TUNNEL and
> > > > > > > VIRTIO_NET_F_RSS, but did not negotiate VIRTIO_NET_F_HASH_REPORT, 1.
> > > > > > > then if we only want to configure the inner header hash (such as
> > > > > > > enabled_tunnel_types), it is good for us to send virtio_net_hash_config alone;
> > > > > > > 2. but then if we want to configure the inner header hash and RSS (such as
> > > > > > > indirection table), we need to send all virtio_net_rss_config and
> > > > > > > virtio_net_hash_config once, because virtio_net_rss_config now does not carry
> > > > > > > enabled_tunnel_types due to misalignment.
> > > > > > > 
> > > > > > > So, I think the following structure will make it clearer to configure inner header
> > > > > > > hash and RSS/hash calculation.
> > > > > > > But in any case, if we still propose to reuse virtio_net_hash_config proposal, I
> > > > > > > am ok, no objection:
> > > > > > > 
> > > > > > > 1. The supported_tunnel_types are placed in the device config space;
> > > > > > > 
> > > > > > Yes. I forgot the variable length part.
> > > > > > The second disadvantage I remember now is one need to resupply all the rss hash config parameter and device needs to compare and modify for this one field.
> > > > Or it could be an advantage since one normally wants to configure a
> > > > symmetric key with this. Further device can just use the new config
> > > When we want to configure the hash key, he continues to use the previous
> > > rss/hash calculation interface. This is ok.
> > > 
> > > Thanks.
> > I don't understand this sentence. My point is simply that
> > to use the tunnel key has to be symmetric. So two commands
> > will be required: one to set tunnel types, one to
> > set the key.
> 
> Yes, you are right. Then one should be VIRTIO_NET_CTRL_HASH_TUNNEL_SET and
> the other
> should be VIRTIO_NET_CTRL_MQ_RSS_CONFIG/VIRTIO_NET_CTRL_MQ_HASH_CONFIG.
> 
> Thanks.

Well that is still 1 command for tunnels that affects both rss and
hashing. Why not 2 commands for rss and for hashing?


> > 
> > > > with no need to check what the old one was. I'd call it a wash.
> > > > 
> > > > > > Given these two disadvantages, I also prefer independent SET command the way you have it.
> > > > > OK, let's wait for Michael's input again.
> > > > > 
> > > > > Thanks.
> > > > This part is not critical to me, but now I understand we need two sets of SET commands.
> > > > 
> > > > 
> > > > > > > 2.
> > > > > > > Reserve the following structure:
> > > > > > > 
> > > > > > >          struct virtnet_hash_tunnel {
> > > > > > > le32 enabled_tunnel_types;
> > > > > > >          };
> > > > > > > 
> > > > > > > 3. Reserve the SET command for enabled_tunnel_types and remove the GET
> > > > > > > command for enabled_tunnel_types.
> > > > > > > 
> > > > > > > [1] https://lists.oasis-open.org/archives/virtio-dev/202303/msg00317.html
> > > > > > > 
> > > > > > > Thanks a lot!
> > > > ---------------------------------------------------------------------
> > > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > > > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> > 
> > This publicly archived list offers a means to provide input to the
> > OASIS Virtual I/O Device (VIRTIO) TC.
> > 
> > In order to verify user consent to the Feedback License terms and
> > to minimize spam in the list archive, subscription is required
> > before posting.
> > 
> > Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> > Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> > List help: virtio-comment-help@lists.oasis-open.org
> > List archive: https://lists.oasis-open.org/archives/virtio-comment/
> > Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> > List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> > Committee: https://www.oasis-open.org/committees/virtio/
> > Join OASIS: https://www.oasis-open.org/join/


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

