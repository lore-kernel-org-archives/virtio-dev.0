Return-Path: virtio-dev-return-8111-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 54A9C986112
	for <virtio-dev@lists.oasis-open.org>; Mon, 15 Mar 2021 11:27:23 +0000 (UTC)
Date: Mon, 15 Mar 2021 12:27:09 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20210315122709.33c4f128.cohuck@redhat.com>
In-Reply-To: <CAPR809sesHT9M+5jmQho-4m1L1QufPgE6A_RGWmYqbnM52qSkQ@mail.gmail.com>
References: <CAPR809sesHT9M+5jmQho-4m1L1QufPgE6A_RGWmYqbnM52qSkQ@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH v5] Add lifetime metrics to virtio-blk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Enrico Granata <egranata@google.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 9 Mar 2021 14:20:14 -0700
Enrico Granata <egranata@google.com> wrote:

> In many embedded systems, virtio-blk implementations are
> backed by eMMC or UFS storage devices, which are subject to
> predictable and measurable wear over time due to repeated write
> cycles.
> 
> For such systems, it can be important to be able to track
> accurately the amount of wear imposed on the storage over
> time and surface it to applications. In a native deployments
> this is generally handled by the physical block device driver
> but no such provision is made in virtio-blk to expose these
> metrics for devices where it makes sense to do so.
> 
> This patch adds support to virtio-blk for lifetime and wear
> metrics to be exposed to the guest when a deployment of
> virtio-blk is done over compatible eMMC or UFS storage.
> 
> Signed-off-by: Enrico Granata <egranata@google.com>
> Fixes: https://github.org/oasis-tcs/virtio-spec/issues/97
> ---
>  content.tex | 35 +++++++++++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/content.tex b/content.tex
> index b72bad0..75631ba 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -4418,6 +4418,9 @@ \subsection{Feature bits}\label{sec:Device Types
> / Block Device / Feature bits}

There still seems to be something wrong with the line wrapping in this
patch (won't apply without manual massaging) -- can you please
double-check your setup?

That said, I think we can still vote on this patch; please add the link
to this version to the github issue if you think it's time for voting.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

