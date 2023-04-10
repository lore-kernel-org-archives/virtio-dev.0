Return-Path: <virtio-dev-return-12071-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 206CFC77B6E
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 01:35:23 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 71B4342908
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 01:35:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by host09.ws5.connectedcommunity.org (Postfix) with QMQP
	id 5E2702A8C7; Mon, 10 Apr 2023 01:35:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 64113986366
	for <virtio-dev@lists.oasis-open.org>; Mon, 10 Apr 2023 01:33:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: Oz-18yVDMEm4LR9IpOknaQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681090426; x=1683682426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BtwG4PU4amkOM2K+PKTfQ0j6IbROHgP5F+YrVmClMG0=;
        b=o9MMnZ/8HB52Grjmo1CbpTwQdFRs/8NjfZuEGTI4leLKacFxv6IhQWRPgi4irDr0gh
         mZKe9KDMYBa6ff1A1038C9Wfn74E4sOvArx11Cc1SRudvwAWzu5ArpqaBuyY/yf4s9D5
         YZV4peLLvepfmXO+opIOB4MQignRmSzPMPBH8XlgNxycgUIENMSAcuGjOrddTeHe9Nqi
         K5ew2IDhbLh3KlrjqMC8j7f9NjJRRWXja6J/52NlKUd4GtkRlp5Rz3xAqnrNYeqL7qJf
         /CjwZfuh9++gnHyVIxmsNf/ZVOoiPhPGpfG/67EThf4Gi5+IEJJ/FKow+Fg6Y4NxHRuY
         qczg==
X-Gm-Message-State: AAQBX9cyS8fNAE65NxH9/8IZleo29Qo7cY/InGRpwf9cPUn34BlD8kSZ
	kXdxnxPOGTRH7DEU+q77XFEX0I2KxM84whO2v23YLqxFzN6n2bU/nHCLi5GIaVDIUr1tfZJcuko
	EzKuYx/PtuHUl7clZNGagvawaofhraG1FCRSUMaeAYyri
X-Received: by 2002:a05:6808:3307:b0:383:fef9:6cac with SMTP id ca7-20020a056808330700b00383fef96cacmr2388898oib.9.1681090426169;
        Sun, 09 Apr 2023 18:33:46 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZQ2XqsbPJ/y8jkxpMthAPy63rRO431jUa8QvUzzuKd6KgHejs0xLQHWkTSE/4s44BPwcmg+tUCwBItEQLcYoU=
X-Received: by 2002:a05:6808:3307:b0:383:fef9:6cac with SMTP id
 ca7-20020a056808330700b00383fef96cacmr2388892oib.9.1681090425882; Sun, 09 Apr
 2023 18:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230330225834.506969-1-parav@nvidia.com> <20230330225834.506969-10-parav@nvidia.com>
 <20230407043841-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230407043841-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 10 Apr 2023 09:33:32 +0800
Message-ID: <CACGkMEtkOdwixxaRz2Pv9xP75vb13ncboX5XRs8NqFCUsS16aQ@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, virtio-dev@lists.oasis-open.org, cohuck@redhat.com, 
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, 
	Satananda Burla <sburla@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers

On Fri, Apr 7, 2023 at 4:55=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Fri, Mar 31, 2023 at 01:58:32AM +0300, Parav Pandit wrote:
> > Legacy virtio configuration registers and adjacent
> > device configuration registers are located somewhere
> > in a memory BAR.
> >
> > A new capability supplies the location of these registers
> > which a driver can use to map I/O access to legacy
> > memory mapped registers.
> >
> > This gives the ability to locate legacy registers in either
> > the existing memory BAR or as completely new BAR at BAR 0.
> >
> > A below example diagram attempts to depicts it in an existing
> > memory BAR.
> >
> > +------------------------------+
> > |Transitional                  |
> > |MMR SRIOV VF                  |
> > |                              |
> > ++---------------+             |
> > ||dev_id =3D       |             |
> > ||{0x10f9-0x10ff}|             |
> > |+---------------+             |
> > |                              |
> > ++--------------------+        |
> > || PCIe ext cap =3D 0xB |        |
> > || cfg_type =3D 10      |        |
> > || offset   =3D 0x1000  |        |
> > || bar      =3D A {0..5}|        |
> > |+--|-----------------+        |
> > |   |                          |
> > |   |                          |
> > |   |    +-------------------+ |
> > |   |    | Memory BAR =3D A    | |
> > |   |    |                   | |
> > |   +------>+--------------+ | |
> > |        |  |legacy virtio | | |
> > |        |  |+ dev cfg     | | |
> > |        |  |registers     | | |
> > |        |  +--------------+ | |
> > |        +-----------------+ | |
> > +------------------------------+
> >
> > Co-developed-by: Satananda Burla <sburla@marvell.com>
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
>
>
> I am split about using the extended capability for this, since in
> practice this makes for more code in hypervisors.  How about just using
> an existing capability as opposed to the extended capability? Less work
> for existing hypervisors, no? And let's begin to use the extended
> capability for something more important than legacy access.
>
>
>
>
> > ---
> >  transport-pci.tex | 33 +++++++++++++++++++++++++++++++--
> >  1 file changed, 31 insertions(+), 2 deletions(-)
> >
> > diff --git a/transport-pci.tex b/transport-pci.tex
> > index aeda4a1..55a6aa0 100644
> > --- a/transport-pci.tex
> > +++ b/transport-pci.tex
> > @@ -168,6 +168,7 @@ \subsection{Virtio Structure PCI Capabilities}\labe=
l{sec:Virtio Transport Option
> >  \item ISR Status
> >  \item Device-specific configuration (optional)
> >  \item PCI configuration access
> > +\item Legacy memory mapped configuration registers (optional)
> >  \end{itemize}
> >
> >  Each structure can be mapped by a Base Address register (BAR) belongin=
g to
> > @@ -228,6 +229,8 @@ \subsection{Virtio Structure PCI Capabilities}\labe=
l{sec:Virtio Transport Option
> >  #define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
> >  /* Vendor-specific data */
> >  #define VIRTIO_PCI_CAP_VENDOR_CFG        9
> > +/* Legacy configuration registers capability */
> > +#define VIRTIO_PCI_CAP_LEGACY_MMR_CFG    10
> >  \end{lstlisting}
> >
> >          Any other value is reserved for future use.
> > @@ -682,6 +685,18 @@ \subsubsection{Common configuration structure layo=
ut}\label{sec:Virtio Transport
> >  Configuration Space / Legacy Interface: Device Configuration
> >  Space}~\nameref{sec:Basic Facilities of a Virtio Device / Device Confi=
guration Space / Legacy Interface: Device Configuration Space} for workarou=
nds.
> >
> > +\paragraph{Transitional MMR Interface: A Note on Configuration Registe=
rs}
> > +\label{sec:Virtio Transport Options / Virtio Over PCI Bus / Virtio Str=
ucture PCI Capabilities / Common configuration structure layout / Transitio=
nal MMR Interface: A Note on Configuration Registers}
> > +
> > +The transitional MMR device MUST present legacy virtio registers
> > +consisting of legacy common configuration registers followed by
> > +legacy device specific configuration registers described in section
> > +\ref{sec:Virtio Transport Options / Virtio Over PCI Bus / Virtio Struc=
ture PCI Capabilities / Common configuration structure layout / Legacy Inte=
rfaces: A Note on Configuration Registers}
> > +in a memory region PCI BAR.
> > +
> > +The transitional MMR device MUST provide the location of the
> > +legacy virtio configuration registers using a legacy memory mapped
> > +registers capability described in section \ref{sec:Virtio Transport Op=
tions / Virtio Over PCI Bus / Virtio Structure PCI Capabilities / Transitio=
nal MMR Interface: Legacy Memory Mapped Configuration Registers Capability}=
.
> >
> >  \subsubsection{Notification structure layout}\label{sec:Virtio Transpo=
rt Options / Virtio Over PCI Bus / PCI Device Layout / Notification capabil=
ity}
> >
> > @@ -956,9 +971,23 @@ \subsubsection{PCI configuration access capability=
}\label{sec:Virtio Transport O
> >  specified by some other Virtio Structure PCI Capability
> >  of type other than \field{VIRTIO_PCI_CAP_PCI_CFG}.
> >
> > +\subsubsection{Transitional MMR Interface: Legacy Memory Mapped Config=
uration Registers Capability}
> > +\label{sec:Virtio Transport Options / Virtio Over PCI Bus / Virtio Str=
ucture PCI Capabilities / Transitional MMR Interface: Legacy Memory Mapped =
Configuration Registers Capability}
> > +
> > +The optional VIRTIO_PCI_CAP_LEGACY_MMR_CFG capability defines
> > +the location of the legacy virtio configuration registers
> > +followed by legacy device specific configuration registers in
> > +the memory region BAR for the transitional MMR device.
> > +
> > +The \field{cap.offset} MUST be 4-byte aligned.
> > +The \field{cap.offset} SHOULD be 4KBytes aligned and
>
> what's the point of this?
>
> > +\field{cap.length} SHOULD be 4KBytes.
>
> Why is length 4KBytes? Why not the actual length?
>
>
> > +
> > +The transitional MMR device MUST present a legacy configuration
> > +memory mapped registers capability using \field{virtio_pcie_ext_cap}.
> > +
> >  \subsubsection{Legacy Interface: A Note on Feature Bits}
> > -\label{sec:Virtio Transport Options / Virtio Over PCI Bus /
> > -Virtio Structure PCI Capabilities / Legacy Interface: A Note on Featur=
e Bits}
> > +\label{sec:Virtio Transport Options / Virtio Over PCI Bus / Virtio Str=
ucture PCI Capabilities / Legacy Interface: A Note on Feature Bits}
> >
>
>
> So it is not by chance that we abadoned the legacy interface,
> it had some fundamental issues.
> Let me list some off the top of my mind:
> - no atomicity across accesses, so if a register changes
>   while it is read driver gets trash. solved using generation id
> - no defined endian-ness. solved using le
> - no way to reject driver configuration

I can think more:

- VIRTIO_F_ACCESS_PLATFORM
- VIRTIO_F_ORDER_PLATFORM

The above two are a must for hardware devices which are almost
impossible for legacy interfaces.

Hardware transitional devices are really tricky, ENI is one example
which can only work for x86.

config ALIBABA_ENI_VDPA
        tristate "vDPA driver for Alibaba ENI"
        select VIRTIO_PCI_LIB_LEGACY
        depends on PCI_MSI && X86

It has an MMIO bar for legacy registers and it works by chance for
Linux drivers; DPDK requires patches to let it work.

This is fine for vDPA but not for virtio if the design can only work
for some specific setups (OSes/archs).

Thanks

>
> we just did a new thing instead, but I feel if you are reviving the
> legacy interface yet again, it is worth thinking about solving the worst
> of the warts. For example, I can see an endian-ness register that
> hypervisor can either read to check device is compatible with guest, or
> maybe even write to force device to specific endian-ness.
> A generation counter that hypervisor can check to
> verify value is consistent? Can work if hypervisor
> caches configuration.
> A bad state flag that device can set to make hypervisor
> stop guest? Better than corrupting it ...
>
>
>
>
> >  Only Feature Bits 0 to 31 are accessible through the
> >  Legacy Interface. When used through the Legacy Interface,
> > --
> > 2.26.2
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
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-l=
ists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

