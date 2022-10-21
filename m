Return-Path: <virtio-dev-return-10087-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 994F898658F
	for <virtio-dev@lists.oasis-open.org>; Fri, 21 Oct 2022 12:12:27 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20221014141826.502247-1-hrishivarya.bhageeradhan@opensynergy.com>
References: <20221014141826.502247-1-hrishivarya.bhageeradhan@opensynergy.com>
Date: Fri, 21 Oct 2022 14:12:20 +0200
Message-ID: <87ilkd9xzv.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH] content: reserve device ID 43 for Camera
 device
Content-Type: text/plain
To: hrishivarya.bhageeradhan@opensynergy.com, virtio-dev@lists.oasis-open.org, hrishivarya.bhageeradhan@opensynergy.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Oct 14 2022, hrishivarya.bhageeradhan@opensynergy.com wrote:

> From: Hrishivarya Bhageeradhan <hrishivarya.bhageeradhan@opensynergy.com>
>
> The virtio-camera device allows to stream a camera video with
> ability to change controls, formats and get camera captures.
> This patch is to reserve the next available device ID for
> virtio-camera.

Does this device relate in any way to the already reserved video
{en,de}coder devices (ids 30, 31)? Or is this intended to more actively
control how a physical camera processes video?

[The video devices 30 and 31 do not have a specification included in the
virtio spec, unfortunately.]

>
> Signed-off-by: Hrishivarya Bhageeradhan <hrishivarya.bhageeradhan@opensynergy.com>
> ---
>  content.tex | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/content.tex b/content.tex
> index e863709..91ba76c 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -2990,6 +2990,8 @@ \chapter{Device Types}\label{sec:Device Types}
>  \hline
>  42         &   RDMA device \\
>  \hline
> +43         &   Camera device \\
> +\hline
>  \end{tabular}
>
>  Some of the devices above are unspecified by this document,


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

