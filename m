Return-Path: virtio-comment-return-1429-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
MIME-Version: 1.0
References: <159827814858.192353.8993077724330545555.stgit@ahduyck-workstation>
 <159827822200.192353.2054100263606468640.stgit@ahduyck-workstation> <20200824171935.67055848.cohuck@redhat.com>
In-Reply-To: <20200824171935.67055848.cohuck@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 24 Aug 2020 08:35:23 -0700
Message-ID: <CAKgT0UdCuzPfpM6GJ4RsnsNjc2Mstnf6rarWNSEF-huMzCccgw@mail.gmail.com>
Subject: [virtio-comment] Re: [PATCH v7 1/3] content: Document balloon feature free page hints
Content-Type: text/plain; charset="UTF-8"
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Wang, Wei W" <wei.w.wang@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Aug 24, 2020 at 8:19 AM Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Mon, 24 Aug 2020 07:10:22 -0700
> Alexander Duyck <alexander.duyck@gmail.com> wrote:
>
> > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >
> > Free page hints allow the balloon driver to provide information on what
> > pages are not currently in use so that we can avoid the cost of copying
> > them in migration scenarios. Add a feature description for free page hints
> > describing basic functioning and requirements.
> >
> > In working on this the specification as pointed out certain issues with the
> > Linux driver and QEMU device implementation. The issues include:
> > 1. The Linux driver does not re-initialize pages when it reuses them
> > before receiving the "DONE" command, as such this can lead to possible data
> > corruption.
> > 2. The QEMU device is not returning the "DONE" command if a migration
> > fails. This results in the guest holding onto pages until forced out by the
> > shrinker.
> >
> > There are also additional issues that have been found not related to the
> > specification.
> >
> > There is currently discussion on if the feature should be removed so this
> > patch is a place-holder for if we decide to keep the feature and fix the
> > issues. Otherwise this patch can be dropped and we can work on a patch to
> > document the need to avoid the feature.
>
> I think we should drop this paragraph?
>
> Otherwise,
> Acked-by: Cornelia Huck <cohuck@redhat.com>

Yeah, I should probably update this. I could probably drop everything
after the first paragraph since I believe we addressed these items as
needed in the Linux and QEMU implementation.

Thanks.

- Alex

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

