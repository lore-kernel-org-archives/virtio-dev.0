Return-Path: <jasowang@redhat.com>
Message-ID: <0862abe5-b1f5-77ba-bddb-097dac21ce99@redhat.com>
Date: Thu, 25 Nov 2021 10:57:28 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/2] virtio: introduce STOP status bit
References: <20211111185812.2326093-1-eperezma@redhat.com>
 <20211111185812.2326093-3-eperezma@redhat.com>
 <YZZ4aXdOAA65v10Y@stefanha-x1.localdomain>
 <CAJaqyWcy3J=pSgXQbKch3EA-5swJJBa68qn-VCWFaixctR+ppw@mail.gmail.com>
 <YZzbtcNXRTD1BawU@stefanha-x1.localdomain>
 <CAJaqyWfwX4hUMKw5mK-jwUUDm8WQA2PxUvbD2EOavMUAO1Q0kQ@mail.gmail.com>
 <YZ4gE8+KiiZBK9no@stefanha-x1.localdomain>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <YZ4gE8+KiiZBK9no@stefanha-x1.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Stefan Hajnoczi <stefanha@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>, virtio-comment@lists.oasis-open.org, Michael Tsirkin <mst@redhat.com>, Alexander Mikheev <amikheev@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Bodong Wang <bodong@nvidia.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>


在 2021/11/24 下午7:20, Stefan Hajnoczi 写道:
> On Tue, Nov 23, 2021 at 06:00:20PM +0100, Eugenio Perez Martin wrote:
>> On Tue, Nov 23, 2021 at 1:17 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>>> On Thu, Nov 18, 2021 at 08:58:05PM +0100, Eugenio Perez Martin wrote:
>>>> On Thu, Nov 18, 2021 at 5:00 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>>>>> On Thu, Nov 11, 2021 at 07:58:12PM +0100, Eugenio Pérez wrote:
>>>>>> +the driver MAY change avail_idx in the case of split virtqueue, but the new
>>>>>> +avail_idx MUST be within used_idx and used_idx plus virtqueue size.
>>>>> I'm trying to understand how this would work. Available buffers may be
>>>>> consumed out-of-order unless VIRTIO_F_IN_ORDER was negotiated, so the
>>>>> avail ring could contain something like:
>>>>>
>>>>>    avail.ring = [Used, Not used, Used, Not used, ...]
>>>>>                                                  ^--- avail.idx
>>>>>
>>>>> There are num_not_used = avail.idx - used.idx requests that are "Not
>>>>> used" in avail.ring.
>>>>>
>>>>> Does this mean the driver can rewind avail.idx by counting the number of
>>>>> "Not used" buffers and skipping "Used" buffers until it reaches
>>>>> num_not_used "Not used" buffers?
>>>>>
>>>> I'm going to also drop the "resume" part for the next version because
>>>> it adds extra complexity not actually needed, and it can be achieved
>>>> with a full reset in a simpler way.
>>>>
>>>> But I'll explain it below with your examples. Long story short, the
>>>> driver only can rewind the available descriptors that are still in the
>>>> available ring, and the device must flush the ones that cannot recover
>>>> from the ring.
>>>>
>>>>> I think there is a known issue with this approach:
>>>>>
>>>>> Imagine a vring with 4 elements:
>>>>>
>>>>>    avail.ring = [0,        1,    2,    3   ]
>>>>>                  Not used, used, used, used
>>>>>                                             ^--- avail.idx
>>>>>
>>>>> Since the device has used 3 buffers the driver now has space to make
>>>>> more buffers available. avail.idx wraps back to the start of the ring
>>>>> and the driver overwrites the first element ("Not used"):
>>>>>
>>>>>    avail.ring = [1,        N/A,  N/A,  N/A]
>>>>>                  Not used, N/A,  N/A,  N/A
>>>>>                           ^--- avail.idx
>>>>>
>>>>> Since vring descriptor 0 is still in use the driver chose descriptor 1
>>>>> for the new available buffer.
>>>>>
>>>>> Now we stop the device, knowing there are two buffers available that
>>>>> have not been used. But avail.ring[] actually only contains the new
>>>>> buffer (vring descriptor 1) that we made available because we overwrote
>>>>> the old avail.ring[] element (vring descriptor 0).
>>>>>
>>>>> What now? Where does the device reset its internal avail_idx to?
>>>> To be on the same page, in qemu the device maintains two "internal
>>>> avail idx": shadow_avail_idx (last seen in the available ring, could
>>>> be 4 in this case) and last_avail_idx (next descriptor to fetch from
>>>> avail, 2). The device must forget shadow_avail_idx and flush the
>>>> descriptors that cannot recover (0). So last_avail_idx is now 3. Now
>>>> it can stop.
>>>>
>>>> The proposal allows the device to fail descriptor 0 in a
>>>> device-specific way, but I think now it was a bad choice.
>>>>
>>>> The driver cannot move the device's last_avail_idx in this operation:
>>>> The device is simply forced to flush used ones to the used ring or
>>>> descriptor ring in a packed vq case. So the device's internal
>>>> avail_idx == used_idx == 3. When the device resumes, it's still 3.
>>>>
>>>> The device must keep its last_avail_idx through stop and resume cycle.
>>> Are you saying that all buffers avail->ring[i % ring_size] must be
>>> completed by the device before the STOP bit is reported where i <=
>>> last_avail_idx?
>>>
>>> This means the driver can modify avail->ring[i % ring_size] where
>>> avail_idx >= i > used_idx.
>>>
>> Yes, That's correct. The driver could also decide to modify the
>> descriptor table instead of the avail ring to do so, but I think the
>> point is clear now.
>>
>> Somehow it is thought after the premise that the out of order
> "Somehow it is thought after the premise" == "there is a fundamental
> design assumption"?
>
>> descriptors are descriptors that the device must wait to complete
>> before the pause anyway. Depending on the device, it might prefer to
>> cancel them, to wait for them, etc. The interesting descriptors to
>> rewind are the ones that have not reached the device (i > used_idx).
>> The driver can do whatever it wants with them.
>>
>> If we assume all the in-flight descriptors are idempotent and we
>> expose a way for the device to expose them, the model is way more
>> simpler than this.
> The constraint that the device has to mark all previously seen "avail"
> buffers as "used" is problematic. It makes STOP visible to the driver
> when the device has to fail requests.


I think we need some clarification here on the driver. For doing 
migration, some kind of mediation is a must.

As we've discussed in the previous versions of this proposal, the VMM 
usually won't advertise the STOP feature to guest if we don't want to do 
nested live migration (if we do we can shadow it anyhow).

So from the guest point of view it won't see neither STOP nor the 
inflight descriptors.


> That is incompatible with how
> devices behave across live migration today. If you want to use STOP for
> live migration then it's probably necessary to rethink this constraint.
>
> QEMU's virtio-blk and virtio-scsi device models put failed requests onto
> a list so they can be retried after problems with the underlying storage
> have been resolved (e.g. more disk space becomes available and ENOSPC
> requests can be retried).


A question, I think for those "failure" it's actually not visible from 
the drive? If this is true, from the spec point of view, there are still 
inflight. The VMM may choose to migrate them to the destination and 
re-submit them there. This works more like vhost re-connection.


Thanks


> Based on the constraints you described, those
> requests cannot be kept in the list across STOP.
>
> QEMU live migration sends the retry list to the migration destination. I
> think you're saying that won't be possible when STOP is used to
> implement live migration?
>
> That would be a shame since one of the ways to resolve I/O errors is by
> migrating to another host :).
>
> Stefan

