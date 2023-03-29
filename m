Return-Path: <virtio-dev-return-11831-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0208DC761A6
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 09:01:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1AF5367045
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 09:01:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 017CA9864B8
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 09:01:12 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E11D29864A3; Wed, 29 Mar 2023 09:01:12 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CD2999864A4
	for <virtio-dev@lists.oasis-open.org>; Wed, 29 Mar 2023 09:01:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: uzF27P4VM7qprtxiTmefrA-1
From: Cornelia Huck <cohuck@redhat.com>
To: Parav Pandit <parav@nvidia.com>, mst@redhat.com,
 virtio-dev@lists.oasis-open.org, pasic@linux.ibm.com
Cc: sgarzare@redhat.com, virtio-comment@lists.oasis-open.org,
 shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230328201754.440974-2-parav@nvidia.com>
Organization: Red Hat GmbH
References: <20230328201754.440974-1-parav@nvidia.com>
 <20230328201754.440974-2-parav@nvidia.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Wed, 29 Mar 2023 11:01:06 +0200
Message-ID: <87zg7wlynh.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [PATCH v9 1/8] content: Add vq number text

On Tue, Mar 28 2023, Parav Pandit <parav@nvidia.com> wrote:

> Introduce vq number and its range so that subsequent patches can refer
> to it.
>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
> changelog:
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
>
> diff --git a/content.tex b/content.tex
> index cff548a..3766bf9 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -298,6 +298,10 @@ \section{Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Virtqueues}
>  virtqueues\footnote{For example, the simplest network device has one virtqueue for
>  transmit and one for receive.}.
>  
> +Each virtqueue is identified by a vq number or also referred
> +to as a virtqueue number;

I think "identified by a vq number (also referred to as a virtqueue
number)" would read better.

> vq number range is from 0 to 65535
> +inclusive.
> +
>  Driver makes requests available to device by adding
>  an available buffer to the queue, i.e., adding a buffer
>  describing the request to a virtqueue, and optionally triggering


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

