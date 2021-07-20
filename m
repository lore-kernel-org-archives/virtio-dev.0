Return-Path: <virtio-comment-return-2017-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <YPaOYTAHaHYcelth@stefanha-x1.localdomain>
References: <8a2037df-e527-dcb4-c4c8-a568885180e4@redhat.com>
 <YO60HpxfZnmfMCMj@stefanha-x1.localdomain>
 <094e15d4-169a-87e9-5ebb-93439ea72831@redhat.com>
 <YO79tuI72kTEWURN@stefanha-x1.localdomain>
 <1ab19438-cc13-bbe5-7fec-53a113d85463@redhat.com>
 <YPAHcG7bxhlIGVeE@stefanha-x1.localdomain>
 <c626c856-7010-0df6-131f-00aad7221266@redhat.com>
 <c3f1d0f5-bfe1-b2f1-2d06-f9e7352247f8@redhat.com>
 <YPVz9A/DkawlKoD1@stefanha-x1.localdomain>
 <0213e6c2-59aa-f140-7231-36231b42051d@redhat.com>
 <YPaOYTAHaHYcelth@stefanha-x1.localdomain>
Date: Tue, 20 Jul 2021 12:48:43 +0200
Message-ID: <87o8ax8dmc.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-comment] [PATCH V2 2/2] virtio: introduce STOP status bit
Content-Type: text/plain
To: Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jul 20 2021, Stefan Hajnoczi <stefanha@redhat.com> wrote:

> On Tue, Jul 20, 2021 at 11:04:55AM +0800, Jason Wang wrote:
>> Let me clarify, I agree we can't have a standard device state for all kinds
>> of device.
>> 
>> That's way I tend to leave them to be device specific. (but not
>> implementation specific)
>
> Unfortunately device state is sometimes implementation-specific. Not
> because the device is proprietary, but because the actual state is
> meaningless to other implementations.
>
> I mentioned virtiofs as an example where file system backends can be
> implemented in completely different ways so the device state cannot be
> migrated between implementations.
>
>> But we can generalize the virtqueue state for sure.
>
> I agree and also that some device types can standardize their device
> state representations. But I think it's a technical requirement to
> support implementation-specific state for device types where
> cross-implementation migration is not possible.
>
> I'm not saying the implementation-specific state representation has to
> be a binary blob. There could be an identifier registry to ensure live
> migration compatibility checks can be performed. There could also be a
> standard binary encoding for migration data. But the contents will be
> implementation-specific for some devices.

Can we at least put those implementation-specific states into some kind
of structured, standardized form? E.g. something like

<type category: file system backend data>
<type identifier: file system foo>
<length>
<data>

so that we can at least do compat checks for "I know how to handle foo"?


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

