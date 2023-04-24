Return-Path: <virtio-dev-return-12373-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C890C77B61
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 16:45:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4716FC6131
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 16:45:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 33868986644
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 16:45:17 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2632998635B; Mon, 24 Apr 2023 16:45:17 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7607B9866C7
	for <virtio-dev@lists.oasis-open.org>; Mon, 24 Apr 2023 16:45:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: b6bIAiUIPpCqZdCrP636vA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682354680; x=1684946680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cl8TrnJrpxtSXopKqJcHKnxmIqkCMI8G5gGoUiogvco=;
        b=dVBMMGK2rpx8H3q6BCLnydBG2inOX4WwAi5GYWN7k+XtAnejdzzcJntAMig/H15Fxm
         s9fcAIcDOApuhuDJl9C4vFrxcJlmqdqVaySjgTJsV252S3cudhzt4hlH8YQ2yVDJmUYz
         JA43OO8lUGbiN0iKXOvCH2J0If/pHBuPxP5GHaWkioFX9ZtUTThURMGHHrxa2n9QPnXP
         /I2V0RdlF4AKR9/YvjH67sJIh1MMXfO9lyG29rLClv5GHswJbi7vfaS1wz1eZwGO1dOR
         4jydzEHGuAakArSS/QAMiPqLw5ECpAjfv8/WNzujh+ZZhi5Va4ZJ962LOMcqLN8Jw4qk
         Ixug==
X-Gm-Message-State: AAQBX9d44kCp+bC7+gS0mxJQEG0qs267dCviW9MfJLnatIS7YtV5qL1P
	fEzUg8hNHarP8NleeD1ZocdSNk5FvJLqLkvciX4A3d/VyRVusxAI9hbyDBtz94xf0grNxjAtAU2
	1TGZZjQlBBIb0qJo08X8cNPfStnOq8BDgeskB
X-Received: by 2002:adf:e347:0:b0:2d3:33d4:1cfb with SMTP id n7-20020adfe347000000b002d333d41cfbmr9250408wrj.36.1682354680705;
        Mon, 24 Apr 2023 09:44:40 -0700 (PDT)
X-Google-Smtp-Source: AKy350bDDfkbkz4WG8aQAC4jY8htgrmWyr7CVjUUamriaiWUZUWUcjMHs0K2st5GxulHERpJ1iT0bg==
X-Received: by 2002:adf:e347:0:b0:2d3:33d4:1cfb with SMTP id n7-20020adfe347000000b002d333d41cfbmr9250393wrj.36.1682354680453;
        Mon, 24 Apr 2023 09:44:40 -0700 (PDT)
Date: Mon, 24 Apr 2023 12:44:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, mst@redhat.com, cohuck@redhat.com,
	sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com,
	Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>,
	Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <a67ae1170d9535a98862d01825b2662180d77d82.1682354275.git.mst@redhat.com>
References: <cover.1682354275.git.mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cover.1682354275.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] [PATCH v12 06/10] mmio: document ADMIN_VQ as reserved

Adding relevant registers needs more work and it's not
clear what the use-case will be as currently only
the PCI transport is supported. But let's keep the
door open on this.
We already say it's reserved in a central place, but it
does not hurt to remind implementers to mask it.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

---

changes in v12:
	drop "as of now" to address comment by parav
---
 content.tex | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/content.tex b/content.tex
index bcbc06d..7d6d9c4 100644
--- a/content.tex
+++ b/content.tex
@@ -2365,6 +2365,18 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
 
 Notification mechanisms did not change.
 
+\subsection{Features reserved for future use}\label{sec:Virtio Transport Options / Virtio Over MMIO / Features reserved for future use}
+
+Devices and drivers utilizing Virtio Over MMIO
+do not support the following features:
+\begin{itemize}
+
+\item VIRTIO_F_ADMIN_VQ
+
+\end{itemize}
+
+These features are reserved for future use.
+
 \section{Virtio Over Channel I/O}\label{sec:Virtio Transport Options / Virtio Over Channel I/O}
 
 S/390 based virtual machines support neither PCI nor MMIO, so a
-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

