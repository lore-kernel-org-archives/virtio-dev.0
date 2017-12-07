Return-Path: virtio-dev-return-2783-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 16FCE58190D5
	for <virtio-dev@lists.oasis-open.org>; Thu,  7 Dec 2017 05:34:06 -0800 (PST)
Date: Thu, 7 Dec 2017 15:33:54 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171207152806-mutt-send-email-mst@kernel.org>
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
 <20171206134957.GD12584@stefanha-x1.localdomain>
 <286AC319A985734F985F78AFA26841F73937B57F@shsmsx102.ccr.corp.intel.com>
 <CAJSP0QWugAKQy6hYEJfy_XHEg-Q2swAzZMNcWBqn-r9Yi7yiEg@mail.gmail.com>
 <5A28BC2D.6000308@intel.com>
 <CAJSP0QUxRv9LNb1+McYxV0KY4Ss3NkaSjwO6fXiJd+oU2+zJSQ@mail.gmail.com>
 <B84047ECBD981D4B93EAE5A6245AA3610159323B@FRAEML521-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B84047ECBD981D4B93EAE5A6245AA3610159323B@FRAEML521-MBX.china.huawei.com>
Subject: [virtio-dev] Re: [Qemu-devel] [virtio-dev] [PATCH v3 0/7] Vhost-pci for inter-VM
 communication
To: "Avi Cohen (A)" <avi.cohen@huawei.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Wei Wang <wei.w.wang@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Yang, Zhiyong" <zhiyong.yang@intel.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Dec 07, 2017 at 07:54:48AM +0000, Avi Cohen (A) wrote:
> There is already a  virtio mechanism in which 2 VMs assigned a virtio device , are communicating via a veth pair  in the host .
> KVM just passes  a pointer of the page of the writer VM to the reader VM - resulting  in  excellent performance (no vSwitch in the middle)

What exactly do you refer to?

> **Question**:  What is the advantage of vhost-pci compared to this ?
> Best Regards
> Avi

I suspect what's missing in this thread is the original motivation rfc:
http://virtualization.linux-foundation.narkive.com/A7FkzAgp/rfc-vhost-user-enhancements-for-vm2vm-communication

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

