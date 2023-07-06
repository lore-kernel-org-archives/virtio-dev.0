Return-Path: <virtio-dev-return-13260-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B81EB64DD
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 16:28:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1E29A26A4E
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 16:28:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1623398680B
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 16:28:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 07AC5986728; Thu,  6 Jul 2023 16:28:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E9CEA98672A
	for <virtio-dev@lists.oasis-open.org>; Thu,  6 Jul 2023 16:28:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: JF8N1oC2NaG37XrsMgAPsQ-1
From: Cornelia Huck <cohuck@redhat.com>
To: Parav Pandit <parav@nvidia.com>, virtio-comment@lists.oasis-open.org,
 mst@redhat.com, david.edmondson@oracle.com
Cc: virtio-dev@lists.oasis-open.org, sburla@marvell.com,
 jasowang@redhat.com, yishaih@nvidia.com, maorg@nvidia.com,
 shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230706041714.65600-5-parav@nvidia.com>
Organization: Red Hat GmbH
References: <20230706041714.65600-1-parav@nvidia.com>
 <20230706041714.65600-5-parav@nvidia.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Thu, 06 Jul 2023 18:28:21 +0200
Message-ID: <87r0pluhqy.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [PATCH v10 4/4] transport-pci: Introduce group legacy group
 member config region access

On Thu, Jul 06 2023, Parav Pandit <parav@nvidia.com> wrote:

> diff --git a/transport-pci-legacy-regs.tex b/transport-pci-legacy-regs.tex
> new file mode 100644
> index 0000000..ceea28c
> --- /dev/null
> +++ b/transport-pci-legacy-regs.tex
> @@ -0,0 +1,42 @@
> +\subsection{Legacy Interface: Group member device Configuration Region Access}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / Legacy Interface: Group Member Device Configuration Region Access}
> +
> +The PCI owner device or the member device or both support driver notifications using

What about

"The PCI owner device, the member device, or both can choose to
support..." ?

> +a notification region defined in \field{struct virtio_pci_legacy_notify_region}.
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
> +The group owner device hardwires VF BAR0 to zero in the SR-IOV Extended
> +capability.
> +
> +The group member device does not use PCI BAR0 in all the Virtio PCI capabilities

"in [or for?] any of the...", I guess?

> +listed in section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities}.
> +
> +\devicenormative{\subsubsection}{Legacy Interface: Group Member Device Legacy Configuration Region Access}{Virtio Transport Options / Virtio Over PCI Bus / Legacy Interface: Group Member Device Configuration Region Access}
> +
> +When a PCI SR-IOV group owner device supports
> +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
> +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE, VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ,
> +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE commands, the group owner device MUST
> +hardwire VF BAR0 to zero in the SR-IOV Extended capability and the group memberi

s/memberi/member/

> +device MUST NOT use BAR0 in any of the Virtio Structure PCI Capabilities.
> +
> +The group owner device or the group member device or both MAY support driver
> +notifications region.

Make this "a driver notification region"?

> +
> +For the SR-IOV group type, the owner device supporting
> +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
> +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE, VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ,
> +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_QUERY
> +commands and its member device SHOULD follow the rules for the PCI Device ID,
> +Revision ID and Subsystem Device ID of the non-transitional devices documented in
> +section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery}.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

