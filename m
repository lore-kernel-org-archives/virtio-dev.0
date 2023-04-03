Return-Path: <virtio-dev-return-11898-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2101CC76188
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:05:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 542BF23D7D
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:05:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C4E2498661F
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:05:26 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 659D598659A; Mon,  3 Apr 2023 15:05:26 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BCBC79863E4
	for <virtio-dev@lists.oasis-open.org>; Mon,  3 Apr 2023 15:03:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: CFEPJhg9MdGT966hLrAKAw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680534223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MC0DixM22z3Ob4dLJ52xNtVKDnto+5lvu6UpUWYdmI=;
        b=FUKMr+peRHBMClLceUtTeHwxel8L3CMJvEDL3BeiKxpaqAXXM77zSN2IDG6X08N24j
         F3uZVQxz5I122SAeQsiVgkTZyExCdhKUPn7M+S3Xyx4cwhgT3HqQNFOAPCkin5O6fp6L
         JetHJ41qH0u+IH9uY7z+btcIAxLqWcH4FWDFV9RuZIDz7fAgAcyo7VRM1ExTHS7RlGLK
         RM6XAAyGrrLrWIP9y03SC8zRy8FFslzVhi/zRzI4OH//xHMviH/q2WKpcJVvHIrUjxvP
         0/LNqd6qxsNpb0dYeIN03HspV8wkyPxwTSYAlXzrvo8W6lvjnMVguLKIWdkrC6/y9VCM
         nMAA==
X-Gm-Message-State: AAQBX9dVg+xcaCK46oyd7+FtGGVsogNc1FJxGMEu5jy4LPRiWbZqBkff
	0m28lshW6AZtiHAlISYOysGnw/j8EOgB4q4BpI4Bi7Ug3INSXi1j/d2CBMbd6qtiiV4et0zGauG
	FERKy5xCkMZtcGNs00QpREcbEbiJN
X-Received: by 2002:a17:907:9725:b0:93f:9594:d97d with SMTP id jg37-20020a170907972500b0093f9594d97dmr35619268ejc.14.1680534223012;
        Mon, 03 Apr 2023 08:03:43 -0700 (PDT)
X-Google-Smtp-Source: AKy350YienEiYCXWomZEoFjip+R69FvKl9BHmqLNdEyFAWxxWR3MDamZBeRMjGBI8ynuK14zuCP3vg==
X-Received: by 2002:a17:907:9725:b0:93f:9594:d97d with SMTP id jg37-20020a170907972500b0093f9594d97dmr35619238ejc.14.1680534222685;
        Mon, 03 Apr 2023 08:03:42 -0700 (PDT)
Date: Mon, 3 Apr 2023 11:03:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, mst@redhat.com, cohuck@redhat.com,
	sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com,
	Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>,
	Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <aa6e3f39c4db34f3cf50a650cffeb0180d89e616.1680533760.git.mst@redhat.com>
References: <cover.1680533760.git.mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cover.1680533760.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] [PATCH v11 06/10] mmio: document ADMIN_VQ as reserved

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
 content.tex | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/content.tex b/content.tex
index 5057df2..f7446bf 100644
--- a/content.tex
+++ b/content.tex
@@ -2364,6 +2364,18 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
 
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

