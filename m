Return-Path: <virtio-dev-return-12004-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF0BC76188
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 05:33:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6E062419AE
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 05:33:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4AA359865C9
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 05:33:05 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3D2B79865A8; Wed,  5 Apr 2023 05:33:05 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 23A649865B0
	for <virtio-dev@lists.oasis-open.org>; Wed,  5 Apr 2023 05:33:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 51Wlf9uvPv2qY8EXIou4cQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680672779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nj4Ku3TsLfPCllGXqmHU3p5Yuyii3BYZsBAbdwtk3Ys=;
        b=1dwf6Q2dLSioiGBTTkyQfYDpMZ56wjdHap6QQPnfaAtSqTTIjj1hbcglzBhTLkI7rB
         ErykUfQSE/XbPzB9i9quxivN911rwG504XKN3VH31cliRCkWuLh9WSDFOUKMm5GCa9O1
         qxKMrFEqnOO0YcvLKn2uTgcwgJOb/wBaQr0Hww8lr5bFIrfdR8PnCfb3f5zqzeyQof7W
         2LnhOOjsWmGYBrJWNRQzy8EShCzz/e2NNCT3MSSlDlwzdAI8ErLSjrvpiF6sUXnfvBPF
         +6O1860VjAf0tiLXZT9ZzHMP1t2lMd+qQLN8wjr73OcDBHRd5aoamT/KhZXZ/EarOkbm
         Uciw==
X-Gm-Message-State: AAQBX9fERzwWAfcdjuXb5+uaeMNicg4Y9PXCdOIjElEc3UC50luT59hd
	eaMKkLfm41BTfemIgOc/nwWScS0VHde8YxHKHSavMWC4YHYH5D9mh9ELDl1GrGcCgBcuc2/IesH
	FBTuTuCJwls+/l+mg+PTu/7OZ+lP5
X-Received: by 2002:a17:906:c407:b0:931:a321:7640 with SMTP id u7-20020a170906c40700b00931a3217640mr1711474ejz.74.1680672779701;
        Tue, 04 Apr 2023 22:32:59 -0700 (PDT)
X-Google-Smtp-Source: AKy350aWSjTEC0Db1ZddvVNCkoYYS8hBHABIe6spBdKZECe3guuS+NHlz8T4Wgy3jxJr8uGPjvzz5A==
X-Received: by 2002:a17:906:c407:b0:931:a321:7640 with SMTP id u7-20020a170906c40700b00931a3217640mr1711465ejz.74.1680672779391;
        Tue, 04 Apr 2023 22:32:59 -0700 (PDT)
Date: Wed, 5 Apr 2023 01:32:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com, sgarzare@redhat.com,
	pasic@linux.ibm.com, virtio-comment@lists.oasis-open.org,
	shahafs@nvidia.com
Message-ID: <20230405013038-mutt-send-email-mst@kernel.org>
References: <20230405010657.612529-1-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230405010657.612529-1-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v12 00/10] Rename queue number to queue index

On Wed, Apr 05, 2023 at 04:06:47AM +0300, Parav Pandit wrote:
> 1. Currently, virtqueue is identified between driver and device
> interchangeably using either number or index terminology.
> 
> 2. Between PCI and MMIO transport the queue size (depth) is
> defined as queue_size and QueueNum respectively.
> 
> To avoid confusion and to have consistency, unify them to use
> index.
> 
> 3. Filed name vqn in the driver notification structure is
> ambiguous as it is supposed to hold either vq index or device
> supplied vq identifier.
> 
> 4. Device is really supplying queue identifier in the 
> queue_notify_data register, and this often get confused with
> very similar looking feature bit NOTIFICATION_DATA.
> 
> Solution:
> a. Use virtqueue index description, and rename MMIO register as QueueSize.
> b. Replace virtqueue number with virtqueue index
> c. RSS area of virtio net has inherited some logic, describe it
> using abstract rss_rq_id.
> d. rename queue_notifify_data to queue_notify_id
> e. rename vqn to vq_notify_id to reflect it can hold either vq
> index of device supplied some id.
> 
> Patch summary:
> patch-1 introduce vq number as generic term
> patch-2 renames index to number for pci transport
> patch-3 rename queue_notify_data to queue_notify_id
> patch-4 remove first vq index reference
> patch-5 renames mmio register from Num to Size
> patch-6 renames index to number for mmio transport
> patch-7 renames num field to size for ccw transport
> patch-8 renames vq by its index for ccw transport
> patch-9 for virtio-net removes duplicate example from requirements
> patch-10 for virtio-net updates rss description to use vq index
> 
> This series only improves the documentation, it does not change any
> transport or device functionality.
> 
> Please review.
> This series fixes the issue [1].
> 
> [1] https://github.com/oasis-tcs/virtio-spec/issues/163


I like where this is going. I will change AQ patches to be like this,
but it's holidays here in israel so not reposting immediately,
pls review assuming I will address that change.
For same reason pls don't expect quick review.
The patchset itself is just a cleanup so even though it's up
to crazy revision numbers already it's ok if it takes a bit more
time to merge.

> ---
> changelog:
> v11->v12:
> - replace number to index
> - avoid confusion around vqn field and rename to vq_notify_id
> - rename queue_notify_data to avoid confusing with NOTIFY_DATA
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
> 
> Parav Pandit (10):
>   content: Add vq index text
>   content.tex Replace virtqueue number with index
>   content: Rename confusing queue_notify_data and vqn names
>   transport-pci: Avoid first vq index reference
>   transport-mmio: Rename QueueNum register
>   transport-mmio: Avoid referring to zero based index
>   transport-ccw: Rename queue depth/size to other transports
>   transport-ccw: Refer to the vq by its index
>   virtio-net: Avoid duplicate receive queue example
>   virtio-net: Describe RSS using rss rq id
> 
>  content.tex                      | 27 ++++++++++++----
>  device-types/net/description.tex | 29 ++++++++++++-----
>  notifications-be.c               |  2 +-
>  notifications-le.c               |  2 +-
>  transport-ccw.tex                | 15 +++++----
>  transport-mmio.tex               | 55 +++++++++++++++++++-------------
>  transport-pci.tex                | 26 ++++++++-------
>  7 files changed, 99 insertions(+), 57 deletions(-)
> 
> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

