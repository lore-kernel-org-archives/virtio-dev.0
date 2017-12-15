Return-Path: virtio-dev-return-2832-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 4AC035818F4D
	for <virtio-dev@lists.oasis-open.org>; Fri, 15 Dec 2017 02:31:20 -0800 (PST)
Message-ID: <5A33A4EA.7010204@intel.com>
Date: Fri, 15 Dec 2017 18:33:14 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <CAJSP0QUAqCzFgVtM1cg_KybdyrZa_FRUHhDN7oLfRjZ2ZVkp4g@mail.gmail.com> <286AC319A985734F985F78AFA26841F73937E001@shsmsx102.ccr.corp.intel.com> <20171211111147.GF13593@stefanha-x1.localdomain> <286AC319A985734F985F78AFA26841F73937EEED@shsmsx102.ccr.corp.intel.com> <20171212101440.GB6985@stefanha-x1.localdomain> <5A30E0C1.3070905@intel.com> <20171213123521.GL16782@stefanha-x1.localdomain> <20171213165142-mutt-send-email-mst@kernel.org> <CAJSP0QWHJBL4APkeMt8-P8PFaPF=Vbi0NSnJtU7YX67fJrW=hw@mail.gmail.com> <20171213222102-mutt-send-email-mst@kernel.org> <20171214150609.GQ14433@stefanha-x1.localdomain>
In-Reply-To: <20171214150609.GQ14433@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [Qemu-devel] [virtio-dev] [PATCH v3 0/7] Vhost-pci for inter-VM
 communication
To: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Yang, Zhiyong" <zhiyong.yang@intel.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "avi.cohen@huawei.com" <avi.cohen@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 12/14/2017 11:06 PM, Stefan Hajnoczi wrote:
> On Wed, Dec 13, 2017 at 10:59:10PM +0200, Michael S. Tsirkin wrote:
>>>   * VHOST_USER_SET_VRING_KICK
>>>
>>>     Set up vring kick doorbell (unless bit 8 is set) before sending
>>>     VHOST_USER_SET_VRING_KICK to the guest.
>> But guest can't use it, now can it?
>>
>> What guest needs is a mapping to interrupts.
> ...
>>>   * VHOST_USER_SET_VRING_CALL
>>>
>>>     Set up the vring call doorbell (unless bit 8 is set) before sending
>>>     VHOST_USER_SET_VRING_CALL to the guest.
>> Same here. what guest needs is mapping from io to notifications,
>> right?
> The PCI device should contain a BAR with doorbell registers.  I don't
> think a fancy mapping is necessary, instead the device spec should
> define the BAR layout.
>
> When the guest vhost-user slave receives this message it knows it can
> now begin using the doorbell register.

Not really. A doorbell will cause an interrupt to be injected to the 
master device driver, which is not ready to work at that time. The slave 
driver isn't expected to use the doorbell until the master is ready by 
sending the last message VHOST_USER_SET_VHOST_PCI to link UP the slave 
device.

So I think passing the fd msg to guest doesn't have a value in terms of 
functionality.

Best,
Wei





---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

