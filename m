Return-Path: <virtio-comment-return-2609-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Fri, 21 Jan 2022 04:17:52 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Message-ID: <20220121041752.7619cd85.pasic@linux.ibm.com>
In-Reply-To: <20220119112059-mutt-send-email-mst@kernel.org>
References: <20220114225032.290762-1-mst@redhat.com>
	<20220119132319.5ee3821d.pasic@linux.ibm.com>
	<20220119112059-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [virtio] [PATCH] virtio: clarify feature negotiation
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, virtio@lists.oasis-open.org, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 19 Jan 2022 11:34:35 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Jan 19, 2022 at 01:23:19PM +0100, Halil Pasic wrote:
> > On Fri, 14 Jan 2022 17:50:51 -0500
> > "Michael S. Tsirkin" <mst@redhat.com> wrote: =20
> > > Subject: virtio: clarify feature negotiation =20
> >=20
> > This is in my opinion more of an incompatible change that a
> > clarification, but since the commit message does not constitute a part
> > of the standard, it does not matter that much.
> > [..]
> >  =20
> > > @@ -298,10 +298,10 @@ \section{Device Configuration Space}\label{sec:=
Basic Facilities of a Virtio Devi
> > >  \end{note}
> > > =20
> > >  \devicenormative{\subsection}{Device Configuration Space}{Basic Faci=
lities of a Virtio Device / Device Configuration Space}
> > > -The device MUST allow reading of any device-specific configuration
> > > +The device SHOULD allow reading of any device-specific configuration
> > >  field before FEATURES_OK is set by the driver.  This includes fields=
 which are
> > > -conditional on feature bits, as long as those feature bits are offer=
ed
> > > -by the device.
> > > +conditional on feature bits, as long as those feature bits have
> > > +been acknowledged by the driver. =20
> >=20
> > "Those feature bits have been acknowledged by the driver" is new
> > terminology. IMHO we should have a precise definition
> > of "feature bit is acknowledged".
> >=20
> > Currently "acknowledge features" means "write features".
> >=20
> >  =20
> > > =20
> > >  \subsection{Legacy Interface: A Note on Device Configuration Space e=
ndian-ness}\label{sec:Basic Facilities of a Virtio Device / Device Configur=
ation Space / Legacy Interface: A Note on Configuration Space endian-ness}
> > > =20
> > > @@ -500,8 +500,13 @@ \section{Device Initialization}\label{sec:Genera=
l Initialization And Device Oper
> > > =20
> > >  \item\label{itm:General Initialization And Device Operation /
> > >  Device Initialization / Read feature bits} Read device feature bits,=
 and write the subset of feature bits
> > > -   understood by the OS and driver to the device.  During this step =
the
> > > -   driver MAY read (but MUST NOT write) the device-specific configur=
ation fields to check that it can support the device before accepting it.
> > > +   understood by the OS and driver to the device.  During this
> > > +   step, after writing the subset of feature bits to the device the
> > > +   driver MAY read (but MUST NOT write) the device-specific
> > > +   configuration fields to validate that it can support the device
> > > +   before accepting it. The driver MAY then repeatedly modify the
> > > +   subset as appropriate, write the new subset and repeat the
> > > +   validation, any number of times. =20
> >=20
> > IMHO don't have an exact definition of what "MAY read device-specific
> > configuration field means". To me, "may read" does not automatically
> > imply that what was read can be interpreted, is valid and meaningful. =
=20
>=20
> Let's say "MAY read (and use)" - is that clear enough?

I would prefer "MAY read, and the value read  is valid".

>=20
> > For example there was no harm in reading MTU without having the
> > F_VERSION_1 feature acknowledged before. We did not end up in undefined
> > behavior land, the read_config operation did not blow up in our face,
> > and the field was also "there" if the corresponding feature was offered=
.
> > The only trouble was that one could not interpret the value of the fiel=
d,
> > because one could not tell is it big or little endian.
> >=20
> > IMHO, we want to accomplish, readable, interpretible, valid and
> > meaningful, before the feature has been negotiated by setting
> > FEATURES_OK.
> >=20
> > I see a couple of potential problems with this:
> > 1) The set of acknowledged features may be invalid! For example may end
> > up with feature B acknowledged and feature B not acknowledged, when
> > B depends on A. Before "acknowledge" we used to be safe, because the
> > device would reject FEATURES_OK. =20
>=20
> right. but for reading config fields it's probably enough in practice.
>=20

In practice yes. But we can do better, e.g. if we mandate that all
features need to be written before early config space access. And
that is actually what your Linux patch does anyway.

> > 2) In theory, we could have union-type conditional fields. To demonstra=
te
> > what I mean here is a stupid example:
> > struct ThermometherConfig {
> > union {
> > u16 temp_in_kelvin;
> > u16 temp_in_celsius;
> > u16 temp_in_farenheit;
> > } temp;
> > };
> > where kelvin is the default, but you can get Celsius or Fahrenheit
> > depending on mutex feature bits.
> > This also used to be and still is safe after the features have been
> > negotiated, but with "acknowledged" there is trouble when both the
> > features are set. =20
>=20
> something to worry about in the future but are there cases like
> this in present? should we worry?

I will have to rescann the spec. In practice, it ain't a huge issue,
if we mandate that "right before FEATURES_OK", because that way
we would only have a problem in the cases where we would have had
a problem if we did set  FEATURES_OK.

If we want to go down this route, it probably wouldn't hurt to watch
out for unions in config space, when the spec is extended.


>=20
> > 3) Features are written in 32 bit chunks. My guess is that what we
> > want for "features acknowledged is": driver has written each chunk it
> > knows about at least once. Of course, the question arises, what should
> > the device do if config is read before that happens. =20
>=20
> we are lucky that at present it's just mtu of the net device :).
>=20

Yes, I was trying to showcase the properties of the interface.

>=20
> > 4) It is pretty obvious to me, that after "features have been
> > acknowledged", we want the driver to read the very same config as
> > if we were in "features have been negotiated" state. The only  differen=
ce
> > we want is, that the features must not be "frozen", i.e. the driver
> > should still be able to modify the features. =20
>=20
> I can add that, ok.

I think that would also help with several of these, admittedly rather
theoretical issues. My approach to this was really to take a step back,
and examine the interface. I like nicely designed interfaces. :D


>=20
> > 5) It ain't clear to me when is the driver supposed to assume that
> > "the features have been acknowledged". I.e. that the expected changes
> > have taken effect. For PCI, as far as I remember, they have this write =
it
> > and then read it back drill to force side-effects. Would we have to do
> > something like this. I think for FEATURES_OK we have that stuff clearly
> > specified. =20
>=20
> Hmm good point.  normally reads do not bypass writes, so you can write
> features and then read config, should work.  only exception is when they
> are different types e.g.  in theory features could be in IO and config
> in memory.  however I think reads from different types of memory can be
> reordered anyway, so that config isn't really legal.  I'll poke at the
> pci spec some more to refresh my memory on this.=20

Thx!

>=20
> > I don't know if that would be viable, but introducing a FEATURES_ACK
> > status bit would IMHO resolve a bunch of these potential problems, and
> > would also serve as a clear trigger for stuff like vhost (to flush
> > features) =20
>=20
> Right. With this proposal I think basically a config read
> flushes features. Which isn't too bad ...

No it is not, but we would have to implement it. And we would have
to ether do dirty tracking, or flush on each config read if we aren't
FEATURES_OK yet. And we would also require an awareness of config reads
in the part that does the features, if the config space is handled in
a different part. In practice, it is probably a non-issue. But I wanted
to mention it.

>=20
> > The only problem, that would remain is that IMHO this is still
> > fundamentally a change that effectively breaks compatibility. IMHO
> > "features acknowledged" is essentially a new feature, which enables
> > a sane use of the config space before FEATURES_OK. But we can't guard i=
t
> > with a feature bit, because the snake would just bite its tail. I'm
> > fine with going down this route. It is just that I would like to be
> > completely transparent about this. =20
>=20
> well kind of. But I think the nice thing about it and the reason
> I structured it this way and not as a complete new status bit
> is that it really matches pretty well what the existing
> body of code does, e.g. we don't need any qemu changes at all,

Wouldn't we need to change QEMU to flush features to vhost backends?

Would we want to make QEMU tolerate drivers that do not play by the
new rules. I'm asking about that RFC of mine which does the transport
specific detection of legacy/modern?

> and most linux and windows drivers except for network with
> the MTU thing are also good to go.

Yes, going with a new satus bit would use up a status bit, and=20
result in more code, at least on the Linux side of things. On the
other hand, the new status bit approach would result in a cleaner
and easier to understand interface.

I think, one key point we have to clarify is: did we really have
this acknowledged but not yet negotiated state in pre-1.0 virtio. If we
did, then it is much more plausible to say, that doing it like this
is a clarification, and doing it with a new status bit would be a new
feature of virtio.

On this question please see my other email:
https://www.mail-archive.com/virtio-dev@lists.oasis-open.org/msg08187.html


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

