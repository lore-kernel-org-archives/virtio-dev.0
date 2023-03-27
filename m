Return-Path: <virtio-dev-return-11775-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5FD7C76195
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 09:51:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C16DE759A1
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 09:51:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B5A099862BC
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 09:51:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A7AE3986260; Mon, 27 Mar 2023 09:51:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 92D3D983DE9
	for <virtio-dev@lists.oasis-open.org>; Mon, 27 Mar 2023 09:51:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: h0l5vU75NIavvTPpUOlb4Q-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679910688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwhmn62syTEwzXF4PNqalvCr6B4k+h9NLU5gMizmMRI=;
        b=wbZLgTL1YwukwWBU9yyFpSTcsdjaUvmhQGsKXdbAKyzVsVQqQaRQY3KO8laGRPUVki
         wvWpm+ZQbrI3CdKO1COgtcccsd8aKZ0wWKo9K2C3Qa+pcx2lk8wsHTln1N8O8uKrEVT3
         GzkaFp4Q/zvJHmWpBQklDJAbrMfxDs+QCOl9GEreECPg1sZt1G84xWUfSoAxGAvt9E8T
         SoLSfFjEKY6Y5G7IaWZDfhfwqsnulHyiqWCX7wt1nhbg0+Vc+cBKft+5v107wmRbO+cE
         C8ITx7UiWnVTj0hdTwr+F8tTnMm07QQbpsuVP97X+NYGreIY2bc2o+eAlQeKVd0ZRZAM
         cZTg==
X-Gm-Message-State: AAQBX9cZdXiYuXsOpomXNVPSLBGtJpDZ223PAnNyfxSyTbl8PzQlFzG/
	lmK/bZbmfQSZISvhyNAkCWe9N4YTyUVCGXpKiV9pf3QkElmk+77qOahaizmhRQ55qREnRvKwnFv
	4saSpFxZ/vdgElub/FbK7l1v0vZJw
X-Received: by 2002:a05:6214:e67:b0:5ba:852:272c with SMTP id jz7-20020a0562140e6700b005ba0852272cmr15943297qvb.8.1679910688424;
        Mon, 27 Mar 2023 02:51:28 -0700 (PDT)
X-Google-Smtp-Source: AKy350a4fnBCh2F1IdHn0Ek6Z0qSuLcUV2l2hE4f/rZiXuDso5DrNm7e8EeFVgCqMFouVObLg3PRtA==
X-Received: by 2002:a05:6214:e67:b0:5ba:852:272c with SMTP id jz7-20020a0562140e6700b005ba0852272cmr15943284qvb.8.1679910688161;
        Mon, 27 Mar 2023 02:51:28 -0700 (PDT)
Date: Mon, 27 Mar 2023 11:51:24 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: mst@redhat.com, virtio-dev@lists.oasis-open.org, pasic@linux.ibm.com, 
	cohuck@redhat.com, virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, 
	Jiri Pirko <jiri@nvidia.com>
Message-ID: <xira6k65xzbwx7sp3le7fxvqdvyri67u3b55nbhy43xmfv7rvj@u27jssq6takg>
References: <20230323005944.262738-1-parav@nvidia.com>
 <20230323005944.262738-3-parav@nvidia.com>
 <2h5c6jzeu6mxz6prebazh5g62je5nwwppx6zp3un6mjicxdq5v@xpvbt6soyu4u>
MIME-Version: 1.0
In-Reply-To: <2h5c6jzeu6mxz6prebazh5g62je5nwwppx6zp3un6mjicxdq5v@xpvbt6soyu4u>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v5 2/8] transport-pci: Refer to the vq
 by its number

On Mon, Mar 27, 2023 at 11:50:07AM +0200, Stefano Garzarella wrote:
>Hi Parav,
>
>On Thu, Mar 23, 2023 at 02:59:38AM +0200, Parav Pandit wrote:
>>Currently specification uses virtqueue index and
>>number interchangeably to refer to the virtqueue.
>>
>>Instead refer to it by its number.
>>
>>This patch is on top of [1].
>>
>>[1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00527.html
>>
>>Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
>>Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>>Signed-off-by: Parav Pandit <parav@nvidia.com>
>>---
>>changelog:
>>v2->v3:
>>- addressed comments from Michael
>>- changed vqn to virtqueue number in the Note
>>- refer to vqn field instead of virtqueue number
>>---
>>content.tex       |  2 +-
>>transport-pci.tex | 14 ++++++++------
>>2 files changed, 9 insertions(+), 7 deletions(-)
>>
>>diff --git a/content.tex b/content.tex
>>index 1ab7794..0f634ac 100644
>>--- a/content.tex
>>+++ b/content.tex
>>@@ -321,7 +321,7 @@ \section{Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Virtqueues}
>>VIRTIO_F_IN_ORDER feature. If negotiated, this knowledge
>>might allow optimizations or simplify driver and/or device code.
>>
>>-Each virtqueue is identified as vq number or also referred
>>+Each virtqueue is identified by a vq number or also referred
>
>Could we merge this change into patch 1?

Ooops, I see now that v6 addressed this.

>
>Thanks,
>Stefano
>
>>to as a virtqueue number; vq number range is from 0 to 65535.
>>
>>Each virtqueue can consist of up to 3 parts:
>>diff --git a/transport-pci.tex b/transport-pci.tex
>>index b07a822..044c085 100644
>>--- a/transport-pci.tex
>>+++ b/transport-pci.tex
>>@@ -390,13 +390,15 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>>
>>\item[\field{queue_notify_data}]
>>        This field exists only if VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated.
>>-        The driver will use this value to put it in the 'virtqueue number' field
>>-        in the available buffer notification structure.
>>+        The driver will use this value to put it in the field
>>+        \field{vqn} in the available buffer notification
>>+        structure.
>>        See section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Available Buffer Notifications}.
>>        \begin{note}
>>        This field provides the device with flexibility to determine how virtqueues
>>        will be referred to in available buffer notifications.
>>-        In a trivial case the device can set \field{queue_notify_data}=vqn. Some devices
>>+        In a trivial case the device can set
>>+        \field{queue_notify_data}=vq number. Some devices
>>        may benefit from providing another value, for example an internal virtqueue
>>        identifier, or an internal offset related to the virtqueue number.
>>        \end{note}
>>@@ -1005,7 +1007,7 @@ \subsubsection{Device Initialization}\label{sec:Virtio Transport Options / Virti
>>The driver typically does this as follows, for each virtqueue a device has:
>>
>>\begin{enumerate}
>>-\item Write the virtqueue index (first queue is 0) to \field{queue_select}.
>>+\item Write the virtqueue number (first queue is 0) to \field{queue_select}.
>>
>>\item Read the virtqueue size from \field{queue_size}. This controls how big the virtqueue is
>>  (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}~\nameref{sec:Basic Facilities of a Virtio Device / Virtqueues}). If this field is 0, the virtqueue does not exist.
>>@@ -1035,7 +1037,7 @@ \subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport Option
>>
>>When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
>>the driver sends an available buffer notification to the device by writing
>>-the 16-bit virtqueue index
>>+the 16-bit virtqueue number
>>of this virtqueue to the Queue Notify address.
>>
>>When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
>>@@ -1053,7 +1055,7 @@ \subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport Option
>>If VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated:
>>\begin{itemize}
>>\item If VIRTIO_F_NOTIFICATION_DATA has not been negotiated, the driver MUST use the
>>-\field{queue_notify_data} value instead of the virtqueue index.
>>+\field{queue_notify_data} value instead of the virtqueue number.
>>\item If VIRTIO_F_NOTIFICATION_DATA has been negotiated, the driver MUST set the
>>\field{vqn} field to the \field{queue_notify_data} value.
>>\end{itemize}
>>-- 
>>2.26.2
>>
>>
>>This publicly archived list offers a means to provide input to the
>>OASIS Virtual I/O Device (VIRTIO) TC.
>>
>>In order to verify user consent to the Feedback License terms and
>>to minimize spam in the list archive, subscription is required
>>before posting.
>>
>>Subscribe: virtio-comment-subscribe@lists.oasis-open.org
>>Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
>>List help: virtio-comment-help@lists.oasis-open.org
>>List archive: https://lists.oasis-open.org/archives/virtio-comment/
>>Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
>>List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
>>Committee: https://www.oasis-open.org/committees/virtio/
>>Join OASIS: https://www.oasis-open.org/join/
>>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

