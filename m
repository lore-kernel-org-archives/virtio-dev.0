Return-Path: <mgurtovoy@nvidia.com>
Message-ID: <25c2fe2c-3000-bb17-b4d1-b2c08c8b733a@nvidia.com>
Date: Tue, 5 Apr 2022 11:44:34 +0300
Subject: Re: [PATCH v4 1/1] Introduce MGMT Admin commands
References: <20220302160237.26742-1-mgurtovoy@nvidia.com>
 <20220302160237.26742-2-mgurtovoy@nvidia.com>
 <20220404181653-mutt-send-email-mst@kernel.org>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220404181653-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, parav@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, stefanha@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 4/5/2022 1:29 AM, Michael S. Tsirkin wrote:
> On Wed, Mar 02, 2022 at 06:02:37PM +0200, Max Gurtovoy wrote:
>> +It is beyond the scope of the virtio specification to define necessary synchronization in system software to ensure that a virtio PCI VF device
>> +interrupt configuration modification is reflected in the PCI device. However, it is expected that any modern system software implementing virtio
>> +drivers and PCI subsystem will ensure that any changes occurring in the VF interrupt configuration is either updated in the PCI VF device or
>> +such configuration fails.
> I am no longer sure this assertion holds. For example, how would the PF
> driver ensure that e.g. VFIO is not bound to a VF for passthrough to
> a VM and is not configuring the MSI-X configuration of the VF?
> I don't really see a way to do that cleanly.
>
> Would you care to post a proof of concept or even a pseudo-code patch?

I don't think we a POC for now.

We have an example of MSI-X configuration in mlx5 driver: 
https://lore.kernel.org/linux-pci/20210314124256.70253-1-leon@kernel.org/

The infrastructure in Linux already exist.

>
> It appears even harder to support in an (admittedly, uncommon,
> but apparently available due to virtio subsystem not necessarily
> matching the PF boundary) case where the admin queue is
> in a VF and so the admin driver is running within guest.

I'm not sure I follow.

If the VF will support AQ it doesn't mean it will have all the optional 
functionality we're adding to the PF.

>
> I thus have been thinking of an alternate approach, where the # of MSIX
> vectors does not change, but the # of VQs does.  Since guests do not
> currently request more vectors than VQs, this will address the
> requirement in a cleaner way that guests should be able to universally
> support.  Synchronization then can be achieved by failing the command if
> any status bits (or just VIRTIO_CONFIG_S_DRIVER?  did not think too
> deeply about the difference ...) in the affected VFs are set indicating
> an attached driver. A new feature bit might be required for this and
> maybe a new field indicating the actual # of vectors.

We discussed about the VQs settings in the past. It is more challenging 
thing to do since each device type has it's own VQ types and configurations.

MSI-X is a common feature that we can apply on each virtio device.

>
>

