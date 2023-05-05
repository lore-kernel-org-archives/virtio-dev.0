Return-Path: <virtio-dev-return-12590-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4CA4C77B75
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 15:42:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C01C1F3F68
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 15:41:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B644E9866CF
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 15:41:48 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A93339866C2; Fri,  5 May 2023 15:41:48 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7FCBF986756
	for <virtio-dev@lists.oasis-open.org>; Fri,  5 May 2023 15:41:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: ckKt5MqTN0uSYPQi9-8Slw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683301262; x=1685893262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TBRQFnF9vtLPx3AcrK3IgDuWPAKNdNiqDo5m0n9nBM=;
        b=iX9EfL/jtzI/YLS/6IHfMbH4d/kRxgyuq3mPog05+C9z25HNjI22R1NjiGx5Vw/XOc
         aZ1nwWvWsm4Jp+BSyIi2549qyJ4eJmBv3l6phfarnPcKg8ib2qxwd9fh4wJJce3Ia7Nr
         OTR0EXs3zmXQiYEurpckbTUFx+b0Evtcll+pGZE1lea03rIv0RTeHPgQqTER24LY8/XE
         hhsfdpZ36xLRCakmUHjCuOdFfe03TXNb1KB2V6oL1WO9dYvTJRq6vV39gtHYiIRCcNAV
         dBEz91xkQvkZnJvhgHZPKLTObfxt2zYXpBjfRcQXCq+lL9XE+I1ybk25t/pFg8tgOljq
         ohNw==
X-Gm-Message-State: AC+VfDwUWe9jakllRccF8tCmoO4DR2aoZcomdWO5PDEnmcQu5M2vgP4c
	ZJyIWoE5EkI3FD8Ra6ccZfiufn3HJSiyTycYcCT5yHtbTCexa8lzKs+9CHuY/QLbWZeefuugWlj
	07pBeH3YXhtZNd4lbv/SWir7qo5Ro
X-Received: by 2002:a1c:4b0a:0:b0:3ee:96f0:ea31 with SMTP id y10-20020a1c4b0a000000b003ee96f0ea31mr1438027wma.18.1683301262317;
        Fri, 05 May 2023 08:41:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6XiPVd69y9ChGUBLUcw1qf/0y4Gqb0IOfqgTCAMIVgfnFHCnLPwS8rwt/1/iur+LWPGKEUzw==
X-Received: by 2002:a1c:4b0a:0:b0:3ee:96f0:ea31 with SMTP id y10-20020a1c4b0a000000b003ee96f0ea31mr1437998wma.18.1683301261885;
        Fri, 05 May 2023 08:41:01 -0700 (PDT)
Date: Fri, 5 May 2023 11:40:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, mst@redhat.com, cohuck@redhat.com,
	sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com,
	Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>,
	Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <879bb769e6cbf52799ee5f6ee8ea003efead61e7.1683301091.git.mst@redhat.com>
References: <cover.1683301091.git.mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cover.1683301091.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] [PATCH v13 07/10] ccw: document ADMIN_VQ as reserved

Adding relevant registers needs more work and it's not
clear what the use-case will be as currently only
the PCI transport is supported. But let's keep the
door open on this.
We already say it's reserved in a central place, but it
does not hurt to remind implementers to mask it.

Note: there are more features to add to this list.
Will be done later with a patch on top.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Zhu Lingshan <lingshan.zhu@intel.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>

since v12:
	drop "at this time" comment by parav
---
 transport-ccw.tex | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/transport-ccw.tex b/transport-ccw.tex
index c492cb9..d42ec7f 100644
--- a/transport-ccw.tex
+++ b/transport-ccw.tex
@@ -599,3 +599,15 @@ \subsubsection{Resetting Devices}\label{sec:Virtio Transport Options / Virtio ov
 successful conclusion of the CCW_CMD_VDEV_RESET channel command, although it
 MAY also choose to verify reset completion by reading \field{device status} via
 CCW_CMD_READ_STATUS and checking whether it is 0 afterwards.
+
+\subsection{Features reserved for future use}\label{sec:Virtio Transport Options / Virtio over channel I/O / Features reserved for future use}
+
+Devices and drivers utilizing Virtio over channel I/O
+do not support the following features:
+\begin{itemize}
+
+\item VIRTIO_F_ADMIN_VQ
+
+\end{itemize}
+
+These features are reserved for future use.
-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

