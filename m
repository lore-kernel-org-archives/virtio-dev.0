Return-Path: <virtio-dev-return-11835-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF5DC6FD18
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 09:23:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id ED3091CA245
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 09:23:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D2A2C9864B2
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 09:23:53 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BF1959864A4; Wed, 29 Mar 2023 09:23:53 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ADFBD98649F
	for <virtio-dev@lists.oasis-open.org>; Wed, 29 Mar 2023 09:23:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: JbA9_7o0NU6i3L1zjEvTcQ-1
From: Cornelia Huck <cohuck@redhat.com>
To: Parav Pandit <parav@nvidia.com>, mst@redhat.com,
 virtio-dev@lists.oasis-open.org, pasic@linux.ibm.com
Cc: sgarzare@redhat.com, virtio-comment@lists.oasis-open.org,
 shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230328201754.440974-6-parav@nvidia.com>
Organization: Red Hat GmbH
References: <20230328201754.440974-1-parav@nvidia.com>
 <20230328201754.440974-6-parav@nvidia.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Wed, 29 Mar 2023 11:23:47 +0200
Message-ID: <87o7obnc64.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [PATCH v9 5/8] transport-ccw: Rename queue depth/size to other
 transports

On Tue, Mar 28 2023, Parav Pandit <parav@nvidia.com> wrote:

> max_num field reflects the maximum queue size/depth. Hence align name of
> this field with similar field in PCI and MMIO transport to
> max_queue_size.
> Similarly rename 'num' to 'size'.
>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
> Signed-off-by: Parav Pandit <parav@nvidia.com>
>
> ---
> changelog:
> v8->v9:
> - replaced 'named' as 'known'
> v3->v4:
> - moved note to comment
> ---
>  transport-ccw.tex | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/transport-ccw.tex b/transport-ccw.tex
> index c492cb9..488c46c 100644
> --- a/transport-ccw.tex
> +++ b/transport-ccw.tex
> @@ -237,12 +237,12 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
>  \begin{lstlisting}
>  struct vq_config_block {
>          be16 index;
> -        be16 max_num;
> +        be16 max_queue_size; /* Previously known as max_num */

Nit: the comment should probably start with a lower-case 'p', as it is
not a complete sentence (further instances of this below).

Otherwise,

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

