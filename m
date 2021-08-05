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
 <b19364de-dcdf-af1a-3f33-c0d814d0dd3b@redhat.com>
 <YQpb970f5gU6eDIq@stefanha-x1.localdomain>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <87e4196c-0c4e-87a5-9307-64bcece326f5@redhat.com>
Date: Thu, 5 Aug 2021 14:45:30 +0800
MIME-Version: 1.0
In-Reply-To: <YQpb970f5gU6eDIq@stefanha-x1.localdomain>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Cornelia Huck <cohuck@redhat.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>, mreitz@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


在 2021/8/4 下午5:20, Stefan Hajnoczi 写道:
> On Wed, Aug 04, 2021 at 09:42:34AM +0800, Jason Wang wrote:
>> 在 2021/8/3 下午8:22, Dr. David Alan Gilbert 写道:
>>> * Jason Wang (jasowang@redhat.com) wrote:
>>>> 在 2021/8/3 下午6:37, Stefan Hajnoczi 写道:
>>>>> On Tue, Aug 03, 2021 at 02:33:20PM +0800, Jason Wang wrote:
>>>>>> 在 2021/7/26 下午11:07, Stefan Hajnoczi 写道:
>>> I'd expect how Linux implementations work to be standardised.
>>
>> Does it mean we need:
>>
>> 1) port virtiofsd to multiple platforms
> Correct migration requires a non-POSIX mechanism to reopen files (saving
> inode numbers as you've suggested isn't enough). If that's unavailable
> then it won't be possible to migrate safely.


Ok.


>
>> 2) only support live migration among virtiofds
> We can standardize the device state representation for Linux passthrough
> file systems and implement it in QEMU's virtiofsd and virtiofsd-rs.
>
> However, it's technically possible for other virtiofsd implementations
> to migrate too and they shouldn't be second-class citizens. QEMU's
> virtiofsd isn't special and Linux passthrough file systems aren't
> special.


So the migration compatibility is still a problem for those backends.


>
> Some device state representations will apply to one specific virtiofs
> implementation, so the value of standardizing it beyond choosing a
> unique identifier to prevent collisions is questionable.


As replied in another thread, could we categorize the different types of 
backend with different feature bits. Then we can start think of how to 
standardize the state of each?


>   Does the VIRTIO
> TC want to spend time reviewing implementation-specific device state
> representations?


If it's implementation specific not virtio specific, I guess not. But if 
we use feature bits for identify the backend types, do we have the 
chance to make it virtio specific instead of implementation specific?


>
> What I suggest is to allow in-band implementation-specific device state
> with a unique identifier that prevents migration between incompatible
> implementations.


Does this mean we can only know it's impossible to migrate after a 
migration failure?


>   Standardize device state representations that are
> actually worth standardizing (like the Linux passthrough file system
> where there are multiple implementations): implementors benefit from
> using the standard because it saves them time and ensures migration
> compatibility.


Yes.

Thanks


>
> Stefan

