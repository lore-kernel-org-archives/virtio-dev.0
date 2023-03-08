Return-Path: <virtio-dev-return-11537-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18822C742A7
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 16:25:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 664B92A88A
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 16:25:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 596F9986700
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 16:25:51 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4A6439866F4; Wed,  8 Mar 2023 16:25:51 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3A28B9866F2
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Mar 2023 16:25:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: fahwE3WWPCexMXisLnu8yA-1
From: Cornelia Huck <cohuck@redhat.com>
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-comment@lists.oasis-open.org"
 <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
 <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "nrupal.jani@intel.com"
 <nrupal.jani@intel.com>, "Piotr.Uminski@intel.com"
 <Piotr.Uminski@intel.com>, "hang.yuan@intel.com" <hang.yuan@intel.com>,
 "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>, Zhu Lingshan
 <lingshan.zhu@intel.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
 Shahaf Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <PH0PR12MB54819AE477640508DCFF8333DCB79@PH0PR12MB5481.namprd12.prod.outlook.com>
Organization: Red Hat GmbH
References: <cover.1677761896.git.mst@redhat.com>
 <dd9c34ed74ee296228562f6946d4ca3f2fbee1e1.1677761896.git.mst@redhat.com>
 <PH0PR12MB5481595368C8F0C0E16B681BDCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230303032434-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54819AE477640508DCFF8333DCB79@PH0PR12MB5481.namprd12.prod.outlook.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Wed, 08 Mar 2023 17:24:20 +0100
Message-ID: <87a60nky8b.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [virtio-comment] RE: [PATCH v10 06/10] mmio: document ADMIN_VQ
 as reserved

On Tue, Mar 07 2023, Parav Pandit <parav@nvidia.com> wrote:

>> From: Michael S. Tsirkin <mst@redhat.com>
>> Sent: Friday, March 3, 2023 3:34 AM
>> 
>> On Thu, Mar 02, 2023 at 06:40:55PM +0000, Parav Pandit wrote:
>> > Did you miss reviewed-by from [1] or this is an old series reposted?
>> > [1]
>> > https://lists.oasis-open.org/archives/virtio-dev/202302/msg00242.html
>> 
>> As a general rule, we don't strictly need to track reviewed by since there's a
>> ballot (and presumably people review before voting).
>> 
>> People also tack on Signed-off-by: (and I do it too) but as long as we don't
>> document what it means it's kind of vague, and the process of subscribing to
>> the mailing list is a kind of replacement.
>> 
>> If you think everyone needs to follow practices like netdev does, we really need
>> something written up, and agree on it.
>> 
>> E.g.  I work on the linux kernel too, so I can copy practices from there, but even
>> linux isn't uniform.
>> 
>> And I wonder whether it's worth it - it definitely makes contributing to Linux
>> harder, and even within Linux it pushes contributors away. 
> The number of virtio spec contributors are in order of magnitude less than Linux kernel or just the Linux netdev.
> Patch split up reduces lot of time author and reviewers.
> For example, interrupt moderation at v10 can be very easily split up where prep patch can have RB tag and v11 doesn't need reviewers and author's time.
> Your work here with 10 patches is yet another good example of it.
> I remember Max and I started with 6 patches... and current 10 are more useful way to split them.

I'd argue that splitting changes in a way that makes it easy for
reviewers is a good thing for any project (although practices on many
forges seem to go into another direction...)

>
>> At least for Linux
>> tracking history in a precise way is extremely important since it's helpful with
>> stability. Spec is very different.
>> 
>> Until we have a good contribution documentation I think we should not ask
>> people to follow a pseudo Linux work flow with requests like "please split this
>> patchset up" or "track changes across patch versions"
>> simply because there's no good docs to teach people what exactly is the best
>> practice.
>
> Yes, I wanted to update the contributing document. It is in my to-do list.
> But given the small crowd of contributors right now, almost everyone is familiar with the RB, ack tag.
> At moment it has two main reasons.
>
> 1. Acknowledge the work and efforts that go in the review

I agree, and I try to include tags when applying.

> 2. When in question, reach out later to the spec author or reviewers to know about context/design etc.
> 3. Same reviewer doesn't need to go through the patch which already has RB tag of him/her.

I tend to use R-b in that way as well, but it relies on the patch author
not doing substantial changes between versions...

I guess the usage of R-b et al in the virtio spec stems from the fact
that many contributors are also Linux and/or QEMU contributors  -- not
sure if it makes sense to enshrine their usage, but

4. We can get an R-b from a non-TC member who is an expert on the topic
(and follows standard Linux/QEMU/... practices.)

In the end, how the TC members are voting is the only thing that matters
for inclusion.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

