Return-Path: <mst@redhat.com>
Date: Mon, 17 Jan 2022 16:41:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v1 0/5] VIRTIO: Provision maximum MSI-X vectors for a VF
Message-ID: <20220117163205-mutt-send-email-mst@kernel.org>
References: <20220113145103.26894-1-mgurtovoy@nvidia.com>
 <20220113132436-mutt-send-email-mst@kernel.org>
 <BN9PR12MB5196B58CA5D389F384F05936CE579@BN9PR12MB5196.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <BN9PR12MB5196B58CA5D389F384F05936CE579@BN9PR12MB5196.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Shahaf Shuler <shahafs@nvidia.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Parav Pandit <parav@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jan 17, 2022 at 10:00:21AM +0000, Shahaf Shuler wrote:
> Thursday, January 13, 2022 8:32 PM, Michael S. Tsirkin:
> > Subject: Re: [PATCH v1 0/5] VIRTIO: Provision maximum MSI-X vectors for a
> > VF
> > 
> > On Thu, Jan 13, 2022 at 04:50:58PM +0200, Max Gurtovoy wrote:
> > > Hi,
> > >
> > > In a PCI SR-IOV configuration, MSI-X vectors of the device is precious
> > > device resource. Hence making efficient use of it based on the use
> > > case that aligns to the VM configuration is desired for best system
> > > performance.
> > >
> > > For example, today's static assignment of the amount of MSI-X vectors
> > > doesn't allow sophisticated utilization of resources.
> > >
> > > A typical cloud provider SR-IOV use case is to create many VFs for use
> > > by guest VMs. Each VM might have a different purpose and different
> > > amount of resources accordingly (e.g. number of CPUs). A common driver
> > > usage of device's MSI-X vectors is proportional to the number of CPUs
> > > in the VM. Since the system administrator might know the amount of
> > > CPUs in the requested VM, he can also configure the VF's MSI-X vectors
> > > amount proportional to the number of CPUs in the VM. In this way, the
> > > utilization of the physical hardware will be improved.
> > >
> > > Today we have some operating systems that support provisioning MSI-X
> > > vectors for PCI VFs.
> > >
> > > Update the specification to have a method to change the number of
> > > MSI-X vectors supported by a VF using the PF admin virtqueue
> > > interface. For that, create a generic infrastructure for managing PCI
> > > resources of the managed VF by its parent PF.
> > 
> > Can you describe in the cover letter or the commit log of the admin VQ patch
> > the motivation for using a VQ and not memory mapped space for this
> > capability?
> > In fact I feel at least some commands would be better replaced with a
> > memory mapped structure.
> 
> I am wondering what is the motivation to go for memory mapped structures for such control operations. 
> 
> I can fully understand why data plane related fields should be placed on MMIO structures.

Actually, data plane is usually in a VQ for us, since MMIO accesses
trigger VM exits.

> However for control, memory mapped commands are:
> 1. More constraining for the device implementor and thus not scalable. MMIO direct access implies on-die resources to be allocated. You can see as example the IMS section on Scalable IOV spec[1] that follows this exact design

Oh it's a PCIe thing, right? Read can not depend on another read?
So this is one of the reasons we don't put big structures in MMIO.
But a couple of bytes is really no big deal IMHO.

> 2. Hard to maintain - each new command may add new MMIO fields, making the device BAR complex.

Well actually we have very nice APIs to handle dependency
between memory and feature bits. It's much harder to abstract
away VQ commands, we don't have anything uniform for that.

> 3. Implies a non-uniform design - some commands are memory mapped,
> some commands are VQ based. How do we provide the guiding rules to
> decide? Isn't it simpler to have a single i/f for all the control? 

newdevice.tex has some guiding principles, see "What Device
Configuration Space Layout?".

But yes, if the answer is "commands A,B,C do not fit in
config space, we placed commands D,E in a VQ for consitency"
then that is an ok answer, but it's something to be mentioned
in the commit log.



> 
> [1]
> https://www.intel.com/content/www/us/en/developer/articles/technical/introducing-intel-scalable-io-virtualization.html

config space is generally more robust, requires less code
on both host and guest side.


