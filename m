Return-Path: <virtio-dev-return-10164-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F154D98662C
	for <virtio-dev@lists.oasis-open.org>; Wed, 16 Nov 2022 02:08:38 +0000 (UTC)
Message-ID: <1668564505.1220481-3-xuanzhuo@linux.alibaba.com>
Date: Wed, 16 Nov 2022 10:08:25 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20221101120428.9500-1-xuanzhuo@linux.alibaba.com>
 <20221101120428.9500-2-xuanzhuo@linux.alibaba.com>
 <87k03xtzdm.fsf@redhat.com>
In-Reply-To: <87k03xtzdm.fsf@redhat.com>
Subject: [virtio-dev] Re: [PATCH v1 1/2] Reserve device id for ISM device
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: Cornelia Huck <cohuck@redhat.com>
Cc: hans@linux.alibaba.com, herongguang@linux.alibaba.com, zmlcc@linux.alibaba.com, dust.li@linux.alibaba.com, tonylu@linux.alibaba.com, zhenzao@linux.alibaba.com, helinguo@linux.alibaba.com, gerry@linux.alibaba.com, mst@redhat.com, jasowang@redhat.com, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 14 Nov 2022 14:54:45 +0100, Cornelia Huck <cohuck@redhat.com> wrote:
> On Tue, Nov 01 2022, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> > Use device ID 43
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> > Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
> > Signed-off-by: Tony Lu <tonylu@linux.alibaba.com>
> > Signed-off-by: Helin Guo <helinguo@linux.alibaba.com>
> > Signed-off-by: Hans Zhang <hans@linux.alibaba.com>
> > Signed-off-by: He Rongguang <herongguang@linux.alibaba.com>
> > ---
> >  content.tex | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/content.tex b/content.tex
> > index e863709..cd006c3 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -2990,6 +2990,8 @@ \chapter{Device Types}\label{sec:Device Types}
> >  \hline
> >  42         &   RDMA device \\
> >  \hline
> > +43         &   ISM device \\
>
> This id has just been taken by virtio-camera.
>
> It might be worth splitting this out, opening an issue, and request a
> vote for this (it seems there's agreement that virtio-ism makes sense in
> general?)

OK.

Thanks.

>
>
> > +\hline
> >  \end{tabular}
> >
> >  Some of the devices above are unspecified by this document,
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

