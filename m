Return-Path: <virtio-dev-return-13873-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E8D4CE79CD
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 11:22:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id F06FA61271
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 11:22:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D2F09986673
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 11:22:57 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BCA96986669; Wed, 20 Sep 2023 11:22:57 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AD3E298666A
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Sep 2023 11:22:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="411139891"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="411139891"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="889882231"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="889882231"
Message-ID: <2f67fb85-2238-9c34-a265-b0f97b7ab7e1@intel.com>
Date: Wed, 20 Sep 2023 19:22:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 Jason Wang <jasowang@redhat.com>
References: <PH0PR12MB5481C41D4F32DA26D5831471DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <67680965-b115-32c7-dfdf-c56ab37bdd81@intel.com>
 <213a0f94-cee2-d8c5-3c5d-d2d7fc920e75@intel.com>
 <PH0PR12MB5481AE8C6E5EAFE9A4ADA6F6DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f1fe513e-d42d-03a6-348c-5e58aac0a759@intel.com>
 <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5f01772f-eb27-bfe0-7f69-b83fbd90dda0@intel.com>
 <PH0PR12MB5481ABF4B9BC2082BC54AB1DDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230918144312-mutt-send-email-mst@kernel.org>
 <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
 <20230920054836-mutt-send-email-mst@kernel.org>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <20230920054836-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state



On 9/20/2023 6:36 PM, Michael S. Tsirkin wrote:
> On Wed, Sep 20, 2023 at 02:06:13PM +0800, Zhu, Lingshan wrote:
>>
>> On 9/19/2023 2:49 AM, Michael S. Tsirkin wrote:
>>> On Mon, Sep 18, 2023 at 06:41:55PM +0000, Parav Pandit wrote:
>>>>> Please refer to the code for setting FEATURES_OK.
>>>> It wont work when one needs to suspend the device.
>>>> There is no point of doing such work over registers as fundamental framework is over the AQ.
>>> Well not really. It's over admin commands. When these were built the
>>> intent always was that it's possible to use admin commands through
>>> another interface, other than admin queue. Is there a problem
>>> implementing admin commands over a memory BAR? For example, I can see
>>> an "admin command" capability pointing at a BAR where
>>> commands are supplied, and using a new group type referring to
>>> device itself.
>> I am not sure, if a bar cap would be implemented as a proxy for the admin vq
>> based live migration.
> Not a proxy for a vq in that there's no vq then.
I think if the driver sends admin commands through a VF's bar, then
VF forwards the admin commands to the PF, it acts like a proxy,
or an agent. Anyway it takes admin commands.

So the problems we have discussed still exist.
>
>> then the problems of admin vq LM that we have
>> discussed
>> still exist.
> I freely admit the finer points of this extended flamewar have been lost
> on me, and I wager I'm not the only one. I thought you wanted to migrate
> the device just by accessing the device itself (e.g. the VF) without
> accessing other devices (e.g. the PF), while Parav wants it in a
> separate device so the whole of the device itself can passed through to
> guest. Isn't this, fundamentally, the issue?
we are implementing basic facilities for live migration.

We have pointed out lots of issues, there are many discussions with
Jason and Parav about the problems in migration by admin vq, for example:
security, QOS and nested.
>
>> the bar is only a proxy, doesn't fix anything. and even larger
>> side channel attacking surface: vf-->pf-->vf
> In this model there's no pf. BAR belongs to vf itself
> and you submit commands for the VF through its BAR.
> Just separate from the pci config space.
If using the bar to process admin commands,
is this solution too heavy compared to my proposal in this series?
>
> The whole attacking surface discussion is also puzzling.  We either are
> or are not discussing confidential computing/TDI.  I couldn't figure
> it out. This needs a separate thread I think.
I agree confidential computing is out of spec. Parva mentioned TDISP and 
even
in TDISP spec, it explicitly defined some attacking model, and PF is an 
example.

It is out of spec anyway.
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

