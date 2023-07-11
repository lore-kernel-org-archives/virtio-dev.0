Return-Path: <virtio-dev-return-13336-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4B8EB64DC
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Jul 2023 09:10:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 01DB62AD57
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Jul 2023 09:10:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DF1FA986561
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Jul 2023 09:10:17 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C8C59983FEB; Tue, 11 Jul 2023 09:10:17 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AE795986503
	for <virtio-dev@lists.oasis-open.org>; Tue, 11 Jul 2023 09:10:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: arnKHn5qOGy2Pt208I8u9Q-1
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>
Cc: virtio-comment@lists.oasis-open.org, david.edmondson@oracle.com,
 virtio-dev@lists.oasis-open.org, sburla@marvell.com, jasowang@redhat.com,
 yishaih@nvidia.com, maorg@nvidia.com, shahafs@nvidia.com
In-Reply-To: <20230710122502-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <20230710161752.204248-1-parav@nvidia.com>
 <20230710122502-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Tue, 11 Jul 2023 11:10:09 +0200
Message-ID: <87pm4ylspa.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [PATCH v14] admin: Add group member legacy register access
 commands

On Mon, Jul 10 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Jul 10, 2023 at 07:17:52PM +0300, Parav Pandit wrote:
>> +The \field{flags} value of 0x1 indicates that the notification address is of
>> +the owner device, value of 0x2 indicates that the notification address is of
>> +the member device, the value of 0 indicates that all the entries starting from
>
> , the -> and value of 0x0 

Looking at this sentence again, maybe make this

"A \field{flags} value of 0x1 indicates that the notification address is
that of the owner device, a value of 0x2 indicates that the notification
address is that of the member device, and a value of 0 indicates..."

if you're tweaking it anyway?

>
>
>> +that entry are invalid entries in \field{entries}. All other values in
>> +\field{flags} are reserved.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

