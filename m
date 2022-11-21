Return-Path: <mst@redhat.com>
Date: Mon, 21 Nov 2022 12:09:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v8 7/9] ccw: document ADMIN_VQ as reserved
Message-ID: <20221121115828-mutt-send-email-mst@kernel.org>
References: <20221121012419.317406-1-mst@redhat.com>
 <20221121012419.317406-8-mst@redhat.com>
 <87r0xw5mod.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87r0xw5mod.fsf@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com, virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Nov 21, 2022 at 04:53:22PM +0100, Cornelia Huck wrote:
> On Sun, Nov 20 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > Adding relevant registers needs more work and it's not
> > clear what the use-case will be as currently only
> > the PCI transport is supported. But let's keep the
> > door open on this.
> > We already say it's reserved in a central place, but it
> > does not hurt to remind implementers to mask it.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  content.tex | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/content.tex b/content.tex
> > index 9c74fa9..7111929 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -2971,6 +2971,18 @@ \subsubsection{Resetting Devices}\label{sec:Virtio Transport Options / Virtio ov
> >  MAY also choose to verify reset completion by reading \field{device status} via
> >  CCW_CMD_READ_STATUS and checking whether it is 0 afterwards.
> >  
> > +\subsection{Features reserved for future use}\label{sec:Virtio Transport Options / Virtio Over MMIO / Features reserved for future use}
> 
> s/MMIO/Channel I/O/
> 
> > +
> > +At this time, devices and drivers utilizing Virtio over channel I/O
> > +do not support the following features:
> > +\begin{itemize}
> > +
> > +\item VIRTIO_F_ADMIN_VQ
> 
> There are already a few features not yet supported for ccw (queue reset,
> shared memory, ...) -- would it make sense to add a separate patch
> listing all of the features not yet supported prior to adding all of the
> admin vq infrastructure? Otherwise, this section is a bit misleading.
> 
> (What is the situation for MMIO?)
> 
> > +
> > +\end{itemize}
> > +
> > +These features are reserved for future use.
> > +
> >  \chapter{Device Types}\label{sec:Device Types}
> >  
> >  On top of the queues, config space and feature negotiation facilities

OK I think for now the following is sufficient, right?
Separately, we should make an effort to document that these
features are transport specific and not supported on all transports:
happily VIRTIO_F_RING_RESET is only used in drivers/virtio/virtio_pci_modern.c
for now, and VIRTIO_PMEM_F_SHMEM_REGION seems to be unused by Linux.

    ccw: document more reserved features
    
    vq reset and shared memory are unsupported, too.
    
    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

diff --git a/content.tex b/content.tex
index 30f8efb..776fc56 100644
--- a/content.tex
+++ b/content.tex
@@ -2978,6 +2978,8 @@ \subsection{Features reserved for future use}\label{sec:Virtio Transport Options
 \begin{itemize}
 
 \item VIRTIO_F_ADMIN_VQ
+\item VIRTIO_F_RING_RESET
+\item Shared memory regions including VIRTIO_PMEM_F_SHMEM_REGION
 
 \end{itemize}
 

