Return-Path: virtio-dev-return-7223-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 99751985B04
	for <virtio-dev@lists.oasis-open.org>; Thu, 30 Apr 2020 10:57:13 +0000 (UTC)
References: <1588240976-10213-1-git-send-email-vatsa@codeaurora.org>
 <20200430060653-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <49422625-add9-a13a-6a29-cf761be4cb3a@redhat.com>
Date: Thu, 30 Apr 2020 18:56:57 +0800
MIME-Version: 1.0
In-Reply-To: <20200430060653-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Subject: [virtio-dev] Re: [RFC/PATCH 0/1] virtio_mmio: hypervisor specific interfaces for
 MMIO
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, Srivatsa Vaddagiri <vatsa@codeaurora.org>
Cc: konrad.wilk@oracle.com, jan.kiszka@siemens.com, will@kernel.org, stefano.stabellini@xilinx.com, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, tsoni@codeaurora.org, pratikp@codeaurora.org, christoffer.dall@arm.com, alex.bennee@linaro.org, linux-kernel@vger.kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>


On 2020/4/30 =E4=B8=8B=E5=8D=886:07, Michael S. Tsirkin wrote:
> On Thu, Apr 30, 2020 at 03:32:55PM +0530, Srivatsa Vaddagiri wrote:
>> The Type-1 hypervisor we are dealing with does not allow for MMIO transp=
ort.
> How about PCI then?


Or maybe you can use virtio-vdpa.

Thanks



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

