Return-Path: <virtio-dev-return-11379-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B014C678D4
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 15:07:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 73E37F3F4A
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 15:07:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 58ACE986686
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 15:07:02 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 41093986672; Thu,  2 Mar 2023 15:07:02 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3011A986676
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Mar 2023 15:07:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 3pbuo8xwNz2m8Oax44uHIg-1
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: Parav Pandit <parav@nvidia.com>, virtio-dev@lists.oasis-open.org,
 virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
In-Reply-To: <20230301123044-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <20230223054624.168042-1-parav@nvidia.com>
 <87a60z5wes.fsf@redhat.com> <20230301182207.23f995cd.pasic@linux.ibm.com>
 <20230301123044-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Thu, 02 Mar 2023 16:06:52 +0100
Message-ID: <87a60vmbub.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 0/3] Rename queue index to queue
 number

On Wed, Mar 01 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Mar 01, 2023 at 06:22:07PM +0100, Halil Pasic wrote:
>> On Mon, 27 Feb 2023 09:45:31 +0100
>> Cornelia Huck <cohuck@redhat.com> wrote:
>> 
>> > For the vq index/number, I'm not that sure that "virtqueue number" is
>> > better that "virtqueue index" -- actually, I'd prefer the latter. We'd
>> > need some renaming either way.
>> 
>> I prefer index as well. Especially that we start indexing with 0. Also
>> seems to be the more common term for such stuff in both Mathematics and
>> CS.
>> 
>> Regards,
>> Halil 
>
>
> Basically I am saying that this:
>
> /* Queue size for the currently selected queue - Write Only */
> #define VIRTIO_MMIO_QUEUE_NUM           0x038
>
> is a bad name because queue number seems to be ambiguous.
>
> Maybe start with just getting rid of uses of QUEUE_NUM meaning size?

Nod, that seems to be uncontroversial.

>
>
> If we want to use queue index we need to fix RSS spec in networking
> since that seems to want to use queue index in a very weird way:
> networking has this idea of calling queues like this:
> receiveq1 receiveq2 ....
> why 1-based? I guess we wanted this to be clear even to a 5 year olds ;)
>
> And then for extra fun, in the RSS section we say "0 based index" where we
> seem to mean "this number in the queue name, but subtract 1 in your head".
> Why subtract 1? I guess we wanted these 5 year olds to practice math ...

Heh :)

Yeah, that looks like a mess... I don't think we should use a weird
substraction scheme. I haven't looked at the RSS stuff much, would it be
hard to fix it up?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

