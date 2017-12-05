Return-Path: virtio-dev-return-2746-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 737C55818F4E
	for <virtio-dev@lists.oasis-open.org>; Mon,  4 Dec 2017 23:01:52 -0800 (PST)
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3be9aa23-ca3b-2b16-ecf1-83388365c6b0@redhat.com>
Date: Tue, 5 Dec 2017 15:01:25 +0800
MIME-Version: 1.0
In-Reply-To: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH v3 0/7] Vhost-pci for inter-VM communication
To: Wei Wang <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com, stefanha@redhat.com, pbonzini@redhat.com
Cc: jan.kiszka@siemens.com, avi.cohen@huawei.com, zhiyong.yang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>



On 2017年12月05日 11:33, Wei Wang wrote:
> Vhost-pci is a point-to-point based inter-VM communication solution. This
> patch series implements the vhost-pci-net device setup and emulation. The
> device is implemented as a virtio device, and it is set up via the
> vhost-user protocol to get the neessary info (e.g the memory info of the
> remote VM, vring info).
>
> Currently, only the fundamental functions are implemented. More features,
> such as MQ and live migration, will be updated in the future.
>
> The DPDK PMD of vhost-pci has been posted to the dpdk mailinglist here:
> http://dpdk.org/ml/archives/dev/2017-November/082615.html
>
> v2->v3 changes:
> 1) static device creation: instead of creating and hot-plugging the
>     device when receiving a vhost-user msg, the device is not created
>     via the qemu booting command line.
> 2) remove vqs: rq and ctrlq are removed in this version.
>      - receive vq: the receive vq is not needed anymore. The PMD directly
>                    shares the remote txq and rxq - grab from remote txq to
>                    receive packets, and put to rxq to send packets.
>      - ctrlq: the ctrlq is replaced by the first 4KB metadata area of the
>               device Bar-2.
> 3) simpler implementation: the entire implementation has been tailored
>     from ~1800 LOC to ~850 LOC.

Hi:

Any performance numbers you can share?

Thanks

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

