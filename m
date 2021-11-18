Return-Path: <jasowang@redhat.com>
MIME-Version: 1.0
References: <20211111185812.2326093-1-eperezma@redhat.com> <20211111185812.2326093-3-eperezma@redhat.com>
 <CACGkMEv+42=qMDHtn8vM1jG6K2rNuKWz=CLtpJqwVJ7u7WF=ZA@mail.gmail.com>
 <CAJaqyWdWCHS9TMunT1XEaMF8_YByLo+Zfpy+DY8GBeG349HAQA@mail.gmail.com>
 <CACGkMEvagQ8SDKb+WGL96w-7=w0fj70MQ+J3fJ9USMN1f3ANTA@mail.gmail.com>
 <CAJaqyWe0=Ax5sZoY3pReuw8qJuO0hC8zMMixDFZDZp-Z7ivEBw@mail.gmail.com>
 <CACGkMEs2oVnsoyn5BUm3WKN9mxhKjpZCVfwcR5GENnxmoH7PaA@mail.gmail.com>
 <CAJaqyWcogZRutFEHu7GRxvWyr1JGNzQtuVawLMZFWR-PTJtMhg@mail.gmail.com>
 <CACGkMEuqQ0SOpkJ75Q3v6iUHRxyS2u0+VB-DvKzT=vn1Vwf=VA@mail.gmail.com> <CAJaqyWeptPr-CsMs_zBsfoo_b4AgmZ4Ao4LQ59w5k_jxPSEe1Q@mail.gmail.com>
In-Reply-To: <CAJaqyWeptPr-CsMs_zBsfoo_b4AgmZ4Ao4LQ59w5k_jxPSEe1Q@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 Nov 2021 11:27:33 +0800
Message-ID: <CACGkMEuuGvn7-DovokXi1FhUuXx-qWP31i68xWB92YvSRxk6sA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] virtio: introduce STOP status bit
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>, virtio-comment@lists.oasis-open.org, mst <mst@redhat.com>, Alexander Mikheev <amikheev@nvidia.com>, Stefan Hajnoczi <stefanha@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Bodong Wang <bodong@nvidia.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Nov 17, 2021 at 4:08 PM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Wed, Nov 17, 2021 at 4:27 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Tue, Nov 16, 2021 at 10:50 PM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Tue, Nov 16, 2021 at 7:56 AM Jason Wang <jasowang@redhat.com> wrot=
e:
> > > >
> > > > On Tue, Nov 16, 2021 at 2:17 AM Eugenio Perez Martin
> > > > <eperezma@redhat.com> wrote:
> > > > >
> > > > > On Mon, Nov 15, 2021 at 5:08 AM Jason Wang <jasowang@redhat.com> =
wrote:
> > > > > >
> > > > > > On Fri, Nov 12, 2021 at 6:51 PM Eugenio Perez Martin
> > > > > > <eperezma@redhat.com> wrote:
> > > > > > >
> > > > > > > On Fri, Nov 12, 2021 at 5:18 AM Jason Wang <jasowang@redhat.c=
om> wrote:
> > > > > > > >
> > > > > > > > On Fri, Nov 12, 2021 at 2:59 AM Eugenio P=C3=A9rez <eperezm=
a@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > From: Jason Wang <jasowang@redhat.com>
> > > > > > > > >
> > > > > > > > > This patch introduces a new status bit STOP. This can be =
used by the
> > > > > > > > > driver to stop the device in order to safely fetch used d=
escriptors
> > > > > > > > > status, making sure the device will not fetch new availab=
le ones.
> > > > > > > > >
> > > > > > > > > Its main use case is live migration, although it has othe=
r orthogonal
> > > > > > > > > use cases. It can be used to safely discard requests that=
 have not been
> > > > > > > > > used: in other words, to rewind available descriptors.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > > >
> > > > > > > > So this is much more complicated, see below.
> > > > > > > >
> > > > > > >
> > > > > > > I agree it's more complicated, but it addresses some concerns=
 raised
> > > > > > > on previous patches sent to the list. Not saying that all of =
them must
> > > > > > > be addressed, or addressed this way though :).
> > > > > > >
> > > > > > > > > ---
> > > > > > > > >  content.tex | 83 +++++++++++++++++++++++++++++++++++++++=
++++++++++++++
> > > > > > > > >  1 file changed, 83 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/content.tex b/content.tex
> > > > > > > > > index 2aa3006..9ed0d09 100644
> > > > > > > > > --- a/content.tex
> > > > > > > > > +++ b/content.tex
> > > > > > > > > @@ -47,6 +47,13 @@ \section{\field{Device Status} Field}\=
label{sec:Basic Facilities of a Virtio Dev
> > > > > > > > >  \item[DRIVER_OK (4)] Indicates that the driver is set up=
 and ready to
> > > > > > > > >    drive the device.
> > > > > > > > >
> > > > > > > > > +\item[STOP (16)] When VIRTIO_F_STOP is negotiated, indic=
ates that the
> > > > > > > > > +  device has been stopped by the driver. This status bit=
 is different
> > > > > > > > > +  from the reset since the device state is preserved.
> > > > > > > > > +
> > > > > > > > > +\item[STOP_FAILED (32)] When VIRTIO_F_STOP is negotiated=
, indicates that the
> > > > > > > > > +  device could not stop the STOP request.
> > > > > > > > > +
> > > > > > > > >  \item[DEVICE_NEEDS_RESET (64)] Indicates that the device=
 has experienced
> > > > > > > > >    an error from which it can't recover.
> > > > > > > > >  \end{description}
> > > > > > > > > @@ -74,11 +81,83 @@ \section{\field{Device Status} Field}=
\label{sec:Basic Facilities of a Virtio Dev
> > > > > > > > >  recover by issuing a reset.
> > > > > > > > >  \end{note}
> > > > > > > > >
> > > > > > > > > +If VIRTIO_F_STOP has been negotiated,
> > > > > > > >
> > > > > > > > "has not been" actually?
> > > > > > > >
> > > > > > >
> > > > > > > I think the sentence is ok. In other words, "Even when VIRTIO=
_F_STOP
> > > > > > > *has been* negotiated (in other words, driver sent FEATURES_O=
K), the
> > > > > > > driver must not set or clear the STOP bit before setting DRIV=
ER_OK".
> > > > > >
> > > > > > Ok, but what happens if we simply allow the STOP to be set if
> > > > > > DRIVER_OK is not set? It looks to me that the DRIVER_OK doesn't
> > > > > > conflict with STOP.
> > > > > >
> > > > > > (Anyhow we allow to set STOP after DRIVER_OK)
> > > > > >
> > > > >
> > > > > We could change it to "the driver MUST NOT set or clear STOP if
> > > > > FEATURES_OK is not set", which would allow the driver to start a
> > > > > device in stop mode. Before that should be definitely not done by=
 a
> > > > > good driver.
> > > >
> > > > Yes, limiting it before FEATURES_OK is a must.
> > > >
> > > > >
> > > > > But if we don't allow the resume, it makes little sense to allow =
the
> > > > > driver to start (as "set DRIVER_OK bit") in stop mode anyhow.
> > > >
> > > > Yes.
> > > >
> > > > > I would
> > > > > say that it is better to limit that now, and allow it in the futu=
re if
> > > > > we find a valid use case, enabling a specific feature flag for it=
.
> > > > >
> > > > > I'm also fine if we decide to leave this unspecified, but limitin=
g it
> > > > > now could enable us to make something useful with it in the futur=
e.
> > > >
> > > > Leaving is unspecified seems better since if we do the limitation, =
it
> > > > introduces extra efforts for future extension.  But I'm fine with
> > > > either.
> > > >
> > > > >
> > > > > > >
> > > > > > > > > the driver MUST NOT set or clear STOP if
> > > > > > > > > +DRIVER_OK is not set.
> > > > > > > > > +
> > > > > > > > > +If VIRTIO_F_STOP has been negotiated the driver MUST re-=
read the device status
> > > > > > > > > +to ensure the STOP or STOP_FAILED bit is set after the w=
rite. The device
> > > > > > > > > +acknowledges the new paused status setting the first, or=
 the failure setting
> > > > > > > > > +the last. Since this change may not be instantaneous, th=
e driver MAY wait for
> > > > > > > > > +the configuration change notification that the device mu=
st send after the
> > > > > > > > > +change.
> > > > > > > >
> > > > > > > > This is kind of tricky, it means the device can send notifi=
cation
> > > > > > > > after it has been stopped.
> > > > > > >
> > > > > > > I don't think this part it's so tricky. That notification is =
also sent
> > > > > > > when the DEVICE_NEEDS_RESET bit is set,
> > > > > >
> > > > > > I think they are different, DEVICE_NEEDS_RESET doesn't mean the=
 device
> > > > > > is stopped.
> > > > >
> > > > > To clarify, what I meant is that there are situations where this
> > > > > notification is raised even if device configuration is not change=
d,
> > > > > but its status.
> > > >
> > > > Right, but again the notification is not a must for the status chan=
ged
> > > > (e.g reset).
> > > >
> > > > >
> > > > > NEED_RESET does not mean the device is stopped, but it (should) s=
ignal
> > > > > the driver that further interaction with the device will be for s=
ure
> > > > > invalid. I may be wrong with this, but this way of notifying the
> > > > > driver relieves it to the need for check status in every interact=
ion.
> > > >
> > > > You are right. But it's still different with stop, we don't need to
> > > > check if for every interaction. What we need is to check if only af=
ter
> > > > the driver tries to stop the device (as reset).
> > > >
> > > > >
> > > > > > But what we want to achieve is to make sure there won't be
> > > > > > any interaction between device and driver after STOP is set by =
device.
> > > > > >
> > > > >
> > > > > If I understand you correctly, what you meant is that that a driv=
er
> > > > > could (and I think it will a lot of times) read the status change=
 in
> > > > > this order:
> > > > > 1) STOP bit is set
> > > > > 2) Notification change arrives
> > > > >
> > > > > And 2) is weird since the device promised no more interaction som=
ehow.
> > > > >
> > > > > I agree to some extent, but it can be read even from the opposite
> > > > > angle: From the moment the driver sets DRIVER_OK, every change on=
 the
> > > > > device (status or config) is notified using configuration change
> > > > > interrupt.
> > > >
> > > > For status, It depends on what you mean by "change". If it's the va=
lue
> > > > that read from the driver:
> > > >
> > > > 1) The only thing that needs to be notified is the status that can
> > > > only be set by device, that is NEEDS_RESET.
> > > > 2) For the status that set by the driver and device can refuse
> > > > (forever or temporarily), there's no notification change: DRIVER_OK=
,
> > > > FEATURE_OK
> > > >
> > > > STOP belongs to 2). STOP_FAILED belongs to 1), but:
> > > >
> > > > 1) STOP status bit 0 means the device is not stopped
> > > > 2) We don't have DRIVER_FAILED and FEATURE_FAILED, instead, we just
> > > > check whether or not the bit is set by the device.
> > > >
> > > > So whether or not we need STOP_FAILED is still questionable.
> > > >
> > >
> > > I don't split in "bits set by device" or "set by the driver". The way
> > > I see it, the driver send a request, and the device is going to chang=
e
> > > its status in the future. The driver can read the status reading the
> > > two bits bitfield:
> > >
> > > STOP_FAILED
> > > |STOP
> > > ||
> > > 00 - Running normally
> > > 01 - Device has stopped successfully
> > > 10 - Device could not stop, but is running normally
> >
> > I wonder what's the advantage of differing 10 from 00?
> >
>
> If the stop is not instantaneous, the driver knows when to stop
> polling, or if it has to retry.

Yes, I meant the driver knows the stop is sent from itself. So in this
case 00 after stop means 10 above.

>
> > > 11 - Cannot find this combination at this moment.
> > >
> > > > >
> > > > > a) Regarding the standard, I don't see it so different from the
> > > > > NEED_RESET: the config change keeps being an out of band notifica=
tion
> > > > > system the driver can relay to know a (expected) status change.
> > > > > b) I don't see a big deal with changing the semantic from "no mor=
e
> > > > > interaction from the device" with "no more interaction but the
> > > > > expected config change interrupt".
> > > > > c) It's easy to ignore the interrupt, or even not to treat it
> > > > > specially after the stop: The driver already should scan config t=
o
> > > > > look for changes in configuration and status, it will simply find
> > > > > none. Although this is not implemented widely as far as I see.
> > > > >
> > > > > In that regard, I feel that interaction is very innocuous, and to=
 me
> > > > > is the straightforward solution to avoid the active polling.
> > > >
> > > > Well, the driver can choose not to do busy polling for sure without
> > > > the interrupt for sure.
> > > >
> > >
> > > You mean using the transport specific method you describe in previous=
 mails?
> >
> > Yes and no, it could be:
> >
> > 1) transport specific method
> > 2) any other method that doesn't do busy polling (timer, sleep etc)
> >
>
> 2 without 1 could increase migration time,

It depends on the VMM actually. E.g the qemu's downtime is in ms, we
can sleep in sub-ms then the latency introduced could be ignored.

> and block a CPU only to
> check for the status.

It's not too bad as we do this for reset as well.

>
> > >
> > > > >
> > > > > > > and (as I read) is for the
> > > > > > > same reason somehow: To avoid the status polling:
> > > > > > > * "The driver SHOULD NOT rely on completion of operations of =
a device
> > > > > > > if DEVICE_NEEDS_RESET is set." (copied from the standard)
> > > > > > > * The reading of the status field could be expensive / inconv=
enient in
> > > > > > > each operation.
> > > > > >
> > > > > > It makes sense for the device initiated event to use interrupt.=
 But
> > > > > > for a stop, it's driver initiated, in this case the driver won'=
t start
> > > > > > the work (for example the cleanup) after it makes sure the devi=
ce is
> > > > > > stopped. Polling the status should be fine as this is how the r=
est
> > > > > > works. Anything makes stop differ from reset here? Or what worr=
ies you
> > > > > > without the interrupt?
> > > > > >
> > > > >
> > > > > This is proposed only in the scope of the concerns I saw raised i=
n
> > > > > previous series: the time to stop a device could be unbound, and
> > > > > tricks to poll less frequently will increase migration time.
> > > >
> > > > But I don't see how an interrupt can help to reduce the time spent =
on
> > > > the stop.
> > >
> > > If a host has many pass-through devices, it needs to burn CPU to ask
> > > all of them periodically. To reduce that burden, it poll less
> > > frequently. Because of that, some devices are stopped but hypervisor
> > > is not aware of that.
> > >
> > > To solve it, the device must be able to tell the hypervisor / driver
> > > when it has stopped. Of course, interrupt may not be the only way, an=
d
> > > actively polling will always be a choice.
> >
> > Yes, usually linux drivers will not do busy polling, instead it can
> > use cpu_relax() or msleep() during the polling.
> >
>
> I understand that both of them work technically, but CPU relax does
> not allow to introduce more work with that thread and msleep increases
> the migration time.

(See above reply for reset)

>
> > >
> > > > The downtime is usually a user policy, so the VMM can choose
> > > > to timeout the stop and perform the resume.
> > > >
> > >
> > > With "resume" do you mean to actually reset the device if the STOP bi=
t
> > > is not set in time? If that is a possibility then it is sure we will
> > > need to handle the inflight descriptors.
> >
> > Yes, but I wonder whether or not we can leave the inflight descriptors
> > for the future. (If it's not a must for networking). The idea is to
> > have something that can work quickly. But I'm also fine to propose it
> > now. With that I believe most of the device can be stopped in a short
> > time (we don't need to wait for the completion of inflight requests).
> >
>
> (answered below, let me know if it is not enough).
>
> > >
> > > > As discussed, the way to advertise the inflight buffers might be a
> > > > solution for this.
> > > >
> > >
> > > If these transactions are idempotent, as you say later, then yes.
> > >
> > > > >
> > > > > I will fully agree if these are left to the future: it is easy to
> > > > > implement this chunk of the proposal under a separated feature fl=
ag if
> > > > > this need arises. Sorry if that part was not clear enough.
> > > >
> > > > That's fine.
> > > >
> > > > >
> > > > > > > * Solution: Instead of polling, make a device facility to not=
ify the
> > > > > > > driver that it cannot trust the device is going to behave pro=
perly /
> > > > > > > same as before anymore via notification.
> > > > > > >
> > > > > > > We can add another exception to the "device configuration spa=
ce
> > > > > > > change" in "Notification of Device Configuration Changes", li=
ke the
> > > > > > > one already present:
> > > > > > > "In addition, this notification is triggered by the device se=
tting
> > > > > > > DEVICE_NEEDS_RESET".
> > > > > > >
> > > > > > > I understand it sounds tricky that the device sends a notific=
ation
> > > > > > > when it's stopped, but in my opinion it's aligned with previo=
us
> > > > > > > behavior (DEVICE_NEEDS_RESET),
> > > > > >
> > > > > > I think not,  e.g DEVICE_NEEDS_RESET doesn't (or it can't) mean=
 the
> > > > > > device won't process the buffer or send an interrupt.
> > > > > >
> > > > >
> > > > > From the driver point of view, it means that the driver cannot tr=
ust
> > > > > the device anymore until the reset, so the driver actions are sim=
ilar:
> > > >
> > > > I think we need clarify the exact semanic of STOP_FAILED, and it wi=
ll
> > > > be very hard to differ
> > > >
> > > > 1) The device can not be stopped in short time
> > > >
> > > > from
> > > >
> > > > 2) The device can not be stopped forever
> > > >
> > > > At least in case 1) the driver still can trust the device.
> > > >
> > >
> > > I think that from the driver POV is the same. If device cannot stop,
> > > it will continue operating normally.
> > >
> > > > >
> > > > > ""
> > > > > the driver can=E2=80=99t assume requests in flight will be comple=
ted if
> > > > > DEVICE_NEEDS_RESET is set, nor can it assume that they have not b=
een
> > > > > completed
> > > > > ""
> > > > >
> > > > > (Sorry for being circular here, I think it proceeds here too) Wha=
t I
> > > > > meant is that the device sent an out of band notification when th=
e
> > > > > device status changed. The driver could check the status field be=
fore
> > > > > processing every used buffer and also with a timer just in case, =
and
> > > > > DEVICE_NEEDS_RESET would not need the config interrupt change. Bu=
t the
> > > > > interrupt gives convenience to the whole operation.
> > > > >
> > > > > Every time the driver gets that interrupt, it must re-check all t=
he
> > > > > device configuration and status anyway. It can still make buffers
> > > > > available while processing it, but that's the meaning of the inte=
rrupt
> > > > > to me. And a status change after DRIVER_OK fits to it, from my po=
int
> > > > > of view.
> > > >
> > > > I fully agree, but it's different:
> > > >
> > > > 1) The driver don't know when there will be a NEEDS_RESET, so witho=
ut
> > > > an interrupt, it must check the status for each operation
> > > > 2) The drive know when there will be STOP/STOP_FAILED, it only need=
s
> > > > to check the status after it tries to stop the device
> > > >
> > >
> > > You know that the device will set from that point in the future, with
> > > an unbound time.
> >
> > So my point is introducing facilities to avoid the unbound time. I
> > think both of us know dealing with it is not easy.
> >
>
> Sure, that works for me.
>
> > > That could not be a problem, but there are concerns
> > > raised on previous patches about this.
> > >
> > > > >
> > > > > > > it's explicitly stated that it will be
> > > > > > > the last one, and it's caused because of the inconvenience of=
 polling
> > > > > > > device status. Even if the driver can use other mechanisms.
> > > > > >
> > > > > > I think STOP works much more similarly to reset not NEEDS_RESET=
. The
> > > > > > only difference with reset is that STOP needs to preserve the d=
evice
> > > > > > states and we don't (or can't) use interrupt to signal the comp=
letion
> > > > > > of reset.
> > > > > >
> > > > >
> > > > > From the semantic point of view, yes. But in practical terms we c=
an
> > > > > face unbounded time.
> > > >
> > > > The problem is:
> > > >
> > > > 1) how to define the "unbounded time", if we don't define it exactl=
y,
> > > > the device may abuse the status bit which may cause a lot of troubl=
es
> > >
> > > To me, the unbounded time is where the device does not guarantee that
> > > you will have the STOP status set the next time you read it. In case
> > > of an untrusted device, this may include everyone of them, for sure.
> >
> > Then the device behaviour is tied to the driver's behaviour. The
> > problem is that there's no bound time between the write and the
> > following read. There could be arbitrary time in the middle.
> >
>
> Right. In my opinion, that's why a device should be able to report
> that the stop is either in progress or failed. But *idempotent* in
> flight descriptors help for sure.

Yes.

>
> > >
> > > You care a little bit less about it if the device notifies you about
> > > the condition: You simply have the driver waiting for it, but
> > > operating normally in other regards.
> >
> > This can be achieved even without an interrupt.
> >
>
> Sure, the interrupt is just the straightforward way to do so (or the
> first that comes to my mind at least). There may be more convenient
> ways to do so.
>
> > >
> > > That notification can be a basic facility, a transport device one, or
> > > whichever other method.
> > >
> > > To mandate that the device is stopped the next time the status bit is
> > > read is another possibility for sure but if I understood correctly
> > > that would let other devices out. If vqs descriptors are idempotent,
> > > inflight_fd may be a way to get rid of that unbound time for sure.
> >
> > To be clear, inflight_fd should be part of the device area?
> >
>
> This is a little bit tricky, but I would say they should.
>
> I think this deserves another thread of its own, but it also allows
> other situations I have in my backlog to work way better. For example,
> in the case of emulated out of qemu devices (OVS, packed queue, no
> inflight_fd), it is impossible to recover the queue in case of fatal
> failure of the device. This would allow VMM to continue the connection
> with a new spawned device with no notice for guests.
>
> It would be ideal to place that chunk of memory in the VMM, but I'm
> not sure if self-contained devices would allow that.

Yes, that's somehow my point as well. From the view of inflight
reporting current virtqueue is not self-contained. So it should be
fine to introduce facilities to report them.

>
> > >
> > > > 2) there are other approaches that we can deal with the unbound tim=
e,
> > > > timeout in driver + reset
> > > >
> > > > > I mean, both operations have unbound time for
> > > > > sure, but I would say that any device should handle reset way fas=
ter
> > > > > than the STOP.
> > > >
> > > > Any reason that STOP is faster? I'd expect STOP is a subset of rese=
t,
> > > > that is, in order to do reset, we must first stop.
> > > >
> > >
> > > I'm not sure if that is the way hardware can work, but with reset the
> > > device can reclaim the needed resources for the communication in an
> > > asynchronous way, since they are not needed for the driver to ask.
> >
> > Yes and I think we can do the same for the stop.
> >
> > > With the STOP, they need to be communicated to the driver somehow in =
a
> > > virtio way.
> >
> > So I think if it's device specific, we'd better not assume which is
> > faster. Instead, as discussed, it's better to try our best to avoid
> > the unbound stop (as what we did for reset). If we fail, it's not late
> > to consider how to recover from that.
> >
>
> I'm fine with that.
>
> > >
> > > > >
> > > > > I fully agree on your point, but I can also see the other way aro=
und:
> > > > > It would be convenient to have a configuration interrupt for the =
reset
> > > > > too, but it is impossible since we cannot configure any before th=
e
> > > > > reset.
> > > >
> > > > I think it's a more about the question:
> > > >
> > > > 1) Why an interrupt is a must for STOP
> > > >
> > > > than
> > > >
> > > > 2) If we can use an interrupt
> > > >
> > > > My questions are all for 1).
> > > >
> > >
> > > It's not a must.
> > >
> > > > >
> > > > > > >
> > > > > > > If the community still has concerns about it, another option =
is to
> > > > > > > actually extract the way the device notifies it from the gene=
ral
> > > > > > > facilities, and make it transport specific. But to use the de=
vice
> > > > > > > configuration change notification for this makes sense to me.=
 The
> > > > > > > device configuration has changed.
> > > > > >
> > > > > > See above, I think we should have a consistent way to handle re=
set and stop.
> > > > > >
> > > > > > >
> > > > > > > > As discussed in the previous versions,
> > > > > > > > driver is freed to use timer or what ever other mechanism i=
f it
> > > > > > > > doesn't like the busy polling. I wonder how much value we c=
an gain
> > > > > > > > from a dedicated config interrupt. Especially consider some=
 transport
> > > > > > > > can use transport specific interrupt (not virtio specific i=
nterrupt)
> > > > > > > > for reporting whether or not set status succeed.
> > > > > > > >
> > > > > > >
> > > > > > > In my opinion, *if* we agree that a stop is a virtio facility=
 and not
> > > > > > > a per-device one, and *if* we agree that a notification is re=
quired
> > > > > > > for the device to notify the stop, it makes sense to use a
> > > > > > > transport-independent mechanism that the device must already
> > > > > > > implement.
> > > > > >
> > > > > > So the major question is why a notification is a must? And Just=
 to be
> > > > > > clear, there could be transport specific mechanisms for error
> > > > > > reporting.
> > > > > >
> > > > > > E,g
> > > > > >
> > > > > > 1) PCI can have non-posted write, if we use non-posted write to=
 carry
> > > > > > the stop command, the device can return whether or not the devi=
ce is
> > > > > > stopped successfully.
> > > > > >
> > > > > > or
> > > > > >
> > > > > > 2) Some other transport can convert the stop status bit set int=
o a
> > > > > > command and queue it to device specific queue, device can then =
use
> > > > > > it's own specific interrupt to report the when the stop is hand=
led
> > > > > > (success or fail)
> > > > > >
> > > > >
> > > > > I would be totally fine with that too.
> > > > >
> > > > > > >
> > > > > > > > >If the device sets the STOP_FAILED bit, the driver MUST cl=
ear it before
> > > > > > > > > +try new STOP attempts.
> > > > > > > >
> > > > > > > > Does the device need to re-read the STOP_FAILED for synchro=
nization?
> > > > > > >
> > > > > > > I tend to see the status as something that belongs to the dev=
ice and
> > > > > > > is exposed to the driver. In that sense, the write from the g=
uest
> > > > > > > triggers an event on the device, and the device decides what =
will be
> > > > > > > exposed on that field (MMIO?) on the next driver read. If it'=
s not
> > > > > > > that way, we couldn't use the STOP bit that way, right?
> > > > > >
> > > > > > Yes, but this is not an answer to my question. It's about the
> > > > > > ordering, when write returns it doesn't mean the write arrives =
at the
> > > > > > device, this is the case of PCI at least. So we need a mechanis=
m to
> > > > > > make sure the write arrives at the device (PCI read will flush
> > > > > > previous write).
> > > > > >
> > > > >
> > > > > I didn't see that in your original question, sorry. But the PCI r=
ead
> > > > > that flush the write is the driver one, isn't it?
> > > > >
> > > > > In that case I would say that "the read" is part of "the write". =
It's
> > > > > an issue of the PCI protocol, which I would say doesn't belong to=
 this
> > > > > section (or even this document?): To implement virtio over PCI, y=
ou
> > > > > know that virtio needs a write, and, in particular, you know that=
 PCI
> > > > > needs a posterior read to make sure that write is effective.
> > > > >
> > > > > Either that, or that the driver must use non-posted ones if it wa=
nts
> > > > > the device to note it.
> > > > >
> > > > > Or am I still missing something?
> > > >
> > > > Just to make sure we are in the same page,  in this paragraph, you
> > > > said this at the beginning:
> > > >
> > > > "If VIRTIO_F_STOP has been negotiated the driver MUST re-read the d=
evice status
> > > > to ensure the STOP or STOP_FAILED bit is set after the write."
> > > >
> > > > And in the end of the paragraph:
> > > >
> > > > If the device sets the STOP_FAILED bit, the driver MUST clear it
> > > > before try new STOP attempts. But you don't define whether we need =
to
> > > > re-read to make sure STOP_FAILED is clear if the driver tries to cl=
ear
> > > > it. Is this intended?
> > > >
> > >
> > > Not really, I assumed that the write of clearing STOP_FAILED and the
> > > write of STOP would be ordered, and that the device should have no
> > > problem clearing that status bit, since I don't see any kind of
> > > resource reclamation or anything like that there.
> >
> > Ok.
> >
> > >
> > > > >
> > > > > > >
> > > > > > > > I
> > > > > > > > wonder how much we can gain from STOP_FAILED, the patch is =
unclear on
> > > > > > > > when that the device needs to set this bit. And driver can =
choose to
> > > > > > > > reset after a specific timeout anyhow.
> > > > > > > >
> > > > > > >
> > > > > > > The conditions where the device needs to set this bit are uns=
pecified
> > > > > > > because it depends on the device: Not only to the kind of dev=
ice, but
> > > > > > > also on the device backend.
> > > > > > >
> > > > > > > The same condition (regarding the possibility of handling the=
 pending
> > > > > > > buffers) could cause different devices to react differently. =
A network
> > > > > > > device could decide it's fine to drop pending tx, let the gue=
st think
> > > > > > > that "the network lost them", and mark them as done,
> > > > > >
> > > > > > We may meet the similar issue during reset.
> > > > > >
> > > > >
> > > > > Yes, but the driver should be fine to fail a reset, it does not w=
ant
> > > > > to use the device anymore or it wants to totally override the dev=
ice
> > > > > state. If a stop fails, the driver would expect the device to con=
tinue
> > > > > operating in my opinion, because it will be impossible to recover=
 the
> > > > > device state.
> > > >
> > > > This is only true if we allow the stop to be failed. It would be an
> > > > issue if the driver fails to stop a device since it can fail the st=
op
> > > > of the entire VM which is not something that the VMM is expecting.
> > > >
> > > > If we don't allow the stop can fail and we allow the device to expo=
se
> > > > the inflight buffers, we are all fine:
> > > >
> > > > 1) VM is guaranteed to be stopped
> > > > 2) stop can be finished in time
> > > >
> > > > Devices are free to choose to wait for the short time request and t=
ag
> > > > the long time request as inflight.
> > > >
> > > > >
> > > > > This is again something that we could leave if we decide it is no=
t
> > > > > necessary at this moment: It just shows how a concern of previous
> > > > > proposals can be solved, at least technically.
> > > >
> > > > To me, I think we can start from a set of functions that can make e=
.g
> > > > the virtio-net to work to unblock:
> > > >
> > > > 1) live migration work
> > > > 2) extensions to other devices (e.g inflight could be done on top a=
s
> > > > new features)
> > > >
> > > > >
> > > > > > > where a
> > > > > > > persistent storage cannot do that for write requests. Just as=
 an
> > > > > > > example, not saying that networking devices must do that :).
> > > > > >
> > > > > > So I think this brings extra complexity that we probably don't =
need to
> > > > > > worry about now. The reason is that the spec doesn't allow the =
reset
> > > > > > to fail.
> > > > > >
> > > > >
> > > > > It can be left for the future for sure.
> > > > >
> > > > > > >
> > > > > > > > > +
> > > > > > > > > +If VIRTIO_F_STOP has been negotiated and the device has =
confirmed its stop,
> > > > > > > > > +the driver MAY change avail_idx in the case of split vir=
tqueue, but the new
> > > > > > > > > +avail_idx MUST be within used_idx and used_idx plus virt=
queue size.
> > > > > > > >
> > > > > > > > Any motivation for this? it looks to me it makes the featur=
e coupled
> > > > > > > > with the virtqueue state proposal? It seems odd to allow av=
ail change
> > > > > > > > but not the last_avail_idx change.
> > > > > > > >
> > > > > > >
> > > > > > > On second thought, I think you are right and this overlaps wi=
th the
> > > > > > > state proposal.
> > > > > > >
> > > > > > > > > +
> > > > > > > > > +If VIRTIO_F_STOP has been negotiated and the device has =
confirmed its stop,
> > > > > > > > > +the driver MAY change any descriptor.
> > > > > > > > > +
> > > > > > > > > +If VIRTIO_F_STOP has been negotiated and the device has =
confirmed its stopped,
> > > > > > > > > +the driver can resume it clearing the STOP status bit. I=
t MUST re-read the
> > > > > > > > > +device status to ensure the STOP bit is clear after the =
write. The device
> > > > > > > > > +acknowledges the new status clearing it. Since this chan=
ge may not be
> > > > > > > > > +instantaneous, the driver MAY wait for the configuration=
 change notification
> > > > > > > > > +that the device must send after the change.
> > > > > > > >
> > > > > > > > Do we really needs resuming? it's kind of:
> > > > > > > >
> > > > > > > > 1) STOP -> clear STOP
> > > > > > > >
> > > > > > > > vs
> > > > > > > >
> > > > > > > > 2) STOP -> RESET -> DRIVER_OK
> > > > > > > >
> > > > > > > > Using 2) preserve the semantic that the driver can't clear =
the status bit.
> > > > > > > >
> > > > > > >
> > > > > > > You are totally right in that regard. But the use case simpli=
fies the
> > > > > > > operation when the driver only wants to take back some availa=
ble
> > > > > > > descriptors still not used, in the range last_avail_idx..avai=
l_idx.
> > > > > > > Doing that could be a big burden for drivers, who would need =
to
> > > > > > > re-send every status. MST proposed that use case at [1].
> > > > > >
> > > > > > Yes, but it looks to me this doesn't require the resuming? And =
the per
> > > > > > virtqueue reset is being proposed here.
> > > > > >
> > > > > > https://www.mail-archive.com/virtio-dev@lists.oasis-open.org/ms=
g07818.html
> > > > > >
> > > > > > Actually, there's a subtle difference between 1) and 2). That i=
s using
> > > > > > 2) doesn't make sure we can "resume" from the index where we st=
opped.
> > > > > > But this won't be an issue considering we know that we need to =
support
> > > > > > setting device virtqueue state(index). So if we want to resume =
from
> > > > > > the exact index it could be:
> > > > > >
> > > > > > STOP -> RESET -> setting index -> DRIVER_OK
> > > > > >
> > > > >
> > > > > With the state I meant more than VQ state, but the device state i=
n
> > > > > general. For example, for the network, you must also send all the
> > > > > needed control commands to recover mac, rx filters, etc.
> > > >
> > > > I'm not sure I get this. For those cvq stuff, with the help of the
> > > > shadow virtqueue, we don't need any spec extensions. What did I mis=
s
> > > > here?
> > > >
> > >
> > > Right, that was not the example I intended to put actually. I did a
> > > lot of back and forth for the answer and I put the wrong one here,
> > > sorry :).
> > >
> > > But my concern is solved if we treat the inflight as a idempotent. Al=
l
> > > unanswered things above this are solved with that too.
> > >
> > > > >
> > > > > That's what I meant with "if you just want to rewind some descrip=
tors,
> > > > > resetting the whole device is overkill".
> > > > >
> > > > > The example may be wrong, I can think of virtiofs and the need to=
 keep
> > > > > files opened:
> > > > > * If we go through a full reset circle, the files opened may not =
be
> > > > > the same as the closed ones, like deleted files with open handles=
.
> > > > > * If we go through a full reset circle, watchers may skip a chang=
e.
> > > > >
> > > > > Of course, this complexity may be left for the future and simply =
state
> > > > > that, if that is the case, the device cannot offer stop feature.
> > > > > Virtiofs have already other complexities that makes its migration
> > > > > hard, but I think the point is explained.
> > > >
> > > > There are long discussions about the virtiofs migration. But it's o=
ut
> > > > of the scope for the discussion of device stop since it's mainly ab=
out
> > > > how to define and expose device states. For stop, it's more than
> > > > sufficient to say the device states needs to be preserved after the
> > > > device is stopped.
> > > >
> > > > I'd rather go with something simple to work for a simple type of
> > > > device like ethernet. Otherwise there will be endless discussion. F=
or
> > > > any features that are not needed by the ethernet device, I would le=
ave
> > > > it for future investigation.
> > > >
> > > > >
> > > > > > >
> > > > > > > In that regard, the straightforward thing to do is modify ava=
il_idx /
> > > > > > > descriptors from that range and let resume. However, the RESE=
T path
> > > > > > > makes it easier to implement the device part of course, and t=
he guest
> > > > > > > can also achieve the rewind that way.
> > > > > > >
> > > > > > > > > +
> > > > > > > > >  \devicenormative{\subsection}{Device Status Field}{Basic=
 Facilities of a Virtio Device / Device Status Field}
> > > > > > > > >
> > > > > > > > >  The device MUST NOT consume buffers or send any used buf=
fer
> > > > > > > > >  notifications to the driver before DRIVER_OK.
> > > > > > > > >
> > > > > > > > > +If VIRTIO_F_STOP has not been negotiated the device MUST=
 ignore the write of
> > > > > > > > > +STOP. If the DRIVER_OK status bit is not set the device =
SHOULD ignore the write
> > > > > > > > > +or clear of STOP.
> > > > > > > > > +
> > > > > > > > > +If VIRTIO_F_STOP has been negotiated, the device MUST fi=
nish any in flight
> > > > > > > > > +operations after the driver writes STOP.
> > > > > > > >
> > > > > > > > I wonder if it's better to leave this to device to decide. =
E.g some
> > > > > > > > block devices may requires a very log time to finish the in=
flight
> > > > > > > > operations.
> > > > > > > >
> > > > > > >
> > > > > > > (Letting out SVQ + inflight descriptors for this part of the =
response,
> > > > > > > I will come back to it later)
> > > > > > >
> > > > > > > But if virtqueue is not valid anymore, how can it report them=
 when
> > > > > > > finished?
> > > > > >
> > > > > > It's still valid since the STOP bit is not set by the device.
> > > > > >
> > > > >
> > > > > Then I don't understand your answer. To my proposal of:
> > > > >
> > > > > "If VIRTIO_F_STOP has been negotiated, the device MUST finish any
> > > > > in-flight operations after the driver writes STOP."
> > > > >
> > > > > You answered:
> > > > >
> > > > > "I wonder if it's better to leave this to device to decide. E.g s=
ome
> > > > > block devices may requires a very log time to finish the inflight
> > > > > operations."
> > > > >
> > > > > The device must finish all requests before it shows the STOP bit =
as
> > > > > set to the device. Maybe it is better to rephrase it like:
> > > > >
> > > > > If VIRTIO_F_STOP has been negotiated, the device MUST finish any
> > > > > in-flight operations after the driver writes STOP and before it s=
ets
> > > > > its status bit STOP as set.
> > > > >
> > > > > ?
> > > >
> > > > I meant when to set STOP is highly device specific. E.g for the vir=
tio
> > > > block devices which allows the in-flight requests to be re-submitte=
d
> > > > after resume, the device can choose to not wait for the completion =
of
> > > > the inflight operations and expose them to the driver. This helps t=
o
> > > > reduce the time spent on the stop.
> > > >
> > > > >
> > > > > > > In that sense, I would say it's better to report failure and
> > > > > > > let the guest handle it as if the disk is unavailable (timeou=
t?
> > > > > > > temporary faulty sector? I'm not sure what is the most suitab=
le way).
> > > > > >
> > > > > > This could be addressed by leaving the following choices to the=
 devices:
> > > > > >
> > > > > > 1) complete the inflight requests
> > > > > > 2) device or virtio specific for reporting inflight descriptors
> > > > > >
> > > > >
> > > > > As previously, I'm not sure how this relates with "the stop bit i=
s not
> > > > > set by the device", so my answer may be completely wrong here,
> > > >
> > > > It's related to time spent on the stop. E.g for block devices, it c=
an
> > > > simply show all the inflight buffers to guests and set the stop bit=
.
> > > > Then STOP should be very fast.
> > > >
> > > > >
> > > > > Even assuming the device can report in-flight descriptors, it nee=
ds to
> > > > > wait for the backend before reporting them anyhow.
> > > >
> > > > Why does it need to wait for the backend? I mean for the device tha=
t
> > > > supports in-flight descriptors, the semantic of the device should
> > > > allow the requests to be processed twice.
> > > >
> > >
> > > If that is true the proposal would be greatly simplified of course.
> >
> > It seems to be true for virtio-blk (at least current Qemu migrates
> > inflight requests). But it might not be true for other type of devices
> > (anyhow we can leave them for future investigation).
> >
>
> That's the issue, but if qemu already migrate them that way I think we
> should be safe.
>
> > >
> > > > > And we would need
> > > > > another indication. What is the use of separating these status?
> > > > > (waiting for stop bit, waiting for inflight descriptors to be val=
id).
> > > > >
> > > > > The only possibility I can come up with is to actually stop the
> > > > > request right in the middle of an operation. For example, to allo=
w a
> > > > > big block read to stop and then when the device is informed about
> > > > > these inflight descriptors and its progress, it can continue. I w=
ould
> > > > > say this is very out of scope, more about this later ([1]).
> > > > >
> > > > > > >
> > > > > > > *If* we are not going to allow the guest to resume operation,=
 where it
> > > > > > > knows all the status of the device, then there is no value on=
 let the
> > > > > > > device delay the operation: From the guest point of view it e=
ither
> > > > > > > succeed to send to the device backend and somebody else cause=
d a
> > > > > > > failure (external network lose the tx packet, bit rotting cau=
sed I'm
> > > > > > > reading a different value than previously written), or it fai=
led at
> > > > > > > the stop moment.
> > > > > >
> > > > > > So it's highly device specific, e.g for ethernet, we can afford=
 the
> > > > > > loss of packets but not for the block devices so reporting infl=
ight
> > > > > > descriptors may help to res-submit those after "resuming".
> > > > > >
> > > > >
> > > > > Right.
> > > > >
> > > > > > >
> > > > > > > This is different with the resume possibility, where the devi=
ce can
> > > > > > > decide to hold the descriptors, stop operating, and then resu=
me
> > > > > > > operation.
> > > > > > >
> > > > > > > > > Depending on the device, it can do it
> > > > > > > > > +in many ways as long as the driver can recover its norma=
l operation if it
> > > > > > > > > +resumes the device without the need of resetting it:
> > > > > > > > > +\begin{itemize}
> > > > > > > > > +\item Drain and wait for the completion of all pending r=
equests until a
> > > > > > > > > +convenient avail descriptor. Ignore any other posterior =
descriptor.
> > > > > > > > > +\item Return a device-specific failure for these descrip=
tors, so the driver
> > > > > > > > > +can choose to retry or to cancel them.
> > > > > > > >
> > > > > > > > If we allow the driver to retry, we need a way to report in=
flight
> > > > > > > > buffers which is not supported by the spec. A way to solve =
this is to
> > > > > > > > make it device specific.
> > > > > > > >
> > > > > > >
> > > > > > > Regarding the retry, I don't get you here. Re-reading the pat=
ch, I
> > > > > > > think that "driver retry" is very ambiguous: I meant for the =
device to
> > > > > > > mark the descriptor as used, but with a communication specifi=
c error
> > > > > > > code, so the application, guest kernel, etc (driver in the st=
andard)
> > > > > > > can decide to retry.
> > > > > >
> > > > > > That's why I think introducing the virtqueue state is a must fo=
r stop,
> > > > > > With all the indexes defined, it would be much easier to descri=
be what
> > > > > > the device or driver is expected to work.
> > > > > >
> > > > >
> > > > > I still don't see the relationship, sorry.
> > > >
> > > > E.g how do you define the in-flight buffers accurately?
> > > >
> > >
> > > If we can make them idempotent, one descriptor is in flight if it is
> > > available and the device is aware of that.
> >
> > Somehow, but it would be tricky to define 'aware' since it's device
> > specific stuffs.
> >
>
> We can define it in terms of VirtIO queues but I see it way better if
> I think from "the device point of view" about them. If you have a
> packed virtqueue, the in-flight descriptors are the available
> descriptors that the driver placed in a given position but then were
> overridden by used descriptors with a different id. In the moment they
> are used, they are not available or in-flight anymore.
>
> So the in-flight descriptors are a subset of the available ones, but
> they are not recoverable just looking at the descriptor ring and
> knowing the vq status (that includes the wrap bit and ring idx). The
> guest and the device track them in their regular working, but if the
> hypervisor needs to override the device with no notice by the guest
> (OVS case I described above), it's not possible.

Yes.

>
> The split ring is the same but the descriptor length is recoverable
> from the descriptor ring. And we cannot talk in terms of overridden
> but when used index has surpassed the avail idx of old descriptors.
>
> The only thing left to say is that for some devices they should be
> reported in the same order they were made available by the driver, to
> preserve ordering. We can skip this for net queues. And I think we
> could delegate this requirement to be per device.
>
> I agree this cannot happen in the current qemu or vhost-net, because
> they use the indexes in order, but it's not something we should rely
> on. That's why I forced these to be flushed but, as discussed, this
> should not be a problem if they are treated as idempotent.

Ok.

>
> > >
> > > > >
> > > > > What I intended to say in the patch is that the device can choose=
 to
> > > > > just return a device / communication error to indicate that the
> > > > > transaction has failed at device level, but related to virtio, th=
e
> > > > > buffer would be marked as used.
> > > > >
> > > > > Maybe a good example of this is for the device to choose to retur=
n
> > > > > VIRTIO_BLK_S_IOERR, even if the transaction is still going in the
> > > > > block backend, but I don't know a lot of the blk device so I may =
be
> > > > > wrong. I guess that the guest cannot know about the value being
> > > > > written / read with that error code, and it is forced to re-read =
that.
> > > > > But the virtqueue will be in a good state, and the device can be =
reset
> > > > > and can recover its state. It's totally up to the device to choos=
e to
> > > > > do so.
> > > >
> > > > I think not, if we tie STOP to some device errors that could be eve=
n
> > > > more complicated.
> > > >
> > >
> > > It's up to the device to implement that way but I understand your poi=
nt.
> > >
> > > > >
> > > > > Virtqueue state is still needed, but not because the device choos=
es to
> > > > > return VIRTIO_BLK_S_IOERR, but because it needs a way to recover =
the
> > > > > status after the reset.
> > > > >
> > > > > > >
> > > > > > > Regarding the in-flight descriptor report, it's interesting b=
ut I
> > > > > > > cannot see a way where it does not complicate the solution a =
lot or
> > > > > > > adds new dependencies. I have the next thoughts:
> > > > > > > 1) If it works as inflight_fd, "a region of shared memory"
> > > > > > > 1.1) This region must be in the guest's AS so the device has =
access to
> > > > > > > it. This either invalidates the use of STOP from the driver p=
oint of
> > > > > > > view as "let me know where you are not going to modify the gu=
est's
> > > > > > > memory anymore".
> > > > >
> > > > > Long shot here, but might this work with the combination of the
> > > > > balloon device? Making this far and far from the simplicity thoug=
h...
> > > > >
> > > > > > > 1.2) This region is on the hypervisor's AS. If the device sup=
ports it,
> > > > > > > it is possible to implement the SVQ without the need of STOP =
bit. This
> > > > > > > is equivalent to "I have a PF that also supports VF dirty mem=
ory
> > > > > > > tracking".
> > > > > > > 2) If it works as the config space, where the driver can ask =
for its
> > > > > > > status, STOP means "STOP writing used and report via config s=
pace". No
> > > > > > > need for reset.
> > > > > > >
> > > > > > > Did you have something different in mind?
> > > > > >
> > > > > > Not sure, maybe config space is better. What I want is to make =
the
> > > > > > feature as small as possible but leaving spaces for future exte=
nsion.
> > > > > >
> > > > > > E.g we start from the feature that is sufficient for networking
> > > > > > devices, (but doesn't prevent the future work to extend it to b=
lock
> > > > > > devices). I'm not familiar with the block device, but mandating=
 the
> > > > > > completion of inflight descriptor make have troubles, e.g unexp=
ected
> > > > > > downtime during live migration.
> > > > > >
> > > > >
> > > > > [1] I agree with that, but I feel that "device or virtio specific=
 for
> > > > > reporting inflight descriptors" is way too broad to make it usefu=
l at
> > > > > the moment.
> > > >
> > > > Yes and that's not a must for an ethernet device.
> > > >
> > >
> > > This is not really true as how this proposal is specified, if we use
> > > it in the hypervisor. Just saving the virtqueue index is not enough i=
f
> > > the device is not using the descriptors in order, since the available
> > > buffers may not be recoverable just looking at the guest memory.
> > >
> > > In that regard, we must either flush them (as this proposal do, and
> > > with the unbound time problem), or use the inflight descriptors.
> >
> > I meant for ethernet device, device can simply complet all inflight
> > buffers before the STOP. Or anything I missed here?
> >
>
> That's what the proposal mandates :). It even allows the device to
> mark as completed (used) without sending / receive them, since the
> network should be prepared for that.
>
> But its not true for other devices, and concerns have been raised previou=
sly.

Right, that's my understanding as well.

>
> > >
> > > > >
> > > > > Maybe the best thing to do is to put all the restrictions at this
> > > > > moment, and when we figure out a good format for the inflight, ad=
d
> > > > > "\item report inflight descriptors". Then, the device and the dri=
ver
> > > > > are free to not accept any combination. Does it make sense?
> > > >
> > > > Somehow, to start from a version that works for networking devices.
> > > > Where we know we don't need to care:
> > > >
> > > > 1) stop fail
> > > > 2) unbound time of stop, so we don't need an interrupt
> > > > 3) inflight buffers
> > > > 4) new facility querying device states (shadow CVQ can do this)
> > > >
> > > > This will ease both of us as I feel the discussion might not be eas=
ily
> > > > converged if we care about other types of devices with too many
> > > > things. With networking done, we can start to support block devices
> > > > and we can ask help from block gurus.
> > > >
> > >
> > > I'm fine with that except that we don't need 3.
> >
> > I still think it's not a must for ethernet device, (we don't have that
> > in all the current virtio-net backends, anything make hardware
> > different in this situation?).
> >
>
> As long as we mandate that the device flush them, is not a problem.

Just to make sure we are in the same page, what I meant is we need either:

1) mandate the "flush"

or

2) leave the device to choose "flush" or report inlfight descriptors
or using of the both

We know 1) works for net but probably not others, 2) seems can work
for most of the devices (e.g block). That's why I think 2) is better.

>
> Its convenient to have that way of reporting, since we are talking
> about general virtio queues here. I mean, net can survive it because
> it's the way the guest uses the net, but we don't allow because
> virtqueue works differently.
>
> > But I'm ok if we start to propose the inflight stuffs, that can makes
> > a complete virtqueue state. I wonder maybe it's better to use
> > device-area for those instead of transport specific way to access
> > them.
> >
>
> I'd say it's the best bet.

Yes.

>
> > >
> > > > >
> > > > > > >
> > > > > > > > > +\item Mark them as done even if they are not, if the kin=
d of device can
> > > > > > > > > +assume to lose them.
> > > > > > > >
> > > > > > > > I think "make buffer used" is better than "mark them as don=
e". And we
> > > > > > > > need a accurate definition on who is "them".
> > > > > > > >
> > > > > > >
> > > > > > > All items include other operations, like the ones that the de=
vice must
> > > > > > > do internally to process the control virtqueue. But I cannot =
find an
> > > > > > > example where telling the driver they are done when it's not =
is valid
> > > > > > > for this particular item.
> > > > > > >
> > > > > > > But I agree it needs better wording.
> > > > > > >
> > > > > > > And I will s/them/operations/. for the next one.
> > > > > > >
> > > > > > > > > +\end{itemize}
> > > > > > > > > +
> > > > > > > > > +If VIRTIO_F_STOP has been negotiated and it needs to fai=
l the device stop after
> > > > > > > > > +a guest's request,
> > > > > > > >
> > > > > > > > It's not clear what did "a guest's request" means.
> > > > > > > >
> > > > > > >
> > > > > > > Right. Would "operation" fit better here?
> > > > > >
> > > > > > Still unclear, I guess this sentence tries to define when the d=
evice
> > > > > > can fail the stop?
> > > > > >
> > > > >
> > > > > Not really, my intentions were to add a MUST operation for when t=
he
> > > > > device fails. The first is needed for the second though, so maybe=
 we
> > > > > can rephrase.
> > > > >
> > > > > If we agree that a device can fail the stop, I think we should no=
t
> > > > > restrict the circumstances where the device can fail. "If the dev=
ice
> > > > > can find external circumstances where it cannot satisfy STOP must=
 not
> > > > > offer STOP feature" works for me too, actually.
> > > >
> > > > I'd leave the STOP_FAILED for future investigation.
> > > >
> > > > >
> > > > > > >
> > > > > > > > > the device MUST set the STOP_FAILED bit for the guest to
> > > > > > > > > +read it. The device MUST ignore new writes to the STOP b=
it until the guest
> > > > > > > > > +clears STOP_FAILED.
> > > > > > > > > +
> > > > > > > > > +If VIRTIO_F_STOP has been negotiated and the guest has w=
ritten the STOP bit,
> > > > > > > > > +and the device can pause its operation, the device MUST =
set the descriptors
> > > > > > > > > +that it has done with them as used before exposing the S=
TOP status bit as set.
> > > > > > > > > +
> > > > > > > > > +If VIRTIO_F_STOP has been negotiated, the device MUST NO=
T perform these actions
> > > > > > > > > +after exposing the STOP bit set:
> > > > > > > > > +\begin{itemize}
> > > > > > > > > +\item Read updates on the descriptor or driver area, or =
consume more buffers.
> > > > > > > > > +\item Send any used buffer notifications to the driver.
> > > > > > > > > +\end{itemize}
> > > > > > > > > +
> > > > > > > > > +The device MUST send a configuration space change right =
after exposing the STOP
> > > > > > > > > +or STOP_FAILED as set to the driver, and MUST NOT change=
 configuration space or
> > > > > > > > > +send another configuration space change notification to =
the driver afterwards
> > > > > > > > > +until the guest clears it.
> > > > > > > > > +
> > > > > > > > > +If VIRTIO_F_STOP has been negotiated and STOP device sta=
tus flag is set,
> > > > > > > > > +the device MUST resume operation when the driver clears =
the STOP bit. The
> > > > > > > > > +device MUST continue reading available descriptors as if=
 an available buffer
> > > > > > > > > +notification has reach it, starting from the last descri=
ptor it marked as used,
> > > > > > > >
> > > > > > > > So I still tend to define virtqueue state as basic facility=
 before
> > > > > > > > defining STOP. It can makes thing easier.
> > > > > > > >
> > > > > > >
> > > > > > > Yes, coming back to that approach can simplify the whole prop=
osal.
> > > > > > >
> > > > > > > > > +and continue the regular operation after that. The devic=
e MUST read again
> > > > > > > > > +descriptor and driver area beyond the last descriptor it=
 marked as used when it
> > > > > > > > > +stopped, because the driver can change it. Device MUST s=
et DEVICE_NEEDS_RESET
> > > > > > > > > +if for some reason it cannot continue.
> > > > > > > > > +
> > > > > > > > >  \label{sec:Basic Facilities of a Virtio Device / Device =
Status Field / DEVICENEEDSRESET}The device SHOULD set DEVICE_NEEDS_RESET wh=
en it enters an error state
> > > > > > > > >  that a reset is needed.  If DRIVER_OK is set, after it s=
ets DEVICE_NEEDS_RESET, the device
> > > > > > > > >  MUST send a device configuration change notification to =
the driver.
> > > > > > > > > @@ -6694,6 +6773,10 @@ \chapter{Reserved Feature Bits}\la=
bel{sec:Reserved Feature Bits}
> > > > > > > > >    transport specific.
> > > > > > > > >    For more details about driver notifications over PCI s=
ee \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific I=
nitialization And Device Operation / Available Buffer Notifications}.
> > > > > > > > >
> > > > > > > > > +\item[VIRTIO_F_STOP(41)] This feature indicates that the=
 driver can
> > > > > > > > > +  stop the device.
> > > > > > > > > +  See \ref{sec:Basic Facilities of a Virtio Device / Dev=
ice Status Field}.
> > > > > > > > > +
> > > > > > > > >  \end{description}
> > > > > > > >
> > > > > > > > So I think the patch complicate thing is various ways:
> > > > > > > >
> > > > > > > > 1) STOP_FAILED status bit, which seems unnecessary or even =
duplicated
> > > > > > > > with NEEDS_RESET
> > > > > > > > 2) configuration change interrupt, looks conflict with the =
semantic of STOP
> > > > > > >
> > > > > > > I'm not sure about those two, I find we will have devices wit=
h unbound
> > > > > > > stop time where both can be useful if we agree on making this=
 a
> > > > > > > general facility.
> > > > > >
> > > > > > If the unbound stop time is the only worry, the way to report i=
nflight
> > > > > > descriptors looks like a better solution.
> > > > >
> > > > > I'm not sure if that's the only condition under which a device ca=
n
> > > > > fail to stop, but if we agree on that we could prepare a format f=
or
> > > > > block devices to report them, for example. They are needed someho=
w in
> > > > > the networking case of packed if buffers are used out of order.
> > > >
> > > > It can, but let's leave it for the future now.
> > > >
> > > > Actually, for inflight buffers, a better idea is to support it at t=
he
> > > > virtqueue level without extra data structure. But it's for sure not=
 a
> > > > short term solution.
> > > >
> > >
> > > Can you expand on this? Why do you think it is not a short term solut=
ion?
> >
> > For the inflight buffers, I guess we need add more data structure in
> > the device area. That's fine. But I wonder if we can re-design the
> > virtqueue carefully then the inflight buffers could be deduced from
> > the vring. It requires a re-design of the current vring which is not
> > easy.
> >
>
> I've never thought that, but it's hard to pursue both vring
> compactation and to *interleave* data not useful in the normal
> communication.
>
> I'd say that allocate a region and let driver (including VMM) know
> when it can trust it is the way to go. For SW device implementations
> that can abort in any moment because of a bug or whatever, they can
> use the area as if it were theirs, and keep them properly updated. For
> HW, it's enough if they populate at STOP. Memory is allocated upfront
> but there is no need to use transport bandwith to keep it updated.
>
> If we reuse that region, there is no need to make a sepparate config
> call to get or set vq state. I find the config space call more
> straightforward, but this cover way more use cases.
>
> Thoughts?

The advantage of config space is that the data is provided on demand.
E.g the vq state could be also useful for debugging (e.g via ethtool
and other tools).

If we use virtqueue, it will forces the device to update the data via
DMA or make it only available after STOP. So I think I agree, using
config and device memory is probably better.

Thanks

>
> Thanks!
>
> > Thanks
> >
> > >
> > > > >
> > > > > > And STOP_FAILED is actually
> > > > > > not accurate since it means the stop is not finished in bound t=
ime
> > > > > > (but we need to define how long should be a bound time?)
> > > > > >
> > > > > > > Resetting the whole device because of this leaves
> > > > > > > the driver with no possibility of knowing the state of the se=
nt
> > > > > > > descriptors.
> > > > > > >
> > > > > > > Of course, if these use cases are not interesting, it's easie=
r to
> > > > > > > leave them out for sure.
> > > > > > >
> > > > > > > > 3) status bit clearing (resuming), a functional duplication=
 with RESET
> > > > > > > > + DRIVER_OK
> > > > > > > >
> > > > > > >
> > > > > > > I agree it can be obtained with a whole reset, so it can be o=
ut and
> > > > > > > leave it for the future if needed. However it seems overkill =
if we
> > > > > > > just want to rewind some descriptors back, and there is no st=
andard
> > > > > > > way to recover the device status beyond vq_state.
> > > > > >
> > > > > > It's more about the minimal self-contained set of the new featu=
res. If
> > > > > > it's just rewind, device or virtqueue reset is sufficient.
> > > > >
> > > > > I'm not sure if that is true for all devices with the features th=
e
> > > > > standard offers at the moment, but it might be right for serial.
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > > > If we want
> > > > > > to obtain the state, virtqueue state is a must and with virtque=
ue
> > > > > > state, resuming (clearing STOP) is not a must.
> > > > > >
> > > > >
> > > > > Right.
> > > > >
> > > > > Thanks!
> > > > >
> > > > > > Thanks
> > > > > >
> > > > > > >
> > > > > > > Thanks!
> > > > > > >
> > > > > > > > I think we'd better to stick to the minimal set of the func=
tion to
> > > > > > > > reduce the complexity: virtqueue state + STOP bit (without =
clearing
> > > > > > > > and no config interrupt).
> > > > > > > >
> > > > > > >
> > > > > > > [1] https://lists.oasis-open.org/archives/virtio-comment/2021=
07/msg00043.html
> > > > > > >
> > > > > > > > Thanks
> > > > > > > >
> > > > > > > > >
> > > > > > > > >  \drivernormative{\section}{Reserved Feature Bits}{Reserv=
ed Feature Bits}
> > > > > > > > > --
> > > > > > > > > 2.27.0
> > > > > > > > >
> > > > > > > >
> > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> >
>

