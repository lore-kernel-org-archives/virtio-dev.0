Return-Path: virtio-dev-return-6748-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 50118986113
	for <virtio-dev@lists.oasis-open.org>; Thu, 13 Feb 2020 03:40:51 +0000 (UTC)
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <4c3d13be5a391b1fc50416838de57d903cbf8038.1581305609.git.zhabin@linux.alibaba.com>
 <0c71ff9d-1a7f-cfd2-e682-71b181bdeae4@redhat.com>
 <c42c8b49-5357-f341-2942-ba84afc25437@linux.intel.com>
 <ad96269f-753d-54b8-a4ae-59d1595dd3b2@redhat.com>
 <5522f205-207b-b012-6631-3cc77dde3bfe@linux.intel.com>
 <45e22435-08d3-08fe-8843-d8db02fcb8e3@redhat.com>
 <4c19292f-9d25-a859-3dde-6dd5a03fdf0b@linux.intel.com>
 <44209f3c-613c-3766-ca83-321b77b0f0dd@redhat.com>
 <20200212041554-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d4123292-88e8-0879-7474-ca5f7f9f801f@redhat.com>
Date: Thu, 13 Feb 2020 11:40:37 +0800
MIME-Version: 1.0
In-Reply-To: <20200212041554-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [PATCH v2 4/5] virtio-mmio: add MSI interrupt
 feature support
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Liu, Jing2" <jing2.liu@linux.intel.com>, Zha Bin <zhabin@linux.alibaba.com>, linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org, slp@redhat.com, qemu-devel@nongnu.org, chao.p.peng@linux.intel.com, gerry@linux.alibaba.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 2020/2/12 =E4=B8=8B=E5=8D=885:16, Michael S. Tsirkin wrote:
>>> Thanks for the advice.:)
>>>
>>> Actually when looking into pci, the queue_msix_vector/msix_config is th=
e
>>> msi vector index, which is the same as the mmio register MsiVecSel
>>> (0x0d0).
>>>
>>> So we don't introduce two extra registers for mapping even in sharing
>>> mode.
>>>
>>> What do you think?
>>>
>> I'm not sure I get the point, but I still prefer the separate vector_sel
>> from queue_msix_vector.
>>
>> Btw, Michael propose per vq registers which could also work.
>>
>> Thanks
>>
> Right and I'd even ask a question: do we need shared MSI at all?


I guess it is still needed at least for the current virtio code.=20
Technically we may have thousands queues.

Thanks


> Is it somehow better than legacy interrupt? And why?
> Performance numbers please.
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

