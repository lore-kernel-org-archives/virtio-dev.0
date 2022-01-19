Return-Path: <jasowang@redhat.com>
MIME-Version: 1.0
References: <20220113145103.26894-1-mgurtovoy@nvidia.com> <20220113145103.26894-5-mgurtovoy@nvidia.com>
 <20220113125409-mutt-send-email-mst@kernel.org> <38c7b7a3-e0d8-d242-8723-11cabbbcb47d@nvidia.com>
 <PH0PR12MB54812553884E5791B8A69DE8DC579@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220117171459-mutt-send-email-mst@kernel.org> <631d8512-6a28-a714-4a71-dded3ef9ce3c@redhat.com>
 <20220118002309-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220118002309-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 19 Jan 2022 12:16:47 +0800
Message-ID: <CACGkMEucTZSOq=yZ6-DjksW_Z_pg9vcA+pM6+iWWiGdpmM8u0Q@mail.gmail.com>
Subject: Re: [PATCH 4/5] virtio-net: add support for VIRTIO_F_ADMIN_VQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jan 18, 2022 at 1:25 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Jan 18, 2022 at 10:18:29AM +0800, Jason Wang wrote:
> >
> > =E5=9C=A8 2022/1/18 =E4=B8=8A=E5=8D=886:22, Michael S. Tsirkin =E5=86=
=99=E9=81=93:
> > > On Mon, Jan 17, 2022 at 02:07:51PM +0000, Parav Pandit wrote:
> > > > > From: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > > Sent: Sunday, January 16, 2022 3:18 PM
> > > > >
> > > > >
> > > > > On 1/13/2022 7:56 PM, Michael S. Tsirkin wrote:
> > > > > > On Thu, Jan 13, 2022 at 04:51:02PM +0200, Max Gurtovoy wrote:
> > > > > > > Set the relevant index in case of VIRTIO_F_ADMIN_VQ negotiati=
on.
> > > > > > >
> > > > > > > Reviewed-by: Parav Pandit <parav@nvidia.com>
> > > > > > > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > > > So admin VQ # is only known when all features are negotiated.
> > > > > No. The driver should see if VIRTIO_NET_F_CTRL_VQ/VIRTIO_F_ADMIN_=
VQ
> > > > > are set by the device.
> > > > >
> > > > > Negotiation is not a must.
> > > > >
> > > > > Lets say CTRL_VQ is supported by the device and driver A would li=
ke to use it
> > > > > and driver B wouldn't like to use it - in both cases the admiq VQ=
 # would be 2N
> > > > > + 1.
> > > > >
> > > > > > Which is quite annoying if hypervisor wants to partition things=
 e.g.
> > > > > > handling admin q in process and handling vqs by an external pro=
cess or
> > > > > > by hardware.
> > > > > >
> > > > > > I think we can allow devices to set the VQ# for the admin queue
> > > > > > instead. Would that work?
> > > > Number of MSI-X configuration and number of VQs config are two diff=
erent,
> > >
> > > I was talking about the number of the VQ used for admin commands. Not
> > > about the number of VQs.
> > >
> > > > though it has strong correlation.
> > > > Configuring number of queues seems a very device specific configura=
tion (even though num_queues is generic field in struct virtio_pci_common_c=
fg).
> > > >
> > > > So num VQ configuration is a different command likely combined with=
 other device specific config such as mac or rss or others.
> > > I was not talking about that at all, but since you mention that,
> > > to me it looks like something that many device types can support.
> > > It's not necessarily rss related, MQ config would benefit too,
> > > so I am not sure why not have a command for controlling number
> > > of queues. Looks like it could quite be generic.
> > >
> > > Since current guests only support two modes: a vector
> > > per VQ and a shared vector for all VQs, it follows that
> > > it is important when configuring vectors per VF to also configure
> > > VQs per VF. This makes me wonder whether ability to configure
> > > vectors per VF in isolation without ability to configure or
> > > at least query VQs per VF even has value.
> >
> >
> > So I had some thought in the past, it looks to me we need a generic
> > provision interface that contains all the necessary attributes:
> >
> > 1) #queues
> > 2) device_features
> > 3) #msi_vectors
> > 4) device specific configurations
> >
> > It could be either an admin virtqueue interface[1] or a dedicated
> > capability[2], (the latter seems easier).
> >
> > Thanks
> >
> > [1]
> > https://lists.oasis-open.org/archives/virtio-comment/202108/msg00025.ht=
ml
> > [2]
> > https://lists.oasis-open.org/archives/virtio-comment/202108/msg00136.ht=
ml
> >
>
> We also need
> - something like injecting cvq commands to control rx mode from the admin=
 device
> - page fault / dirty page handling
>
> these two seem to call for a vq.

Right, but vq is not necessarily for PF if we had PASID. And with
PASID we don't even need a dedicated new cvq.

Thanks

>
>
> > >
> > >
>

