Return-Path: <virtio-dev-return-13348-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E629EB64D9
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 12:24:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 96430387B
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 12:24:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 803F7986687
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 12:24:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6FA3E986663; Wed, 12 Jul 2023 12:24:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5C2A8986682
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Jul 2023 12:24:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: L_dd5zwSOMeCLRZSS3XV0Q-1
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>
Cc: virtio-dev@lists.oasis-open.org, jasowang@redhat.com, Parav Pandit
 <parav@nvidia.com>
In-Reply-To: <20230712075319-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <20220315032402.6088-1-xuanzhuo@linux.alibaba.com>
 <20230712072050-mutt-send-email-mst@kernel.org>
 <1689162241.4383667-1-xuanzhuo@linux.alibaba.com>
 <20230712075319-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Wed, 12 Jul 2023 14:24:32 +0200
Message-ID: <87mt01jp1b.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: Re: [virtio-dev] Re: [PATCH v12] virtio-net: support device stats

On Wed, Jul 12 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Jul 12, 2023 at 07:44:01PM +0800, Xuan Zhuo wrote:
>> On Wed, 12 Jul 2023 07:34:38 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> > On Tue, Mar 15, 2022 at 11:24:02AM +0800, Xuan Zhuo wrote:
>> > > This patch allows the driver to obtain some statistics from the device.
>> > >
>> > > In the back-end implementation, we can count a lot of such information,
>> > > which can be used for debugging and judging the running status of the
>> > > back-end. We hope to directly display it to the user through ethtool.
>> > >
>> > > To get stats atomically, try to get stats for all queue pairs in one
>> > > command.
>> > >
>> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> > > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>> >
>> > Functionally, I think this is close to ok now.  But the text needs
>> > of work.  Are you trying to target 1.3 with this?
>> 
>> I personally worry about that 1.3 may be too late, if possible, I would like to
>> respond as soon as possible.
>> 
>> I really don't really care if it can get into 1.3 or not but I do hope that this
>> can be done as soon as possible.
>> 
>> Thanks.
>
> Yes we were supposed to freeze for 1.3. This change can be merged on a
> main branch after 1.3 forks and is under review.

Nod, that's what I would prefer to do. Being merged on virtio-next
should be enough for including device/driver implementations.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

