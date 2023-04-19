Return-Path: <virtio-dev-return-12303-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B950AC6FD18
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 07:05:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C592529FDB
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 07:05:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 44E759866B8
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 07:05:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2BF3398667C; Wed, 19 Apr 2023 07:05:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 08EC998641E
	for <virtio-dev@lists.oasis-open.org>; Wed, 19 Apr 2023 07:05:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: sj9rKJs4Mu2gJYAuNEyX3w-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681887911; x=1684479911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DW5vl8wAqG6chq9AcTW6cOrJSOh0tRKwP9bQroOCzXo=;
        b=Zqsry3lYiGGot4/DSTx5eCv1kTMjDHyVX6aa6sWh6jT0IXAZmXdPBMo35UUqDrrtNa
         /wgJTzx0VGLXgm07hLxpFC8eHCRy+nmkvV3fvXzt/BWNPcRcOq/usgrHbT3QfAd3eKE/
         afZfnSpU+oM294r5JA78L3h/KtsEpx7JPWMxZ6iWCsk1yRwLI00p4lUvulPg2Ykou3lH
         Y1Vgo24fF1EFHrhHtzoecwVdeLkFhQkcCKm9838tFE/5a2PuReAeujhDz7VugqMDMpjj
         1v//YF1QUEM2NS3c7YHJDr00JocRf6pFbacQg/0lpe8cb9Dz2XCG2EAhbMP5hIqL2gNR
         ZkNQ==
X-Gm-Message-State: AAQBX9fMu0tfbuK9c4ZrA7K8TiN41bTxnjCad2uCwxJbV8iz9FEAXALI
	N8Uus5REXx95b1oNAw4mOkKBArVUCQWIhZuQQXO23w6OejhV63+IYfiwckY42Ltsr1GF3m2Xn6j
	gmtLOxUvIy3Zb0WhO6yVUqqh6y2Em
X-Received: by 2002:a7b:c394:0:b0:3f1:6fb3:ffcc with SMTP id s20-20020a7bc394000000b003f16fb3ffccmr9728400wmj.22.1681887911096;
        Wed, 19 Apr 2023 00:05:11 -0700 (PDT)
X-Google-Smtp-Source: AKy350YI+rA7A5YbRp6AsiE/X6rTwymmwdF4XoUuNSdduhhEC65ymRH4uEQg+bMGJLE6omFDEdLnQA==
X-Received: by 2002:a7b:c394:0:b0:3f1:6fb3:ffcc with SMTP id s20-20020a7bc394000000b003f16fb3ffccmr9728385wmj.22.1681887910840;
        Wed, 19 Apr 2023 00:05:10 -0700 (PDT)
Date: Wed, 19 Apr 2023 03:05:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, pasic@linux.ibm.com, cohuck@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230419030057-mutt-send-email-mst@kernel.org>
References: <20230411194220.752355-1-parav@nvidia.com>
 <20230411194220.752355-2-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230411194220.752355-2-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH 1/2] transport-pci: Improve config msix vector description

On Tue, Apr 11, 2023 at 10:42:19PM +0300, Parav Pandit wrote:
> config_msix_vector is the register that holds the MSI-X vector number
> for receiving configuration change related interrupts.
> 
> It is not "for MSI-X".
> 
> Hence, replace the confusing text with appropriate one.
> 
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> 
> ---
> changelog:
> v0->v1:
> - added 'here'
> - dropped 'receiving'
> ---
>  transport-pci.tex | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/transport-pci.tex b/transport-pci.tex
> index 42be072..cb9fadd 100644
> --- a/transport-pci.tex
> +++ b/transport-pci.tex
> @@ -343,7 +343,8 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>          Driver Feature Bits selected by \field{driver_feature_select}.
>  
>  \item[\field{config_msix_vector}]
> -        The driver sets the Configuration Vector for MSI-X.
> +        The driver writes an MSI-X vector number here for Configuration change
> +        interrupts.

Hmm I think it's "the vector", not an. And the order of words
is unusual. We also don't normally use "writes here". Would

	Used by the driver to set the MSI-X vector number for Configuration change interrupts.

be equally acceptable?


>  \item[\field{num_queues}]
>          The device specifies the maximum number of virtqueues supported here.
> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

