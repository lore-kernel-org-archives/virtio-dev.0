Return-Path: <virtio-dev-return-12377-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F4AC77B73
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 16:46:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2EEE33257
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 16:45:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6DC0A9866A9
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 16:45:29 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BCFCF9866DA; Mon, 24 Apr 2023 16:45:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E82779866A3
	for <virtio-dev@lists.oasis-open.org>; Mon, 24 Apr 2023 16:45:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: FlNro2rqO36DhduCk2kFJA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682354696; x=1684946696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EobZNADGc9RGdpDef7rAlYQCuR+CaNuaH2E8TZ/lczU=;
        b=O7O7nA5zTVmR8WpwE8caKdFVhz9go1PZAQJIrR/Cje4wjzIdx78TyLniIH/AOzjG7g
         kqMovxylcIxpY6Z3PnjzPs9vTX0hZ7KNkNSM/dU+WnxCyoGDA/vXk06Yf/fz6t/xGa+Q
         c46Vba8bNwjf2gqWdDz7v6+Z35nqYKWrklEFoR748YfK8Ozlpb0wWwB/f3JE5D/M/KZw
         gJJ0qW8CUT53EnjPq3K2v0k52VDgq640zKuyt7zrOjSvubuXFcXZk7inlroAYAxGaPNw
         7uP1Q5luPGicQZDuv++KB/OLQuVkfrfl/+HLv12r213jkLRYaHyiE/TmtY5qu3uL1Brg
         MN4w==
X-Gm-Message-State: AAQBX9dibDTWzVg3BNw666e3zH7bdh8R5sQe26hS0iDOiaxJsbEhPJKd
	exh1LmU+MxAEufz78UfAe+t43JAUfmLOBp7r12cqDz2m7s3qWMP4GJlm4AfNBHo4ycM9TKrbbIl
	CP3cvsh5G+k42rCivwg6RKn1lPWnj
X-Received: by 2002:a7b:ce04:0:b0:3f0:f3ee:9e2a with SMTP id m4-20020a7bce04000000b003f0f3ee9e2amr8223428wmc.35.1682354696179;
        Mon, 24 Apr 2023 09:44:56 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZI1IosDzvVkvuioxGJc58Yq6/Jixuqa346VM3mfDQNZG8Y2ZbItZFloie4FVOtiXmQbf+vpg==
X-Received: by 2002:a7b:ce04:0:b0:3f0:f3ee:9e2a with SMTP id m4-20020a7bce04000000b003f0f3ee9e2amr8223412wmc.35.1682354696002;
        Mon, 24 Apr 2023 09:44:56 -0700 (PDT)
Date: Mon, 24 Apr 2023 12:44:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, mst@redhat.com, cohuck@redhat.com,
	sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com,
	Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>,
	Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <db86630b80459e8a40b0f41026473be5bc640763.1682354275.git.mst@redhat.com>
References: <cover.1682354275.git.mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cover.1682354275.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] [PATCH v12 10/10] ccw: document more reserved features

vq reset and shared memory are unsupported, too.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Fixes: https://github.com/oasis-tcs/virtio-spec/issues/160
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Zhu Lingshan <lingshan.zhu@intel.com>

---

changes in v12:
address comment by parav
---
 content.tex | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/content.tex b/content.tex
index 1bc9af0..fe032ac 100644
--- a/content.tex
+++ b/content.tex
@@ -2988,11 +2988,13 @@ \subsubsection{Resetting Devices}\label{sec:Virtio Transport Options / Virtio ov
 
 \subsection{Features reserved for future use}\label{sec:Virtio Transport Options / Virtio over channel I/O / Features reserved for future use}
 
-At this time, devices and drivers utilizing Virtio over channel I/O
+Devices and drivers utilizing Virtio over channel I/O
 do not support the following features:
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

