Return-Path: <virtio-dev-return-12002-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68648C761AF
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 05:26:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B12C2419A9
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 05:26:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A86ED9865BD
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 05:26:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9C69C983DE1; Wed,  5 Apr 2023 05:26:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8C5C79865A8
	for <virtio-dev@lists.oasis-open.org>; Wed,  5 Apr 2023 05:26:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: UKtlYGEGMDSih7W5pCnP_w-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680672377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVBjKFnPp7zMkB8af0HRYEyi5okeTVUw6bRVVChTmGg=;
        b=ODGzzG4j2wDrY1xyXwiiP61Xtk/3owxomfHiCNJcH+eLIBTZgZSueuYJY3d/GpddlP
         kQTbsMEqmFQ4GIYVakb+Gp8m8l2sgY61ONbQ+4wdu8qO9t7tKP1+IFhKWnhhUkoBoun9
         f9zTxj+w8IZAY/qNw2F0Qz+Tj1A4Gl0AhNhlLz49XuDaLty1W5z0BQ3kE5EsVibDzXc5
         MV7mB0CDJ2CMaORUKawk3DLW/KFMsSBzYNkz8AxT54k5vDrShG1wL/3Q7X7PT01juDCv
         moQKrkr7SSHf7NdMluiDfXehgF1rqu4hLvHJjuD63maT2OB9O92a3GgyMrIECJuZ0ryA
         Hg9w==
X-Gm-Message-State: AAQBX9cdG6MuKvezY9ZmIJi0x54eezBTDa7+7XQbtnDJRG6sfY7O1dNX
	cVGavXRSg2Uo2+dw+Pes79hh5abVPeNjf+HQznDoHq5G8QTl+KFw4euPykF1C7hHGT/wc1av36X
	GU0cqLewxu9C1TYRY9HenF0etDLjo
X-Received: by 2002:a05:6402:1a54:b0:4fb:b0ce:3f63 with SMTP id bf20-20020a0564021a5400b004fbb0ce3f63mr710914edb.28.1680672377486;
        Tue, 04 Apr 2023 22:26:17 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y4kkLcgRRHLKVuN6RJ2PzUEbVDfyUNoOdk8iVwhmT9xqBZK6dX4xDcvjTB4PSUAn17Asvc8w==
X-Received: by 2002:a05:6402:1a54:b0:4fb:b0ce:3f63 with SMTP id bf20-20020a0564021a5400b004fbb0ce3f63mr710904edb.28.1680672377163;
        Tue, 04 Apr 2023 22:26:17 -0700 (PDT)
Date: Wed, 5 Apr 2023 01:26:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com, sgarzare@redhat.com,
	pasic@linux.ibm.com, virtio-comment@lists.oasis-open.org,
	shahafs@nvidia.com
Message-ID: <20230405012352-mutt-send-email-mst@kernel.org>
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

It's the other way around: start with full name, then abbreviation.
Each virtqueue is identified by virtqueue
index (sometimes abbreviated to vq index). A virtqueue index range ...

are there more abbreviations we want to mention here? vq_idx?


>  Driver makes requests available to device by adding
>  an available buffer to the queue, i.e., adding a buffer
>  describing the request to a virtqueue, and optionally triggering
> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

