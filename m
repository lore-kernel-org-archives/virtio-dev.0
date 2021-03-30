Return-Path: virtio-dev-return-8123-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 44BA7986299
	for <virtio-dev@lists.oasis-open.org>; Tue, 30 Mar 2021 09:51:23 +0000 (UTC)
Date: Tue, 30 Mar 2021 11:51:14 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20210330115114.4cb89229.cohuck@redhat.com>
In-Reply-To: <CABATKF_wnHQRrmBV=yKE-wrOMGXxX6=Pz=PwgZy+-DXrVQ+7ZA@mail.gmail.com>
References: <CABATKF_wnHQRrmBV=yKE-wrOMGXxX6=Pz=PwgZy+-DXrVQ+7ZA@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH] Reserve device id for parameter server
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Hao Chen <chenhaosjtuacm@google.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 22 Mar 2021 12:19:11 -0700
Hao Chen <chenhaosjtuacm@google.com> wrote:

> Use device ID 37
> 
> Signed-off-by: Hao Chen <chenhaosjtuacm@google.com>
> ---
>  content.tex | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/content.tex b/content.tex
> index b72bad0..b88e606 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -2870,6 +2870,8 @@ \chapter{Device Types}\label{sec:Device Types}
>  \hline
>  36         &   CAN device \\
>  \hline
> +37         &   Parameter Server \\

37 has already been requested for the Dmabuf device (although I don't
recall a vote being requested for it.)

Maybe better pick 38 for this device?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

