Return-Path: <virtio-dev-return-13233-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413BAEB64DA
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Jul 2023 10:56:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 88BA97C66D
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Jul 2023 10:56:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 68F6D986726
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Jul 2023 10:56:37 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4EF10986712; Wed,  5 Jul 2023 10:56:37 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3B5EA98671A
	for <virtio-dev@lists.oasis-open.org>; Wed,  5 Jul 2023 10:56:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: Nm8wSREfNEyGBY1-3KbGjQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688554593; x=1691146593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TR4EPXg9WcyaG5wC84m2pi84hgHJOML3TK1YrWNh/Ug=;
        b=dkCf8vVXVqPIzU+gDB0McssoBSR+89NsvAjam19pM8bG+Xx+ZP9H3Zo1lf0ID5YZP0
         JyvwcMJ/d4rKULxeU7qjH1nJrHO2uKDeoFOZBejpYyicK0kd0GzkCFRIQ/21DE7YupKd
         pUHZRGr/09HCWQv5AJ/OjuSr9ovlHn4DMxSrN3EIfzh2mbKZzyl+QNTch2rjSSK2xlp+
         PN9ttSFwReyccHr+0OD/2TorUIjWpWBAlZCRexR/MAm+0WBOSuI4w9FVf1+giZIywYk1
         6IqFUURaGyL8HKA/bRaDn3EK0itQDGb+0qxMkIpTsjG1FuAvnixiAAQ+kSmgh59fLnT6
         1B9Q==
X-Gm-Message-State: ABy/qLbY79fy7X3wb9GFQFOaogsT914RhZCQvPLm6EcHHqNiPeGHbsi3
	AsCwi2eZrTDeV8pXUZYMnyylFrNL/Vo3xgMtuQlz5ZZJuqDgh2sfxO3wfLqcqXmaaa6kxtust30
	Yd847ydFGGTSfRciBc+WHILScd5wV
X-Received: by 2002:adf:e405:0:b0:314:a3f:9c08 with SMTP id g5-20020adfe405000000b003140a3f9c08mr12605182wrm.39.1688554593625;
        Wed, 05 Jul 2023 03:56:33 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFZ/LDqv0CQ0bwqKpK2mq2XaAAGaZHMSPEp4K0I+UPx3C9WkRK/KtFc7Zorf1znUVaXAOaVhw==
X-Received: by 2002:adf:e405:0:b0:314:a3f:9c08 with SMTP id g5-20020adfe405000000b003140a3f9c08mr12605162wrm.39.1688554593229;
        Wed, 05 Jul 2023 03:56:33 -0700 (PDT)
Date: Wed, 5 Jul 2023 06:56:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-comment@lists.oasis-open.org, cohuck@redhat.com,
	david.edmondson@oracle.com, virtio-dev@lists.oasis-open.org,
	sburla@marvell.com, jasowang@redhat.com, yishaih@nvidia.com,
	maorg@nvidia.com, shahafs@nvidia.com
Message-ID: <20230705065522-mutt-send-email-mst@kernel.org>
References: <20230704233724.22394-1-parav@nvidia.com>
 <20230704233724.22394-5-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230704233724.22394-5-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v9 4/4] transport-pci: Introduce group
 legacy group member config region access

On Wed, Jul 05, 2023 at 02:37:24AM +0300, Parav Pandit wrote:
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
>  admin-cmds-legacy-interface.tex |  2 +-
>  conformance.tex                 |  1 +
>  transport-pci-legacy-regs.tex   | 41 +++++++++++++++++++++++++++++++++
>  transport-pci.tex               |  2 ++
>  4 files changed, 45 insertions(+), 1 deletion(-)
>  create mode 100644 transport-pci-legacy-regs.tex
> 
> diff --git a/admin-cmds-legacy-interface.tex b/admin-cmds-legacy-interface.tex
> index 09001d5..571b256 100644
> --- a/admin-cmds-legacy-interface.tex
> +++ b/admin-cmds-legacy-interface.tex
> @@ -150,7 +150,7 @@ \subsubsection{Legacy Interfaces}\label{sec:Basic Facilities of a Virtio Device
>  by the device.
>  
>  Refer to the specific transport section for the definition of the
> -\field{region_data}.
> +\field{region_data}. For PCI transport refer to section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / Legacy Interface: Group Member Device Configuration Region Access}.
>  
>  This command is currently only defined for the PCI SR-IOV group type.
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
> index 0000000..e4f70c9
> --- /dev/null
> +++ b/transport-pci-legacy-regs.tex
> @@ -0,0 +1,41 @@
> +\subsection{Legacy Interface: Group member device Configuration Region Access}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / Legacy Interface: Group Member Device Configuration Region Access}
> +
> +The PCI owner device or the member device or both supports driver notifications using
> +a notification region defined in the \field{struct virtio_pci_notify_region}.
> +
> +In \field{struct virtio_virtio_admin_cmd_legacy_notify_query_entry},
> +\field{region_data} is defined as following:
> +
> +\begin{lstlisting}
> +struct virtio_pci_legacy_notify_region {
> +        u8 owner;  /* When set to 1, notification region is of the owner device */
> +        u8 bar;    /* BAR of the member or owner device */
> +        u8 padding[6];
> +        le64 offset; /* Offset within bar. */
> +};
> +\end{lstlisting}
> +
> +The group owner device hardwire VF BAR0 in the SR-IOV Extended capability.
> +
> +The group member device does not use PCI BAR0 in various Virtio PCI capabilities
> +listed in section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities}.
> +
> +\devicenormative{\subsubsection}{Legacy Interface: Group Member Device Legacy Configuration Region Access}{Virtio Transport Options / Virtio Over PCI Bus / Legacy Interface: Group Member Device Configuration Region Access}
> +
> +When a PCI SR-IOV group owner device supports
> +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
> +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE, VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ,
> +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE commands, the group owner device MUST
> +hardwire VF BAR0 in the SR-IOV Extended capability and the group member device
> +MUST NOT use BAR0 in any of the Virtio Structure PCI Capabilities.
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

This is completely apropos rien here.

Include this from admin.tex for now pls.



> -- 
> 2.26.2
> 
> 
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
> 
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
> 
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/
> 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

