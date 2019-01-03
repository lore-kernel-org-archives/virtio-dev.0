Return-Path: virtio-dev-return-5230-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BE60F985AFA
	for <virtio-dev@lists.oasis-open.org>; Thu,  3 Jan 2019 09:26:19 +0000 (UTC)
Date: Thu, 3 Jan 2019 10:26:12 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190103102612.0226e6dc.cohuck@redhat.com>
In-Reply-To: <1546493462-32244-1-git-send-email-wei.w.wang@intel.com>
References: <1546493462-32244-1-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v1 0/2] virtio-balloon: tweak config_changed
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, mst@redhat.com, borntraeger@de.ibm.com, pbonzini@redhat.com, dgilbert@redhat.com, pasic@linux.ibm.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu,  3 Jan 2019 13:31:00 +0800
Wei Wang <wei.w.wang@intel.com> wrote:

> Since virtio-ccw doesn't work with accessing to the config registers
> inside an interrupt context, this patch series avoids that issue by
> moving the config register accesses to the related workqueue contexts.
> 
> Wei Wang (2):
>   virtio-balloon: tweak config_changed implementation
>   virtio-balloon: improve update_balloon_size_func
> 
>  drivers/virtio/virtio_balloon.c | 59 +++++++++++++++++++++--------------------
>  1 file changed, 30 insertions(+), 29 deletions(-)
> 

A quick test (various 'balloon <num>' in the QEMU monitor) with a
virtio-balloon-ccw device seems to work fine here.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

