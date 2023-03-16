Return-Path: <virtio-dev-return-11645-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F07C6FD1F
	for <virtio-dev@archiver.kernel.org>; Thu, 16 Mar 2023 13:45:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DE13A41A0E
	for <virtio-dev@archiver.kernel.org>; Thu, 16 Mar 2023 13:45:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CDF75986432
	for <virtio-dev@archiver.kernel.org>; Thu, 16 Mar 2023 13:45:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C310A983E51; Thu, 16 Mar 2023 13:45:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AF8809863D7;
	Thu, 16 Mar 2023 13:45:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Ve.SsCl_1678974327;
Message-ID: <e8554f9d-ebb7-5b3e-ec40-a674921775c3@linux.alibaba.com>
Date: Thu, 16 Mar 2023 21:45:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org,
 Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230306154817.14115-1-hengqi@linux.alibaba.com>
 <c81de233-227c-73c8-a4bd-d43aa374dd86@nvidia.com>
 <20230315075954-mutt-send-email-mst@kernel.org>
 <11cce86e-8068-2e83-9fc5-e1b825adde29@nvidia.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <11cce86e-8068-2e83-9fc5-e1b825adde29@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] Re: [virtio-comment] Re: [PATCH v10] virtio-net:
 support inner header hash



在 2023/3/16 上午7:24, Parav Pandit 写道:
>
> On 3/15/2023 8:10 AM, Michael S. Tsirkin wrote:
>> On Tue, Mar 14, 2023 at 11:23:55PM -0400, Parav Pandit wrote:
>>> If not, for now it may be better to skip vxlan and nvegre as they 
>>> inherently
>>> have unique outer header UDP src port based on the inner header.
>>
>> So what's left, GRE?  GRE is actually different, in that it's not IP at
>> all.
> Sorry, I wrongly wrote nvegre above.
>
> IPoIP, GRE and NVGRE are left.
>
> vxlan and geneve has the udp src entropy.
>
>>
> Not sure I understand "its not IP at all".
>
> GRE has outer IP header + GRE header with the key to identify the flow.
> The key is effectively the hash for the flow.
>
>> So if we are talking about GRE, hash is indeed not calculated at all at
>> the moment, right? 
> Hash of the outer IP header of the src and dst IP can be still 
> calculated currently for GRE when the optional key is not present.
>
>> And I would say a natural first step for GRE is
>> actually adding a hash type that will support this protocol.
>>
> For GRE and NVGRE GRE_header.key as the flow/hash identifier should 
> work without inner header hash.
> Older version of the GRE doesn't have key, so inner header hash is 
> useful.

Yes, indeed.
The old GRE does not have keys such as flow id. Even with the new GRE, 
we have no chance to use optional fields,
because we have connected with various operators, and the most basic 
fields can get the best compatibility.

Thanks.

>
>> How about doing that? It seems like this should be a small step
>> and completely uncontroversial.
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

