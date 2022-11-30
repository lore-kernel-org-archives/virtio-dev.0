Return-Path: <xuanzhuo@linux.alibaba.com>
Message-ID: <1669795611.7596157-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v1] content: reserve device ID 44 for ISM device
Date: Wed, 30 Nov 2022 16:06:51 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20221130080248.49418-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20221130080248.49418-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: hans@linux.alibaba.com, herongguang@linux.alibaba.com, zmlcc@linux.alibaba.com, dust.li@linux.alibaba.com, tonylu@linux.alibaba.com, zhenzao@linux.alibaba.com, helinguo@linux.alibaba.com, gerry@linux.alibaba.com, mst@redhat.com, cohuck@redhat.com, jasowang@redhat.com, Jan Kiszka <jan.kiszka@siemens.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 30 Nov 2022 16:02:48 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> The virtio-ism device provides the ability to share memory between
> different guests on a host. A guest's memory got from ism device can be
> shared with multiple peers at the same time. This shared relationship
> can be dynamically created and released.
>
> The shared memory obtained from the device is divided into multiple ism
> regions for share. ISM device provides a mechanism to notify other ism
> region referrers of content update events.
>
> This patch is to reserve the next available device ID for virtio-ism.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/150

I think we can vote first to merge this first.

Thanks.


>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
> Signed-off-by: Tony Lu <tonylu@linux.alibaba.com>
> Signed-off-by: Helin Guo <helinguo@linux.alibaba.com>
> Signed-off-by: Hans Zhang <hans@linux.alibaba.com>
> Signed-off-by: He Rongguang <herongguang@linux.alibaba.com>
> ---
>  content.tex | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/content.tex b/content.tex
> index 91ba76c..7302365 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -2992,6 +2992,8 @@ \chapter{Device Types}\label{sec:Device Types}
>  \hline
>  43         &   Camera device \\
>  \hline
> +44         &   ISM device \\
> +\hline
>  \end{tabular}
>
>  Some of the devices above are unspecified by this document,
> --
> 2.32.0.3.g01195cf9f
>

