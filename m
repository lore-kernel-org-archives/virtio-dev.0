Return-Path: virtio-dev-return-6579-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3D2C1985C94
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Jan 2020 06:55:51 +0000 (UTC)
References: <cover.1577240905.git.zhabin@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6143fb9b-ad2e-a771-f7a2-91bd9f1b7873@redhat.com>
Date: Thu, 2 Jan 2020 14:55:27 +0800
MIME-Version: 1.0
In-Reply-To: <cover.1577240905.git.zhabin@linux.alibaba.com>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v1 0/2] support virtio mmio specification Version 3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Zha Bin <zhabin@linux.alibaba.com>, linux-kernel@vger.kernel.org
Cc: mst@redhat.com, slp@redhat.com, virtio-dev@lists.oasis-open.org, gerry@linux.alibaba.com, jing2.liu@intel.com, chao.p.peng@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 2019/12/25 =E4=B8=8A=E5=8D=8810:50, Zha Bin wrote:
> With the virtio spec proposal[1], other VMMs (e.g. Qemu) can also make us=
e
> of the new features to get a enhancing performance.
>
> [1]https://lkml.org/lkml/2019/12/20/113
>
> Liu Jiang (2):
>    x86/msi: Enhance x86 to support platform_msi
>    virtio-mmio: add features for virtio-mmio specification version 3


Btw, for next version I suggest to copy both kvm-devel list and=20
qemu-devel list.

Thanks



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

