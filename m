Return-Path: <virtio-dev-return-12312-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D78A6C77B73
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 13:33:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 027042A88B
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 13:33:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C9285986613
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 13:33:06 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A69C4986422; Wed, 19 Apr 2023 13:33:06 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 93744986426
	for <virtio-dev@lists.oasis-open.org>; Wed, 19 Apr 2023 13:33:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: -13KhuMkMvGo6L2aaEo4VA-1
From: Cornelia Huck <cohuck@redhat.com>
To: Parav Pandit <parav@nvidia.com>, mst@redhat.com,
 virtio-dev@lists.oasis-open.org, pasic@linux.ibm.com
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Parav Pandit
 <parav@nvidia.com>
In-Reply-To: <20230411200358.753101-1-parav@nvidia.com>
Organization: Red Hat GmbH
References: <20230411200358.753101-1-parav@nvidia.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Wed, 19 Apr 2023 15:33:01 +0200
Message-ID: <87bkjkngj6.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [PATCH] device-types/multiple: replace queues with enqueues

On Tue, Apr 11 2023, Parav Pandit <parav@nvidia.com> wrote:

> Queue is a verb and noun both. Replacing it with enqueue avoids
> ambiguity around plural queues noun vs verb; similar to virtio fs device
> description.

Personally, I don't think this patch adds much, but I don't really mind
it, either.

>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
>  device-types/blk/description.tex   | 2 +-
>  device-types/gpio/description.tex  | 4 ++--
>  device-types/i2c/description.tex   | 2 +-
>  device-types/scsi/description.tex  | 2 +-
>  device-types/vsock/description.tex | 2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)
>

(...)

> diff --git a/device-types/vsock/description.tex b/device-types/vsock/description.tex
> index 105bb30..07909d6 100644
> --- a/device-types/vsock/description.tex
> +++ b/device-types/vsock/description.tex
> @@ -218,7 +218,7 @@ \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device /
>  \field{buf_alloc} and \field{fwd_cnt} fields.
>  
>  \subsubsection{Receive and Transmit}\label{sec:Device Types / Socket Device / Device Operation / Receive and Transmit}
> -The driver queues outgoing packets on the tx virtqueue and incoming packet
> +The driver enqueues outgoing packets on the tx virtqueue and incoming packet

"queues (...) on" reads natural to me, but I'd use "to" with
"enqueues"... can any native speakers comment?

>  receive buffers on the rx virtqueue. Packets are of the following form:
>  
>  \begin{lstlisting}


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

