Return-Path: <jasowang@redhat.com>
Subject: Re: [PATCH] virtio-pci: implement VIRTIO_F_RING_STATE
References: <20210707043441.42361-1-jasowang@redhat.com>
 <YOwZhDqkYv7kUgiQ@stefanha-x1.localdomain>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ada4dce9-7ac0-5deb-e1e2-644d4468143d@redhat.com>
Date: Tue, 13 Jul 2021 11:39:13 +0800
MIME-Version: 1.0
In-Reply-To: <YOwZhDqkYv7kUgiQ@stefanha-x1.localdomain>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: mst@redhat.com, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, mgurtovoy@nvidia.com, cohuck@redhat.com, eperezma@redhat.com, oren@nvidia.com, shahafs@nvidia.com, parav@nvidia.com, bodong@nvidia.com, amikheev@nvidia.com, pasic@linux.ibm.com, dgilbert@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


在 2021/7/12 下午6:29, Stefan Hajnoczi 写道:
> On Wed, Jul 07, 2021 at 12:34:41PM +0800, Jason Wang wrote:
>> This patch is a follow up for the virtqueue state synchronization
>> series to implement VIRTIO_F_RING_STATE via a dedicated capability for
>> PCI transport.
>>
>> With the help of the STOP status bit, the virtqueue state
>> synchronization for PCI should be self contained.
>>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   content.tex | 32 ++++++++++++++++++++++++++++++++
>>   1 file changed, 32 insertions(+)
> This may not be critical, but the interface reminds me of the legacy
> fw_cfg interface that was slow. It was replaced by a DMA interface that
> reduced the number of vmexits. fw_cfg often transferred far more data
> than this interface, so the inefficiency was a bigger problem.
>
> If there was an admin virtqueue then the state of all virtqueues could
> be saved/loaded in a single request instead of requiring 2 accesses per
> virtqueue.


So this is just one of the possible implementation. It could be done via 
other ways for sure:

1) new control command which pack both avail and used state
2) 32bit registers
3) shared memory (DMA)


>
> Assuming a register access takes 1 microsecond, a device with 64
> virtqueues needs 128 microseconds to save/load virtqueue state. The
> actual register access time will vary depending on how the device is
> implemented (VFIO, vDPA, userspace). The total time is probably going to
> be acceptable, however, if we need an admin virtqueue anyway,


It can only help if we invent a control command that can be used to set 
or get a brunch of states (e.g 128 states).


>   then maybe
> do this as an admin virtqueue request instead of a transport-specific
> method?


As discussed in another thread, admin virtqueue is one of the possible 
solution since the virtqueue state is one of the basic facility.

We can allow the state to be carried via admin virtqueue after it was 
introduced in the spec.

But admin virtqueue should not be the only method.

Thanks


>
> Stefan

