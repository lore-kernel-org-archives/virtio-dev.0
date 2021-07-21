Return-Path: <jasowang@redhat.com>
Subject: Re: [virtio-comment] [PATCH V2 2/2] virtio: introduce STOP status bit
References: <8a2037df-e527-dcb4-c4c8-a568885180e4@redhat.com>
 <YO60HpxfZnmfMCMj@stefanha-x1.localdomain>
 <094e15d4-169a-87e9-5ebb-93439ea72831@redhat.com>
 <YO79tuI72kTEWURN@stefanha-x1.localdomain>
 <1ab19438-cc13-bbe5-7fec-53a113d85463@redhat.com>
 <YPAHcG7bxhlIGVeE@stefanha-x1.localdomain>
 <c626c856-7010-0df6-131f-00aad7221266@redhat.com>
 <YPVzcLGj591X37fX@stefanha-x1.localdomain>
 <48a8b9f0-d68f-e5a0-1d7b-43e61bda603c@redhat.com>
 <d4e7afdd-943d-73bd-3c31-c07543392819@nvidia.com>
 <YPbIHXPd1I13/K1U@stefanha-x1.localdomain>
 <2d24c89b-9a6f-921b-55f2-50b522e1eb91@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f35c5985-fc90-1899-440c-a621b9ce5974@redhat.com>
Date: Wed, 21 Jul 2021 11:06:06 +0800
MIME-Version: 1.0
In-Reply-To: <2d24c89b-9a6f-921b-55f2-50b522e1eb91@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Cornelia Huck <cohuck@redhat.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>


在 2021/7/20 下午9:09, Max Gurtovoy 写道:
>
> On 7/20/2021 3:57 PM, Stefan Hajnoczi wrote:
>> On Tue, Jul 20, 2021 at 03:27:00PM +0300, Max Gurtovoy wrote:
>>> On 7/20/2021 6:02 AM, Jason Wang wrote:
>>>> 在 2021/7/19 下午8:43, Stefan Hajnoczi 写道:
>>>>> On Fri, Jul 16, 2021 at 10:03:17AM +0800, Jason Wang wrote:
>>>>>> 在 2021/7/15 下午6:01, Stefan Hajnoczi 写道:
>>>>>>> On Thu, Jul 15, 2021 at 09:35:13AM +0800, Jason Wang wrote:
>>>>>>>> 在 2021/7/14 下午11:07, Stefan Hajnoczi 写道:
>>>>>>>>> On Wed, Jul 14, 2021 at 06:29:28PM +0800, Jason Wang wrote:
>>>>>>>>>> 在 2021/7/14 下午5:53, Stefan Hajnoczi 写道:
>>>>>>>>>>> On Tue, Jul 13, 2021 at 08:16:35PM +0800, Jason Wang wrote:
>>>>>>>>>>>> 在 2021/7/13 下午6:00, Stefan Hajnoczi 写道:
>>>>>>>>>>>>> On Tue, Jul 13, 2021 at 11:27:03AM +0800, Jason Wang wrote:
>>>>>>>>>>>>>> 在 2021/7/12 下午5:57, Stefan Hajnoczi 写道:
>>>>>>>>>>>>>>> On Mon, Jul 12, 2021 at 12:00:39PM +0800, Jason Wang wrote:
>>>>>>>>>>>>>>>> 在 2021/7/11 上午4:36, Michael S. Tsirkin 写道:
>>>>>>>>>>>>>>>>> On Fri, Jul 09, 2021
>>>>>>>>>>>>>>>>> at 07:23:33PM +0200,
>>>>>>>>>>>>>>>>> Eugenio Perez Martin
>>>>>>>>>>>>>>>>> wrote:
>>>>>>>>> That's
>>>>>>>>> basically the difference between the vhost/vDPA's
>>>>>>>>> selective passthrough
>>>>>>>>> approach and VFIO's full passthrough approach.
>>>>>>>> We can't do VFIO full pasthrough for migration anyway,
>>>>>>>> some kind of mdev is
>>>>>>>> required but it's duplicated with the current vp_vdpa driver.
>>>>>>> I'm not sure that's true. Generic VFIO PCI migration can 
>>>>>>> probably be
>>>>>>> achieved without mdev:
>>>>>>> 1. Define a migration PCI Capability that indicates support for
>>>>>>>       VFIO_REGION_TYPE_MIGRATION. This allows the PCI device
>>>>>>> to implement
>>>>>>>       the migration interface in hardware instead of an mdev 
>>>>>>> driver.
>>>>>> So I think it still depend on the driver to implement migrate
>>>>>> state which is
>>>>>> vendor specific.
>>>>> The current VFIO migration interface depends on a device-specific
>>>>> software mdev driver but here I'm showing that the physical device 
>>>>> can
>>>>> implement the migration interface so that no device-specific 
>>>>> driver code
>>>>> is needed.
>>>>
>>>> This is not what I read from the patch:
>>>>
>>>>   * device_state: (read/write)
>>>>   *      - The user application writes to this field to inform the 
>>>> vendor
>>>> driver
>>>>   *        about the device state to be transitioned to.
>>>>   *      - The vendor driver should take the necessary actions to 
>>>> change
>>>> the
>>>>   *        device state. After successful transition to a given 
>>>> state, the
>>>>   *        vendor driver should return success on write(device_state,
>>>> state)
>>>>   *        system call. If the device state transition fails, the 
>>>> vendor
>>>> driver
>>>>   *        should return an appropriate -errno for the fault 
>>>> condition.
>>>>
>>>> Vendor driver need to mediate between the uAPI and the actual device.
>>> We're building an infrastructure for VFIO PCI devices in the last few
>>> months.
>>>
>>> It should be merged hopefully to kernel 5.15.
>> Do you have links to patch series or a brief description of the VFIO API
>> features that are on the roadmap?
>
> we devided it to few patchsets .
>
> The entire series can be found at:
>
> https://github.com/jgunthorpe/linux/commits/mlx5_vfio_pci
>
> We'll first add support for mlx5 devices suspend/resume (ConnectX-6 
> and above).
>
> The driver is ready in the series above.
>
> The next step is to add Live migration for virtio. Hopefully we will 
> be able to agree on the Virtio PCI in the near future.


So I still think for vitio pci the migration should be done via vp_vdpa 
driver instead of using vfio/mdev.

Using vDPA have too much advantages (we had a lot of discussion in the 
past) via present a virtio device instead of a transport specific one:

1) software/management stack is ready
2) transport independent, micro VM ready
3) migration compatibility could be maintained
4) management API ready
5) fail-over or multi-path in the future

etc.


>
>>
>>>>
>>>>>> Note that it's just an uAPI definition not something defined in 
>>>>>> the PCI
>>>>>> spec.
>>>>> Yes, that's why I mentioned Changpeng Liu's idea to turn the uAPI 
>>>>> into a
>>>>> standard PCI Capability to eliminate the need for device-specific
>>>>> drivers.
>>>>
>>>> Ok.
>>>>
>>>>
>>>>>> Out of curiosity, the patch is merged without any real users in
>>>>>> the Linux.
>>>>>> This is very bad since we lose the change to audit the whole design.
>>>>> I agree. It would have helped to have a complete vision for how live
>>>>> migration should work along with demos. I don't see any migration 
>>>>> code
>>>>> in samples/vfio-mdev/ :(.
>>>>
>>>> Right.
>>> Creating a standard is not related to Linux nor VFIO.
>>>
>>> With the proposal that I've sent, we can develop a migration driver and
>>> virtio device that will support it (NVIDIA virtio-blk SNAP device).
>>>
>>> And you can build live migration support in virtio_vdpa driver (if VDPA
>>> migration protocol will be implemented).
>> I guess "VDPA migration protocol" is not referring to Jason's proposal
>> but instead to a new vDPA interface that adds the migration interface
>> from you proposal to vDPA?
>
> I mean a parallel protocol to VFIO.


Actually, the first step is to define the state and its API in the spec 
as both of us tries to achieve and make it independent to any kind of 
implementation (VFIO or vDPA).

Thanks


>
>
>> Stefan
>

