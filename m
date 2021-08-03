Return-Path: <jasowang@redhat.com>
Subject: Re: [virtio-comment] [PATCH V2 2/2] virtio: introduce STOP status bit
References: <YPVz9A/DkawlKoD1@stefanha-x1.localdomain>
 <0213e6c2-59aa-f140-7231-36231b42051d@redhat.com>
 <YPaOYTAHaHYcelth@stefanha-x1.localdomain>
 <b4e23058-df0b-e630-a10e-458ddfedb2cb@redhat.com>
 <YPf00fKOCoBUETzW@stefanha-x1.localdomain>
 <5b5a366a-152f-def3-6978-9a2772aefe3a@redhat.com>
 <YPlHew9Dqy7n5v2N@stefanha-x1.localdomain>
 <ccd8b978-3e39-b997-4346-0f5e1a99b259@redhat.com>
 <YP7Prxye4x5FwixU@stefanha-x1.localdomain>
 <632c4c4f-7896-ec06-b3f1-bcd4d1ec58ca@redhat.com>
 <YQkcguccUO5IruuJ@stefanha-x1.localdomain>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a1e9e2b8-f7c7-b187-3221-2ddeddb7ead6@redhat.com>
Date: Tue, 3 Aug 2021 19:42:31 +0800
MIME-Version: 1.0
In-Reply-To: <YQkcguccUO5IruuJ@stefanha-x1.localdomain>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Cornelia Huck <cohuck@redhat.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>, mreitz@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


在 2021/8/3 下午6:37, Stefan Hajnoczi 写道:
> On Tue, Aug 03, 2021 at 02:33:20PM +0800, Jason Wang wrote:
>> 在 2021/7/26 下午11:07, Stefan Hajnoczi 写道:
>>> I guess this is just a summary of what we've already discussed and not
>>> new information. I think an implementation today would use DBus VMState
>>> to transfer implementation-specific device state (an opaque blob).
>>
>> Instead of trying to migrate those opaque stuffs which is kind of tricky, I
>> wonder if we can avoid them by recording the mapping in the shared
>> filesystem itself.
> The problem is that virtiofsd has no way of reopening the exact same
> files without Linux file handles.


I believe if we want to support live migration of the passthrough 
filesystem. The filesystem itself must be shared? (like NFS)

Assuming this is true. Can we store those mapping (e.g fuse inode -> 
host inode) in a known path/file in the passthrough filesystem itself 
and hide that file from the guest?

The destination can simply open this unkown file and do the lookup the 
mapping and reopen the file if necessary.

Then we don't need the Linux file handle.


>   So they need to be transferred to the
> destination (or stored on a shared file system as you suggested),
> regardless of whether they are part of the VIRTIO spec's device state or
> not.
>
> Implementation-specific state can be considered outside the scope of the
> VIRTIO spec. In other words, we could exclude it from the VIRTIO-level
> device state that save/load operate on. This does not solve the problem,
> it just shifts the responsibility to the virtualization stack to migrate
> this state.
>
> The Linux file handles or other virtiofsd implementation-specific state
> would be migrated separately (e.g. using DBus VMstate) so that by the
> time the destination device does a VIRTIO load operation, it has the
> necessary implementation-specific state ready.


That may work but I want to get rid of the implementation specific 
stuffs like linux handles completely.


>
> I prefer to support in-band migration of implementation-specific state
> because it's less complex to have a single device state instead of
> splitting it.


I wonder how to deal with migration compatibility in this case.


>
> Is this the direction you were thinking in?


Somehow.

Thanks


>
> Stefan

