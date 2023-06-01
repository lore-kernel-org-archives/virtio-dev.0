Return-Path: <virtio-dev-return-12833-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3664C7EE23
	for <virtio-dev@archiver.kernel.org>; Thu,  1 Jun 2023 05:17:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 38BC344560
	for <virtio-dev@archiver.kernel.org>; Thu,  1 Jun 2023 05:17:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2E5F698661F
	for <virtio-dev@archiver.kernel.org>; Thu,  1 Jun 2023 05:17:16 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 20237986608; Thu,  1 Jun 2023 05:17:16 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 09EEB986605;
	Thu,  1 Jun 2023 05:17:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vk08UW0_1685596628;
Date: Thu, 1 Jun 2023 13:17:08 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org,
	Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230601051708.GC98474@h68b04307.sqa.eu95>
References: <20230522050236.49433-1-hengqi@linux.alibaba.com>
 <20230522151522-mutt-send-email-mst@kernel.org>
 <20230523035803.GB23504@h68b04307.sqa.eu95>
 <69cd31d4-c059-3edd-f14b-bdf03ac4b200@linux.alibaba.com>
 <20230530153623-mutt-send-email-mst@kernel.org>
 <20230601002734-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230601002734-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Subject: Re: [virtio-dev] Re: [virtio-comment] Re: [PATCH v14] virtio-net:
 support inner header hash

On Thu, Jun 01, 2023 at 12:30:30AM -0400, Michael S. Tsirkin wrote:
> On Tue, May 30, 2023 at 03:40:18PM -0400, Michael S. Tsirkin wrote:
> > On Fri, May 26, 2023 at 04:04:18PM +0800, Heng Qi wrote:
> > > 
> > > 
> > > 在 2023/5/23 上午11:58, Heng Qi 写道:
> > > > On Mon, May 22, 2023 at 03:19:16PM -0400, Michael S. Tsirkin wrote:
> > > > > On Mon, May 22, 2023 at 01:02:36PM +0800, Heng Qi wrote:
> > > > > > 1. Currently, a received encapsulated packet has an outer and an inner header, but
> > > > > > the virtio device is unable to calculate the hash for the inner header. The same
> > > > > > flow can traverse through different tunnels, resulting in the encapsulated
> > > > > > packets being spread across multiple receive queues (refer to the figure below).
> > > > > > However, in certain scenarios, we may need to direct these encapsulated packets of
> > > > > > the same flow to a single receive queue. This facilitates the processing
> > > > > > of the flow by the same CPU to improve performance (warm caches, less locking, etc.).
> > > > > > 
> > > > > >                 client1                    client2
> > > > > >                    |        +-------+         |
> > > > > >                    +------->|tunnels|<--------+
> > > > > >                             +-------+
> > > > > >                                |  |
> > > > > >                                v  v
> > > > > >                        +-----------------+
> > > > > >                        | monitoring host |
> > > > > >                        +-----------------+
> > > > > > 
> > > > > > To achieve this, the device can calculate a symmetric hash based on the inner headers
> > > > > > of the same flow.
> > > > > > 
> > > > > > 2. For legacy systems, they may lack entropy fields which modern protocols have in
> > > > > > the outer header, resulting in multiple flows with the same outer header but
> > > > > > different inner headers being directed to the same receive queue. This results in
> > > > > > poor receive performance.
> > > > > > 
> > > > > > To address this limitation, inner header hash can be used to enable the device to advertise
> > > > > > the capability to calculate the hash for the inner packet, regaining better receive performance.
> > > > > > 
> > > > > > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > > > > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > ---
> > > > > > v13->v14:
> > > > > > 	1. Move supported_hash_tunnel_types from config space into cvq command. @Parav Pandit
> > > > > > 	2. Rebase to master branch.
> > > > > > 	3. Some minor modifications.
> > > > > So, I proposed adding a "generic UDP tunnel" option which simply uses UDP source
> > > > > port for hash. I think it will help us not having to chaise future tunnels as
> > > > > more and more are added.
> > > > I agree, but I thought we'd do this in another thread, sorry.
> > > > Following your suggestion, we should add a field similar to
> > > > \field{generic_udp_tunnel_option} in the virtnet_hash_tunnel_config_set
> > > > structure.
> > > > 
> > > > \field{generic_udp_tunnel_option} should be 0, 1 or 2.
> > > > 
> > > > \field{hash_tunnel_types} is still useful, but for more general purpose we need
> > > > to use it together with \field{generic_udp_tunnel_option}.
> > > > 
> > > > When \field{generic_udp_tunnel_option} is 0, all tunneling protocols included in
> > > > \field{hash_tunnel_types} use the inner header for hashing. For other tunnel
> > > > protocols not included in \field{hash_tunnel_types}, the hash is calculated as if
> > > > VIRTIO_NET_F_TUNNEL_HASH is not negotiated.
> > > > 
> > > > When \field{generic_udp_tunnel_option} is 1, all tunneling protocols included in
> > > > \field{hash_tunnel_types} use the inner header for hashing. For other tunnel
> > > > protocols not included in \field{hash_tunnel_types}, if their outer headers are
> > > > based on UDP protocol, the device use the outer UDP source port for hashing.
> > > > For the rest of the tunnel protocols, the hash is calculated as if VIRTIO_NET_F_TUNNEL_HASH
> > > > was not negotiated.
> > > > 
> > > > When \field{generic_udp_tunnel_option} is 2, for all UDP tunneling protocols,
> > > > the outer udp source port is used for hashing, otherwise if the tunneling protocol
> > > > is included in \field{hash_tunnel_types}, the inner header is used for hashing.
> > > > For the rest of the tunnel protocols, the hash is calculated as if VIRTIO_NET_F_TUNNEL_HASH
> > > > was not negotiated.
> > > > 
> > > > And for this option, we need to add a reminder:
> > > > Although the \field{generic_udp_tunnel_option} helps us adapt to more new
> > > > tunneling protocols, it is still an unreliable option, especially for
> > > > tunneling protocols that use "SHOULD" "Recommended" in their own
> > > > specifications, because it means the udp source port does not
> > > > always fully identify a stream.
> > > > 
> > > 
> > > Hi, Michael.
> > > 
> > > Do you agree with this plan? Please let me know if you have any comments.:)
> > > 
> > > If there are no comments, I can start a new version to make progress.
> > > 
> > > Thanks.
> > 
> > How are "tunneling protocols" defined though?
> > 
> > Maybe pass a mask of destination UDP ports for which this applies?
> > 
> > Then we don't need options, if port is set in mask then
> > generic udp tunnel inner hash applies. If port is not set then
> > hash is calculated in some other way, including
> > one of tunnel specific flags.
> 
> I admit this is pretty complex though. As an intermediate step
> I can see two other options:
> - just do this for all UDP packets assuming most traffic is encapsulated

This is a bit crude, but it does simplify the complexity of device
implementations.

> - assume that the list of protocols is configured in the NIC
>   by other means (e.g. hard-coded, or we can add an admin command for this)

Other means also means hardcoding, because we always need to know what
the "new tunnel type" is, otherwise the driver can't understand it.

Assuming we don't use any hard-coded tunnel types for the
VIRTIO_NET_F_TUNNEL_HASH feature, then we use the GET command to get the
tunnel types supported by the device before we intend to use the
inner header hashing capabilities. But if we don't do mappings for
these codes, the driver can't understand what the device returns. Then
we need to hardcode it...

So I tend to dst port mask, or generic option (set to 1 to use source
port for all UDP packets).

Thanks.

> 
> Thoghts?
> 
> 
> > 
> > > > > I also suggested dropping some tunnels which are less common and where
> > > > > the specification is unambiguous enough that source port should include
> > > > > inner hash.
> > > > OK, I'll re-screen and update the tunneling protocols we already include
> > > > (e.g. remove STT since it fits what you said).
> > > > 
> > > > Thanks.
> > > > 
> > > > ---------------------------------------------------------------------
> > > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > > > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

