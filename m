Return-Path: virtio-dev-return-8078-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 87F07986307
	for <virtio-dev@lists.oasis-open.org>; Mon,  1 Mar 2021 18:34:56 +0000 (UTC)
MIME-Version: 1.0
References: <CAPR809to17OpKuAvoYvdjpZYmVxbTi5umTABc4UZf90iqC0UmA@mail.gmail.com>
 <YD0wg2oFaqqJyID5@stefanha-x1.localdomain>
In-Reply-To: <YD0wg2oFaqqJyID5@stefanha-x1.localdomain>
From: Enrico Granata <egranata@google.com>
Date: Mon, 1 Mar 2021 11:34:43 -0700
Message-ID: <CAPR809s8S8yANT1qt1PUyw-bOtO0jwHVcO=9B18tFsLAJKKHMQ@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH v3] Add lifetime metrics to virtio-blk
Content-Type: text/plain; charset="UTF-8"
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

TC leads, please schedule a vote on resolving this issue

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/97

Thanks,
- Enrico

On Mon, Mar 1, 2021 at 11:21 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Mon, Mar 01, 2021 at 10:51:03AM -0700, Enrico Granata wrote:
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
> > ---
> >  content.tex | 31 +++++++++++++++++++++++++++++--
> >  1 file changed, 29 insertions(+), 2 deletions(-)
>
> Great, please request a Technical Committee vote:
> https://github.com/oasis-tcs/virtio-spec/#use-of-github-issues
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

