Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v3] virtio-net: Improve introductory description
Date: Thu, 9 Feb 2023 12:47:51 +0000
Message-ID: <PH0PR12MB5481C50E5EE1B2E7D306BA49DCD99@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230209014108.209950-1-parav@nvidia.com>
 <20230209071430-mutt-send-email-mst@kernel.org> <877cwr6myi.fsf@redhat.com>
 <20230209073110-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230209073110-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, February 9, 2023 7:31 AM
>=20
> On Thu, Feb 09, 2023 at 01:29:57PM +0100, Cornelia Huck wrote:
> > On Thu, Feb 09 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >
> > > On Thu, Feb 09, 2023 at 03:41:08AM +0200, Parav Pandit wrote:
> > >> @@ -389,8 +392,8 @@ \subsection{Device Operation}\label{sec:Device
> > >> Types / Network Device / Device O  };  \end{lstlisting}
> > >>
> > >> -The controlq is used to control device features such as
> > >> -filtering.
> > >> +The controlq is used to control many device features described
> > >> +further in
> > >
> > > many seems subjective.
> > >
> > > s/many/some of the/ ?
> >
> > s/many/various/ instead? That section should cover all of the device
> > features controled via the control vq.
>=20
> I like that.
>=20
Looks good. Will send v4.

> > >
> > >> +section \ref{sec:Device Types / Network Device / Device Operation /
> Control Virtqueue}.

