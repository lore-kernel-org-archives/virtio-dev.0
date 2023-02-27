Return-Path: <virtio-dev-return-11311-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D626CC64ED6
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 08:45:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1E40D2A82E
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 08:45:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 189BE98640A
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 08:45:38 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 095179863ED; Mon, 27 Feb 2023 08:45:38 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EDEB69863FE
	for <virtio-dev@lists.oasis-open.org>; Mon, 27 Feb 2023 08:45:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 5_K-mEfoOC6V99i1cnCTUQ-1
From: Cornelia Huck <cohuck@redhat.com>
To: Parav Pandit <parav@nvidia.com>, mst@redhat.com,
 virtio-dev@lists.oasis-open.org
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Parav Pandit
 <parav@nvidia.com>
In-Reply-To: <20230223054624.168042-1-parav@nvidia.com>
Organization: Red Hat GmbH
References: <20230223054624.168042-1-parav@nvidia.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Mon, 27 Feb 2023 09:45:31 +0100
Message-ID: <87a60z5wes.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [PATCH 0/3] Rename queue index to queue number
Message-ID: <20230227084531.xArqFv_bE_61iwHFaRPeU2dj1ENOvw2V4-TTmQWJkMw@z>

On Thu, Feb 23 2023, Parav Pandit <parav@nvidia.com> wrote:

> 1. Currently, virtqueue is identified between driver and device
> interchangeably using either number of index terminology.
>
> 2. Between PCI and MMIO transport the queue size (depth) is
> defined as queue_size and QueueNum respectively.
>
> To avoid confusion and to have consistency, unify them to use as Number.
>
> Solution:
> Use virtqueue number description, and rename MMIO register as QueueSize.
>
> Patch summary:
> patch-1 renames index to number for pci transport
> patch-2 renames mmio register from Num to Size
> patch-3 renames index to number for mmio transport
>
> Please review.
> This series fixes the issue [1].
>
> This series is on top of [2].
>
> [1] https://github.com/oasis-tcs/virtio-spec/issues/163
> [2] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00527.html
>
> ---
> Cornelia:
> I was not sure about ccw for vq_config_block and vq_info_block structures
> index field refers to the queue number or not.
> Can you please clarify?
>
> If it vqn, I will send v1 by replacing index to vqn to be
> consistent with other part of the spec which also uses vqn.

The vq_*_block structures use "index" for the vq index/number and "num"
for the number of buffers (queue size).

I'm wondering what terminology we should standardize on. For the size of
the queue, we have queue_size, QueueNum, and num. Calling it some
variation of "queue size" and mentioning that it refers to the number of
buffers makes sense.

For the vq index/number, I'm not that sure that "virtqueue number" is
better that "virtqueue index" -- actually, I'd prefer the latter. We'd
need some renaming either way.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

