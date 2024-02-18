Return-Path: <virtio-dev-return-14329-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25915C48BF6
	for <virtio-dev@archiver.kernel.org>; Sun, 18 Feb 2024 14:11:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 658EAEE29B
	for <virtio-dev@archiver.kernel.org>; Sun, 18 Feb 2024 14:11:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 525F3986189
	for <virtio-dev@archiver.kernel.org>; Sun, 18 Feb 2024 14:11:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 459D1986144; Sun, 18 Feb 2024 14:11:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3033498614B
	for <virtio-dev@lists.oasis-open.org>; Sun, 18 Feb 2024 14:11:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: N9cJjYXSPCyDCaKzrQVwrw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708265483; x=1708870283;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GpFK/MBP9Xla7BGGcIZAuTfTqNwqtOosvl2kSOghBNY=;
        b=CeRh8iTtjEeruOAgDPD6RKgqHc/oTr+1/u/omCk3GBkSwY/iUN0yPMj++G1n+6y3/u
         BCJ3L9f/p5RygfDQZyuxXffGHqMvEibxhN5srhEpt0IsbOczPn7GqQoOffP55g4EdvPD
         g+19U0GWnkCiICPThFhW6gFSpecPweXbW1VL21ES4eHuzqsjT25J3KFCFrSJ8Ptpxj+O
         MExyws72KpMBL7O3rw7lLCKCqOWzkMGpG9OB3xKrM/VCriAbDRu29Mp+tMAK8trZ+Ko1
         yYk3T7RaKiPdfTBp6Yi9SFsovO6FaCMZvbbDRO2cu/546La65SUbm8GnsvM8sJaOCFRQ
         5Pfw==
X-Forwarded-Encrypted: i=1; AJvYcCUbctR8A+3pXQQlGXBSEQWUtpW7zzW+QIua3evCRNeR280ZXgje0nLQmZ69QioT61VMvHCGJoEb9DXWSbr9DnbQeg7fkMCCanSZXBshC1rx
X-Gm-Message-State: AOJu0Yxjrws3DkQ+1+9tj1GkBt2t8l7JI2hUOKbonUN5wKupI9sDN8L9
	zK7NHHfNnIJ/q05A7Pn6zsdaTNDzN0v9gLNoa5V+4SYCVEz92HADsxSQQDV9sMVgFAJKihFDfsM
	o0uzIb7HbNceGEx3pDbYkRsAa+h4zC3SuwTTRuBemNqA9V0++fqcITeaZCrstbDDiDg==
X-Received: by 2002:a2e:9a81:0:b0:2d0:c17c:e478 with SMTP id p1-20020a2e9a81000000b002d0c17ce478mr6737602lji.42.1708265482824;
        Sun, 18 Feb 2024 06:11:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFo097a/Oymw51E3Qe8arCd+IYhk42U6bHCi3ES9X4DwBMZI/O6Lb2o0mHl69tgr1R533NcFA==
X-Received: by 2002:a2e:9a81:0:b0:2d0:c17c:e478 with SMTP id p1-20020a2e9a81000000b002d0c17ce478mr6737589lji.42.1708265482380;
        Sun, 18 Feb 2024 06:11:22 -0800 (PST)
Date: Sun, 18 Feb 2024 09:11:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: jasowang@redhat.com, eperezma@redhat.com, cohuck@redhat.com,
	stefanha@redhat.com, virtio-comment@lists.oasis-open.org,
	stevensd@chromium.org, virtio-dev@lists.oasis-open.org
Message-ID: <20240218090935-mutt-send-email-mst@kernel.org>
References: <20240218132306.83456-1-lingshan.zhu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20240218132306.83456-1-lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH] virtio: introduce SUSPEND bit in device status

On Sun, Feb 18, 2024 at 09:23:06PM +0800, Zhu Lingshan wrote:
> This commit allows the driver to suspend the device by
> introducing a new status bit SUSPEND in device_status.
> 
> This commit also introduce a new feature bit VIRTIO_F_SUSPEND
> which indicating whether the device support SUSPEND.
> 
> This SUSPEND bit is transport-independent.
> 
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>



Could we get some kind of dscription how this has taken into
consideration the proposal from David Stevens?

I find it really tiring when there are competing patches with authors
ignoring each other's work and leaving it up to reviewers to
figure out how do the patches compare.

> ---
>  content.tex | 34 ++++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/content.tex b/content.tex
> index 0a62dce..3d656b5 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -49,6 +49,9 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
>  
>  \item[DEVICE_NEEDS_RESET (64)] Indicates that the device has experienced
>    an error from which it can't recover.
> +
> +\item[SUSPEND (16)] When VIRTIO_F_SUSPEND is negotiated, indicates that the
> +  device has been suspended by the driver.
>  \end{description}
>  
>  The \field{device status} field starts out as 0, and is reinitialized to 0 by
> @@ -73,6 +76,10 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
>  recover by issuing a reset.
>  \end{note}
>  
> +The driver SHOULD NOT set SUSPEND if FEATURES_OK is not set.
> +
> +When setting SUSPEND, the driver MUST re-read \field{device status} to ensure the SUSPEND bit is set.
> +
>  \devicenormative{\subsection}{Device Status Field}{Basic Facilities of a Virtio Device / Device Status Field}
>  
>  The device MUST NOT consume buffers or send any used buffer
> @@ -82,6 +89,25 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
>  that a reset is needed.  If DRIVER_OK is set, after it sets DEVICE_NEEDS_RESET, the device
>  MUST send a device configuration change notification to the driver.
>  
> +The device MUST ignore SUSPEND if FEATURES_OK is not set.
> +
> +The device MUST ignore SUSPEND if VIRTIO_F_SUSPEND is not negotiated.
> +
> +The device SHOULD allow settings to \field{device status} even when SUSPEND is set.
> +
> +If VIRTIO_F_SUSPEND is negotiated and SUSPEND is set, the device SHOULD clear SUSPEND
> +and resumes operation upon DRIVER_OK.
> +
> +If VIRTIO_F_SUSPEND is negotiated, when the driver sets SUSPEND,
> +the device SHOULD perform the following actions before presenting SUSPEND bit in the \field{device status}:
> +
> +\begin{itemize}
> +\item Stop consuming buffers of any virtqueues and mark all finished descriptors as used.
> +\item Wait until all descriptors that being processed to finish and mark them as used.
> +\item Flush all used buffer and send used buffer notifications to the driver.
> +\item Pause its operation except \field{device status} and preserve configurations in its Device Configuration Space, see \ref{sec:Basic Facilities of a Virtio Device / Device Configuration Space}
> +\end{itemize}
> +
>  \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature Bits}
>  
>  Each virtio device offers all the features it understands.  During
> @@ -99,10 +125,10 @@ \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature B
>  \begin{description}
>  \item[0 to 23, and 50 to 127] Feature bits for the specific device type
>  
> -\item[24 to 41] Feature bits reserved for extensions to the queue and
> +\item[24 to 42] Feature bits reserved for extensions to the queue and
>    feature negotiation mechanisms
>  
> -\item[42 to 49, and 128 and above] Feature bits reserved for future extensions.
> +\item[43 to 49, and 128 and above] Feature bits reserved for future extensions.
>  \end{description}
>  
>  \begin{note}
> @@ -872,6 +898,10 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>  	\ref{devicenormative:Basic Facilities of a Virtio Device / Feature Bits} for
>  	handling features reserved for future use.
>  
> +  \item[VIRTIO_F_SUSPEND(42)] This feature indicates that the driver can
> +   SUSPEND the device.
> +   See \ref{sec:Basic Facilities of a Virtio Device / Device Status Field}.
> +
>  \end{description}
>  
>  \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
> -- 
> 2.35.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

