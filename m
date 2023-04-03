Return-Path: <virtio-dev-return-11900-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81193C76196
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:05:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4D6EB41A34
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:05:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 61C69986841
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:05:27 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2D1939867D4; Mon,  3 Apr 2023 15:05:27 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ABDD798640E
	for <virtio-dev@lists.oasis-open.org>; Mon,  3 Apr 2023 15:03:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: pY12In3sMYy7empc8jt4KA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680534229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilognqbAB16JxBo3iXgvaY7nq8HSXhqpPRWvM+qQi5w=;
        b=s3GBRIb7pndmNkwAkdvr+FqHW1vmNzid1SVdj1vsAjvyk03d5NJmHSNlC01caeiN+w
         SAOLiLQLIQhWEYsMMNEHkfEyMRtv8IKNrKsOYzw9HMQsoFvGFuuDVB8hZn6Oxxaj7ydq
         hOQWeJQIazYHyVxElI0freas3cq1dcUitl10ikaQLdX41G7EQUEJff4BXzIcfLpz9qBL
         rQzobAZFRwg+T9U8AYJjZSzUoSfYDrmfGZ12FUtoploR8wNtMc73Oi2sbIaJEisULm6t
         FtcfJB2HhZj7UawZBUDx5FaLlFtvflJ0jjgOkxUxV2dgriI6X0vO5O91Bo7fvviohb0E
         Ei8g==
X-Gm-Message-State: AAQBX9e47kHbPHyMIdVcjRdsi1qEcFhsyshrayhKc6/NpGOkrZzujrCJ
	uJL28itKIJ9NaXpI4CuXSp63OQHywN9zy3EJbruhfkHV00o0E0tlyQZgPkd2j9zoUG//jfB7aYJ
	Ui12OsL+MtG/srYaTQQTrZfW457Pw
X-Received: by 2002:a17:906:f2c9:b0:93b:62f:82a3 with SMTP id gz9-20020a170906f2c900b0093b062f82a3mr37416461ejb.6.1680534229595;
        Mon, 03 Apr 2023 08:03:49 -0700 (PDT)
X-Google-Smtp-Source: AKy350Yp8H2KlyeyxivLk3z1Zouh1GwQAtojAeN41qsCs/KMhwsz2BSdB6/i6SnFBUdXWXPIocLuyQ==
X-Received: by 2002:a17:906:f2c9:b0:93b:62f:82a3 with SMTP id gz9-20020a170906f2c900b0093b062f82a3mr37416436ejb.6.1680534229309;
        Mon, 03 Apr 2023 08:03:49 -0700 (PDT)
Date: Mon, 3 Apr 2023 11:03:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, mst@redhat.com, cohuck@redhat.com,
	sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com,
	Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>,
	Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <71c1c5f86e19651585426160fc4cc15dc2da6ee6.1680533760.git.mst@redhat.com>
References: <cover.1680533760.git.mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cover.1680533760.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] [PATCH v11 07/10] ccw: document ADMIN_VQ as reserved

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
---
 content.tex | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/content.tex b/content.tex
index f7446bf..1213d48 100644
--- a/content.tex
+++ b/content.tex
@@ -2978,6 +2978,18 @@ \subsubsection{Resetting Devices}\label{sec:Virtio Transport Options / Virtio ov
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

