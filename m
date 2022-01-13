Return-Path: <virtio-dev-return-9023-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ACF9E9862D3
	for <virtio-dev@lists.oasis-open.org>; Thu, 13 Jan 2022 00:55:35 +0000 (UTC)
MIME-Version: 1.0
References: <20220112055755.41011-1-jasowang@redhat.com> <20220112055755.41011-2-jasowang@redhat.com>
 <Yd6o/rFvyFFhR3+2@stefanha-x1.localdomain>
In-Reply-To: <Yd6o/rFvyFFhR3+2@stefanha-x1.localdomain>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 13 Jan 2022 08:55:18 +0800
Message-ID: <CACGkMEshBONdayoxYaA4LWY0_azztqW_2zAoe2tXCkJrLdoT+w@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH V2 1/2] virtio-pci: introduce virtio structure PCI
 Extended Capability
Content-Type: text/plain; charset="UTF-8"
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>, mst <mst@redhat.com>, eperezma <eperezma@redhat.com>, Cindy Lu <lulu@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 12, 2022 at 6:10 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Wed, Jan 12, 2022 at 01:57:54PM +0800, Jason Wang wrote:
> > We're already out of the configuration space if there's a device that
> > supports all kinds of the virtio structure via PCI capability. This
> > prevents us from adding new capabilities in the future.
> >
> > So the patch adds the support for virtio structure via PCI Extended
> > Capability via the vendor specific extended capability.
> >
> > Only MMIO bar is allowed now.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  content.tex | 127 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 127 insertions(+)
> >
> > diff --git a/content.tex b/content.tex
> > index cf20570..00a75f2 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -1476,6 +1476,129 @@ \subsubsection{Non-transitional Device With Legacy Driver: A Note
> >     of BAR0 by presenting zeroes on every BAR and ignoring writes.
> >  \end{enumerate}
> >
> > +\subsection{Virtio Structure PCI Extended Capabilities}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Extended Capabilities}
> > +
> > +The location of the virtio structures that depend on the PCI Express
> > +capability are specified using a vendor-specific extended capabilities
> > +on the extended capabilities list in PCI Express extended
> > +configuration space of the device.
>
> I can't parse this sentence. Can you rephrase it and/or split it into
> multiple sentences?

Sure, how about something like:

There could be virtio structures that depend on the PCI express
capability. The location of those structures are specified using a
vendor-specific extended capabilities on the extended capabilities
list.

>
> > The virtio structure extended
> > +capability uses little-endian format: all fields are read-only for the
> > +driver unless stated otherwise:
> > +
> > +\begin{lstlisting}
> > +struct virtio_pci_ecap {
> > +        le16 cap_vndr;      /* Generic PCI field: PCI_EXT_CAP_ID_VNDR */
> > +        le16 cap_rev:4;     /* Generic PCI field: capability version: 0x1 */
> > +        le16 cap_next:12;   /* Generic PCI field: next ptr */
> > +        le16 cfg_type;      /* Identifies the structure */
> > +        le16 cfg_rev:4;     /* Identifies the version of the structure: 0x1 */
> > +        le16 cap_len:12;    /* The bytes of the entire capability */
> > +        u8 bar;             /* Where to find it. */
> > +        u8 id;              /* Multiple capabilities of the same type */
> > +        u8 padding[2];      /* Pad to full dword. */
> > +        le32 offset;        /* Offset within bar. */
> > +        le32 length;        /* Length of the structure, in bytes. */
> > +};
> > +\end{lstlisting}
> > +
> > +This structure can be followed by extra data, depending on the
> > +\field{cfg_type}.
> > +
> > +\begin{description}
> > +\item[\field{cap_vndr}]
> > +        0x0B; Identifies a vendor-specific extended capability.
>
> It's worth clarifying that "vendor-specific" here refers to the PCIe
> standard, not to the VIRTIO standard. Please use "PCI Vendor-Specific
> Extended Capability" everywhere in this patch instead of just
> "vendor-specific extended capability". That helps avoid confusion with
> VIRTIO_PCI_CAP_VENDOR_CFG.

I'm ok with this. Note that I just copy-paste from the pci part:

\item[\field{cap_vndr}]
0x09; Identifies a vendor-specific capability.

I think the logic is that it's a general PCI field, so we can avoid
mentioning "PCIe" again. So for general PCI fields, the "vendor" is
the one deduced from the PCI vendor ID. For the virtio field like
cfg_type, it's the virtio vendor.

>
> > +
> > +\item[\field{cap_rev}]
> > +        0x01; Identifies the version of the capability structure.
> > +
> > +\item[\field{cap_next}]
> > +        Link to next extended capability in the capability list in the
> > +        PCI Express extended configuration space.
> > +
> > +\item[\field{cfg_type}]
> > +        Identifies the structure. All values are reserved for future
> > +        use.
> > +
> > +        The device MAY offer more than one structure of any type - this makes it
> > +        possible for the device to expose multiple interfaces to drivers.  The order of
> > +        the capabilities in the capability list specifies the order of preference
> > +        suggested by the device. A device MAY specify that this ordering mechanism be
> > +        overridden by the use of the \field{id} field.
> > +
> > +\item[\field{cfg_rev}]
> > +        0x01; Identifies the version of virtio structure PCI extended
> > +        capability.
> > +
> > +\item[\field{cap_len}]
> > +        The length of the entire vendor specific extended capability,
> > +        including the virtio_pci_ecap structure and vendor specific
> > +        registers.
>
> I thought the point of this is to place the register in ->bar, so why
> would there be extra registers after struct virtio_pci_ecap(64)?

PCI spec allows to place registers in the capability itself. We had
already done this, one example is:

struct virtio_pci_notify_cap {
        struct virtio_pci_cap cap;
        le32 notify_off_multiplier; /* Multiplier for queue_notify_off. */
};

Actually, this is the only way to make VIRTIO_PCI_CAP_PCI_CFG to work.

struct virtio_pci_cfg_cap {
        struct virtio_pci_cap cap;
        u8 pci_cfg_data[4]; /* Data for BAR access. */
};

> Again,
> it's unclear who the "vendor" is.

It's a general PCI field, so the vendor here is specified from the
view of PCI that is the vendor deduced from the PCI vendor ID.

>
> > @@ -1488,6 +1611,10 @@ \subsubsection{Device Initialization}\label{sec:Virtio Transport Options / Virti
> >  PCI capability list, detecting virtio configuration layout using Virtio
> >  Structure PCI capabilities as detailed in \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities}
> >
> > +Optionally, if the device is a PCIe device, the driver scans the PCI
> > +Extended capability list, detecting virtio configuration layout using
> > +Virtio Struct PCI Extended capabilities as detailed in \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Extended Capabilities}
>
> If the same structure is present in both the PCI Capabilities and PCI
> Extended Capabilities lists, which one has a higher priority?

This is not allowed in this proposal where only the structure that
depends on the PCI Express capability is allowed. E.g the PASID
configuration structure depends on the PASID extended capability.

This is much more simpler than allowing existing virtio structures to
be presented on both PCI and PCIe capability list.

Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

