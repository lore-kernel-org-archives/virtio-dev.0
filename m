Return-Path: <virtio-dev-return-8777-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7E36C986373
	for <virtio-dev@lists.oasis-open.org>; Tue,  5 Oct 2021 03:16:37 +0000 (UTC)
From: Parav Pandit <parav@nvidia.com>
Date: Tue, 5 Oct 2021 03:16:35 +0000
Message-ID: <PH0PR12MB5481775FB5930D9985AAB378DCAF9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20210930091759.525267-1-parav@nvidia.com>
 <87y27d2bup.fsf@redhat.com>
 <PH0PR12MB548116BD0816E447A3F2CDDDDCAB9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <8735pg3im0.fsf@redhat.com>
In-Reply-To: <8735pg3im0.fsf@redhat.com>
MIME-Version: 1.0
Subject: RE: [virtio-dev] [PATCH] Add device reset timeout field
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Monday, October 4, 2021 9:09 PM


> On Fri, Oct 01 2021, Parav Pandit <parav@nvidia.com> wrote:
>=20
> >> From: Cornelia Huck <cohuck@redhat.com>
> >> Sent: Friday, October 1, 2021 5:31 PM
> >>
> >> On Thu, Sep 30 2021, Parav Pandit <parav@nvidia.com> wrote:
> >>
> > [..]
> >
> >> > +Once the driver initiates a reset, the device may not be able to
> >> > +finish the reset immediately. Such device provides a hint to the
> >> > +driver about how long a device may take to complete the reset.
> >> > +Driver should wait at least for the time specified by the device
> >> > +to let device finish the reset or if the device status field to
> >> > +become 0 within the
> >> specified time interval.
> >>
> >> Would such a timeout also apply to the virtqueue reset that is
> >> discussed elsewhere on the virtio lists?
> >>
> > No. I haven't read that thread fully but device reset timeout is not in=
tent to
> solve all the timeouts.
> > It is intent to have the specific purpose described in this proposal.
>=20
> Ok. I guess if we want to specify some more generic timeout handling in t=
he
> future, the device is free to use the same timeout everywhere it makes se=
nse.
>
I think it is better to not overload device reset timeout for queue reset t=
imeout.
A queue in a device might recover a lot faster depending on the device type=
.
It would be incorrect to define single field that may not serve both the pu=
rpose.
So lets keep the scope of device reset timeout to device reset level.
And not mix with other IO timeout or queue timeout.
=20
> >
> >> Can transports specify what can actually time out? For example, for
> >> an asynchronous transport like ccw, it might make sense to have the
> >> timeout apply to the interrupt that is supposed to come in for the
> >> RESET command (the driver then can try to terminate the running
> >> command, if desired.)
> >>
> >> > +Such driver initialization sequence specified in \ref{sec:General
> >> > +Initialization And Device Operation / Device Initialization}.
> >>
> >> I'm sorry, I don't parse that statement.
> > It is similar statement that exists in "Driver Requirements" section as=
 first
> line.
> > Do you mean I should rewrite above sentence or?
>=20
> The sentence seems to be missing a verb?
Ah, right. I will add "is" and modify it as " Such driver initialization se=
quence is specified in 3.1."

>=20
> >
> >>
> >> > +
> >> >  \devicenormative{\subsection}{Device Status Field}{Basic
> >> > Facilities of a Virtio Device / Device Status Field}
> >> >
> >> >  The device MUST NOT consume buffers or send any used buffer @@
> >> > -210,11 +219,20 @@ \section{Device Reset}\label{sec:Basic
> >> > Facilities of a Virtio Device / Device Re  indicating completion of
> >> > the reset by reinitializing \field{device status}  to 0, until the
> >> > driver re-initializes the
> >> device.
> >> >
> >> > +A device may not be able to complete reset action when the driver
> >> > +initiates
> >> a reset operation.
> >> > +Such a device should provide the hint as to how long a device may
> >> > +take to
> >> finish the reset operation.
> >> > +This hint is provided by the device using device reset timeout
> >> > +field in units
> >> of 10 milliseconds.
> >>
> >> Is this supposed to go into the device config space? Or can each
> >> transport decide how to expose the value?
> >>
> > Isn't each transport define how a config space is accessible?
> > In this proposal for PCI it is part of the struct virtio_pci_common_cfg=
.
>=20
> Yes; therefore my question. Should we agree about putting it into the con=
fig
> space, or does it make more sense to leave the actual mechanism to the
> transport?
I think its worth to add into the config space like proposed.
I don't see it any different than queue_notify_data field.

>=20
> >
> >  > > +
> >> >  \drivernormative{\subsection}{Device Reset}{Basic Facilities of a
> >> > Virtio Device / Device Reset}
> >> >
> >> >  The driver SHOULD consider a driver-initiated reset complete when
> >> > it reads \field{device status} as 0.
> >> >
> >> > +When a device reports a non-zero device reset timeout value, the
> >> > +driver SHOULD wait for the device to finish the reset action
> >> > +during the initialization sequence before giving up on the device.
> >> > +When device reset timeout is not provided by the device, driver
> >> > +SHOULD choose a
> >> reasonable timeout value for reset operation to complete.
> >>
> >> Is the driver allowed to not time the reset action out at all?
> >>
> > Which is what is being done by the Linux driver today.
> > Not sure I follow the question.
> > As virtio spec follows RFC 2119, driver is recommended to time the rese=
t with
> above text description.
>=20
> Yes, it does make sense use a timeout; but should we note explicitly that
> there's no requirement for the driver to use any kind of timeout mechanis=
m if
> it didn't negotiate the feature? Or drop that statement completely, and l=
et the
> driver continue to do whatever it is doing right now?
>=20
Letting driver doing what it is doing right now =3D wait infinitely is cert=
ainly not good.
We want to improve the driver stack to have determinism.
Hence, the proposal to improve.

Also in other thread Michael also mentioned that current code is broken in =
the hotplug scenario where, device is infinitely waiting for reset to finis=
h.
And this reset never finishes, because device is already on its way to hot =
unplug.
We also experienced this in the field.

> >
> >> What does "giving up on the device" imply?
> > I should probably better write it as " action during the initialization=
 sequence
> before declaring the device as unable_to_reset".
>=20
> Maybe "before considering the reset operation to have failed"?
>=20
Sounds good. Will modify.

> >
> >> Can the driver perform some
> >> recovery actions (e.g for ccw, the driver may be able to terminate
> >> the running reset command and re-try)?
> >>
> > Will that retry help to recover the device? If so, what is the new oper=
ation
> that helps in recovery?
>=20
> It is about the communication mechanism, not the action; we can abort the
> communication mechanism for the command and re-try the same command
> again, if there's anything that caused the command to not be properly
> transmitted or so. The mechanism for that is probably different enough fr=
om
> the read/write operations used by pci or mmio.
>=20
> >
> >> What about a reset that is done outside of the initialization sequence=
?
> > In general reset leads to device re-initialization. Isn't it?
> > Can a virtio device be reset without initialization or re-initializatio=
n?
>=20
> I don't think we say anywhere that the driver must start to re-initialize=
 the
> device again if it did a reset. It's probably best to simply drop any ref=
erences to
> the initialization sequence; the timeout should apply to any reset initia=
ted by
> the driver, regardless of its purpose/usefulness.

The proposed spec suggest the device reset timeout handling during device r=
eset stage.
It doesn't suggest device reinitialization.
Proposed changes does refer to device initialization section, because it is=
 applicable in usual device reset flow as part of the device init sequence.
But I agree that this may not be necessary to overdo.
I will remove this reference.
Thanks.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

