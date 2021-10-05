Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [virtio-dev] [PATCH] Add device reset timeout field
Date: Tue, 5 Oct 2021 08:42:16 +0000
Message-ID: <PH0PR12MB54815763EDC6ECDEEC59A844DCAF9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20210930091759.525267-1-parav@nvidia.com>
 <87y27d2bup.fsf@redhat.com>
 <PH0PR12MB548116BD0816E447A3F2CDDDDCAB9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <8735pg3im0.fsf@redhat.com>
 <PH0PR12MB5481775FB5930D9985AAB378DCAF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <87tuhw0xyn.fsf@redhat.com>
In-Reply-To: <87tuhw0xyn.fsf@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Halil Pasic <pasic@linux.ibm.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Tuesday, October 5, 2021 12:18 PM
>=20
> On Tue, Oct 05 2021, Parav Pandit <parav@nvidia.com> wrote:
>=20
> >> From: Cornelia Huck <cohuck@redhat.com>
> >> Sent: Monday, October 4, 2021 9:09 PM
> >
> >
> >> On Fri, Oct 01 2021, Parav Pandit <parav@nvidia.com> wrote:
> >>
> >> >> From: Cornelia Huck <cohuck@redhat.com>
> >> >> Sent: Friday, October 1, 2021 5:31 PM
> >> >>
> >> >> On Thu, Sep 30 2021, Parav Pandit <parav@nvidia.com> wrote:
> >> >> > +Such driver initialization sequence specified in
> >> >> > +\ref{sec:General Initialization And Device Operation / Device
> Initialization}.
> >> >>
> >> >> I'm sorry, I don't parse that statement.
> >> > It is similar statement that exists in "Driver Requirements"
> >> > section as first
> >> line.
> >> > Do you mean I should rewrite above sentence or?
> >>
> >> The sentence seems to be missing a verb?
> > Ah, right. I will add "is" and modify it as " Such driver initializatio=
n sequence is
> specified in 3.1."
>=20
> Maybe
>=20
> "Refer to the driver initialization sequence specified in..."
>=20
Device reset section already has reference to initialization sequence.
So I will skip mentioning this as part of device reset timeout explanation.

> ?
> >> >> > -210,11 +219,20 @@ \section{Device Reset}\label{sec:Basic
> >> >> > Facilities of a Virtio Device / Device Re  indicating completion
> >> >> > of the reset by reinitializing \field{device status}  to 0,
> >> >> > until the driver re-initializes the
> >> >> device.
> >> >> >
> >> >> > +A device may not be able to complete reset action when the
> >> >> > +driver initiates
> >> >> a reset operation.
> >> >> > +Such a device should provide the hint as to how long a device
> >> >> > +may take to
> >> >> finish the reset operation.
> >> >> > +This hint is provided by the device using device reset timeout
> >> >> > +field in units
> >> >> of 10 milliseconds.
> >> >>
> >> >> Is this supposed to go into the device config space? Or can each
> >> >> transport decide how to expose the value?
> >> >>
> >> > Isn't each transport define how a config space is accessible?
> >> > In this proposal for PCI it is part of the struct virtio_pci_common_=
cfg.
> >>
> >> Yes; therefore my question. Should we agree about putting it into the
> >> config space, or does it make more sense to leave the actual
> >> mechanism to the transport?
> > I think its worth to add into the config space like proposed.
> > I don't see it any different than queue_notify_data field.
>=20
> The queue_notify_data field does not seem to have been specified for anyt=
hing
> but PCI so far. In particular, CCW does not yet provide that facility, an=
d I'm not
> sure whether it should go into the config space, or use a dedicated mecha=
nism.
> It might be worth standardizing on using the config space for variables s=
uch as
> the notification data and the reset timeout, or it might make things awkw=
ard
> for some transports.
>=20
> Halil, do you have any opinion on this, especially for CCW?
>=20
> >
> >>
> >> >
> >> >  > > +
> >> >> >  \drivernormative{\subsection}{Device Reset}{Basic Facilities of
> >> >> > a Virtio Device / Device Reset}
> >> >> >
> >> >> >  The driver SHOULD consider a driver-initiated reset complete
> >> >> > when it reads \field{device status} as 0.
> >> >> >
> >> >> > +When a device reports a non-zero device reset timeout value,
> >> >> > +the driver SHOULD wait for the device to finish the reset
> >> >> > +action during the initialization sequence before giving up on th=
e
> device.
> >> >> > +When device reset timeout is not provided by the device, driver
> >> >> > +SHOULD choose a
> >> >> reasonable timeout value for reset operation to complete.
> >> >>
> >> >> Is the driver allowed to not time the reset action out at all?
> >> >>
> >> > Which is what is being done by the Linux driver today.
> >> > Not sure I follow the question.
> >> > As virtio spec follows RFC 2119, driver is recommended to time the
> >> > reset with
> >> above text description.
> >>
> >> Yes, it does make sense use a timeout; but should we note explicitly
> >> that there's no requirement for the driver to use any kind of timeout
> >> mechanism if it didn't negotiate the feature? Or drop that statement
> >> completely, and let the driver continue to do whatever it is doing rig=
ht now?
> >>
> > Letting driver doing what it is doing right now =3D wait infinitely is =
certainly not
> good.
> > We want to improve the driver stack to have determinism.
> > Hence, the proposal to improve.
>=20
> I think the driver had already been free to implement some timeout if it
> wanted to?
Sure when this feature is not supported, driver can choose its own timeout =
value.
Spec is providing the guidance to driver of what to do when this field is n=
ot present.

>=20
> >
> > Also in other thread Michael also mentioned that current code is broken=
 in
> the hotplug scenario where, device is infinitely waiting for reset to fin=
ish.
> > And this reset never finishes, because device is already on its way to =
hot
> unplug.
> > We also experienced this in the field.
>=20
> I don't question the usefulness of the timeout; my concern is that we sho=
uld not
> cause confusion whether old drivers are compliant or not.=20
Old driver will follow old spec. New driver will follow new spec.
Old driver unaware of this new spec changes cannot do anything anyways.

> If we say that the
> driver SHOULD timeout with a self-chosen value, it might read as a new
> requirement, even though the driver is not forced to implement it. No
> statement at all might be less confusing.
I think yes, it is a new requirement as part of the new spec release.
An old driver doesn't need to implement new spec recommendations.

Guidance provided in newer spec is anyway good for driver to make decision,=
 so I think we should think from forward spec perspective.

