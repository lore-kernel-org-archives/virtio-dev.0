Return-Path: <virtio-comment-return-2733-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <PH0PR12MB548104AB80FA36544DB3D7D0DC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220203075716.11684-1-mgurtovoy@nvidia.com>
 <20220203075716.11684-2-mgurtovoy@nvidia.com>
 <20220207052843-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548164CFE929F59EEDBD3557DC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220208014039-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548104AB80FA36544DB3D7D0DC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
Date: Tue, 08 Feb 2022 14:19:49 +0100
Message-ID: <878rulv6kq.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-comment] RE: [PATCH v3 1/4] Add virtio Admin virtqueue
Content-Type: text/plain
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Feb 08 2022, Parav Pandit <parav@nvidia.com> wrote:

>> From: Michael S. Tsirkin <mst@redhat.com>
>> Sent: Tuesday, February 8, 2022 12:13 PM
>
>> On Tue, Feb 08, 2022 at 06:25:41AM +0000, Parav Pandit wrote:
>> >
>> > > From: Michael S. Tsirkin <mst@redhat.com>
>> > > Sent: Monday, February 7, 2022 4:09 PM
>> > >
>> > > Next, trying to think about scalable iov extensions. So we will have
>> > > groups of VFs and then SFs as the next level.
>> > > How does one differentiate between the two?
>> > > Maybe reserve a field for "destination type"?
>> > >
>> > We already discussed this in v2.
>> > SF will have different identification than 16-bits. And no one knows what
>> that would be.
>> > We just cannot reserve some arbitrary bytes for unknown.
>> > You suggested in v2 to reserve 4 bytes for sf_id, and I explained you that 4
>> bytes may not be enough.
>> >
>> > Whether SFs are on top of VFs or SFs are on top of PFs or both is completely
>> different spec.
>> > Whether PF will manage SFs of the VFs or it will be done nested manner by
>> VF etc is a completely different discussion than what is being proposed here.
>> > Whether PF will manage the SF is yet another big question. We work with
>> users and they dislike this.
>> > To address it, some OS has a different management interface (not visible to
>> PF) for SF life cycle even though SFs are anchored on a PF.
>> >
>> > So SF/iov extension discussion has long way to go for community to first
>> understand the use cases before crafting some extension.
>> >
>> > So lets not complicate and mix things here for a blurry definition of scalable
>> iov/sf extension.
>> 
>> Some reserved bytes won't hurt. 2 bytes for type gives us 64k types, sounds like
>> that should be enough.
> It doesn't stop there.
> Mentioning some destination type, interrupt type, etc also requires reserving bytes for different device id type, interrupt type and more.
> We past this stage long ago after discussing this in v1 at [1].
> It is just better and cleaner to define a different structure to describe SF/iov and its configuration.

I have the feeling that we might be overcomplicating this. We have some
groups of targets (a device, a group, that more complicated SF thingy),
and we want to distinguish between them. That's easy enough to cover via
some kind of enum-equivalent (0 == same dev, 1 == target a dev id, 2
== target a group id, 3 == multi-layer target) and some spec how 1 and 2
should look like (as I'd expect them to be common for many different
things). The SF thingy can be covered by 3, and we'll probably want to
make that one command-specific, as the whole setup does not have enough
things we can standardize on.

Does that make sense? This standardizes the simpler setups, and gives
enough flexibility for the more complicated ones. If we have another
simpler setup in the future, it can become type 4, 5, etc.


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

