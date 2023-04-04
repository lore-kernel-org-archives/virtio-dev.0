Return-Path: <virtio-dev-return-11953-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDBCEC6FD1D
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 07:05:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0DB5D2ACB0
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 07:05:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 877B3986647
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 07:05:21 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 114349863ED; Tue,  4 Apr 2023 07:05:21 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CE36E9863E5
	for <virtio-dev@lists.oasis-open.org>; Tue,  4 Apr 2023 07:04:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: kNl2slJaMUKUr3M_KFq7yg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680591841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwHFJghfOM2kGQNN8h4CrMcCtPdD/NJ+5qTp60nF0WE=;
        b=W9AtsJAJjhW/Z9bk/1MjmDc8CuNT3n7PIK0r3pnOKkXKcEmnR+ZkrF3XigQHmNdFqX
         cosgUOdXnnu0zlDEpy7jtB2yp039ZNfdq8aYeo6kSG0J9ve8M7Iop6HOTjBqqUxMmwEF
         XcyPLxQ4zWfck8ASA9wDaLokdUcCmB8ztRbWfQV29YGlEfMHX5iNoAQUoZzLbwSiYrHg
         PRtiLIuuRiG80tYZCb/BjNx+5iWPog+AKPrGvCSiI3Tf8qfzC6drQx8kdZ6EIm4Ox7+b
         ZEEbZlmsGCujwtkw6mMD66cRZEgu/XT5EYRdtzeWKVdQ7/sz2kvA4hItz265lMn3/Xo3
         8q6A==
X-Gm-Message-State: AAQBX9eVnVsbc2e/eEYmGRzz3CD9QjJTF3ZCzttD3t6ffNvi10PhjGwN
	dJyQsU5JUQKl4ywfChJ2by6eeZ0xdE8WcGJBy2tRTCaE7rHt9NndD5R8/ov0MHVZuVzhq0uQmh/
	xPEusIh9S5rAMyxzHsNhtXE4oJZRH
X-Received: by 2002:a17:907:628a:b0:931:c2f0:9437 with SMTP id nd10-20020a170907628a00b00931c2f09437mr1393641ejc.8.1680591841777;
        Tue, 04 Apr 2023 00:04:01 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZiVKcnoHmulOULjj63fu4e2xi8Gci/b8a2YGGQcGSb04//CNgsHLa2RQ0qxeS3Q1pCDCW8nQ==
X-Received: by 2002:a17:907:628a:b0:931:c2f0:9437 with SMTP id nd10-20020a170907628a00b00931c2f09437mr1393624ejc.8.1680591841492;
        Tue, 04 Apr 2023 00:04:01 -0700 (PDT)
Date: Tue, 4 Apr 2023 03:03:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, pasic@linux.ibm.com, cohuck@redhat.com,
	sgarzare@redhat.com, virtio-comment@lists.oasis-open.org,
	shahafs@nvidia.com
Message-ID: <20230404030244-mutt-send-email-mst@kernel.org>
References: <20230403225052.585498-1-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230403225052.585498-1-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v11 0/8] Rename queue index to queue number

On Tue, Apr 04, 2023 at 01:50:44AM +0300, Parav Pandit wrote:
> 1. Currently, virtqueue is identified between driver and device
> interchangeably using either number or index terminology.
> 
> 2. Between PCI and MMIO transport the queue size (depth) is
> defined as queue_size and QueueNum respectively.
> 
> To avoid confusion and to have consistency, unify them to use Number.
> 
> Solution:
> a. Use virtqueue number description, and rename MMIO register as QueueSize.
> b. Replace virtqueue index with virtqueue number
> c. RSS area of virtio net has inherited some logic, describe it
> using abstract rss_rq_id.
> 
> Patch summary:
> patch-1 introduce vq number as generic term
> patch-2 renames index to number for pci transport
> patch-3 renames mmio register from Num to Size
> patch-4 renames index to number for mmio transport
> patch-5 renames num field to size for ccw transport
> patch-6 renames index field to vqn for ccw transport
> patch-7 for virtio-net removes duplicate example from requirements
> patch-8 for virtio-net updates rss description to use vq number
> 
> This series only improves the documentation, it does not change any
> transport or device functionality.
> 
> Please review.
> This series fixes the issue [1].
> 
> [1] https://github.com/oasis-tcs/virtio-spec/issues/163

Could you knock out a version based on Halil's suggestion of using index
throughout?

> ---
> changelog:
> v10->v11:
> - added Reviewed-by for all the reviewed patches
> - updated commit log of patch-8 to drop rq_handle reference
> - skipped comment to further use rss_rq_id, as rss_rq_id usage
>   and structure are self describing
> v9->v10:
> - added virtqueue number part in content in braces
> - replaced queue_select to vqn in ccw
> - avoided aggrasive alignment of 65 chars
> - updated commit log to drop reference to already merged patches
> - added review-by tag for already reviewed patches
> v8->v9:
> - addressed comments from David
> - few corrections with article
> - renaming 'virtqueue number' to 'vq number'
> - improving text and wording for rss_rq_id, avail notification
> - commit log of specific change in individual patches
> v7->v8:
> - remove note about first virtqueue number
> - skipped Max's comment to put word 'structure' in same line as its
>   crosses 65 chars limit per line
> - reworded queue_notification data set line, as '=' and vq number
>   wording was odd
> v6->v7:
> - remove text around first vq as it is already covered in the basic
>   virtqueues facility section
> v5->v6:
> - moved the vq number description from middle of vq operation
>   to beginning of vq introduction
> v4->v5:
> - fixed accidental removal of "unclassifed packets".
> - simplfied text around indirection_table mask
> - removed rss_rq_id references as indirection table and
>   unclassified_queue data type is self explanatory
> v3->v4:
> - moved note to comment for ccw
> - renamed rq_handle to rss_rq_id
> - moved rss_rq_id next to rss_config structure
> - define rss_config structure using rss_rq_id
> v2->v3:
> - addressed comments from Michael
> - added previous definitions for ccw fields
> - moved rq_handle definition before using it
> - added first patch to describe vq number
> - updated pci for available buffer notification section
> v1->v2:
> - added patches for virtio net for rss area
> - added patches for covering ccw transport
> - added missing entries to refer in mmio transport
> 
> Parav Pandit (8):
>   content: Add vq number text
>   transport-pci: Refer to the vq by its number
>   transport-mmio: Rename QueueNum register
>   transport-mmio: Refer to the vq by its number
>   transport-ccw: Rename queue depth/size to other transports
>   transport-ccw: Refer to the vq by its number
>   virtio-net: Avoid duplicate receive queue example
>   virtio-net: Describe RSS using rss rq id
> 
>  content.tex                      |  4 ++
>  device-types/net/description.tex | 29 ++++++++++----
>  transport-ccw.tex                | 26 +++++++------
>  transport-mmio.tex               | 65 ++++++++++++++++++--------------
>  transport-pci.tex                | 13 ++++---
>  5 files changed, 84 insertions(+), 53 deletions(-)
> 
> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

