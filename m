Return-Path: <virtio-dev-return-13970-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B976E810A2
	for <virtio-dev@archiver.kernel.org>; Wed, 27 Sep 2023 08:20:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 66F692ACAA
	for <virtio-dev@archiver.kernel.org>; Wed, 27 Sep 2023 08:20:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 557D3986675
	for <virtio-dev@archiver.kernel.org>; Wed, 27 Sep 2023 08:20:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3FA5298640B; Wed, 27 Sep 2023 08:20:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 20BCC98640F;
	Wed, 27 Sep 2023 08:20:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="372103098"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="372103098"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="742626592"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="742626592"
Message-ID: <305d9907-9668-d362-1ff2-49a5e9f90e42@intel.com>
Date: Wed, 27 Sep 2023 16:20:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
To: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>,
 "eperezma@redhat.com" <eperezma@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
References: <PH0PR12MB5481830365A80EF4583A3FFADCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEshxAU3Mjo7vczBNRb=P=FnenO4mPb9HJL0Ma3ZRbe-oA@mail.gmail.com>
 <PH0PR12MB548172996D62E37714A9776BDCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtW88zJkDQL58NqLzzudq=f+SmzJ8bha55Dd2fd=FRGBQ@mail.gmail.com>
 <PH0PR12MB5481573D6EE3BE03FB7C3D70DCFCA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvOxraeVB-5g7dJ-KBN=63kpmDfDdqaiQVyDh8egDjsGw@mail.gmail.com>
 <PH0PR12MB5481C11F6D68A892A091E2AFDCC3A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <e9c482d5-1441-fec5-b55b-f1ac6e81f85b@intel.com>
 <PH0PR12MB5481C57B255B0D5EA6FB109DDCC3A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ddbd47c8-6985-2d08-bf98-0e7516f0c3c4@intel.com>
 <20230926064201-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <20230926064201-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state



On 9/26/2023 6:48 PM, Michael S. Tsirkin wrote:
> On Tue, Sep 26, 2023 at 05:25:42PM +0800, Zhu, Lingshan wrote:
>> We don't want to repeat the discussions, it looks like endless circle with
>> no direction.
> OK let me try to direct this discussion.
> You guys were speaking past each other, no dialog is happening.
> And as long as it goes on no progress will be made and you
> will keep going in circles.
>
> Parav here made an effort and attempted to summarize
> use-cases addressed by your proposal but not his.
> He couldn't resist adding "a yes but" in there oh well.
> But now I hope you know he knows about your use-cases?
>
> So please do the same. Do you see any advantages to Parav's
> proposal as compared to yours? Try to list them and
> if possible try not to accompany the list with "yes but"
> (put it in a separate mail if you must ;) ).
> If you won't be able to see any, let me know and I'll try to help.
>
> Once each of you and Parav have finally heard the other and
> the other also knows he's been heard, that's when we can
> try to make progress by looking for something that addresses
> all use-cases as opposed to endlessly repeating same arguments.
Sure Michael, I will not say "yes but" here.

 From Parav's proposal, he intends to migrate a member device by its 
owner device through the admin vq,
thus necessary admin vq commands are introduced in his series.


I see his proposal can:
1) meet some customers requirements without nested and bare-metal
2) align with Nvidia production
3) easier to emulate by onboard SOC

The general purpose of his proposal and mine are aligned: migrate virtio 
devices.

Jason has ever proposed to collaborate, please allow me quote his proposal:

"
Let me repeat once again here for the possible steps to collaboration:

1) define virtqueue state, inflight descriptors in the section of
basic facility but not under the admin commands
2) define the dirty page tracking, device context/states in the
section of basic facility but not under the admin commands
3) define transport specific interfaces or admin commands to access them
"

I totally agree with his proposal.

Does this work for you Michael?

Thanks
Zhu Lingshan

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

