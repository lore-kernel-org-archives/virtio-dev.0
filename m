Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH] content.tex Fix Driver notifications label
Date: Thu, 16 Feb 2023 05:36:35 +0000
Message-ID: <PH0PR12MB5481C3CE3F9A361A828FF69FDCA09@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230203183532.90685-1-parav@nvidia.com>
 <87k00p9331.fsf@redhat.com> <20230215061424-mutt-send-email-mst@kernel.org>
 <871qmrdstu.fsf@redhat.com> <20230215075915-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481A47EF49115D98E310521DCA39@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230215191830-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230215191830-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, February 15, 2023 7:20 PM
>=20
> On Wed, Feb 15, 2023 at 09:53:55PM +0000, Parav Pandit wrote:
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Wednesday, February 15, 2023 8:00 AM
> > >
> > > btw did you try to generate a diff pdf? when changing labels it is
> > > sometimes necessary to keep old ones around too as diff needs old and
> new links to work.
> >
> > I generated the new pdf before pushing the patch.
> > I couldn't generate the diff pdf using ./makediffpdf.sh
> >
> > I get error on running makediff.sh virtio.tex
> >
> > Warning: command \@chapapp containing @ found in
> > Warning: virtio.tex.
> > Warning: consider using --makeatletter if the result is not compilable.
> > Warning: command \@chapapp containing @ found in
> > Warning: ./main.tex.
> > Warning: consider using --makeatletter if the result is not compilable.
> > Submodule path 'latexdiff' not initialized Maybe you want to use
> > 'update --init'?
> > make: Entering directory '/images/parav/upstream/virtio-spec/latexdiff'
> > make: *** No rule to make target 'mkdirs'.  Stop.
> > make: Leaving directory '/images/parav/upstream/virtio-spec/latexdiff'
> > ./makediff.sh: line 51: ./latexdiff-fast: No such file or directory
>=20
>=20
> Hmm. does this help:
>
Works great. Thank you.
Was able to find out fixing the change log.
I posted the fix up patch at [1].

Please review.
[1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00331.html

