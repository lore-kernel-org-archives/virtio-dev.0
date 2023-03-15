Return-Path: <virtio-dev-return-11617-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CFEC61DA4
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 11:17:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C6AC37604B
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 11:17:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BD0DC98641B
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 11:17:38 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B25D69863FC; Wed, 15 Mar 2023 11:17:38 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A1A23986402
	for <virtio-dev@lists.oasis-open.org>; Wed, 15 Mar 2023 11:17:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: u2jV-1HpNbaR_bbqVViixA-1
From: Cornelia Huck <cohuck@redhat.com>
To: Parav Pandit <parav@nvidia.com>, mst@redhat.com,
 virtio-dev@lists.oasis-open.org
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Parav Pandit
 <parav@nvidia.com>
In-Reply-To: <20230310150519.115090-1-parav@nvidia.com>
Organization: Red Hat GmbH
References: <20230310150519.115090-1-parav@nvidia.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Wed, 15 Mar 2023 12:17:34 +0100
Message-ID: <87pm9atga9.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [PATCH] virtio-net: Fix virtqueues spelling error

On Fri, Mar 10 2023, Parav Pandit <parav@nvidia.com> wrote:

> Correct spelling from virtqueus to virtqueues.
>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
>  device-types/net/description.tex | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, pushed as editorial update.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

