Return-Path: <virtio-dev-return-12008-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F963C7619A
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 09:18:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 50E223DF28
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 09:18:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3DDCA9865B8
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 09:18:52 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3360A983DE1; Wed,  5 Apr 2023 09:18:52 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 241269865A7
	for <virtio-dev@lists.oasis-open.org>; Wed,  5 Apr 2023 09:18:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: _t_O2Va5NOKJc9RS2ow3Gg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680686329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3AHc4v0+BX+AM2wGA0FyfpprjMfdCEl63nKe0SwUdgA=;
        b=H+Hail5lrDrkCjryDLXvYKiOQgswOjnW/PuYR0rdgO7BniICDNs1kcZd6HBN3nZA2Q
         1isNgEeuNd7c4nMx2j9Lf6b7iWUEgDsHBKFUU1f5+tPs66imsI7KUWjCIEEGAXxsO8lO
         p7ldSFMAKCoGFYfpNsr0lJ1ttN6LSaUcLFzXVsL8TbTwb97ObEzB9NqwPS5ssQoxAem5
         +l5MlMwocM8VpbWi6iXpSHdX6gKD+gGu8b1sWL/1GsszKkNhk2dZSWtG2D4GakdbxM1/
         gObJCmKXgtoauQxj72e1N/zQNkHMdf/PU8/Jv/ZUh4VobjEZQXusllOnWdTQ8xyqbkH4
         D6lA==
X-Gm-Message-State: AAQBX9dCjN8GBv98waEhWzp5luiKP9OeJw4WdXmGPjdOXHuvfg3mWpcr
	AJt8HsUBQl4D7M1xN+7rB8xxPUtLBv0gMqje796Jt6piLXf6pDMqodWW3ZRyBcy9NXb/tU4v36P
	Mj0f+TfGnJ1kYoPUwscxc+k/9tHG5
X-Received: by 2002:a17:906:454c:b0:946:fa68:1a91 with SMTP id s12-20020a170906454c00b00946fa681a91mr2253322ejq.75.1680686329050;
        Wed, 05 Apr 2023 02:18:49 -0700 (PDT)
X-Google-Smtp-Source: AKy350a1k+NuBfllcUC8UeSOAvvSzg+yoyv9eyMQom1kSAohX2PFnTnKTtgjkyIBKsz6ykEZEViAug==
X-Received: by 2002:a17:906:454c:b0:946:fa68:1a91 with SMTP id s12-20020a170906454c00b00946fa681a91mr2253312ejq.75.1680686328790;
        Wed, 05 Apr 2023 02:18:48 -0700 (PDT)
Date: Wed, 5 Apr 2023 05:18:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com, sgarzare@redhat.com,
	pasic@linux.ibm.com, virtio-comment@lists.oasis-open.org,
	shahafs@nvidia.com
Message-ID: <20230405051801-mutt-send-email-mst@kernel.org>
References: <20230405010657.612529-1-parav@nvidia.com>
 <20230405010657.612529-2-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230405010657.612529-2-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v12 01/10] content: Add vq index text

On Wed, Apr 05, 2023 at 04:06:48AM +0300, Parav Pandit wrote:
> Introduce vq index and its range so that subsequent patches can refer
> to it.
> 
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
> changelog:
> v11->v12:
> - renamed 'number' to 'index'
> v9->v10:
> - added braces around vq number wording
> - added vqn as another term for vq number
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
> index cff548a..e64115c 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -298,6 +298,10 @@ \section{Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Virtqueues}
>  virtqueues\footnote{For example, the simplest network device has one virtqueue for
>  transmit and one for receive.}.
>  
> +Each virtqueue is identified by a vq index (also referred
> +to as a virtqueue index); vq index range is from 0 to 65535
> +inclusive.
> +

In fact can we just say "virtqueue index" everywhere? The less slang
reader has to learn, the better.

>  Driver makes requests available to device by adding
>  an available buffer to the queue, i.e., adding a buffer
>  describing the request to a virtqueue, and optionally triggering
> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

