Return-Path: <virtio-dev-return-9518-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 276EB9863EB
	for <virtio-dev@lists.oasis-open.org>; Tue,  3 May 2022 13:00:53 +0000 (UTC)
Message-ID: <43a6caa0-d771-c5ca-c043-ea16f0bbda45@bytedance.com>
Date: Tue, 3 May 2022 14:00:49 +0100
MIME-Version: 1.0
References: <20220408174441.1002578-1-usama.arif@bytedance.com>
From: Usama Arif <usama.arif@bytedance.com>
In-Reply-To: <20220408174441.1002578-1-usama.arif@bytedance.com>
Subject: [virtio-dev] Re: [PATCH v2 0/4] Introduce aux. notifications and virtio-vhost-user
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: virtio-dev@lists.oasis-open.org, stefanha@redhat.com, mst@redhat.com
Cc: ndragazis@arrikto.com, fam.zheng@bytedance.com, liangma@liangbit.com
List-ID: <virtio-dev.lists.oasis-open.org>



On 08/04/2022 18:44, Usama Arif wrote:
> Hi,
> 
> This patch series introduces device and driver auxiliary notifications
> as a new set of virtio device resources, as well as vhost-user device
> backend that uses these resources.
> 
> Driver auxiliary notifications allow the device to send notifications
> other than configuration changes and used buffer notifications to the
> driver, these are optional and their meaning is **device-specific**.
> 
> Device auxiliary notifcations allow the driver to send notifcations
> other than available buffer notifications to the device for example
> through a device register, these are optional and their meaning is
> **device-specific**.
> 
> These resources are used in the last patch by the virtio-vhost-user
> device in order to send/receive notifications to/from the driver
> regarding activity on the vhost-user virtqueues. By standardizing
> these resources as standalone virtio device resources, other future
> devices will be able to use them as well.
> 
> The last patch introduces the vhost-user device backend which facilitates
> vhost-user device emulation through vhost-user protocol exchanges and
> access to shared memory. Software-defined networking, storage, and other
> I/O appliances can provide services through this device.
> 
> This device is based on Wei Wang's vhost-pci work. The virtio-vhost-user
> device differs from vhost-pci because it is a single virtio
> device type that exposes the vhost-user protocol instead of a family of
> new virtio device types, one for each vhost-user device type.
> 
> A HTML version with the changes is available at [1].
> 
> For more information about virtio-vhost-user, see [2].
> 
> These patches are based on the work initially done by Stefan Hajnoczi [2]
> and continued by Nikos Dragazis [3], [4].
> 
> A working prototype implementing this spec can be reproduced using
> instructions in [5] utilizing work done on top of v6.2.50 QEMU [6] and
> 22.03.0-rc4 DPDK [7].
> This is also based on the work initially done by Stefan
> and continued later by Nikos. The prototype code uses the terms
> "doorbell"/"device-specific notification" and "master"/"slave" instead of
> "device auxiliary notification"/"driver auxiliary notification" and
> "frontend"/"backend". This is based on older work, however, their
> functionality is the same. If these virtio-spec changes get approved,
> I will refractor the patches for QEMU/DPDK and send them for review
> according to the final patches in the respective mailing list.
> 
> Thanks and looking forward to your response!
> Usama

Hi,

Just wanted to check if there were any feedback/comments on the v2 of 
the patch?

Thanks!
Usama

> 
> [1] https://uarif1.github.io/vvu/v2/virtio-v1.1-cs01
> [2] https://wiki.qemu.org/Features/VirtioVhostUser
> [3] https://ndragazis.github.io/dpdk-vhost-vvu-demo.html
> [4] https://lists.oasis-open.org/archives/virtio-dev/202005/msg00132.html
> [5] https://uarif1.github.io/vvu/dpdk-vvu-instructions
> [6] https://github.com/uarif1/qemu/tree/vvu
> [7] https://github.com/uarif1/dpdk/tree/vvu
> ----------
> v1->v2:
> - Shortened device aux. notification section
> - Make data width of device aux. notifications device specific and not
>    limited to 2 bytes.
> - Added information about the minimum number of MSIX vectors.
> - Split virtio-mmio implementation of driver aux. notifications into 2
>    registers, DeviceAuxNotificationIndex and DeviceAuxNotificationData.
> - Made the shared memory section in virtio vhost-user clearer and added
>    the shared memory would look like when
>    VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS has been negotiated.
> 
> 
> Usama Arif (4):
>    content: Introduce driver/device auxiliary notifications
>    content: Introduce driver/device aux. notification cfg type for PCI
>    content: Introduce driver/device auxiliary notifications for MMIO
>    vhost-user: add vhost-user device type
> 
>   conformance.tex       |  29 ++++-
>   content.tex           | 254 ++++++++++++++++++++++++++++++------
>   introduction.tex      |   3 +
>   virtio-vhost-user.tex | 294 ++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 539 insertions(+), 41 deletions(-)
>   create mode 100644 virtio-vhost-user.tex
> 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

