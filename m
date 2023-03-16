Return-Path: <virtio-dev-return-11644-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D52C6FD19
	for <virtio-dev@archiver.kernel.org>; Thu, 16 Mar 2023 13:38:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 77A3B2AC6D
	for <virtio-dev@archiver.kernel.org>; Thu, 16 Mar 2023 13:38:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6AD8A98643E
	for <virtio-dev@archiver.kernel.org>; Thu, 16 Mar 2023 13:38:51 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5F348983E51; Thu, 16 Mar 2023 13:38:51 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4AE999863D7;
	Thu, 16 Mar 2023 13:38:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Ve.Tc9-_1678973924;
Date: Thu, 16 Mar 2023 21:38:44 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org,
	virtio-comment@lists.oasis-open.org,
	Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230316133844.GB20524@h68b04307.sqa.eu95>
References: <20230306154817.14115-1-hengqi@linux.alibaba.com>
 <c81de233-227c-73c8-a4bd-d43aa374dd86@nvidia.com>
 <e573702a-9a2e-d210-f13a-f0b241442991@linux.alibaba.com>
 <9f6286ea-51b2-dcc0-86c9-66509d92d8c2@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f6286ea-51b2-dcc0-86c9-66509d92d8c2@nvidia.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v10] virtio-net: support inner
 header hash

On Wed, Mar 15, 2023 at 07:06:53PM -0400, Parav Pandit wrote:
> 
> 
> On 3/15/2023 9:19 AM, Heng Qi wrote:
> >
> >
> >在 2023/3/15 上午11:23, Parav Pandit 写道:
> >>
> >>
> >>On 3/6/2023 10:48 AM, Heng Qi wrote:
> >>
> [..]
> >>>  \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
> >>>+\item[VIRTIO_NET_F_HASH_TUNNEL] Requires VIRTIO_NET_F_CTRL_VQ.
> >>I think this should also say that HASH_TUNNEL requires either of
> >>the F_RSS or F_HASH_REPORT.
> >>Because without it HASH_TUNNEL is not useful.
> >
> >F_HASH_TUNNEL indicates that the hash should be calculated using
> >the inner packet header, even without F_RSS or F_HASH_REPORT,
> >we can continue to use the hash value in scenarios such as RPS or
> >ebpf programs.
> Yes.
> Even for rps or ebpf programs, F_HASH_TUNNEL is fine.
> When such feature arrives in future, it above line will have OR
> condition for RPS feature bit.
> 
> >
> >
> >I think it's fine to let F_HASH_TUNNEL rely on F_RSS or
> >_F_HASH_REPORT as those are probably important scenarios where
> >inner packet header hash is used.
> Yes.
> 
> >>If not, for now it may be better to skip vxlan and nvegre as
> >>they inherently have unique outer header UDP src port based on
> >>the inner header.
> >
> >Symmetric hashing ignores the order of the five-tuples when
> >calculating the hash, that is, using (a1,a2,p1,p2) and
> >(a2,a1,p2,p1) respectively can calculate the same hash.
> >There is a scenario that the two directions client1->client2 and
> >client2->client1 of the same flow may pass through different
> >tunnels.
> >In order to allow the data in two directions to be processed by
> >the same CPU, we need to calculate a symmetric hash based on the
> >inner packet header.
> I am lost in two directions and two clients above.
> When you say two directions, do you mean tx and rx?
> and do symmetric hashing between tx and rx between two end points
> within single tunnel?
>

A rough description of this scene is as follows:
Client1 sends packets to client2, and client2 sends packets to client1 respectively.
This is called two directions, and they are in the same flow.
The packets in the two directions may reach the processing host through
different tunnels. In this scenario, we need to hash these packets to the
same queue for the same cpu to process, so inner symmetric hashing is required.


client1                   client2
    |                         |
    |      __________         |
    +----->| tunnels |<-------+
           |---------|
              |  |
              |  |
              |  |
              v  v
        +-----------------+
        | processing host |
        +-----------------+


> >>>+\field{hash_tunnel_types} is set to
> >>>VIRTIO_NET_HASH_TUNNEL_TYPE_NONE by the device for the
> >>>+unencapsulated packets.
> >>>+
> I missed this before. unencapsulated is not a term.
> s/unencapsulated packets/Non encapsulated packets or non tunneled packets
> 

Yes, you are right!

Thanks.

> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
> 
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
> 
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

