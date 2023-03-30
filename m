Return-Path: <virtio-dev-return-11850-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F737C77B61
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 07:44:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 71ABA42B8E
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 07:44:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6775398654B
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 07:44:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5CF8C98652B; Thu, 30 Mar 2023 07:44:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 42CD8986528
	for <virtio-dev@lists.oasis-open.org>; Thu, 30 Mar 2023 07:44:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: WV5BJ9UPMpGVK-U_PtCwfw-1
From: Cornelia Huck <cohuck@redhat.com>
To: Parav Pandit <parav@nvidia.com>, mst@redhat.com,
 virtio-dev@lists.oasis-open.org, pasic@linux.ibm.com
Cc: sgarzare@redhat.com, virtio-comment@lists.oasis-open.org,
 shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230329212341.465843-2-parav@nvidia.com>
Organization: Red Hat GmbH
References: <20230329212341.465843-1-parav@nvidia.com>
 <20230329212341.465843-2-parav@nvidia.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Thu, 30 Mar 2023 09:44:32 +0200
Message-ID: <87355mhee7.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [PATCH v10 1/8] content: Add vq number text

On Thu, Mar 30 2023, Parav Pandit <parav@nvidia.com> wrote:

> Introduce vq number and its range so that subsequent patches can refer
> to it.
>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
> changelog:
> v9->v10:
> - added braces around vq number wording
> - added vqn as another term for vq number
> v8->v9:
> - added inclusive when describing the vq number range
> - skipped comment to put virtqueue number wording first because we
>   prefer to use shorter vq number as much as possible
> v5->v6:
> - moved description close to introduction, it was in middle of
>   queue data transfer description
> v2->v3:
> - new patch
> ---
>  content.tex | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

