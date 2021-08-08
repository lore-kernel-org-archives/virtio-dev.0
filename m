Return-Path: <virtio-comment-return-2181-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <YPlHew9Dqy7n5v2N@stefanha-x1.localdomain>
 <ccd8b978-3e39-b997-4346-0f5e1a99b259@redhat.com>
 <YP7Prxye4x5FwixU@stefanha-x1.localdomain>
 <632c4c4f-7896-ec06-b3f1-bcd4d1ec58ca@redhat.com>
 <YQkcguccUO5IruuJ@stefanha-x1.localdomain>
 <a1e9e2b8-f7c7-b187-3221-2ddeddb7ead6@redhat.com> <YQk08YxioRkHZ2uw@work-vm>
 <b19364de-dcdf-af1a-3f33-c0d814d0dd3b@redhat.com> <YQpY1pXZmTVecNMW@work-vm>
 <010a3ceb-70a9-d5c4-7de3-8d8f692efbb1@redhat.com> <YQufELMuQ83V3C+i@work-vm>
 <5bc3425c-d15a-cafb-765b-2bf22fbb3a33@redhat.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <d69540fe-3be3-4956-ce2f-8e9cab9b3fc1@nvidia.com>
Date: Sun, 8 Aug 2021 12:31:20 +0300
MIME-Version: 1.0
In-Reply-To: <5bc3425c-d15a-cafb-765b-2bf22fbb3a33@redhat.com>
Subject: Re: [virtio-comment] [PATCH V2 2/2] virtio: introduce STOP status bit
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Jason Wang <jasowang@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Cornelia Huck <cohuck@redhat.com>, Oren
 Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>, mreitz@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 8/6/2021 9:15 AM, Jason Wang wrote:
>
> =E5=9C=A8 2021/8/5 =E4=B8=8B=E5=8D=884:19, Dr. David Alan Gilbert =E5=86=
=99=E9=81=93:
>> * Jason Wang (jasowang@redhat.com) wrote:
>>> =E5=9C=A8 2021/8/4 =E4=B8=8B=E5=8D=885:07, Dr. David Alan Gilbert =E5=
=86=99=E9=81=93:
>>>> * Jason Wang (jasowang@redhat.com) wrote:
>>>>> =E5=9C=A8 2021/8/3 =E4=B8=8B=E5=8D=888:22, Dr. David Alan Gilbert =E5=
=86=99=E9=81=93:
>>>>>> * Jason Wang (jasowang@redhat.com) wrote:
>>>>>>> =E5=9C=A8 2021/8/3 =E4=B8=8B=E5=8D=886:37, Stefan Hajnoczi =E5=86=
=99=E9=81=93:
>>>>>>>> On Tue, Aug 03, 2021 at 02:33:20PM +0800, Jason Wang wrote:
>>>>>>>>> =E5=9C=A8 2021/7/26 =E4=B8=8B=E5=8D=8811:07, Stefan Hajnoczi =E5=
=86=99=E9=81=93:
>>>>>>>>>> I guess this is just a summary of what we've already=20
>>>>>>>>>> discussed and not
>>>>>>>>>> new information. I think an implementation today would use=20
>>>>>>>>>> DBus VMState
>>>>>>>>>> to transfer implementation-specific device state (an opaque=20
>>>>>>>>>> blob).
>>>>>>>>> Instead of trying to migrate those opaque stuffs which is kind=20
>>>>>>>>> of tricky, I
>>>>>>>>> wonder if we can avoid them by recording the mapping in the=20
>>>>>>>>> shared
>>>>>>>>> filesystem itself.
>>>>>>>> The problem is that virtiofsd has no way of reopening the exact=20
>>>>>>>> same
>>>>>>>> files without Linux file handles.
>>>>>>> I believe if we want to support live migration of the passthrough
>>>>>>> filesystem. The filesystem itself must be shared? (like NFS)
>>>>>>>
>>>>>>> Assuming this is true. Can we store those mapping (e.g fuse=20
>>>>>>> inode -> host
>>>>>>> inode) in a known path/file in the passthrough filesystem itself=20
>>>>>>> and hide
>>>>>>> that file from the guest?
>>>>>> That's pretty dangerous; it assumes that the filesystem is only used
>>>>>> together with virtiofs; as a *shared* filesystem it's possible=20
>>>>>> that it's
>>>>>> being used directly by normal NFS clients as well.
>>>>>> It's also very racy; trying to make sure those mappings reflect the
>>>>>> *current* meaning of inodes even while they're changing under=20
>>>>>> your feet
>>>>>> is non-trivial.
>>>>> Right, it's just a thought to avoid migrating implementation specific
>>>>> stuffs.
>>>>>
>>>>>
>>>>>>> The destination can simply open this unkown file and do the=20
>>>>>>> lookup the
>>>>>>> mapping and reopen the file if necessary.
>>>>>>>
>>>>>>> Then we don't need the Linux file handle.
>>>>>>>
>>>>>>>
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 So they need to be transferred to the
>>>>>>>> destination (or stored on a shared file system as you suggested),
>>>>>>>> regardless of whether they are part of the VIRTIO spec's device=20
>>>>>>>> state or
>>>>>>>> not.
>>>>>>>>
>>>>>>>> Implementation-specific state can be considered outside the=20
>>>>>>>> scope of the
>>>>>>>> VIRTIO spec. In other words, we could exclude it from the=20
>>>>>>>> VIRTIO-level
>>>>>>>> device state that save/load operate on. This does not solve the=20
>>>>>>>> problem,
>>>>>>>> it just shifts the responsibility to the virtualization stack=20
>>>>>>>> to migrate
>>>>>>>> this state.
>>>>>>>>
>>>>>>>> The Linux file handles or other virtiofsd=20
>>>>>>>> implementation-specific state
>>>>>>>> would be migrated separately (e.g. using DBus VMstate) so that=20
>>>>>>>> by the
>>>>>>>> time the destination device does a VIRTIO load operation, it=20
>>>>>>>> has the
>>>>>>>> necessary implementation-specific state ready.
>>>>>>> That may work but I want to get rid of the implementation=20
>>>>>>> specific stuffs
>>>>>>> like linux handles completely.
>>>>>> I'm not sure how much implementation specific you can get rid of;=20
>>>>>> but
>>>>>> you should be able to comparmentalise it, and you should be able=20
>>>>>> to make
>>>>>> it so that common things can be shared;
>>>>> Yes, that's is the way we need to go.
>>>>>
>>>>>
>>>>>> =C2=A0=C2=A0=C2=A0 i.e. if I have two
>>>>>> implementations of virtiofs, both running on Linux, then it might be
>>>>>> good if we can live migrate between them, and standardise the=20
>>>>>> format.
>>>>> As replied in the previous version, I'm not sure how hard it is=20
>>>>> consider the
>>>>> file_handle mentioned by Stefan is not a part of uABI and it=20
>>>>> depends on
>>>>> specific kernel config to work.
>>>>>
>>>>>
>>>>>> So, I'd expect the core virtiofs data to be standardised globally,
>>>>> Yes, maybe start at the FUSE level.
>>>>>
>>>>>
>>>>>> =C2=A0=C2=A0=C2=A0 then
>>>>>> I'd expect how Linux implementations work to be standardised.
>>>>> Does it mean we need:
>>>>>
>>>>> 1) port virtiofsd to multiple platforms
>>>>> 2) only support live migration among virtiofds
>>>>>
>>>>> ?
>>>> Not necessarily; I mean that we have layers:
>>>> =C2=A0=C2=A0=C2=A0 a) Virtio
>>>> =C2=A0=C2=A0=C2=A0 b) Virtio-fs
>>>> =C2=A0=C2=A0=C2=A0 c]
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c1) virtio-fs backed by a Linux filesys=
tem
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c2) virtio-fs backed by some object sto=
re
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c3) virito-fs backed by something else
>>>>
>>>> (a) is standardised
>>>> The migration data for (b) can be standardised
>>>
>>> That would be good.
>>>
>>>
>>>> We can also standardise c1, c2 (not that we've made a c2)
>>>> and we could expect migration between different implementations all
>>>> that are backed by a Linux filesystem (if that file handle stuff is
>>>> portable); but we wouldn't expect a migration between c1 and c2 to=20
>>>> work.
>>>> (and c2 might get split if there are different types of object store).
>>>
>>> If I understand this correctly, this requires the management layer=20
>>> to know
>>> the details of the backend before trying to live migrate the guest.=20
>>> Or do we
>>> need different feature bits for the above three types of the virtio-fs
>>> device?
>> Yep, something would need to know the details of the backend; but that's
>> true of most existing backends anyway; e.g. in virtio-net the management
>> layer understands the underlying network and what it has to setup on the
>> destination to ensure the network on both sides looks the same; it's got
>> different implications but it does still need to know it.
>
>
> I think it's different. E.g for the case of virtio-net though setup on=20
> the destination doesn't depends on the device state.
>
> E.g technically, we can do cross backend live migration. E.g from qemu=20
> virtio-net to a vhost-user backend.

virtio-blk also need to have management to control backends.

Let's say the storage is backed by remote nvmf target so you must to=20
create the same connection in the destination as well.

This should be done by some sys-admin.


>
> Thanks
>
>
>>
>> Dave
>>
>>>> So, just because there are different types of backends, doesn't=20
>>>> mean we
>>>> have to give up standardisation; we just have to acknowledge there's
>>>> a range of backends and standardisethe bits we can.
>>>
>>> Right.
>>>
>>> Thanks
>>>
>>>
>>>> Dave
>>>>
>>>>>> Dave
>>>>>>
>>>>>>>> I prefer to support in-band migration of=20
>>>>>>>> implementation-specific state
>>>>>>>> because it's less complex to have a single device state instead of
>>>>>>>> splitting it.
>>>>>>> I wonder how to deal with migration compatibility in this case.
>>>>>>>
>>>>>>>
>>>>>>>> Is this the direction you were thinking in?
>>>>>>> Somehow.
>>>>>>>
>>>>>>> Thanks
>>>>>>>
>>>>>>>
>>>>>>>> Stefan
>

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
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

