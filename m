Return-Path: <jasowang@redhat.com>
MIME-Version: 1.0
References: <20220124093918.34371-1-mgurtovoy@nvidia.com> <20220124093918.34371-2-mgurtovoy@nvidia.com>
 <20220126093659-mutt-send-email-mst@kernel.org> <PH0PR12MB5481862FCAA0A399C4599844DC219@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481862FCAA0A399C4599844DC219@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 27 Jan 2022 11:56:10 +0800
Message-ID: <CACGkMEvKrUDEzOXFHZNeObuDZSKF+8xwJE576PNtRcdK_4+Mxw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] Add virtio Admin Virtqueue
Content-Type: text/plain; charset="UTF-8"
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jan 27, 2022 at 11:55 AM Parav Pandit <parav@nvidia.com> wrote:
>
>
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, January 26, 2022 8:11 PM
> >
> > On Mon, Jan 24, 2022 at 11:39:15AM +0200, Max Gurtovoy wrote:
> > > +Regardless of device offering VIRTIO_F_IN_ORDER, admin queue command
> > > +buffers are used by the device in out of order manner.
> >
> > Instead of special-casing AQ I'd like to see a generic capability addressing this
> > need. For example, TX for virtio net might benefit from this too. And I'd like to
> > mention, again, VIRTIO_F_PARTIAL_ORDER proposal as one, arguably cleaner
> > and more generic way to address this.
> > And if that's not adequate I'd like to address that as part of the
> > PARTIAL_ORDER proposal, this kind of per-queue in order was definitely on
> > the radar as it was formulated.
> As we dropped other less important items from this proposal because it was too big.
> I am going to keep the PARTIAL_ORDER also out of this one. It falls in same bucket.
>
> So AQ follows same ordering rules as other queues.
> Are you ok with this in v3?

I'm fine with this.

Thanks

>

