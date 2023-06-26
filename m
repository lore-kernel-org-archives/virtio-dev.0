Return-Path: <virtio-dev-return-13080-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8DBEB64DC
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Jun 2023 09:33:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 583B13E32D
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Jun 2023 09:33:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4E076986413
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Jun 2023 09:33:00 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 40BD398636F; Mon, 26 Jun 2023 09:33:00 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3042E986383
	for <virtio-dev@lists.oasis-open.org>; Mon, 26 Jun 2023 09:33:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: Pg-PPsu4MAyPiHVlATUCUg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687771973; x=1690363973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qO8FTPE5QO+YMIqZNbs7uMRrliKhjUq7TL5sMeoiYS4=;
        b=EQ6arW58BAFGGmwhwkqtByfh31QLBbv8RByiUAbbN8raySxSp/8/P2uc8kRXu9Rq0D
         DB28514dO4y1833dnqRzVwcuEJrgH3/RR1cWPrMNxEbCUjW8+Ug47wIyrclZxlEv8s6h
         CqBi3Cbixqo2EUng9QFk+2osWce09m7q3u//URk39LV20CBeTSQkyYh7zPw3Q48BK9ro
         uZEMZXMo0TxsnShesbWWGiYEL3SiB17aJbBqXdCbYjWMwiazNJUYRNH8slng+fzYw8r8
         AFNv/6NeB0G9ZcEICfbQSgcjeJXcnbjh72EwXgF8Iyaya9GLgYcJhW6jr0BzXelBMGGo
         RHIw==
X-Gm-Message-State: AC+VfDymSzrRSF6CBfJqKTR+BJV8KmsATO47xQ3g1/BzC+JoyDt9ZG6P
	aFM4a0uPiPoIZTLBjhE+99CBtMbTkUbe7HtnKZRo5TZQtcIX/xUr/k3J9+EOeCyzxNzaWlTQFKd
	czpyiPae068q9SJvGijWr58pIfE5F
X-Received: by 2002:a05:600c:2182:b0:3fa:79af:15c8 with SMTP id e2-20020a05600c218200b003fa79af15c8mr7295099wme.23.1687771972951;
        Mon, 26 Jun 2023 02:32:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ukfPtR44+aTHIYmNzYIK5aNWQU5ToR4gRDp56tlcihhpaBFQqteTxbCbPEiSg/FvtcrxNTQ==
X-Received: by 2002:a05:600c:2182:b0:3fa:79af:15c8 with SMTP id e2-20020a05600c218200b003fa79af15c8mr7295091wme.23.1687771972577;
        Mon, 26 Jun 2023 02:32:52 -0700 (PDT)
Date: Mon, 26 Jun 2023 05:32:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	parav@nvidia.com
Message-ID: <20230626031704-mutt-send-email-mst@kernel.org>
References: <20230626062210.49020-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20230626062210.49020-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [RFC PATCH] admin-queue: bind the group member to the device

On Mon, Jun 26, 2023 at 02:22:10PM +0800, Xuan Zhuo wrote:
> The VFs of the SR-IOV are created by the user inside the guest OS, so the virtio
> devices don't know about these VFs. Because each VF may be assigned a different role
> by the user, the virtio device can not choose one VF to bind random.
> So only the user knows how to bind the virtio devices to the VFs.
> On the other hand, generally the virtio devices are not created by the user
> inside the guest OS. This requires some management platform to participate.
> 
> So the usage of this command:
> 1. The user purchases a virtio network card on the management platform,
>    and sets the ip, queue number, etc. The user obtains the identity of
>    the network card.
> 2. The user creates a VF with echo 8 > sriov_numvfs

this one is unlikely, as this requires PF access and affects all VFs.

> 3. The user binds the net crad to a VF with identity through the command
>    of the patch
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>




> ---
>  admin.tex | 41 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/admin.tex b/admin.tex
> index 2efd4d7..64d0667 100644
> --- a/admin.tex
> +++ b/admin.tex
> @@ -115,7 +115,8 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
>  \hline \hline
>  0x0000 & VIRTIO_ADMIN_CMD_LIST_QUERY & Provides to driver list of commands supported for this group type    \\
>  0x0001 & VIRTIO_ADMIN_CMD_LIST_USE & Provides to device list of commands used for this group type \\
> -0x0002 - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}    \\
> +0x0002 & VIRTIO_ADMIN_CMD_BIND_DEVICE & Bind the device to one group member \\
> +0x0003 - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}    \\
>  \hline
>  0x8000 - 0xFFFF & - & Reserved for future commands (possibly using a different structure)    \\
>  \hline
> @@ -429,6 +430,44 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
>  \field{VF Enable} refer to registers within the SR-IOV Extended
>  Capability as specified by \hyperref[intro:PCIe]{[PCIe]}.
>  
> +\subsubsection{Bind the device for member}
> +
> +The VFs of the SR-IOV are created by the user inside the guest OS, so the virtio
> +devices don't know about these VFs.

I don't really get how.

> Because each VF may be assigned a different role
> +by the user, the virtio device can not choose one VF to bind random.
> +So only the user knows how to bind the virtio devices to the VFs.
> +On the other hand, generally the virtio devices are not created by the user
> +inside the guest OS. This requires some management platform to participate.
> +
> +So we introduce a new admin queue command to bind the VFs and the virtio
> +devices.

This description needs a complete rewrite, but to try to help you I'd
need to figure out what is being said. My guess is that this is an
attempt to introduce some kind of identity to VFs.  OK but what is this
identity and how is it better than using VF#?  You want it to persist
when NumVFs in the SR-IOV capability changes?

> +\begin{lstlisting}
> +struct virtio_admin_cmd_bind {
> +    u64 identity;
> +};
> +\end{lstlisting}
> +
> +The user got the \field{identity} from the management platform, that is not
> +included by this spec.

Without even understanding the above, what I don't like about this
proposal, is that it assumes some out of band interface to either
specify or discover these IDs. With admin commands we now have
ability to fully specify a management interface, and I'd rather
we had a complete proposal covering all aspects of it.
If some platform does not want to use the management aspects,
that's ok.

> +
> +\drivernormative{\paragraph}{Group administration commands}{Basic Facilities of a Virtio Device / Device groups / Group administration commands / Bind the device for member}
> +
> +VIRTIO_ADMIN_CMD_BIND_DEVICE requires that the \field{group_member_id} MUST be set.
> +
> +The \field{identity} is passed by the user. It is the identity of the virtio
> +device.
> +
> +\devicenormative{\paragraph}{Group administration commands}{Basic Facilities of a Virtio Device / Device groups / Group administration commands / Bind the device for member}
> +
> +Every device MUST have one unique \field{identity} in the host.
> +
> +If the PF device can not find the device by the \field{identity},
> +the \field{status} MUST be set to VIRTIO_ADMIN_STATUS_EINVAL.
> +
> +If the device is found by the \field{identity}, the device MUST work as the
> +device of this group member specified by the \field{group_member_id}.
> +
>  \section{Administration Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Administration Virtqueues}
>  
>  An administration virtqueue of an owner device is used to submit

> -- 
> 2.32.0.3.g01195cf9f


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

