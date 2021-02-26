Return-Path: virtio-dev-return-8048-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3B014986226
	for <virtio-dev@lists.oasis-open.org>; Fri, 26 Feb 2021 12:14:15 +0000 (UTC)
Date: Fri, 26 Feb 2021 13:13:52 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-ID: <YDjmALQeAV/ldp9Q@myrica>
References: <20210225175314.1987932-1-jean-philippe@linaro.org>
 <20210225140723-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20210225140723-mutt-send-email-mst@kernel.org>
Subject: [virtio-dev] Re: [PATCH] virtio-iommu: Add VIRTIO_IOMMU_F_BOOT_BYPASS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, eric.auger@redhat.com, kevin.tian@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Feb 25, 2021 at 02:11:17PM -0500, Michael S. Tsirkin wrote:
> On Thu, Feb 25, 2021 at 06:53:15PM +0100, Jean-Philippe Brucker wrote:
> > Specify the behavior of the device before feature negotiation.
> > Implementations that allow DMA to bypass the IOMMU during boot inform
> > the driver by setting the VIRTIO_IOMMU_F_BOOT_BYPASS feature.
> > Negotiating the feature doesn't have any effect.
> 
> from spec text it kind of looks like it does, after
> FEATURES_OK devices are disallowed access?

Before FEATURES_OK the BOOT_BYPASS feature defines the policy chosen by
the device implementation.  After FEATURES_OK the driver overrides this
policy using the BYPASS feature.

Thinking more about this, we can't redefine F_BYPASS now (QEMU offers it),
but I'm tempted to deprecate it and replace it with a new feature bit that
indicates presence of a bypass field in config space. Device sets the byte
to 0 or 1 to declare its default bypass policy, and driver can override
this by writing 0 or 1 (currently done by accepting or refusing F_BYPASS).
It would be a lot cleaner than this.

Or just state that the boot-bypass behavior is up to the implementation
and leave it at that.

> > Clarify the description for VIRTIO_IOMMU_F_BYPASS while we're at it,
> > because "downstream of the IOMMU" is confusing.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> are the two bypass features dependend on each other then?

No the device can offer one without the other.

Thanks,
Jean

> 
> > ---
> >  virtio-iommu.tex | 28 ++++++++++++++++++++--------
> >  1 file changed, 20 insertions(+), 8 deletions(-)
> > 
> > diff --git a/virtio-iommu.tex b/virtio-iommu.tex
> > index 08b358a..4f34a14 100644
> > --- a/virtio-iommu.tex
> > +++ b/virtio-iommu.tex
> > @@ -59,7 +59,7 @@ \subsection{Feature bits}\label{sec:Device Types / IOMMU Device / Feature bits}
> >    VIRTIO_IOMMU_F_MAP_UNMAP is supported.}
> >  
> >  \item[VIRTIO_IOMMU_F_BYPASS (3)]
> > -  When not attached to a domain, endpoints downstream of the IOMMU
> > +  When not attached to a domain, endpoints managed by the IOMMU
> >    can access the guest-physical address space.
> >  
> >  \item[VIRTIO_IOMMU_F_PROBE (4)]
> > @@ -67,6 +67,10 @@ \subsection{Feature bits}\label{sec:Device Types / IOMMU Device / Feature bits}
> >  
> >  \item[VIRTIO_IOMMU_F_MMIO (5)]
> >    The VIRTIO_IOMMU_MAP_F_MMIO flag is available.
> > +
> > +\item[VIRTIO_IOMMU_F_BOOT_BYPASS (6)]
> > +  Before feature negotiation, endpoints managed by the IOMMU
> > +  can access the guest-physical address space.
> >  \end{description}
> >  
> >  \drivernormative{\subsubsection}{Feature bits}{Device Types / IOMMU Device / Feature bits}
> > @@ -114,12 +118,15 @@ \subsection{Device initialization}\label{sec:Device Types / IOMMU Device / Devic
> >  
> >  When the device is reset, endpoints are not attached to any domain.
> >  
> > -If the VIRTIO_IOMMU_F_BYPASS feature is negotiated, all accesses from
> > -unattached endpoints are allowed and translated by the IOMMU using the
> > -identity function. If the feature is not negotiated, any memory access
> > -from an unattached endpoint fails. Upon attaching an endpoint in
> > -bypass mode to a new domain, any memory access from the endpoint fails,
> > -since the domain does not contain any mapping.
> > +Memory accesses from an endpoint bypass the IOMMU, that is all
> > +accesses are allowed and translated using the identity function,
> > +in the following cases:
> > +\begin{itemize}
> > +\item If the VIRTIO_IOMMU_F_BOOT_BYPASS feature is offered and
> > +  the FEATURES_OK status bit is not set.
> 
> confused. so this feature *only* has effect before FEATURES_OK?
> 
> 
> > +\item If the VIRTIO_IOMMU_F_BYPASS feature is negotiated and the
> > +  endpoint is not attached to a domain.
> > +\end{itemize}
> >  
> >  Future devices might support more modes of operation besides MAP/UNMAP.
> >  Drivers verify that devices set VIRTIO_IOMMU_F_MAP_UNMAP and fail
> > @@ -136,8 +143,13 @@ \subsection{Device initialization}\label{sec:Device Types / IOMMU Device / Devic
> >  
> >  \devicenormative{\subsubsection}{Device Initialization}{Device Types / IOMMU Device / Device Initialization}
> >  
> > +If the device does not offer the VIRTIO_IOMMU_F_BOOT_BYPASS
> > +feature, it SHOULD NOT let endpoints access the guest-physical
> > +address space before feature negotiation is complete.
> > +
> >  If the driver does not accept the VIRTIO_IOMMU_F_BYPASS feature, the
> > -device SHOULD NOT let endpoints access the guest-physical address space.
> > +device SHOULD NOT let endpoints access the guest-physical address space
> > +after feature negotiation is complete.
> 
> 
> sounds weird as if they are only allowed access before feature
> negotiation. likely not what you meant.
> 
> 
> >  
> >  \subsection{Device operations}\label{sec:Device Types / IOMMU Device / Device operations}
> >  
> > -- 
> > 2.30.1
> 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

