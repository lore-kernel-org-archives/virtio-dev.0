Return-Path: virtio-dev-return-6747-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5B4AA986113
	for <virtio-dev@lists.oasis-open.org>; Thu, 13 Feb 2020 03:38:51 +0000 (UTC)
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <8a4ea95d6d77a2814aaf6897b5517353289a098e.1581305609.git.zhabin@linux.alibaba.com>
 <20200211062205-mutt-send-email-mst@kernel.org>
 <ef613d3a-0372-64f3-7644-2e88cc9d4355@redhat.com>
 <20200212024158-mutt-send-email-mst@kernel.org>
 <d4eb9cde-5d06-3df9-df28-15378a9c6929@redhat.com>
 <82d99b35-0c64-2eb2-9c23-7af2597b880b@redhat.com>
 <20200212045245-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ff1a4d50-cfff-a354-3c64-30a6ed50a9fe@redhat.com>
Date: Thu, 13 Feb 2020 11:38:31 +0800
MIME-Version: 1.0
In-Reply-To: <20200212045245-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v2 1/5] virtio-mmio: add notify feature for per-queue
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Zha Bin <zhabin@linux.alibaba.com>, slp@redhat.com, jing2.liu@linux.intel.com, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, chao.p.peng@linux.intel.com, gerry@linux.alibaba.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 2020/2/12 =E4=B8=8B=E5=8D=885:55, Michael S. Tsirkin wrote:
> On Wed, Feb 12, 2020 at 05:33:06PM +0800, Jason Wang wrote:
>> On 2020/2/12 =E4=B8=8B=E5=8D=884:53, Jason Wang wrote:
>>> On 2020/2/12 =E4=B8=8B=E5=8D=884:18, Michael S. Tsirkin wrote:
>>>> On Wed, Feb 12, 2020 at 11:39:54AM +0800, Jason Wang wrote:
>>>>> On 2020/2/11 =E4=B8=8B=E5=8D=887:33, Michael S. Tsirkin wrote:
>>>>>> On Mon, Feb 10, 2020 at 05:05:17PM +0800, Zha Bin wrote:
>>>>>>> From: Liu Jiang<gerry@linux.alibaba.com>
>>>>>>>
>>>>>>> The standard virtio-mmio devices use notification register to signa=
l
>>>>>>> backend. This will cause vmexits and slow down the
>>>>>>> performance when we
>>>>>>> passthrough the virtio-mmio devices to guest virtual machines.
>>>>>>> We proposed to update virtio over MMIO spec to add the per-queue
>>>>>>> notify feature VIRTIO_F_MMIO_NOTIFICATION[1]. It can allow the VMM =
to
>>>>>>> configure notify location for each queue.
>>>>>>>
>>>>>>> [1]https://lkml.org/lkml/2020/1/21/31
>>>>>>>
>>>>>>> Signed-off-by: Liu Jiang<gerry@linux.alibaba.com>
>>>>>>> Co-developed-by: Zha Bin<zhabin@linux.alibaba.com>
>>>>>>> Signed-off-by: Zha Bin<zhabin@linux.alibaba.com>
>>>>>>> Co-developed-by: Jing Liu<jing2.liu@linux.intel.com>
>>>>>>> Signed-off-by: Jing Liu<jing2.liu@linux.intel.com>
>>>>>>> Co-developed-by: Chao Peng<chao.p.peng@linux.intel.com>
>>>>>>> Signed-off-by: Chao Peng<chao.p.peng@linux.intel.com>
>>>>>> Hmm. Any way to make this static so we don't need
>>>>>> base and multiplier?
>>>>> E.g page per vq?
>>>>>
>>>>> Thanks
>>>> Problem is, is page size well defined enough?
>>>> Are there cases where guest and host page sizes differ?
>>>> I suspect there might be.
>>>
>>> Right, so it looks better to keep base and multiplier, e.g for vDPA.
>>>
>>>
>>>> But I also think this whole patch is unproven. Is someone actually
>>>> working on QEMU code to support pass-trough of virtio-pci
>>>> as virtio-mmio for nested guests? What's the performance
>>>> gain like?
>>>
>>> I don't know.
>>>
>>> Thanks
>>
>> Btw, I think there's no need for a nested environment to test. Current
>> eventfd hook to MSIX should still work for MMIO.
>>
>> Thanks
>
> Oh yes it's the wildcard thingy but how much extra performance does one g=
et
> from it with MMIO? A couple % might not be worth the trouble for MMIO.


The cover letter have some numbers but I'm not sure whether or not it=20
was measured by vhost or other which needs some clarification.

Thanks


>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

