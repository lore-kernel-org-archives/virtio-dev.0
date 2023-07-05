Return-Path: <virtio-dev-return-13237-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C8CEB64DD
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Jul 2023 13:42:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id ABAB869F6A
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Jul 2023 13:42:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8AFE8986729
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Jul 2023 13:42:46 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 70C37986721; Wed,  5 Jul 2023 13:42:46 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5C5C89865A3
	for <virtio-dev@lists.oasis-open.org>; Wed,  5 Jul 2023 13:42:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: gQ_kk4vZPj67YsktcqWMaQ-1
From: Cornelia Huck <cohuck@redhat.com>
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-comment@lists.oasis-open.org"
 <virtio-comment@lists.oasis-open.org>, "david.edmondson@oracle.com"
 <david.edmondson@oracle.com>, "virtio-dev@lists.oasis-open.org"
 <virtio-dev@lists.oasis-open.org>, "sburla@marvell.com"
 <sburla@marvell.com>, "jasowang@redhat.com" <jasowang@redhat.com>, Yishai
 Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Shahaf
 Shuler <shahafs@nvidia.com>
In-Reply-To: <PH0PR12MB5481B4761D5B67B850755782DC2FA@PH0PR12MB5481.namprd12.prod.outlook.com>
Organization: Red Hat GmbH
References: <20230704233724.22394-1-parav@nvidia.com>
 <20230705070758-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B4761D5B67B850755782DC2FA@PH0PR12MB5481.namprd12.prod.outlook.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Wed, 05 Jul 2023 15:42:40 +0200
Message-ID: <87a5wa325r.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] RE: [virtio-comment] [PATCH v9 0/4] admin: Access legacy registers
 using admin commands

On Wed, Jul 05 2023, Parav Pandit <parav@nvidia.com> wrote:

>> From: Michael S. Tsirkin <mst@redhat.com>
>> Sent: Wednesday, July 5, 2023 7:09 AM
>> 
>> OK I sent a bunch of comments. Pls try to address, unfortunately I didn't go in
>> depth over the last patch, but I feel it should be squashed into the generic
>> legacy command sections avoiding need for indirection, so rewriting it now
>> wouldn't be efficient.
>
> I relooked at well yday.
> Transport has very small section.
> This aligns to how the existing spec is written, for example vq notify data is explained in generic way and defined in pci way in PCI chapter.
> The indirection is fine and also self-contained similarly here.

Would it make sense to do this the other way around (i.e. use something
that is PCI-only from the start?)

IIUC, the "legacy" problem as it stands is something specific to PCI,
with MMIO using two distinct approaches for pre-1.0 and 1.0+, and CCW
simply using different commands (and no need for any kind of cross
access.) Not 100% sure about MMIO, but I don't think we need a version
of this for CCW.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

