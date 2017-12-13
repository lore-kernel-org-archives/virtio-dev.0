Return-Path: virtio-dev-return-2815-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 15F17581809C
	for <virtio-dev@lists.oasis-open.org>; Wed, 13 Dec 2017 13:50:26 -0800 (PST)
References: <CAJSP0QX4V64OoU4-Dhb93MUZ9Rz0FPR-La5Xq4_yqGH7SG6PjQ@mail.gmail.com>
 <20171207213420-mutt-send-email-mst@kernel.org> <5A2A347B.9070006@intel.com>
 <CAJSP0QUAqCzFgVtM1cg_KybdyrZa_FRUHhDN7oLfRjZ2ZVkp4g@mail.gmail.com>
 <286AC319A985734F985F78AFA26841F73937E001@shsmsx102.ccr.corp.intel.com>
 <20171211111147.GF13593@stefanha-x1.localdomain>
 <286AC319A985734F985F78AFA26841F73937EEED@shsmsx102.ccr.corp.intel.com>
 <20171212101440.GB6985@stefanha-x1.localdomain> <5A30E0C1.3070905@intel.com>
 <20171213123521.GL16782@stefanha-x1.localdomain>
 <20171213165142-mutt-send-email-mst@kernel.org>
 <CAJSP0QWHJBL4APkeMt8-P8PFaPF=Vbi0NSnJtU7YX67fJrW=hw@mail.gmail.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <825b8205-0b88-a198-b77d-63c8f2563c2e@redhat.com>
Date: Wed, 13 Dec 2017 22:50:11 +0100
MIME-Version: 1.0
In-Reply-To: <CAJSP0QWHJBL4APkeMt8-P8PFaPF=Vbi0NSnJtU7YX67fJrW=hw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [Qemu-devel] [virtio-dev] [PATCH v3 0/7] Vhost-pci for inter-VM
 communication
To: Stefan Hajnoczi <stefanha@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Yang, Zhiyong" <zhiyong.yang@intel.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "avi.cohen@huawei.com" <avi.cohen@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Stefan,

On 12/13/2017 09:08 PM, Stefan Hajnoczi wrote:
> On Wed, Dec 13, 2017 at 3:01 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> On Wed, Dec 13, 2017 at 12:35:21PM +0000, Stefan Hajnoczi wrote:
>>> I'm not saying that DPDK should use libvhost-user.  I'm saying that it's
>>> easy to add vfio vhost-pci support (for the PCI adapter I described) to
>>> DPDK.  This patch series would require writing a completely new slave
>>> for vhost-pci because the device interface is so different from
>>> vhost-user.
>>
>> The main question is how appropriate is the vhost user protocol
>> for passing to guests. And I am not sure at this point.
>>
>> Someone should go over vhost user messages and see whether they are safe
>> to pass to guest. If most are then we can try the transparent approach.
>> If most aren't then we can't and might as well use the proposed protocol
>> which at least has code behind it.
> 
> I have done that:
> 
...
>   * VHOST_USER_SET_MEM_TABLE
> 
>     Set up BARs before sending a VHOST_USER_SET_MEM_TABLE to the guest.

It would require to filter out userspace_addr from the payload not to
leak other QEMU process VAs to the guest.

Maxime

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

