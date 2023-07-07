Return-Path: <virtio-dev-return-13313-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D2CEB64D9
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 11:46:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4FD4C2B03B
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 11:46:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2DBF0986812
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 11:46:24 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0A7FB9867EB; Fri,  7 Jul 2023 11:46:24 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E9E489867F9
	for <virtio-dev@lists.oasis-open.org>; Fri,  7 Jul 2023 11:46:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: BvxmypFzOayfXB300WvGGw-1
From: Cornelia Huck <cohuck@redhat.com>
To: Parav Pandit <parav@nvidia.com>, virtio-comment@lists.oasis-open.org,
 mst@redhat.com, david.edmondson@oracle.com
Cc: virtio-dev@lists.oasis-open.org, sburla@marvell.com,
 jasowang@redhat.com, yishaih@nvidia.com, maorg@nvidia.com,
 shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230707035401.107855-1-parav@nvidia.com>
Organization: Red Hat GmbH
References: <20230707035401.107855-1-parav@nvidia.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Fri, 07 Jul 2023 13:46:18 +0200
Message-ID: <87pm540ws5.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [PATCH v12 0/3] admin: Access legacy registers using admin
 commands

On Fri, Jul 07 2023, Parav Pandit <parav@nvidia.com> wrote:

> This short series introduces legacy registers access commands for the owner
> group member access the legacy registers of the member VFs.
> This short series introduces legacy region access commands by the group owner
> device for its member devices.
> Currently it is applicable to the PCI PF and VF devices. If in future any
> SIOV devices to support legacy registers, they can be easily supported using
> same commands by using the group member identifiers of the future SIOV devices.
>
> More details as overview, motivation, use case are further described
> below.
>
> Patch summary:
> --------------
> patch-1 fix split rows of admin opcode tables by a line
> patch-2 fix section numbering

Pushed 1+2 as editorial updates.

> patch-3 add legacy region access commands


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

