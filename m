Return-Path: <virtio-dev-return-11734-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05596C6FD1C
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 23:05:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 108602A8F7
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 23:05:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D99C3986579
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 23:05:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6782B986474; Wed, 22 Mar 2023 23:05:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 72C31986455
	for <virtio-dev@lists.oasis-open.org>; Wed, 22 Mar 2023 23:04:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: avptBUXgN3WQi0JDmvkbsA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679526272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISj799JirOayjigJ3MM537c0xFFEZu5R8XPxHSW/SC4=;
        b=13dvg1BOKelgR/+Rok7Mzc84+KgzAv3BoRNtdK/0teu2ikzQT7s2Rv9LMg6hWYmSR/
         Lm8hLNFHbvAJse7qNm5xDW7msn8yRRMBqRaJwDVQZG4NEjb47cMYZ4o7ngfROitva/XN
         XrEkUVn25nbvciz+6EMVa7mmIOhHaGrZctjLAYp07v2nFkwa3j8NY7FK2uDdLMzd1y0B
         0JEOH4pXptLSOjKW5EP1w2xP2TyRGQ8VvMPrefJzUcviLGuipF+bjRAwaFE07OhGqORF
         iLZz3rUaCIVy8MHUn90vsHGp8j1d9kbUfAW4rbIYNNXA9WQ96aSBJrTtGTiYGjAdnhY+
         tJow==
X-Gm-Message-State: AO0yUKXNiY64/DFaXlz5vFK8hmebXsAhRBFYKU6FXSJHclElYBJg3iRG
	x+u2fffwRMlm01WNYb2VHImfxeQB8QEOeSjo8+cwiWRxpZsb7+c1tAAWC0msmHZt3YvBixauR56
	f7QlUMgs/45Ymz0BOY+Rtvtn8Cxeh
X-Received: by 2002:a17:906:d8c7:b0:88d:ba89:1837 with SMTP id re7-20020a170906d8c700b0088dba891837mr3726696ejb.8.1679526272210;
        Wed, 22 Mar 2023 16:04:32 -0700 (PDT)
X-Google-Smtp-Source: AK7set8PtGFSnPCa/DSRidcxkXvXOXD997C/rdxidFF6Jiiv478MoZAZ1cf4rUJ1gg0Ol+rMHQfDCA==
X-Received: by 2002:a17:906:d8c7:b0:88d:ba89:1837 with SMTP id re7-20020a170906d8c700b0088dba891837mr3726683ejb.8.1679526271995;
        Wed, 22 Mar 2023 16:04:31 -0700 (PDT)
Date: Wed, 22 Mar 2023 19:04:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, pasic@linux.ibm.com, cohuck@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
Message-ID: <20230322190416-mutt-send-email-mst@kernel.org>
References: <20230322215243.249524-1-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230322215243.249524-1-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v4 0/8] Rename queue index to queue number

On Wed, Mar 22, 2023 at 11:52:35PM +0200, Parav Pandit wrote:
> 1. Currently, virtqueue is identified between driver and device
> interchangeably using either number of index terminology.
> 
> 2. Between PCI and MMIO transport the queue size (depth) is
> defined as queue_size and QueueNum respectively.
> 
> To avoid confusion and to have consistency, unify them to use as Number.


Looks good, some comments on 8/8.

> Solution:
> a. Use virtqueue number description, and rename MMIO register as QueueSize.
> b. Replace virtqueue index to virtqueue number
> c. RSS area of virtio net has inherited some logic, describe it
> using abstract rq_handle.
> 
> Patch summary:
> patch-1 introduce vq number as generic term
> patch-2 renames index to number for pci transport
> patch-3 renames mmio register from Num to Size
> patch-4 renames index to number for mmio transport
> patch-5 renames num field to size for ccw transport
> patch-6 renames index field to queue_select for ccw transport
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
> 
> ---
> changelog:
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
>   virtio-net: Describe RSS using receive queue handle
> 
>  content.tex                      |  3 ++
>  device-types/net/description.tex | 29 ++++++++++++-----
>  transport-ccw.tex                | 27 ++++++++-------
>  transport-mmio.tex               | 56 +++++++++++++++++++-------------
>  transport-pci.tex                | 14 ++++----
>  5 files changed, 81 insertions(+), 48 deletions(-)
> 
> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

