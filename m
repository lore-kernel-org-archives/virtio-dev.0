Return-Path: <eperezma@redhat.com>
MIME-Version: 1.0
References: <20211111185812.2326093-1-eperezma@redhat.com> <20211111185812.2326093-2-eperezma@redhat.com>
 <CACGkMEuLBC8DFu21=EvgSkixRgybvvjGtcGU80mqK+Fpoe72vQ@mail.gmail.com>
In-Reply-To: <CACGkMEuLBC8DFu21=EvgSkixRgybvvjGtcGU80mqK+Fpoe72vQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 12 Nov 2021 12:41:00 +0100
Message-ID: <CAJaqyWcNGvTjaMEPz6dQUAQLni=8q-6tN7Lmh67A20k9NcLDkw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] content: Explain better the status clearing bits
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Jason Wang <jasowang@redhat.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>, virtio-comment@lists.oasis-open.org, mst <mst@redhat.com>, Alexander Mikheev <amikheev@nvidia.com>, Stefan Hajnoczi <stefanha@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Bodong Wang <bodong@nvidia.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Nov 12, 2021 at 4:46 AM Jason Wang <jasowang@redhat.com> wrote:
>
> On Fri, Nov 12, 2021 at 2:59 AM Eugenio P=C3=A9rez <eperezma@redhat.com> =
wrote:
> >
> > The spec tells that "The driver MUST NOT clear a device status bit", bu=
t
> > a device using PCI transport reset a virtio device writing 0 to device
> > status. In some way, that is to clear all its bits.
> >
> > Instead of add an exception, tell explicitely the status bits that
> > the driver cannot clear anytime in a normal operation, so conformant
> > device and drivers keeps being conformant.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >  content.tex | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/content.tex b/content.tex
> > index 5d112af..2aa3006 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -60,9 +60,10 @@ \section{\field{Device Status} Field}\label{sec:Basi=
c Facilities of a Virtio Dev
> >  initialization sequence specified in
> >  \ref{sec:General Initialization And Device Operation / Device
> >  Initialization}.
> > -The driver MUST NOT clear a
> > -\field{device status} bit.  If the driver sets the FAILED bit,
> > -the driver MUST later reset the device before attempting to re-initial=
ize.
> > +The driver MUST NOT clear ACKNOWLEDGE, DRIVER, DRIVER_OK, FEATURES_OK =
or
> > +DEVICE_NEEDS_RESET bits of \field{device status}, except if resetting =
the whole
> > +device.
>
> Any reason for using blacklist here? I guess it is used for patch 2
> (introduce the bit that can be cleared?).
>

That's it. I should have stated better in the patch message. Thanks
for pointing it out!

> Thanks
>
> > If the driver sets the FAILED bit, the driver MUST later reset the
> > +device before attempting to re-initialize.
> >
> >  The driver SHOULD NOT rely on completion of operations of a
> >  device if DEVICE_NEEDS_RESET is set.
> > --
> > 2.27.0
> >
>

