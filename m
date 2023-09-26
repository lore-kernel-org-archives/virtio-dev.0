Return-Path: <virtio-dev-return-13962-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87737E7D26E
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 09:25:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B8D0629FD3
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 09:25:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8B9BA98640B
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 09:25:52 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6EBE9983DE3; Tue, 26 Sep 2023 09:25:52 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5B8FA98639D;
	Tue, 26 Sep 2023 09:25:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="378805489"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="378805489"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="838966935"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="838966935"
Message-ID: <ddbd47c8-6985-2d08-bf98-0e7516f0c3c4@intel.com>
Date: Tue, 26 Sep 2023 17:25:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Content-Language: en-US
To: Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "eperezma@redhat.com" <eperezma@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
References: <PH0PR12MB5481C41D4F32DA26D5831471DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230918144312-mutt-send-email-mst@kernel.org>
 <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
 <20230920054836-mutt-send-email-mst@kernel.org>
 <CACGkMEsn+9AqgmurN8-GXkcu8UxAr62_woJn3XZN+oUkTQNPUg@mail.gmail.com>
 <PH0PR12MB5481830365A80EF4583A3FFADCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEshxAU3Mjo7vczBNRb=P=FnenO4mPb9HJL0Ma3ZRbe-oA@mail.gmail.com>
 <PH0PR12MB548172996D62E37714A9776BDCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtW88zJkDQL58NqLzzudq=f+SmzJ8bha55Dd2fd=FRGBQ@mail.gmail.com>
 <PH0PR12MB5481573D6EE3BE03FB7C3D70DCFCA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvOxraeVB-5g7dJ-KBN=63kpmDfDdqaiQVyDh8egDjsGw@mail.gmail.com>
 <PH0PR12MB5481C11F6D68A892A091E2AFDCC3A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <e9c482d5-1441-fec5-b55b-f1ac6e81f85b@intel.com>
 <PH0PR12MB5481C57B255B0D5EA6FB109DDCC3A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <PH0PR12MB5481C57B255B0D5EA6FB109DDCC3A@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state



On 9/26/2023 2:03 PM, Parav Pandit wrote:
>
>> From: Zhu, Lingshan <lingshan.zhu@intel.com>
>> Sent: Tuesday, September 26, 2023 11:07 AM
>>> 1. cover letter is missing the problem statement and use case
>> I only reply to this section of comments, this does not mean I agree with you on
>> your other statements, Instead I agree with Jason on his replies to you.
>>
>> In my cover letter:
>> "The main usecase of these new facilities is Live Migration."
>>
> :)
> Two letter word do not explain the use case of why is asking to mediating a native virtio device.
this solution work for fundamental virtualization: trap and emulate, 
just like other virtio config space
fields.

Do you know how device status or vq_enable work? I suggest to read QEMU 
code.
>
> And yet you call is the basic facilities.
> Anyways you know the misaligned response in email and cover letter is evident.
No, I don't, they are basic facilities as you can see, this is loud and 
clear.
>
>> Did you miss it?
> No.
> It misses the detail as I described in the theory of operation described in [1].
>
> [1] https://lists.oasis-open.org/archives/virtio-comment/202309/msg00061.html
Details are in the following patch in this series
>
>>> 2. why queue suspend and both device suspend are introduced, only one
>> should be there. The design description is missing.
>> there are no queue suspend, they are device suspend and vq state accessors.
>> please read the patch if you want to comment.
>>> 3. Even though it claims under some random basic facility, cover letter clearly
>> states the main use case is "live migration".
>> it is not random, they are precisely defined virtio basic facilities.
>>> 4. Patch 4 is not needed at all. When device is suspended, it is _suspended_. It
>> does not do any bifurcation.
>> The device should not accept vq reset and the driver should reset vqs, please
>> read previous discussions with MST and please don't ignore the conclusions
>>> 5. only suspend bit of patch2 is not enough to cover P2P. One needs suspend
>> and freeze both covered in series [1].
>> we have discussed this for many times, P2P is out of virtio spec, do you want to
>> mediate every PCI state/functionality?
>>> 6. Finally the whole description of 1 to 4 need to be split in the device
>> operation, so that both passthrough and medication can utilize it using admin
>> cmd and otherwise.
>> Do you see any reasons this solution can not be used for passthrough and
>> mediation?
> Right. Proposed solution does not meeting following requirements addressed in [1].
>
> [1] https://lore.kernel.org/virtio-comment/20230906081637.32185-1-lingshan.zhu@intel.com/T/#m7efbaadbc73f033c2793d9eb1eb0afa210aae4be
>
> [1] I replied to Jason in previous email.
> I will repeat here. They are covered in [1].
>
> 1. Missing P2P support
As I asked before, please don't ignore, please answer:
"we have discussed this for many times, P2P is out of virtio spec,
do you want to mediate every PCI state/functionality?"
> 2. Missing dirty page tracking
This will be included in V2, as we have repeated for many times,
we want this series to be small and focus, that is why dirty page tracking
and in-flight descriptors are not here. but they will in V2.
> 3. Incremental device context framework for short downtime
Do you observe significant downtime in QEMU/vhost?

Why do you think this series can introduce more downtime,

Do you know this series can re-use QEMU/vhost?

Have you really read QEMU live migration code?

Jason has ever suggested you read it.
> 3.a Ability to do inflight descriptor tracking
as told you many times, in V2
> 4. Ability to do the work for multiple member devices in parallel.
As told you many times, they are per-device facilities, for example,
per-vf device, that means, migrate the VF by its own facilities.

Is that clear enough for you?
>
>
>> Or does features_OK work for passthrough or mediation? Any difference?
> It does not work. Passthrough devices are not trapped by the hypervisor.
Really? Features_ok does not work for passthrough? Seriously?
>
>>> Since Zhu, told that dirty tracking and inflight descriptors will be done, I
>> presume he will propose to do over admin q or command interface.
>>> And since all can run over the admin commands, the plumbing done in 1 to 4
>> can be made using admin commands.
>> No
> Such negative assertion does not help.
> Explain why part, like how I explained above.
OK, we can repeat:

Again! They are self-contained basic facilities, they should better not 
depend on others like admin vq.

And please refer to previous discussions, where Jason and I pointed out 
admin vq is not a qualified
solution for live migration because of: 1)nested 2)baremetal LM 3)QOS 
4)security.

We don't want to repeat the discussions, it looks like endless circle 
with no direction.
>
>>> Until now we could not establish creating yet another DMA interface that is
>> better than q interface.
>>> So ...
>>> To me both the methods will start looking more converged to me over admin
>> command and queues.
>> I don't think so, again, we are introducing basic facilities and these facilities
>> don't depend on or rely on admin vq.
> If so, stop the work "live migration" from the cover letter.
> Reliance of admin command (again not vq, be careful what you constantly claim).
> Not reliance on admin queue or admin command does/does not make it basic facility.
why admin commands are must? These facilities are self contained, right?
>
> Admin commands and queues are already in basic facilities section today.
> So claiming that hey one is using admin commands that means it is non_basic facility is not correct.
Still why you think admin command is a must? It is clear that this 
proposal can work without admin vq,
and even better!
>
>>> Passthrough will use them over owner device.
>>> Mediation somehow need to do over member device.
>>> Mediation will not use any device suspend command because it needs to
>> keep bisecting everything.
>> please read QEMU vhost live migration solution
> Can you please share the pointer to it?
>
> I am familiar with [2] and it does not require device suspend flow as things are bisected.
>
> [2] https://qemu-project.gitlab.io/qemu/interop/vhost-user.html#introduction
If so, I believe you may find out that this solution can work perfect 
with vhost, right?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

