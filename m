Return-Path: <virtio-dev-return-13400-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50FAEB64DC
	for <virtio-dev@archiver.kernel.org>; Fri, 21 Jul 2023 13:05:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 064AF42B4B
	for <virtio-dev@archiver.kernel.org>; Fri, 21 Jul 2023 13:05:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D1E91986841
	for <virtio-dev@archiver.kernel.org>; Fri, 21 Jul 2023 13:05:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B459E98683F; Fri, 21 Jul 2023 13:05:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 13168986840
	for <virtio-dev@lists.oasis-open.org>; Fri, 21 Jul 2023 13:05:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: ttulXq5bMSipizS93um36g-1
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtio-dev@lists.oasis-open.org,
 jasowang@redhat.com, Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230721083327-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <20220315032402.6088-1-xuanzhuo@linux.alibaba.com>
 <20230712072050-mutt-send-email-mst@kernel.org>
 <1689162241.4383667-1-xuanzhuo@linux.alibaba.com>
 <20230712075319-mutt-send-email-mst@kernel.org>
 <87mt01jp1b.fsf@redhat.com>
 <20230712082616-mutt-send-email-mst@kernel.org>
 <87mszp8nae.fsf@redhat.com>
 <20230721083327-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Fri, 21 Jul 2023 15:05:12 +0200
Message-ID: <87jzut8lfb.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: 1.3 and branching

On Fri, Jul 21 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, Jul 21, 2023 at 02:24:57PM +0200, Cornelia Huck wrote:
>> On Wed, Jul 12 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> 
>> > On Wed, Jul 12, 2023 at 02:24:32PM +0200, Cornelia Huck wrote:
>> >> On Wed, Jul 12 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> >> > Yes we were supposed to freeze for 1.3. This change can be merged on a
>> >> > main branch after 1.3 forks and is under review.
>> >> 
>> >> Nod, that's what I would prefer to do. Being merged on virtio-next
>> >> should be enough for including device/driver implementations.
>> >
>> > Except I'd prefer a v1.3 branch instead of a next branch - adding things
>> > on the branch should be harder, not easier.
>> 
>> Just to clarify: What I had planned for 1.3 (and what we already did for
>> 1.2) is to fork a -next branch, finish 1.3 on the master branch, and
>> then merge -next back into master after we'd be done with 1.3.
>> 
>> I'm not sure what you mean by "adding things on the branch should be
>> harder, not easier" -- I think it is already a bit harder because it is
>> a branch :)
>> 
>> We can of course do a v1.3 branch instead and continue developing on
>> master, but shouldn't we then create branches (glorified tags) for the
>> older releases as well?
>
> Yea, makes sense.
> I think we are all set WRT what we planned to be in 1.3 - right?

I'll send out a "last call" JFTR, but I think we're good.

> Next step is preparing the changelog and packaging it
> all as WD, then voting to approve it as a CSD/CSPRD and start
> public review.
>
> Have time this week? if not I will get to it next week.

Certainly not this week, but one of us can get started with the
changelog next week. Fortunately, it should be shorter than the one for
1.2 :)


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

