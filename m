Return-Path: <jasowang@redhat.com>
Subject: Re: [virtio-comment] [PATCH V2 2/2] virtio: introduce STOP status bit
References: <YPaOYTAHaHYcelth@stefanha-x1.localdomain>
 <b4e23058-df0b-e630-a10e-458ddfedb2cb@redhat.com>
 <YPf00fKOCoBUETzW@stefanha-x1.localdomain>
 <5b5a366a-152f-def3-6978-9a2772aefe3a@redhat.com>
 <YPlHew9Dqy7n5v2N@stefanha-x1.localdomain>
 <ccd8b978-3e39-b997-4346-0f5e1a99b259@redhat.com>
 <YP7Prxye4x5FwixU@stefanha-x1.localdomain>
 <632c4c4f-7896-ec06-b3f1-bcd4d1ec58ca@redhat.com>
 <YQkcguccUO5IruuJ@stefanha-x1.localdomain>
 <a1e9e2b8-f7c7-b187-3221-2ddeddb7ead6@redhat.com>
 <YQpRq2u3vyeFqX08@stefanha-x1.localdomain>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0115702d-12bb-e856-b055-a8ff37064b38@redhat.com>
Date: Thu, 5 Aug 2021 14:35:04 +0800
MIME-Version: 1.0
In-Reply-To: <YQpRq2u3vyeFqX08@stefanha-x1.localdomain>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Cornelia Huck <cohuck@redhat.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>, mreitz@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


在 2021/8/4 下午4:36, Stefan Hajnoczi 写道:
> On Tue, Aug 03, 2021 at 07:42:31PM +0800, Jason Wang wrote:
>> 在 2021/8/3 下午6:37, Stefan Hajnoczi 写道:
>>> On Tue, Aug 03, 2021 at 02:33:20PM +0800, Jason Wang wrote:
>>>> 在 2021/7/26 下午11:07, Stefan Hajnoczi 写道:
>>>>> I guess this is just a summary of what we've already discussed and not
>>>>> new information. I think an implementation today would use DBus VMState
>>>>> to transfer implementation-specific device state (an opaque blob).
>>>> Instead of trying to migrate those opaque stuffs which is kind of tricky, I
>>>> wonder if we can avoid them by recording the mapping in the shared
>>>> filesystem itself.
>>> The problem is that virtiofsd has no way of reopening the exact same
>>> files without Linux file handles.
>>
>> I believe if we want to support live migration of the passthrough
>> filesystem. The filesystem itself must be shared? (like NFS)
> The virtiofs device is not tied to any particular file system backend.
> The file system could be shared (available from both the source and
> destination) or local. It might be a passthrough file system or
> something else (an in-memory file system similar to Linux tmpfs, a
> non-POSIX network storage like a REST object storage API, etc).


Yes, I meant for the case of passthrough file system, it must be shared 
in order to be migrated.

Or can we live migrate the whole passthrough file system to the 
destination as block device?

Thanks


>
> Stefan

