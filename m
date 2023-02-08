Return-Path: <virtio-comment-return-4055-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
MIME-Version: 1.0
References: <20230206084746.40536-1-alvaro.karsz@solid-run.com>
 <PH0PR12MB54817FE12FD77CC74B36D136DCDA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230206160206-mutt-send-email-mst@kernel.org> <PH0PR12MB54818A5BD25527FEAEAFF6CCDCDA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230206171410-mutt-send-email-mst@kernel.org> <DM8PR12MB54806C5AF84EB7974D80FE0EDCDA9@DM8PR12MB5480.namprd12.prod.outlook.com>
 <20230207091242-mutt-send-email-mst@kernel.org> <PH0PR12MB5481BBF4B010D1B197DEF27FDCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230208123630-mutt-send-email-mst@kernel.org> <PH0PR12MB5481170F1BAAFD7B46D4749BDCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481170F1BAAFD7B46D4749BDCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Wed, 8 Feb 2023 20:11:55 +0200
Message-ID: <CAJs=3_DGGER9z1gnzxt_XumLe7Gz4f01e9rtt0fcXkUyKdO5gQ@mail.gmail.com>
Subject: Re: [virtio-comment] RE: [virtio-dev] [PATCH] virtio-net: Fix and
 update VIRTIO_NET_F_NOTF_COAL feature
Content-Type: text/plain; charset="UTF-8"
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, February 8, 2023 12:39 PM
> >
> > On Wed, Feb 08, 2023 at 05:30:28PM +0000, Parav Pandit wrote:
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Tuesday, February 7, 2023 9:18 AM
> > >
> > > > > Why migration generate too many spurious interrupts?
> > > >
> > > > Because, you might want to migrate from hardware with to hardware
> > > > without coalescing features. So you just tell guest "sure I will
> > > > coalesce" but in fact send interrupts normally.
> > >
> > > For the hardware that has fake coalescing, HV wouldn't know it anyway
> > without doing pre verification.
> > > And HV may not migrate in such case for best experience.
> > > HV may choose to migrate with low accuracy as you say, which is fine.
> > >
> > > But the spec guidance for the device implementations is to promote some
> > reasonable level of accuracy.
> > > Hard to define in words here.
> > > Best effort is wide spectrum of range. :)
> > >
> > > Typically, we say in the spec as SHOULD.
> > > So, lets skip the best-effort wording and stick to SHOULD part like rest of the
> > spec.
> >
> > I think the point of best-effort is that driver must handle interrupts that arrive
> > earlier.
> Ok. so Let's put this must requirement in the driver section like the rest.

But this requirement is already written in "Driver Requirements: Used
Buffer Notification Suppression".
Handling spurious interrupts is not NOTF_COAL specific, but generic,
regardless of NOTF_COAL.
So I don't think that this should be written in the NOTF_COAL driver section.

> > This is how we used it elsewhere.
> In a quick grep I see best effort shows two matches one for rx filter and one for vlan.
> Vlan we lately know was (close) to incorrect.
>
> > What else does it include in your
> > opinion that we absolutely must exclude?
> > I feel it's a good fit for a non-conformance section which is by nature a bit
> > informal.
> >
> > For a conformance section SHOULD is indeed a good fit.
> >
> Yes, must in driver section and should in device section looks good to me too.

The whole NOTF_COAL section is about explaining when a device should
issue an interrupt and when not, so writing "The device SHOULD NOT
issue an interrupt when it's not supposed to" seems a bit redundant to
me.

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

