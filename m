Return-Path: virtio-dev-return-5233-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B4EB1985AFA
	for <virtio-dev@lists.oasis-open.org>; Thu,  3 Jan 2019 09:57:28 +0000 (UTC)
Date: Thu, 3 Jan 2019 10:57:20 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190103105720.48e6c2c6.cohuck@redhat.com>
In-Reply-To: <1545963986-11280-2-git-send-email-wei.w.wang@intel.com>
References: <1545963986-11280-1-git-send-email-wei.w.wang@intel.com>
	<1545963986-11280-2-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v1 1/2] virtio_pci: use queue idx instead of array idx
 to set up the vq
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, mst@redhat.com, borntraeger@de.ibm.com, pbonzini@redhat.com, dgilbert@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, 28 Dec 2018 10:26:25 +0800
Wei Wang <wei.w.wang@intel.com> wrote:

> When find_vqs, there will be no vq[i] allocation if its corresponding
> names[i] is NULL. For example, the caller may pass in names[i] (i=4)
> with names[2] being NULL because the related feature bit is turned off,
> so technically there are 3 queues on the device, and name[4] should
> correspond to the 3rd queue on the device.
> 
> So we use queue_idx as the queue index, which is increased only when the
> queue exists.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>  drivers/virtio/virtio_pci_common.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

