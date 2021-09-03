Return-Path: <mst@redhat.com>
Date: Fri, 3 Sep 2021 04:32:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] Reserve device id for RDMA device
Message-ID: <20210903043232-mutt-send-email-mst@kernel.org>
References: <20210903080303.39915-1-weijunji@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20210903080303.39915-1-weijunji@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Junji Wei <weijunji@bytedance.com>
Cc: virtio-dev@lists.oasis-open.org, dledford@redhat.com, jgg@ziepe.ca, jasowang@redhat.com, yuval.shaia.ml@gmail.com, marcel.apfelbaum@gmail.com, cohuck@redhat.com, hare@suse.de, xieyongji@bytedance.com, chaiwen.cc@bytedance.com, dingtao.darren@bytedance.com, duanxiongchun@bytedance.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Sep 03, 2021 at 04:03:03PM +0800, Junji Wei wrote:
> Use device ID 42
> 
> Signed-off-by: Junji Wei <weijunji@bytedance.com>

Pls remember you will need a github issue and all that jazz.

> ---
>  content.tex | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/content.tex b/content.tex
> index 3aeb4a4..b57c997 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -2878,6 +2878,8 @@ \chapter{Device Types}\label{sec:Device Types}
>  \hline
>  41         &   GPIO device \\
>  \hline
> +42         &   RDMA device \\
> +\hline
>  \end{tabular}
>  
>  Some of the devices above are unspecified by this document,
> -- 
> 2.30.1 (Apple Git-130)

