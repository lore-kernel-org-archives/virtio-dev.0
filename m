Return-Path: <virtio-dev-return-13634-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F323BEB8FA5
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Sep 2023 08:30:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6E40B2A8E2
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Sep 2023 08:30:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 667D19865F1
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Sep 2023 08:30:04 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5868C9865CD; Wed,  6 Sep 2023 08:30:04 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 43C2E9865D0
	for <virtio-dev@lists.oasis-open.org>; Wed,  6 Sep 2023 08:30:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 6DI9ZhQ9Na63JxEYEIO7hQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693988997; x=1694593797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LnTWWGgEruauMyVSp+TchgFbp9BnFj8bNyYIwBo32Xs=;
        b=b4JZdIe/Nt5uJdpM880oBul53SUZEPx+r5KLm1d27uuF8DHLlsz24bNaseHO3Oh9MI
         z8lXLXkt5FcBaiiXxU2Snd/K3niR6MquiY/Oo5KZ7kFaPM3NYtS6+YMUthjAXpk9jkuX
         0MV9L2ewgxbpkakZAS0oSBxNcWMySA5zmTBv96DiVFlK6GmHh8L5g5wiWHPlO551QcuX
         EjwHJzs80bWOMzeeuegOKs/I70daAdqZfxWy/J5AOOZd4IJaAV964g72t/vkf6sXhb2P
         B5pW1L3RhY9ZWAh+49G/MIuJSOeJNZkAXlT5E8JP5aSRqmanZNwJGCdjJVU5uVXubOr3
         kXPw==
X-Gm-Message-State: AOJu0YyYMR+VLp0yAuRqEmCqRsKNq2HSewOvwknYjt8RbV+5IRWPysmO
	M1a65fr9wojrINErpwZ/5nfrVnXBEFE801qicEzxvN9QVh4fEP+e3M+YpUkk97bl4yJy8sZTMfZ
	6ph1BcUVvLI+i0q+xiBWgd1hZtGw0
X-Received: by 2002:a17:906:8469:b0:99b:627b:e96d with SMTP id hx9-20020a170906846900b0099b627be96dmr1662612ejc.44.1693988996893;
        Wed, 06 Sep 2023 01:29:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfgPRb0v4ZSxEBgYQsxXnkldtT/id8dIu+Bx8PITi3bCUd30A9kb73JT+hNriOXyj89G7z5g==
X-Received: by 2002:a17:906:8469:b0:99b:627b:e96d with SMTP id hx9-20020a170906846900b0099b627be96dmr1662591ejc.44.1693988996549;
        Wed, 06 Sep 2023 01:29:56 -0700 (PDT)
Date: Wed, 6 Sep 2023 04:29:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: jasowang@redhat.com, eperezma@redhat.com, cohuck@redhat.com,
	stefanha@redhat.com, virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org
Message-ID: <20230906042851-mutt-send-email-mst@kernel.org>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20230906081637.32185-1-lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state

On Wed, Sep 06, 2023 at 04:16:32PM +0800, Zhu Lingshan wrote:
> This series introduces
> 1)a new SUSPEND bit in the device status
> Which is used to suspend the device, so that the device states
> and virtqueue states are stabilized.
> 
> 2)virtqueue state and its accessor, to get and set last_avail_idx
> and last_used_idx of virtqueues.
> 
> The main usecase of these new facilities is Live Migration.
> 
> Future work: dirty page tracking and in-flight descriptors.

oh that answers my question - it's not covered.
I don't think we can merge this without in-flight descriptor
support.



> This series addresses many comments from Jason, Stefan and Eugenio
> from RFC series.
> 
> Zhu Lingshan (5):
>   virtio: introduce vq state as basic facility
>   virtio: introduce SUSPEND bit in device status
>   virtqueue: constraints for virtqueue state
>   virtqueue: ignore resetting vqs when SUSPEND
>   virtio-pci: implement VIRTIO_F_QUEUE_STATE
> 
>  content.tex       | 118 ++++++++++++++++++++++++++++++++++++++++++++++
>  transport-pci.tex |  18 +++++++
>  2 files changed, 136 insertions(+)
> 
> -- 
> 2.35.3
> 
> 
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
> 
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
> 
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/
> 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

