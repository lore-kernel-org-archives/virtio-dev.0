Return-Path: <virtio-dev-return-13767-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43CC7EDE9A8
	for <virtio-dev@archiver.kernel.org>; Thu, 14 Sep 2023 11:37:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id ABB0345B3D
	for <virtio-dev@archiver.kernel.org>; Thu, 14 Sep 2023 11:37:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9A5B2986651
	for <virtio-dev@archiver.kernel.org>; Thu, 14 Sep 2023 11:37:12 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8ED86986641; Thu, 14 Sep 2023 11:37:12 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 80361986639
	for <virtio-dev@lists.oasis-open.org>; Thu, 14 Sep 2023 11:37:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: zUK8b1lfOayS6KDMuAJcHQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694691427; x=1695296227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fpcobUAQmNRu7g2td/pu6JTMcmiCHlmgba8nlGvTHI=;
        b=maMigXaMxYFSUK0gi6VET+DYB9Eji/ouFhbthVHMKPAGPn5qNoUh+SlvkWC/09A/xJ
         E9wbvwrEkAAkihlRmCXnG15tKs6oCG20Iy5XA0KmPzqEoJt6M1XF6KyIIWymMRw5kawj
         gQczdAfrplLHRlgoJ3/qXT64EEolGYLI4afWhj9GQQotb93lO9MCzj/IYtfEFfW9Bj7j
         D407KN96yFDNjGCaKn1cSfpISfeEfPXa1sr4rvXtLtVrp51p8t4qkU13N2hUazGKfWwb
         6Yb2wx78LLr7iGCp1LO0o8zKhu9e65HYqf+obyU9p6136PUF/BI9lnC3UHQrDYfO0l0+
         9JsQ==
X-Gm-Message-State: AOJu0YwUQOVaQq0yDDiUr45BxV/RnRxnEzI8ysYFiBQOyWnrbxz3M9Hr
	7JaiBrIJGB0nubj/lv5lcC7xq9ptYcJl+uNGGIpmkSaI1xo3DwSAb5Ls2+62a5szrcZ+gULQdww
	NNucZ+G7PUwgbACGSzHsVt8lOXh/0
X-Received: by 2002:a17:906:81c7:b0:9ad:b80c:c19d with SMTP id e7-20020a17090681c700b009adb80cc19dmr1464805ejx.56.1694691427512;
        Thu, 14 Sep 2023 04:37:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEK0oq6O1OoliLiyMC6De+KMMdv2NaSQMRcGmKAxCn6wgwKUff91rKqRG4RmyQ7168QeELuw==
X-Received: by 2002:a17:906:81c7:b0:9ad:b80c:c19d with SMTP id e7-20020a17090681c700b009adb80cc19dmr1464792ejx.56.1694691427180;
        Thu, 14 Sep 2023 04:37:07 -0700 (PDT)
Date: Thu, 14 Sep 2023 07:37:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: jasowang@redhat.com, eperezma@redhat.com, cohuck@redhat.com,
	stefanha@redhat.com, virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org
Message-ID: <20230914073454-mutt-send-email-mst@kernel.org>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20230906081637.32185-1-lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq state

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
> 
> This series addresses many comments from Jason, Stefan and Eugenio
> from RFC series.


after going over this in detail, it is like I worried: this
tries to do too much through a single register and
the ownership is muddied significantly.

I feel a separate capability for suspend/resume that would
be independent of device status would be preferable.

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


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

