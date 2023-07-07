Return-Path: <virtio-dev-return-13312-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC09EB64D9
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 11:37:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3C6DE2B03B
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 11:37:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1165798680A
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 11:37:15 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EC7C39867EB; Fri,  7 Jul 2023 11:37:14 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D8C859867F9
	for <virtio-dev@lists.oasis-open.org>; Fri,  7 Jul 2023 11:37:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 0uJutzpAME6EK9ezC9NEKg-1
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>
Cc: virtio-comment@lists.oasis-open.org, david.edmondson@oracle.com,
 virtio-dev@lists.oasis-open.org, sburla@marvell.com, jasowang@redhat.com,
 yishaih@nvidia.com, maorg@nvidia.com, shahafs@nvidia.com
In-Reply-To: <20230706183617-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <20230706212722.97973-1-parav@nvidia.com>
 <20230706183617-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Fri, 07 Jul 2023 13:37:08 +0200
Message-ID: <87sfa00x7f.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [PATCH v11 0/3] admin: Access legacy registers using admin
 commands

On Thu, Jul 06 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, Jul 07, 2023 at 12:27:19AM +0300, Parav Pandit wrote:
>> This short series introduces legacy registers access commands for the owner
>> group member access the legacy registers of the member VFs.
>> This short series introduces legacy region access commands by the group owner
>> device for its member devices.
>> Currently it is applicable to the PCI PF and VF devices. If in future any
>> SIOV devices to support legacy registers, they can be easily supported using
>> same commands by using the group member identifiers of the future SIOV devices.
>> 
>> More details as overview, motivation, use case are further described
>> below.
>
> corneli want to apply 1,2 as editorial?

I guess that makes sense to get them out of the way.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

