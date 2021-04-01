Return-Path: virtio-dev-return-8128-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2851D98660D
	for <virtio-dev@lists.oasis-open.org>; Thu,  1 Apr 2021 19:39:29 +0000 (UTC)
MIME-Version: 1.0
References: <CABATKF_RAGg-kLvgaRq78T5ADHasvAmAS1=TM7Oc-HLehmaPvg@mail.gmail.com>
In-Reply-To: <CABATKF_RAGg-kLvgaRq78T5ADHasvAmAS1=TM7Oc-HLehmaPvg@mail.gmail.com>
From: Enrico Granata <egranata@google.com>
Date: Thu, 1 Apr 2021 13:39:16 -0600
Message-ID: <CAPR809uhMqrDUFg_iFjYnenezt1siRCm1dV+uM+5UdJukeGFow@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH] Reserve device id for audio policy device
Content-Type: text/plain; charset="UTF-8"
To: Hao Chen <chenhaosjtuacm@google.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Reviewed-By: Enrico Granata <egranata@google.com>

On Thu, Apr 1, 2021 at 12:56 PM Hao Chen <chenhaosjtuacm@google.com> wrote:
>
> Use device ID 39
>
> Signed-off-by: Hao Chen <chenhaosjtuacm@google.com>
> ---
>  content.tex | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/content.tex b/content.tex
> index b72bad0..72cb32d 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -2870,6 +2870,8 @@ \chapter{Device Types}\label{sec:Device Types}
>  \hline
>  36         &   CAN device \\
>  \hline
> +39         &   Audio policy device \\
> +\hline
>  \end{tabular}
>
>  Some of the devices above are unspecified by this document,
> --
> 2.31.0.208.g409f899ff0-goog

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

