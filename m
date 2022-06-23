Return-Path: <jasowang@redhat.com>
MIME-Version: 1.0
References: <20220426225824.5918-1-mgurtovoy@nvidia.com> <20220426225824.5918-3-mgurtovoy@nvidia.com>
 <20220515111056-mutt-send-email-mst@kernel.org> <PH0PR12MB5481DD681A0172899E09BC6CDCCF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220517074130-mutt-send-email-mst@kernel.org> <PH0PR12MB5481D968013490C396CD2944DCDC9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220620055014-mutt-send-email-mst@kernel.org> <PH0PR12MB5481BB1BE6102DC78E555DEDDCB09@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsCrjLWri6TZ3yjf4qTWeXn-Bma-RY1HZFLbVS4ApyuVQ@mail.gmail.com> <PH0PR12MB5481E6E87639E07C885666F6DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481E6E87639E07C885666F6DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 23 Jun 2022 10:41:55 +0800
Message-ID: <CACGkMEuHO5oBgFAkPnOZ8b3z+H5E2xXgM6FqbZdUuZB-2wX0UQ@mail.gmail.com>
Subject: Re: [virtio-comment] RE: [PATCH v5 2/7] Introduce admin command set
Content-Type: text/plain; charset="UTF-8"
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, "aadam@redhat.com" <aadam@redhat.com>, "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jun 23, 2022 at 10:07 AM Parav Pandit <parav@nvidia.com> wrote:
>
>
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Wednesday, June 22, 2022 9:27 PM
>
> > > 1. proposed new command doesn't demand exposing registers in the PCI
> > > memory mapped area 2. Today AQ is perceived in to be PF, but it doesn't
> > have to be. For next 10 years spec may evolve to have AQ for some other
> > purpose on VFs/SFs.
> > > Such devices scale at much higher magnitude than PFs.
> > > And exposing memory mapped registers for rare functionality is the last
> > thing to do in my mind.
> > > 3. Placements of such features bits in an AQ gives device lot more flexibility
> > on _how_ to implement them. Some in sw, fw, hw, memory die etc.
> > > Placement of them in PCI register space reduces these options.
> > >
> > > So exposing them something in PCI register space has to have strong
> > technical reason than just simplicity of access.
> >
> > I think I know the advantages of admin virtqueue. But this part looks
> > suspicious and actually the reverse,
> >
> > 1) register based transport have been used for years, it's natural to add
> > features based on the existing transport and what you suggest here limit the
> > new features to be carried with those transports
> > 2) admin virtqueue is heavy weight in use cases like nesting, we need a
> > simple interface
> > 3) admin virtqueue is not the universal transport for all cases, we've already
> > had DMA/CMA based transports (e.g ccw and rproc)
> >
> Are you suggesting only feature bits through register-based transport or all commands via register-based transport?

For feature bits, if we don't have admin virtqueue as transport, I
suggest it be negotiated with existing transport: we don't need any
extension of the existing transport facility to make it work. If we
have admin virtqueue as a transport, we must allow the features of the
managed device to be negotiated through the admin virtqueue.

For other commands, we probably need to analyze it case by case. But
if the command is for management only, it should be done via admin
virtqueue. (Note that for the MSIX allocation, I do see some vendors
allocating it via registers). If the command is used for basic
facilities like the virtqueue reset, it should be allowed to be
implemented by any transport (admin virtqueue as well as others like
PCI registers).

Thanks

