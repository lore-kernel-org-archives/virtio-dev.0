Return-Path: virtio-dev-return-3750-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id E9DFB58191C8
	for <virtio-dev@lists.oasis-open.org>; Mon,  9 Apr 2018 02:42:54 -0700 (PDT)
References: <B84047ECBD981D4B93EAE5A6245AA3610159B386@FRAEML521-MBX.china.huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f82eed72-f398-a463-d35a-469e517a8b36@redhat.com>
Date: Mon, 9 Apr 2018 11:42:42 +0200
MIME-Version: 1.0
In-Reply-To: <B84047ECBD981D4B93EAE5A6245AA3610159B386@FRAEML521-MBX.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] Dynamic assignment of vhost-user to a VM
To: "Avi Cohen (A)" <avi.cohen@huawei.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 09/04/2018 08:33, Avi Cohen (A) wrote:
> Hello All,
> Is it  possible to assign a vhost-user frontend to a VM *after* the VM was launched ?
> Best Regards
> Avi

If you're referring to QEMU then yes, you can dynamically create all of
character devices (to connect to the vhost-user server), network devices
(to create a vhost-user client) and NICs (that peer with the vhost-user
server).

If you're using libvirt to run QEMU, you can in fact invoke a single
"virsh attach-device" command to handle all three steps.

Thanks,

Paolo

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

