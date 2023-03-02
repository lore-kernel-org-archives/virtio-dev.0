Return-Path: <virtio-dev-return-11372-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB49C678D4
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 13:06:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8BE6B23D57
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 13:06:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 857169866A8
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 13:06:15 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7AD3F986676; Thu,  2 Mar 2023 13:06:15 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3FEC698669C
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Mar 2023 13:06:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: jlzC7ygoN-2okIj-8Uz8zQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677762322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sf1IpS7VT/gug9Fti3yx3cdh/uC6X+C7k5kIk4CUq3k=;
        b=f2SVjxHIlaUhUpzGSD+yj7S4JoWg9mqZr8cR2mX0olJx9f++t3eXzqNA03Y8G+EHwe
         4AlzLXWmwLFOfo+FBC8lLcwIE3dcJg8wk/zS6cwL0q/HE9Vr+Imav32Lhoz2lom5MNmA
         8ZCvNwvuWqW6BoFsLARKL2p5a6z6PhKH1/sBRAApt9JL7F3yNHFXqAvsGQzdfn4sQtPt
         lYRgXAZJMyngkNWDh6f1Zdh84HvoKyGr6LKzu7cxiWw5Q/PnMgbsMbr0D6Y279/yw0Hj
         +3GY1dquNb/S6GxvWnxkogp4AR8aVEMG1PcL/Fm5CR3QZM69hqKWDx7XQ0GBEWETSops
         DMpw==
X-Gm-Message-State: AO0yUKWyGw3ZITaDCoBSxxWmFVXKyhoFkh7+AVmDlE8LBq8GGXPp28gB
	vfhMGnidO9gzTAkazwCHSn3nVlPpYJXlcjAOqjRl5lviSw/m8vq62LydgrPxKm0Yn9Ug4BXfRQF
	VrAR61UypwmnHc1rb4e4wXWzxlAk3
X-Received: by 2002:a05:6000:104d:b0:2c7:390e:163c with SMTP id c13-20020a056000104d00b002c7390e163cmr7204581wrx.47.1677762322104;
        Thu, 02 Mar 2023 05:05:22 -0800 (PST)
X-Google-Smtp-Source: AK7set+bCZOxa9ufDTHNXsUJABlz5CwvSXfdY144y/CG9ZlCOCKwnIKjLmljUs6rSTpSYYHRyiPNZQ==
X-Received: by 2002:a05:6000:104d:b0:2c7:390e:163c with SMTP id c13-20020a056000104d00b002c7390e163cmr7204566wrx.47.1677762321918;
        Thu, 02 Mar 2023 05:05:21 -0800 (PST)
Date: Thu, 2 Mar 2023 08:05:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, mst@redhat.com, cohuck@redhat.com,
	sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com,
	Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <cd10fcfd7ab071982b6cd372fb3db29ef4526a02.1677761896.git.mst@redhat.com>
References: <cover.1677761896.git.mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cover.1677761896.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] [PATCH v10 07/10] ccw: document ADMIN_VQ as reserved

Adding relevant registers needs more work and it's not
clear what the use-case will be as currently only
the PCI transport is supported. But let's keep the
door open on this.
We already say it's reserved in a central place, but it
does not hurt to remind implementers to mask it.

Note: there are more features to add to this list.
Will be done later with a patch on top.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 content.tex | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/content.tex b/content.tex
index 6c3ee52..b414133 100644
--- a/content.tex
+++ b/content.tex
@@ -2977,6 +2977,18 @@ \subsubsection{Resetting Devices}\label{sec:Virtio Transport Options / Virtio ov
 MAY also choose to verify reset completion by reading \field{device status} via
 CCW_CMD_READ_STATUS and checking whether it is 0 afterwards.
 
+\subsection{Features reserved for future use}\label{sec:Virtio Transport Options / Virtio over channel I/O / Features reserved for future use}
+
+At this time, devices and drivers utilizing Virtio over channel I/O
+do not support the following features:
+\begin{itemize}
+
+\item VIRTIO_F_ADMIN_VQ
+
+\end{itemize}
+
+These features are reserved for future use.
+
 \chapter{Device Types}\label{sec:Device Types}
 
 On top of the queues, config space and feature negotiation facilities
-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

