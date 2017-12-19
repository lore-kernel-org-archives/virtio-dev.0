Return-Path: virtio-dev-return-2863-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 3DDA258190D3
	for <virtio-dev@lists.oasis-open.org>; Tue, 19 Dec 2017 06:56:33 -0800 (PST)
Date: Tue, 19 Dec 2017 16:56:15 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171219161754-mutt-send-email-mst@kernel.org>
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
 <20171219113505.GA8499@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171219113505.GA8499@stefanha-x1.localdomain>
Subject: Re: [virtio-dev] [PATCH v3 0/7] Vhost-pci for inter-VM communication
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, marcandre.lureau@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, jan.kiszka@siemens.com, avi.cohen@huawei.com, zhiyong.yang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

>  * Please handle short reads/writes and EAGAIN with the UNIX domain socket.  Do
>    not use read/write_all() functions because they hang QEMU until I/O
>    completes.

I'm not sure I agree with this one. vhost-user uses this extensively
right now. It might be a worth-while goal to drop this limitation
but I don't see why we should start with vhost-pci.

And in particular, VCPU can't make progress unless a slave is present.

>  * What happens when the vhost-user master disconnects while we're running?
> 
>  * How does the guest know when the QEMU vhost-user slave has finished
>    initializing everything?  It seems like a guest driver could access the
>    device before things are initialized.
> 
>  * How can the vhost-user slave inside the guest participate in feature
>    negotiation?  It must be able to participate, otherwise slaves cannot
>    disable features that QEMU supports but they don't want to support.
> 
>    It's not feasible to pass in host_features as a QEMU parameter because
>    that would require libvirt, OpenStack, cloud providers, etc to add
>    support so users can manually set the bits for their slave
>    implementation.
>
>  * How can the the guest limit the number of virtqueues?

I think it is feasible to pass in host features, # of vqs etc.  Assuming
compatibility with existing guests, I don't think you can do anything
else really if you assume that vhost guest might boot after the
virtio guest.

So either you give up on compatibility, or you allow the vhost
guest to block the virtio guest.

I think compatibility is more important.

We can later think about ways to add non-blocking behaviour
as a feature.

> 
>  * Please include tests.  See tests/virtio-net-test.c and
>    tests/vhost-user-test.c for examples.

Unit tests are nice but an actual way to test without
running a full blown dpdk stack would be nicer.
Something along the lines of a port of vhost user bridge
to the guest.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

