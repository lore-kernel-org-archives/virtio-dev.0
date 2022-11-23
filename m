Return-Path: <xuanzhuo@linux.alibaba.com>
Message-ID: <1669202497.092381-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] content: reserve device ID 44 for ISM device
Date: Wed, 23 Nov 2022 19:21:37 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20221123112109.37560-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20221123112109.37560-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: hans@linux.alibaba.com, herongguang@linux.alibaba.com, zmlcc@linux.alibaba.com, dust.li@linux.alibaba.com, tonylu@linux.alibaba.com, zhenzao@linux.alibaba.com, helinguo@linux.alibaba.com, gerry@linux.alibaba.com, mst@redhat.com, cohuck@redhat.com, jasowang@redhat.com, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 23 Nov 2022 19:21:09 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> The virtio-ism device provides the ability to share memory between
> different guests on a host. A guest's memory got from ism device can be
> shared with multiple peers at the same time. This shared relationship
> can be dynamically created and released.
>
> The shared memory obtained from the device is divided into multiple ism
> regions for share. ISM device provides a mechanism to notify other ism
> region referrers of content update events.

The last spec version:

	https://lists.oasis-open.org/archives/virtio-dev/202211/msg00001.html

Thanks.


>
> This patch is to reserve the next available device ID for virtio-ism.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
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

