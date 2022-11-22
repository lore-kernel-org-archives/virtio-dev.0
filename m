Return-Path: <mst@redhat.com>
Date: Tue, 22 Nov 2022 04:51:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v8 7/9] ccw: document ADMIN_VQ as reserved
Message-ID: <20221122044540-mutt-send-email-mst@kernel.org>
References: <20221121012419.317406-1-mst@redhat.com>
 <20221121012419.317406-8-mst@redhat.com>
 <87r0xw5mod.fsf@redhat.com>
 <20221121115828-mutt-send-email-mst@kernel.org>
 <87bkozfk4k.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87bkozfk4k.fsf@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com, virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Nov 22, 2022 at 09:50:35AM +0100, Cornelia Huck wrote:
> On Mon, Nov 21 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > OK I think for now the following is sufficient, right?
> > Separately, we should make an effort to document that these
> > features are transport specific and not supported on all transports:
> > happily VIRTIO_F_RING_RESET is only used in drivers/virtio/virtio_pci_modern.c
> > for now, and VIRTIO_PMEM_F_SHMEM_REGION seems to be unused by Linux.
> >
> >     ccw: document more reserved features
> >     
> >     vq reset and shared memory are unsupported, too.
> >     
> >     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > diff --git a/content.tex b/content.tex
> > index 30f8efb..776fc56 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -2978,6 +2978,8 @@ \subsection{Features reserved for future use}\label{sec:Virtio Transport Options
> >  \begin{itemize}
> >  
> >  \item VIRTIO_F_ADMIN_VQ
> > +\item VIRTIO_F_RING_RESET
> > +\item Shared memory regions including VIRTIO_PMEM_F_SHMEM_REGION
> 
> \item VIRTIO_F_SR_IOV (not applicable for this transport)
> \item VIRTIO_F_NOTIFICATION_DATA
> \item VIRTIO_F_NOTIF_CONFIG_DATA
> 
> I think that would be all AFAICS.

In fact VIRTIO_F_NOTIF_CONFIG_DATA is also not supported for MMIO.

> 
> What about doing a separate github issue for patch 1 + the list of
> reserved features for ccw as of now? We should be able to get that in
> independently of the admin vq work.

Yes - if it's me that's going to work on this then I'd rather make it a
patch on top though, I'd like to work on ADMIN_VQ first as that
has people waiting on it. Work on hardening spec wording is something
that will never end ;)

-- 
MST

