Return-Path: virtio-dev-return-6595-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 71C6A984400
	for <virtio-dev@lists.oasis-open.org>; Mon,  6 Jan 2020 07:24:23 +0000 (UTC)
References: <cover.1577240905.git.zhabin@linux.alibaba.com>
 <a11d4c616158c9fb1ca4575ca0530b2e17b952fa.1577240905.git.zhabin@linux.alibaba.com>
 <229e689d-10f1-2bfb-c393-14dfa9c78971@redhat.com>
 <0460F92A-3DF6-4F7A-903B-6434555577CC@linux.alibaba.com>
 <f8b46502-a5a5-c5c6-88df-101dbfd02fda@redhat.com>
 <56703BDA-B7AE-4656-8061-85FD1A130597@linux.alibaba.com>
 <20200105054142-mutt-send-email-mst@kernel.org>
From: "Liu, Jing2" <jing2.liu@linux.intel.com>
Message-ID: <ec003137-c08f-cda6-6a94-d37d5460189c@linux.intel.com>
Date: Mon, 6 Jan 2020 15:24:18 +0800
MIME-Version: 1.0
In-Reply-To: <20200105054142-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v1 2/2] virtio-mmio: add features for virtio-mmio
 specification version 3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, "Liu, Jiang" <gerry@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, Zha Bin <zhabin@linux.alibaba.com>, linux-kernel@vger.kernel.org, slp@redhat.com, virtio-dev@lists.oasis-open.org, jing2.liu@intel.com, chao.p.peng@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 1/5/2020 6:42 PM, Michael S. Tsirkin wrote:
> On Thu, Dec 26, 2019 at 09:16:19PM +0800, Liu, Jiang wrote:
>>> 2) The mask and unmask control is missed
>>>
>>>
>>>>   but the extension doesn=E2=80=99t support 3) because
>>>> we noticed that the Linux virtio subsystem doesn=E2=80=99t really make=
 use of interrupt masking/unmasking.
> Linux uses masking/unmasking in order to migrate interrupts between
> CPUs.

Hi Michael,

Thanks for reviewing the patches!

When trying to study the mask/unmask use case during migrating irq, it=20
seems being used e.g.

1) migrate irq(s) away from offline cpu

2) irq affinity is changing, while an interrupt comes so it sets=20
SETAFFINITY_PENDING and

the lapic (e.g. x86) does the mask and unmask to finish the pending=20
during ack.

Is this right? So we should have mask/unmask for each vector.

Thanks,

Jing


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

