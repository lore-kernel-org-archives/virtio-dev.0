Return-Path: virtio-dev-return-3953-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 6C90A5818097
	for <virtio-dev@lists.oasis-open.org>; Wed, 25 Apr 2018 06:23:48 -0700 (PDT)
References: <20180425082312.32244-1-tiwei.bie@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <09fbd602-96f4-9444-977a-979b234cbcdb@redhat.com>
Date: Wed, 25 Apr 2018 15:23:39 +0200
MIME-Version: 1.0
In-Reply-To: <20180425082312.32244-1-tiwei.bie@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [RFC] VIRTIO_F_IO_BARRIER: use I/O barriers in driver
To: Tiwei Bie <tiwei.bie@intel.com>, mst@redhat.com, stefanha@redhat.com, jasowang@redhat.com, virtio-dev@lists.oasis-open.org
Cc: cunming.liang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 25/04/2018 10:23, Tiwei Bie wrote:
> There will be hardware virtio devices in the future, which
> require drivers to use the barriers suitable for I/O device,
> compared with software virtio devices which just require
> drivers to use the barriers suitable for CPU core.
> 
> To fix the ordering issue for hardware virtio devices, add
> a new feature: VIRTIO_F_IO_BARRIER. When negotiated, driver
> will use the barriers suitable for I/O device.

Unfortunately this doesn't work as mentioned earlier.  Virtio live
migration assumes that features are safe if you have them on the
destination but not on the source; this feature however works the
opposite way.

Paolo


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

