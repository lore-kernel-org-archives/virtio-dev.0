Return-Path: <virtio-dev-return-12334-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DC1C77B7C
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Apr 2023 20:46:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 934A12AC50
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Apr 2023 20:46:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 87A18986644
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Apr 2023 20:46:04 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 798369863EA; Thu, 20 Apr 2023 20:46:04 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 68FCD986635
	for <virtio-dev@lists.oasis-open.org>; Thu, 20 Apr 2023 20:46:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: bPO_1Q_kMDmTYRAMbSJcMg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682023559; x=1684615559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0RllF3nBrpGU+mDq3KTdCYRnQVNTvL+w1zhEjaetMvk=;
        b=alvlkiGZD7YaNZsdiEHBxycuseEaaOH5ZSSFjsCJSYr/e3kGLN1zt0y31yPtdGbLpv
         G7d+Y8rCYHSbWBeAqEqKhO44+ZYizNP7qRHWebtD2tSNh+2bjq+65aC8ZEFthW+SDQxx
         R/vbZylkvNOxHuEGZTf8UJu65vvglNxKO9hlXIMjZlfkgaie0zn8lztrC1DDte5pgI6r
         JmLEiEnLFKeHvMcYu36flm4VpKOmQ0IwNe6pCPF6zrFoJIuacs5wJEa3scbxQtfAxbxM
         eN6UCyAUYWCjAdVA+OTtmUzo/qsxv3LNr7U8RDwuaDDtbg5DmqofzlrpGpYY/wiUCVVf
         xsHg==
X-Gm-Message-State: AAQBX9ddcW9ap6tHnX8gY09mgfYi3MJMhFRclv5IScSQfO479mFWXNcj
	O0IWB6x9Oa1avFLHtUH6GLg9YMBDr/CAs3mKmzoPJ8htqO5OaMOxEyI3/KIyXnWBeRA9dqISDnU
	/uVuoe6j8p2/kM8wurW5oLzrEClLr
X-Received: by 2002:a05:6000:1809:b0:2fb:c131:ad12 with SMTP id m9-20020a056000180900b002fbc131ad12mr2097156wrh.63.1682023558920;
        Thu, 20 Apr 2023 13:45:58 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zjj9lS3jEe5iFO+X3Eyv33l+3WIOvWK6a/ydu+X4r265smJ+xXhbn41ymjDwq/j2RdnjRFbA==
X-Received: by 2002:a05:6000:1809:b0:2fb:c131:ad12 with SMTP id m9-20020a056000180900b002fbc131ad12mr2097145wrh.63.1682023558563;
        Thu, 20 Apr 2023 13:45:58 -0700 (PDT)
Date: Thu, 20 Apr 2023 16:45:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
Message-ID: <20230420164535-mutt-send-email-mst@kernel.org>
References: <20230420195554.69907-1-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230420195554.69907-1-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v1] device-types/multiple: replace queues with enqueues

On Thu, Apr 20, 2023 at 10:55:54PM +0300, Parav Pandit wrote:
> Queue is a verb and noun both. Replacing it with enqueue avoids
> ambiguity around plural queues noun vs verb; similar to virtio fs device
> description.
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>

ACK stands. Cornelia, editorial change?


> ---
> changelog:
> v0->v1:
> - replace 'on' to 'to'
> ---
>  device-types/blk/description.tex   | 2 +-
>  device-types/gpio/description.tex  | 4 ++--
>  device-types/i2c/description.tex   | 2 +-
>  device-types/scsi/description.tex  | 2 +-
>  device-types/vsock/description.tex | 2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/device-types/blk/description.tex b/device-types/blk/description.tex
> index 517b012..f04c932 100644
> --- a/device-types/blk/description.tex
> +++ b/device-types/blk/description.tex
> @@ -427,7 +427,7 @@ \subsubsection{Legacy Interface: Device Initialization}\label{sec:Device Types /
>  
>  \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Operation}
>  
> -The driver queues requests to the virtqueues, and they are used by
> +The driver enqueues requests to the virtqueues, and they are used by
>  the device (not necessarily in order). Each request except
>  VIRTIO_BLK_T_ZONE_APPEND is of form:
>  
> diff --git a/device-types/gpio/description.tex b/device-types/gpio/description.tex
> index 8e5c7f0..d51fbe1 100644
> --- a/device-types/gpio/description.tex
> +++ b/device-types/gpio/description.tex
> @@ -358,7 +358,7 @@ \subsubsection{requestq Operation: Set IRQ Type}\label{sec:Device Types / GPIO D
>  \subsubsection{requestq Operation: Message Flow}\label{sec:Device Types / GPIO Device / requestq Operation / Message Flow}
>  
>  \begin{itemize}
> -\item The driver queues \field{struct virtio_gpio_request} and
> +\item The driver enqueues \field{struct virtio_gpio_request} and
>      \field{virtio_gpio_response} buffers to the \field{requestq} virtqueue,
>      after filling all fields of the \field{struct virtio_gpio_request} buffer as
>      defined by the specific message type.
> @@ -458,7 +458,7 @@ \subsection{Device Operation: eventq}\label{sec:Device Types / GPIO Device / eve
>  
>  The \field{eventq} virtqueue is used by the driver to unmask the interrupts and
>  used by the device to notify the driver of newly sensed interrupts. In order to
> -unmask interrupt on a GPIO line, the driver queues a pair of buffers,
> +unmask interrupt on a GPIO line, the driver enqueues a pair of buffers,
>  \field{struct virtio_gpio_irq_request} (filled by driver) and \field{struct
>  virtio_gpio_irq_response} (to be filled by device later), to the \field{eventq}
>  virtqueue. A separate pair of buffers must be queued for each GPIO line, the
> diff --git a/device-types/i2c/description.tex b/device-types/i2c/description.tex
> index 5d407cb..861529a 100644
> --- a/device-types/i2c/description.tex
> +++ b/device-types/i2c/description.tex
> @@ -47,7 +47,7 @@ \subsection{Device Operation}\label{sec:Device Types / I2C Adapter Device / Devi
>  
>  \subsubsection{Device Operation: Request Queue}\label{sec:Device Types / I2C Adapter Device / Device Operation: Request Queue}
>  
> -The driver queues requests to the virtqueue, and they are used by the
> +The driver enqueues requests to the virtqueue, and they are used by the
>  device. The request is the representation of segments of an I2C
>  transaction. Each request is of the form:
>  
> diff --git a/device-types/scsi/description.tex b/device-types/scsi/description.tex
> index 904c4a7..478b558 100644
> --- a/device-types/scsi/description.tex
> +++ b/device-types/scsi/description.tex
> @@ -158,7 +158,7 @@ \subsection{Device Operation}\label{sec:Device Types / SCSI Host Device / Device
>  
>  \subsubsection{Device Operation: Request Queues}\label{sec:Device Types / SCSI Host Device / Device Operation / Device Operation: Request Queues}
>  
> -The driver queues requests to an arbitrary request queue, and
> +The driver enqueues requests to an arbitrary request queue, and
>  they are used by the device on that same queue. It is the
>  responsibility of the driver to ensure strict request ordering
>  for commands placed on different queues, because they will be
> diff --git a/device-types/vsock/description.tex b/device-types/vsock/description.tex
> index 105bb30..7d91d15 100644
> --- a/device-types/vsock/description.tex
> +++ b/device-types/vsock/description.tex
> @@ -218,7 +218,7 @@ \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device /
>  \field{buf_alloc} and \field{fwd_cnt} fields.
>  
>  \subsubsection{Receive and Transmit}\label{sec:Device Types / Socket Device / Device Operation / Receive and Transmit}
> -The driver queues outgoing packets on the tx virtqueue and incoming packet
> +The driver enqueues outgoing packets to the tx virtqueue and incoming packet
>  receive buffers on the rx virtqueue. Packets are of the following form:
>  
>  \begin{lstlisting}
> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

