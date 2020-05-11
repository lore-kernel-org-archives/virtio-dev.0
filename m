Return-Path: virtio-comment-return-1229-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
MIME-Version: 1.0
References: <158895811782.529821.115832709184722087.stgit@ahduyck-workstation>
 <158895818234.529821.13300630585219085797.stgit@ahduyck-workstation> <20200511140951.2afe0cca.cohuck@redhat.com>
In-Reply-To: <20200511140951.2afe0cca.cohuck@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 11 May 2020 08:22:02 -0700
Message-ID: <CAKgT0UcE24vBfQZDpNNMh0FMAkAN0SyZzPMnfznmXbJth-fVYQ@mail.gmail.com>
Subject: [virtio-comment] Re: [PATCH 1/3] content: Document balloon feature free page hints
Content-Type: text/plain; charset="UTF-8"
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, virtio-dev@lists.oasis-open.org, "Wang, Wei W" <wei.w.wang@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, May 11, 2020 at 5:10 AM Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Fri, 08 May 2020 10:16:22 -0700
> Alexander Duyck <alexander.duyck@gmail.com> wrote:
>
> > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >
> > Free page hints allow the balloon driver to provide information on what
> > pages are not currently in use so that we can avoid the cost of copying
> > them in migration scenarios. Add a feature description for free page hints
> > describing basic functioning and requirements.
> >
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > ---
> >  content.tex |  128 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 122 insertions(+), 6 deletions(-)
> >
>

I've taken care of the spelling/grammar items pointed out. Will be
fixed for next version.

> > +hinting request.
> > +
> > +The driver SHOULD return pages for use once \field{free_page_hint_cmd_id}
> > +reports a value of VIRTIO_BALLOON_CMD_ID_DONE.
> > +
> > +\devicenormative{\paragraph}{Free Page Hinting}{Device Types / Memory Balloon Device / Device Operation / Free Page Hinting}
> > +
> > +Normative statements in this section apply if the
> > +VIRTIO_BALLOON_F_FREE_PAGE_HINT feature has been negotiated.
> > +
> > +The device MUST set \field{free_page_hint_cmd_id} to
> > +VIRTIO_BALLOON_CMD_ID_STOP any time that the dirty pages for the given
> > +guest are being recorded.
> > +
> > +The device MUST NOT reuse a command ID until it has received an output
>
> What does 'reuse' mean in this context? I would expect that it is
> forbidden to do the following:
> - device sets id in config space
> - driver queues descriptor with id
> - device changes id to anything other than the current id or the
>   reserved ids <== bad
>
> Maybe "The device MUST NOT change a command ID actively in use by the
> driver until..." ?

Actually what I was referring to was something more like:
- device sets the ID <n> in config space
- device sets the ID value to CMD_ID_STOP.
- device set the ID value to <n> again.

In order to be able to do that the driver has to reply indicating it
has stopped reporting hints before we can go back and reuse <n>. The
expectation is that the device will use <n+1> when it resumes.

This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

