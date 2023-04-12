Return-Path: <virtio-dev-return-12167-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E0BBC7619A
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 04:31:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 671032B01B
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 04:31:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5817298650F
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 04:31:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 44D2A9864B3; Wed, 12 Apr 2023 04:31:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 338C0986509
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Apr 2023 04:31:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: VJq7Pvq6NjGUp5j37643KQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681273878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zaa83pC8CIqsQkq9wj1coypM3DxmF6CONRK+crZeBTc=;
        b=y8TNjhVckz0aEXsZEPde6e60hz3Y4lx9PQ46njp9okx/NbJlbGELgNOk0n1N4thZUE
         IyZoRmHdtExG6zns+vDxSY5lDVp1NchfGaPqdEX5e9L460y7Kry/7IkNyNZlpzvAHSQo
         TzDnbGkho0lhn9ILyw4ASfJXtdLrFd2+RFz05QC3IT1ghiSgbDYz0kxFa8YoXjpMvCjj
         7nq+Xd4p5WZx1eelmk9sxO0SPWY4WFi2Bjq2BmcrStF2NK7RW7kIw00zz5mC9vJdxll6
         BF0y4ivj8DaJDDC9oA5IP13XA4ykwig8GG236ZoJdnARKlac6COXnHQiCcgtV+QE2vKi
         qYEw==
X-Gm-Message-State: AAQBX9cfB0hmIPxAHknNx2MuRBsus+KHAcIYnr4/2yFYSBVJ0vBKV6ZH
	Bz2f3JZmagJXx1rgfwBvxKATze0IW/PUwyiGLki4XDTTm1nsiuX/JZlSRQLMrwi7T0RbWk3q5Gi
	VHrzvnlWdePu2L8lNm9k41DRH7fHv
X-Received: by 2002:a05:600c:2148:b0:3ed:f9d3:f95c with SMTP id v8-20020a05600c214800b003edf9d3f95cmr8850547wml.19.1681273878756;
        Tue, 11 Apr 2023 21:31:18 -0700 (PDT)
X-Google-Smtp-Source: AKy350aDA4uCL6CN+M7S8FMse76+rytlpPSY6zhbD+0MvmBL6SCzM/5QZOl5DXnBWIiSr9BZ3tYsRw==
X-Received: by 2002:a05:600c:2148:b0:3ed:f9d3:f95c with SMTP id v8-20020a05600c214800b003edf9d3f95cmr8850537wml.19.1681273878478;
        Tue, 11 Apr 2023 21:31:18 -0700 (PDT)
Date: Wed, 12 Apr 2023 00:31:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com,
	Satananda Burla <sburla@marvell.com>
Message-ID: <20230412003006-mutt-send-email-mst@kernel.org>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-11-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230330225834.506969-11-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH 10/11] transport-pci: Use driver notification PCI
 capability

On Fri, Mar 31, 2023 at 01:58:33AM +0300, Parav Pandit wrote:
> PCI devices support memory BAR regions for performant driver
> notifications using the notification capability.
> Enable transitional MMR devices to use it in simpler manner.
> 
> Co-developed-by: Satananda Burla <sburla@marvell.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
>  transport-pci.tex | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/transport-pci.tex b/transport-pci.tex
> index 55a6aa0..4fd9898 100644
> --- a/transport-pci.tex
> +++ b/transport-pci.tex
> @@ -763,6 +763,34 @@ \subsubsection{Notification structure layout}\label{sec:Virtio Transport Options
>  cap.length >= queue_notify_off * notify_off_multiplier + 4
>  \end{lstlisting}
>  
> +\paragraph{Transitional MMR Interface: A note on Notification Capability}
> +\label{sec:Virtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities / Notification capability / Transitional MMR Interface}
> +
> +The transitional MMR device benefits from receiving driver
> +notifications at the Queue Notification address offered using
> +the notification capability, rather than via the memory mapped
> +legacy QueueNotify configuration register.
> +
> +Transitional MMR device uses same Queue Notification address
> +within a BAR for all virtqueues:
> +\begin{lstlisting}
> +cap.offset
> +\end{lstlisting}
> +
> +The transitional MMR device MUST support Queue Notification
> +address within a BAR for all virtqueues at:
> +\begin{lstlisting}
> +cap.offset
> +\end{lstlisting}
> +
> +The transitional MMR driver that wants to use driver
> +notifications offered using notification capability MUST use
> +same Queue Notification address within a BAR for all virtqueues at:
> +
> +\begin{lstlisting}
> +cap.offset
> +\end{lstlisting}
> +
>  \subsubsection{ISR status capability}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / ISR status capability}
>  
>  The VIRTIO_PCI_CAP_ISR_CFG capability

Why? What exactly is going on here? legacy drivers will
not do this.

> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

