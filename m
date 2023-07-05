Return-Path: <virtio-dev-return-13230-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128BAEB64DA
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Jul 2023 10:09:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3EF8D3309B
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Jul 2023 10:09:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2203A98671F
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Jul 2023 10:09:41 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0A74398670E; Wed,  5 Jul 2023 10:09:41 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EAEAA986712
	for <virtio-dev@lists.oasis-open.org>; Wed,  5 Jul 2023 10:09:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: t7ssxjoxN5ClmlDMlgHfQg-1
From: Cornelia Huck <cohuck@redhat.com>
To: Parav Pandit <parav@nvidia.com>, virtio-comment@lists.oasis-open.org,
 mst@redhat.com, david.edmondson@oracle.com
Cc: virtio-dev@lists.oasis-open.org, sburla@marvell.com,
 jasowang@redhat.com, yishaih@nvidia.com, maorg@nvidia.com,
 shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230704233724.22394-3-parav@nvidia.com>
Organization: Red Hat GmbH
References: <20230704233724.22394-1-parav@nvidia.com>
 <20230704233724.22394-3-parav@nvidia.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Wed, 05 Jul 2023 12:09:37 +0200
Message-ID: <87ilay3c0u.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [PATCH v9 2/4] admin: Fix section numbering

On Wed, Jul 05 2023, Parav Pandit <parav@nvidia.com> wrote:

> Requirements are put one additional level down. Fix it.
>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
> changelog:
> v4->v5:
> - new patch
> ---
>  admin.tex | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Same thing applies to the normative statements for the admin vq (in the
same file) -- do you want to fix that as well?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

