Return-Path: <mst@redhat.com>
Date: Tue, 5 Oct 2021 17:49:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio-iommu: Rework the bypass feature
Message-ID: <20211005174532-mutt-send-email-mst@kernel.org>
References: <20210930163503.51200-1-jean-philippe@linaro.org>
 <87a6jn1ka9.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87a6jn1ka9.fsf@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: Cornelia Huck <cohuck@redhat.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, virtio-dev@lists.oasis-open.org, eric.auger@redhat.com, sebastien.boeuf@intel.com, kevin.tian@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Oct 05, 2021 at 06:57:50PM +0200, Cornelia Huck wrote:
> On Thu, Sep 30 2021, Jean-Philippe Brucker <jean-philippe@linaro.org> wro=
te:
>=20
> > The VIRTIO_IOMMU_F_BYPASS feature is awkward to use and incomplete.
> > Although it is implemented by QEMU, it is not supported by any driver as
> > far as I know. Replace it with a new VIRTIO_IOMMU_F_BYPASS_CONFIG
> > feature. The old feature bit is deprecated and will be recycled once
> > versions of QEMU that implement it are not distributed anymore.
>=20
> I'm not sure we can safely reuse old feature bits. I don't think we're
> running out of free feature bits, so just keep this as reserved and
> deprecated?
>=20
> >
> > Two features are missing from virtio-iommu:
> >
> > * The ability for an hypervisor to start the device in bypass mode. The
> >   wording for VIRTIO_IOMMU_F_BYPASS is not clear enough to allow it at
> >   the moment.
> >
> > * The ability for a guest to set individual endpoints in bypass mode
> >   when bypass is globally disabled. An OS should have the ability to
> >   allow only endpoints it trusts to bypass the IOMMU, while keeping DMA
> >   disabled for endpoints it isn't even aware of. At the moment this can
> >   only be emulated by creating identity mappings.
> >
> > The VIRTIO_IOMMU_F_BYPASS_CONFIG feature adds a 'bypass' config field
> > that allows to enable and disable bypass globally. It also adds a new
> > flag for the ATTACH request.
> >
> > * The hypervisor can start the VM with bypass enabled or, if it knows
> >   that the software stack supports it, disabled. The 'bypass' config
> >   fields resets to 0 or 1.
> >
> > * Generally the firmware won't have an IOMMU driver and will need to be
> >   started in bypass mode, so the bootloader and kernel can be loaded
> >   from storage endpoint.
> >
> >   For more security, the firmware could implement a minimal virtio-iommu
> >   driver that reuses existing virtio support and only touches the config
> >   space. It could enable PCI bus mastering in bridges only for the
> >   endpoints that need it, enable global IOMMU bypass by flipping a bit,
> >   then tear everything down before handing control over to the OS. This
> >   prevents vulnerability windows where a malicious endpoint reprograms
> >   the IOMMU while the OS is configuring it [1].
> >
> >   The isolation provided by vIOMMUs has mainly been used for securely
> >   assigning endpoints to untrusted applications so far, while kernel DMA
> >   bypasses the IOMMU. But we can expect boot security to become as
> >   important in virtualization as it presently is on bare-metal systems,
> >   where some devices are untrusted and must never be able to access
> >   memory that wasn't assigned to them.
> >
> > * The OS can enable and disable bypass globally. It can then enable
> >   bypass for individual endpoints by attaching them to bypass domains,
> >   using the new VIRTIO_IOMMU_ATTACH_F_BYPASS flag. It can disable bypass
> >   by attaching them to normal domains.
> >
> > [1] IOMMU protection against I/O attacks: a vulnerability and a proof o=
f concept
> >     Morgan, B., Alata, =C9., Nicomette, V. et al.
> >     https://link.springer.com/article/10.1186/s13173-017-0066-7
>=20
> I'm not really familiar with this topic, so I'll just point out some
> spec things.
>=20
> >
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> > The virtio-iommu spec with colored diff is available at
> > https://jpbrucker.net/virtio-iommu/spec-bypass/virtio-iommu-f-bypass-co=
nfig-v1-diff.pdf
> >
> > Apologies for the poorly thought out VIRTIO_IOMMU_F_BYPASS. I didn't
> > spend enough time on it and ignored valuable suggestions.
> > ---
> >  virtio-iommu.tex | 69 +++++++++++++++++++++++++++++++++++++-----------
> >  1 file changed, 53 insertions(+), 16 deletions(-)
> >
> > diff --git a/virtio-iommu.tex b/virtio-iommu.tex
> > index efa735b..a2c90ea 100644
> > --- a/virtio-iommu.tex
> > +++ b/virtio-iommu.tex
> > @@ -59,14 +59,19 @@ \subsection{Feature bits}\label{sec:Device Types / =
IOMMU Device / Feature bits}
> >    VIRTIO_IOMMU_F_MAP_UNMAP is supported.}
> > =20
> >  \item[VIRTIO_IOMMU_F_BYPASS (3)]
> > -  When not attached to a domain, endpoints downstream of the IOMMU
> > -  can access the guest-physical address space.
> > +  This feature is deprecated.
>=20
> "and must not be negotiated." ?
>=20
> Not sure if we should add normative statements for that.

We can't just make existing art de jure illegal.

So SHOULD NOT and yes needs confirmance statements.
Given documentation is already there why remove it?


> > =20
> >  \item[VIRTIO_IOMMU_F_PROBE (4)]
> >    The PROBE request is available.
> > =20
> >  \item[VIRTIO_IOMMU_F_MMIO (5)]
> >    The VIRTIO_IOMMU_MAP_F_MMIO flag is available.
> > +
> > +\item[VIRTIO_IOMMU_F_BYPASS_CONFIG (6)]
> > +  The global bypass state is described in \field{bypass} of
> > +  struct virtio_iommu_config. The domain bypass state is
> > +  described by VIRTIO_IOMMU_ATTACH_F_BYPASS.
> > +
> >  \end{description}
> > =20
> >  \drivernormative{\subsubsection}{Feature bits}{Device Types / IOMMU De=
vice / Feature bits}
> > @@ -97,12 +102,19 @@ \subsection{Device configuration layout}\label{sec=
:Device Types / IOMMU Device /
> >      le32 end;
> >    } domain_range;
> >    le32 probe_size;
> > +  u8 bypass;
> > +  u8 reserved[3];
> >  };
> >  \end{lstlisting}
> > =20
> >  \drivernormative{\subsubsection}{Device configuration layout}{Device T=
ypes / IOMMU Device / Device configuration layout}
> > =20
> > -The driver MUST NOT write to device configuration fields.
> > +When the VIRTIO_IOMMU_F_BYPASS_CONFIG feature is negotiated, the
> > +driver MAY write to \field{bypass}. The driver MUST NOT write to
> > +any other device configuration field.
> > +
> > +If field \field{bypass} contains a value different than 0 or 1,
> > +the driver SHOULD treat it as 0.
>=20
> "The driver MUST NOT write any value different than 0 or 1 to
> \field{bypass}." ?
>=20
> > =20
> >  \devicenormative{\subsubsection}{Device configuration layout}{Device T=
ypes / IOMMU Device / Device configuration layout}
> > =20
> > @@ -110,16 +122,24 @@ \subsection{Device configuration layout}\label{se=
c:Device Types / IOMMU Device /
> >  the page granularity. The device MAY set more than one bit in
> >  \field{page_size_mask}.
> > =20
> > +If the driver writes a value different than 0 or 1 in
> > +\field{bypass}, the device SHOULD treat it as 0.
>=20
> "The device MUST NOT present any value different than 0 or 1 in
> \field{bypass}." ?

