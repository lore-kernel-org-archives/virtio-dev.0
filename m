Return-Path: virtio-dev-return-6741-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C2783985DD2
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Feb 2020 09:03:25 +0000 (UTC)
References: <4c3d13be5a391b1fc50416838de57d903cbf8038.1581305609.git.zhabin@linux.alibaba.com>
 <0c71ff9d-1a7f-cfd2-e682-71b181bdeae4@redhat.com>
 <c42c8b49-5357-f341-2942-ba84afc25437@linux.intel.com>
 <ad96269f-753d-54b8-a4ae-59d1595dd3b2@redhat.com>
 <5522f205-207b-b012-6631-3cc77dde3bfe@linux.intel.com>
 <45e22435-08d3-08fe-8843-d8db02fcb8e3@redhat.com>
 <20200211065319-mutt-send-email-mst@kernel.org>
 <c4a78a15-c889-df3f-3e1e-7df1a4d67838@redhat.com>
 <20200211070523-mutt-send-email-mst@kernel.org>
 <fdb19ef4-2003-6c6f-5c6f-c757a6320130@redhat.com>
 <20200211090003-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4557a5e8-74eb-f238-1579-b7b558cb2969@redhat.com>
Date: Wed, 12 Feb 2020 17:03:00 +0800
MIME-Version: 1.0
In-Reply-To: <20200211090003-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [PATCH v2 4/5] virtio-mmio: add MSI interrupt
 feature support
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Zha Bin <zhabin@linux.alibaba.com>, slp@redhat.com, "Liu, Jing2" <jing2.liu@linux.intel.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, chao.p.peng@linux.intel.com, gerry@linux.alibaba.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 2020/2/11 =E4=B8=8B=E5=8D=8810:00, Michael S. Tsirkin wrote:
>> Yes, it can work but it may bring extra effort when you want to mask a
>> vector which is was shared by a lot of queues.
>>
>> Thanks
>>
> masking should be per vq too.
>
> --=20


Yes, but if the vector is shard by e.g 16 queues, then all those=20
virtqueues needs to be masked which is expensive.

Thanks



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

