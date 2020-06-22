Return-Path: virtio-dev-return-7500-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5B50E985F21
	for <virtio-dev@lists.oasis-open.org>; Mon, 22 Jun 2020 22:37:45 +0000 (UTC)
MIME-Version: 1.0
References: <20200619214912.25598.8400.stgit@localhost.localdomain>
 <20200619215309.25598.7553.stgit@localhost.localdomain> <acac152a-8be5-aa5c-ca52-e5ffc90b6ed4@redhat.com>
In-Reply-To: <acac152a-8be5-aa5c-ca52-e5ffc90b6ed4@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 22 Jun 2020 15:37:33 -0700
Message-ID: <CAKgT0UcP6gGK_X80pepwpsC=JFmL9+n61ow-HEJMKbFVZ4Jh8g@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH 1/2] virtio-balloon: Prevent guest from starting a report
 when we didn't request one
Content-Type: text/plain; charset="UTF-8"
To: David Hildenbrand <david@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jun 22, 2020 at 1:10 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 19.06.20 23:53, Alexander Duyck wrote:
> > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >
> > Based on code review it appears possible for the driver to force the device
> > out of a stopped state when hinting by repeating the last ID it was
> > provided.
>
> Indeed, thanks for noticing.
>
> >
> > Prevent this by only allowing a transition to the start state when we are
> > in the requested state. This way the driver is only allowed to send one
> > descriptor that will transition the device into the start state. All others
> > will leave it in the stop state once it has finished.
> >
> > In addition add the necessary locking to provent any potential races
>
> s/provent/prevent/

Thanks for catching that. I will fix the typo.

> > between the accesses of the cmd_id and the status.
> >
> > Fixes: c13c4153f76d ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > ---
> >  hw/virtio/virtio-balloon.c |   11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> > index 10507b2a430a..7f3af266f674 100644
> > --- a/hw/virtio/virtio-balloon.c
> > +++ b/hw/virtio/virtio-balloon.c
> > @@ -527,7 +527,8 @@ static bool get_free_page_hints(VirtIOBalloon *dev)
> >              ret = false;
> >              goto out;
> >          }
> > -        if (id == dev->free_page_report_cmd_id) {
> > +        if (dev->free_page_report_status == FREE_PAGE_REPORT_S_REQUESTED &&
> > +            id == dev->free_page_report_cmd_id) {
> >              dev->free_page_report_status = FREE_PAGE_REPORT_S_START;
> >          } else {
> >              /*
>
> But doesn't that mean that, after the first hint, all further ones will
> be discarded and we'll enter the STOP state in the else case? Or am I
> missing something?
>
> Shouldn't this be something like
>
> if (id == dev->free_page_report_cmd_id) {
>     if (dev->free_page_report_status == FREE_PAGE_REPORT_S_REQUESTED) {
>         dev->free_page_report_status = FREE_PAGE_REPORT_S_START;
>     }
>     /* Stay in FREE_PAGE_REPORT_S_START as long as the cmd_id match .*/
> } else { ...

There should only be one element containing an outbuf at the start of
the report. Once that is processed we should not see the driver
sending additional outbufs unless it is sending the STOP command ID.

> > @@ -592,14 +593,16 @@ static void virtio_balloon_free_page_start(VirtIOBalloon *s)
> >          return;
> >      }
> >
> > -    if (s->free_page_report_cmd_id == UINT_MAX) {
> > +    qemu_mutex_lock(&s->free_page_lock);
> > +
> > +    if (s->free_page_report_cmd_id++ == UINT_MAX) {
> >          s->free_page_report_cmd_id =
> >                         VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;
> > -    } else {
> > -        s->free_page_report_cmd_id++;
> >      }
>
> Somewhat unrelated cleanup.

Agreed. I can drop it if preferred. I just took care of it because I
was adding the lock above and below to prevent us from getting into
any wierd states where the command ID might be updated but the report
status was not.

> >
> >      s->free_page_report_status = FREE_PAGE_REPORT_S_REQUESTED;
> > +    qemu_mutex_unlock(&s->free_page_lock);
> > +
> >      virtio_notify_config(vdev);
> >  }
> >
> >
>
>
> --
> Thanks,
>
> David / dhildenb
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

