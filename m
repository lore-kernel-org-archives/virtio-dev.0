Return-Path: <mst@redhat.com>
Date: Wed, 15 Feb 2023 07:59:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] content.tex Fix Driver notifications label
Message-ID: <20230215075915-mutt-send-email-mst@kernel.org>
References: <20230203183532.90685-1-parav@nvidia.com>
 <87k00p9331.fsf@redhat.com>
 <20230215061424-mutt-send-email-mst@kernel.org>
 <871qmrdstu.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <871qmrdstu.fsf@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Cornelia Huck <cohuck@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Feb 15, 2023 at 01:19:25PM +0100, Cornelia Huck wrote:
> On Wed, Feb 15 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Fri, Feb 10, 2023 at 12:23:14PM +0100, Cornelia Huck wrote:
> >> On Fri, Feb 03 2023, Parav Pandit <parav@nvidia.com> wrote:
> >> 
> >> > Driver notifications section is under "Basic Facilities of a Virtio
> >> > Device". However, the label is placed under "Virtqueues" section.
> >> >
> >> > Fix the label references.
> >> >
> >> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> >> > ---
> >> >  content.tex | 14 +++++++-------
> >> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >> 
> >> Not sure if it was originally intended to sit unter the virtqueues
> >> section (it was lifted up one level as it disappeared under the packet
> >> ring section), might have been.
> >> 
> >> It probably makes sense to not try and move it back into the virtqueues
> >> section, and instead do your change. Other opinions?
> >
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > Minor fix does not need a vote.
> > Cornelia are you applying this?
> 
> Pushed.

btw did you try to generate a diff pdf? when changing labels it is
sometimes necessary to keep old ones around too as diff
needs old and new links to work.

-- 
MST

