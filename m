Return-Path: <virtio-dev-return-8919-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C9597986452
	for <virtio-dev@lists.oasis-open.org>; Thu,  4 Nov 2021 17:07:49 +0000 (UTC)
Date: Thu, 4 Nov 2021 22:37:40 +0530
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
Message-ID: <20211104170740.GA14929@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
MIME-Version: 1.0
Subject: [virtio-dev] Timing out virtio-pci config space access
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
To: virtio-dev@lists.oasis-open.org
Cc: mst@redhat.com, jasowang@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

We are working on a virtio-pci implementation on a Type-1 hypervisor where
backend drivers are hosted in another VM and are considered untrusted. PCI is
the virtio transport used in this case.

One issue that crops up is a read/write of config space can potentially block
forever, as the backend is untrusted and could be causing a denial-of-service of
sorts. This causes the vcpu to stall forever. I was wondering if we can timeout
in such case and have the hypervisor break the stall by letting read return
"error" (-1) along with setting DEVICE_NEEDS_RESET in status register. Will that
allow Linux guest driver to gracefully fail its probe? I don't see where Linux
handles DEVICE_NEEDS_RESET currently and also am not sure if returning -1 will
lead to graceful failure of the driver alone (we don't want VM to come down or
panic because of a mis-behaving device). 

I saw some discussions in this regard for vDPA where similar solution seem to
have been discussed.

https://lkml.org/lkml/2021/7/6/219

Would that work for PCI transport also?

Thanks
vatsa


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

