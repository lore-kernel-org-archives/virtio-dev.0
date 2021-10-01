Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [virtio-dev] [PATCH] Add device reset timeout field
Date: Fri, 1 Oct 2021 12:25:11 +0000
Message-ID: <PH0PR12MB548116BD0816E447A3F2CDDDDCAB9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20210930091759.525267-1-parav@nvidia.com>
 <87y27d2bup.fsf@redhat.com>
In-Reply-To: <87y27d2bup.fsf@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Friday, October 1, 2021 5:31 PM
>=20
> On Thu, Sep 30 2021, Parav Pandit <parav@nvidia.com> wrote:
>=20
[..]

> > +Once the driver initiates a reset, the device may not be able to
> > +finish the reset immediately. Such device provides a hint to the
> > +driver about how long a device may take to complete the reset. Driver
> > +should wait at least for the time specified by the device to let
> > +device finish the reset or if the device status field to become 0 with=
in the
> specified time interval.
>=20
> Would such a timeout also apply to the virtqueue reset that is discussed
> elsewhere on the virtio lists?
>=20
No. I haven't read that thread fully but device reset timeout is not intent=
 to solve all the timeouts.
It is intent to have the specific purpose described in this proposal.

> Can transports specify what can actually time out? For example, for an
> asynchronous transport like ccw, it might make sense to have the timeout
> apply to the interrupt that is supposed to come in for the RESET command =
(the
> driver then can try to terminate the running command, if desired.)
>=20
> > +Such driver initialization sequence specified in \ref{sec:General
> > +Initialization And Device Operation / Device Initialization}.
>=20
> I'm sorry, I don't parse that statement.
It is similar statement that exists in "Driver Requirements" section as fir=
st line.
Do you mean I should rewrite above sentence or?

>=20
> > +
> >  \devicenormative{\subsection}{Device Status Field}{Basic Facilities
> > of a Virtio Device / Device Status Field}
> >
> >  The device MUST NOT consume buffers or send any used buffer @@
> > -210,11 +219,20 @@ \section{Device Reset}\label{sec:Basic Facilities
> > of a Virtio Device / Device Re  indicating completion of the reset by
> > reinitializing \field{device status}  to 0, until the driver re-initial=
izes the
> device.
> >
> > +A device may not be able to complete reset action when the driver init=
iates
> a reset operation.
> > +Such a device should provide the hint as to how long a device may take=
 to
> finish the reset operation.
> > +This hint is provided by the device using device reset timeout field i=
n units
> of 10 milliseconds.
>=20
> Is this supposed to go into the device config space? Or can each transpor=
t
> decide how to expose the value?
>
Isn't each transport define how a config space is accessible?
In this proposal for PCI it is part of the struct virtio_pci_common_cfg.

 > > +
> >  \drivernormative{\subsection}{Device Reset}{Basic Facilities of a
> > Virtio Device / Device Reset}
> >
> >  The driver SHOULD consider a driver-initiated reset complete when it
> > reads \field{device status} as 0.
> >
> > +When a device reports a non-zero device reset timeout value, the
> > +driver SHOULD wait for the device to finish the reset action during
> > +the initialization sequence before giving up on the device. When
> > +device reset timeout is not provided by the device, driver SHOULD choo=
se a
> reasonable timeout value for reset operation to complete.
>=20
> Is the driver allowed to not time the reset action out at all?
>=20
Which is what is being done by the Linux driver today.
Not sure I follow the question.
As virtio spec follows RFC 2119, driver is recommended to time the reset wi=
th above text description.

> What does "giving up on the device" imply?=20
I should probably better write it as " action during the initialization seq=
uence before declaring the device as unable_to_reset".

> Can the driver perform some
> recovery actions (e.g for ccw, the driver may be able to terminate the ru=
nning
> reset command and re-try)?
>
Will that retry help to recover the device? If so, what is the new operatio=
n that helps in recovery?
=20
> What about a reset that is done outside of the initialization sequence?
In general reset leads to device re-initialization. Isn't it?
Can a virtio device be reset without initialization or re-initialization?

>=20
> (...)
>=20
> > @@ -6673,6 +6711,11 @@ \chapter{Reserved Feature
> Bits}\label{sec:Reserved Feature Bits}
> >    transport specific.
> >    For more details about driver notifications over PCI see \ref{sec:Vi=
rtio
> Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And=
 Device
> Operation / Available Buffer Notifications}.
> >
> > +  \item[VIRTIO_F_DEV_RESET_TO(40)] This feature indicates that the
> > + device
>=20
> I think we should spell this out as VIRTIO_F_DEV_RESET_TIMEOUT=20
Ok. I will revise it in v2.

