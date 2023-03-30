Return-Path: <virtio-dev-return-11851-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04BF6C77B61
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 07:48:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5D9F560350
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 07:48:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 583AA986546
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 07:48:07 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4EA88986526; Thu, 30 Mar 2023 07:48:07 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3F73B986529
	for <virtio-dev@lists.oasis-open.org>; Thu, 30 Mar 2023 07:48:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: jhIhNXk0OxG9NlpqxUGzGA-1
From: Cornelia Huck <cohuck@redhat.com>
To: Parav Pandit <parav@nvidia.com>, mst@redhat.com,
 virtio-dev@lists.oasis-open.org, pasic@linux.ibm.com
Cc: sgarzare@redhat.com, virtio-comment@lists.oasis-open.org,
 shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230329212341.465843-7-parav@nvidia.com>
Organization: Red Hat GmbH
References: <20230329212341.465843-1-parav@nvidia.com>
 <20230329212341.465843-7-parav@nvidia.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Thu, 30 Mar 2023 09:48:01 +0200
Message-ID: <87zg7ufzny.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [PATCH v10 6/8] transport-ccw: Refer to the vq by its number

On Thu, Mar 30 2023, Parav Pandit <parav@nvidia.com> wrote:

> Currently specification uses virtqueue index and
> number interchangeably to refer to the virtqueue.
>
> Instead refer to it by its number.
>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
> Signed-off-by: Parav Pandit <parav@nvidia.com>
>
> ---
> changelog:
> v9->v10:
> - replaced queue_select with vqn
> - used lower case letter for first word in comment
> v8->v9:
> - replaced 'named' with 'known'
> - replaced 'queue number' with 'vq number'
> v3->v4:
> - moved note to comment
> v2->v3:
> - added comment note for queue_select similar to max_queue_size
> v0->v1:
> - new patch
> ---
>  transport-ccw.tex | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

