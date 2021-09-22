Return-Path: <virtio-dev-return-8704-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A9FD698636E
	for <virtio-dev@lists.oasis-open.org>; Wed, 22 Sep 2021 11:28:27 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20210903080303.39915-1-weijunji@bytedance.com>
References: <20210903080303.39915-1-weijunji@bytedance.com>
Date: Wed, 22 Sep 2021 13:28:12 +0200
Message-ID: <87czp0g88j.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH] Reserve device id for RDMA device
Content-Type: text/plain
To: Junji Wei <weijunji@bytedance.com>, virtio-dev@lists.oasis-open.org
Cc: weijunji@bytedance.com, dledford@redhat.com, jgg@ziepe.ca, mst@redhat.com, jasowang@redhat.com, yuval.shaia.ml@gmail.com, marcel.apfelbaum@gmail.com, hare@suse.de, xieyongji@bytedance.com, chaiwen.cc@bytedance.com, dingtao.darren@bytedance.com, duanxiongchun@bytedance.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Sep 03 2021, Junji Wei <weijunji@bytedance.com> wrote:

> Use device ID 42
>
> Signed-off-by: Junji Wei <weijunji@bytedance.com>
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

Do we have an answer to the issues raised with the QEMU patches? IOW, is
it reasonable to expect that we can actually implement a usuable RDMA
device? While device IDs are generally cheap, it would be good not to
have too many dead entries.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

