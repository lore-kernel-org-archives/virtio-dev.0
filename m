Return-Path: <virtio-comment-return-2660-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
MIME-Version: 1.0
References: <20220124093918.34371-1-mgurtovoy@nvidia.com> <20220124093918.34371-5-mgurtovoy@nvidia.com>
 <e0726651-4534-26e9-3368-abee12ed13c0@redhat.com> <PH0PR12MB5481398EBFC427C178D5F51BDC219@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481398EBFC427C178D5F51BDC219@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 28 Jan 2022 11:23:30 +0800
Message-ID: <CACGkMEte-oLuF81QwTjFJ67VLUksdUsG90rz8RCtnZBxWqaQ2Q@mail.gmail.com>
Subject: [virtio-comment] Re: [PATCH v2 4/4] Add support for MSI-X vectors configuration for
 PCI VFs
Content-Type: text/plain; charset="UTF-8"
To: Parav Pandit <parav@nvidia.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "mst@redhat.com" <mst@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jan 27, 2022 at 1:22 PM Parav Pandit <parav@nvidia.com> wrote:
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Thursday, January 27, 2022 9:06 AM
>
> [...]
>
> >
> > And I think it's better to explicit split the commands then we can have
> > dedicated commands for MSI instead of trying to mix all SRIOV related
> > attributes into the same command.
>
> It is not mixed. Its clubbed together so that driver-device communication can be minimal and still flexible.
>
> For example in [1] it has, command like,
> ip link add vx0 type vxlan id 100 local 1.1.1.1 remote 2.2.2.2 dev eth0 dstport 4789
>
> it would be inefficient do it as,
> $ ip link add vx0 type vxlan id 100
> $ ip link vx0 local 1.1.1.1
> $ ip link vx0 remote 2.2.2.2
> $ ip link vx0 dev eth0
> $ ip link vx0 dstport 4789
>
> [1] https://developers.redhat.com/blog/2018/10/22/introduction-to-linux-interfaces-for-virtual-networking#macvlan

vxlan part actually.

>
> Similarly, we prefer the ability and flexibility to set more fields in one command.

I understood this motivation. But what I want to say is:

struct virtio_cmd {
    u64 attr_mask;
    field_X;
    field_Y;
    field_Z;
}

What's the default value if one of the X,Y, Z is not specified? How to
get those default values?

And suppose we add a new field

struct virtio_cmd {
    u64 attr_mask;
    field_X;
    field_Y;
    field_Z;
    field_M;
}

How can the driver know it can use field_M? And if field_M is
supported in src but not dst, how can we keep the migration
compatibility?

Would it be simple to just mandate all the fields in this case?

Thanks


>
> > I think it's better to have a dedicated command to set the msix_vectors, then
> > there's no need for the attrs_mask.
> >
> Main design principle in having attr_mask is to avoid issuing multiple commands for related/adjacent attributes.
> Lesser the number of commands serviced, more efficient the overall system is.
> Hence the attribute mask gives the flexibility to set one or more.


This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

