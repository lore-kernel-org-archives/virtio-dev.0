Return-Path: virtio-dev-return-8125-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 595AD9862BC
	for <virtio-dev@lists.oasis-open.org>; Tue, 30 Mar 2021 20:43:02 +0000 (UTC)
MIME-Version: 1.0
References: <CABATKF_wnHQRrmBV=yKE-wrOMGXxX6=Pz=PwgZy+-DXrVQ+7ZA@mail.gmail.com>
 <20210330115114.4cb89229.cohuck@redhat.com> <CABATKF9YyYwBGOhSX0wKRB1t3OG+1DAKdmfzwHnAu5+f+M68Fg@mail.gmail.com>
 <CABATKF-ZvtVyQV1wQwFyejao6aeeu1DGLNtFL1KA4y5=bM+p0A@mail.gmail.com>
In-Reply-To: <CABATKF-ZvtVyQV1wQwFyejao6aeeu1DGLNtFL1KA4y5=bM+p0A@mail.gmail.com>
From: Enrico Granata <egranata@google.com>
Date: Tue, 30 Mar 2021 14:42:50 -0600
Message-ID: <CAPR809ufm4y_8cQ9gPKemWb=mYUN7uNTOTV3Brc2UiSFUgUAXA@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v2] Reserve device id for parameter server
Content-Type: text/plain; charset="UTF-8"
To: Hao Chen <chenhaosjtuacm@google.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Reviewed-By: Enrico Granata <egranata@google.com>

Thanks,
- Enrico

On Tue, Mar 30, 2021 at 2:42 PM Hao Chen <chenhaosjtuacm@google.com> wrote:
>
> ---------- Forwarded message ---------
> From: Hao Chen <chenhaosjtuacm@google.com>
> Date: Tue, Mar 30, 2021 at 12:34 PM
> Subject: [PATCH v2] Reserve device id for parameter server
> To: <virtio-dev@lists.oasis-open.org>
>
>
> Use device ID 38
>
> Signed-off-by: Hao Chen <chenhaosjtuacm@google.com>
> ---
>  content.tex | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/content.tex b/content.tex
> index b72bad0..cc292b3 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -2870,6 +2870,8 @@ \chapter{Device Types}\label{sec:Device Types}
>  \hline
>  36         &   CAN device \\
>  \hline
> +38         &   Parameter Server \\
> +\hline
>  \end{tabular}
>
>  Some of the devices above are unspecified by this document,
> --
> 2.31.0.291.g576ba9dcdaf-goog

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

