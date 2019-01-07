Return-Path: virtio-dev-return-5259-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AA521984257
	for <virtio-dev@lists.oasis-open.org>; Mon,  7 Jan 2019 13:40:31 +0000 (UTC)
References: <1546844466-38079-1-git-send-email-wei.w.wang@intel.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 7 Jan 2019 14:40:23 +0100
MIME-Version: 1.0
In-Reply-To: <1546844466-38079-1-git-send-email-wei.w.wang@intel.com>
Content-Language: en-US
Message-Id: <8eaba95f-5d3f-f225-31bf-65e6425330be@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH v3 0/3] virtio-balloon: tweak config_changed
To: Wei Wang <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, mst@redhat.com, cohuck@redhat.com
Cc: pbonzini@redhat.com, dgilbert@redhat.com, pasic@linux.ibm.com
List-ID: <virtio-dev.lists.oasis-open.org>

Can you please cc stable? Right now 4.20 does not work under KVM.



On 07.01.2019 08:01, Wei Wang wrote:
> Since virtio-ccw doesn't work with accessing to the config space
> inside an interrupt context, this patch series avoids that issue by
> moving the config register accesses to the related workqueue contexts.
> 
> v2->v3 ChangeLog:
>     - rename cmd_id_received to cmd_id_received_cache, and have call sites
>       read the latest value via virtio_balloon_cmd_id_received. (Still
>       kept Cornelia and Halil's reviewed-by as it's a minor change)
>     - remove zeroing vb->num_free_page_blocks in probe since vb is
>       allocated via kzalloc.
> v1->v2 ChangeLog:
>     - add config_read_bitmap to indicate to the workqueue callbacks about
>       the necessity of reading the related config fields.
> 
> Wei Wang (3):
>   virtio-balloon: tweak config_changed implementation
>   virtio-balloon: improve update_balloon_size_func
>   virtio_balloon: remove the unnecessary 0-initialization
> 
>  drivers/virtio/virtio_balloon.c | 104 ++++++++++++++++++++++++++--------------
>  1 file changed, 69 insertions(+), 35 deletions(-)
> 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

