Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v10 03/10] admin: introduce group administration commands
Date: Tue, 14 Feb 2023 01:18:42 +0000
Message-ID: <PH0PR12MB5481F96BC5CCD806210F13D9DCA29@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230209121221.15118-1-mst@redhat.com>
 <20230209121221.15118-4-mst@redhat.com>
 <PH0PR12MB54817D14FBFDD561D8BCDF7EDCDF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230212044245-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230212044245-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "nrupal.jani@intel.com" <nrupal.jani@intel.com>, "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>, "hang.yuan@intel.com" <hang.yuan@intel.com>, "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>, Zhu Lingshan <lingshan.zhu@intel.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Sunday, February 12, 2023 4:50 AM
>=20
> On Sat, Feb 11, 2023 at 06:50:37PM +0000, Parav Pandit wrote:
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Thursday, February 9, 2023 7:14 AM
> >
> > [..]
> >
> > > +Group administration commands can be issued through an owner device
> > > +to control member devices of a group.
> > can be issued by the owner device to control ...
>=20
> Well it's clearly the driver that issues the commands. Don't see how
> can a device issue them. If instead of "through an owner device"
> you prefer a more verbose "the driver of an owner device" then
> I can live with that. Let me know.

"through" wording is convoluted and it hints that someone else is preparing=
 the command and its tunneled through the admin vq.
Which is clearly not the scope here.

How about below simple statements like below?

Group administrative commands control the member devices.
The driver sends group administrative commands to the owner device.

> > General spec structure is describing the "rules" as device and driver s=
ide
> requirements.
> > Can you please move above rule paragraph belongs to device and driver
> requirements section?
>=20
> Generally we have a bit of duplication. A high level description
> showing how things work together. Then per-device/driver conforumance
> statements. So I think this should stay but I will look at adding
> conformance clauses too.
Ok. that will be good.
Yes. General description is good without the "rule" wording so that we have=
 clear separation of conformance and description.

> > I am not sure it should be intentional and mention of Linux.
> > Any OS would need multiple error values to know the error cause.
> > Linux doesn't have name "OK" either for well-known value of 0.
> >
> > For example
> > $ errno 22
> > EINVAL 22 Invalid argument
> >
> > $ errno 0
> > This has not output for it and doesn't exist in errno.h.
>=20
> No name OK true, but it does use 0 to signal success sometimes:
Yes, but the wording is "success" and not "ok". :)

>=20
> https://man7.org/linux/man-pages/man3/errno.3.html
>=20
> For some system calls and library functions (e.g.,
>        getpriority(2)), -1 is a valid return on success.  In such cases,
>        a successful return can be distinguished from an error return by
>        setting errno to zero before the call, and then, if the call
>        returns a status that indicates that an error may have occurred,
>        checking to see if errno has a nonzero value.
>=20
>=20
>=20
> > Description is already good enough to describe what they are.
> > Can we please drop Linux wording?
>=20
> But why should we?=20
Because of following reasons.

1. If we start putting 22 with Linux annotations, in few weeks virtio Net d=
evice section will be full of annotation of ethtool, tc, ip config and more=
 for Linux developers.
For example, the current two interrupt moderation patches need to write eth=
tool options details to match to following this Linux example here.
It is better to avoid such things and keep spec OS agnostics, even though i=
t is addressing and fitting into the Linux use cases.

2. Virtio error code to Linux error code switch-case is simple routine to h=
ave.

3. Every time virtio spec to refer to errno.h for finding right value is op=
posite of what spec may want to achieve.
If an error code doesn't match to errno.h, now spec developers and reviewer=
s to review what is not defined by errno.h to find as unique value.

3.1 And if that is taken in future by errno.h for something else?

All of this is not worth a simple switch case statement to deal with.

