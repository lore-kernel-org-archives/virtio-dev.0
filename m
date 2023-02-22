Return-Path: <virtio-comment-return-4449-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20230222064936-mutt-send-email-mst@kernel.org>
References: <20230217154529.33508-1-parav@nvidia.com>
 <20230217154529.33508-2-parav@nvidia.com> <87wn4byqqb.fsf@redhat.com>
 <20230221124013-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481AC76D8FDB8E53956EAE4DCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230221125057-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815BA778BE4039755B7D6FDCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230221130713-mutt-send-email-mst@kernel.org>
 <87356yaxaz.fsf@redhat.com>
 <20230222064936-mutt-send-email-mst@kernel.org>
Date: Wed, 22 Feb 2023 13:07:07 +0100
Message-ID: <87wn49aopg.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [PATCH v3 1/2] virtio-net: Describe dev cfg fields read only
Content-Type: text/plain
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Feb 22 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Feb 22, 2023 at 10:01:24AM +0100, Cornelia Huck wrote:
>> On Tue, Feb 21 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> 
>> > On Tue, Feb 21, 2023 at 05:59:52PM +0000, Parav Pandit wrote:
>> >> 
>> >> > From: Michael S. Tsirkin <mst@redhat.com>
>> >> > Sent: Tuesday, February 21, 2023 12:52 PM
>> >> > 
>> >> > On Tue, Feb 21, 2023 at 05:50:09PM +0000, Parav Pandit wrote:
>> >> > > Hence, it should be mentioned as read-only fields, so when the driver writes
>> >> > something to read-only fields, it can be considered as undefined behavior on
>> >> > such fields.
>> >> > >
>> >> > 
>> >> > In the description not in the normative statements. normative sections just tell
>> >> > driver what it must and must not do, in the standard RFC terms.
>> >> > 
>> >> Got it.
>> >> I will shift them as read-only in the description section.
>> >> And normative in the device and driver section.
>> >> Device section:
>> >> Any writes to config space fields is ignored by the device, because these are read-only fields for the driver.
>> >
>> > writes is plural so "are ignored"
>> >
>> > but more importantly use rfc terms in normative sections.
>> 
>> I don't think you need to talk about "read-only" in the normative
>> sections (that belongs to the descriptive sections.) I'd use
>> 
>> "The device MUST ignore any writes to config space fields by the
>> driver."
>
> Hmm. Is this something we previously required for read only fields?

So, better make it SHOULD?

(The only alternative to ignoring I see is breaking the device, and I
think ignoring is preferable.)

>
>
>> >
>> >> 
>> >> Driver section:
>> >> Driver must not write to read-only fields.
>> 
>> "The driver MUST NOT write to any config space field."


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

