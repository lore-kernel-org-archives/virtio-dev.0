Return-Path: <virtio-dev-return-13281-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048FFEB64D9
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 19:00:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 62FF9755CA
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 19:00:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 52BE1986811
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 19:00:54 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3FB6598672D; Thu,  6 Jul 2023 19:00:54 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 27DFF986808
	for <virtio-dev@lists.oasis-open.org>; Thu,  6 Jul 2023 19:00:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: E3TINn4KOu-rDMh4bhe7Eg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688670050; x=1691262050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phXFWELZR+pCdQhAzyOKO7Sv3a6UJY5sLpWp83GyB6A=;
        b=jMBxXQFyhP6a+Ocakt9wfimyu7O/4y8HsKq7lKdBz1DQb1Ed6l5Yvc5TLLljojd+mM
         lOscY3aL4XY5u5IwJAyXnn1g4s16DdXaiX7VqjlEv8kOkLyzpc/HW5h5QXC+yeSUpHtn
         nhWLe9oobN4AID0Y3oX//4WGzlArDSPzNAjbMAa4OdeOh3tuM1r31vG6mEKiXc17L9Un
         E7JKC1YVfqnnIipB7dUKzqokkDoihkl8tGXtUyTILejbWXB1ZCz0WGSwCsJKIKwiDCWm
         sPcZ9mPdQEEKozAXgJR526L3TFNBIJg461SIIeRoEUo9IuadKCRlQDblbAwFUvhSMy3p
         NbPg==
X-Gm-Message-State: ABy/qLbvNpwRACPF2Ili3+oK2X0LSQ9B2jYBK+cKQPGh+qI2Izcku7KJ
	jXZarbxYmPd8TvlHVO1IvWDzrg4/aAisw2gPTTnXm/qnEfU0ofxiDpKfwhCQvR5Rdr5ky336WFJ
	/OPPiK1+iA5agP6DGn4QAO6Q5M2NA
X-Received: by 2002:a1c:cc02:0:b0:3fb:4064:7e22 with SMTP id h2-20020a1ccc02000000b003fb40647e22mr2764861wmb.19.1688670050055;
        Thu, 06 Jul 2023 12:00:50 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEJLske6C2gEIHZPyHmaMvWG43DWNE2DzpZuUQP3a/C1kPZWBtVUb9MU6W04/CN4D0Di4rDtA==
X-Received: by 2002:a1c:cc02:0:b0:3fb:4064:7e22 with SMTP id h2-20020a1ccc02000000b003fb40647e22mr2764839wmb.19.1688670049707;
        Thu, 06 Jul 2023 12:00:49 -0700 (PDT)
Date: Thu, 6 Jul 2023 15:00:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-comment@lists.oasis-open.org, cohuck@redhat.com,
	david.edmondson@oracle.com, virtio-dev@lists.oasis-open.org,
	sburla@marvell.com, jasowang@redhat.com, yishaih@nvidia.com,
	maorg@nvidia.com, shahafs@nvidia.com
Message-ID: <20230706145646-mutt-send-email-mst@kernel.org>
References: <20230706041714.65600-1-parav@nvidia.com>
 <20230706041714.65600-5-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230706041714.65600-5-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v10 4/4] transport-pci: Introduce group legacy group
 member config region access

On Thu, Jul 06, 2023 at 07:17:14AM +0300, Parav Pandit wrote:
> This patch links how in a PCI transport a group owner can access group
> member (PCI VFs) legacy registers using a legacy registers access
> commands using administration virtqueue infrastructure.
> 
> Additionally it extend the PCI notification capability through which a
> PCI VF device indicates to the driver which PCI BAR region to be used
> for driver notifications.
> 
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/167
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
> changelog:
> v9->v10:
> - addressed comments from Cornelia
> - fixed errors related to article
> - hardwire to hardwires
> - replaced various to all
> - added hardwire to zero
> v7->v8:
> - addressed comments from Michael
> - made bar offset 64-bit
> - prefix legacy specific structure with _legacy
> - moved generic normative from pci to generic section
> - added link to virtio pci capabilities when referring to bar 0
> - remove 'should' from generic description
> v6->v7:
> - addressed comments from Michael
> - removed driver normative about I/O BAR emulation as it does not
>   make much sense for the spec
> - removed references to administration virtqueue
> - rewrote driver legacy region access without guest and hypervisor
>   wording
> - added normative for notification region
> - added normative for PCI IDs for device which support legacy commands
> v5->v6:
> - aligned pci capability to 4B as required by PCI spec
> - added text for the PCI capability for the group member device
> v4->v5:
> - split pci transport and generic command section to new patch
> - removed multiple references to the VF
> - written the description of the command as generic with member
>   and group device terminology
> - reflected many section names to remove VF
> v3->v4:
> - moved noted to the conformance section details in next patch
> - removed queue notify address query AQ command on Michael's suggestion,
>   though it is fine. Instead replaced with extending virtio_pci_notify_cap
>   to indicate that legacy queue notifications can be done on the
>   notification location.
> - fixed spelling errors.
> - replaced administrative virtqueue to administration virtqueue
> - added queue notification capability register to indicate legacy q
>   notification supported
> v2->v3:
> - adddressed Jason and Michael's comment to split single register
>   access command to common config and device specific commands.
> - dropped the suggetion to introduce enable/disable command as
>   admin command cap bit already covers it.
> v1->v2:
> - addressed comments from Michael
> - added theory of operation
> - grammar corrections
> - removed group fields description from individual commands as
>   it is already present in generic section
> - added endianness normative for legacy device registers region
> - renamed the file to drop vf and add legacy prefix
> 
> - added overview in commit log
> - renamed subsection to reflect command
> ---
>  admin-cmds-legacy-interface.tex |  3 ++-
>  conformance.tex                 |  1 +
>  transport-pci-legacy-regs.tex   | 42 +++++++++++++++++++++++++++++++++
>  transport-pci.tex               |  2 ++
>  4 files changed, 47 insertions(+), 1 deletion(-)
>  create mode 100644 transport-pci-legacy-regs.tex
> 
> diff --git a/admin-cmds-legacy-interface.tex b/admin-cmds-legacy-interface.tex
> index dd01c0a..e67632b 100644
> --- a/admin-cmds-legacy-interface.tex
> +++ b/admin-cmds-legacy-interface.tex
> @@ -187,7 +187,8 @@ \subsubsection{Legacy Interfaces}\label{sec:Basic Facilities of a Virtio Device
>  by the device.
>  
>  Refer to the specific transport section for the definition of the
> -\field{data}.
> +\field{data}. For the PCI transport refer to section
> +\ref{sec:Virtio Transport Options / Virtio Over PCI Bus / Legacy Interface: Group Member Device Configuration Region Access}.
>  
>  This command is currently only defined for the SR-IOV group type.
>  
> diff --git a/conformance.tex b/conformance.tex
> index dc00e84..b3f2c92 100644
> --- a/conformance.tex
> +++ b/conformance.tex
> @@ -267,6 +267,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>  \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy Interfaces: A Note on PCI Device Layout}
>  \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / Virtio Device Configuration Layout Detection / Legacy Interface: A Note on Device Layout Detection}
>  \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / Virtqueue Configuration / Legacy Interface: A Note on Virtqueue Configuration}
> +\item Section \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / Legacy Interface: Group Member Device Configuration Region Access}
>  \item Section \ref{sec:Virtio Transport Options / Virtio Over MMIO / Legacy interface}
>  \item Section \ref{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Setting the Virtio Revision / Legacy Interfaces: A Note on Setting the Virtio Revision}
>  \item Section \ref{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Configuring a Virtqueue / Legacy Interface: A Note on Configuring a Virtqueue}
> diff --git a/transport-pci-legacy-regs.tex b/transport-pci-legacy-regs.tex
> new file mode 100644
> index 0000000..ceea28c
> --- /dev/null
> +++ b/transport-pci-legacy-regs.tex
> @@ -0,0 +1,42 @@
> +\subsection{Legacy Interface: Group member device Configuration Region Access}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / Legacy Interface: Group Member Device Configuration Region Access}
> +
> +The PCI owner device or the member device or both support driver notifications using
> +a notification region defined in \field{struct virtio_pci_legacy_notify_region}.
> +
> +In \field{struct virtio_virtio_admin_cmd_legacy_notify_query_entry},
> +\field{region_data} is defined as following:
> +
> +\begin{lstlisting}
> +struct virtio_pci_legacy_notify_region {
> +        u8 owner;  /* When set to 1, notification region is of the owner device */

I propose we rename this to flags:
	0x0 - end of list (driver should ignore following values until end of list)
	0x1 - owner
	0x2 - member
other values - reserved

and prescribe that driver ignores any reserved values.

basically we are following how the virtio capabilities work.




> +        u8 bar;    /* BAR of the member or owner device */
> +        u8 padding[6];
> +        le64 offset; /* Offset within bar. */
> +};
> +\end{lstlisting}
> +
> +The group owner device hardwires VF BAR0 to zero in the SR-IOV Extended
> +capability.
> +
> +The group member device does not use PCI BAR0 in all the Virtio PCI capabilities
> +listed in section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities}.

Just drop this last one. How can they use it if there's no VF BAR0?


> +
> +\devicenormative{\subsubsection}{Legacy Interface: Group Member Device Legacy Configuration Region Access}{Virtio Transport Options / Virtio Over PCI Bus / Legacy Interface: Group Member Device Configuration Region Access}
> +
> +When a PCI SR-IOV group owner device supports
> +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
> +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE, VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ,
> +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE commands, the group owner device MUST
> +hardwire VF BAR0 to zero in the SR-IOV Extended capability and the group memberi
> +device MUST NOT use BAR0 in any of the Virtio Structure PCI Capabilities.
> +
> +The group owner device or the group member device or both MAY support driver
> +notifications region.
> +
> +For the SR-IOV group type, the owner device supporting
> +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
> +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE, VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ,
> +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_QUERY
> +commands and its member device SHOULD follow the rules for the PCI Device ID,
> +Revision ID and Subsystem Device ID of the non-transitional devices documented in
> +section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery}.
> diff --git a/transport-pci.tex b/transport-pci.tex
> index a5c6719..72c78f6 100644
> --- a/transport-pci.tex
> +++ b/transport-pci.tex
> @@ -1212,3 +1212,5 @@ \subsubsection{Driver Handling Interrupts}\label{sec:Virtio Transport Options /
>          re-examine the configuration space to see what changed.
>      \end{itemize}
>  \end{itemize}
> +
> +\input{transport-pci-legacy-regs.tex}
> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

