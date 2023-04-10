Return-Path: <virtio-dev-return-12072-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43956C77B6E
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 01:36:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 79B53887
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 01:36:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6BF5198638E
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 01:36:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6249A9843C6; Mon, 10 Apr 2023 01:36:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 51304986319
	for <virtio-dev@lists.oasis-open.org>; Mon, 10 Apr 2023 01:36:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: reGTIXhIOsaAPJkaHw-0wQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681090588; x=1683682588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVoAUVNC0VwUE2Cd0oCg4bMkW6jLsQZI3GKzijUTVIc=;
        b=nLwsllI3LRyTX/kwSYhV7uTi16yna+2+eBjqyuSbDaas76CTQlo/Sf4+BZN5rA/sVd
         +31ABRAx9M68IIqjw3pnODMSOJmoxoO7BIDlFWESpFVbn5Qf9A1EH9bNrNNupS6NLW6d
         CSmU7ZbMWexFVsih/gpPSc+bPxBUIUx3LKHpmIYs86kZ5dddoixGgMvh3c4iJ+rfsJCm
         0wtmOk4emAE82U0blDMAeOhZcc+ZVmOzvc/l6uL2NvsiisKLVCJmiDMll2RjpfSsDjmW
         0qqqBjPVm7x3vemBY24qLyR8dIwq94h8YbgRL19vRijj5y/1YWxFpvnpFqmnxGWfqcq4
         DXTA==
X-Gm-Message-State: AAQBX9eoW4vz7NfCBj5uin1ZWCxWgOQZPnEzQ6DWMCd2mfCQhdhNhW+F
	YRRD3rJZcCA9iNYmIgC4GzP5FAz1htXCUd2eqsQtXXcwUjBQ47FO+WVimvdjv78unEhTJB9tCNB
	qbg8gUlQmxdg3N7FSpk2ipiON01vEBCuprSsCl1OdQ72G
X-Received: by 2002:a05:6808:915:b0:389:50f2:4aa6 with SMTP id w21-20020a056808091500b0038950f24aa6mr2410405oih.9.1681090588453;
        Sun, 09 Apr 2023 18:36:28 -0700 (PDT)
X-Google-Smtp-Source: AKy350a96XF3a7OWYoRa8Ep6XSXgEDQvOpYv2K9viH7QsgZ2GO7sIPQ3PEqv9+mQCJxsWukyFnr9uvP0zhvuWapJlMo=
X-Received: by 2002:a05:6808:915:b0:389:50f2:4aa6 with SMTP id
 w21-20020a056808091500b0038950f24aa6mr2410397oih.9.1681090588206; Sun, 09 Apr
 2023 18:36:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230330225834.506969-1-parav@nvidia.com> <20230330225834.506969-9-parav@nvidia.com>
In-Reply-To: <20230330225834.506969-9-parav@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 10 Apr 2023 09:36:17 +0800
Message-ID: <CACGkMEtMOy4B-O-52ka+9P3OBQ_hs1KvdjWodNYg-XKLff+giw@mail.gmail.com>
To: Parav Pandit <parav@nvidia.com>
Cc: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com, 
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, 
	Satananda Burla <sburla@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] [PATCH 08/11] transport-pci: Introduce virtio
 extended capability

On Fri, Mar 31, 2023 at 7:00=E2=80=AFAM Parav Pandit <parav@nvidia.com> wro=
te:
>
> PCI device configuration space for capabilities is limited to only 192
> bytes shared by many PCI capabilities of generic PCI device and virtio
> specific.
>
> Hence, introduce virtio extended capability that uses PCI Express
> extended capability.
> Subsequent patch uses this virtio extended capability.
>
> Co-developed-by: Satananda Burla <sburla@marvell.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>

Can you explain the differences compared to what I've used to propose?

https://www.mail-archive.com/virtio-dev@lists.oasis-open.org/msg08078.html

This can save time for everybody.

Thanks

> ---
>  transport-pci.tex | 69 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 68 insertions(+), 1 deletion(-)
>
> diff --git a/transport-pci.tex b/transport-pci.tex
> index 665448e..aeda4a1 100644
> --- a/transport-pci.tex
> +++ b/transport-pci.tex
> @@ -174,7 +174,8 @@ \subsection{Virtio Structure PCI Capabilities}\label{=
sec:Virtio Transport Option
>  the function, or accessed via the special VIRTIO_PCI_CAP_PCI_CFG field i=
n the PCI configuration space.
>
>  The location of each structure is specified using a vendor-specific PCI =
capability located
> -on the capability list in PCI configuration space of the device.
> +on the capability list in PCI configuration space of the device
> +unless stated otherwise.
>  This virtio structure capability uses little-endian format; all fields a=
re
>  read-only for the driver unless stated otherwise:
>
> @@ -301,6 +302,72 @@ \subsection{Virtio Structure PCI Capabilities}\label=
{sec:Virtio Transport Option
>  fields provide the most significant 32 bits of a total 64 bit offset and
>  length within the BAR specified by \field{cap.bar}.
>
> +Virtio extended PCI Express capability structure defines
> +the location of certain virtio device configuration related
> +structures using PCI Express extended capability. Virtio
> +extended PCI Express capability structure uses PCI Express
> +vendor specific extended capability (VSEC). It has a below
> +layout:
> +
> +\begin{lstlisting}
> +struct pcie_ext_cap {
> +        le16 cap_vendor_id; /* Generic PCI field: 0xB */
> +        le16 cap_version : 2; /* Generic PCI field: 0 */
> +        le16 next_cap_offset : 14; /* Generic PCI field: next cap or 0 *=
/
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
>  \drivernormative{\subsubsection}{Virtio Structure PCI Capabilities}{Virt=
io Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilit=
ies}
>
>  The driver MUST ignore any vendor-specific capability structure which ha=
s
> --
> 2.26.2
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

