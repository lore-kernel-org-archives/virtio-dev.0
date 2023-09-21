Return-Path: <virtio-dev-return-13915-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD8EE706F8
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 09:06:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 202462ACA5
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 09:06:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1018098668C
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 09:06:45 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 00F2898667D; Thu, 21 Sep 2023 09:06:45 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E44C298667E;
	Thu, 21 Sep 2023 09:06:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="384306927"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="384306927"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="920657873"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="920657873"
Message-ID: <125b664c-096c-09c0-c05c-29b62f020124@intel.com>
Date: Thu, 21 Sep 2023 17:06:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>,
 "eperezma@redhat.com" <eperezma@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
References: <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
 <20230920054836-mutt-send-email-mst@kernel.org>
 <2f67fb85-2238-9c34-a265-b0f97b7ab7e1@intel.com>
 <20230920075243-mutt-send-email-mst@kernel.org>
 <20230920084058-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548110E53C924C984FA24A49DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230920101402-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816F8341A77E63831316DBDCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230920160218-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54814A89793CF796412D6A27DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921004957-mutt-send-email-mst@kernel.org>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <20230921004957-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state



On 9/21/2023 1:41 PM, Michael S. Tsirkin wrote:
> On Thu, Sep 21, 2023 at 03:43:12AM +0000, Parav Pandit wrote:
>>
>>> From: Michael S. Tsirkin <mst@redhat.com>
>>> Sent: Thursday, September 21, 2023 1:34 AM
>>>
>>> On Wed, Sep 20, 2023 at 05:21:52PM +0000, Parav Pandit wrote:
>>>>> OK so with this summary in mind, can you find any advantages to
>>>>> inband+mediation that are real or do you just see disadvantages? And
>>>>> it's a tricky question because I can see some advantages ;)
>>>> inband + mediation may be useful for nested case.
>>> Hint: there's more.
>> Can you please list down?
>>
>> The starting point of discussion is, there is passthrough member device without mediation in virtio interface layers.
>> How shall device migration should work for it?
> I was attempting to have each of you see other's point of view.
> It seems clear I was right, at least one way communication was
> not getting through. Let me try to help.
>
>
> First, clearly Zhu Lingshan cares about the mediation use-case, not the
> un-mediated one.  Mediation is clearly heavier but also more powerful
> in many use-cases - is that obvious or do I need to list the reasons?
> To mention one example, it supports cross-vendor migration. Which the unmediated
> variant maybe can in theory support too, and when it does maybe in a better and
> more structured way - but that will require standartization effort that
> didn't happen yet. With mediation it was already demonstrated more than
> once.
>
> 1. For mediation something that works within existing mediation framework -
> e.g. reusing as he does feature bits - will require less support
> than a completely separate facility.
> I think Zhu Lingshan also believes that since there will be less code ->
> less security issues.
>
> 2. With or without mediation, the mapping of commands to VFs is simpler,
> allowing more control - for example, let's say you want to reset a VF -
> you do not need to flush the queue of existing commands, which might
> potentially take a long time because some other VFs are very busy - you
> just reset the VF which any unmap flow will already do.
>
>
Thanks, I agree
> But Zhu Lingshan, all this will be pointless if you also do not try to
> do this and list what are reasonable points that Parav made. Please do
> not mistake what I'm doing here for taking sides I just want the
> communication to start working. And that means everyone tries to take
> all use-cases into account even if working for a vendor that does not
> care about this use-case. Otherwise we will just keep getting into these
> flamewars.
I think admin vq live migration surely work for some scenarios and can 
meet specific customers requirements,
that uses cases are reasonable for sure.

Jason, Eugenio and me, et al spent a lot of efforts on this live 
migration proposal in the past two years,
this series are based on the joint work, directly carry on previous 
series sent by Jason and Eugenio.

This series introduces basic facilities for live migration, and the 
implementation is transport specific.

I agree we should cooperate, at least the basic facilities can be used 
by admin vq, for example the
dirty page tracking facility and even forward suspend command to device 
status.

Thanks,
Zhu Lingshan


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

