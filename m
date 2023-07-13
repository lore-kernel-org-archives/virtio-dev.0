Return-Path: <virtio-dev-return-13372-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04249EB64DD
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Jul 2023 09:13:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 72A4242C34
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Jul 2023 09:13:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 69B7A9867D2
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Jul 2023 09:13:12 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5D6DE9867C2; Thu, 13 Jul 2023 09:13:12 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4C9BB9867C4
	for <virtio-dev@lists.oasis-open.org>; Thu, 13 Jul 2023 09:13:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: AIc7cnlPP72_q910md45hQ-1
From: Cornelia Huck <cohuck@redhat.com>
To: Parav Pandit <parav@nvidia.com>, virtio-comment@lists.oasis-open.org,
 mst@redhat.com
Cc: virtio-dev@lists.oasis-open.org, hengqi@linux.alibaba.com,
 shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230712222405.455201-2-parav@nvidia.com>
Organization: Red Hat GmbH
References: <20230712222405.455201-1-parav@nvidia.com>
 <20230712222405.455201-2-parav@nvidia.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Thu, 13 Jul 2023 11:13:04 +0200
Message-ID: <87wmz4qin3.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [virtio-comment] [PATCH 1/4] virtio-net: Place C code under
 listing

On Thu, Jul 13 2023, Parav Pandit <parav@nvidia.com> wrote:

> With extra white space for the define, pdf generation fails.
> Also place the C code under listing.
>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
>  device-types/net/description.tex | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/device-types/net/description.tex b/device-types/net/description.tex
> index 206020d..6fd4a20 100644
> --- a/device-types/net/description.tex
> +++ b/device-types/net/description.tex
> @@ -1024,12 +1024,14 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
>  If VIRTIO_NET_F_HASH_TUNNEL has been negotiated, the driver can send the command
>  VIRTIO_NET_CTRL_HASH_TUNNEL_SET to configure the calculation of the inner header hash.
>  
> +\begin{lstlisting}
>  struct virtnet_hash_tunnel {
>      le32 enabled_tunnel_types;
>  };
>  
>  #define VIRTIO_NET_CTRL_HASH_TUNNEL 7
> - #define VIRTIO_NET_CTRL_HASH_TUNNEL_SET 0
> +#define VIRTIO_NET_CTRL_HASH_TUNNEL_SET 0

I think the indentation here is intentional (as in other, similare
sections.)

> +\end{lstlisting}
>  
>  Field \field{enabled_tunnel_types} contains the bitmask of encapsulation types enabled for inner header hash.
>  See \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets /


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

