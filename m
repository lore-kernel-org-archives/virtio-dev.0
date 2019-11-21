Return-Path: virtio-dev-return-6361-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1F5BF985E8D
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Nov 2019 08:56:40 +0000 (UTC)
Date: Thu, 21 Nov 2019 09:56:25 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20191121095625.610d1716.cohuck@redhat.com>
In-Reply-To: <20191120174451.GB89876@lophozonia>
References: <20191120151903.175110-1-jean-philippe@linaro.org>
	<20191120151903.175110-2-jean-philippe@linaro.org>
	<20191120182734.7d6ec586.cohuck@redhat.com>
	<20191120174451.GB89876@lophozonia>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH RESEND v4 1/1] Add virtio-iommu device
 specification
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: virtio-dev@lists.oasis-open.org, joro@8bytes.org, tnowicki@marvell.com, eric.auger@redhat.com, kevin.tian@intel.com, lorenzo.pieralisi@arm.com, mst@redhat.com, bauerman@linux.ibm.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 20 Nov 2019 18:44:51 +0100
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> On Wed, Nov 20, 2019 at 06:27:34PM +0100, Cornelia Huck wrote:
> > > +\begin{lstlisting}
> > > +struct virtio_iommu_config {
> > > +  le64 page_size_mask;
> > > +  struct virtio_iommu_range_64 {
> > > +    le64 start;
> > > +    le64 end;
> > > +  } input_range;
> > > +  struct virtio_iommu_range_32 {
> > > +    le32 start;
> > > +    le32 end;
> > > +  } domain_range;
> > > +  le32 probe_size;
> > > +};
> > > +\end{lstlisting}
> > > +
> > > +\drivernormative{\subsubsection}{Device configuration layout}{Device=
 Types / IOMMU Device / Device configuration layout}
> > > +
> > > +The driver MUST NOT write to device configuration fields.
> > > +
> > > +\devicenormative{\subsubsection}{Device configuration layout}{Device=
 Types / IOMMU Device / Device configuration layout}
> > > +
> > > +The device SHOULD set \field{padding} to zero. =20
> >=20
> > I don't see any field named 'padding' -- is that a leftover from an
> > earlier version? =20
>=20
> Oh right, it is. The previous version had an 1-byte field before
> probe_size, so the structure needed 3 bytes of padding. Since we replaced
> that field by domain_range in v4, padding is gone.
>=20
> > If it is, we can probably remove it as a trivial change on top after
> > this change went in. =20
>=20
> I can also send a new version (after waiting a few days for other
> comments), please let me know what you prefer.

If nothing else turns up (I didn't spot anything), I think we can just
remove this sentence on top, no need to restart the voting IMHO.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

