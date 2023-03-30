Return-Path: <virtio-dev-return-11855-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC35C761A6
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 12:37:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AFD2229FCD
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 12:37:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9B79098654C
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 12:37:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8D43C986531; Thu, 30 Mar 2023 12:37:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 79490986533;
	Thu, 30 Mar 2023 12:37:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Vf-UF8w_1680179844;
Message-ID: <39f3ebf4-1141-8044-4ffc-e32e62edbb2c@linux.alibaba.com>
Date: Thu, 30 Mar 2023 20:37:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230218143715.841-1-hengqi@linux.alibaba.com>
 <20230228061309-mutt-send-email-mst@kernel.org>
 <25231225-59c8-91b0-e0dd-3dab8aa8164b@linux.alibaba.com>
 <20230308093311-mutt-send-email-mst@kernel.org>
 <c334a082-4b78-c7ea-e04a-6436f4965516@linux.alibaba.com>
 <20230309142612-mutt-send-email-mst@kernel.org>
 <021eeb40-aab1-07b9-cfe7-9dd61a32e0b3@linux.alibaba.com>
 <20230315074633-mutt-send-email-mst@kernel.org>
 <4b14043c-6059-1d26-060e-7dc653c4f401@linux.alibaba.com>
 <20230320154556-mutt-send-email-mst@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20230320154556-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] Re:
 [virtio-dev] Re: [PATCH v9] virtio-net: support inner header hash



在 2023/3/21 上午3:48, Michael S. Tsirkin 写道:
> On Wed, Mar 15, 2023 at 08:55:45PM +0800, Heng Qi wrote:
>> We use the most basic GRE header fields (not NVGRE), not even optional
>> fields.
> I'd say yes, the most convincing usecase is with legacy GRE.

Yes. But we still have a strong need for VXLAN and GENEVE to do 
symmetric hashing. Please consider this.

> Given that, do you need the rest of protocols there?

I would say that I checked the current tunneling protocols used for 
overlay networks and their respective RFC versions compared to each other.

They are:

1. GRE_rfc2784 :This protocol is only specified for IPv4 and used as 
either the payload or delivery protocol.
     link : https://datatracker.ietf.org/doc/rfc2784/

2. GRE_rfc2890: This protocol describes extensions by which two fields, 
Key and Sequence Number, can be optionally carried in the GRE Header.
     link: https://www.rfc-editor.org/rfc/rfc2890

3. GRE_rfc7676: IPv6 Support for Generic Routing Encapsulation (GRE). 
This protocol is specified for IPv6 and used as either the payload or 
delivery protocol.
     Note that this does not change the GRE header format or any 
behaviors specified by RFC 2784 or RFC 2890.
     link: https://datatracker.ietf.org/doc/rfc7676/

4. GRE-in-UDP: GRE-in-UDP Encapsulation. This specifies a method of 
encapsulating network protocol packets within GRE and UDP headers.
     This GRE-in-UDP encapsulation allows the UDP source port field to 
be used as an entropy field. This protocol is specified for IPv4 and 
IPv6, and used as either the payload or delivery protocol.
     link: https://www.rfc-editor.org/rfc/rfc8086

5. VXLAN: Virtual eXtensible Local Area Network.
     link: https://datatracker.ietf.org/doc/rfc7348/

6. VXLAN-GPE: Generic Protocol Extension for VXLAN. This protocol 
describes extending Virtual eXtensible Local Area Network (VXLAN) via 
changes to the VXLAN header.
     link: https://www.ietf.org/archive/id/draft-ietf-nvo3-vxlan-gpe-12.txt

7. GENEVE: Generic Network Virtualization Encapsulation.
     link: https://datatracker.ietf.org/doc/rfc8926/

8. IPIP: IP Encapsulation within IP.
     link: https://www.rfc-editor.org/rfc/rfc2003

9. NVGRE: Network Virtualization Using Generic Routing Encapsulation
     link: https://www.rfc-editor.org/rfc/rfc7637.html

10. STT: Stateless Transport Tunneling. STT is particularly useful when 
some tunnel endpoints are in end-systems, as it utilizes the 
capabilities of the network interface card to improve performance.
       link: https://www.ietf.org/archive/id/draft-davie-stt-08.txt

Among them, GRE_rfc2784, VXLAN and GENEVE are our internal requirements 
for inner header hashing.
GRE_rfc2784 requires RSS hashing to different queues.
For the monitoring scenario I mentioned, VXLAN or GRE_rfc2890 also needs 
to use inner symmetric hashing.

I know you mean to want this feature to only support GRE_rfc2784, since 
it's the most convincing for RSS.
But RSS hashes packets to different queues for different streams.
For the same flow, it needs to hash it to the same queue.
So this doesn't distort the role of RSS, and I believe that for modern 
protocols like VXLAN and others, inner symmetric hashing is still a 
common requirement for other vendors using virtio devices.

So, can we make this feature support all the protocols I have checked 
above, so that vendors can choose to support the protocols they want. 
And this can avoid the addition of new tunnel protocols
in the near future as much as possible.

Do you think it's ok?

Again: I'm so sorry I didn't realize I missed this until I checked my 
emails. 🙁😮

> We can start with just legacy GRE (think about including IPv6 or not).
> Given how narrow this usecase is, I'd be fine with focusing
> just on this, and addressing more protocols down the road
> with something programmable like BPF. WDYT?
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

