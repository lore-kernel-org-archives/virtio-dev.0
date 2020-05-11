Return-Path: virtio-comment-return-1233-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
MIME-Version: 1.0
References: <158895811782.529821.115832709184722087.stgit@ahduyck-workstation>
 <20200511143823.14d7398e.cohuck@redhat.com> <3f1e5c3e-03ce-bb32-e5a7-4be381477754@redhat.com>
In-Reply-To: <3f1e5c3e-03ce-bb32-e5a7-4be381477754@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 11 May 2020 08:51:25 -0700
Message-ID: <CAKgT0Uch3Tt9rMN7ku3D_OnNnyrV7sLk6_HecLHSOZd-ah87Hw@mail.gmail.com>
Subject: [virtio-comment] Re: [PATCH 0/3] virtio-spec: Add documentation for recently added
 balloon features
Content-Type: text/plain; charset="UTF-8"
To: David Hildenbrand <david@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, virtio-comment@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, "Wang, Wei W" <wei.w.wang@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, May 11, 2020 at 5:44 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 11.05.20 14:38, Cornelia Huck wrote:
> > On Fri, 08 May 2020 10:16:14 -0700
> > Alexander Duyck <alexander.duyck@gmail.com> wrote:
> >
> >> This patch set is meant to add documentation for balloon features that have
> >> been recently added to the Linux kernel[1,2] and that we are currently
> >> working on adding to QEMU[3].
> >>
> >> Changes since RFC:
> >> Incorporated suggestions from Cornelia Huck
> >> Fixed a few additional spelling errors
> >>
> >> [1]: https://lore.kernel.org/lkml/20200211224416.29318.44077.stgit@localhost.localdomain/
> >> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b0c504f154718904ae49349147e3b7e6ae91ffdc
> >> [3]: https://lists.oasis-open.org/archives/virtio-dev/202004/msg00180.html
> >>
> >> ---
> >>
> >> Alexander Duyck (3):
> >>       content: Document balloon feature free page hints
> >>       content: Document balloon feature page poison
> >>       content: Document balloon feature free page reporting
> >>
> >>
> >>  content.tex |  248 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> >>  1 file changed, 242 insertions(+), 6 deletions(-)
> >>
> >> --
> >>
> >
> > I think this has moved a lot into the right direction; but the patches
> > would really benefit from review by someone more familiar with the
> > balloon than me.
>
> On my list, will have a look this week.
>
> Minor nit I spotted: Patch #2 should not document things (e.g., how
> poisoning interacts with reported pages), before the free reporting
> feature is actually introduced in patch #3.

I'll tweak thinks a bit to work around that. The issue is that the
page poison feature was introduced before page reporting, however it
wasn't really put into use until page reporting was added.

> BTW: Thanks Alex for tackling this!

No problem. Thanks to you and Cornelia for taking the time to review this.

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

