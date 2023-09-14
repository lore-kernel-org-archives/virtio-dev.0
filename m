Return-Path: <virtio-dev-return-13765-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA41EDE9A8
	for <virtio-dev@archiver.kernel.org>; Thu, 14 Sep 2023 11:30:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8D1682AC63
	for <virtio-dev@archiver.kernel.org>; Thu, 14 Sep 2023 11:30:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3670298666B
	for <virtio-dev@archiver.kernel.org>; Thu, 14 Sep 2023 11:30:11 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 189D29866F2; Thu, 14 Sep 2023 11:30:11 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F414E9866BA
	for <virtio-dev@lists.oasis-open.org>; Thu, 14 Sep 2023 11:30:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 4F6bkfdeMkGCwm349pBzqg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694691007; x=1695295807;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GxpiCpSlW17v6RGdS9BH6kLJKP3t/hJwe1wjhApUyt8=;
        b=nVlnXd6K+/6iBHXvW/XAC9GIYFA/zJ/lwq+EWC6BENaUIbYG27ihWwQT+KVQ4zOFJI
         wP7v4Jam3Lq3QvmPRBxN29Tj6RkpD23FQrn3aGz54DY/1VPd1bpOU9Ody0nqrLSyaM4a
         /xW4QhG7JXvOpifu/CEDCrpuLDf9zd3ju53EJ11FXc6nEwLYuJEsEVK9jL74XjTgplJ+
         meop/NhvhGtSQIf1c5A8MyYwKqHk9aOIoEWggU0gGM2tZ15GZtdGQoue5g3vwIX4Q7+N
         syqsNjQkfEg/RfWRl62tREfLbQfyNxYkdfSTVgTlWpt0LsdSASRDuB7LbjtxIxf8x+Y2
         53Eg==
X-Gm-Message-State: AOJu0YwnjOxYtflo6aFFju4wTAJjLNb4VwNqfBJcDX9fQaWmJY3w/5/j
	kptao+2QiFa9Gehpe8otJ+yUTr45AsQITYhYrttgn7OzCEzdYd581D2OYEnn7wSxE7zr60oo3Ah
	vs5kTldQk2P1DXSd1c51EibST1LoQ
X-Received: by 2002:a17:907:2c6a:b0:9a1:edfd:73bb with SMTP id ib10-20020a1709072c6a00b009a1edfd73bbmr4394779ejc.47.1694691007403;
        Thu, 14 Sep 2023 04:30:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYTo14pDl3Zp85YnwnGh15JInz0+kIhRJ0VPwUWR+A5DKUXTl7ld59dqMeEh9vcOzCJUMdtQ==
X-Received: by 2002:a17:907:2c6a:b0:9a1:edfd:73bb with SMTP id ib10-20020a1709072c6a00b009a1edfd73bbmr4394763ejc.47.1694691007095;
        Thu, 14 Sep 2023 04:30:07 -0700 (PDT)
Date: Thu, 14 Sep 2023 07:30:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: jasowang@redhat.com, eperezma@redhat.com, cohuck@redhat.com,
	stefanha@redhat.com, virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org
Message-ID: <20230914072857-mutt-send-email-mst@kernel.org>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230906081637.32185-4-lingshan.zhu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20230906081637.32185-4-lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH 3/5] virtqueue: constraints for virtqueue state

On Wed, Sep 06, 2023 at 04:16:35PM +0800, Zhu Lingshan wrote:
> This commit specifies the constraints of the virtqueue state,
> and the actions should be taken by the device when SUSPEND
> and DRIVER_OK is set
> 
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> ---
>  content.tex | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/content.tex b/content.tex
> index 0fab537..9d727ce 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -594,6 +594,25 @@ \subsection{\field{Used State} Field}
>  When VIRTIO_RING_F_PACKED is not negotiated, the 16-bit value of \field{used_idx}
>  is always 0
>  
> +\drivernormative{\subsection}{Virtqueue State}{Basic Facilities of a Virtio Device / Virtqueue State}
> +
> +If VIRTIO_F_QUEUE_STATE has been negotiated but VIRTIO_RING_F_PACKED not been negotiated,
> +the driver SHOULD NOT access \field{Used State} of any virtqueues, it SHOULD use the
> +used index in the used ring.
> +
> +\devicenormative{\subsection}{Virtqueue State}{Basic Facilities of a Virtio Device / Virtqueue State}
> +
> +If VIRTIO_F_QUEUE_STATE has been negotiated, the device SHOULD only accept setting
> +Virtqueue State of any virtqueues when DRIVER_OK is not set in \field{device status},
> +or both of DRIVER_OK and SUSPEND are set in \field{device status}.
> +Otherwise the device MUST ignore any writes to Virtqueue State of any virtqueues.
> +
> +If VIRTIO_F_QUEUE_STATE have been negotiated, when SUSPEND is set,
> +the device MUST record the Virtqueue State of every enabled virtqueue
> +in \field{Available State} and \field{Used State} respectively,

record how?

> +and correspondingly restore the Virtqueue State of every enabled virtqueue
> +from \field{Available State} and \field{Used State} when DRIVER_OK is set.

when is that?


> +
>  \input{admin.tex}
>  
>  \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
> -- 
> 2.35.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

