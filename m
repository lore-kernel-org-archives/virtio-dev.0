Return-Path: <virtio-dev-return-11836-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D931C74A5B
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 09:30:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B627626A27
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 09:30:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A61199864B0
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 09:30:21 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 990B098649F; Wed, 29 Mar 2023 09:30:21 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 87CBD9864A3
	for <virtio-dev@lists.oasis-open.org>; Wed, 29 Mar 2023 09:30:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: xau8s-CJM1u2SpvjIDfoPA-1
From: Cornelia Huck <cohuck@redhat.com>
To: Parav Pandit <parav@nvidia.com>, mst@redhat.com,
 virtio-dev@lists.oasis-open.org, pasic@linux.ibm.com
Cc: sgarzare@redhat.com, virtio-comment@lists.oasis-open.org,
 shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230328201754.440974-7-parav@nvidia.com>
Organization: Red Hat GmbH
References: <20230328201754.440974-1-parav@nvidia.com>
 <20230328201754.440974-7-parav@nvidia.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Wed, 29 Mar 2023 11:30:15 +0200
Message-ID: <87lejfnbvc.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [PATCH v9 6/8] transport-ccw: Refer to the vq by its number

On Tue, Mar 28 2023, Parav Pandit <parav@nvidia.com> wrote:

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
>  transport-ccw.tex | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/transport-ccw.tex b/transport-ccw.tex
> index 488c46c..0240db8 100644
> --- a/transport-ccw.tex
> +++ b/transport-ccw.tex
> @@ -236,12 +236,12 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
>  
>  \begin{lstlisting}
>  struct vq_config_block {
> -        be16 index;
> +        be16 queue_select; /* Previously known as index */
>          be16 max_queue_size; /* Previously known as max_num */

Same comment regarding s/Previously/previously/ as for the last patch.

Also, I'm not that happy with the name "queue_select". Sure, it matches
what pci and mmio use, but ccw does not quite use the same mechanism:
vq_config_block is not a structure that always exists where the meaning
of the fields is controlled by a selector field, but a structure that is
provided by the caller and then filled to refer to a certain vq. I'd
prefer this field to be named "vq_num" or something like that.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

