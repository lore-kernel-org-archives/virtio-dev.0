Return-Path: <mst@redhat.com>
Date: Fri, 13 Jan 2023 06:42:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-comment] [PATCH v4 00/20] Split device spec to its
 individual files
Message-ID: <20230113064057-mutt-send-email-mst@kernel.org>
References: <20230112212254.763783-1-parav@nvidia.com>
 <87bkn2ohx3.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87bkn2ohx3.fsf@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Cornelia Huck <cohuck@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, david@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jan 13, 2023 at 11:19:52AM +0100, Cornelia Huck wrote:
> On Thu, Jan 12 2023, Parav Pandit <parav@nvidia.com> wrote:
> 
> > Relatively several of the recent device specifications are maintained
> > in their own specification file. Such separate files enables better
> > maintenance of the specification overall.
> > However, several of the initial virtio device specifications
> > are located in single file.
> >
> > Hence, split them into their individual files.
> >
> > Additionally, each device's driver and device conformance is
> > present in one giant conformance file all together.
> >
> > As Michael suggest's move this device and driver conformance
> > section adjacent to device specification in each device specific
> > directory. This further makes device specification self-contained.
> >
> > Added patch to fix spelling errors in network device
> > specification which was inherited from its previous file
> > location.
> >
> > Patches do not change any part of the specification outcome
> > except fixing the spelling errors.
> > It only changes how the specification is maintained.
> >
> > patch summary:
> > -------------
> > patch 1 to 7 creates new files for moving devices spec out of
> > content and conformance files.
> > patch 8 to 20 move existing dedicated file spec to new directory
> > and creates per device,driver conformance file for each device.
> 
> This LGTM now.
> 
> Michael: did you check whether redlining works as expected?

I have successfully generated a diff from 1.1 and did some manual
spot checking. Looks ok to me.  I really expect contributors to
do this too :)

