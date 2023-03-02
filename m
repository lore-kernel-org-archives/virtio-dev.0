Return-Path: <virtio-dev-return-11370-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECAADC678D4
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 13:06:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BAB6365F
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 13:05:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B0A15986688
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 13:05:50 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A5027986674; Thu,  2 Mar 2023 13:05:50 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0AECD98669A
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Mar 2023 13:05:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: KZGI4QgNO2mTlO3G5Of8SA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677762318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UqwvUGzfx47XXHBlp8V7l2ptcPUeJ7meD03MAmLbMhw=;
        b=mVrzDZA+PzwPE7qcc7np3Lru0q8zv5s/R1EpN9mT+0YuGdQDLTpdEmEDtRSbKwNiMy
         n6i/fF/KkgD928X6IVXEfxXmhjwMuwU4EEAmzDtozfYo/JuFBTtBg0es264fPbBATzUl
         MYkoDBz5+eX66eXLRagzNm+hjQE986FVjqsgyEcJO9PqmgQ0my/7GgdNVlruDzZu00fW
         /BrWfmBrxQ7q8fn2tfiY5iNn3165s6rtWtgDFyafSwzlhFTPCk/L5TotblPNAEr8wPkH
         V/N1Ku/LldUvTHy7wE4Lbi49KKlciXOOLjrIoZ55W6A2aaJSRusvQ8mo6qhOuD+JHLkx
         omLA==
X-Gm-Message-State: AO0yUKXlyQxUwM1JiXySx4Uui4julpz213x24/tZLO7NtBKBXrJgeXYb
	mLd+jXfI5V5kg2B5+X5qr0vA7DalnzEYdzhiV/ow2XWV3o4OkUARpBHNxVGDn5D7/NGETkjqIl/
	qEsK9/AkJNFz7SS1P5QhUIk6NWly1ihYH7A==
X-Received: by 2002:adf:fecd:0:b0:2c7:13e4:2094 with SMTP id q13-20020adffecd000000b002c713e42094mr8012563wrs.42.1677762318072;
        Thu, 02 Mar 2023 05:05:18 -0800 (PST)
X-Google-Smtp-Source: AK7set+5gn2lLqtCQudZGWRhIH7n46ZA5SyVdW5uEs9c+hUxa6OQijFSHBnazjuA2asmIc5JWFGuUQ==
X-Received: by 2002:adf:fecd:0:b0:2c7:13e4:2094 with SMTP id q13-20020adffecd000000b002c713e42094mr8012539wrs.42.1677762317900;
        Thu, 02 Mar 2023 05:05:17 -0800 (PST)
Date: Thu, 2 Mar 2023 08:05:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, mst@redhat.com, cohuck@redhat.com,
	sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com,
	Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <dd9c34ed74ee296228562f6946d4ca3f2fbee1e1.1677761896.git.mst@redhat.com>
References: <cover.1677761896.git.mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cover.1677761896.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] [PATCH v10 06/10] mmio: document ADMIN_VQ as reserved

Adding relevant registers needs more work and it's not
clear what the use-case will be as currently only
the PCI transport is supported. But let's keep the
door open on this.
We already say it's reserved in a central place, but it
does not hurt to remind implementers to mask it.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 content.tex | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/content.tex b/content.tex
index 1076125..6c3ee52 100644
--- a/content.tex
+++ b/content.tex
@@ -2363,6 +2363,18 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
 
 Notification mechanisms did not change.
 
+\subsection{Features reserved for future use}\label{sec:Virtio Transport Options / Virtio Over MMIO / Features reserved for future use}
+
+At this time, devices and drivers utilizing Virtio Over MMIO
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

