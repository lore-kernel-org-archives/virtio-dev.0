Return-Path: virtio-dev-return-2769-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 4E4895819115
	for <virtio-dev@lists.oasis-open.org>; Wed,  6 Dec 2017 02:44:10 -0800 (PST)
Message-ID: <5A27CA70.8020704@intel.com>
Date: Wed, 06 Dec 2017 18:46:08 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com> <1512444796-30615-8-git-send-email-wei.w.wang@intel.com> <20171205160512.GI31150@stefanha-x1.localdomain>
In-Reply-To: <20171205160512.GI31150@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] Re: [PATCH v3 7/7] virtio/vhost.c: vhost-pci needs
 remote gpa
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, jan.kiszka@siemens.com, avi.cohen@huawei.com, zhiyong.yang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 12/06/2017 12:05 AM, Stefan Hajnoczi wrote:
> On Tue, Dec 05, 2017 at 11:33:16AM +0800, Wei Wang wrote:
>> The vhost-pci driver uses the remote guest physical address to send/receive
>> packets from the remote guest, so when sending the ving info to the vhost-pci
>> device, send the guest physical adress directly.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> ---
>>   hw/virtio/vhost.c | 56 +++++++++++++++++++++++++++++++++++--------------------
>>   1 file changed, 36 insertions(+), 20 deletions(-)
> Can you do it inside vhost_memory_map()/vhost_memory_unmap() instead of
> modifying callers?
>
> Looks like vhost_dev_has_iommu() already takes this approach:
>
>    static void *vhost_memory_map(struct vhost_dev *dev, hwaddr addr,
>                                  hwaddr *plen, int is_write)
>    {
>        if (!vhost_dev_has_iommu(dev)) {
>            return cpu_physical_memory_map(addr, plen, is_write);
>        } else {
>            return (void *)(uintptr_t)addr;
>        }
>    }
>
>    static void vhost_memory_unmap(struct vhost_dev *dev, void *buffer,
>                                   hwaddr len, int is_write,
>                                   hwaddr access_len)
>    {
>        if (!vhost_dev_has_iommu(dev)) {
>            cpu_physical_memory_unmap(buffer, len, is_write, access_len);
>        }
>    }

Thanks for the reminder. I think this patch may be not needed with 
adding the F_IOMMU_PLATFORM feature.


Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

