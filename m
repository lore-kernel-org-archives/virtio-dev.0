Return-Path: <jasowang@redhat.com>
Subject: Re: [virtio-comment] [PATCH V2 2/2] virtio: introduce STOP status bit
References: <YOwSGeL+lfTxHuXg@stefanha-x1.localdomain>
 <3ce9775c-64fa-1c9b-6627-55f3b18ac987@redhat.com>
 <YO1kQ8sBkr2eguvi@stefanha-x1.localdomain>
 <8a2037df-e527-dcb4-c4c8-a568885180e4@redhat.com>
 <YO60HpxfZnmfMCMj@stefanha-x1.localdomain>
 <094e15d4-169a-87e9-5ebb-93439ea72831@redhat.com>
 <YO79tuI72kTEWURN@stefanha-x1.localdomain>
 <1ab19438-cc13-bbe5-7fec-53a113d85463@redhat.com>
 <YPAHcG7bxhlIGVeE@stefanha-x1.localdomain>
 <c626c856-7010-0df6-131f-00aad7221266@redhat.com>
 <YPVzcLGj591X37fX@stefanha-x1.localdomain>
 <48a8b9f0-d68f-e5a0-1d7b-43e61bda603c@redhat.com>
 <d4e7afdd-943d-73bd-3c31-c07543392819@nvidia.com>
 <0b278344-c732-53c3-59b0-b581109bbee5@redhat.com>
 <94180b9d-0fcd-5522-8352-81e29e68fa8a@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f1dc87f3-4b47-4d74-ce33-52b13e68ac55@redhat.com>
Date: Thu, 22 Jul 2021 10:01:06 +0800
MIME-Version: 1.0
In-Reply-To: <94180b9d-0fcd-5522-8352-81e29e68fa8a@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Cornelia Huck <cohuck@redhat.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>


在 2021/7/21 下午7:43, Max Gurtovoy 写道:
>>
>>
>> Right, vp_vdpa fit naturally for this. But I don't see the much value 
>> of a dedicated migration driver, do you?
>
> I don't know how VDPA device advertise migration capability to QEMU. 


This is done by vhost-vDPA via advertising vhost feature 
VHOST_F_LOG_ALL, otherwise qemu will block the migration.

vhost-vDPA inherits the vhost uAPI, so at the uAPI level we had:

1) VHOST_SET_VRING_BASE/VHOST_GET_VRING_BASE for syncing index
2) VHOST_SET_LOG_BASE for setting the address of the dirty page bitmap
3) VHOST_VDPA_SET_STATUS for setting the device status

Note that, vhost-vDPA doesn't implement 2) since we're not sure the 
dirty page bitmap is the way we need to go for hardware, it would just 
take few lines for introducing them in vDPA bus level.

So from vDPA point of view, it's a vhost device. And the vDPA networking 
device is driven by the qemu vhost-vDPA module.

Without VHOST_SET_LOG_BASE, Eugenio is working on the shadow virtqueue 
for tracking dirty pages in software to live migrate a vDPA device.

Assuming the VHOST_SET_LOG_BASE or other dirty logging mechanism is 
implemented, we can live migrate a networking vDPA device with the 
hardware assisted dirty page tracking.

For the device state like filters, mac, qemu will intercept the control 
command so we don't need any API for querying those states from the 
devices. So the above three uAPIs are sufficient for live migrating a 
virtio-net vDPA device, and the migration compatibility is kept 
perfectly since it was seamlessly integrated with the current vhost 
protocol.

When the device/virtio specific mechanism for device state 
synchronization is invented, we can introduce uAPI for them.

Thanks

