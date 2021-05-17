Return-Path: virtio-dev-return-8165-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4065E985E01
	for <virtio-dev@lists.oasis-open.org>; Mon, 17 May 2021 15:55:28 +0000 (UTC)
MIME-Version: 1.0
References: <20210505193655.2414268-1-egranata@google.com> <CAPR809ukYeThsPy4eg8A-G8b4Hwt7Prxh9P75=Vp9jnCKb6WqQ@mail.gmail.com>
 <20210517123300.0ea826ef.cohuck@redhat.com>
In-Reply-To: <20210517123300.0ea826ef.cohuck@redhat.com>
From: Enrico Granata <egranata@google.com>
Date: Mon, 17 May 2021 09:55:16 -0600
Message-ID: <CAPR809vrz4+WRxSJ=BtQGeKLgHCeMwgB8xq9E+Ei8kykKbPfbA@mail.gmail.com>
Subject: Re: [virtio-dev] Fwd: [PATCH v2] Provide detailed specification of
 virtio-blk lifetime metrics
Content-Type: text/plain; charset="UTF-8"
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

I believe the proposal was Acked-By and didn't receive any strong pushback

The only open point of discussion was whether to rename the feature
flag to F_EMMC_LIFETIME in order to open the door for F_NVME_LIFETIME
I think, but I didn't hear any comment on that

Thanks,
- Enrico

On Mon, May 17, 2021 at 4:33 AM Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Wed, 5 May 2021 13:37:26 -0600
> Enrico Granata <egranata@google.com> wrote:
>
> > ---------- Forwarded message ---------
> > From: Enrico Granata <egranata@google.com>
> > Date: Wed, May 5, 2021 at 1:37 PM
> > Subject: [PATCH v2] Provide detailed specification of virtio-blk
> > lifetime metrics
> > To: <virtio-dev@lists.oasis-open.org>
> > Cc: <egranata@google.com>, <hch@infradead.org>, <mst@redhat.com>,
> > <linux-block@vger.kernel.org>,
> > <virtualization@lists.linux-foundation.org>
> >
> >
> > In the course of review, some concerns were surfaced about the
> > original virtio-blk lifetime proposal, as it depends on the eMMC
> > spec which is not open
> >
> > Add a more detailed description of the meaning of the fields
> > added by that proposal to the virtio-blk specification, as to
> > make it feasible to understand and implement the new lifetime
> > metrics feature without needing to refer to JEDEC's specification
> >
> > This patch does not change the meaning of those fields nor add
> > any new fields, but it is intended to provide an open and more
> > clear description of the meaning associated with those fields.
> >
> > Signed-off-by: Enrico Granata <egranata@google.com>
> > ---
> > Changes in v2:
> >   - clarified JEDEC references;
> >   - added VIRTIO_BLK prefix and cleaned up comment syntax;
> >   - clarified reserved block references
> >
> >  content.tex | 40 ++++++++++++++++++++++++++++++++--------
> >  1 file changed, 32 insertions(+), 8 deletions(-)
>
> Do we have a consent here? I see the mails are not showing up on all of
> the lists, so I'm a bit confused regarding the state of this...
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

