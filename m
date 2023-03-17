Return-Path: <virtio-dev-return-11649-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1A5C76195
	for <virtio-dev@archiver.kernel.org>; Fri, 17 Mar 2023 08:38:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 17F7D2ACAF
	for <virtio-dev@archiver.kernel.org>; Fri, 17 Mar 2023 08:38:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 113C4986430
	for <virtio-dev@archiver.kernel.org>; Fri, 17 Mar 2023 08:38:58 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 054A2985FE5; Fri, 17 Mar 2023 08:38:58 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E693298642F;
	Fri, 17 Mar 2023 08:38:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Ve2Imz7_1679042329;
Message-ID: <10394600-28fa-b25b-c82d-5a541609912c@linux.alibaba.com>
Date: Fri, 17 Mar 2023 16:38:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230306154817.14115-1-hengqi@linux.alibaba.com>
 <c81de233-227c-73c8-a4bd-d43aa374dd86@nvidia.com>
 <e573702a-9a2e-d210-f13a-f0b241442991@linux.alibaba.com>
 <9f6286ea-51b2-dcc0-86c9-66509d92d8c2@nvidia.com>
 <20230316133844.GB20524@h68b04307.sqa.eu95>
 <PH0PR12MB5481E500DF200DD258C151BFDCBC9@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <PH0PR12MB5481E500DF200DD258C151BFDCBC9@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] RE: [virtio-comment] Re: [PATCH v10] virtio-net:
 support inner header hash



在 2023/3/17 上午3:55, Parav Pandit 写道:
>> From: Heng Qi <hengqi@linux.alibaba.com>
>> Sent: Thursday, March 16, 2023 9:39 AM
>> A rough description of this scene is as follows:
>> Client1 sends packets to client2, and client2 sends packets to client1
>> respectively.
>> This is called two directions, and they are in the same flow.
>> The packets in the two directions may reach the processing host through
>> different tunnels. In this scenario, we need to hash these packets to the same
>> queue for the same cpu to process, so inner symmetric hashing is required.
>>
>>
>> client1                   client2
>>      |                         |
>>      |      __________         |
>>      +----->| tunnels |<-------+
>>             |---------|
>>                |  |
>>                |  |
>>                |  |
>>                v  v
>>          +-----------------+
>>          | processing host |
>>          +-----------------+
>>
> I understood now. The key piece is the processing host is different from clients 1 and 2, I was missing that.
> The key is there are two tunnels and processing data on the inner header for the different tunnels is your primary requirement.
> Hence inner hashing helps to serialize them.

Yes, you are right.



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

