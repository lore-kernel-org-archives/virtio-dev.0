Return-Path: <egranata@google.com>
MIME-Version: 1.0
References: <20210505193655.2414268-1-egranata@google.com> <CAPR809ukYeThsPy4eg8A-G8b4Hwt7Prxh9P75=Vp9jnCKb6WqQ@mail.gmail.com>
 <YO6ro345FI0XE8vv@stefanha-x1.localdomain> <87pmvlck3p.fsf@redhat.com> <YO7zwKbH6OEW2z1o@stefanha-x1.localdomain>
In-Reply-To: <YO7zwKbH6OEW2z1o@stefanha-x1.localdomain>
From: Enrico Granata <egranata@google.com>
Date: Fri, 6 Aug 2021 13:19:35 -0600
Message-ID: <CAPR809uuo=5kmzUs3RFp6z_4===R0hxdFiScLPouUS+qxdaVWg@mail.gmail.com>
Subject: Re: [virtio-dev] Fwd: [PATCH v2] Provide detailed specification of
 virtio-blk lifetime metrics
Content-Type: text/plain; charset="UTF-8"
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, virtio-dev@lists.oasis-open.org, linux-block@vger.kernel.org, virtualization@lists.linux-foundation.org, hch@infradead.org
List-ID: <virtio-dev.lists.oasis-open.org>

Hi folks,
I am back from my leave of absence, so thank you everyone for your patience

This proposal has been outstanding for a while and didn't seem to
receive pushback, especially compared to the initial proposal

Would it be the right time to put this modification up for a vote?

Thanks,
- Enrico

Thanks,
- Enrico


On Wed, Jul 14, 2021 at 8:25 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Wed, Jul 14, 2021 at 11:36:58AM +0200, Cornelia Huck wrote:
> > On Wed, Jul 14 2021, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> >
> > > On Wed, May 05, 2021 at 12:37:26PM -0700, Enrico Granata wrote:
> > >> ---------- Forwarded message ---------
> > >> From: Enrico Granata <egranata@google.com>
> > >> Date: Wed, May 5, 2021 at 1:37 PM
> > >> Subject: [PATCH v2] Provide detailed specification of virtio-blk
> > >> lifetime metrics
> > >> To: <virtio-dev@lists.oasis-open.org>
> > >> Cc: <egranata@google.com>, <hch@infradead.org>, <mst@redhat.com>,
> > >> <linux-block@vger.kernel.org>,
> > >> <virtualization@lists.linux-foundation.org>
> > >>
> > >>
> > >> In the course of review, some concerns were surfaced about the
> > >> original virtio-blk lifetime proposal, as it depends on the eMMC
> > >> spec which is not open
> > >>
> > >> Add a more detailed description of the meaning of the fields
> > >> added by that proposal to the virtio-blk specification, as to
> > >> make it feasible to understand and implement the new lifetime
> > >> metrics feature without needing to refer to JEDEC's specification
> > >>
> > >> This patch does not change the meaning of those fields nor add
> > >> any new fields, but it is intended to provide an open and more
> > >> clear description of the meaning associated with those fields.
> > >>
> > >> Signed-off-by: Enrico Granata <egranata@google.com>
> > >> ---
> > >> Changes in v2:
> > >>   - clarified JEDEC references;
> > >>   - added VIRTIO_BLK prefix and cleaned up comment syntax;
> > >>   - clarified reserved block references
> > >>
> > >>  content.tex | 40 ++++++++++++++++++++++++++++++++--------
> > >>  1 file changed, 32 insertions(+), 8 deletions(-)
> > >
> > > Ping?
> > >
> > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> >
> > [Enrico is currently on leave of absence]
> >
> > Is there any outstanding feedback from the linux-block folks? I've lost
> > track of this, I'm afraid. (Your R-b is the only feedback I see on this
> > list...)
> >
> > We can certainly put up a vote. This is one of the things I wanted to
> > see fixed for the next release of the standard.
>
> I have CCed Christoph, linux-block@, and virtualization@. Here is the
> link to the patch that we're discussing:
> https://patchwork.kernel.org/project/linux-block/patch/20210505193655.2414268-1-egranata@google.com/
>
> Stefan

