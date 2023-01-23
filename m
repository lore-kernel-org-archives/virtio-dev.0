Return-Path: <virtio-comment-return-3902-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Mon, 23 Jan 2023 15:49:47 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Message-ID: <20230123154947.35f1f52a.pasic@linux.ibm.com>
In-Reply-To: <PH0PR12MB54814E64310DE64E19ABD7DADCC89@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230110230945.528293-1-parav@nvidia.com>
	<20230123124006.0cae9a96.pasic@linux.ibm.com>
	<PH0PR12MB54814E64310DE64E19ABD7DADCC89@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [virtio-dev] [PATCH v9] virtio-network: Clarify VLAN filter
 table configuration
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: Parav Pandit <parav@nvidia.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 23 Jan 2023 12:41:16 +0000
Parav Pandit <parav@nvidia.com> wrote:

> > From: Halil Pasic <pasic@linux.ibm.com>
> > Sent: Monday, January 23, 2023 6:40 AM
> >=20
> > On Wed, 11 Jan 2023 01:09:45 +0200
> > Parav Pandit <parav@nvidia.com> wrote:
> >  =20
> > > The filtering behavior of the VLAN filter commands is not very clear
> > > as discussed in thread [1]. =20
> >  =20
> > >
> > > Hence, add the command description and device requirements for it.
> > >
> > > [1]
> > > https://lists.oasis-open.org/archives/virtio-dev/202301/msg00136.html=
 =20
> >=20
> > Sorry I could not find the discussion. Can you point me to the email wh=
ere the
> > discussion starts?
> > =20
> Latest patch is for this change is : https://lists.oasis-open.org/archive=
s/virtio-dev/202301/msg00231.html
>=20

Sorry, my bad. Should I repost my feedback on v10 or should we continue
here? AFAICT v10 is a rebase on the directory structure stuff, so the
text should be the same.

> There was past discussion at https://www.mail-archive.com/qemu-devel@nong=
nu.org/msg913433.html

That is a completely different discussion than provided under [1] in the
commit message. Right? So the link provided is just wrong?

Regards,
Halil

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
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

