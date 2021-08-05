Return-Path: <jasowang@redhat.com>
Subject: Re: [virtio-comment] [PATCH V2 2/2] virtio: introduce STOP status bit
References: <YPf00fKOCoBUETzW@stefanha-x1.localdomain>
 <5b5a366a-152f-def3-6978-9a2772aefe3a@redhat.com>
 <YPlHew9Dqy7n5v2N@stefanha-x1.localdomain>
 <ccd8b978-3e39-b997-4346-0f5e1a99b259@redhat.com>
 <YP7Prxye4x5FwixU@stefanha-x1.localdomain>
 <632c4c4f-7896-ec06-b3f1-bcd4d1ec58ca@redhat.com>
 <YQkcguccUO5IruuJ@stefanha-x1.localdomain>
 <a1e9e2b8-f7c7-b187-3221-2ddeddb7ead6@redhat.com> <YQk08YxioRkHZ2uw@work-vm>
 <b19364de-dcdf-af1a-3f33-c0d814d0dd3b@redhat.com> <YQpY1pXZmTVecNMW@work-vm>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <010a3ceb-70a9-d5c4-7de3-8d8f692efbb1@redhat.com>
Date: Thu, 5 Aug 2021 14:38:58 +0800
MIME-Version: 1.0
In-Reply-To: <YQpY1pXZmTVecNMW@work-vm>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Cornelia Huck <cohuck@redhat.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>, mreitz@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


在 2021/8/4 下午5:07, Dr. David Alan Gilbert 写道:
> * Jason Wang (jasowang@redhat.com) wrote:
>> 在 2021/8/3 下午8:22, Dr. David Alan Gilbert 写道:
>>> * Jason Wang (jasowang@redhat.com) wrote:
>>>> 在 2021/8/3 下午6:37, Stefan Hajnoczi 写道:
>>>>> On Tue, Aug 03, 2021 at 02:33:20PM +0800, Jason Wang wrote:
>>>>>> 在 2021/7/26 下午11:07, Stefan Hajnoczi 写道:
>>>>>>> I guess this is just a summary of what we've already discussed and not
>>>>>>> new information. I think an implementation today would use DBus VMState
>>>>>>> to transfer implementation-specific device state (an opaque blob).
>>>>>> Instead of trying to migrate those opaque stuffs which is kind of tricky, I
>>>>>> wonder if we can avoid them by recording the mapping in the shared
>>>>>> filesystem itself.
>>>>> The problem is that virtiofsd has no way of reopening the exact same
>>>>> files without Linux file handles.
>>>> I believe if we want to support live migration of the passthrough
>>>> filesystem. The filesystem itself must be shared? (like NFS)
>>>>
>>>> Assuming this is true. Can we store those mapping (e.g fuse inode -> host
>>>> inode) in a known path/file in the passthrough filesystem itself and hide
>>>> that file from the guest?
>>> That's pretty dangerous; it assumes that the filesystem is only used
>>> together with virtiofs; as a *shared* filesystem it's possible that it's
>>> being used directly by normal NFS clients as well.
>>> It's also very racy; trying to make sure those mappings reflect the
>>> *current* meaning of inodes even while they're changing under your feet
>>> is non-trivial.
>>
>> Right, it's just a thought to avoid migrating implementation specific
>> stuffs.
>>
>>
>>>> The destination can simply open this unkown file and do the lookup the
>>>> mapping and reopen the file if necessary.
>>>>
>>>> Then we don't need the Linux file handle.
>>>>
>>>>
>>>>>     So they need to be transferred to the
>>>>> destination (or stored on a shared file system as you suggested),
>>>>> regardless of whether they are part of the VIRTIO spec's device state or
>>>>> not.
>>>>>
>>>>> Implementation-specific state can be considered outside the scope of the
>>>>> VIRTIO spec. In other words, we could exclude it from the VIRTIO-level
>>>>> device state that save/load operate on. This does not solve the problem,
>>>>> it just shifts the responsibility to the virtualization stack to migrate
>>>>> this state.
>>>>>
>>>>> The Linux file handles or other virtiofsd implementation-specific state
>>>>> would be migrated separately (e.g. using DBus VMstate) so that by the
>>>>> time the destination device does a VIRTIO load operation, it has the
>>>>> necessary implementation-specific state ready.
>>>> That may work but I want to get rid of the implementation specific stuffs
>>>> like linux handles completely.
>>> I'm not sure how much implementation specific you can get rid of; but
>>> you should be able to comparmentalise it, and you should be able to make
>>> it so that common things can be shared;
>>
>> Yes, that's is the way we need to go.
>>
>>
>>>    i.e. if I have two
>>> implementations of virtiofs, both running on Linux, then it might be
>>> good if we can live migrate between them, and standardise the format.
>>
>> As replied in the previous version, I'm not sure how hard it is consider the
>> file_handle mentioned by Stefan is not a part of uABI and it depends on
>> specific kernel config to work.
>>
>>
>>> So, I'd expect the core virtiofs data to be standardised globally,
>>
>> Yes, maybe start at the FUSE level.
>>
>>
>>>    then
>>> I'd expect how Linux implementations work to be standardised.
>>
>> Does it mean we need:
>>
>> 1) port virtiofsd to multiple platforms
>> 2) only support live migration among virtiofds
>>
>> ?
> Not necessarily; I mean that we have layers:
>    a) Virtio
>    b) Virtio-fs
>    c]
>      c1) virtio-fs backed by a Linux filesystem
>      c2) virtio-fs backed by some object store
>      c3) virito-fs backed by something else
>
> (a) is standardised
> The migration data for (b) can be standardised


That would be good.


> We can also standardise c1, c2 (not that we've made a c2)
> and we could expect migration between different implementations all
> that are backed by a Linux filesystem (if that file handle stuff is
> portable); but we wouldn't expect a migration between c1 and c2 to work.
> (and c2 might get split if there are different types of object store).


If I understand this correctly, this requires the management layer to 
know the details of the backend before trying to live migrate the guest. 
Or do we need different feature bits for the above three types of the 
virtio-fs device?


>
> So, just because there are different types of backends, doesn't mean we
> have to give up standardisation; we just have to acknowledge there's
> a range of backends and standardisethe bits we can.


Right.

Thanks


>
> Dave
>
>>
>>> Dave
>>>
>>>>> I prefer to support in-band migration of implementation-specific state
>>>>> because it's less complex to have a single device state instead of
>>>>> splitting it.
>>>> I wonder how to deal with migration compatibility in this case.
>>>>
>>>>
>>>>> Is this the direction you were thinking in?
>>>> Somehow.
>>>>
>>>> Thanks
>>>>
>>>>
>>>>> Stefan

