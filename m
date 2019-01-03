Return-Path: virtio-dev-return-5236-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 000AE985AFA
	for <virtio-dev@lists.oasis-open.org>; Thu,  3 Jan 2019 12:16:37 +0000 (UTC)
Date: Thu, 3 Jan 2019 13:16:28 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <1546493462-32244-2-git-send-email-wei.w.wang@intel.com>
References: <1546493462-32244-1-git-send-email-wei.w.wang@intel.com>
	<1546493462-32244-2-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190103131628.3674a50d@oc2783563651>
Subject: [virtio-dev] Re: [PATCH v1 1/2] virtio-balloon: tweak config_changed
 implementation
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, mst@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com, pbonzini@redhat.com, dgilbert@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu,  3 Jan 2019 13:31:01 +0800
Wei Wang <wei.w.wang@intel.com> wrote:

> virtio-ccw has deadlock issues with reading config registers inside the
> interrupt context

I would say something like 'virtio-ccw does not support using
virtio_config_ops from an atomic context' as the limitation is not
limited to read config (aka. get()). But I'm fine with your formulation
as well.

> , so we tweak the virtballoon_changed implementation
> by moving the config read operations into the related workqueue contexts.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>


Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

[..]


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

