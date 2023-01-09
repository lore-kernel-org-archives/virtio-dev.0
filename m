Return-Path: <mst@redhat.com>
Date: Mon, 9 Jan 2023 08:35:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-comment] [PATCH v1 13/20] virtio-rpmb: Maintain rpmb
 device spec in separate directory
Message-ID: <20230109083413-mutt-send-email-mst@kernel.org>
References: <20230101180824.325172-1-parav@nvidia.com>
 <20230101180824.325172-14-parav@nvidia.com>
 <874jszeuw4.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <874jszeuw4.fsf@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Cornelia Huck <cohuck@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jan 09, 2023 at 01:48:27PM +0100, Cornelia Huck wrote:
> On Sun, Jan 01 2023, Parav Pandit <parav@nvidia.com> wrote:
> 
> > Place device specification, its driver and device
> > conformance into its own directory to have self contained device
> > specification.
> >
> > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/153
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > ---
> > changelog:
> > v0->v1:
> > - new patch
> > ---
> >  conformance.tex                               | 23 ++-----------------
> >  content.tex                                   |  1 -
> >  .../virtio-rpmb/device-conformance.tex        | 13 +++++++++++
> >  .../virtio-rpmb/device.tex                    |  0
> >  .../virtio-rpmb/driver-conformance.tex        |  7 ++++++
> >  5 files changed, 22 insertions(+), 22 deletions(-)
> >  create mode 100644 device-types/virtio-rpmb/device-conformance.tex
> >  rename virtio-rpmb.tex => device-types/virtio-rpmb/device.tex (100%)
> >  create mode 100644 device-types/virtio-rpmb/driver-conformance.tex
> >
> 
> (...)
> 
> > diff --git a/content.tex b/content.tex
> > index a486e36..13a2a94 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -3014,7 +3014,6 @@ \chapter{Device Types}\label{sec:Device Types}
> >  \import{device-types/virtio-crypto/}{device}
> >  \import{device-types/virtio-vsock/}{device}
> >  \import{device-types/virtio-fs/}{device}
> > -\input{virtio-rpmb.tex}
> 
> This is missing
> 
> \import{device-types/virtio-rpmb/}{device}
> 
> (I noticed broken references when building with the patches applied)


Oh, good catch. Parav, I'd really like patch submitters to run the
build and review the resulting files.
I guess we should withdraw the ballot for now and wait until a fixed
version. Agree?

> >  \input{virtio-iommu.tex}
> >  \input{virtio-sound.tex}
> >  \input{virtio-mem.tex}

