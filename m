Return-Path: <virtio-dev-return-11834-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF0AC6FD18
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 09:18:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 54843120D47
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 09:18:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4E5379864BA
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 09:18:42 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 453209864A4; Wed, 29 Mar 2023 09:18:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 30CFE9864A3
	for <virtio-dev@lists.oasis-open.org>; Wed, 29 Mar 2023 09:18:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: uMAh0thxML2CCU7Jb_-3PQ-1
From: Cornelia Huck <cohuck@redhat.com>
To: Parav Pandit <parav@nvidia.com>, mst@redhat.com,
 virtio-dev@lists.oasis-open.org, pasic@linux.ibm.com
Cc: sgarzare@redhat.com, virtio-comment@lists.oasis-open.org,
 shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>, Jiri Pirko
 <jiri@nvidia.com>
In-Reply-To: <20230328201754.440974-5-parav@nvidia.com>
Organization: Red Hat GmbH
References: <20230328201754.440974-1-parav@nvidia.com>
 <20230328201754.440974-5-parav@nvidia.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Wed, 29 Mar 2023 11:18:33 +0200
Message-ID: <87r0t7nceu.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [PATCH v9 4/8] transport-mmio: Refer to the vq by its number

On Tue, Mar 28 2023, Parav Pandit <parav@nvidia.com> wrote:

> Currently specification uses virtqueue index and
> number interchangeably to refer to the virtqueue.
>
> Instead refer to it by its number.
>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
>
> ---
> changelog:
> v8->v9:
> - added 'by' at two places
> - replaced 'queue number' with 'vq number'
>
> v6->v7:
> - remove text around first vq as it is already covered in the basic
>   virtqueues facility section
> ---
>  transport-mmio.tex | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

