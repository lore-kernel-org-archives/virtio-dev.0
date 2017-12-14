Return-Path: virtio-dev-return-2824-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id D7AF75818CAD
	for <virtio-dev@lists.oasis-open.org>; Thu, 14 Dec 2017 08:50:36 -0800 (PST)
References: <286AC319A985734F985F78AFA26841F73937EEED@shsmsx102.ccr.corp.intel.com>
 <20171212101440.GB6985@stefanha-x1.localdomain> <5A30E0C1.3070905@intel.com>
 <20171213123521.GL16782@stefanha-x1.localdomain>
 <20171213165142-mutt-send-email-mst@kernel.org>
 <CAJSP0QWHJBL4APkeMt8-P8PFaPF=Vbi0NSnJtU7YX67fJrW=hw@mail.gmail.com>
 <825b8205-0b88-a198-b77d-63c8f2563c2e@redhat.com>
 <20171214154656.GR14433@stefanha-x1.localdomain>
 <20171214180830-mutt-send-email-mst@kernel.org>
 <31609e8a-8446-cc8c-dc3b-a72d37086358@redhat.com>
 <20171214184009-mutt-send-email-mst@kernel.org>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <f705f911-ec01-0ae2-1274-a2ffb9bf1015@redhat.com>
Date: Thu, 14 Dec 2017 17:50:22 +0100
MIME-Version: 1.0
In-Reply-To: <20171214184009-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] Re: [Qemu-devel] [virtio-dev] [PATCH v3 0/7]
 Vhost-pci for inter-VM communication
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Wei Wang <wei.w.wang@intel.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Yang, Zhiyong" <zhiyong.yang@intel.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "avi.cohen@huawei.com" <avi.cohen@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, snabb-devel@googlegroups.com, dgilbert@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>



On 12/14/2017 05:40 PM, Michael S. Tsirkin wrote:
> On Thu, Dec 14, 2017 at 05:39:19PM +0100, Maxime Coquelin wrote:
>>
>>
>> On 12/14/2017 05:27 PM, Michael S. Tsirkin wrote:
>>> On Thu, Dec 14, 2017 at 03:46:56PM +0000, Stefan Hajnoczi wrote:
>>>> On Wed, Dec 13, 2017 at 10:50:11PM +0100, Maxime Coquelin wrote:
>>>>> On 12/13/2017 09:08 PM, Stefan Hajnoczi wrote:
>>>>>> On Wed, Dec 13, 2017 at 3:01 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>>>> On Wed, Dec 13, 2017 at 12:35:21PM +0000, Stefan Hajnoczi wrote:
>>>>>>>> I'm not saying that DPDK should use libvhost-user.  I'm saying that it's
>>>>>>>> easy to add vfio vhost-pci support (for the PCI adapter I described) to
>>>>>>>> DPDK.  This patch series would require writing a completely new slave
>>>>>>>> for vhost-pci because the device interface is so different from
>>>>>>>> vhost-user.
>>>>>>>
>>>>>>> The main question is how appropriate is the vhost user protocol
>>>>>>> for passing to guests. And I am not sure at this point.
>>>>>>>
>>>>>>> Someone should go over vhost user messages and see whether they are safe
>>>>>>> to pass to guest. If most are then we can try the transparent approach.
>>>>>>> If most aren't then we can't and might as well use the proposed protocol
>>>>>>> which at least has code behind it.
>>>>>>
>>>>>> I have done that:
>>>>>>
>>>>> ...
>>>>>>     * VHOST_USER_SET_MEM_TABLE
>>>>>>
>>>>>>       Set up BARs before sending a VHOST_USER_SET_MEM_TABLE to the guest.
>>>>>
>>>>> It would require to filter out userspace_addr from the payload not to
>>>>> leak other QEMU process VAs to the guest.
>>>>
>>>> QEMU's vhost-user master implementation is insecure because it leaks
>>>> QEMU process VAs.  This also affects vhost-user host processes, not just
>>>> vhost-pci.
>>>>
>>>> The QEMU vhost-user master could send an post-IOMMU guest physical
>>>> addresses whereever the vhost-user protocol specification says "user
>>>> address".  That way no address space information is leaked although it
>>>> does leak IOMMU mappings.
>>>>
>>>> If we want to hide the IOMMU mappings too then we need another logical
>>>> address space (kind a randomized ramaddr_t).
>>>>
>>>> Anyway, my point is that the current vhost-user master implementation is
>>>> insecure and should be fixed.  vhost-pci doesn't need to worry about
>>>> this issue.
>>>>
>>>> Stefan
>>>
>>> I was going to make this point too.  It does not look like anyone uses
>>> userspace_addr. It might have been a mistake to put it there -
>>> maybe we should have reused it for map offset.
>>>
>>> It does not look like anyone uses this for anything.
>>>
>>> How about we put zero, or a copy of the GPA there?
>>>
>>>
>>
>> It is used when no iommu for the ring addresses, and when iommu is used
>> for the IOTLB update messages.
>>
>> Maxime
> 
> How do clients use it? Why won't GPA do just as well?

It is used to calculate the offset in the regions, so if we change all
to use GPA, it may work without backend change.

Maxime

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

