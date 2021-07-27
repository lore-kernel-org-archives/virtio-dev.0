Return-Path: <mreitz@redhat.com>
Subject: Re: [virtio-comment] [PATCH V2 2/2] virtio: introduce STOP status bit
References: <c626c856-7010-0df6-131f-00aad7221266@redhat.com>
 <c3f1d0f5-bfe1-b2f1-2d06-f9e7352247f8@redhat.com>
 <YPVz9A/DkawlKoD1@stefanha-x1.localdomain>
 <0213e6c2-59aa-f140-7231-36231b42051d@redhat.com>
 <YPaOYTAHaHYcelth@stefanha-x1.localdomain>
 <b4e23058-df0b-e630-a10e-458ddfedb2cb@redhat.com>
 <YPf00fKOCoBUETzW@stefanha-x1.localdomain>
 <5b5a366a-152f-def3-6978-9a2772aefe3a@redhat.com>
 <YPlHew9Dqy7n5v2N@stefanha-x1.localdomain>
 <ccd8b978-3e39-b997-4346-0f5e1a99b259@redhat.com>
 <YP7Prxye4x5FwixU@stefanha-x1.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <cf1ce2c6-9690-178f-d6cd-a1f19c759ec3@redhat.com>
Date: Tue, 27 Jul 2021 09:43:53 +0200
MIME-Version: 1.0
In-Reply-To: <YP7Prxye4x5FwixU@stefanha-x1.localdomain>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Cornelia Huck <cohuck@redhat.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 26.07.21 17:07, Stefan Hajnoczi wrote:
> On Thu, Jul 22, 2021 at 09:08:58PM +0800, Jason Wang wrote:
>> 在 2021/7/22 下午6:24, Stefan Hajnoczi 写道:
>>> On Thu, Jul 22, 2021 at 03:33:10PM +0800, Jason Wang wrote:
>>>> 在 2021/7/21 下午6:20, Stefan Hajnoczi 写道:
>>>>> On Wed, Jul 21, 2021 at 10:29:17AM +0800, Jason Wang wrote:
>>>>>> 在 2021/7/20 下午4:50, Stefan Hajnoczi 写道:
>>>>> I recognize that opaque device state poses a risk to migration
>>>>> compatibility, because device implementors may arbitrarily use opaque
>>>>> state when a standard is available.
>>>>>
>>>>> However, the way to avoid this scenario is by:
>>>>>
>>>>> 1. Making the standard migration approach the easiest to implement
>>>>>       because everything has been taken care of. It will save implementors
>>>>>       the headache of defining and coding their own device state
>>>>>       representations and versioning.
>>>>>
>>>>> 2. Educate users about migration compatibility so they can identify
>>>>>       implementors are locking in their users.
>>>> For vendor specific device, this may work. But for standard devices like
>>>> virtio, we should go further.
>>>>
>>>> The device states should be defined in the spec clearly. We should re-visit
>>>> the design if those states contains anything that is implementation
>>>> specific.
>>> Can you describe how migrating virtiofs devices should work?
>>
>> I need to learn more virtio-fs before answering this question.
>>
>> Actually, it would be faster if I can see a prototype of the migration
>> support for virtio-fs and start from there (as I've suggested this in
>> another thread).
>>
>>
>>>    I think
>>> that might be quicker than if I reply to each of your points because our
>>> views are still quite far apart.
>>
>> Yes, it would be quicker if we can start from a prototype.
> I have CCed Max Reitz to check whether a prototype of virtiofs migration
> might be available soon?

No, I don’t think so.

I hope I can start with looking into it soon (where "soon" already means 
one or two months), but I can make absolutely no predictions on when 
something usable even as just a prototype might come out of it.  (And I 
find that to be so many conditionals that I don’t think there’s going to 
be one soon.)

> But I can describe the key state that needs to be migrated:
>
> - FUSE nodeid -> host inode mappings. The driver uses nodeid numbers in
>    the FUSE protocol and the device maps them to actual inodes on the
>    passthrough file system.
> - FUSE fh -> open fd mappings. The driver uses fh numbers in the FUSE
>    protocol and the device maps them to actual file descriptors on the
>    host.
> - FUSE fh -> open dir fd mappings. The driver uses fh numbers in the
>    FUSE protocol and the device maps them to actual O_DIRECTORY file
>    descriptors on the host.
>
> The driver expects to be able to continue using nodeid and fh numbers
> across migration. Let's look at just the open fds for a moment:
>
> The OPEN command opens the file for a given nodeid and returns its fh.
> Due to POSIX file system semantics there is no reliable way to reopen
> the same file from just the filename. The problem is that a file can be
> renamed or deleted (but still accessible until the last fd is closed).
>
> Linux file handles (open_by_handle_at(2) and name_to_handle_at(2)) make
> it possible to reopen the exact same file using a struct file_handle
> instead of a filename. So the virtiofs device could transfer the Linux
> file handles to the destination where the fd -> open fd mappings can be
> restored.
>
> The problem is that Linux file handles are an implementation-specific
> solution to this problem. On non-Linux hosts there may be other
> solutions that userspace file systems use to solve this problem. Or a
> virtiofs device may not implement a passthrough host file system and
> have a completely different concept of what an inode is.
>
> This means only a subset of virtiofs implementations can use Linux file
> handles as part of their device state. There is no way for the driver or
> device to recreate or restore the necessary information without
> implementation-specific device state like Linux file handles, though.

(For the record, I agree with this summary.)

Max

> I guess this is just a summary of what we've already discussed and not
> new information. I think an implementation today would use DBus VMState
> to transfer implementation-specific device state (an opaque blob).
>
> Stefan

