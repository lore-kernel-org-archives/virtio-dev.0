Return-Path: <jasowang@redhat.com>
MIME-Version: 1.0
References: <20220113145103.26894-1-mgurtovoy@nvidia.com> <20220113145103.26894-2-mgurtovoy@nvidia.com>
 <20220113124137-mutt-send-email-mst@kernel.org> <4946a0fe-70f0-43cc-6730-f8ab0f3d8687@nvidia.com>
 <20220117160951-mutt-send-email-mst@kernel.org> <115a8f4a-3f64-e8a0-86d9-26b8d15afa2c@redhat.com>
 <20220119030711-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220119030711-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 25 Jan 2022 11:35:25 +0800
Message-ID: <CACGkMEvbX0Q3NvTSqn-Cyz617fqa9JSGcms7SgVGqGCvyGBzhg@mail.gmail.com>
Subject: Re: [PATCH 1/5] Add virtio Admin Virtqueue specification
Content-Type: text/plain; charset="UTF-8"
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, virtio-comment@lists.oasis-open.org, Cornelia Huck <cohuck@redhat.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Parav Pandit <parav@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 19, 2022 at 4:11 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Jan 19, 2022 at 11:04:50AM +0800, Jason Wang wrote:
> > Exactly, another call for the using the PRS queue instead. But generally
> > speaking, admin virtqueue limit or complicate the functions that can be
> > exported to guest. That's why I suggest to decouple all the possible
> > features out of admin virtqueue, and make it available by both the admin
> > virtqueue and the transport specific method (e.g capability).
>
> I'm not exactly sure what's wrong with starting with a queue, if there's
> need to also allow passing that over another transport we can add that.

Nothing wrong, but I think we can't mandate the features to be
implemented solely via admin virtqueue. Each transport has its own use
cases. Making admin virtqueue to be visible in the nested environment
will be a challenge.

> In particular, I think it's useful to have a capability to inject
> requests as if they have been passed through a VQ.
> Such a capability would address this need, won't it?

It really depends on the requirement, for simple requests like MSI
support in virtio-mmio, introducing such a large change seems
sub-optimal than an ad-hoc MSI interface.

Thanks


>
> --
> MST
>

