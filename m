Return-Path: virtio-dev-return-2767-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 63A4158190D3
	for <virtio-dev@lists.oasis-open.org>; Wed,  6 Dec 2017 02:15:29 -0800 (PST)
Message-ID: <5A27C3B7.7010109@intel.com>
Date: Wed, 06 Dec 2017 18:17:27 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com> <1512444796-30615-3-git-send-email-wei.w.wang@intel.com> <20171205145950.GF31150@stefanha-x1.localdomain>
In-Reply-To: <20171205145950.GF31150@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] [PATCH v3 2/7] vhost-pci-net: add vhost-pci-net
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, jan.kiszka@siemens.com, avi.cohen@huawei.com, zhiyong.yang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 12/05/2017 10:59 PM, Stefan Hajnoczi wrote:
> On Tue, Dec 05, 2017 at 11:33:11AM +0800, Wei Wang wrote:
>> Add the vhost-pci-net device emulation. The device uses bar 2 to expose
>> the remote VM's memory to the guest. The first 4KB of the the bar area
>> stores the metadata which describes the remote memory and vring info.
> This device looks like the beginning of a new "vhost-pci" virtio device
> type.  There are layering violations:
>
> 1. This has nothing to do with virtio-net or networking, it's purely
>     vhost-pci.  Why is it called vhost-pci-net instead of vhost-pci?

Here are a few things that are specific to vhost-pci-net here:

1) The device category here is set to NETWORK.
2) vhost-pci-net related features (e.g. future MQ feature) will be added 
to the property here.

Right now, we only have vhost-pci-net. How about all focusing on the 
vhost-pci-net, and ignore vhost-pci for now? When future other types of 
devices are addded, we can abstract out a common vhost-pci layer?

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

