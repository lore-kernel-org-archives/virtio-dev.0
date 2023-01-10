Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [virtio-dev] Re: [PATCH v2 00/20] Split device spec to its
 individual files
Date: Tue, 10 Jan 2023 15:26:12 +0000
Message-ID: <PH0PR12MB5481324F6E61B352850E8FB5DCFF9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230109162849.463101-1-parav@nvidia.com>
 <20230109121857-mutt-send-email-mst@kernel.org> <87358i4ow0.fsf@redhat.com>
 <PH0PR12MB548116EBA8343DA37A8F345DDCFF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <87zgaq2z6e.fsf@redhat.com>
In-Reply-To: <87zgaq2z6e.fsf@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Tuesday, January 10, 2023 10:21 AM
>=20
> On Tue, Jan 10 2023, Parav Pandit <parav@nvidia.com> wrote:
>=20
> >> From: virtio-dev@lists.oasis-open.org
> >> <virtio-dev@lists.oasis-open.org> On Behalf Of Cornelia Huck
> >>
> >> On Mon, Jan 09 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> > Does makediff still work? Documentation says latexpand does not
> >> > support import. without latexdiff generating redlined versions
> >> > would be very difficult.
> >> >
> >> >
> >> > I am also worried about consistency since we already use \\input.
> >> > If using \\input means putting everything in a single directory,
> >> > that's a small price to pay:
> >> >
> >> > virtio-sound.tex + virtio-sound-conformance.tex
> >> >
> >> > is not fundamentally worse than
> >> > device-types/virtio-sound/device.tex
> >> > and device-types/virtio-sound/device-conformance.tex
> >> >
> >> > and it avoids the duplicated "device" in the name.
> >> >
> >> > Previously it looked like a cosmetic issue, but now it looks like
> >> > it's important.
> >>
> >> I agree, and we need to decide quickly what to do with the ballot. We
> >> don't want to merge v1, but the current votes still have a majority
> >> of 'yes'. My preference would be to withdraw the ballot, which needs
> >> to be done before
> >> 22:00 UTC today, if I'm not confused.
> >>
> >> Parav, what do you think? If you request to withdraw the ballot,
> >> that's easy to do; we'll just open a new one once we've agreed on a ve=
rsion.
> >
> > I am revising the v2 and should be available in 7 pm UTC time.
> > This will include,
> > a. white space removal at end of the net and blk files b. fix missing
> > device conformance links for 4 devices c. import to input d. continue
> > with directories e. rename device-types/<name>/device.tex to
> > device-types/<name>/description.tex
>=20
> Apologies if I sound like a process stickler, but the main problem is tha=
t the
> ballot is currently about v1 of the patches (and we obviously can't chang=
e that
> while it is open, as that would invalidate the votes that already have be=
en cast.)
If it auto invalidates, is there any withdrawal process needed?
If no, lets withdraw an re-vote on v3.

> If your v3 looks good, we need a new ballot to vote on that. As it stands=
 now,
> the TC would have voted to include v1 with its known problems... that's w=
hy I
> think a withdrawal would be best.

We will use the same github issue for v3, and new ballot yes?

