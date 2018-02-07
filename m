Return-Path: virtio-dev-return-3172-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 6E1045819113
	for <virtio-dev@lists.oasis-open.org>; Wed,  7 Feb 2018 07:23:48 -0800 (PST)
References: <20180125040328.22867-1-tiwei.bie@intel.com>
 <20180125040328.22867-7-tiwei.bie@intel.com>
 <2e83b7fa-8cec-4c13-003f-f753a13fbfe2@redhat.com>
 <20180206044005.louuil5etk6vsy4z@debian-xvivbkq.sh.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d7ff477b-11eb-720b-c389-1b75348f3a89@redhat.com>
Date: Wed, 7 Feb 2018 16:23:29 +0100
MIME-Version: 1.0
In-Reply-To: <20180206044005.louuil5etk6vsy4z@debian-xvivbkq.sh.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] [PATCH v1 6/6] vhost-user: add VFIO based
 accelerators support
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, alex.williamson@redhat.com, jasowang@redhat.com, stefanha@redhat.com, cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 06/02/2018 05:40, Tiwei Bie wrote:
> In our case, the accelerator for
> each VM is a PCI VF device and the PCI card has vswitch
> logic (the VFs are the ports of switch to connect VMs).

Ok, this makes a lot more sense now. :)

Paolo

> So the card is a vswitch accelerator which will be shared
> between multiple VMs.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

