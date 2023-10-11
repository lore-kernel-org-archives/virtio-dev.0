Return-Path: <virtio-dev-return-13996-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EBAFCD6E54
	for <virtio-dev@archiver.kernel.org>; Wed, 11 Oct 2023 10:38:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 751F4780E9
	for <virtio-dev@archiver.kernel.org>; Wed, 11 Oct 2023 10:38:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5DE3498683D
	for <virtio-dev@archiver.kernel.org>; Wed, 11 Oct 2023 10:38:43 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4F8F8986605; Wed, 11 Oct 2023 10:38:43 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3F8D7986603;
	Wed, 11 Oct 2023 10:38:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="381876794"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="381876794"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="819645104"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="819645104"
Message-ID: <373821b2-1a1e-3bf3-51dc-8af54db85d00@intel.com>
Date: Wed, 11 Oct 2023 18:38:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Parav Pandit <parav@nvidia.com>,
 Jason Wang <jasowang@redhat.com>, "eperezma@redhat.com"
 <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
References: <PH0PR12MB5481573D6EE3BE03FB7C3D70DCFCA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvOxraeVB-5g7dJ-KBN=63kpmDfDdqaiQVyDh8egDjsGw@mail.gmail.com>
 <PH0PR12MB5481C11F6D68A892A091E2AFDCC3A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <e9c482d5-1441-fec5-b55b-f1ac6e81f85b@intel.com>
 <PH0PR12MB5481C57B255B0D5EA6FB109DDCC3A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ddbd47c8-6985-2d08-bf98-0e7516f0c3c4@intel.com>
 <20230926064201-mutt-send-email-mst@kernel.org>
 <305d9907-9668-d362-1ff2-49a5e9f90e42@intel.com>
 <20230927113510-mutt-send-email-mst@kernel.org>
 <558fe3d6-0b81-4def-7256-52ac3cbffa8f@intel.com>
 <20231011061508-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <20231011061508-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] Re: [PATCH 0/5] virtio:
 introduce SUSPEND bit and vq state



On 10/11/2023 6:20 PM, Michael S. Tsirkin wrote:
> On Mon, Oct 09, 2023 at 06:01:42PM +0800, Zhu, Lingshan wrote:
>>
>> On 9/27/2023 11:40 PM, Michael S. Tsirkin wrote:
>>> On Wed, Sep 27, 2023 at 04:20:01PM +0800, Zhu, Lingshan wrote:
>>>> On 9/26/2023 6:48 PM, Michael S. Tsirkin wrote:
>>>>> On Tue, Sep 26, 2023 at 05:25:42PM +0800, Zhu, Lingshan wrote:
>>>>>> We don't want to repeat the discussions, it looks like endless circle with
>>>>>> no direction.
>>>>> OK let me try to direct this discussion.
>>>>> You guys were speaking past each other, no dialog is happening.
>>>>> And as long as it goes on no progress will be made and you
>>>>> will keep going in circles.
>>>>>
>>>>> Parav here made an effort and attempted to summarize
>>>>> use-cases addressed by your proposal but not his.
>>>>> He couldn't resist adding "a yes but" in there oh well.
>>>>> But now I hope you know he knows about your use-cases?
>>>>>
>>>>> So please do the same. Do you see any advantages to Parav's
>>>>> proposal as compared to yours? Try to list them and
>>>>> if possible try not to accompany the list with "yes but"
>>>>> (put it in a separate mail if you must ;) ).
>>>>> If you won't be able to see any, let me know and I'll try to help.
>>>>>
>>>>> Once each of you and Parav have finally heard the other and
>>>>> the other also knows he's been heard, that's when we can
>>>>> try to make progress by looking for something that addresses
>>>>> all use-cases as opposed to endlessly repeating same arguments.
>>>> Sure Michael, I will not say "yes but" here.
>>>>
>>>>   From Parav's proposal, he intends to migrate a member device by its owner
>>>> device through the admin vq,
>>>> thus necessary admin vq commands are introduced in his series.
>>>>
>>>>
>>>> I see his proposal can:
>>>> 1) meet some customers requirements without nested and bare-metal
>>>> 2) align with Nvidia production
>>>> 3) easier to emulate by onboard SOC
>>> Is that all you can see?
>>>
>>> Hint: there's more.
>> please help provide more.
> Just a small subset off the top of my head:
> Error handling.
handle failed live migration? how?

and for other errors, we have mature error handling solutions
in virtio for years, like re-read, NEEDS_RESET.

If that is not good enough, then the corollary is:
admin vq is better than config space,
then the further corollary could be:
we should refactor virito-pci interfaces to admin vq commands,
like how we handle features

Is that true?
> Extendable to other group types such as SIOV.
For SIOV, the admin vq is a transport, but for SR-IOV
the admin vq is a control channel, that is different,
and admin vq can be a side channel.

For example, for SIOV, we config and migrate MSIX through
admin vq. For SRIOV, they are in config space.
> Batching of commands
> less pci transactioons
so this can still be a QOS issue.
If batching, others to starve?
> Support for keeping some data off-device
I don't get it, what is off-device?
The live migration facilities need to fetch data from the device anyway
>
> which does not mean it's better unconditionally.
> are above points clear?
The thing is, what blocks the config space solution?
Why admin vq is a must for live migration?
What's wrong in config space solution?
Shall we refactor everything in virtio-pci to use admin vq?
>
> as long as you guys keep not hearing each other we will keep
> seeing these flame wars. if you expect everyone on virtio-comment
> to follow a 300 message thread you are imo very much mistaken.
I am sure I have not ignored any questions.
I am saying admin vq is problematic for live migration,
at least it doesn't work for nested, so why admin vq is a must for live 
migration?
>
>>>
>>>
>>>
>>>
>>>> The general purpose of his proposal and mine are aligned: migrate virtio
>>>> devices.
>>>>
>>>> Jason has ever proposed to collaborate, please allow me quote his proposal:
>>>>
>>>> "
>>>> Let me repeat once again here for the possible steps to collaboration:
>>>>
>>>> 1) define virtqueue state, inflight descriptors in the section of
>>>> basic facility but not under the admin commands
>>>> 2) define the dirty page tracking, device context/states in the
>>>> section of basic facility but not under the admin commands
>>>> 3) define transport specific interfaces or admin commands to access them
>>>> "
>>>>
>>>> I totally agree with his proposal.
>>>>
>>>> Does this work for you Michael?
>>>>
>>>> Thanks
>>>> Zhu Lingshan
>>> I just doubt very much this will work.  What will "define" mean then -
>>> not an interface, just a description in english? I think you
>>> underestimate the difficulty of creating such definitions that
>>> are robust and precise.
>> I think we can review the patch to correct the words.
>>>
>>> Instead I suggest you define a way to submit admin commands that works
>>> for nested and bare-metal (i.e. not admin vq, and not with sriov group
>>> type). And work with Parav to make live migration admin commands work
>>> reasonably will through this interface and with this type.
>> why admin commands are better than registers?
>>
>> This publicly archived list offers a means to provide input to the
>> OASIS Virtual I/O Device (VIRTIO) TC.
>>
>> In order to verify user consent to the Feedback License terms and
>> to minimize spam in the list archive, subscription is required
>> before posting.
>>
>> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
>> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
>> List help: virtio-comment-help@lists.oasis-open.org
>> List archive: https://lists.oasis-open.org/archives/virtio-comment/
>> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
>> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
>> Committee: https://www.oasis-open.org/committees/virtio/
>> Join OASIS: https://www.oasis-open.org/join/
>>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

