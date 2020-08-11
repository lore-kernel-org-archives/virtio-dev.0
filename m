Return-Path: virtio-comment-return-1396-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Lars Ganrot <lga@napatech.com>
Date: Tue, 11 Aug 2020 15:43:44 +0000
Message-ID: <49f4f4c248a844d4a51f97308adf19b3@napatech.com>
References: <20200810161501.1572834-1-mst@redhat.com>
 <20200810185928.2e722231.cohuck@redhat.com>
 <20200811042047-mutt-send-email-mst@kernel.org>
 <3e1f1c3f6b3a44daabf3cfca1d3e3f66@napatech.com>
In-Reply-To: <3e1f1c3f6b3a44daabf3cfca1d3e3f66@napatech.com>
Content-Language: en-US
MIME-Version: 1.0
Subject: [virtio-comment] RE: [virtio-dev] Re: [virtio] [PATCH RFC] VIRTIO_F_PARTIAL_ORDER for
 page fault handling
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Lars Ganrot <lga@napatech.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

> From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> open.org> On Behalf Of Lars Ganrot
> Sent: 11. august 2020 16:54
>=20
> > From: virtio-dev@lists.oasis-open.org
> > <virtio-dev@lists.oasis-open.org> On Behalf Of Michael S. Tsirkin
> > Sent: 11. august 2020 10:23
> >
> > On Mon, Aug 10, 2020 at 06:59:28PM +0200, Cornelia Huck wrote:
> > > On Mon, 10 Aug 2020 12:15:15 -0400
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >
> > > > Devices that normally use buffers in order can benefit from
> > > > ability to temporarily switch to handle some buffers out of order.
> > > >
> > > > As a case in point, a networking device might handle RX buffers in
> > > > order normally. However, should an access to an RX buffer cause a
> > > > page fault (e.g. when using PRI), the device could benefit from
> > > > ability to temporarily keep using following buffers in the ring
> > > > (possibly with higher overhead) until the fault has been resolved.
> > > >
> > > > Page faults allow more features such as THP, auto-NUMA, live
> > > > migration.
> > > >
> > > > Out of order is of course already possible, however, IN_ORDER is
> > > > currently required for descriptor batching where device marks a
> > > > whole batch of buffers used in one go.
> > > >
> > > > The idea behind this proposal is to relax that requirement,
> > > > allowing batching without asking device to be in orde rat all
> > > > times, as
> > > > follows:
> > > >
> > > > Device uses buffers in any order. Eventually when device detects
> > > > that it has used all previously outstanding buffers, it sets a
> > > > FLUSH flag on the last buffer used. If it set this flag on the
> > > > last buffer used previously, and now uses a batch of descriptors
> > > > in-order, it can now signal the last buffer used again setting the =
FLUSH
> flag.
> > > >
> > > > Driver can detect in-order when it sees two FLUSH flags one after
> > > > another. In other respects the feature is similar to IN_ORDER from
> > > > the driver implementation POV.
> > > >
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > ---
> > > >  content.tex     |  9 ++++++++-
> > > >  packed-ring.tex | 23 +++++++++++++++++++++++  split-ring.tex  |
> > > > 26
> > > > ++++++++++++++++++++++++--
> > > >  3 files changed, 55 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/content.tex b/content.tex index 91735e3..8494eb6
> > > > 100644
> > > > --- a/content.tex
> > > > +++ b/content.tex
> > > > @@ -296,7 +296,11 @@ \section{Virtqueues}\label{sec:Basic
> > > > Facilities of a Virtio Device / Virtqueues}
> > > >
> > > >  Some devices always use descriptors in the same order in which
> > > > they have been made available. These devices can offer the
> > > > -VIRTIO_F_IN_ORDER feature. If negotiated, this knowledge
> > > > +VIRTIO_F_IN_ORDER feature.  Other devices sometimes use
> > > > +descriptors in the same order in which they have been made
> > > > +available. These devices can offer the VIRTIO_F_PARTIAL_ORDER
> > > > +feature. If one of the features VIRTIO_F_IN_ORDER or
> > > > +VIRTIO_F_PARTIAL_ORDER is
> > negotiated,
> > > > +this knowledge
> > >
> > > Do these two features conflict with each other? I.e., at most one of
> > > them may be negotiated (or offered?) at a time?
> >
> > Good point. I think so, yes. Will document.
>=20
> Isn't it more natural to think of VIRTIO_F_IN_ORDER as the simple case wh=
ich
> always maintains ordered access, while the new feature flag allows active
> control of when descriptors are ordered and when not? To make it backward
> compatible let VIRTIO_F_IN_ORDER imply the new bit is set, while the new =
bit
> set by itself without VIRTIO_F_IN_ORDER set means only active control is
> offered. I guess a name like VIRTIO_F_CTRL_ORDER would be more
> appropriate with this interpretation.
>=20

On second thought that might be a bit backwards - how about:

Legacy case: VIRTIO_F_IN_ORDER=3D=3D0/1 + VIRTIO_F_ORDER_RELAX=3D=3D0
This proposal: VIRTIO_F_IN_ORDER=3D=3D1 + VIRTIO_F_ORDER_RELAX=3D=3D1
Potential future use: VIRTIO_F_???_ORDER=3D=3D1 + VIRTIO_F_ORDER_RELAX=3D=
=3D0/1

>=20
>=20
> This publicly archived list offers a means to provide input to theOASIS V=
irtual
> I/O Device (VIRTIO) TC.In order to verify user consent to the Feedback Li=
cense
> terms andto minimize spam in the list archive, subscription is requiredbe=
fore
> posting.Subscribe: virtio-comment-subscribe@lists.oasis-
> open.orgUnsubscribe: virtio-comment-unsubscribe@lists.oasis-open.orgList
> help: virtio-comment-help@lists.oasis-open.orgList archive: https://lists=
.oasis-
> open.org/archives/virtio-comment/Feedback License: https://www.oasis-
> open.org/who/ipr/feedback_license.pdfList Guidelines: https://www.oasis-
> open.org/policies-guidelines/mailing-listsCommittee: https://www.oasis-
> open.org/committees/virtio/Join OASIS: https://www.oasis-open.org/join/


This publicly archived list offers a means to provide input to the=0D
OASIS Virtual I/O Device (VIRTIO) TC.=0D
=0D
In order to verify user consent to the Feedback License terms and=0D
to minimize spam in the list archive, subscription is required=0D
before posting.=0D
=0D
Subscribe: virtio-comment-subscribe@lists.oasis-open.org=0D
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org=0D
List help: virtio-comment-help@lists.oasis-open.org=0D
List archive: https://lists.oasis-open.org/archives/virtio-comment/=0D
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf=
=0D
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts=0D
Committee: https://www.oasis-open.org/committees/virtio/=0D
Join OASIS: https://www.oasis-open.org/join/

