Return-Path: <virtio-dev-return-13263-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3737C0015E
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 16:39:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 167667C690
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 16:39:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9E581986887
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 16:39:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 63BEB986826; Thu,  6 Jul 2023 16:39:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2FBDB98672C
	for <virtio-dev@lists.oasis-open.org>; Thu,  6 Jul 2023 16:39:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: Ew49OX2DMq6pbZaLsmROJw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688661559; x=1691253559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hy9TekNvTv1yOYVvp8MJv78ThdQQSQQI3+ZK4BVTe8=;
        b=Ig6SYeGM7jMpuqJxJ3xcPBaDhBxF7BzQ8iaL8B0AmU53TlJcc/kC8W/th9Aata+QhE
         c8d9aLZR/4I1xzZI41aY0OuJg54/GgmVwpichr322yI4MWAEToWWHVgML4h4X+l/knft
         rrz27ohhFI7PbIEdZrlJ587dPh+RIOqRSHr8IZHiprrO7u7Dq10Z3GudwvI37eKzAGFy
         wkGVK27S0Dmckv0VQ9sfWAHjkcEIto/TFxmHyHFBJFCgwqbxy6kF/xtTGmSfeJNRkqsz
         l4J79uCIiWnSasF3TGvJ11BlY0JG7M9h9MguVPU9RVuiPY+/SHRsmXzMKOx1O6nDlT6J
         9qIw==
X-Gm-Message-State: ABy/qLaJ7HSfnnZiulUZv3oGj7A8l6J9R7CcSuaIsOUf/khQ3uht3DsJ
	t/LMpaugdD7DpalDn16UIdlzK/LH5kjI7hU5dVbcyg6q/TSGnx/ty62MJ4CXpFzuIa1Nqn+7zpn
	lQD90ZudblYZOpHj7yNruUt8cbSZr
X-Received: by 2002:a1c:7c17:0:b0:3fb:4055:1ddd with SMTP id x23-20020a1c7c17000000b003fb40551dddmr1698827wmc.28.1688661559052;
        Thu, 06 Jul 2023 09:39:19 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE2InZ4k5+5cfJsxdOeFOBXCqpf/twwoPlS7th5Qa2Jyi0Lm3i+GIJS4pzn0w0VYRbeR+8EQg==
X-Received: by 2002:a1c:7c17:0:b0:3fb:4055:1ddd with SMTP id x23-20020a1c7c17000000b003fb40551dddmr1698811wmc.28.1688661558657;
        Thu, 06 Jul 2023 09:39:18 -0700 (PDT)
Date: Thu, 6 Jul 2023 12:39:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, virtio-comment@lists.oasis-open.org,
	david.edmondson@oracle.com, virtio-dev@lists.oasis-open.org,
	sburla@marvell.com, jasowang@redhat.com, yishaih@nvidia.com,
	maorg@nvidia.com, shahafs@nvidia.com
Message-ID: <20230706123220-mutt-send-email-mst@kernel.org>
References: <20230706041714.65600-1-parav@nvidia.com>
 <20230706041714.65600-5-parav@nvidia.com>
 <87r0pluhqy.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87r0pluhqy.fsf@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v10 4/4] transport-pci: Introduce group legacy group
 member config region access

On Thu, Jul 06, 2023 at 06:28:21PM +0200, Cornelia Huck wrote:
> On Thu, Jul 06 2023, Parav Pandit <parav@nvidia.com> wrote:
> 
> > diff --git a/transport-pci-legacy-regs.tex b/transport-pci-legacy-regs.tex
> > new file mode 100644
> > index 0000000..ceea28c
> > --- /dev/null
> > +++ b/transport-pci-legacy-regs.tex
> > @@ -0,0 +1,42 @@
> > +\subsection{Legacy Interface: Group member device Configuration Region Access}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / Legacy Interface: Group Member Device Configuration Region Access}
> > +
> > +The PCI owner device or the member device or both support driver notifications using
> 
> What about
> 
> "The PCI owner device, the member device, or both can choose to
> support..." ?
> 
> > +a notification region defined in \field{struct virtio_pci_legacy_notify_region}.
> > +
> > +In \field{struct virtio_virtio_admin_cmd_legacy_notify_query_entry},
> > +\field{region_data} is defined as following:
> > +
> > +\begin{lstlisting}
> > +struct virtio_pci_legacy_notify_region {
> > +        u8 owner;  /* When set to 1, notification region is of the owner device */
> > +        u8 bar;    /* BAR of the member or owner device */
> > +        u8 padding[6];
> > +        le64 offset; /* Offset within bar. */
> > +};
> > +\end{lstlisting}
> > +
> > +The group owner device hardwires VF BAR0 to zero in the SR-IOV Extended
> > +capability.
> > +
> > +The group member device does not use PCI BAR0 in all the Virtio PCI capabilities
> 
> "in [or for?] any of the...", I guess?
> 
> > +listed in section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities}.
> > +
> > +\devicenormative{\subsubsection}{Legacy Interface: Group Member Device Legacy Configuration Region Access}{Virtio Transport Options / Virtio Over PCI Bus / Legacy Interface: Group Member Device Configuration Region Access}
> > +
> > +When a PCI SR-IOV group owner device supports
> > +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
> > +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE, VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ,
> > +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE commands, the group owner device MUST
> > +hardwire VF BAR0 to zero in the SR-IOV Extended capability and the group memberi
> 
> s/memberi/member/
> 
> > +device MUST NOT use BAR0 in any of the Virtio Structure PCI Capabilities.
> > +
> > +The group owner device or the group member device or both MAY support driver
> > +notifications region.
> 
> Make this "a driver notification region"?

I think in fact for conformance we can just refer to supporting the command.
The command can return an array of structures, each referring to
the memory of the owner device or the member device.


> > +
> > +For the SR-IOV group type, the owner device supporting
> > +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
> > +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE, VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ,
> > +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE and VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_QUERY
> > +commands and its member device SHOULD follow the rules for the PCI Device ID,

what does "its" mean here? Of the group?
Members of the SR-IOV group type are VFs. They can not follow
the rules for the Device ID: the spec says:
This field in all VFs returns FFFFh when read.

Even if you somehow refer to the software it's extraneous anyway
since the spec proceeds: VI software should return the Vendor ID value
from the associated PF as the Vendor ID value for the VF.

We'll need a separate statement for Device ID.

> > +Revision ID and Subsystem Device ID of the non-transitional devices documented in
> > +section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery}.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

