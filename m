Return-Path: <mst@redhat.com>
Date: Wed, 3 Aug 2022 02:43:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v6 1/5] Introduce device group
Message-ID: <20220803024231-mutt-send-email-mst@kernel.org>
References: <20220731154354.15698-1-mgurtovoy@nvidia.com>
 <20220731154354.15698-2-mgurtovoy@nvidia.com>
 <20220802092302-mutt-send-email-mst@kernel.org>
 <CACGkMEtgghEpPk=eE4z=5QiGTW42768i4729KR0-+ThHaQE3bA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtgghEpPk=eE4z=5QiGTW42768i4729KR0-+ThHaQE3bA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Jason Wang <jasowang@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, virtio-comment@lists.oasis-open.org, Cornelia Huck <cohuck@redhat.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Oren Duer <oren@nvidia.com>, Parav Pandit <parav@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Ariel Adam <aadam@redhat.com>, virtio@lists.oasis-open.org, eperezma <eperezma@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Aug 03, 2022 at 12:44:38PM +0800, Jason Wang wrote:
> > A VF now is a member of a SRIOV and SIOV type groups and we
> > can use type to distinguish between these.
> >
> > We should probably be explicit that each of these groups has to
> > have a distinct group type then.
> >
> > And this raises the question: different types have different
> > capabilities. So let's say admin queue is used to both
> > control features for SRIOV VFs and to create SIOV SFs.
> 
> I don't get how the admin queue can be used to control VF features
> considering VF has its capabilities. (SR-IOV lacks the ability to
> provision a single VF).

I mean, VF exists, but it does not have to consume lots of resources.
We can if we want to require that drivers only attach to VFs which have
been enabled through a special command.

-- 
MST

