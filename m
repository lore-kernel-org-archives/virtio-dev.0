Return-Path: <virtio-dev-return-13256-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9ABEB64DC
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 13:39:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0B0B4866A8
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 13:39:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E411B98672E
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 13:39:17 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CCE68986726; Thu,  6 Jul 2023 13:39:17 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B8E0E986727
	for <virtio-dev@lists.oasis-open.org>; Thu,  6 Jul 2023 13:39:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: s879jbhoNouN5M3BzrJHeA-1
From: Cornelia Huck <cohuck@redhat.com>
To: Parav Pandit <parav@nvidia.com>, virtio-comment@lists.oasis-open.org,
 mst@redhat.com, david.edmondson@oracle.com
Cc: virtio-dev@lists.oasis-open.org, sburla@marvell.com,
 jasowang@redhat.com, yishaih@nvidia.com, maorg@nvidia.com,
 shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230706041714.65600-3-parav@nvidia.com>
Organization: Red Hat GmbH
References: <20230706041714.65600-1-parav@nvidia.com>
 <20230706041714.65600-3-parav@nvidia.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Thu, 06 Jul 2023 15:39:11 +0200
Message-ID: <87wmzdupkw.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [PATCH v10 2/4] admin: Fix section numbering

On Thu, Jul 06 2023, Parav Pandit <parav@nvidia.com> wrote:

> Requirements are put one additional level down. Fix it.
>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
> changelog:
> v9->v10:
> - addressed comments from Cornelia
> - fixed requirements for administration virtqueue section
> v4->v5:
> - new patch
> ---
>  admin.tex | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

