Return-Path: <virtio-dev-return-12591-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97CEFC77B75
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 15:46:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E4096157EEB
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 15:46:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BCFD29866C7
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 15:46:00 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A0CC89865C3; Fri,  5 May 2023 15:46:00 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8E8369866BE
	for <virtio-dev@lists.oasis-open.org>; Fri,  5 May 2023 15:46:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: lqtm4jYaPPiM1CAur_ZnjA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683301557; x=1685893557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0ll71lkUeWWPvdvdBPgOskWdCAOtnIrMi1UlUkLMHA=;
        b=dOlXK75dJv3vCrXaaHMBDmQ8l9zV2P5jZ3M+K4sFrGEyZLn85pcWPfesRp5B24dLuw
         2kvokwwyJXK5I+3y8HvM43Eaulh0zGE2TwDlpXYNUE2Dk28mG6IyW+r8wz915p/adebr
         fyskRjjJGl068ksa0VWGm/j91rLh6E3O/NtsuZTQSEjS+rk0NBRG2wAlRVBn6WrT9wKM
         G1YDJjhegJZAe8YjKdr2ZkZRUM6jX9xFvcxGOM2lUiIdITVRp4mpbDAj0/rvTA02YlDv
         aZGr1yOPsLSAYRQeCUtgzpcKXIEqEywMSj+jZiO2hS915g9K3m/5efWznwKKn6xO2AYT
         mdLQ==
X-Gm-Message-State: AC+VfDy425h1IC/F5eJE8GmavwrZJ9QAIY5lKv0JlYCIEAwVUxrn//yK
	+AGNGdDmIw/63lgSKCrsoOVsZ48xEk+TAdi6LiZ+FOjBEj1Dr9Iwg63N9hk2TP/0wd2tWffHbWG
	H7HoIsZf8AbhVDOCIfr5ER8iM03YF
X-Received: by 2002:a17:906:4787:b0:94a:658e:1180 with SMTP id cw7-20020a170906478700b0094a658e1180mr1934184ejc.26.1683301557450;
        Fri, 05 May 2023 08:45:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7mJ8+WEP1Oy3wDcPy+nD30xRRuAwGhbnDVPIbHhXa7ZjSG0UPVYG5ab0WdvcfpSGdt061bAw==
X-Received: by 2002:a17:906:4787:b0:94a:658e:1180 with SMTP id cw7-20020a170906478700b0094a658e1180mr1934154ejc.26.1683301557091;
        Fri, 05 May 2023 08:45:57 -0700 (PDT)
Date: Fri, 5 May 2023 11:45:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
	hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>,
	Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230505114501-mutt-send-email-mst@kernel.org>
References: <cover.1683301091.git.mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cover.1683301091.git.mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v13 00/10] Introduce device group and device management

On Fri, May 05, 2023 at 11:40:33AM -0400, Michael S. Tsirkin wrote:
> 
> 
> 
> Change log:
> 
> since 13:
> 	command specific data is u8 again
> 	exclude admin queues in blk's num_queues
> 	minor other tweaks
> 
> since 11:
> 	addressed lots of comments, all minor. consistency with
> 	outstanding number->index and queue->enqueue work
> 	i did not intentionally drop any reviewed-by tags
> 	as all changes are minor - if yours is missing it is
> 	because I forgot to record it, sorry
> 
> 	one "breaking" change in response to stefan's comment:
> 	in patch 5, num_queues has been specified not to include admin
> 	queues: just regular ones.
> 
> since v10:
> 	addressed lots of comments by Jiri, Stefan. Cornelia, Lngshan, Parav, Max
> 
> since v9:
> 	addressed comments by Parav, Max, Cornelia, David and Zhu Lingshan:
> 		added link to errno header from Linux
> 		rename _MEM to _MEMBER
> 		admin vq num is zero based
> 		clarify who sends commands where
> 		minor english tweaks
> 		clarify command length
> 		specify interaction with sriov capability
> 		correct commit log - NumVFs can be 0
> 
> 	i could not decide what should happen when VFs are
> 	disabled. for now did not specify.
> 
> since v8:
> 	addressed comments by Cornelia - as we agreed on list
> 	
> since v7:
> 	make high level error codes match linux, with virtio specific codes
> 		in a separate field
> 	renamed _ACCEPT to _USE since that's what it does
> 	clarified forward compatibility and non pci transports
> 	support multiple admin vqs
> 	conformance statements
> 	lots of changes all over the place to I changed author from Max
> 	to myself. Don't need to take credit but also don't want
> 	to blame Max for my mistakes.
> 
> since v6:
> 
> 	- removed some extentions intended for future use.
> 	  We'll do them when we get there.
> 
> 	- brought back command list query from v5 in a simplified form -
> 	  it's here to address the case where a single parent
> 	  can address multiple groups, such as PF addressing
> 	  transport vq and sriov vfs.
> 
> 	- attempt to make terminology more formal.
> 	In particular a term for whoever controls the group.
>  	I am still going back
> 	and forth between "parent" and "owner" - owner might
> 	be better after all since it will work if we ever
> 	have a self group. For now it's parent.
> 
> TODO (maybe?) - probably ok to defer until this part is upstream:
> 
> 	Add "all members" member id.
> 
> 	Add commands for MSI, feature discovery.
> 
> 	Add commands for transport vq.


Fixes: https://github.com/oasis-tcs/virtio-spec/issues/171

As there have only been tiny tweaks since v12, I'm starting a vote now.

> 
> My intent is to try and support both SR-IOV and SIOV
> usecases with the same structure and maybe even the same
> VQ.
> 
> For example, it might make sense to split creating/destroying
> SIOV devices from the transport passing data from the guest - the
> driver would then not negotiate VIRTIO_F_SR_IOV (which
> then means auto-provisioning).
> 
> More ideas for use-cases:
> virtio VF features query and configuration space provisioning
> virtio VF resource (queues, msix vectors count) provisioning
> 
> 
> Future directions (shouldn't block this patch)
> - aborting commands - left for later. or is vq reset enough?
> - should we rename structures from admin to group admin?
> 
> 
> Michael S. Tsirkin (10):
>   virtio: document forward compatibility guarantees
>   admin: introduce device group and related concepts
>   admin: introduce group administration commands
>   admin: introduce virtio admin virtqueues
>   pci: add admin vq registers to virtio over pci
>   mmio: document ADMIN_VQ as reserved
>   ccw: document ADMIN_VQ as reserved
>   admin: command list discovery
>   admin: conformance clauses
>   ccw: document more reserved features
> 
>  admin.tex                        | 584 +++++++++++++++++++++++++++++++
>  content.tex                      |  62 +++-
>  device-types/blk/description.tex |   2 +-
>  introduction.tex                 |   3 +
>  transport-ccw.tex                |  14 +
>  transport-mmio.tex               |  12 +
>  transport-pci.tex                |  33 ++
>  7 files changed, 707 insertions(+), 3 deletions(-)
>  create mode 100644 admin.tex
> 
> -- 
> MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

