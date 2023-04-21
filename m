Return-Path: <virtio-dev-return-12340-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3B0C77B7D
	for <virtio-dev@archiver.kernel.org>; Fri, 21 Apr 2023 13:56:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 74CD433585
	for <virtio-dev@archiver.kernel.org>; Fri, 21 Apr 2023 13:56:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6A055986646
	for <virtio-dev@archiver.kernel.org>; Fri, 21 Apr 2023 13:56:48 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5E2FC986637; Fri, 21 Apr 2023 13:56:48 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4A7D598663F
	for <virtio-dev@lists.oasis-open.org>; Fri, 21 Apr 2023 13:56:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: zDugvD9eMbC1ATeQKxhi_g-1
From: Cornelia Huck <cohuck@redhat.com>
To: Parav Pandit <parav@nvidia.com>, mst@redhat.com,
 virtio-dev@lists.oasis-open.org
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Parav Pandit
 <parav@nvidia.com>
In-Reply-To: <20230420195554.69907-1-parav@nvidia.com>
Organization: Red Hat GmbH
References: <20230420195554.69907-1-parav@nvidia.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Fri, 21 Apr 2023 15:56:39 +0200
Message-ID: <87leil49uw.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [PATCH v1] device-types/multiple: replace queues with enqueues

On Thu, Apr 20 2023, Parav Pandit <parav@nvidia.com> wrote:

> Queue is a verb and noun both. Replacing it with enqueue avoids
> ambiguity around plural queues noun vs verb; similar to virtio fs device
> description.
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
> changelog:
> v0->v1:
> - replace 'on' to 'to'
> ---
>  device-types/blk/description.tex   | 2 +-
>  device-types/gpio/description.tex  | 4 ++--
>  device-types/i2c/description.tex   | 2 +-
>  device-types/scsi/description.tex  | 2 +-
>  device-types/vsock/description.tex | 2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)

Thanks, pushed as editorial update.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

