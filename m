Return-Path: virtio-dev-return-2768-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 4F9835819115
	for <virtio-dev@lists.oasis-open.org>; Wed,  6 Dec 2017 02:30:53 -0800 (PST)
Message-ID: <5A27C752.2050906@intel.com>
Date: Wed, 06 Dec 2017 18:32:50 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com> <1512444796-30615-6-git-send-email-wei.w.wang@intel.com> <20171205160020.GH31150@stefanha-x1.localdomain>
In-Reply-To: <20171205160020.GH31150@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] Re: [PATCH v3 5/7] vhost-user: VHOST_USER_SET_VHOST_PCI
 msg
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, jan.kiszka@siemens.com, avi.cohen@huawei.com, zhiyong.yang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 12/06/2017 12:00 AM, Stefan Hajnoczi wrote:
> On Tue, Dec 05, 2017 at 11:33:14AM +0800, Wei Wang wrote:
>> Add a new vhost-uer protocol msg, VHOST_USER_SET_VHOST_PCI. This msg is
>> used to signal the vhost-pci device to start/stop working.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> ---
>>   hw/net/vhost_net.c                | 37 +++++++++++++++++++++++++++++++++++++
>>   hw/virtio/vhost-pci-slave.c       |  2 +-
>>   hw/virtio/vhost-user.c            | 17 +++++++++++++++++
>>   hw/virtio/vhost.c                 |  7 +++++++
>>   include/hw/virtio/vhost-backend.h |  2 ++
>>   include/hw/virtio/vhost-user.h    |  2 ++
>>   include/hw/virtio/vhost.h         |  2 ++
>>   include/net/vhost_net.h           |  2 ++
>>   8 files changed, 70 insertions(+), 1 deletion(-)
> New protocol messages must be documented in docs/interop/vhost-user.txt.

OK, I'll add it to the doc after the discussion.

>
> Why is a new message needed?  I'm not sure why it is specific to
> vhost-pci.

Yes, it might be useful for other vhost-user slave implementations. 
Probably we can name it "VHOST_USER_SET_SLAVE"?
The message is used to "link up" or "link down" the slave device. For 
example, when virtio-net leaves, it sends a "VHOST_USER_SET_SLAVE" msg 
to the salve to link down the slave device.
(a similar msg is VHOST_USER_SET_VRING_ENABLE, but that is for virtqueue 
enable/disable, not for a device level enable/disable)

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

