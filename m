Return-Path: <virtio-dev-return-11902-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0421FC76196
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:06:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id F1F1667062
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:05:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A57D0986739
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:05:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8C73B98665E; Mon,  3 Apr 2023 15:05:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2F76E9865D8
	for <virtio-dev@lists.oasis-open.org>; Mon,  3 Apr 2023 15:04:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: bp-UNmMHMsujV50DzLispw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680534251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02YT+TGXB8e2/Yq6IzZnLTmPXxtILh1+Gc+RZ2GFO14=;
        b=xXeK/Tb4g/UET4XLUTgtTnl7KZnZlh+bTyzxIDGCK7Z0fckmQGFoN4Y43oDgSVRBzE
         4k/5wpvhUHoHH0oUTm8wzlRFgogKoWpqAOerztxntBB5NLsFL81ZU7CW291y8XUuuKIe
         4CFt4lMNfImKBghrbKnWGGg0uEcaWwZvFMLPHcYMIme0xG9mRhLvaqqtECUBb2Patt9f
         EX3W/qkIX956XL37DmNa5wNdP04HTby+ClQGyt8M0K/5VAHz3nVGbFFOzkyx8qZvT17D
         TuEBqbpsGGXpTno0NYZb8spYKT2wMHtSp2bkkomBj3ISS2c2FYvNBku2BnpZ3Hji5irs
         Nrkg==
X-Gm-Message-State: AAQBX9erlBWXILhJNMaKwoyP3/vV2lT5saYD+GqXmwiI2cX5aGWbiDsO
	Fdh4/CnqrGrCQi++BoeTvDA08mvjZ1avr+yjj66whv9VOxzar+0l8cU5GPd8syu1MoYLWe9Y3o1
	JRk9MoAOcX2HKPyEouzNZ9V6PWlYf
X-Received: by 2002:a17:907:8a19:b0:947:fb8a:f2d2 with SMTP id sc25-20020a1709078a1900b00947fb8af2d2mr8811335ejc.62.1680534250985;
        Mon, 03 Apr 2023 08:04:10 -0700 (PDT)
X-Google-Smtp-Source: AKy350aOwy6h7mmToFAK3cPW2hLPCGVAYxn6qzUhgALBkqJkwewr41nDOUi1lHPRuSG1rSrhJl0xJw==
X-Received: by 2002:a17:907:8a19:b0:947:fb8a:f2d2 with SMTP id sc25-20020a1709078a1900b00947fb8af2d2mr8811314ejc.62.1680534250800;
        Mon, 03 Apr 2023 08:04:10 -0700 (PDT)
Date: Mon, 3 Apr 2023 11:04:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, mst@redhat.com, cohuck@redhat.com,
	sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com,
	Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>,
	Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <b1445cf4f4702f4dbea74a3498e02a85b6cc702b.1680533760.git.mst@redhat.com>
References: <cover.1680533760.git.mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cover.1680533760.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] [PATCH v11 10/10] ccw: document more reserved features

vq reset and shared memory are unsupported, too.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Fixes: https://github.com/oasis-tcs/virtio-spec/issues/160
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 content.tex | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/content.tex b/content.tex
index 1213d48..fca3827 100644
--- a/content.tex
+++ b/content.tex
@@ -2985,6 +2985,8 @@ \subsection{Features reserved for future use}\label{sec:Virtio Transport Options
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

