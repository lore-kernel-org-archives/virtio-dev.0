Return-Path: <virtio-dev-return-12052-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 541B7C6FD1D
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 08:38:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B199E33594
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 08:38:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AAB9F9865EB
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 08:38:09 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9E57F983F7B; Fri,  7 Apr 2023 08:38:09 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8F8309865D7
	for <virtio-dev@lists.oasis-open.org>; Fri,  7 Apr 2023 08:38:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: HgsJj2f_MEukg_SB5LqBzQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680856683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mtb9CiJWugUeXG3y1gTusZYkF0xLB5fiqkRBGfkc5A=;
        b=ZbKVP1WPRH+QPtVjIY+GwwZlVWe2kcw3D/TI3OxPYiSDMizASwzXR/qVsIRxwROlsf
         uc1VIyBeFqENt2eXJgHS+JnmhBOqeUhov1cM9khA+kn3sQFS8zjeVvOL4KZsFb5bLfBV
         xcSZH6y1Lk6dOqyii7oBymbMj2ghI7BgxXxwTcLy4fv/2lS0N2C71j1C4x+REDOJKh6I
         q9ArYF2FCzoI6D2/j+HEinye1J7zseZ4WYWAy5BZtChAcwPsIrlSJaeoG9Zn5ACNAGii
         dZo8rUaXBTdo8gfT8gne771RQ27Gyet32hsRW6nsR2TF6/n4piF31adZXkpOy/gN+SDW
         bCIw==
X-Gm-Message-State: AAQBX9d/f4GE1An57tYvK9XsI2Vu4xpgDijUIiC+ogaUIy9+1LDZE1nM
	/5H+TxFQ79VSgnUz6Br1oSSoUKd5fUfT+RVtkfq8nEITSdt1S4rcupbnQFMCQ1NE7FeYkBE3ygW
	CfE7iLJAIHIzElhvAVsJXtcoEnax8
X-Received: by 2002:adf:fa8e:0:b0:2cf:e3d0:2a43 with SMTP id h14-20020adffa8e000000b002cfe3d02a43mr787180wrr.4.1680856683000;
        Fri, 07 Apr 2023 01:38:03 -0700 (PDT)
X-Google-Smtp-Source: AKy350YCGH2Nsb8c4hDTTvBQQmV+oNzWq27x/UmNtYmy+mjwma54yqSnCyHTlVA7HpItuGym7FT48A==
X-Received: by 2002:adf:fa8e:0:b0:2cf:e3d0:2a43 with SMTP id h14-20020adffa8e000000b002cfe3d02a43mr787166wrr.4.1680856682695;
        Fri, 07 Apr 2023 01:38:02 -0700 (PDT)
Date: Fri, 7 Apr 2023 04:37:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com,
	Satananda Burla <sburla@marvell.com>
Message-ID: <20230407041619-mutt-send-email-mst@kernel.org>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-8-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230330225834.506969-8-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH 07/11] transport-pci: Introduce transitional MMR device id

On Fri, Mar 31, 2023 at 01:58:30AM +0300, Parav Pandit wrote:
> Transitional MMR device PCI Device IDs are unique. Hence,
> any of the existing drivers do not bind to it.
> This further maintains the backward compatibility with
> existing drivers.
> 
> Co-developed-by: Satananda Burla <sburla@marvell.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>

This is IMO just too big a change: fundamentally this is a completely
new transport since no existing drivers can use this device at all. Not
a thing we should do lightly. And we have options on the table
such as AQ, which address most of the issue. Yes they do not
work for passthrough of a PF but that seems like a minor issue.
If we want to save the MMR idea, let's find a way to cut
down this patchset's size significantly.


On a more positive side, I do not really see a reason to
have a new ID at all. Device can have a normal device ID
and additionally the new capability.









> ---
>  transport-pci.tex | 45 +++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 41 insertions(+), 4 deletions(-)
> 
> diff --git a/transport-pci.tex b/transport-pci.tex
> index ee11ba5..665448e 100644
> --- a/transport-pci.tex
> +++ b/transport-pci.tex
> @@ -19,12 +19,14 @@ \section{Virtio Over PCI Bus}\label{sec:Virtio Transport Options / Virtio Over P
>  \subsection{PCI Device Discovery}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery}
>  
>  Any PCI device with PCI Vendor ID 0x1af4, and PCI Device ID 0x1000 through
> -0x107f inclusive is a virtio device. The actual value within this range
> -indicates which virtio device is supported by the device.
> +0x107f inclusive and DeviceID 0x10f9 through 0x10ff is a virtio device.
> +The actual value within this range indicates which virtio device
> +type it is.
>  The PCI Device ID is calculated by adding 0x1040 to the Virtio Device ID,
>  as indicated in section \ref{sec:Device Types}.
> -Additionally, devices MAY utilize a Transitional PCI Device ID range,
> -0x1000 to 0x103f depending on the device type.
> +Additionally, devices MAY utilize a Transitional PCI Device ID range
> +0x1000 to 0x103f inclusive or a Transitional MMR PCI Device ID range
> +0x10f9 to 0x10ff inclusive, depending on the device type.
>  
>  \devicenormative{\subsubsection}{PCI Device Discovery}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery}
>  
> @@ -95,6 +97,41 @@ \subsubsection{Legacy Interfaces: A Note on PCI Device Discovery}\label{sec:Virt
>  
>  This is to match legacy drivers.
>  
> +\subsubsection{Transitional MMR Interface: A Note on PCI Device
> +Discovery}\label{sec:Virtio Transport Options / Virtio Over PCI
> +Bus / PCI Device Discovery / Transitional MMR Interface: A Note on PCI Device Discovery}
> +
> +The transitional MMR device has one of the following PCI Device ID
> +depending on the device type:
> +
> +\begin{tabular}{|l|c|}
> +\hline
> +Transitional PCI Device ID  &  Virtio Device    \\
> +\hline \hline
> +0x10f9      &   network device     \\
> +\hline
> +0x10fa     &   block device     \\
> +\hline
> +0x10fb     & memory ballooning (traditional)  \\
> +\hline
> +0x10fc     &      console       \\
> +\hline
> +0x10fd     &     SCSI host      \\
> +\hline
> +0x10fe     &  entropy source    \\
> +\hline
> +0x10ff     &   9P transport     \\
> +\hline
> +\end{tabular}
> +
> +The PCI Subsystem Vendor ID and the PCI Subsystem Device ID MAY
> +reflect the PCI Vendor and Device ID of the environment.
> +
> +The transitional MMR driver MUST match any PCI Revision ID value.
> +
> +The transitional MMR driver MAY match any PCI Subsystem Vendor ID and
> +any PCI Subsystem Device ID value.
> +
>  \subsection{PCI Device Layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout}
>  
>  The device is configured via I/O and/or memory regions (though see
> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

