Return-Path: <virtio-dev-return-11956-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE26C6FD1D
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 07:21:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B64FC2B03A
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 07:21:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 95D1298640C
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 07:21:04 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7274B9863E4; Tue,  4 Apr 2023 07:21:04 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5F3069863E6
	for <virtio-dev@lists.oasis-open.org>; Tue,  4 Apr 2023 07:21:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 3UahRJZYNXG02W2nIqwxoA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680592861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zf46jMez8uLXGzDInvids57wIpOiPvE7GGH8QQCjI4I=;
        b=38OFJTyMN9Z9cvRIfNwwrTKB0ItGphtooBPYD6D98vWhsO6WpA6XeNzjw+mdw3Sual
         BORQN4Dv4TNWfj/9radjc1TGr/s4w5FOozoaGRNvfPaRNRiattJLsYSYwS0HqWhgNqh4
         GOWEfZS3BlWpMwbPXTCSDgmcsmumo2tTMeVkWN56un7NqsfnAbcL0fiHf+9KFi29YV6Q
         cr6+90BKj0i2BZs2ah2Ai6XYwvWtvjKtueB+/JyCDxL/WZ7V+dLu6o7UU4OFvmDFPFka
         8KccXSAXOnKPchu3apJEFK8n/YEGab653JGnC9g28VmbLam9v+BpbSUF/VvscDirjB9L
         78Lg==
X-Gm-Message-State: AAQBX9cF/HqASPII3Oj3j2sYjReGbASqZBqqD4DTaE7WxOgobF4C5hAx
	uB4iR9UMTSNBEYiDqPAz8936YPB+3oj2qgGJ9yxJyw7x6jmBQOPfPQwyQRC4rPx4lY0RDROAyNf
	2z5HmKgXs3WddJw0AxBStnmovlaNX
X-Received: by 2002:a17:906:95c2:b0:8b0:f277:5cde with SMTP id n2-20020a17090695c200b008b0f2775cdemr1065729ejy.32.1680592861280;
        Tue, 04 Apr 2023 00:21:01 -0700 (PDT)
X-Google-Smtp-Source: AKy350YuAbADbrj4d8R6WM/8UZ9vjXbMPjLUO8FltLtEMgrfV4h2819irIQgC2vy34hqg8j4U+kXYA==
X-Received: by 2002:a17:906:95c2:b0:8b0:f277:5cde with SMTP id n2-20020a17090695c200b008b0f2775cdemr1065720ejy.32.1680592860961;
        Tue, 04 Apr 2023 00:21:00 -0700 (PDT)
Date: Tue, 4 Apr 2023 03:20:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, pasic@linux.ibm.com, cohuck@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230404031723-mutt-send-email-mst@kernel.org>
References: <20230324013534.280820-1-parav@nvidia.com>
 <20230324013534.280820-4-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230324013534.280820-4-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH 3/3] transport-pci: Improve queue msix vector register
 desc

On Fri, Mar 24, 2023 at 04:35:34AM +0300, Parav Pandit wrote:
> queue_msix_vector register is for receiving interrupts from the device
> for the virtqueue.
> 
> "for MSI-X" is confusing term.
> 
> Also it is the register that driver "writes" to, similar to
> many other registers such as queue_desc, queue_driver etc.
> 
> Hence, replace the verb from use to write.
> 
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>  transport-pci.tex | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/transport-pci.tex b/transport-pci.tex
> index 1bc89b4..9d492d5 100644
> --- a/transport-pci.tex
> +++ b/transport-pci.tex
> @@ -367,7 +367,8 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>          A 0 means the queue is unavailable.
>  
>  \item[\field{queue_msix_vector}]
> -        The driver uses this to specify the queue vector for MSI-X.
> +        The driver writes an MSI-X vector number for receiving
> +        virtqueue interrupts.

Ok but "receiving" is confusing here. And the verb writes seems
to ask for direction, look at queue_desc as an example.

Following that example:

	The driver writes the MSI-X vector number used for virtqueue interrupts here.

would you agree?



>  \item[\field{queue_enable}]
>          The driver uses this to selectively prevent the device from executing requests from this virtqueue.
> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

