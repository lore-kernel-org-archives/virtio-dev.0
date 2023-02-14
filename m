Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v10 03/10] admin: introduce group administration commands
Date: Tue, 14 Feb 2023 16:44:59 +0000
Message-ID: <PH0PR12MB548103071F8E12DC67020800DCA29@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230209121221.15118-1-mst@redhat.com>
 <20230209121221.15118-4-mst@redhat.com>
 <PH0PR12MB54817D14FBFDD561D8BCDF7EDCDF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230212044245-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481F96BC5CCD806210F13D9DCA29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230214014634-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230214014634-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "nrupal.jani@intel.com" <nrupal.jani@intel.com>, "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>, "hang.yuan@intel.com" <hang.yuan@intel.com>, "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>, Zhu Lingshan <lingshan.zhu@intel.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, February 14, 2023 2:47 AM
>=20
> > >
> > > Well it's clearly the driver that issues the commands. Don't see how
> > > can a device issue them. If instead of "through an owner device"
> > > you prefer a more verbose "the driver of an owner device" then I can
> > > live with that. Let me know.
> >
> > "through" wording is convoluted and it hints that someone else is prepa=
ring
> the command and its tunneled through the admin vq.
> > Which is clearly not the scope here.
>=20
> It is exactly someone else - the driver not the owner itself.
I completely lost you.
My understanding is below.
For a PCI PF device, AQ is on the PF (owner device who creates the AQ).
PF driver is issuing the AQ command and waiting for the completion to arriv=
e.
PF driver decides which AQ to use to issue the command.
This AQ is no different than net cvq, or tx/rx virtqueue.
Only difference is, it carries generic command instead of device type speci=
fic command.

In some other use case that we need to write in the cover letter, that this=
 queue may act as a transport for some SIOV or something.
Even in such scenario, command is still issued to the AQ by the owner PF dr=
iver.

What did I miss?
If none, your below description looks good to me.

> =09The driver sends group administration commands to the owner device
> of
> =09the group to control member devices of the group.
>=20
> will do the trick.
>=20
This looks good to me.

> > > > I am not sure it should be intentional and mention of Linux.
> > > > Any OS would need multiple error values to know the error cause.
> > > > Linux doesn't have name "OK" either for well-known value of 0.
> > > >
> > > > For example
> > > > $ errno 22
> > > > EINVAL 22 Invalid argument
> > > >
> > > > $ errno 0
> > > > This has not output for it and doesn't exist in errno.h.
> > >
> > > No name OK true, but it does use 0 to signal success sometimes:
> > Yes, but the wording is "success" and not "ok". :)
>=20
> Hmm. A but wordy and we have _OK elsewhere in the spec, while Linux does
> not have either OK ot SUCCESS. Just informal text.
> Will consider how to make it clearer.
>=20
> > >
> > > https://man7.org/linux/man-pages/man3/errno.3.html
> > >
> > > For some system calls and library functions (e.g.,
> > >        getpriority(2)), -1 is a valid return on success.  In such cas=
es,
> > >        a successful return can be distinguished from an error return =
by
> > >        setting errno to zero before the call, and then, if the call
> > >        returns a status that indicates that an error may have occurre=
d,
> > >        checking to see if errno has a nonzero value.
> > >
> > > > Description is already good enough to describe what they are.
> > > > Can we please drop Linux wording?
> > >
> > > But why should we?
> > Because of following reasons.
> >
> > 1. If we start putting 22 with Linux annotations, in few weeks virtio N=
et device
> section will be full of annotation of ethtool, tc, ip config and more for=
 Linux
> developers.
> > For example, the current two interrupt moderation patches need to write
> ethtool options details to match to following this Linux example here.
This cannot be relaxed if errno.h and Linux annotation must be added.
And I don't think its correct direction for the spec.

> > It is better to avoid such things and keep spec OS agnostics, even thou=
gh it is
> addressing and fitting into the Linux use cases.
> >
> > 2. Virtio error code to Linux error code switch-case is simple routine =
to have.
> >
> > 3. Every time virtio spec to refer to errno.h for finding right value i=
s opposite
> of what spec may want to achieve.
> > If an error code doesn't match to errno.h, now spec developers and revi=
ewers
> to review what is not defined by errno.h to find as unique value.
> >
> > 3.1 And if that is taken in future by errno.h for something else?
> >
> > All of this is not worth a simple switch case statement to deal with.
>=20
> I think we'll have to agree to disagree here. Years working on virt taugh=
t me
> that matching some existing interface is usually better than coming up wi=
th our
> own.=20
With all due respect to your working experience on virt, learning from exis=
ting technology, standards, and open-source software is certainly good.

However, it is a not correct to imply that virtio community will make mista=
ke if they do not copy error codes from the errno.h file for AQ.

> Even if it is a bit more work upfront it pays dividends later. Forcing so=
me
> discipline in not coming up with outlandish "EFOOBAR" codes no one driver=
 will
> end up using is a good idea too.
Copying GPLv2 errno.h is not the way to enforce that.

Community will review EFOOBAR when/if that appears.
You are implying that a new error code of AQ to be first defined in errno.h=
.
If so, for sure reference needs to refer that like IEEE, PCI spec and more.
Doesn't sound right to me.

If virtio is copying GPLv2 errno.h error codes, it must be spelled out in l=
icensing area and generic line as errno.h and not just "Linux".
I don't think this is right for virtio spec.

> And yes we can come up with crazy conventions like 0xdead for success.
> Does not mean we should.
That is exactly not the suggestion.
Suggestion is to not to copy GPLv2 definitions to virtio spec.

Avoiding crazy definition can be easily achieved by this community is doing=
 it in OS agnostic manner.

The question is: Can virtio community define error codes by learning from e=
rrno.h, netlink errors and by learning from other industry leading specs?
I think yes, community members in this email thread can do that without ann=
otating Linux in the spec.

My humble request is, let's spend more time to solidify the AQ on other asp=
ects than copying error codes.

