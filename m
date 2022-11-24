Return-Path: <mst@redhat.com>
Date: Thu, 24 Nov 2022 02:45:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v9 06/10] mmio: document ADMIN_VQ as reserved
Message-ID: <20221124024408-mutt-send-email-mst@kernel.org>
References: <20221123210706.21476-1-mst@redhat.com>
 <20221123210706.21476-7-mst@redhat.com>
 <CACGkMEtDJ4r-oaBgjk0MDpHe6gOO2=R6GEAANAyCDMOgh0jETQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtDJ4r-oaBgjk0MDpHe6gOO2=R6GEAANAyCDMOgh0jETQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Jason Wang <jasowang@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com, virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Nov 24, 2022 at 02:03:30PM +0800, Jason Wang wrote:
> On Thu, Nov 24, 2022 at 5:08 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
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
> > index aa68926..023f9b9 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -2362,6 +2362,18 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
> >
> >  Notification mechanisms did not change.
> >
> > +\subsection{Features reserved for future use}\label{sec:Virtio Transport Options / Virtio Over MMIO / Features reserved for future use}
> > +
> > +At this time, devices and drivers utilizing Virtio Over MMIO
> > +do not support the following features:
> > +\begin{itemize}
> > +
> > +\item VIRTIO_F_ADMIN_VQ
> 
> Do we need to add VIRTIO_F_SR_IOV here? And probably SR-IOV group type?
> 
> Thanks

yea we can add more as patches on top.
as all of VIRTIO_F_ADMIN_VQ is not there I don't think we need to
call out  SR-IOV group type separately.

> > +
> > +\end{itemize}
> > +
> > +These features are reserved for future use.
> > +
> >  \section{Virtio Over Channel I/O}\label{sec:Virtio Transport Options / Virtio Over Channel I/O}
> >
> >  S/390 based virtual machines support neither PCI nor MMIO, so a
> > --
> > MST
> >

