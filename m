Return-Path: <virtio-dev-return-13196-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BEE7EB64DA
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 16:56:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5FB0A2AED6
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 16:56:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4A6E09866FA
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 16:56:16 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 328719866ED; Fri, 30 Jun 2023 16:56:16 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1EDDD9866EF
	for <virtio-dev@lists.oasis-open.org>; Fri, 30 Jun 2023 16:56:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: okkolZ51PYWC_6nH6YYUGg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688144172; x=1690736172;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YFa2gbUrDS2zIHbnIRZk6UIrljg5ws+GfoDCm8XCEHA=;
        b=NxI4u4QWG1VbwAsXRMnhypNxgpCQzkkdi6Q5x8rFeahbmmuhBtF1FqwgXekd7K/IAK
         rH2da4tF5DvFuTTIu2ubgKiM/TPzxRVg5GWjNvu8UBbB52LvqqnrTI5JLt1oh7ry53Np
         s4bcy+rvyEfDdXFjJ6vXvJCFH2ManR+5J/YFLC24i0e+0Ez5Eq4TmjEfQOLr4QhcQ8rN
         8ewsUBg9tXdj7Bd4B5j1XsDD8KJVOq3lvBgfxCJBKtHzdURnwdgebOej3qU4jHQdZKCD
         lZGcv46Q0/y8MvofaYOg8R0vt+Cp4G/vZaWCt25kdoLrFEQ6hepm0a0IvivdCgyjPKWP
         XxEw==
X-Gm-Message-State: AC+VfDxl/YfzNkbDEyuOz6XBowU7bI6ghS1zmfufukFd5HMsVWMam8ZU
	/QaZ1hJfHfGzS0Pndz/lZWJGHSznPbbDcnQ0uAh4XCPHq0ZHeHyYsuEHgFsWOTRp2CGkUQh/5UA
	ERwRhMcKE5YSC7noZwPDTbMfoDBem
X-Received: by 2002:a05:600c:2290:b0:3fb:4165:9deb with SMTP id 16-20020a05600c229000b003fb41659debmr2627585wmf.18.1688144171861;
        Fri, 30 Jun 2023 09:56:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5UR0nDa5ZeniZA5HGYvfqasFkjlcvPgRjApqCWoLfjSIcVJhl8UlRlADr4XobvRxIigldbKw==
X-Received: by 2002:a05:600c:2290:b0:3fb:4165:9deb with SMTP id 16-20020a05600c229000b003fb41659debmr2627561wmf.18.1688144171275;
        Fri, 30 Jun 2023 09:56:11 -0700 (PDT)
Date: Fri, 30 Jun 2023 12:56:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>
Message-ID: <20230630124537-mutt-send-email-mst@kernel.org>
References: <PH0PR12MB548127F715FC8B9FB14B5614DC25A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230630005420.GC77232@h68b04307.sqa.eu95>
 <PH0PR12MB54816F7B067539DF4B09C2BFDC2AA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <b957023f-a015-1622-531b-50b6931d974e@linux.alibaba.com>
 <20230630014917-mutt-send-email-mst@kernel.org>
 <bd010577-9a85-72f9-9af6-4289a482b991@linux.alibaba.com>
 <20230630041337-mutt-send-email-mst@kernel.org>
 <38fe3702-ea32-0d4a-fe23-cc7dbc823415@linux.alibaba.com>
 <20230630102758-mutt-send-email-mst@kernel.org>
 <20230630160909.GA43312@h68b04307.sqa.eu95>
MIME-Version: 1.0
In-Reply-To: <20230630160909.GA43312@h68b04307.sqa.eu95>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] Re:
 [virtio-dev] RE: [virtio-comment] RE: [PATCH v19] virtio-net: support inner
 header hash

On Sat, Jul 01, 2023 at 12:09:09AM +0800, Heng Qi wrote:
> On Fri, Jun 30, 2023 at 10:52:25AM -0400, Michael S. Tsirkin wrote:
> > On Fri, Jun 30, 2023 at 10:04:08PM +0800, Heng Qi wrote:
> > > 
> > > 
> > > 在 2023/6/30 下午4:17, Michael S. Tsirkin 写道:
> > > > On Fri, Jun 30, 2023 at 02:15:13PM +0800, Heng Qi wrote:
> > > > > 
> > > > > 在 2023/6/30 下午1:59, Michael S. Tsirkin 写道:
> > > > > > On Fri, Jun 30, 2023 at 09:55:41AM +0800, Heng Qi wrote:
> > > > > > > 在 2023/6/30 上午9:36, Parav Pandit 写道:
> > > > > > > > > From: Heng Qi <hengqi@linux.alibaba.com>
> > > > > > > > > Sent: Thursday, June 29, 2023 8:54 PM
> > > > > > > > > 
> > > > > > > > > On Thu, Jun 29, 2023 at 04:59:28PM +0000, Parav Pandit wrote:
> > > > > > > > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > > > > > > > Sent: Thursday, June 29, 2023 7:48 AM
> > > > > > > > > > > > > struct virtio_net_hash_config reserved is fine.
> > > > > > > > > > > > +1.
> > > > > > > > > > > > 
> > > > > > > > > > > > Inner header hash is orthogonal to RSS, and it's fine to have its
> > > > > > > > > > > > own structure and commands.
> > > > > > > > > > > > There is no need to send additional RSS fields when we configure
> > > > > > > > > > > > inner header hash.
> > > > > > > > > > > > 
> > > > > > > > > > > > Thanks.
> > > > > > > > > > > Not RSS, hash calculations. It's not critical, but I note that
> > > > > > > > > > > practically you said you will enable this with symmetric hash so it
> > > > > > > > > > > makes sense to me to send this in the same command with the key.
> > > > > > > > > > > 
> > > > > > > > > > In the v19, we have,
> > > > > > > > > > 
> > > > > > > > > > +\item[VIRTIO_NET_F_HASH_TUNNEL] Requires VIRTIO_NET_F_CTRL_VQ
> > > > > > > > > along with VIRTIO_NET_F_RSS or VIRTIO_NET_F_HASH_REPORT.
> > > > > > > > > > So it is done along with rss, so in same struct as rss config is fine.
> > > > > > > > > Do you mean having both virtio_net_rss_config and virtio_net_hash_config
> > > > > > > > > have enabled_hash_types?
> > > > > > > > > Like this:
> > > > > > > > > 
> > > > > > > > > struct virtio_net_rss_config {
> > > > > > > > >         le32 hash_types;
> > > > > > > > >         le16 indirection_table_mask;
> > > > > > > > >         struct rss_rq_id unclassified_queue;
> > > > > > > > >         struct rss_rq_id indirection_table[indirection_table_length];
> > > > > > > > >         le16 max_tx_vq;
> > > > > > > > >         u8 hash_key_length;
> > > > > > > > >         u8 hash_key_data[hash_key_length];
> > > > > > > > > +    le32 enabled_tunnel_types;
> > > > > > > > > };
> > > > > > > > > 
> > > > > > > > > struct virtio_net_hash_config {
> > > > > > > > >         le32 hash_types;
> > > > > > > > > -    le16 reserved[4];
> > > > > > > > > +    le32 enabled_tunnel_types;
> > > > > > > > > +    le16 reserved[2];
> > > > > > > > >         u8 hash_key_length;
> > > > > > > > >         u8 hash_key_data[hash_key_length];
> > > > > > > > > };
> > > > > > Oh, I forgot that rss and hash had identical structures.
> > > > > > And we want to keep that I think.
> > > > > > 
> > > > > > But now it's not clear to me: does the same enabled_tunnel_types
> > > > > > apply to both hash calculation and rss?
> > > > > Yes. What I'm trying to say is that making the inner header hash and
> > > > > RSS/hash calculation clear delimitation will make everything easier.
> > > > > The inner header hash just configures enabled_tunnel_types.
> > > > > The RSS/hash calculation is configured as before without modification.
> > > > > 
> > > > > > I note we normally have separate configs for hash and rss.
> > > > > > So to keep it consistent what should we do? two set commands?
> > > > > As I explained above, like outer udp port hash/symmetric toeplitz hash,
> > > > > these fall under the umbrella of RSS/hash calculation.
> > > > Yes but note that symmetric toeplitz hash has to be configured
> > > > separately for RSS and for hashing.
> > > 
> > > Yes, this requires a field like \field{mode}, with different values
> > > corresponding to different hashing algorithms, such as toeplitz or symmetric
> > > toeplitz.
> > > The outer port hash belongs to RSS/hash calculation.
> > 
> > So there will be need for more fields.
> 
> Yes, the mode field is outside of RSS/hash, as it should be at a higher
> level than RSS/hash.
> 
> > To me this implies extending with struct virtio_net_rss_tunnel_config
> > is a better idea since we then have some reserved space to
> > put "mode" down the road (in the reserved[6] space below).
> > 
> > No?
> > 
> > > > 
> > > > > Let's keep the inner header hash simple.
> > > > > 
> > > > > > Or does enabled_tunnel_types apply to both rss and hash?
> > > > > Certainly. See:
> > > > > 
> > > > >      +\item[VIRTIO_NET_F_HASH_TUNNEL] Requires VIRTIO_NET_F_CTRL_VQ along
> > > > > with VIRTIO_NET_F_RSS or VIRTIO_NET_F_HASH_REPORT.
> > > > 
> > > > It does not really say that.
> > > Oh! I understand now. I think a VIRTIO_NET_CTRL_HASH_TUNNEL_SET command is
> > > applied to hash and RSS. Yes.
> > > When one wants to configure inner header hash separately, use
> > > VIRTIO_NET_CTRL_HASH_TUNNEL_SET command to send enabled_tunnel_types
> > > separately.
> > > When one wants to configure both inner header hash and RSS/hash, use
> > > VIRTIO_NET_CTRL_HASH_TUNNEL_SET together with
> > > VIRTIO_NET_CTRL_MQ_RSS_CONFIG/VIRTIO_NET_CTRL_MQ_HASH_CONFIG.
> > > The inner header hash is decoupled from RSS/hash, and no extra fields will
> > > be sent every configuration.
> > 
> > But why is tunnel so different? Rest of things can be configured
> > for hash and for rss separately.
> > 
> 
> It dawned on me where we were not aligned. Please see more.
> 
> > 
> > For example I can configure hash for IPv4 and IPv6 but RSS only for
> > IPv6.
> 
> Can we have this behavior?
> I don't think so, RSS and Hash have the same device configuration, which
> is determined by the *last* *device-received* command of the VIRTIO_NET_CTRL_MQ class.
> See the spec:
> "If more than one multiqueue mode is negotiated, the resulting device
> configuration is defined by the last command sent by the driver."

Oh I was confused. You are right, also this:

If the feature VIRTIO_NET_F_RSS was negotiated:
\begin{itemize}
\item The device uses \field{hash_types} of the virtio_net_rss_config structure as 'Enabled hash types' bitmask.
\item The device uses a key as defined in \field{hash_key_data} and \field{hash_key_length} of the virtio_net_rss_config structure (see
\ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) / Setting RSS parameters}).
\end{itemize}
        
If the feature VIRTIO_NET_F_RSS was not negotiated:
\begin{itemize}
\item The device uses \field{hash_types} of the virtio_net_hash_config structure as 'Enabled hash types' bitmask.
\item The device uses a key as defined in \field{hash_key_data} and \field{hash_key_length} of the virtio_net_hash_config structure (see
\ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode / Hash calculation}).
\end{itemize}

Sorry about making this noise. I thought I saw a bug.

> > But for some reason, if I configure tunnel for GRE it will
> > affect both hash and RSS. Why? It seems quite possible to me that I
> > was offload for hash for GRE but don't want to use it
> > for RSS to avoid RX underrun issues we discussed.
> 
> This makes sense. So the scenario you are referring to should be:
> The configuration of RSS/HASH is IPV6, but we have configured
> GRE_rfc2784 (both inner and outer headers are IPv4). When the
> device receives a GRE_rfc2784 packet, which matches the GRE_rfc2784
> encapsulation type, and then the device need to calculate the hash
> based on RSS/Hash, but it turns out that the configured IPv6 of RSS/hash
> does not match the inner IPv4. Then nothing happened.  ?

That would be my understanding too.


> If yes, I agree to virtio_net_rss_tunnel_config and virtio_net_hash_tunnel_config.

Or even name them virtio_net_rss_ext_config and virtio_net_hash_ext_config
as we expect to use them down the road for other stuff.


But since you have corrected my mistake above, a separate SET is ok too.
And this is what was reviewed in the last 5 revisions or so. You decide.

> > 
> > 
> > > > 
> > > > 
> > > > 
> > > > > > We should have reserved more space. We can still do it if you like:
> > > > > > 
> > > > > > struct virtio_net_rss_tunnel_config {
> > > > > >         le32 enabled_tunnel_types;
> > > > > >         le16 reserved[6];
> > > > > >         struct virtio_net_rss_config hash;
> > > > > > };
> > > > > > 
> > > > > > struct virtio_net_hash_tunnel_config {
> > > > > >         le32 enabled_tunnel_types;
> > > > > >         le16 reserved[6];
> > > > > >         struct virtio_net_hash_config hash;
> > > > > > };
> > > > > > 
> > > > > > ?
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > > > > If yes, this should have been discussed in v10 [1] before, enabled_tunnel_types
> > > > > > > > > in virtio_net_rss_config will follow the variable length field and cause
> > > > > > > > > misalignment.
> > > > > > > > > 
> > > > > > > > > If we let the inner header hash reuse the virtio_net_hash_config structure, it
> > > > > > > > > can work, but the only disadvantage is that the configuration of the inner
> > > > > > > > > header hash and *RSS*(not hash calculations) becomes somewhat coupled.
> > > > > > > > > Just imagine:
> > > > > > > > > If the driver and the device negotiated VIRTIO_NET_F_HASH_TUNNEL and
> > > > > > > > > VIRTIO_NET_F_RSS, but did not negotiate VIRTIO_NET_F_HASH_REPORT, 1.
> > > > > > > > > then if we only want to configure the inner header hash (such as
> > > > > > > > > enabled_tunnel_types), it is good for us to send virtio_net_hash_config alone;
> > > > > > > > > 2. but then if we want to configure the inner header hash and RSS (such as
> > > > > > > > > indirection table), we need to send all virtio_net_rss_config and
> > > > > > > > > virtio_net_hash_config once, because virtio_net_rss_config now does not carry
> > > > > > > > > enabled_tunnel_types due to misalignment.
> > > > > > > > > 
> > > > > > > > > So, I think the following structure will make it clearer to configure inner header
> > > > > > > > > hash and RSS/hash calculation.
> > > > > > > > > But in any case, if we still propose to reuse virtio_net_hash_config proposal, I
> > > > > > > > > am ok, no objection:
> > > > > > > > > 
> > > > > > > > > 1. The supported_tunnel_types are placed in the device config space;
> > > > > > > > > 
> > > > > > > > Yes. I forgot the variable length part.
> > > > > > > > The second disadvantage I remember now is one need to resupply all the rss hash config parameter and device needs to compare and modify for this one field.
> > > > > > Or it could be an advantage since one normally wants to configure a
> > > > > > symmetric key with this. Further device can just use the new config
> > > > > When we want to configure the hash key, he continues to use the previous
> > > > > rss/hash calculation interface. This is ok.
> > > > > 
> > > > > Thanks.
> > > > I don't understand this sentence. My point is simply that
> > > > to use the tunnel key has to be symmetric. So two commands
> > > > will be required: one to set tunnel types, one to
> > > > set the key.
> > > 
> > > Yes, you are right. Then one should be VIRTIO_NET_CTRL_HASH_TUNNEL_SET and
> > > the other
> > > should be VIRTIO_NET_CTRL_MQ_RSS_CONFIG/VIRTIO_NET_CTRL_MQ_HASH_CONFIG.
> > > 
> > > Thanks.
> > 
> > Well that is still 1 command for tunnels that affects both rss and
> > hashing. Why not 2 commands for rss and for hashing?
> > 
> 
> I think I get you now.
> 
> If the above is correct, then I think we should have the following:
> VIRTIO_NET_CTRL_TUNNEL_RSS -> virtio_net_rss_tunnel_config
> VIRTIO_NET_CTRL_TUNNEL_HASH -> virtio_net_hash_tunnel_config
> 
> ?
> 
> Thanks!
> 
> > 
> > > > 
> > > > > > with no need to check what the old one was. I'd call it a wash.
> > > > > > 
> > > > > > > > Given these two disadvantages, I also prefer independent SET command the way you have it.
> > > > > > > OK, let's wait for Michael's input again.
> > > > > > > 
> > > > > > > Thanks.
> > > > > > This part is not critical to me, but now I understand we need two sets of SET commands.
> > > > > > 
> > > > > > 
> > > > > > > > > 2.
> > > > > > > > > Reserve the following structure:
> > > > > > > > > 
> > > > > > > > >          struct virtnet_hash_tunnel {
> > > > > > > > > le32 enabled_tunnel_types;
> > > > > > > > >          };
> > > > > > > > > 
> > > > > > > > > 3. Reserve the SET command for enabled_tunnel_types and remove the GET
> > > > > > > > > command for enabled_tunnel_types.
> > > > > > > > > 
> > > > > > > > > [1] https://lists.oasis-open.org/archives/virtio-dev/202303/msg00317.html
> > > > > > > > > 
> > > > > > > > > Thanks a lot!
> > > > > > ---------------------------------------------------------------------
> > > > > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > > > > > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
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
> > > > List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> > > > Committee: https://www.oasis-open.org/committees/virtio/
> > > > Join OASIS: https://www.oasis-open.org/join/


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

