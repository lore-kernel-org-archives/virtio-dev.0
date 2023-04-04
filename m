Return-Path: <virtio-dev-return-11957-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02787C6FD1D
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 07:22:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1E9B33E326
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 07:22:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EFE2B9863E6
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 07:22:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D905E986594; Tue,  4 Apr 2023 07:22:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AC62D98640B
	for <virtio-dev@lists.oasis-open.org>; Tue,  4 Apr 2023 07:22:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: -Kx6S3LMO2SOPF_l7V9BTg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680592948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4frHWMv//C9WVZGjyCNeVLd2Cc06WBCig7LGBGwtUOY=;
        b=yJhDFpkZrAeKVQQ2PFiyytbvY21eYsa+iJN0tbjkxyeSRjL5vNv59nJ/DvLEyK/hcv
         BthX81uMcjv46v8n1+bZsLO7r/FMqJSUwysAzQ7hkixfa/5F1PSGnSz/p06zoxPKXMWS
         JDao3p+KWZ5wJFMlJC3XPC99dRm7AsAwGcUJJhQfmas4PPX4VgXNLayxJDLcbSz3Q0u+
         iDP6maEgI21/qsOyLPtKKLOkokmmvonAg3Wd7yGdrcugsahF64OW6y6Vbja65XzURtzd
         X0jAlbOxFslo3xjDHq488GmC2czu2xDJHgOr0Tp6s/PTu5ff9Rii7fcABEauh1+Wk6Vy
         OgmQ==
X-Gm-Message-State: AAQBX9ck9cnSDSYeQsUsDWstFvYksetkB8S/RczPAABykIXVC2MtAxsx
	1N+RyCzEU+E6MH2vY2TkEV1HZ0yQo/cbw3sI/lgE1wRm1HlqwtosoF1anNH34FYFscjw4l6PZi0
	EjxGGUHB6aFCV36mzYSFamM2k4XcC
X-Received: by 2002:a17:906:488c:b0:939:7260:7f7e with SMTP id v12-20020a170906488c00b0093972607f7emr1301125ejq.49.1680592948690;
        Tue, 04 Apr 2023 00:22:28 -0700 (PDT)
X-Google-Smtp-Source: AKy350atyaso9Q02b3HQpflv6PyP7819Bo0qsapPbuP230qnNYgNTt7dONJOkrnSQFFDmxaZYGGzzg==
X-Received: by 2002:a17:906:488c:b0:939:7260:7f7e with SMTP id v12-20020a170906488c00b0093972607f7emr1301110ejq.49.1680592948443;
        Tue, 04 Apr 2023 00:22:28 -0700 (PDT)
Date: Tue, 4 Apr 2023 03:22:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, pasic@linux.ibm.com, cohuck@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
Message-ID: <20230404032218-mutt-send-email-mst@kernel.org>
References: <20230324013534.280820-1-parav@nvidia.com>
 <20230324013534.280820-2-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230324013534.280820-2-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH 1/3] transport-pci: Remove empty line at end of file

On Fri, Mar 24, 2023 at 04:35:32AM +0300, Parav Pandit wrote:
> Remove empty line at end of file.
> 
> Signed-off-by: Parav Pandit <parav@nvidia.com>

Applied this one.

> ---
>  transport-pci.tex | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/transport-pci.tex b/transport-pci.tex
> index 044c085..6e0cb45 100644
> --- a/transport-pci.tex
> +++ b/transport-pci.tex
> @@ -1148,4 +1148,3 @@ \subsubsection{Driver Handling Interrupts}\label{sec:Virtio Transport Options /
>          re-examine the configuration space to see what changed.
>      \end{itemize}
>  \end{itemize}
> -
> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

