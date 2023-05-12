Return-Path: <virtio-dev-return-12666-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DABC77B7C
	for <virtio-dev@archiver.kernel.org>; Fri, 12 May 2023 07:23:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0A974866B0
	for <virtio-dev@archiver.kernel.org>; Fri, 12 May 2023 07:23:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F3D469866F5
	for <virtio-dev@archiver.kernel.org>; Fri, 12 May 2023 07:23:53 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E57A69866DB; Fri, 12 May 2023 07:23:53 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D2D739866D9;
	Fri, 12 May 2023 07:23:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0ViOCF03_1683876226;
Date: Fri, 12 May 2023 15:23:46 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230512072345.GB106739@h68b04307.sqa.eu95>
References: <5463159d-daa2-101b-6abf-ea7aa4f40bd0@linux.alibaba.com>
 <20230427130008-mutt-send-email-mst@kernel.org>
 <20230505135115.GA110622@h68b04307.sqa.eu95>
 <20230505105427-mutt-send-email-mst@kernel.org>
 <e3930c64-b7eb-a01e-39c9-0fe718756185@linux.alibaba.com>
 <20230509110941-mutt-send-email-mst@kernel.org>
 <13fe574e-19da-b842-76cc-4a729a86d676@linux.alibaba.com>
 <20230511021050-mutt-send-email-mst@kernel.org>
 <20230512060019.GA106739@h68b04307.sqa.eu95>
 <20230512024006-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230512024006-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] Re:
 [virtio-dev] Re: [virtio-comment] [PATCH v13] virtio-net: support inner
 header hash

On Fri, May 12, 2023 at 02:54:34AM -0400, Michael S. Tsirkin wrote:
> On Fri, May 12, 2023 at 02:00:19PM +0800, Heng Qi wrote:
> > On Thu, May 11, 2023 at 02:22:12AM -0400, Michael S. Tsirkin wrote:
> > > On Wed, May 10, 2023 at 05:15:37PM +0800, Heng Qi wrote:
> > > > 
> > > > 
> > > > 在 2023/5/9 下午11:15, Michael S. Tsirkin 写道:
> > > > > On Tue, May 09, 2023 at 10:22:19PM +0800, Heng Qi wrote:
> > > > > > 
> > > > > > 在 2023/5/5 下午10:56, Michael S. Tsirkin 写道:
> > > > > > > On Fri, May 05, 2023 at 09:51:15PM +0800, Heng Qi wrote:
> > > > > > > > On Thu, Apr 27, 2023 at 01:13:29PM -0400, Michael S. Tsirkin wrote:
> > > > > > > > > On Thu, Apr 27, 2023 at 10:28:29AM +0800, Heng Qi wrote:
> > > > > > > > > > 在 2023/4/26 下午10:48, Michael S. Tsirkin 写道:
> > > > > > > > > > > On Wed, Apr 26, 2023 at 10:14:30PM +0800, Heng Qi wrote:
> > > > > > > > > > > > This does not mean that every device needs to implement and support all of
> > > > > > > > > > > > these, they can choose to support some protocols they want.
> > > > > > > > > > > > 
> > > > > > > > > > > > I add these because we have scale application scenarios for modern protocols
> > > > > > > > > > > > VXLAN-GPE/GENEVE:
> > > > > > > > > > > > 
> > > > > > > > > > > > +\item In scenarios where the same flow passing through different tunnels is expected to be received in the same queue,
> > > > > > > > > > > > +      warm caches, lessing locking, etc. are optimized to obtain receiving performance.
> > > > > > > > > > > > 
> > > > > > > > > > > > 
> > > > > > > > > > > > Maybe the legacy GRE, VXLAN-GPE and GENEVE? But it has a little crossover.
> > > > > > > > > > > > 
> > > > > > > > > > > > Thanks.
> > > > > > > > > > > But VXLAN-GPE/GENEVE can use source port for entropy.
> > > > > > > > > > > 
> > > > > > > > > > > 	It is recommended that the UDP source port number
> > > > > > > > > > > 	 be calculated using a hash of fields from the inner packet
> > > > > > > > > > > 
> > > > > > > > > > > That is best because
> > > > > > > > > > > it allows end to end control and is protocol agnostic.
> > > > > > > > > > Yes. I agree with this, I don't think we have an argument on this point
> > > > > > > > > > right now.:)
> > > > > > > > > > 
> > > > > > > > > > For VXLAN-GPE/GENEVE or other modern tunneling protocols, we have to deal
> > > > > > > > > > with
> > > > > > > > > > scenarios where the same flow passes through different tunnels.
> > > > > > > > > > 
> > > > > > > > > > Having them hashed to the same rx queue, is hard to do via outer headers.
> > > > > > > > > > > All that is missing is symmetric Toepliz and all is well?
> > > > > > > > > > The scenarios above or in the commit log also require inner headers.
> > > > > > > > > Hmm I am not sure I get it 100%.
> > > > > > > > > Could you show an example with inner header hash in the port #,
> > > > > > > > > hash is symmetric, and you still have trouble?
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > It kinds of sounds like not enough entropy is not the problem
> > > > > > > > > at this point.
> > > > > > > > Sorry for the late reply. :)
> > > > > > > > 
> > > > > > > > For modern tunneling protocols, yes.
> > > > > > > > 
> > > > > > > > > You now want to drop everything from the header
> > > > > > > > > except the UDP source port. Is that a fair summary?
> > > > > > > > > 
> > > > > > > > For example, for the same flow passing through different VXLAN tunnels,
> > > > > > > > packets in this flow have the same inner header and different outer
> > > > > > > > headers. Sometimes these packets of the flow need to be hashed to the
> > > > > > > > same rxq, then we can use the inner header as the hash input.
> > > > > > > > 
> > > > > > > > Thanks!
> > > > > > > So, they will have the same source port yes?
> > > > > > Yes. The outer source port can be calculated using the 5-tuple of the
> > > > > > original packet,
> > > > > > and the outer ports are the same but the outer IPs are different after
> > > > > > different directions of the same flow pass through different tunnels.
> > > > > > > Any way to use that
> > > > > > We use it in monitoring, firewall and other scenarios.
> > > > > > 
> > > > > > > so we don't depend on a specific protocol?
> > > > > > Yes, selected tunneling protocols can be used in this scenario like this.
> > > > > > 
> > > > > > Thanks.
> > > > > > 
> > > > > No, the question was - can we generalize this somehow then?
> > > > > For example, a flag to ignore source IP when hashing?
> > > > > Or maybe just for UDP packets?
> > > > 
> > > > 1. I think the common solution is based on the inner header, so that
> > > > GRE/IPIP tunnels can also enjoy inner symmetric hashing.
> > > > 
> > > > 2. The VXLAN spec does not show that the outer source port in both
> > > > directions of the same flow must be the same [1]
> > > > (although the outer source port is calculated based on the consistent hash
> > > > in the kernel. The consistent hash will sort the five-tuple before
> > > > calculating hashing),
> > > > but it is best not to assume that consistent hashing is used in all VXLAN
> > > > implementations.
> > > 
> > > I agree, best not to assume if it's not in the spec.
> > > The requirement to hash two sides to same queue might
> > > not be necessary for everyone though, right?
> > 
> > The outer source port is also not reliable when it needs to be hashed to
> > the same queue, but the inner header identifies a flow reliably and
> > universally.
> > 
> > > 
> > > > The GENEVE spec uses "SHOUlD"[2].
> > > 
> > > What about other tunnels? Could you summarize please?
> > 
> > Sure.
> > 
> > The VXLAN spec[1] does not show that the outer source port in both
> > directions of the same flow must be the same.
> > 
> > VXLAN-GPE[2]("SHOULD")/GENEVE[3]("SHOULD")/GRE-in-UDP[4.1]/STT[5]
> > recommend that the outer source port of the same flow be calculated
> > based on the inner header hash and set to the same.
> > 
> > But the udp source port of GRE-in-UDP may be used in a scenario similar
> > to NAPT [4.2], where the udp source port is no longer used for entropy,
> > but for identifying different internal hosts. So using udp source port
> > does not identify the same stream. This is why using the inner header is
> > more general, since information about the original stream can reliably
> > identify a flow.
> > 
> > [1] "Source Port: It is recommended that the UDP source port number be
> > calculated using a hash of fields from the inner packet -- one example
> > being a hash of the inner Ethernet frame's headers. This is to enable a
> > level of entropy for the ECMP/load-balancing of the VM-to-VM traffic
> > across the VXLAN overlay. When calculating the UDP source port number in
> > this manner, it is RECOMMENDED that the value be in the dynamic/private
> > port range 49152-65535 [RFC6335]"
> > 
> > [2] "Source UDP Port: The source UDP port is used as entropy for devices
> > forwarding encapsulated packets across the underlay (ECMP for IP routers,
> > or load splitting for link aggregation by bridges). Tenant traffic flows
> > should all use the same source UDP port to lower the chances of packet
> > reordering by the underlay for a given flow. It is recommended for VTEPs
> > to generate this port number using a hash of the inner packet headers.
> > Implementations MAY use the entire 16 bit source UDP port for entropy."
> > 
> > [3] "Source Port: A source port selected by the originating tunnel
> > endpoint. This source port SHOULD be the same for all packets belonging
> > to a single encapsulated flow to prevent reordering due to the use of
> > different paths. To encourage an even distribution of flows across
> > multiple links, the source port SHOULD be calculated using a hash of the
> > encapsulated packet headers using, for example, a traditional 5-tuple.
> > Since the port represents a flow identifier rather than a true UDP
> > connection, the entire 16-bit range MAY be used to maximize entropy."
> > 
> > [4.1] "GRE-in-UDP permits the UDP source port value to be used to encode
> > an entropy value. The UDP source port contains a 16-bit entropy value
> > that is generated by the encapsulator to identify a flow for the
> > encapsulated packet. The port value SHOULD be within the ephemeral port
> > range, i.e., 49152 to 65535, where the high-order two bits of the port
> > are set to one. This provides fourteen bits of entropy for the inner
> > flow identifier. In the case that an encapsulator is unable to derive
> > flow entropy from the payload header or the entropy usage has to be
> > disabled to meet operational requirements (see Section 7), to avoid
> > reordering with a packet flow, the encapsulator SHOULD use the same UDP
> > source port value for all packets assigned to a flow, e.g., the result
> > of an algorithm that performs a hash of the tunnel ingress and egress IP
> > address."
> > 
> > [4.2] "use of the UDP source port for entropy may impact middleboxes'
> > behavior. If a GRE-in-UDP tunnel is expected to be used on a path
> > with a middlebox, the tunnel can be configured either to disable use
> > of the UDP source port for entropy or to enable middleboxes to pass
> > packets with UDP source port entropy."
> > 
> > [5] "STT achieves the first goal by ensuring that the source and
> > destination ports and addresses in the outer header are all the same for
> > a single flow.  The second goal is achieved by generating the source
> > port using a random hash of fields in the headers of the inner packets,
> > e.g. the ports and addresses of the virtual flow's packets."
> 
> 
> 
> > > SHOULD means "if you ignore this
> > > things will work but not well".
> > > You mentioned concerns such as worse performance,
> > > this is fine with SHOULD.
> > 
> > That's it.
> > 
> > > Is inner hashing important for
> > > correctness sometimes?
> > 
> > I'm sorry I didn't understand this, can you explain it in more detail?
> 
> Do things actually break if inner hash is not enabled or is this
> a performance optimization?

Yes, the internal hash comes from our real internal needs, and the
application scenarios have a large scale. When the data traffic and
scale increase, this is very beneficial to our production efficiency and
cost. Performance optimization is not only an important direction of the
network, but also a manifestation of complete functionality. Based on
this, we have reason to believe that internal hashing will play a role
in future developments.

> 
> > > 
> > > > 3. How should we generalize? The device uses a feature to advertise all the
> > > > tunnel types it supports, and hashes these tunnel types using the outer
> > > > source port,
> > > > and then we still have to give the specific tunneling protocols supported by
> > > > the device, just like we do now.
> > > 
> > > Is it problematic to do this for all UDP packets?
> > 
> > I think there will be problems. While devices support configuring this,
> > drivers sometimes don't want devices to do special handling for certain
> > tunneling protocols.
> > 
> > Thanks.
> 
> I guess we can at least add a flag to do this (ignore IP addresses,
> just hash the port numbers) for all UDP packets?

Yes, I think this can also be used as a worker thread.

> Or maybe UDP4/UDP6 separately.
> Hopefully this will be enough to prevent getting requests
> to add more offloads in the future.

Agreed, and understand your concerns about this.

Thanks.
> 
> 
> > > 
> > > > [1] "Source Port: It is recommended that the UDP source port number be
> > > > calculated using a hash of fields from the inner packet -- one example
> > > > being a hash of the inner Ethernet frame's headers. This is to enable a
> > > > level of entropy for the ECMP/load-balancing of the VM-to-VM traffic across
> > > > the VXLAN overlay. When calculating the UDP source port number in this
> > > > manner, it is RECOMMENDED that the value be in the dynamic/private
> > > > port range 49152-65535 [RFC6335] "
> > > > 
> > > > [2] "Source Port: A source port selected by the originating tunnel endpoint.
> > > > This source port SHOULD be the same for all packets belonging to a
> > > > single encapsulated flow to prevent reordering due to the use of different
> > > > paths. To encourage an even distribution of flows across multiple links,
> > > > the source port SHOULD be calculated using a hash of the encapsulated packet
> > > > headers using, for example, a traditional 5-tuple. Since the port
> > > > represents a flow identifier rather than a true UDP connection, the entire
> > > > 16-bit range MAY be used to maximize entropy. In addition to setting the
> > > > source port, for IPv6, the flow label MAY also be used for providing
> > > > entropy. For an example of using the IPv6 flow label for tunnel use cases,
> > > > see [RFC6438]."
> > > > 
> > > > Thanks.
> > > > 
> > > > > 
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
> > > > List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> > > > Committee: https://www.oasis-open.org/committees/virtio/
> > > > Join OASIS: https://www.oasis-open.org/join/
> > > > 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

