Return-Path: <shahafs@nvidia.com>
From: Shahaf Shuler <shahafs@nvidia.com>
Subject: RE: [PATCH v1 0/5] VIRTIO: Provision maximum MSI-X vectors for a VF
Date: Mon, 17 Jan 2022 10:00:21 +0000
Message-ID: <BN9PR12MB5196B58CA5D389F384F05936CE579@BN9PR12MB5196.namprd12.prod.outlook.com>
References: <20220113145103.26894-1-mgurtovoy@nvidia.com>
 <20220113132436-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220113132436-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Parav Pandit <parav@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Thursday, January 13, 2022 8:32 PM, Michael S. Tsirkin:
> Subject: Re: [PATCH v1 0/5] VIRTIO: Provision maximum MSI-X vectors for a
> VF
>=20
> On Thu, Jan 13, 2022 at 04:50:58PM +0200, Max Gurtovoy wrote:
> > Hi,
> >
> > In a PCI SR-IOV configuration, MSI-X vectors of the device is precious
> > device resource. Hence making efficient use of it based on the use
> > case that aligns to the VM configuration is desired for best system
> > performance.
> >
> > For example, today's static assignment of the amount of MSI-X vectors
> > doesn't allow sophisticated utilization of resources.
> >
> > A typical cloud provider SR-IOV use case is to create many VFs for use
> > by guest VMs. Each VM might have a different purpose and different
> > amount of resources accordingly (e.g. number of CPUs). A common driver
> > usage of device's MSI-X vectors is proportional to the number of CPUs
> > in the VM. Since the system administrator might know the amount of
> > CPUs in the requested VM, he can also configure the VF's MSI-X vectors
> > amount proportional to the number of CPUs in the VM. In this way, the
> > utilization of the physical hardware will be improved.
> >
> > Today we have some operating systems that support provisioning MSI-X
> > vectors for PCI VFs.
> >
> > Update the specification to have a method to change the number of
> > MSI-X vectors supported by a VF using the PF admin virtqueue
> > interface. For that, create a generic infrastructure for managing PCI
> > resources of the managed VF by its parent PF.
>=20
> Can you describe in the cover letter or the commit log of the admin VQ pa=
tch
> the motivation for using a VQ and not memory mapped space for this
> capability?
> In fact I feel at least some commands would be better replaced with a
> memory mapped structure.

I am wondering what is the motivation to go for memory mapped structures fo=
r such control operations.=20

I can fully understand why data plane related fields should be placed on MM=
IO structures. However for control, memory mapped commands are:
1. More constraining for the device implementor and thus not scalable. MMIO=
 direct access implies on-die resources to be allocated. You can see as exa=
mple the IMS section on Scalable IOV spec[1] that follows this exact design
2. Hard to maintain - each new command may add new MMIO fields, making the =
device BAR complex.
3. Implies a non-uniform design - some commands are memory mapped, some com=
mands are VQ based. How do we provide the guiding rules to decide? Isn't it=
 simpler to have a single i/f for all the control?=20

[1]
https://www.intel.com/content/www/us/en/developer/articles/technical/introd=
ucing-intel-scalable-io-virtualization.html

