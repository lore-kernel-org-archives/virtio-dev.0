Return-Path: <mst@redhat.com>
Date: Wed, 22 Feb 2023 06:50:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 1/2] virtio-net: Describe dev cfg fields read only
Message-ID: <20230222064936-mutt-send-email-mst@kernel.org>
References: <20230217154529.33508-1-parav@nvidia.com>
 <20230217154529.33508-2-parav@nvidia.com>
 <87wn4byqqb.fsf@redhat.com>
 <20230221124013-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481AC76D8FDB8E53956EAE4DCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230221125057-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815BA778BE4039755B7D6FDCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230221130713-mutt-send-email-mst@kernel.org>
 <87356yaxaz.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87356yaxaz.fsf@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Cornelia Huck <cohuck@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Feb 22, 2023 at 10:01:24AM +0100, Cornelia Huck wrote:
> On Tue, Feb 21 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Tue, Feb 21, 2023 at 05:59:52PM +0000, Parav Pandit wrote:
> >> 
> >> > From: Michael S. Tsirkin <mst@redhat.com>
> >> > Sent: Tuesday, February 21, 2023 12:52 PM
> >> > 
> >> > On Tue, Feb 21, 2023 at 05:50:09PM +0000, Parav Pandit wrote:
> >> > > Hence, it should be mentioned as read-only fields, so when the driver writes
> >> > something to read-only fields, it can be considered as undefined behavior on
> >> > such fields.
> >> > >
> >> > 
> >> > In the description not in the normative statements. normative sections just tell
> >> > driver what it must and must not do, in the standard RFC terms.
> >> > 
> >> Got it.
> >> I will shift them as read-only in the description section.
> >> And normative in the device and driver section.
> >> Device section:
> >> Any writes to config space fields is ignored by the device, because these are read-only fields for the driver.
> >
> > writes is plural so "are ignored"
> >
> > but more importantly use rfc terms in normative sections.
> 
> I don't think you need to talk about "read-only" in the normative
> sections (that belongs to the descriptive sections.) I'd use
> 
> "The device MUST ignore any writes to config space fields by the
> driver."

Hmm. Is this something we previously required for read only fields?


> >
> >> 
> >> Driver section:
> >> Driver must not write to read-only fields.
> 
> "The driver MUST NOT write to any config space field."

