Return-Path: virtio-dev-return-4128-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 5F9515818F01
	for <virtio-dev@lists.oasis-open.org>; Tue, 22 May 2018 13:10:05 -0700 (PDT)
References: <20180522191105.14400-1-christoffer.dall@arm.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <73d5412e-33c8-4726-f1a2-8b7e7de020c7@redhat.com>
Date: Tue, 22 May 2018 22:09:51 +0200
MIME-Version: 1.0
In-Reply-To: <20180522191105.14400-1-christoffer.dall@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH] split-ring: Fix typo in used ring description
To: Christoffer Dall <christoffer.dall@arm.com>, virtio-dev@lists.oasis-open.org
Cc: felipe@nutanix.com, stefanha@redhat.com, pbonzini@redhat.com, mst@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 05/22/18 21:11, Christoffer Dall wrote:
> Only the device updates the used ring.
> 
> This looks like a typo as a result of copy-paste from the description of
> the Available Ring.
> 
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/12
> Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
> ---
>  split-ring.tex | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/split-ring.tex b/split-ring.tex
> index df278fe..2267863 100644
> --- a/split-ring.tex
> +++ b/split-ring.tex
> @@ -417,7 +417,7 @@ overwritten the bytes which were in that buffer, this could leak the
>  contents of freed memory from other processes to the application.
>  \end{note}
>  
> -\field{idx} field indicates where the driver would put the next descriptor
> +\field{idx} field indicates where the device would put the next descriptor
>  entry in the ring (modulo the queue size). This starts at 0, and increases.
>  
>  \begin{note}
> 

Good point about this likely being a copypasta error; when I first tried
to look at the context of your patch in "split-ring.tex", I found the
*correct* instance (currently on line 308) and got confused. But, the
line numbers in the hunk header above are OK; on line 420, "driver" is
wrong.

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks
Laszlo

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

