Return-Path: <virtio-dev-return-11606-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83722C6FD1C
	for <virtio-dev@archiver.kernel.org>; Sat, 11 Mar 2023 21:18:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E827F42B69
	for <virtio-dev@archiver.kernel.org>; Sat, 11 Mar 2023 21:18:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DA48898672C
	for <virtio-dev@archiver.kernel.org>; Sat, 11 Mar 2023 21:18:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CF38F986198; Sat, 11 Mar 2023 21:18:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BE137986725
	for <virtio-dev@lists.oasis-open.org>; Sat, 11 Mar 2023 21:18:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: VrFnuf7_PEqogA_k7zShvw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678569499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmB83oTeEMlqGOyv7Adnkkwksgt9i7gzl2V2stLZx2U=;
        b=5bZjYGHOVzcVgU0z7sBd1sjvLEgG4XxLxQ10qD0vAfGmqdxtYdGg0aUsr2JxLI0RQ9
         k8UTdF5TUImLSabVd9SlkKSsWaDI40PSzIVPnV3MmX02fNoVRKepVczf16ajb/5bIIQm
         He3IkCzRqBpx9lLq1N3SUhJvNXY5He1IRQHtoGAaG0zBxa0V4fKbVuc+RpLSCJsUD/g6
         sKI0mvbAFxjfAzftLqOL0PKynGtb8kgq7iNdp8bTYcvZ7K1iW570cyA+c7ovaGEIkPg+
         QKykjQI2LYB8FRmuQe4p7giVOA8i+qdyoMV6jky+6En6awvjDNtYbFm5be+LHkB4X9Iv
         eO0Q==
X-Gm-Message-State: AO0yUKXnIBSpIM9TcV19uM1f3M6ktq/8OPrK7oTN+X/3eR1AzHnHL3J9
	hMkot3OD04/uFp5/3rH5jYPH7BEGO/j7eZWMzhOVYe82A9VgH0Swse0McYo8Mu5wXdz+BDWZngT
	VggDSh99mCB+S5RQGjdWqg2s1LeDM
X-Received: by 2002:a05:600c:3ca2:b0:3eb:3104:efec with SMTP id bg34-20020a05600c3ca200b003eb3104efecmr6926427wmb.16.1678569499650;
        Sat, 11 Mar 2023 13:18:19 -0800 (PST)
X-Google-Smtp-Source: AK7set9u4uq2syB+wOV1QIYHjN5Q8QFjeovcn4qweQpp3F+KUXPPKAXVjuY/UQYUO/SU2WHIZkFRWQ==
X-Received: by 2002:a05:600c:3ca2:b0:3eb:3104:efec with SMTP id bg34-20020a05600c3ca200b003eb3104efecmr6926414wmb.16.1678569499302;
        Sat, 11 Mar 2023 13:18:19 -0800 (PST)
Date: Sat, 11 Mar 2023 16:18:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
Message-ID: <20230311161751-mutt-send-email-mst@kernel.org>
References: <20230310150519.115090-1-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230310150519.115090-1-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH] virtio-net: Fix virtqueues spelling error

On Fri, Mar 10, 2023 at 05:05:19PM +0200, Parav Pandit wrote:
> Correct spelling from virtqueus to virtqueues.
> 
> Signed-off-by: Parav Pandit <parav@nvidia.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

A minor cleanup Cornelia can you commit?

> ---
>  device-types/net/description.tex | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/device-types/net/description.tex b/device-types/net/description.tex
> index 4cd89ca..960a2e4 100644
> --- a/device-types/net/description.tex
> +++ b/device-types/net/description.tex
> @@ -1438,7 +1438,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  Field \field{unclassified_queue} contains the 0-based index of
>  the receive virtqueue to place unclassified packets in. Index 0 corresponds to receiveq1.
>  
> -Field \field{indirection_table} contains an array of 0-based indices of receive virtqueus. Index 0 corresponds to receiveq1.
> +Field \field{indirection_table} contains an array of 0-based indices of receive virtqueues. Index 0 corresponds to receiveq1.
>  
>  A driver sets \field{max_tx_vq} to inform a device how many transmit virtqueues it may use (transmitq1\ldots transmitq \field{max_tx_vq}).
>  
> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

