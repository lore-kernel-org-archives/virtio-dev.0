Return-Path: <virtio-dev-return-11674-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E56C74A5B
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 09:01:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 95BF21922E5
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 09:01:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 83FF6986449
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 09:01:20 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 723F3983DFC; Tue, 21 Mar 2023 09:01:20 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 60BC79863AC
	for <virtio-dev@lists.oasis-open.org>; Tue, 21 Mar 2023 09:01:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 2UzA8fCPMLion1qMd8HMpw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679389277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjAaGidWyKnivcNV3HLx1wYjDnpg9aFiMzqb9Pk8p50=;
        b=2jL73HikRg/tgWee+gpVuH3XOyJn2yKlIfm4wRaStVYHktyx+wsfY7R345gscat0Cd
         TgxDHPLUeNWJWNbsbk2EL2nf6eh7ogdwBU/cUZN07PvMF4XGJwMOA66zNiufigDHlOS0
         EOLho837G8xODOrM6X8fDG+X9bBNJuRRILUPQJZ/HqTlsFgw3+38yyESq8Hz4RUVzWay
         1tZ81j8HzRdGwy/ayfe9qQ+beaIvpCsFzPM3kJDRhNPvSXTPa7nM3SiDIXo8sTHCsHO8
         oC1NnC2QNx0e0q41c67bddsasP0nqrTM4Yz/eKVi5mGR6gOts+ywi+8WzDIq0Fuju/Yp
         ZhNg==
X-Gm-Message-State: AO0yUKUz5YYuvHVXmQ+1itRpPtDcwxK/74ogaHAejIrhSw3KWTb4lfnx
	l2m6+pLS2Apf6Lsexo74sExKr6ZOT1ZZEdr0hVs/UrYtYlJFxBDxJxtKDYQUVlx9yg9XQxtoidi
	IXP9dVl5brWNLnGVxHAmUKcBiQgfv
X-Received: by 2002:a1c:4b10:0:b0:3ed:2619:6485 with SMTP id y16-20020a1c4b10000000b003ed26196485mr1837446wma.3.1679389277037;
        Tue, 21 Mar 2023 02:01:17 -0700 (PDT)
X-Google-Smtp-Source: AK7set/EfI5MqiN94ncZF4f9KW1heIXNHbz6YJCoO8shgd3woEPtdkXCCgb/U93fZdrl3B2eI9m80A==
X-Received: by 2002:a1c:4b10:0:b0:3ed:2619:6485 with SMTP id y16-20020a1c4b10000000b003ed26196485mr1837423wma.3.1679389276762;
        Tue, 21 Mar 2023 02:01:16 -0700 (PDT)
Date: Tue, 21 Mar 2023 05:01:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, pasic@linux.ibm.com, cohuck@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com,
	Jiri Pirko <jiri@nvidia.com>
Message-ID: <20230321045804-mutt-send-email-mst@kernel.org>
References: <20230321041036.201439-1-parav@nvidia.com>
 <20230321041036.201439-2-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230321041036.201439-2-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v2 1/7] transport-pci: Refer to the vq
 by its number

On Tue, Mar 21, 2023 at 06:10:30AM +0200, Parav Pandit wrote:
> Currently specification uses virtqueue index and
> number interchangeably to refer to the virtqueue.
> 
> Instead refer to it by its number.
> 
> This patch is on top of [1].
> 
> [1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00527.html
> 
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
>  transport-pci.tex | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/transport-pci.tex b/transport-pci.tex
> index b07a822..dbd3adb 100644
> --- a/transport-pci.tex
> +++ b/transport-pci.tex
> @@ -1005,7 +1005,7 @@ \subsubsection{Device Initialization}\label{sec:Virtio Transport Options / Virti
>  The driver typically does this as follows, for each virtqueue a device has:
>  
>  \begin{enumerate}
> -\item Write the virtqueue index (first queue is 0) to \field{queue_select}.
> +\item Write the virtqueue number (first queue is 0) to \field{queue_select}.
>  
>  \item Read the virtqueue size from \field{queue_size}. This controls how big the virtqueue is
>    (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}~\nameref{sec:Basic Facilities of a Virtio Device / Virtqueues}). If this field is 0, the virtqueue does not exist.
> @@ -1035,7 +1035,7 @@ \subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport Option
>  
>  When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
>  the driver sends an available buffer notification to the device by writing
> -the 16-bit virtqueue index
> +the 16-bit virtqueue number
>  of this virtqueue to the Queue Notify address.
>  
>  When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
> @@ -1053,7 +1053,7 @@ \subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport Option
>  If VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated:
>  \begin{itemize}
>  \item If VIRTIO_F_NOTIFICATION_DATA has not been negotiated, the driver MUST use the
> -\field{queue_notify_data} value instead of the virtqueue index.
> +\field{queue_notify_data} value instead of the virtqueue number.
>  \item If VIRTIO_F_NOTIFICATION_DATA has been negotiated, the driver MUST set the
>  \field{vqn} field to the \field{queue_notify_data} value.
>  \end{itemize}



Hmm OK.

Now here's another a problem:

\item[\field{queue_notify_data}]
        This field exists only if VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated.
        The driver will use this value to put it in the 'virtqueue number' field
        in the available buffer notification structure.

and I think it's actually \field{vqn} not 'virtqueue number':
	\item [vqn] VQ number to be notified.

and it also says

        In a trivial case the device can set \field{queue_notify_data}=vqn. Some devices
        may benefit from providing another value, for example an internal virtqueue
        identifier, or an internal offset related to the virtqueue number.

and that's backwards since vqn is always queue_notify_data.
What is meant is "set queue_notify_data to the virtqueue number'.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

