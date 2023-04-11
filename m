Return-Path: <virtio-dev-return-12119-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E7DC76196
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 10:51:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 27A1D370EE
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 10:51:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 056F89863D8
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 10:51:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E350E983DFF; Tue, 11 Apr 2023 10:51:27 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D371E986366
	for <virtio-dev@lists.oasis-open.org>; Tue, 11 Apr 2023 10:51:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 2sjlg989Mt6NRWq9rQIsfQ-1
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, virtio-dev@lists.oasis-open.org,
 virtio-comment@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>,
 Alvaro Karsz <alvaro.karsz@solid-run.com>, David Edmondson
 <david.edmondson@oracle.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230411063059-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <20230323152422.113103-1-hengqi@linux.alibaba.com>
 <336f9b36-6704-51a6-0097-22381c623b8b@linux.alibaba.com>
 <87o7nukfns.fsf@redhat.com>
 <20230411063059-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Tue, 11 Apr 2023 12:51:22 +0200
Message-ID: <87a5zek7yt.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: Re: [virtio-dev] [PATCH v14] virtio-net: support the virtqueue
 coalescing moderation

On Tue, Apr 11 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Apr 11, 2023 at 10:05:11AM +0200, Cornelia Huck wrote:
>> On Thu, Mar 23 2023, Heng Qi <hengqi@linux.alibaba.com> wrote:
>> 
>> > Hi all! If after reviewing it you feel it meets the necessary 
>> > requirements, I kindly request a vote.
>> >
>> > Thanks a lot!
>> >
>> > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/166
>> 
>> So this has been voted upon and accepted, but we have further discussion
>> downthread.
>> 
>> Should we merge the voted-upon version now and do further changes on
>> top, or wait for the discussion to conclude first so that we can merge
>> all of it in one go?
>
> I think we should merge as is. vqn/idx/id are not new discussions
> and have been going on before voting took place, so the TC
> was informed. Parav is working on making tree-wide changes
> around vq index applying this will not make his work
> measureably harder.

I had not looked at the discussion in detail and was unsure whether it
was covering something new... I went ahead and applied it.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

