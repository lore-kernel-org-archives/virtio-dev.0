Return-Path: <virtio-dev-return-13232-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABEDDC001B0
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Jul 2023 10:29:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0812069F90
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Jul 2023 10:29:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EE5A0986728
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Jul 2023 10:29:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E23C3986718; Wed,  5 Jul 2023 10:29:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D13E898671B
	for <virtio-dev@lists.oasis-open.org>; Wed,  5 Jul 2023 10:29:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: dk7I4cjLPs-jtySIvLjoCw-1
From: Cornelia Huck <cohuck@redhat.com>
To: Parav Pandit <parav@nvidia.com>, virtio-comment@lists.oasis-open.org,
 mst@redhat.com, david.edmondson@oracle.com
Cc: virtio-dev@lists.oasis-open.org, sburla@marvell.com,
 jasowang@redhat.com, yishaih@nvidia.com, maorg@nvidia.com,
 shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230704233724.22394-5-parav@nvidia.com>
Organization: Red Hat GmbH
References: <20230704233724.22394-1-parav@nvidia.com>
 <20230704233724.22394-5-parav@nvidia.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Wed, 05 Jul 2023 12:29:26 +0200
Message-ID: <87cz163b3t.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [PATCH v9 4/4] transport-pci: Introduce group legacy group
 member config region access

On Wed, Jul 05 2023, Parav Pandit <parav@nvidia.com> wrote:

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

"For the PCI transport, refer to..."

>  
>  This command is currently only defined for the PCI SR-IOV group type.
>  

(...)

> diff --git a/transport-pci-legacy-regs.tex b/transport-pci-legacy-regs.tex
> new file mode 100644
> index 0000000..e4f70c9
> --- /dev/null
> +++ b/transport-pci-legacy-regs.tex
> @@ -0,0 +1,41 @@
> +\subsection{Legacy Interface: Group member device Configuration Region Access}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / Legacy Interface: Group Member Device Configuration Region Access}
> +
> +The PCI owner device or the member device or both supports driver notifications using

s/supports/support/

> +a notification region defined in the \field{struct virtio_pci_notify_region}.

s/in the/in/

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

s/hardwire/hardwires/

> +
> +The group member device does not use PCI BAR0 in various Virtio PCI capabilities

"in the various" caps? Or "in some of the" caps?

> +listed in section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities}.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

