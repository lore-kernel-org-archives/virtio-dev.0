Return-Path: <jasowang@redhat.com>
MIME-Version: 1.0
References: <20221123210706.21476-1-mst@redhat.com> <20221123210706.21476-11-mst@redhat.com>
In-Reply-To: <20221123210706.21476-11-mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 24 Nov 2022 14:53:12 +0800
Message-ID: <CACGkMEvK3dtXK9Md=uxqJ_Ns7xJwehwNk8vcxhAd21SU2RLVZQ@mail.gmail.com>
Subject: Re: [PATCH RFC v9 10/10] ccw: document more reserved features
Content-Type: text/plain; charset="UTF-8"
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com, virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Nov 24, 2022 at 5:08 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> vq reset and shared memory are unsupported, too.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

I wonder if it's better to split this series into two since it doesn't
have direct connection with the admin stuffs then the compatibility
part can go first.

Thanks

> ---
>
>
> This is not strictly part of this patchset, but just to
> give you the idea of how we can expand this down the road.
>
>  content.tex | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/content.tex b/content.tex
> index 6c3758d..bfcf9fe 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -2983,6 +2983,8 @@ \subsection{Features reserved for future use}\label{sec:Virtio Transport Options
>  \begin{itemize}
>
>  \item VIRTIO_F_ADMIN_VQ
> +\item VIRTIO_F_RING_RESET
> +\item Shared memory regions including VIRTIO_PMEM_F_SHMEM_REGION
>
>  \end{itemize}
>
> --
> MST
>

