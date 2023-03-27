Return-Path: <virtio-dev-return-11773-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CABFC7619A
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 06:10:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DA68542A69
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 06:10:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C65F39862E3
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 06:10:11 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BBA0A98628D; Mon, 27 Mar 2023 06:10:11 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A2EDF986260;
	Mon, 27 Mar 2023 06:10:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Veh3eZs_1679897400;
Message-ID: <1679897351.7097778-1-xuanzhuo@linux.alibaba.com>
Date: Mon, 27 Mar 2023 14:09:11 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Parav Pandit <parav@nvidia.com>
Cc: <virtio-comment@lists.oasis-open.org>,
 <shahafs@nvidia.com>,
 Parav Pandit <parav@nvidia.com>,
 <mst@redhat.com>,
 <virtio-dev@lists.oasis-open.org>,
 <pasic@linux.ibm.com>,
 <cohuck@redhat.com>
References: <20230324013534.280820-1-parav@nvidia.com>
In-Reply-To: <20230324013534.280820-1-parav@nvidia.com>
Subject: [virtio-dev] Re: [virtio-comment] [PATCH 0/3] transport-pci: msix summary update

Series:

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

On Fri, 24 Mar 2023 04:35:31 +0300, Parav Pandit <parav@nvidia.com> wrote:
> Summary for config_msix_vector and queue_msix_vector
> registers have a confusing text of "for MSI-X".
>
> Rewrite the register summary line.
>
> Patch summary:
> patch 1 removes empty line at the end of the file
> patch 2 updates configuration vector summary
> patch 3 updates queue vector summary
>
> These are only editorial changes to rewrite the summary.
> Hence it should not require a github issue.
>
> Parav Pandit (3):
>   transport-pci: Remove empty line at end of file
>   transport-pci: Improve config msix vector description
>   transport-pci: Improve queue msix vector register desc
>
>  transport-pci.tex | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> --
> 2.26.2
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

