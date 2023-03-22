Return-Path: <virtio-dev-return-11706-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A53C6FD1F
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 15:20:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A6DEE3252
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 15:20:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7D92B98646D
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 15:20:38 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5E37E98644E; Wed, 22 Mar 2023 15:20:38 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4BBD5986450
	for <virtio-dev@lists.oasis-open.org>; Wed, 22 Mar 2023 15:20:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: z8yZfS6PNBqcXfPSJCBhTA-1
From: Cornelia Huck <cohuck@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>, virtio-dev@lists.oasis-open.org,
 virtio-comment@lists.oasis-open.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>,
 Jason Wang <jasowang@redhat.com>, Alvaro Karsz
 <alvaro.karsz@solid-run.com>, David Edmondson
 <david.edmondson@oracle.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230322125153.128385-1-hengqi@linux.alibaba.com>
Organization: Red Hat GmbH
References: <20230322125153.128385-1-hengqi@linux.alibaba.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Wed, 22 Mar 2023 16:20:33 +0100
Message-ID: <87sfdwhkxq.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [PATCH v13] virtio-net: support the virtqueue coalescing
 moderation

On Wed, Mar 22 2023, Heng Qi <hengqi@linux.alibaba.com> wrote:

> +The driver MUST NOT set \field{vqn} to any value other than an enabled transmit or receive virtqueue number.

"than the virtqueue number of an enabled transmit or receive virtqueue"

might be better -- what do others think?

Otherwise, LGTM.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

