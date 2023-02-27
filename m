Return-Path: <virtio-dev-return-11320-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C89EDC64ED6
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 17:39:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C92E43E30B
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 17:39:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ADAE0986601
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 17:39:46 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 984179864DB; Mon, 27 Feb 2023 17:39:46 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 86836986561
	for <virtio-dev@lists.oasis-open.org>; Mon, 27 Feb 2023 17:39:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 3nmXhcDqPF6db1R4QzLgCw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1Vp0AA0ML2r2a8JnaX3WpmKUtqyf0CyFxdavBRWNjQ=;
        b=Yu0ihb4+k10IhrQfTPF/EV4qIDwaoDOzB/dm4Nz7HzttVCDUTvX4X6z1f7eKC/CgR9
         9AK5EHRGVYAEsWyLRw8B+UPZ/jlOSvrKwwAhMYA/LEFUQYW6bzd4Vxn4Gq/MrGt4RqhZ
         7SZJzVLfNRAxRRr3Raf/bYizFv6zR1Gf1mngjhToscZshpyCht0n2eoLvnzT+xj5gXoE
         j/I7lgVvY6UqGdWLTPPTXL4S5xqu6kMbFuF1I+NmE8c18TVWzY7Dns+Z756tdg5AsQqE
         M6zLkhtNx9V+Rgfelx+xVhb14kilR3m0Rz1D/3aHUybhujkPXJMWh5Db+JOcULm0qmjI
         GiKQ==
X-Gm-Message-State: AO0yUKWXraqlg16iU/enZtyJbaNImRSoqFKQTC0zGMW/PPQ/kyqfGNb7
	rCQ8EBSgHYkaKTlLSAhl/wIuIJFf/zBkZ8agi928vQH9VCFoCegtwtAc74WX35jmO2JRYx82FnD
	DXTQJcPOALnqwsTkcAE2FQUwxPE/6
X-Received: by 2002:a5d:5222:0:b0:2cb:ae45:111 with SMTP id i2-20020a5d5222000000b002cbae450111mr3162277wra.35.1677519583078;
        Mon, 27 Feb 2023 09:39:43 -0800 (PST)
X-Google-Smtp-Source: AK7set8a2fF7bBWWmVX1VOjxmKEIAv8lsaQNQeH6bjHWICpHUG9OPUhQCBMrUB2GZaPXSxKa0d7Ahw==
X-Received: by 2002:a5d:5222:0:b0:2cb:ae45:111 with SMTP id i2-20020a5d5222000000b002cbae450111mr3162265wra.35.1677519582743;
        Mon, 27 Feb 2023 09:39:42 -0800 (PST)
Date: Mon, 27 Feb 2023 12:39:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com,
	Yuri Benditovich <yuri.benditovich@daynix.com>
Message-ID: <20230227123751-mutt-send-email-mst@kernel.org>
References: <20230223054624.168042-1-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230223054624.168042-1-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH 0/3] Rename queue index to queue number
Message-ID: <20230227173939.x91hyEpkRFgNPhUukG_e_rSsQEnTRxm_X-Iw5VJZIKA@z>

On Thu, Feb 23, 2023 at 07:46:21AM +0200, Parav Pandit wrote:
> 1. Currently, virtqueue is identified between driver and device
> interchangeably using either number of index terminology.
> 
> 2. Between PCI and MMIO transport the queue size (depth) is
> defined as queue_size and QueueNum respectively.
> 
> To avoid confusion and to have consistency, unify them to use as Number.
> 
> Solution:
> Use virtqueue number description, and rename MMIO register as QueueSize.
> 
> Patch summary:
> patch-1 renames index to number for pci transport
> patch-2 renames mmio register from Num to Size
> patch-3 renames index to number for mmio transport
> 
> Please review.
> This series fixes the issue [1].
> 
> This series is on top of [2].
> 
> [1] https://github.com/oasis-tcs/virtio-spec/issues/163
> [2] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00527.html

What about RSS description in net? That says:

description.tex:Field \field{unclassified_queue} contains the 0-based index of

is the index same as vq number? or something different?





> ---
> Cornelia:
> I was not sure about ccw for vq_config_block and vq_info_block structures
> index field refers to the queue number or not.
> Can you please clarify?
> 
> If it vqn, I will send v1 by replacing index to vqn to be
> consistent with other part of the spec which also uses vqn.
> 
> Parav Pandit (3):
>   transport-pci: Refer to the vq by its number
>   transport-mmio: Rename QueueNum register
>   transport-mmio: Refer to the vq by its number
> 
>  transport-mmio.tex | 16 ++++++++--------
>  transport-pci.tex  |  6 +++---
>  2 files changed, 11 insertions(+), 11 deletions(-)
> 
> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

