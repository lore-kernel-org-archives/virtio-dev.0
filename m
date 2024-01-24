Return-Path: <virtio-dev-return-14272-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32712C46CD2
	for <virtio-dev@archiver.kernel.org>; Wed, 24 Jan 2024 11:28:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9A9542ACAF
	for <virtio-dev@archiver.kernel.org>; Wed, 24 Jan 2024 11:28:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 957209867DD
	for <virtio-dev@archiver.kernel.org>; Wed, 24 Jan 2024 11:28:41 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8ABBC9867DB; Wed, 24 Jan 2024 11:28:41 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 791289867D8;
	Wed, 24 Jan 2024 11:28:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W.GhlK9_1706095713;
Message-ID: <e2fdfb70-a3e0-4110-a73a-e81467ce8cad@linux.alibaba.com>
Date: Wed, 24 Jan 2024 19:28:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Michael S. Tsirkin" <mst@redhat.com>,
 virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: virtio@lists.oasis-open.org
References: <ff9a6d805e7d510cde77b9989bef90aa21ffe4b4.1706094950.git.mst@redhat.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <ff9a6d805e7d510cde77b9989bef90aa21ffe4b4.1706094950.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] [PATCH] virtio-net: clarify error handling for
 coalescing



在 2024/1/24 下午7:15, Michael S. Tsirkin 写道:
> This is not a huge deal since it's a SHOULD anyway,
> so make the new requirement SHOULD too.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   device-types/net/description.tex | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/device-types/net/description.tex b/device-types/net/description.tex
> index aff5e08..d1d25fe 100644
> --- a/device-types/net/description.tex
> +++ b/device-types/net/description.tex
> @@ -1792,7 +1792,11 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>   
>   The device MUST ignore \field{reserved}.
>   
> -The device SHOULD respond to VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_RX_SET commands with VIRTIO_NET_ERR if it was not able to change the parameters.
> +The device SHOULD respond to VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and
> +VIRTIO_NET_CTRL_NOTF_COAL_RX_SET commands with VIRTIO_NET_ERR if
> +it was not able to change coalescing parameters. In this case,
> +the parameters SHOULD remain unchanged, for all VQs.

Can we use "virtqueues" instead of "VQs"? Because "VQs" has not been 
used in the text.

With this,

Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>

Thanks!

> +
>   
>   The device MUST respond to the VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command with VIRTIO_NET_ERR if it was not able to change the parameters.
>   


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

