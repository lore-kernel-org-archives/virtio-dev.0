Return-Path: <virtio-dev-return-11959-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE4AC6FD1D
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 07:35:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 90B742B039
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 07:35:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7393A986400
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 07:35:24 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5C6729863E4; Tue,  4 Apr 2023 07:35:24 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 98C519863E6
	for <virtio-dev@lists.oasis-open.org>; Tue,  4 Apr 2023 07:35:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 2TxPXKOUPPCoSDaXBjtEkw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680593712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZ7OvF4WU/QH+YnymTBi4dvXJnEfQtCQbEJffBGyqao=;
        b=GFxvFBPsKLw+4rxugG4+wUf8LTco3Imi3fhgF4x0eKEPnGwchdyObOFutYCJ3E4+cE
         +W0n1TGfPmSNWm0ypD12PZUI4dTH+2LR2Ll2FxfBR8H4obM/F5WgOOl/+1AOJlMW6wkm
         3/drYwwWTUJqCen1ZxEGO/zbWcdiYCfWviy/HzmFF1yCeZ9cbvhQgAzvtlzatxzKGMiv
         pXcILZrLcXCSXEvN0ro+pr9zzWiQyZe4Var/li7jCTQaPWgruZO02Qc/aVl1HvAFYxDw
         0idMr6Pf5jZd3FhWcwwnOMgbYYfuALjpzpLIjbepbe3VbhC1CSTNeA+rw7CS8OMs/RkB
         H0Lw==
X-Gm-Message-State: AAQBX9f2jAgNE33g7I0ul2e2kjugJHJ2rmqXDZ0DnfmPaisY2s8v1Od9
	YtKcAeHqPkFczPGj3IuOqD6OU6qycU8TBZii2PqQ/qQQNtaGF9q2HLpP3LUXScPnlhm5qIlSYWX
	5NiOZXCT9E11TEMuGGE5hqlBL+cYR
X-Received: by 2002:a17:906:e24a:b0:8af:3b78:315d with SMTP id gq10-20020a170906e24a00b008af3b78315dmr1315545ejb.23.1680593712286;
        Tue, 04 Apr 2023 00:35:12 -0700 (PDT)
X-Google-Smtp-Source: AKy350YJnUvSDsCRn2E4j4LFUxjMhi0OHmTX4CSzfSrX9B3leqLEVhP2DtmlSBEjZlzS6tcy3jySYg==
X-Received: by 2002:a17:906:e24a:b0:8af:3b78:315d with SMTP id gq10-20020a170906e24a00b008af3b78315dmr1315532ejb.23.1680593712010;
        Tue, 04 Apr 2023 00:35:12 -0700 (PDT)
Date: Tue, 4 Apr 2023 03:35:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com,
	Satananda Burla <sburla@marvell.com>
Message-ID: <20230404032922-mutt-send-email-mst@kernel.org>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-9-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230330225834.506969-9-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH 08/11] transport-pci: Introduce virtio extended capability

On Fri, Mar 31, 2023 at 01:58:31AM +0300, Parav Pandit wrote:
> PCI device configuration space for capabilities is limited to only 192
> bytes shared by many PCI capabilities of generic PCI device and virtio
> specific.
> 
> Hence, introduce virtio extended capability that uses PCI Express
> extended capability.
> Subsequent patch uses this virtio extended capability.
> 
> Co-developed-by: Satananda Burla <sburla@marvell.com>

What does it "Co-developed-by" mean exactly that Signed-off-by
does not?


> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
>  transport-pci.tex | 69 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 68 insertions(+), 1 deletion(-)
> 
> diff --git a/transport-pci.tex b/transport-pci.tex
> index 665448e..aeda4a1 100644
> --- a/transport-pci.tex
> +++ b/transport-pci.tex
> @@ -174,7 +174,8 @@ \subsection{Virtio Structure PCI Capabilities}\label{sec:Virtio Transport Option
>  the function, or accessed via the special VIRTIO_PCI_CAP_PCI_CFG field in the PCI configuration space.
>  
>  The location of each structure is specified using a vendor-specific PCI capability located
> -on the capability list in PCI configuration space of the device.
> +on the capability list in PCI configuration space of the device
> +unless stated otherwise.
>  This virtio structure capability uses little-endian format; all fields are
>  read-only for the driver unless stated otherwise:
>  
> @@ -301,6 +302,72 @@ \subsection{Virtio Structure PCI Capabilities}\label{sec:Virtio Transport Option
>  fields provide the most significant 32 bits of a total 64 bit offset and
>  length within the BAR specified by \field{cap.bar}.
>  
> +Virtio extended PCI Express capability structure defines
> +the location of certain virtio device configuration related
> +structures using PCI Express extended capability. Virtio
> +extended PCI Express capability structure uses PCI Express
> +vendor specific extended capability (VSEC). It has a below

a layout below, or the following layout

> +layout:
> +
> +\begin{lstlisting}
> +struct pcie_ext_cap {
> +        le16 cap_vendor_id; /* Generic PCI field: 0xB */
> +        le16 cap_version : 2; /* Generic PCI field: 0 */
> +        le16 next_cap_offset : 14; /* Generic PCI field: next cap or 0 */
> +};
> +
> +struct virtio_pcie_ext_cap {
> +        struct pcie_ext_cap pcie_ecap;
> +        u8 cfg_type; /* Identifies the structure. */
> +        u8 bar; /* Index of the BAR where its located */
> +        u8 id; /* Multiple capabilities of the same type */
> +        u8 zero_padding[1];
> +        le64 offset; /* Offset with the bar */
> +        le64 length; /* Length of the structure, in bytes. */
> +        u8 data[]; /* Optional variable length data */

Maybe le64 data[], for alignment?

> +};
> +\end{lstlisting}
> +
> +This structure contains optional data, depending on
> +\field{cfg_type}. The fields are interpreted as follows:
> +
> +\begin{description}
> +\item[\field{cap_vendor_id}]
> +         0x0B; identifies a vendor-specific extended capability.
> +
> +\item[\field{cap_version}]
> +         contains a value of 0.
> +
> +\item[\field{next_cap_offset}]
> +        Offset to the next capability.
> +
> +\item[\field{cfg_type}]
> +        follows the same definition as \field{cfg_type}
> +        from the \field{struct virtio_pci_cap}.
> +
> +\item[\field{bar}]
> +        follows the same  same definition as  \field{bar}
> +        from the \field{struct virtio_pci_cap}.
> +
> +\item[\field{id}]
> +        follows the same  same definition as  \field{id}
> +        from the \field{struct virtio_pci_cap}.
> +
> +\item[\field{offset}]
> +        indicates where the structure begins relative to the
> +        base address associated with the BAR. The alignment
> +        requirements of offset are indicated in each
> +        structure-specific section that uses
> +        \field{struct virtio_pcie_ext_cap}.
> +
> +\item[\field{length}]
> +        indicates the length of the structure indicated by this
> +        capability.
> +
> +\item[\field{data}]
> +        optional data of this capability.
> +\end{description}
> +
>  \drivernormative{\subsubsection}{Virtio Structure PCI Capabilities}{Virtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities}
>  
>  The driver MUST ignore any vendor-specific capability structure which has
> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

