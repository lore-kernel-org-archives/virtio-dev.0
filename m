Return-Path: <mst@redhat.com>
Date: Thu, 24 Nov 2022 03:31:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC v9 10/10] ccw: document more reserved features
Message-ID: <20221124033059-mutt-send-email-mst@kernel.org>
References: <20221123210706.21476-1-mst@redhat.com>
 <20221123210706.21476-11-mst@redhat.com>
 <CACGkMEvK3dtXK9Md=uxqJ_Ns7xJwehwNk8vcxhAd21SU2RLVZQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvK3dtXK9Md=uxqJ_Ns7xJwehwNk8vcxhAd21SU2RLVZQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Jason Wang <jasowang@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com, virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Nov 24, 2022 at 02:53:12PM +0800, Jason Wang wrote:
> On Thu, Nov 24, 2022 at 5:08 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > vq reset and shared memory are unsupported, too.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> I wonder if it's better to split this series into two since it doesn't
> have direct connection with the admin stuffs then the compatibility
> part can go first.
> 
> Thanks

cover letter explains that this is not part of the series,
here for informational purposes.

I don't really have time to work on cleaning up ccw but once
this lands others can take this up.


> > ---
> >
> >
> > This is not strictly part of this patchset, but just to
> > give you the idea of how we can expand this down the road.
> >
> >  content.tex | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/content.tex b/content.tex
> > index 6c3758d..bfcf9fe 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -2983,6 +2983,8 @@ \subsection{Features reserved for future use}\label{sec:Virtio Transport Options
> >  \begin{itemize}
> >
> >  \item VIRTIO_F_ADMIN_VQ
> > +\item VIRTIO_F_RING_RESET
> > +\item Shared memory regions including VIRTIO_PMEM_F_SHMEM_REGION
> >
> >  \end{itemize}
> >
> > --
> > MST
> >

