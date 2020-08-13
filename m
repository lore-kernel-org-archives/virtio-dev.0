Return-Path: virtio-return-3436-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Thu, 13 Aug 2020 16:45:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200813164212-mutt-send-email-mst@kernel.org>
References: <20200810161501.1572834-1-mst@redhat.com>
 <20200810185928.2e722231.cohuck@redhat.com>
 <20200811042047-mutt-send-email-mst@kernel.org>
 <3e1f1c3f6b3a44daabf3cfca1d3e3f66@napatech.com>
MIME-Version: 1.0
In-Reply-To: <3e1f1c3f6b3a44daabf3cfca1d3e3f66@napatech.com>
Subject: [virtio] Re: [virtio-dev] Re: [virtio] [PATCH RFC] VIRTIO_F_PARTIAL_ORDER for
 page fault handling
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Lars Ganrot <lga@napatech.com>
Cc: Cornelia Huck <cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Aug 11, 2020 at 02:53:39PM +0000, Lars Ganrot wrote:
> Hi Michael,
> 
> Short comment below.
> 
> BR,
> 
> -Lars
> 
> > From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org> On
> > Behalf Of Michael S. Tsirkin
> > Sent: 11. august 2020 10:23
> >
> > On Mon, Aug 10, 2020 at 06:59:28PM +0200, Cornelia Huck wrote:
> > > On Mon, 10 Aug 2020 12:15:15 -0400
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >
> > > > Devices that normally use buffers in order can benefit from ability
> > > > to temporarily switch to handle some buffers out of order.
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
> > > > The idea behind this proposal is to relax that requirement, allowing
> > > > batching without asking device to be in orde rat all times, as
> > > > follows:
> > > >
> > > > Device uses buffers in any order. Eventually when device detects
> > > > that it has used all previously outstanding buffers, it sets a FLUSH
> > > > flag on the last buffer used. If it set this flag on the last buffer
> > > > used previously, and now uses a batch of descriptors in-order, it
> > > > can now signal the last buffer used again setting the FLUSH flag.
> > > >
> > > > Driver can detect in-order when it sees two FLUSH flags one after
> > > > another. In other respects the feature is similar to IN_ORDER from
> > > > the driver implementation POV.
> > > >
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > ---
> > > >  content.tex     |  9 ++++++++-
> > > >  packed-ring.tex | 23 +++++++++++++++++++++++  split-ring.tex  | 26
> > > > ++++++++++++++++++++++++--
> > > >  3 files changed, 55 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/content.tex b/content.tex index 91735e3..8494eb6 100644
> > > > --- a/content.tex
> > > > +++ b/content.tex
> > > > @@ -296,7 +296,11 @@ \section{Virtqueues}\label{sec:Basic Facilities
> > > > of a Virtio Device / Virtqueues}
> > > >
> > > >  Some devices always use descriptors in the same order in which
> > > > they have been made available. These devices can offer the
> > > > -VIRTIO_F_IN_ORDER feature. If negotiated, this knowledge
> > > > +VIRTIO_F_IN_ORDER feature.  Other devices sometimes use descriptors
> > > > +in the same order in which they have been made available. These
> > > > +devices can offer the VIRTIO_F_PARTIAL_ORDER feature. If one of the
> > > > +features VIRTIO_F_IN_ORDER or VIRTIO_F_PARTIAL_ORDER is
> > negotiated,
> > > > +this knowledge
> > >
> > > Do these two features conflict with each other? I.e., at most one of
> > > them may be negotiated (or offered?) at a time?
> >
> > Good point. I think so, yes. Will document.
> 
> Isn't it more natural to think of VIRTIO_F_IN_ORDER as the simple case
> which always maintains ordered access, while the new feature flag
> allows active control of when descriptors are ordered and when not? To
> make it backward compatible let VIRTIO_F_IN_ORDER imply the new bit is
> set, while the new bit set by itself without VIRTIO_F_IN_ORDER set
> means only active control is offered. I guess a name like
> VIRTIO_F_CTRL_ORDER would be more appropriate with this
> interpretation.


So how does the behaviour with both VIRTIO_F_IN_ORDER with VIRTIO_F_PARTIAL_ORDER
differ from just VIRTIO_F_IN_ORDER? If all buffers are used in order,
then what is the extra meaning of FLUSH?



> 
> Disclaimer: This email and any files transmitted with it may contain
> confidential information intended for the addressee(s) only. The
> information is not to be surrendered or copied to unauthorized
> persons. If you have received this communication in error, please
> notify the sender immediately and delete this e-mail from your system.

I think we are supposed to disregard this part as irrlevant, but just a
reminder that you agreed that all material posted to the
virtio mailing lists is governed by the relevant IPR rules.
It is your responsibility not to post confidential information there.

-- 
MST


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

