Return-Path: virtio-dev-return-8113-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E6BC19864A9
	for <virtio-dev@lists.oasis-open.org>; Tue, 16 Mar 2021 16:40:51 +0000 (UTC)
MIME-Version: 1.0
References: <CAPR809sesHT9M+5jmQho-4m1L1QufPgE6A_RGWmYqbnM52qSkQ@mail.gmail.com>
 <20210315122709.33c4f128.cohuck@redhat.com>
In-Reply-To: <20210315122709.33c4f128.cohuck@redhat.com>
From: Enrico Granata <egranata@google.com>
Date: Tue, 16 Mar 2021 10:40:39 -0600
Message-ID: <CAPR809uB1OSN8Uu5-irGNjQqqS+tGoid4Dbi8h-Q7dKRV3pXfg@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH v5] Add lifetime metrics to virtio-blk
Content-Type: text/plain; charset="UTF-8"
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Please do start a vote on this issue at your earliest convenience

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/97

Thanks,
- Enrico

On Mon, Mar 15, 2021 at 5:27 AM Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Tue, 9 Mar 2021 14:20:14 -0700
> Enrico Granata <egranata@google.com> wrote:
>
> > In many embedded systems, virtio-blk implementations are
> > backed by eMMC or UFS storage devices, which are subject to
> > predictable and measurable wear over time due to repeated write
> > cycles.
> >
> > For such systems, it can be important to be able to track
> > accurately the amount of wear imposed on the storage over
> > time and surface it to applications. In a native deployments
> > this is generally handled by the physical block device driver
> > but no such provision is made in virtio-blk to expose these
> > metrics for devices where it makes sense to do so.
> >
> > This patch adds support to virtio-blk for lifetime and wear
> > metrics to be exposed to the guest when a deployment of
> > virtio-blk is done over compatible eMMC or UFS storage.
> >
> > Signed-off-by: Enrico Granata <egranata@google.com>
> > Fixes: https://github.org/oasis-tcs/virtio-spec/issues/97
> > ---
> >  content.tex | 35 +++++++++++++++++++++++++++++++++--
> >  1 file changed, 33 insertions(+), 2 deletions(-)
> >
> > diff --git a/content.tex b/content.tex
> > index b72bad0..75631ba 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -4418,6 +4418,9 @@ \subsection{Feature bits}\label{sec:Device Types
> > / Block Device / Feature bits}
>
> There still seems to be something wrong with the line wrapping in this
> patch (won't apply without manual massaging) -- can you please
> double-check your setup?
>
> That said, I think we can still vote on this patch; please add the link
> to this version to the github issue if you think it's time for voting.
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

