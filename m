Return-Path: <virtio-dev-return-11374-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78947C678D4
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 13:06:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 85144F3F5C
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 13:06:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7D05A98668B
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 13:06:35 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 719CD986672; Thu,  2 Mar 2023 13:06:35 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2A4A09867E8
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Mar 2023 13:06:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: ClNouY-3NMKtFC7_dK2LEA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677762335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fx9jWMQb9V82KAuLpgO6kI1nd/+z11V781+fU5lhD3w=;
        b=6HEKuLFSVBpjKWDjSRhlsExnYWjw2N2wWhnqDHCCtfUIyWJYgiiK499YFXcYrOrIhM
         Mx25s6uF0waGR+1r241O0d/Tw5GWo1Z5HElQ0Ea4iQYsQX75LwZzjj5D/EoPoCBJx9lW
         fRydLvjpnxbNgGHt74BOAPhgwlV09YBazZ4GaRsUmSVO/RHRE4AckraJEFoYtvl+Tes1
         ioy81A3CPXlTtRTzRL4m181orSQ87E6peu43VCmqtLbn/EvY7oGuF07G3J0nsNk0KcFg
         dTWbo/RS9/TVLT8yfraSVy4Fbo4tWt3uzh8QwEZqctBYg6BTTwLm7SN+YVDrj4Vu/58C
         Eikg==
X-Gm-Message-State: AO0yUKX2n5ql/La9bLIgA5kO5lSA1X73idP2QufchW+oNJz/yxhwitWX
	EwV2oe8nyT5HHa4oh5zJZywOAVKYx/x0APU3688YodcMrAnNqXHolylUOzkQfdwNKSphJ/puFbk
	fKpImBTuotHSggDckDorr2cpBHrqo
X-Received: by 2002:a5d:4a89:0:b0:2c7:bb13:e23f with SMTP id o9-20020a5d4a89000000b002c7bb13e23fmr7428843wrq.24.1677762335123;
        Thu, 02 Mar 2023 05:05:35 -0800 (PST)
X-Google-Smtp-Source: AK7set+4TPiyIGcy181f+LV9GgdVQot+B+7yxAdE3SyMwsjycBblYx++W30cxng7tQJhvRWwksf0sA==
X-Received: by 2002:a5d:4a89:0:b0:2c7:bb13:e23f with SMTP id o9-20020a5d4a89000000b002c7bb13e23fmr7428833wrq.24.1677762334949;
        Thu, 02 Mar 2023 05:05:34 -0800 (PST)
Date: Thu, 2 Mar 2023 08:05:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, mst@redhat.com, cohuck@redhat.com,
	sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com,
	Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <45e31c1bfd92e91bb721e2c3fbb15c848c3c49c5.1677761896.git.mst@redhat.com>
References: <cover.1677761896.git.mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cover.1677761896.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] [PATCH v10 10/10] ccw: document more reserved features

vq reset and shared memory are unsupported, too.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 content.tex | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/content.tex b/content.tex
index b414133..efcd8bc 100644
--- a/content.tex
+++ b/content.tex
@@ -2984,6 +2984,8 @@ \subsection{Features reserved for future use}\label{sec:Virtio Transport Options
 \begin{itemize}
 
 \item VIRTIO_F_ADMIN_VQ
+\item VIRTIO_F_RING_RESET
+\item Shared memory regions including VIRTIO_PMEM_F_SHMEM_REGION
 
 \end{itemize}
 
-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

