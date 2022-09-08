Return-Path: <virtio-return-3860-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20220908083044.95376-1-mst@redhat.com>
References: <20220908083044.95376-1-mst@redhat.com>
Date: Thu, 08 Sep 2022 11:11:40 +0200
Message-ID: <87sfl2s01f.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio] Re: [virtio-dev] [PATCH] audio->sound
Content-Type: text/plain
To: "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Sep 08 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> Spec calls the device "sound device". Make the name in the
> ID section match.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  content.tex | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/content.tex b/content.tex
> index 5c66e6b..279998a 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -3014,7 +3014,7 @@ \chapter{Device Types}\label{sec:Device Types}
>  \hline
>  24         &   Memory device \\
>  \hline
> -25         &   Audio device \\
> +25         &   Sound device \\
>  \hline
>  26         &   file system device \\
>  \hline

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Actually, under the title "Sound device", the spec says

"The virtio sound card is a virtual audio device..."

-- should it be "virtio sound device" instead?


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

