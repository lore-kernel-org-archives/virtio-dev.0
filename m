Return-Path: virtio-dev-return-2852-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 2D5AE5818F7B
	for <virtio-dev@lists.oasis-open.org>; Mon, 18 Dec 2017 23:58:06 -0800 (PST)
Message-ID: <5A38C70D.30207@intel.com>
Date: Tue, 19 Dec 2017 16:00:13 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <20171215170519.31392-1-stefanha@redhat.com>
In-Reply-To: <20171215170519.31392-1-stefanha@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [RFC virtio-dev] vhost-user-slave: add vhost-user slave device
 type
To: Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 12/16/2017 01:05 AM, Stefan Hajnoczi wrote:
> The vhost-user slave device facilitates vhost-user device emulation
> through vhost-user protocol exchanges and access to shared memory.
> Software-defined networking, storage, and other I/O appliances can
> provide services through this device.
>
> This device is based on Wei Wang's vhost-pci work.  The vhost-user slave
> device differs from vhost-pci because it is a single virtio device type
> that exposes the vhost-user protocol instead of a family of new virtio
> device types, one for each vhost-user device type.
>
> This device supports vhost-user slave and vhost-user master
> reconnection.  It also contains a UUID so that vhost-user slave programs
> can identify a specific device among many without using bus addresses.
>
> It is somewhat unconventional for a virtio device because it makes use
> of additional resources called doorbells, notifications, and shared
> memory.  A mapping of these resources to the virtio PCI transport is
> provided.  Other transports, such as CCW may not be able to support
> this device.

Hi Stefan,

Sorry for being late. I need to shift my focus to some other things for 
a week or two.

I still couldn't see how those problems can be solved with this slave 
device proposal (which vhost-pci doesn't have):

- The complexity of the "relaying" mechanism for two directions 
(GuestSlave<->QemuSlave<->Master). I couldn't think of a simple way to 
do this. If you know a *simple* way, could you please describe the 
detailed steps or show a picture of the details? (I think most of us 
couldn't see the true advantage over the vhost-pci's method)

- Reusability. We seem to have no chance to reuse one slave 
implementation for GuestSlave and QemuSlave, which also wasn't your 
intention as you mentioned. If this couldn't be solved, shall we give up 
this option?

Best,
Wei


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

