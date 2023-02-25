Return-Path: <virtio-dev-return-11278-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A4AC64EC7
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 17:45:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id ABAE729FFA
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 17:45:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A06AB986792
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 17:45:53 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9751F9866A9; Sat, 25 Feb 2023 17:45:53 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 85331986788
	for <virtio-dev@lists.oasis-open.org>; Sat, 25 Feb 2023 17:45:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: gG0cXmuXOxitu6cHk-A2QQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItABUMiGTikilcdSScqZqe7UCv+axyECMpY0K2oX63A=;
        b=1mHlQmUPFKUGGWDmS9NSnoOBJHzgecwG0QzC8diGhQHLnCIzVdkvBLH9jibYGnwEMj
         hKZ57mV+04kfuxTx/7v4pzifD2BoMd14dL7Vulwpr3y5D0Wrxsc4JieN1Qdv7lmgCLtH
         LBc/2Xf5J5Thbp3Gya0aOIYbGYC12emHIH7hVWYc0AdEvLllkcXBrat4+Q+ROlUTBaEc
         U/mmz7I/ZXYkoWI1CISihNQDHUsdmLlaeajORnbCZUIeCA215xVPRvE8IcCeBqf3HH3B
         0efWVBqv2B0dJMLgKjsLRxyqTSYmuU/SpBuJbab8w9d+N2+SKs05CnW1sIMLvkM2mmP2
         WBtQ==
X-Gm-Message-State: AO0yUKUF27qXqHB4m8UXZdsvR/lzKQDa2LFWhcOIr7z+iGuMELFrzqQO
	3Vy98n7irhVO8EuhCbWkjJ+PGCihRJ7rYdqg73wy9zgVYjmJzfqTSGjGTGqSv6/VMy2GzCn3J67
	cILWpqo51hhLVOkK3QT+IWDkxX+Xw
X-Received: by 2002:a05:600c:32af:b0:3ea:ea8a:a94a with SMTP id t47-20020a05600c32af00b003eaea8aa94amr5988941wmp.27.1677347146952;
        Sat, 25 Feb 2023 09:45:46 -0800 (PST)
X-Google-Smtp-Source: AK7set/rJj2tlEFE9equ7EBXGpD5Xrk6aiuqkWfUMNKaJgXOo31WKhSmOJ0lczmlcZ3hxWggmknHFA==
X-Received: by 2002:a05:600c:32af:b0:3ea:ea8a:a94a with SMTP id t47-20020a05600c32af00b003eaea8aa94amr5988928wmp.27.1677347146591;
        Sat, 25 Feb 2023 09:45:46 -0800 (PST)
Date: Sat, 25 Feb 2023 12:45:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
Message-ID: <20230225124225-mutt-send-email-mst@kernel.org>
References: <20230224231232.340814-1-parav@nvidia.com>
 <20230224231232.340814-2-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230224231232.340814-2-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH 1/2] transport-pci: Use capital alphabets
Message-ID: <20230225174543.tjs1Ba4p96pBmo86ynzXaeC1kj82y6SzIQLyPPIKxrs@z>

On Sat, Feb 25, 2023 at 01:12:31AM +0200, Parav Pandit wrote:
> Use capital alphabets to write PCI device id
> similar to vendor id and existing device id.
> 
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
>  transport-pci.tex | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/transport-pci.tex b/transport-pci.tex
> index 0642107..e271d51 100644
> --- a/transport-pci.tex
> +++ b/transport-pci.tex
> @@ -61,7 +61,7 @@ \subsection{PCI Device Discovery}\label{sec:Virtio Transport Options / Virtio Ov
>  the PCI Vendor and Device ID of the environment (for informational purposes by the driver).
>  
>  Non-transitional devices SHOULD have a PCI Device ID in the range
> -0x1040 to 0x107f.
> +0x1040 to 0x107F.
>  Non-transitional devices SHOULD have a PCI Revision ID of 1 or higher.
>  Non-transitional devices SHOULD have a PCI Subsystem Device ID of 0x40 or higher.
>  
> @@ -70,7 +70,7 @@ \subsection{PCI Device Discovery}\label{sec:Virtio Transport Options / Virtio Ov
>  
>  \drivernormative{\subsubsection}{PCI Device Discovery}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery}
>  Drivers MUST match devices with the PCI Vendor ID 0x1AF4 and
> -the PCI Device ID in the range 0x1040 to 0x107f,
> +the PCI Device ID in the range 0x1040 to 0x107F,
>  calculated by adding 0x1040 to the Virtio Device ID,
>  as indicated in section \ref{sec:Device Types}.
>  Drivers for device types listed in section \ref{sec:Virtio
> @@ -89,7 +89,7 @@ \subsubsection{Legacy Interfaces: A Note on PCI Device Discovery}\label{sec:Virt
>  Transitional devices MUST have the PCI Subsystem Device ID
>  matching the Virtio Device ID, as indicated in section \ref{sec:Device Types}.
>  Transitional devices MUST have the Transitional PCI Device ID in
> -the range 0x1000 to 0x103f.
> +the range 0x1000 to 0x103F.

I actually think upper case A-F is inconsistent with lower case 0x.  So
I would say if we are going to worry about it, let's make them all lower
case.



>  This is to match legacy drivers.
>  
> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

