Return-Path: virtio-dev-return-3681-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 8A49558191D2
	for <virtio-dev@lists.oasis-open.org>; Thu, 29 Mar 2018 16:03:03 -0700 (PDT)
From: Stephen Warren <swarren@wwwdotorg.org>
Message-ID: <719390c5-99cd-f3f5-2f74-a0f374a124c2@wwwdotorg.org>
Date: Thu, 29 Mar 2018 17:02:51 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] virtio over SW-defined/CPU-driven PCIe endpoint
To: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

I've been investigating how to implement a virtio device (as opposed to 
a virtio driver) on a regular computer system with a PCIe controller 
that can operate in endpoint mode, as opposed to an endpoint that's 
implemented by a hypervisor that can preempt execution of a VM, or an 
endpoint that's implemented purely in hardware by logic gates. In my 
case (and I assume likely in most CPU-driven PCIe endpoint cases), the 
endpoint controller has the following capabilities:

- Host-initiated accesses to the endpoint's BARs can read/write normal 
memory, but not hardware registers within the endpoint system.

- Accesses to memory exposed by BARs can't be synchronously handled by 
the endpoint's local CPU. The local CPU can't be notified when the host 
writes memory in order to synchronously update other memory locations. 
The local CPU can't synchronously generate the result of a host read 
transaction, but rather the data must be present in memory ahead of time.

- Accesses to a small region of address space can be used to generate 
interrupts to the endpoint's local CPU. This region can be exposed 
through a PCI BAR (or perhaps as part of a BAR; not sure on details 
yet). This region of memory has a fixed format and is separate from true 
RAM, and so can't be used to hold PCI-virtio's discovery/capability data.

- The endpoint can emit PCI interrupts (e.g. MSI) to the attached host.

The model described in the virtio spec's "Virtio PCI Bus" section 
doesn't seem to work in this case, since it assumes:

- Writes to some fields in the PCI configuration space (e.g. 
{queue,device_feature,driver_feature}_select) synchronously update other 
fields (e.g. queue_size), which can immediately be accessed by the host. 
This isn't possible when the memory content is created by a CPU that 
isn't a synchronous part of PCI accesses.

- Writing to some fields in the PCI configuration space (e.g. 
device_status) are supposed to trigger a response by the device, without 
the need to explicitly notify the device of the memory write by some 
other means. This isn't possible when the endpoint's local CPU has no 
mechanism to be notified of such writes.

- The device_status field is asynchronously read-write by both the 
device and driver, yet the spec requires that the driver must always 
read-modify-write this field, and additionally that the driver must 
never clear any device status bit. These requirements seem impossible to 
satisfy in any case at all, let alone the current case.

I can see some possible solutions here:

1) Just implement virtqueues but not all of the standardized PCI 
discovery protocol. virtqueues don't have the problems described above 
and should work fine between systems where there are asynchronous CPUs 
on both ends. virtqueus solely rely on normal memory access without 
side-effects and explicit notification. This would require implementing 
some custom/device-specific discovery protocol. I believe that 
remoteproc/rpmsg take this approach.

2) Define a new standardized virtio PCI discovery protocol that is 
better suited to the device being an asynchronous CPU. For example, 
eliminate the need for the device to somehow notice memory accesses and 
rely on explicitl notification instead. Separate device-written and 
driver-written data into different cache-lines or pages.

3) Use something other than virtio/virtqueues instead.

As an aside, I noticed that the memory allocation for virtqueues is very 
lopsided; the driver always allocates the storage. This means that the 
device must perform PCI reads to transfer data from the driver to the 
device. PCI reads are typically slower than PCI writes since reads 
require a round-trip transfer, whereas writes can be posted. I wonder if 
any thought has been put into having the device optionally allocate 
virtuqueue buffers so that the protocol can rely primarily on PCI 
writes? Perhaps there's some alternative protocol that's more optimized 
for true PCI-based communication than paravirtualized PCI-based 
communication?

Thanks for any thoughts on the best approach, or pointers to 
pre-existing work in this area.

[I originally sent this email to a Linux virtio/virtualization mailing 
list, to which Michael S. Tsirkin responded with the below, which I'm in 
order to mention Jan's work.]

I think Jan Kiszka wanted to add ability to put some data in the PCI
BAR. This was never formally proposed.

Your first step IMHO should be to send these thoughts to one of the
virtio TC mailing lists, that's where discussion about virtio interface
extensions takes place. virtualization@lists.linux-foundation.org is
mostly for Linux virtio drivers.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

