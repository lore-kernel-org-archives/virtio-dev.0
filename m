Return-Path: <virtio-dev-return-11293-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE91C7EE2D
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 23:18:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9D4CB77E2
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 23:18:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 833FC986793
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 23:18:00 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 735E098413F; Sat, 25 Feb 2023 23:18:00 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 45F739867BD
	for <virtio-dev@lists.oasis-open.org>; Sat, 25 Feb 2023 23:18:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: h54qU_tSPCGbaRJOUI-jEw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6vdjdRb/zOg9OsihsWALVEtxwufNVRfIJJEAEzVLv0=;
        b=dTb3sYdBso4otFjoT7EGti+DYFAESbNuCkXbezfVA/+2D0N2s+ZRuT1GcM2xadDP/R
         +AqqlRvPGPFNJyA4cusqwoP6iiVT+hwHvIjbOOl7eWqM7SBDKUN397Q6I2fd2gqNI95M
         zIjNQwzSMvg7Qth2k7b+0SgFZPikNJTGOG/h3D/ncvTgixXdcSU8+isdHQButZpksMVY
         y6M5nVJRibYPjnz27z9SAie8ppklSRjngY3v9nOr78XeVCz8LW4S03vkCP6jk5vZr7V8
         5WFCNAElb/ncPArvgpnC+YIfEipBGREdmw7aB25aWX+2UYbfo6XyP2CxkeVr7fxtIRk0
         ZLMw==
X-Gm-Message-State: AO0yUKVB+jPzoCk9wSGDvYA+oKWg57SBomuQPPFbz+8gtj9HhKhTCYXR
	gapnbz44aBeuTt7qbKLS9/EJYcArEcBKLenXYDeH/yuBzoGoQIWRN38L1W1ZvkgjhyCwEGU1YMr
	SuN+uqC8Eedx5mANhb8X5RSrQ4r/M
X-Received: by 2002:a05:600c:1810:b0:3eb:3947:41ea with SMTP id n16-20020a05600c181000b003eb394741eamr1235471wmp.37.1677367076352;
        Sat, 25 Feb 2023 15:17:56 -0800 (PST)
X-Google-Smtp-Source: AK7set8ueaiQpB1dHfFwj0lA4hvUuqUL5OLmKzUEh6lG9XVUL4+2k5TNrW+0MDWrpiw8od1y8g+Q3A==
X-Received: by 2002:a05:600c:1810:b0:3eb:3947:41ea with SMTP id n16-20020a05600c181000b003eb394741eamr1235466wmp.37.1677367076026;
        Sat, 25 Feb 2023 15:17:56 -0800 (PST)
Date: Sat, 25 Feb 2023 18:17:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
Message-ID: <20230225181618-mutt-send-email-mst@kernel.org>
References: <20230225223001.430522-1-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230225223001.430522-1-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH 0/3] Cleanup for PCI transitional common cfg
Message-ID: <20230225231752.Xt2muZEJhCqXN78HbUJfJT_pNR5g9HZTMzmqkUXLlpQ@z>

On Sun, Feb 26, 2023 at 12:29:58AM +0200, Parav Pandit wrote:
> Legacy interface PCI Device layout description has following issues.
> 
> 1. repeated 'structure' word
> 2. virtio header was defined the 0.9.5 spec. It is referred with
>    different keywards in this section with multiple different words
>    as (a) virtio header, (b) general headers, (c) legacy configuration
>    structure, (d) virtio common configuration structure and
>    (e) other fields.
> 3. Driver and device requirements listing is intermixed.
> 4. spelling error of structure
> 5. Legacy interface common configuration requirements are not adjacent
>    to 1.x comm
> 
> Hence, this short series overcomes above issues.

Looking at the patchset so far I'm inclined to say - leave
legacy well alone. This is not an improvement.

Gratituis changes for trivial benefit have a cost - people have to
re-read spec this to see what changed.  Making things significantly
easier for new readers would make it worth it.  As it stands - this is
not worth it.


> Patch summary:
> patch-1 overcomes above 1 to 4 issues
> patch-2 splits feature bit operations from config layout
> patch-3 relocate requirements adjacent to 1.x requirements
> 
> This series is in top of [1], [2] and [3].
> 
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/164
> Please review.
> 
> [1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00578.html
> [2] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00585.html
> [3] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00597.html
> 
> Parav Pandit (3):
>   transport-pci: Improve PCI legacy device layout description
>   transport-pci: Split notes of PCI Device Layout
>   transport-pci: Relocate common config legacy interface
> 
>  conformance.tex   |   3 +-
>  transport-pci.tex | 182 +++++++++++++++++++++++++---------------------
>  2 files changed, 102 insertions(+), 83 deletions(-)
> 
> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

