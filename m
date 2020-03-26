Return-Path: virtio-dev-return-6980-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 785F298601F
	for <virtio-dev@lists.oasis-open.org>; Thu, 26 Mar 2020 10:49:43 +0000 (UTC)
Date: Thu, 26 Mar 2020 11:49:33 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-ID: <20200326104933.GA2639913@myrica>
References: <20200323133831.2110014-1-jean-philippe@linaro.org>
 <55f19d89-ff7b-b3f6-d5f8-c2b31c23a38a@redhat.com>
MIME-Version: 1.0
In-Reply-To: <55f19d89-ff7b-b3f6-d5f8-c2b31c23a38a@redhat.com>
Subject: Re: [virtio-dev] Re: [RFC PATCH] virtio-iommu: Add PAGE_SIZE_MASK
 property
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Auger Eric <eric.auger@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, bbhushan2@marvell.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Mar 23, 2020 at 03:22:40PM +0100, Auger Eric wrote:
> Hi Jean,
>=20
> On 3/23/20 2:38 PM, Jean-Philippe Brucker wrote:
> > Add a PROBE property to declare the mapping granularity per endpoint.
> > The virtio-iommu device already declares a granule in its config space,
> > but when endpoints are behind different physical IOMMUs, they may have
> > different mapping granules. This new property allows to override the
> > global page_size_mask for each endpoint.
> >=20
> > In the future it may be useful to describe more than one page_size_mask
> > for each endpoint, and allow them to negotiate it during ATTACH. For
> > example two masks could allow the driver to choose between 4k and 64k
> > granule, along with their respective block mapping sizes. This could be
> > added by replacing \field{reserved} with an array length, for example.
> Sorry I don't get the use case where several page size bitmaps should be
> exposed.

For a 4k granule you get block mappings of 2M and 1G. For a 64k granule
you get 512M and 4T block mappings. If you want to communicate both
options to the guest, you need two separate masks, 0x40201000 and
0x40020010000. Then the guest could choose one of the granules during
attach, if we add a flag to the attach request. I'm not suggesting we do
that now, just trying to make sure it can be extended if anyone actually
wants it. Personally I don't think it's worth adding, especially given the
additional work required in the host.

> >=20
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> > I had this change planned for a page-table sharing extension, but it
> > seems to be useful for the VFIO support in QEMU as well [1].
> >=20
> > [1] https://lore.kernel.org/qemu-devel/3da60c1b-6897-7ab1-3a67-bec44fa0=
0a54@redhat.com/
> > ---
> > ---
> >  virtio-iommu.tex | 33 ++++++++++++++++++++++++++++++++-
> >  1 file changed, 32 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/virtio-iommu.tex b/virtio-iommu.tex
> > index 08b358a..d7be13d 100644
> > --- a/virtio-iommu.tex
> > +++ b/virtio-iommu.tex
> > @@ -664,7 +664,8 @@ \subsubsection{PROBE request}\label{sec:Device Type=
s / IOMMU Device / Device ope
> >  \subsubsection{PROBE properties}\label{sec:Device Types / IOMMU Device=
 / Device operations / PROBE properties}
> > =20
> >  \begin{lstlisting}
> > -#define VIRTIO_IOMMU_PROBE_T_RESV_MEM   1
> > +#define VIRTIO_IOMMU_PROBE_T_RESV_MEM         1
> > +#define VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK   2
> >  \end{lstlisting}
> > =20
> >  \paragraph{Property RESV_MEM}\label{sec:Device Types / IOMMU Device / =
Device operations / PROBE properties / RESVMEM}
> > @@ -727,6 +728,36 @@ \subsubsection{PROBE properties}\label{sec:Device =
Types / IOMMU Device / Device
> >  The device SHOULD NOT allow accesses from the endpoint to RESV_MEM reg=
ions
> >  to affect any other component than the endpoint and the driver.
> > =20
> > +\paragraph{Property PAGE_SIZE_MASK}\label{sec:Device Types / IOMMU Dev=
ice / Device operations / PROBE properties / PAGESIZEMASK}
> "Property PAGESIZEMASK" to be homegeneous with "Property RESV_MEM"?

I don't understand, isn't the underscore version more homogeneous? I only
used PAGESIZEMASK and RESVMEM in the label to avoid troubles with latex,
which complains about underscores in labels (maybe because of the
underscore package). But labels are only used for resolving references and
don't appear in the final text.

> > +
> > +The PAGE_SIZE_MASK property overrides the global \field{page_size_mask=
}
> > +configuration for an endpoint.
> > +
> > +\begin{lstlisting}
> > +struct virtio_iommu_probe_page_size_mask {
> > +  struct virtio_iommu_probe_property head;
> > +  u8    reserved[4];
> > +  le64  page_size_mask;
> > +};
> > +\end{lstlisting}
>=20
> Maybe it would be useful to put in the spec the context of use of the
> new property (basically what you wrote in the commit msg). Also
> re-inforce that if no ep page size mask is returned the default one
> applies. Chapters describing page_size_mask global field may be sligtly
> augmented to mention the new prop...

I'll add that if no page size mask property is present, the global page
size mask applies. And in Device operations I'll add that these limits are
described in the device configuration as well as probe properties.

Thanks,
Jean

> > +
> > +The \field{page_size_mask} field behaves in the same way as the global
> > +\field{page_size_mask} field. The least significant bit describes the
> > +mapping granularity, and additional bits are hints (see \ref{sec:Devic=
e
> > +Types / IOMMU Device / Device operations})
> > +
> > +\drivernormative{\subparagraph}{Property PAGE_SIZE_MASK}{Device Types =
/ IOMMU Device / Device operations / PROBE properties / PAGESIZEMASK}
> > +
> > +The driver MUST ignore \field{reserved}.
> > +
> > +\devicenormative{\subparagraph}{Property PAGE_SIZE_MASK}{Device Types =
/ IOMMU Device / Device operations / PROBE properties / PAGESIZEMASK}
> > +
> > +The device SHOULD set \field{reserved} to zero.
> > +
> > +The device MUST set at least one bit in \field{page_size_mask}, descri=
bing
> > +the page granularity. The device MAY set more than one bit in
> > +\field{page_size_mask}.
> > +
> >  \subsubsection{Fault reporting}\label{sev:Device Types / IOMMU Device =
/ Device operations / Fault reporting}
> > =20
> >  The device can report translation faults and other significant
> >=20
>=20
> Thanks
>=20
> Eric
>=20
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>=20

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

